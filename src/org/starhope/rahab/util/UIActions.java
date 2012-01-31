/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Timothy W. Heys
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public
 * License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 */
package org.starhope.rahab.util;

import org.starhope.rahab.Rahab;

/**
 * WRITEME: Document this type. twheys@gmail.com Feb 3, 2010
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys Timothy W. Heys
 */
public final class UIActions {
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 * 
	 * TO displayShiftJournal WRITEME...
	 */
	public static void displayShiftJournal () {
		Rahab.createAndShowShiftJournal ();
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 * 
	 * TO close WRITEME...
	 */
	public static void exit () {
		Rahab.killSessionStatically (true);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 * 
	 * TO loginNewUser WRITEME...
	 */
	public static void loginNewUser () {
		Rahab.loginNewUser ();
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 * 
	 * TO reloadSpyUserAndRoomLists WRITEME...
	 */
	public static void reloadSpyUserAndRoomLists () {
		Rahab.reloadUserAndRoomLists ();
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 * 
	 * TO reloadZoneList WRITEME...
	 */
	public static void reloadZoneList () {
		Rahab.retrieveZoneListStatically ();
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 8, 2010
	 * </pre>
	 * 
	 * TO setAutoScroll WRITEME...
	 * 
	 * @param selected WRITEME
	 */
	public static void setAutoScroll (final boolean selected) {
		Rahab.setAutoScrollsStatically (selected);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Mar 3, 2010
	 * </pre>
	 * 
	 * TO setEchoJoins WRITEME...
	 * 
	 * @param selected WRITEME
	 */
	public static void setEchoJoins (final boolean selected) {
		Rahab.setEchoJoinsStatically (selected);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 * 
	 * TO showOpCommandsHelp WRITEME...
	 */
	public static void showOpCommandsHelp () {
		javax.swing.SwingUtilities.invokeLater (new Runnable () {
			@Override
			public void run () {
				Rahab.openResource ("opcommands.txt");
			}
		});
	}
}
