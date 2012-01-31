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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.game.rooms;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.geometry.Coord2D;

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
 *
 */
public class PointPlace extends AbstractPlace {

	/**
	 * Location for this point
	 */
	final Coord2D location;

	/**
	 * Group for this point
	 */
	final String group;

	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 *
	 * @param name WRITEME 
	 * @param jsonObject WRITEME 
	 * @param room WRITEME 
	 * @throws JSONException
	 */
	public PointPlace (final String name, final JSONObject jsonObject, final Room room) throws JSONException {
		super (name, jsonObject, room);

		final JSONArray locArray = getRoomVar ().getJSONArray ("loc");
		if (locArray.length () >= 2) {
			location = new Coord2D (locArray.getDouble (0), locArray.getDouble (1));
		} else {
			location = new Coord2D (Double.MIN_VALUE, Double.MIN_VALUE);
		}
		group = getRoomVar ().optString ("group", null);
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @return WRITEME 
	 */
	public String getGroup () {
		return group;
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @return WRITEME 
	 */
	public Coord2D getLocation () {
		return location;
	}
}
