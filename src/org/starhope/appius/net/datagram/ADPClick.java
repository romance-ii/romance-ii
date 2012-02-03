/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
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
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author ewinkelman
 */
package org.starhope.appius.net.datagram;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.ChannelListener;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman
 *
 */
public class ADPClick extends ADPJSON {

	/**
	 * X click location
	 */
	private double x;

	/**
	 * Y click location
	 */
	private double y;

	/**
	 * Click target
	 */
	private String target;

	/**
	 * Click modifiers
	 */
	private String with;

	/**
	 * Creates an empty datagram
	 *
	 * @param s WRITEME ewinkelman
	 */
	public ADPClick (final ChannelListener s) {
		super ("click", s);
	}

	/**
	 * Creates a datagram based on the JSON packet
	 *
	 * @param jso WRITEME ewinkelman
	 * @param listener WRITEME ewinkelman
	 * @throws JSONException WRITEME ewinkelman
	 */
	public ADPClick (final JSONObject jso, final ChannelListener listener)
			throws JSONException {
		super (jso, listener);
		if ( !getCommand ().equals ("click")) {
			throw new JSONException ("Incorrect c/from parameter");
		}
		if (jso.has ("x")) {
			x = jso.optDouble ("x");
		}
		if (jso.has ("y")) {
			y = jso.optDouble ("y");
		}
		if (jso.has ("with")) {
			with = jso.optString ("with");
		}
		if (jso.has ("on")) {
			target = jso.optString ("on");
		}
	}

	/**
	 * Gets the target of the click event
	 * 
	 * @return The string identifier of the object upon which the user
	 *         clicked (if any). Can be null.
	 */
	public String getOn () {
		return target;
	}

	/**
	 * Gets click modifiers
	 *
	 * @return WRITEME ewinkelman
	 */
	public String getWith () {
		return with;
	}

	/**
	 * Gets the x coordinate of the click event
	 *
	 * @return WRITEME ewinkelman
	 */
	public double getX () {
		return x;
	}

	/**
	 * Gets the y coordinate of the click event
	 *
	 * @return WRITEME ewinkelman
	 */
	public double getY () {
		return y;
	}

	/**
	 * Sets the target of the click event
	 *
	 * @param target WRITEME ewinkelman
	 */
	public void setOn (final String target) {
		this.target = target;
		setJSON ("on", target);
	}

	/**
	 * Sets click modifiers
	 *
	 * @param with WRITEME ewinkelman
	 */
	public void setWith (final String with) {
		this.with = with;
		setJSON ("with", with);
	}

	/**
	 * Sets the x coordinate of the click event
	 *
	 * @param x WRITEME ewinkelman
	 */
	public void setX (final double x) {
		this.x = x;
		setJSON ("x", Double.valueOf (x));
	}

	/**
	 * Sets the y coordinate of the click event
	 *
	 * @param y WRITEME ewinkelman
	 */
	public void setY (final double y) {
		this.y = y;
		setJSON ("y", Double.valueOf (y));
	}

}
