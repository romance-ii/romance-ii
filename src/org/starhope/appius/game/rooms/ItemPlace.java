/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public
 * License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.game.rooms;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.util.WeakRecord;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ItemPlace extends PointPlace {
	
	/**
	 * Creates a string formatted to be used as a room var to create an item place
	 *
	 * @param loc WRITEME 
	 * @param group WRITEME 
	 * @param realItemID WRITEME 
	 * @param facing WRITEME 
	 * @return WRITEME 
	 */
	public static String createRoomVar (final Coord2D loc, final int realItemID, final String facing) {
		return "{\"loc\":[" + loc.getX () + "," + loc.getY () + "],\"type\":\"item\",\"realID\":\"" + realItemID
				+ "\",\"facing\":\"" + facing + "\"}";
	}

	/**
	 * Item's facing, if there is one
	 */
	final String facing;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final WeakRecord <RealItem> item;

	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 *
	 * @param name WRITEME 
	 * @param jsonObject WRITEME 
	 * @param room WRITEME 
	 * @throws JSONException
	 */
	public ItemPlace (final String name, final JSONObject jsonObject, final Room room) throws JSONException {
		super (name, jsonObject, room);

		facing = getRoomVar ().has ("facing") ? getRoomVar ().getString ("facing") : null;
		item =
				getRoomVar ().has ("realID") ? new WeakRecord <RealItem> (RealItem.class, getRoomVar ().getInt (
						"realID")) : null;
		forBroadcast = true;
	}

	/**
	 * Returns the facing of the object or null if there isn't one
	 *
	 * @return WRITEME 
	 */
	public String getFacing () {
		return facing;
	}

	/**
	 * Gets the item or null if there isn't one
	 *
	 * @return WRITEME 
	 */
	public RealItem getItem () {
		return item != null ? item.get () : null;
	}
}
