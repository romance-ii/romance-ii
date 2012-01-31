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

import java.util.Arrays;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;

import org.starhope.appius.except.ParameterException;
import org.starhope.appius.game.AppiusClaudiusCaecus;

/**
 * General polygon consisting of a series of line segments
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class Polygon implements PolygonPrimitive <Polygon> {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 3744280690134486036L;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected Circle boundingCircle;
	
	/**
	 * Bounding rectangle
	 */
	protected Rectangle boundingRectangle;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final protected Coord2D [] points;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final protected LineSeg2D [] segments;
	
	/**
	 * Constructs a closed polygon using the given set of points as
	 * line segments
	 * 
	 * @param newPoints The points to use to construct the polygon
	 */
	public Polygon (final Coord2D... newPoints) {
		points = null == newPoints ? new Coord2D [] {} : newPoints;
		computeBounds ();
		segments = computeSegments ();
	}
	
	/**
	 * Private constructor used during internal changes to avoid the
	 * overhead of recalcuating bounding stuff ASSUMES you know what
	 * you're doing!
	 * 
	 * @param newPoints WRITEME
	 * @param newSegments WRITEME
	 * @param newBoundingCircle WRITEME
	 */
	private Polygon (final Coord2D [] newPoints,
			final LineSeg2D [] newSegments,
			final Circle newBoundingCircle) {
		points = newPoints;
		segments = newSegments;
		boundingCircle = newBoundingCircle;
	}
	
	/**
	 * Constructs a polygon from a pair of arrays. Assumes that the
	 * arrays of like indexes form coordinate points from which it can
	 * assemble the polygon into line segments
	 * 
	 * @param xPoints Array of x coordinate points
	 * @param yPoints Array of y coordinate points
	 * @throws ParameterException The number of x and y coordinates
	 *              must match
	 */
	public Polygon (final double [] xPoints, final double [] yPoints)
			throws ParameterException {
		if (xPoints.length != yPoints.length) {
			throw new ParameterException (
					"Array of x and y coordinate points for polygon do not match count");
		}
		final Coord2D [] newPoints = new Coord2D [xPoints.length];
		points = newPoints;
		computeBounds ();
		segments = computeSegments ();
	}
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param newPoints WRITEME
	 */
	public Polygon (final List <Coord2D> newPoints) {
		this (newPoints.toArray (new Coord2D [] {}));
	}
	
	/**
	 * Computes a rough bounding circle and rectangle
	 */
	private void computeBounds () {
		double xMin = Double.MAX_VALUE;
		double xMax = Double.MIN_VALUE;
		double yMin = Double.MAX_VALUE;
		double yMax = Double.MIN_VALUE;
		for (final Coord2D point : points) {
			xMin = Math.min (xMin, point.x);
			xMax = Math.max (xMax, point.x);
			yMin = Math.min (yMin, point.y);
			yMax = Math.max (yMax, point.y);
		}
		final Coord2D center = new Coord2D ( (xMax + xMin) / 2d,
				(yMax + yMin) / 2d);
		
		double radius = Double.MIN_VALUE;
		for (final Coord2D point : points) {
			radius = Math.max (radius, center.distance (point));
		}
		boundingCircle = new Circle (center, radius);
		boundingRectangle = new Rectangle (new Coord2D (xMin, yMin),
				xMax - xMin, yMax - yMin);
	}
	
	/**
	 * Computes the line segments for the polygon
	 * 
	 * @return WRITEME
	 */
	private LineSeg2D [] computeSegments () {
		LineSeg2D [] segs = {};
		if (points.length > 1) {
			segs = new LineSeg2D [points.length];
			for (int i = 0; i < (segs.length - 1); i++ ) {
				segs [i] = new LineSeg2D (points [i],
						points [i + 1]);
			}
			segs [points.length - 1] = new LineSeg2D (
					points [points.length - 1], points [0]);
		}
		
		return segs;
	}
	
	/**
	 * Tests to see if we are inside of the polygon. Will give
	 * incorrect results if the polygon exceeds 100 000 units in size
	 * 
	 * @see org.starhope.appius.geometry.PolygonPrimitive#contains(org.starhope.appius.geometry.Coord2D)
	 */
	@Override
	public boolean contains (final Coord2D coord2d) {
		// Create an arbitrary large line segment from the point to
		// the
		// right.
		if (boundingCircle.contains (coord2d)) {
			final LineSeg2D ray = new LineSeg2D (coord2d,
					new Coord2D (100000 + coord2d.x, coord2d.y));
			int count = 0;
			for (final LineSeg2D segment : segments) {
				if (ray.intersects (segment)) {
					count++ ;
				}
			}
			return (count % 2) != 0;
		}
		return false;
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#contains(double,
	 *      double)
	 */
	@Override
	public boolean contains (final double x, final double y) {
		return contains (new Coord2D (x, y));
	}
	
	/**
	 * @return WRITEME
	 */
	public Circle getBoundingCircle () {
		return boundingCircle;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public Rectangle getBoundingRectangle () {
		return boundingRectangle;
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#getCenter()
	 */
	@Override
	public Coord2D getCenter () {
		return getBoundingCircle ().getCenter ();
	}
	
	/**
	 * @return the points
	 */
	public Coord2D [] getPoints () {
		return Arrays.copyOf (points, points.length);
	}
	
	/**
	 * @return the segments
	 */
	public LineSeg2D [] getSegments () {
		return Arrays.copyOf (segments, segments.length);
	}
	
	/**
	 * Gets all the intersection points between two polygons
	 * 
	 * @see org.starhope.appius.geometry.PolygonPrimitive#intersection(org.starhope.appius.geometry.LineSeg2D)
	 */
	@Override
	public Coord2D [] intersection (final LineSeg2D lSeg2d) {
		final HashSet <Coord2D> set = new HashSet <Coord2D> ();
		for (final LineSeg2D segment : segments) {
			final Coord2D intPoint = segment
					.intersectionPoint (lSeg2d);
			if (null != intPoint) {
				set.add (intPoint);
			}
		}
		final Coord2D [] result = new Coord2D [set.size ()];
		set.toArray (result);
		return result;
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#intersects(org.starhope.appius.geometry.LineSeg2D)
	 */
	@Override
	public boolean intersects (final LineSeg2D lSeg2d) {
		if (points.length < 2) {
			return false;
		}
		for (int i = 1; i < points.length; i++ ) {
			if (lSeg2d.intersects (new LineSeg2D (points [i - 1],
					points [i]))) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * <p>
	 * Determines if this polygon intersects with another one
	 * </p>
	 * <p>
	 * XXX: There has to be a better way than this
	 * </p>
	 * 
	 * @param polygon WRITEME
	 * @return WRITEME
	 */
	@Override
	public boolean intersects (final PolygonPrimitive <?> polygon) {
		if (polygon instanceof Circle) {
			return intersectsCircle ((Circle) polygon);
		} else if (polygon instanceof Rectangle) {
			return intersectsRect ((Rectangle) polygon);
		} else {
			return intersectsPoly ((Polygon) polygon);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param circle WRITEME
	 * @return WRITEME
	 */
	@Override
	public boolean intersectsCircle (final Circle circle) {
		if (contains (circle.center)) {
			return true;
		}
		
		for (final LineSeg2D segment : segments) {
			if (circle.intersects (segment)) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param polygon WRITEME
	 * @return WRITEME
	 */
	@Override
	public boolean intersectsPoly (final Polygon polygon) {
		if (boundingCircle.intersects (polygon.getBoundingCircle ())) {
			for (final LineSeg2D segment : polygon.segments) {
				for (final LineSeg2D segment2 : segments) {
					if (segment2.intersects (segment)) {
						return true;
					}
				}
			}
		}
		return false;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param rectangle WRITEME
	 * @return WRITEME
	 */
	@Override
	public boolean intersectsRect (final Rectangle rectangle) {
		return rectangle.polygon.intersectsPoly (this);
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#scale(double)
	 */
	@Override
	public Polygon scale (final double sizeScalar) {
		final List <Coord2D> newPoints = new LinkedList <Coord2D> ();
		for (final Coord2D point : points) {
			newPoints.add (point.multiply (sizeScalar));
		}
		return new Polygon (newPoints);
	}
	
	/**
	 * @return a string in x,y~x,y notation for room variables
	 */
	public String toRoomVar () {
		final StringBuilder s = new StringBuilder ();
		for (int i = 0; i < points.length; ++i) {
			s.append (points [i].getX ());
			s.append (',');
			s.append (points [i].getY ());
			if (i < (points.length - 1)) {
				s.append ('~');
			}
		}
		return s.toString ();
	}
	
	/**
	 * format roughly {(x,y),(x,y)…}
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder sBuilder = new StringBuilder ();
		sBuilder.append ("{");
		for (int i = 0; i < points.length; i++ ) {
			sBuilder.append (Arrays.toString (points));
			if (i < (points.length - 1)) {
				sBuilder.append (",");
			}
		}
		sBuilder.append ("}");
		return sBuilder.toString ();
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#translate(org.starhope.appius.geometry.Coord2D)
	 */
	@Override
	public Polygon translate (final Coord2D coord2d) {
		AppiusClaudiusCaecus
				.fatalBug ("unimplemented: Polygon.translate");
		return null;
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#translate(double,
	 *      double)
	 */
	@Override
	public Polygon translate (final double x, final double y) {
		final Coord2D [] newCoord2ds = new Coord2D [points.length];
		for (int i = 0; i < points.length; i++ ) {
			newCoord2ds [i] = points [i].add (x, y);
		}
		final LineSeg2D [] newSegments = new LineSeg2D [segments.length];
		for (int i = 0; i < segments.length; i++ ) {
			newSegments [i] = segments [i].translate (x, y);
		}
		return new Polygon (newCoord2ds, newSegments,
				boundingCircle.translate (x, y));
	}
	
}
