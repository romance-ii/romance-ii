/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at
 * your option) any later version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.services;

import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.ConcurrentSkipListSet;

import org.starhope.appius.except.ParameterException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.user.GeneralUser;
import org.starhope.util.LibMisc;
import org.starhope.util.types.CommandExecutorThread;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 */
public class Clodia extends Thread implements Comparable <Thread> {
	/**
	 * The user whose lists are being loaded
	 */
	final protected GeneralUser myUser;

	/**
	 * When to give up on loading more
	 */
	private boolean giveUp = false;

	/**
	 * Parent thread; if it stops, we stop.
	 */
	private final Thread myParent;

	/**
	 * The set of user ID:s
	 */
	private static Collection <Integer> userIDs = new ConcurrentSkipListSet <Integer> ();

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param who WRITEME
	 * @param parentThread parent thread
	 */
	public Clodia (final GeneralUser who, final Thread parentThread) {
		myUser = who;
		myParent = parentThread;
		setName ("Clodia:" + who.getAvatarLabel ());
	}

	/**
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final Thread arg0) {
		return arg0.getName ().compareTo (getName ());
	}

	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if ( ! (obj instanceof Clodia)) {
			return false;
		}
		return 0 == compareTo ((Clodia) obj);
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getName ());
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public void quit () {
		giveUp = true;
	}

	/**
	 * @return true, when we can stop
	 */
	public boolean readyToGiveUp () {
		if (myParent instanceof CommandExecutorThread) {
			if ( ! ((CommandExecutorThread) myParent)
					.shouldKeepRunning ()) {
				return true;
			}
		}
		return giveUp;
	}

	/**
	 * @see java.lang.Thread#run()
	 */
	@Override
	public void run () {
		if (Clodia.userIDs.contains (Integer.valueOf (myUser
				.getUserID ()))) {
			return;
		}
		Clodia.userIDs.add (Integer.valueOf (myUser.getUserID ()));
		for (String whichList : new String [] { "$buddy", "$ignore" }) {
			List <String> users = new LinkedList <String> ();
			{
				try {
					Iterator <String> i = myUser
							.getUserListIterator (whichList);
					while (i.hasNext () && !readyToGiveUp ()) {
						users.add (i.next ());
						if (users.size () >= 20) {
							sendList (whichList, users);
							users.clear ();
						}
					}
					if (users.size () > 0)
						sendList (whichList, users);
				} catch (ParameterException e) {
					BugReporter.getReporter ("srv").reportBug (e);
				}
			}
		}

		AppiusClaudiusCaecus.getCharon ().addZombie (this);
		Clodia.userIDs.remove (Integer.valueOf (myUser.getUserID ()));
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param whichList the list name
	 * @param users users on that list
	 */
	public void sendList (final String whichList,
			final List <String> users) {
        myUser.sendBuddyList (whichList, users);
		try {
			Thread.sleep (25);
		} catch (InterruptedException e) {
			// no op
		}
		Thread.yield ();
	}
}
