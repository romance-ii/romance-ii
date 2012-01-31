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
package org.starhope.appius.geometry;

import java.awt.geom.Point2D;
import java.util.regex.Pattern;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Room;
import org.starhope.appius.util.AppiusConfig;

/**
 * A coördinate triplet (x,y,z)
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Coord3D extends Tuple3D <Coord3D> {
	
	/**
	 * origin point (0,0,0)
	 */
	public static final Coord3D ORIGIN = new Coord3D (0, 0, 0);
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 540732171928361012L;
	
	/**
	 * Subtract two three-dimensional coordinates, returning the
	 * absolute distance between them.
	 * 
	 * @param a One point;
	 * @param b and the other
	 * @return The distance between the two coordinates
	 */
	public static double distance (final Coord3D a, final Coord3D b) {
		final double dX = a.x - b.x;
		final double dY = a.y - b.y;
		final double dZ = a.z - b.z;
		return Math.sqrt ( (dX * dX) + (dY * dY) + (dZ * dZ));
	}
	
	/**
	 * @param string A coordinate string as one of: JSON { x:###,
	 *             y:###, z:### } or (x,y,z) or [x:y:z]
	 * @return WRITEME
	 */
	public static Coord3D fromString (final String string) {
		double x, y, z = 0;
		if ('(' == string.charAt (0)) {
			final String [] coords = string.substring (1,
					string.indexOf (')')).split (
					Pattern.quote (","));
			x = Double.parseDouble (coords [0]);
			y = Double.parseDouble (coords [1]);
			if (coords.length > 2) {
				z = Double.parseDouble (coords [2]);
			} else {
				z = 0;
			}
		} else if ('[' == string.charAt (0)) {
			final String [] coords = string.substring (1,
					string.indexOf (']')).split (
					Pattern.quote (":"));
			x = Double.parseDouble (coords [0]);
			y = Double.parseDouble (coords [1]);
			if (coords.length > 2) {
				z = Double.parseDouble (coords [2]);
			} else {
				z = 0;
			}
		} else if ('{' == string.charAt (0)) {
			try {
				return new Coord3D (new JSONObject (string));
			} catch (final JSONException e) {
				throw new IllegalArgumentException (e);
			}
		} else {
			throw new IllegalArgumentException (
					"Can't parse coordinates: " + string);
		}
		
		return new Coord3D (x, y, z);
	}
	
	/**
	 * Syntactic sugar: This just returns the square root of the
	 * distance between two points, as a syntactic sugar for sound- and
	 * air-related events.
	 * 
	 * @param a One point
	 * @param b The other
	 * @return The square root of the distance
	 */
	public static double inverseSquare (final Coord3D a,
			final Coord3D b) {
		return Math.sqrt (Coord3D.distance (a, b));
	}
	
	/**
	 * Generate a random 3D coördinate someplace within the volume
	 * described by a given room. Does not make any assertions about
	 * the coördinate falling within a usable portion of that volume,
	 * e.g. a walkable space.
	 * 
	 * @param aRoom some room
	 * @return a coördinate within the room's described volume
	 */
	public static Coord3D randomIn (final Room aRoom) {
		final int minX = aRoom.getMinX ();
		final int minY = aRoom.getMinY ();
		final int minZ = aRoom.getMinZ ();
		final int maxX = aRoom.getMaxX ();
		final int maxY = aRoom.getMaxY ();
		final int maxZ = aRoom.getMaxZ ();
		Coord3D coord = new Coord3D (minX - 2, minY - 2, minZ - 2);
		for (; !aRoom.canWalk (coord, coord); coord = new Coord3D (
				AppiusConfig.getRandomInt (minX, maxX),
				AppiusConfig.getRandomInt (minY, maxY),
				AppiusConfig.getRandomInt (minZ, maxZ))) {
			// No op
		}
		return coord;
	}
	
	/**
	 * Create a coordinate set at (0,0,0)
	 */
	public Coord3D () {
		super (0, 0, 0);
	}
	
	/**
	 * Copy constructor
	 * 
	 * @param proto prototype to be copied
	 */
	public Coord3D (final Coord3D proto) {
		super (proto.x, proto.y, proto.z);
	}
	
	/**
	 * Creates a coordinate triplet
	 * 
	 * @param x0 x ordinate
	 * @param y0 y abscissa
	 * @param z0 z ordinate
	 */
	public Coord3D (final double x0, final double y0, final double z0) {
		super (x0, y0, z0);
	}
	
	/**
	 * Creates a coordinate triplet from a JSONObject
	 * 
	 * @param jso JSON object containing "x", "y", and "z" coördinates
	 * @throws JSONException if the object is malformed
	 */
	public Coord3D (final JSONObject jso) throws JSONException {
		super (jso);
	}
	
	/**
	 * @param p point
	 */
	public Coord3D (final Point2D p) {
		super (p.getX (), p.getY (), 0);
	}
	
	/**
	 * @return The absolute values of x,y, and z
	 */
	public Coord3D absolutes () {
		return new Coord3D (Math.abs (x), Math.abs (y), Math.abs (z));
	}
	
	/**
	 * Since there's no reasonable ordering for 3D points in a linear
	 * fashion, I compare their string forms.
	 * 
	 * @param other the other point
	 * @return the stringwise comparison of the two coördinate triplets
	 */
	public int compareTo (final Object other) {
		if (null == other) {
			return -1;
		}
		if ( ! (other instanceof Coord3D)) {
			return 1;
		}
		return toString ().compareTo (other.toString ());
	}
	
	/**
	 * Constrain this object's coordinates to be within the given
	 * boundaries.
	 * 
	 * @param minBounds The least they can be;
	 * @param maxBounds The most;
	 * @return true if any ordinate was chomped to fit within the range
	 */
	public Coord3D constrain (final Coord3D minBounds,
			final Coord3D maxBounds) {
		double newX = x;
		double newY = y;
		double newZ = z;
		
		if (x < minBounds.x) {
			newX = minBounds.x;
		}
		if (y < minBounds.y) {
			newY = minBounds.y;
		}
		if (z < minBounds.z) {
			newZ = minBounds.z;
		}
		if (x > maxBounds.x) {
			newX = maxBounds.x;
		}
		if (y > maxBounds.y) {
			newY = maxBounds.y;
		}
		if (z > maxBounds.z) {
			newZ = maxBounds.z;
		}
		return new Coord3D (newX, newY, newZ);
	}
	
	/**
	 * @param other another point
	 * @return the cross-product of the two points
	 */
	public Coord3D crossProduct (final Coord3D other) {
		return new Coord3D ( (y * other.z) - (z * other.y),
				(z * other.x) - (x * other.z), (x * other.y)
						- (y * other.x));
	}
	
	/**
	 * Find the distance to another point, from this one. BRP: this is
	 * reïmplemented for optimization, rather than just calling the
	 * static version, this saves a lot of pointer lookups in a very
	 * primitive routine.
	 * 
	 * @param other Some other point
	 * @return The distance
	 */
	public double distance (final Coord3D other) {
		final double dX = x - other.x;
		final double dY = y - other.y;
		final double dZ = z - other.z;
		return Math.sqrt ( (dX * dX) + (dY * dY) + (dZ * dZ));
	}
	
	/**
	 * @param other another point
	 * @return the dot-product (scalar product) of the vectors from
	 *         origin to the given points
	 */
	public double dotProduct (final Coord3D other) {
		return (x * other.x) + (y * other.y) + (z * other.z);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if ( ! (obj instanceof Coord3D)) {
			return false;
		}
		return toString ().equals (obj.toString ());
	}
	
	/**
	 * Syntactic sugar: This just returns the square root of the
	 * distance between two points, as a syntactic sugar for sound- and
	 * air-related events.
	 * 
	 * @param other The other point
	 * @return The square root of the distance
	 */
	public double inverseSquare (final Coord3D other) {
		return Math.sqrt (this.distance (other));
	}
	
	/**
	 * @see org.starhope.appius.geometry.Tuple3D#newInstance(double,
	 *      double, double)
	 */
	@Override
	protected Coord3D newInstance (final double x0, final double y0,
			final double z0) {
		return new Coord3D (x0, y0, z0);
	}
	
	/**
	 * Converts the 3D coordinate to a 2D coordinate. Reports a bug if
	 * the z coordinate is non-zero (€ = 0.00001d)
	 * 
	 * @return 2D version (assuming that z=0)
	 */
	public Coord2D toCoord2D () {
		if (Math.abs (z) > 0.00001d) {
			BugReporter.getReporter ("srv").reportBug (
					"Flattening a non-planar 3D coordinate : "
							+ toString ());
		}
		return new Coord2D (x, y);
	}
	
	/**
	 * @return an identical 3D vector from the origin
	 */
	public Vector3D toVector3D () {
		return new Vector3D (Coord3D.ORIGIN, this);
	}
	
}
