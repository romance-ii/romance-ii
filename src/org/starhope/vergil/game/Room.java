/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.vergil.game;

import java.util.HashSet;
import java.util.Set;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Room {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static Set <Room> roomList = new HashSet <Room> ();
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param i WRITEME
	 * @return WRITEME
	 */
	public static Room getByID (final int i) {
		for (final Room r : Room.roomList) {
			if (r.getID () == i) {
				return r;
			}
		}
		return null;
	}
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final int id;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final String moniker;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param newID WRITEME
	 * @param newMoniker WRITEME
	 */
	public Room (final int newID, final String newMoniker) {
		id = newID;
		moniker = newMoniker;
		Room.roomList.add (this);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public int getID () {
		return id;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public String getMoniker () {
		return moniker;
	}
	
}
