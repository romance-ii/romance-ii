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

/**
 * WRITEME: Document this type.
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public final class Vector2D extends Tuple2D <Vector2D> {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 2082166349616136575L;
	
	/**
	 * Create a coordinate pair from an x and y value
	 * 
	 * @param x0 x
	 * @param y0 y
	 */
	public Vector2D (final double x0, final double y0) {
		super (x0, y0);
	}
	
	/**
	 * Creates a vector from an existing vector pair
	 * 
	 * @param v WRITEME
	 */
	public Vector2D (final Vector2D v) {
		super (v);
	}
	
	/**
	 * Gets the dot product of the two vectors
	 * 
	 * @param v2d WRITEME
	 * @return dot-product
	 */
	public double dot (final Vector2D v2d) {
		return (x * v2d.x) + (y * v2d.y);
	}
	
	/**
	 * @return true, if x == y == 0
	 */
	public boolean isZero () {
		return (x == 0) && (y == 0);
	}
	
	/**
	 * Gets the length/magnitude of the vector
	 * 
	 * @return the length (magnitude) of the vector
	 */
	public double length () {
		return Math.sqrt ( (x * x) + (y * y));
	}
	
	/**
	 * Creates a new instance of the coordinate pair for use by the
	 * abstract generic parent class to get around downcasting problems
	 * 
	 * @see org.starhope.appius.geometry.Tuple2D#newInstance(double,
	 *      double)
	 */
	@Override
	protected Vector2D newInstance (final double x0, final double y0) {
		return new Vector2D (x0, y0);
	}
	
	/**
	 * Returns a normalised version of the vector
	 * 
	 * @return WRITEME
	 */
	public Vector2D normalize () {
		return scale (1 / length ());
	}
	
	/**
	 * Returns a new vector scaled by the magnitude given
	 * 
	 * @param magnitude WRITEME
	 * @return WRITEME
	 */
	public Vector2D scale (final double magnitude) {
		return new Vector2D (x * magnitude, y * magnitude);
	}
}
