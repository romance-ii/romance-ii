/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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
package org.starhope.appius.user.events;

import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 */
public class QuaestorRunner extends Thread implements
		Comparable <Thread> {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final Queue <ActionHandlerInterface> f = new ConcurrentLinkedQueue <ActionHandlerInterface> ();
	/**
	 * action to be dispatched
	 */
	private final Action a;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param action WRITEME
	 */
	public QuaestorRunner (final Action action) {
		super ();
		setName ("QuaestorRunner/" + action.toString () + "/#"
				+ getId ());
		a = action;
	}

	/**
	 * @param handler a new handler for this action to run against
	 */
	public void add (final ActionHandlerInterface handler) {
		f.add (handler);
	}

	/**
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final Thread o) {
		return getName ().compareTo (o.getName ());
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (obj instanceof QuaestorRunner) {
			return compareTo ((Thread) obj) == 0;
		}
		return false;
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getName ());
	}

	/**
	 * @see java.lang.Thread#run()
	 */
	@Override
	public void run () {
		for ( final ActionHandlerInterface h : f ) {
			h.invoke (a);
		}
		AppiusClaudiusCaecus.getCharon ().addZombie (this);
	}

	/**
	 * @return number of methods awaiting execution
	 */
	public int size () {
		return f.size ();
	}

}
