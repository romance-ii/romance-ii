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

import java.awt.geom.Path2D;

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
 */
abstract class ZonePlace extends AbstractPlace {

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final Path2D.Double areaPath;

	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 *
	 * @param name WRITEME 
	 * @param json WRITEME 
	 * @param room WRITEME 
	 * @throws JSONException
	 */
	public ZonePlace (final String name, final JSONObject json, final Room room) throws JSONException {
		super (name, json, room);

		final JSONArray areaArray = getRoomVar ().getJSONArray ("area");
		areaPath = new Path2D.Double ();

		if (areaArray.length () > 2) {
			for (int i = 0; i < areaArray.length (); i++ ) {
				final JSONArray coordPair = areaArray.getJSONArray (i);
				if (coordPair.length () == 2) {
					if (i == 0) {
						areaPath.moveTo (coordPair.getDouble (0), coordPair.getDouble (1));
					} else {
						areaPath.lineTo (coordPair.getDouble (0), coordPair.getDouble (1));
					}
				} else {
					throw new JSONException ("Bad coordinate pair in area for " + getName ());
				}
			}
		}
	}

	/**
	 * Determines if the given coordinate is in the space for this zone
	 *
	 * @param point 2D coordinates to check against
	 * @return WRITEME 
	 */
	public boolean inArea (final Coord2D point) {
		return inArea (point.getX (), point.getY ());
	}

	/**
	 * Determines if the given coordinate is in the space for this zone
	 *
	 * @param x WRITEME 
	 * @param y WRITEME 
	 * @return WRITEME 
	 */
	public boolean inArea (final double x, final double y) {
		return areaPath.contains (x, y);
	}
}
