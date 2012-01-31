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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.net.datagram;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.ChannelListener;

/**
 * WRITEME: Document this type.
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ADPClick extends ADPJSON {
	
	/**
	 * Click target
	 */
	private String target;
	
	/**
	 * Click modifiers
	 */
	private String with;
	
	/**
	 * X click location
	 */
	private double x;
	
	/**
	 * Y click location
	 */
	private double y;
	
	/**
	 * Creates an empty datagram
	 * 
	 * @param s WRITEME ewinkelman@resinteractive.com
	 */
	public ADPClick (final ChannelListener s) {
		super ("click", s);
	}
	
	/**
	 * Creates a datagram based on the JSON packet
	 * 
	 * @param jso WRITEME ewinkelman@resinteractive.com
	 * @param listener WRITEME ewinkelman@resinteractive.com
	 * @throws JSONException WRITEME ewinkelman@resinteractive.com
	 */
	public ADPClick (final JSONObject jso,
			final ChannelListener listener) throws JSONException {
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
	 * @return WRITEME  brpocock 
	 */
	public String getOn () {
		return target;
	}
	
	/**
	 * Gets click modifiers
	 * 
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public String getWith () {
		return with;
	}
	
	/**
	 * Gets the x coordinate of the click event
	 * 
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public double getX () {
		return x;
	}
	
	/**
	 * Gets the y coordinate of the click event
	 * 
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public double getY () {
		return y;
	}
	
	/**
	 * Sets the target of the click event
	 * 
	 * @param target WRITEME ewinkelman@resinteractive.com
	 */
	public void setOn (final String target) {
		this.target = target;
		setJSON ("on", target);
	}
	
	/**
	 * Sets click modifiers
	 * 
	 * @param with WRITEME ewinkelman@resinteractive.com
	 */
	public void setWith (final String with) {
		this.with = with;
		setJSON ("with", with);
	}
	
	/**
	 * Sets the x coordinate of the click event
	 * 
	 * @param x WRITEME ewinkelman@resinteractive.com
	 */
	public void setX (final double x) {
		this.x = x;
		setJSON ("x", Double.valueOf (x));
	}
	
	/**
	 * Sets the y coordinate of the click event
	 * 
	 * @param y WRITEME ewinkelman@resinteractive.com
	 */
	public void setY (final double y) {
		this.y = y;
		setJSON ("y", Double.valueOf (y));
	}
	
}
