/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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

/**
 * A simple line segment with two endpoints (expressed as
 * {@link Coord3D})
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class LineSeg3D {
	/**
	 * The start of the line
	 */
	protected final Coord3D a;
	/**
	 * The end of the line
	 */
	protected final Coord3D b;
	
	/**
	 * Construct a line segment with the given start and end points
	 * 
	 * @param start the start (A) coördinates
	 * @param end the end (B) coördinates
	 */
	public LineSeg3D (final Coord3D start, final Coord3D end) {
		a = new Coord3D (start);
		b = new Coord3D (end);
	}
	
	/**
	 * translate the line segment's end points by the amount of the
	 * coördinates provided
	 * 
	 * @param delta the amount to alter the line segment
	 * @return the line offset by the given delta
	 */
	public LineSeg3D add (final Coord3D delta) {
		return new LineSeg3D (a.add (delta), b.add (delta));
	}
	
	/**
	 * @return a vector matching this line segment in origin and
	 *         magnitude
	 */
	public Vector3D asVector () {
		return new Vector3D (a, b);
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object) Note, two lines
	 *      are equal if (and only if) they share the same two
	 *      endpoints; however, a line from A to B is identical to a
	 *      line from B to A for these purposes.
	 */
	@Override
	public boolean equals (final Object obj) {
		if ( ! (obj instanceof LineSeg3D)) {
			return false;
		}
		final LineSeg3D l = (LineSeg3D) obj;
		final Coord3D e = l.getStart ();
		final Coord3D f = l.getEnd ();
		return (a.equals (e) && b.equals (f))
				|| (a.equals (f) && b.equals (e));
	}
	
	/**
	 * Get the final (B) coördinates of this segment
	 * 
	 * @return the coördinates of the end of the line segment
	 */
	public Coord3D getEnd () {
		return new Coord3D (b);
	}
	
	/**
	 * Get the initial (A) coördinates of this segment
	 * 
	 * @return the coördinates of the start of the line segment
	 */
	public Coord3D getStart () {
		return new Coord3D (a);
	}
	
	/**
	 * @param p any point
	 * @return true, if the point is one of the endpoints (start or
	 *         end) of this line
	 */
	public boolean hasEndpoint (final Coord3D p) {
		return a.equals (p) || b.equals (p);
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return a.hashCode () ^ 0xcccccccc ^ b.hashCode ();
	}
	
	/**
	 * Create a copy of the line transformed so that it starts at the
	 * origin.
	 * 
	 * @return the copy
	 */
	public LineSeg3D toOrigin () {
		return new LineSeg3D (new Coord3D (0, 0, 0), b.subtract (a));
	}
	
}
