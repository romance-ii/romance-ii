/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game.powers;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 *
 */
@Deprecated
public interface PowerItemInfo {

	/**
	 * Gets an attribute from the real item this power is based on
	 *
	 * @param string WRITEME ewinkelman@resinteractive.com
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	String getAttribute (String string);

	/**
	 * Gets the base item ID
	 *
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	int getItemID ();

	/**
	 * Gets the real/instance ID of the item
	 *
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	int getRealItemID();

	/**
	 * Determines if the real item has this attribute
	 *
	 * @param string WRITEME ewinkelman@resinteractive.com
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	boolean hasAttribute(String string);

}
