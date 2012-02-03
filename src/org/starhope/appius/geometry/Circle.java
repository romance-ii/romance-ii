/**
 * ouble
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman
 */
package org.starhope.appius.geometry;

/**
 * A basic 2D circle class
 * 
 * @author ewinkelman
 */
/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman
 */
public class Circle implements PolygonPrimitive <Circle> {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -5541063773314738494L;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final protected Coord2D center;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final protected double radius;

	/**
	 * Constructs a basic circle
	 * 
	 * @param center0 Coordinates of the center point
	 * @param radius0 Radius of the circle
	 */
	public Circle (final Coord2D center0, final double radius0) {
		center = center0;
		radius = radius0;
	}

	/**
	 * Constructs a basic circle
	 * 
	 * @param x X coordinate of the center point
	 * @param y Y coordinate of the center point
	 * @param radius0 Radius of the circle
	 */
	public Circle (final double x, final double y, final double radius0) {
		this (new Coord2D (x, y), radius0);
	}

	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#contains(org.starhope.appius.geometry.Coord2D)
	 */
	@Override
	public boolean contains (final Coord2D coord2d) {
		return center.distance (coord2d) <= radius;
	}

	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#contains(double,
	 *      double)
	 */
	@Override
	public boolean contains (final double x, final double y) {
		return center.distance (new Coord2D (x, y)) <= radius;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param point1 WRITEME
	 * @param point2 WRITEME
	 * @return WRITEME
	 */
	private double getA (final Coord2D point1, final Coord2D point2) {
		final double x = point2.x - point1.x;
		final double y = point2.y - point1.y;
		return x * x + y * y;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param point1 WRITEME
	 * @param point2 WRITEME
	 * @param cntr WRITEME
	 * @return WRITEME
	 */
	private double getB (final Coord2D point1, final Coord2D point2,
			final Coord2D cntr) {
		return ( (point2.x - point1.x) * (point1.x - cntr.x) + (point2.y - point1.y)
				* (point1.y - cntr.y)) * 2;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param point1 WRITEME
	 * @param cntr WRITEME
	 * @param radius0 WRITEME
	 * @return WRITEME
	 */
	private double getC (final Coord2D point1, final Coord2D cntr,
			final double radius0) {
		return cntr.x * cntr.x + cntr.y * cntr.y + point1.x * point1.x
		+ cntr.y * cntr.y - 2
		* (cntr.x * point1.x + cntr.y * point1.y) - radius0
		* radius0;
	}

	/**
	 * @return the center of the circle
	 */
	@Override
	public Coord2D getCenter () {
		return center;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param point1 WRITEME
	 * @param point2 WRITEME
	 * @param u WRITEME
	 * @return WRITEME
	 */
	private Coord2D getIntPoint (final Coord2D point1,
			final Coord2D point2, final double u) {
		return point1.add (point2.subtract (point1).multiply (u));
	}

	/**
	 * @return the radius
	 */
	public double getRadius () {
		  return radius;
	}

	/**
	 * Finds the inside of the quadratic for intersecting a line and a
	 * circle
	 *
	 * @param a where a is a of au^2 + bu + c
	 * @param b where b is b of au^2 + bu + c
	 * @param c where c is c of au^2 + bu + c
	 * @return WRITEME
	 */
	private double insideRoot (final double a, final double b,
			final double c) {
		return b * b - 4 * a * c;
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#intersection(org.starhope.appius.geometry.LineSeg2D)
	 *      FIXME: This is returning grossly implausible values…
	 */
	@Override
	public Coord2D [] intersection (final LineSeg2D lsSeg2d) {
		final double a = getA (lsSeg2d.point1, lsSeg2d.point2);
		final double b = getB (lsSeg2d.point1, lsSeg2d.point2, center);
		final double inside = insideRoot (a, b,
				getC (lsSeg2d.point1, center, radius));
		if (inside > 0) {
			final double u1 = ( -b + Math.sqrt (inside)) / (2 * a);
			final double u2 = ( -b - Math.sqrt (inside)) / (2 * a);
			return new Coord2D [] {
					getIntPoint (lsSeg2d.point1, lsSeg2d.point2, u1),
					getIntPoint (lsSeg2d.point1, lsSeg2d.point2, u2) };
		} else if (inside == 0) {
			return new Coord2D [] { getIntPoint (lsSeg2d.point1,
					lsSeg2d.point2, -b / (2 * a)) };
		}

		return new Coord2D [] {};
	}

	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#intersects(org.starhope.appius.geometry.LineSeg2D)
	 */
	@Override
	public boolean intersects (final LineSeg2D segment) {
		return insideRoot (getA (segment.point1, segment.point2),
				getB (segment.point1, segment.point2, center),
				getC (segment.point1, center, radius)) >= 0;
	}

	/**
	 * Determines if this polygon intersects with another one XXX: There
	 * has to be a better way than this
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
	 * Determines if this circle intersects with another circle
	 *
	 * @param circle The circle to test intersection with
	 * @return WRITEME
	 */
	@Override
	public boolean intersectsCircle (final Circle circle) {
		return center.distance (circle.center) <= radius
		+ circle.radius;
	}

	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#intersectsPoly(org.starhope.appius.geometry.Polygon)
	 */
	@Override
	public boolean intersectsPoly (final Polygon polygon) {
		return polygon.intersects (this);
	}

	/**
	 * Tests to see if this rectangle intersects the circles
	 *
	 * @param rectangle WRITEME
	 * @return WRITEME
	 */
	@Override
	public boolean intersectsRect (final Rectangle rectangle) {
		return rectangle.intersects (this);
	}

	/**
	 * @param sizeScalar WRITEME
	 * @return WRITEME
	 */
	@Override
	public Circle scale (final double sizeScalar) {
		return new Circle (center, radius * sizeScalar);
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return center.toString () + " r=" + Double.toString (radius);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param coord2d WRITEME
	 * @return WRITEME
	 */
	@Override
	public Circle translate (final Coord2D coord2d) {
		return translate (coord2d.getX (), coord2d.getY ());
	}

	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#translate(double,
	 *      double)
	 */
	@Override
	public Circle translate (final double x, final double y) {
		return new Circle (center.x + x, center.y + y, radius);
	}

}
