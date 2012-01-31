/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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
package org.starhope.appius.except;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class AlreadyLoadedException extends Exception {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 6056918068724660283L;
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 5,
	 * 2009) newID (AlreadyLoadedException)
	 */
	private final long newID;
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 5,
	 * 2009) oldID (AlreadyLoadedException)
	 */
	private final long oldID;
	
	/**
	 * @param oldID1 the ID that was instantiated
	 * @param newID1 the ID which the user just requested
	 */
	public AlreadyLoadedException (final long oldID1, final long newID1) {
		oldID = oldID1;
		newID = newID1;
	}
	
	/**
	 * @see java.lang.Throwable#toString()
	 */
	@Override
	public String toString () {
		return "#" + oldID + " ( => #" + newID + ")"
				+ super.toString ();
	}
}
