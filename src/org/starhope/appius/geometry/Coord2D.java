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
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.geometry;

import java.util.LinkedList;
import java.util.List;
import java.util.regex.Pattern;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * WRITEME: Document this type.
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public final class Coord2D extends Tuple2D <Coord2D> {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -7966923849768378486L;
	
	/**
	 * understands (x,y) or x,y forms
	 * 
	 * @param string WRITEME
	 * @return coördinates
	 */
	public static Coord2D parseCoord2D (final String string) {
		if ('(' == string.charAt (0)) {
			final String [] parts = string.substring (1).split (
					Pattern.quote (","));
			parts [1] = parts [1].replace (")", "");
			return new Coord2D (Double.parseDouble (parts [0]),
					Double.parseDouble (parts [1]));
		}
		final String [] parts = string.split (Pattern.quote (","));
		return new Coord2D (Double.parseDouble (parts [0]),
				Double.parseDouble (parts [1]));
	}
	
	/**
	 * @param parts list of coördinates as a string
	 * @return list of coördinates
	 */
	public static List <Coord2D> parseCoord2D (final String [] parts) {
		final List <Coord2D> coords = new LinkedList <Coord2D> ();
		for (final String coordString : parts) {
			coords.add (Coord2D.parseCoord2D (coordString));
		}
		return coords;
	}
	
	/**
	 * Creates a coordinate pair from an existing coordinate pair
	 * 
	 * @param c other coördinates
	 */
	public Coord2D (final Coord2D c) {
		super (c);
	}
	
	/**
	 * Create a coordinate pair from an x and y value
	 * 
	 * @param x0 x ordinate
	 * @param y0 y abscissa
	 */
	public Coord2D (final double x0, final double y0) {
		super (x0, y0);
	}
	
	/**
	 * Create a Coord2D from a JSON object
	 * 
	 * @param jso an object with "x" and "y" values
	 * @throws JSONException on malformed input
	 */
	public Coord2D (final JSONObject jso) throws JSONException {
		this (jso.getDouble ("x"), jso.getDouble ("y"));
	}
	
	/**
	 * Gets the distance from this coordinate to the given one
	 * 
	 * @param coord2d Target coordinate
	 * @return Distance to target coordinate
	 */
	public double distance (final Coord2D coord2d) {
		return distance (coord2d.x, coord2d.y);
	}
	
	/**
	 * Gets the distance from this coordinate to the given one
	 * 
	 * @param x0 x
	 * @param y0 y
	 * @return distance
	 */
	public double distance (final double x0, final double y0) {
		final double x1 = x0 - x;
		final double y1 = y0 - y;
		return Math.sqrt ( (x1 * x1) + (y1 * y1));
	}
	
	/**
	 * Creates a new instance of the coordinate pair for use by the
	 * abstract generic parent class to get around downcasting problems
	 * 
	 * @see org.starhope.appius.geometry.Tuple2D#newInstance(double,
	 *      double)
	 */
	@Override
	protected Coord2D newInstance (final double x0, final double y0) {
		return new Coord2D (x0, y0);
	}
	
	/**
	 * @return (x,y,0)
	 */
	public Coord3D toCoord3D () {
		return new Coord3D (x, y, 0);
	}
	
	/**
	 * Moves the point by the given delta x and y
	 * 
	 * @param dX Δx
	 * @param dY Δy
	 * @return new coördinates
	 */
	public Coord2D translate (final double dX, final double dY) {
		return new Coord2D (x + dX, y + dY);
	}
}
