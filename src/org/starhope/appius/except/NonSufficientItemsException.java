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
 * Affero General Public License for more details.
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.except;

/**
 * <p>
 * This exception may be thrown for a purchase attempt by a player who
 * does not have enough (in-game) currency to afford the item being
 * purchased.
 * </p>
 * <p>
 * This has nothing to do with actual real-world money.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class NonSufficientItemsException extends Exception {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -6462517287925538687L;
	
	/**
	 * Item that's lacking
	 */
	private final int itemID;
	/**
	 * Number of items the user has
	 */
	private final int userHas;
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final int wants;
	
	/**
	 * @param item The item ID
	 * @param want How many are wanted
	 * @param has How many the user has
	 */
	public NonSufficientItemsException (final int item,
			final int want, final int has) {
		itemID = item;
		wants = want;
		userHas = has;
	}
	
	/**
	 * @see java.lang.Throwable#toString()
	 */
	@Override
	public String toString () {
		return "Non-sufficient items exception for item " + itemID
				+ ")\n(user has " + userHas + " and needs + "
				+ wants + ")" + super.toString ();
	}
}
