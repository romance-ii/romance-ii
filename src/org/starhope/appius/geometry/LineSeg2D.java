/**
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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman
 */
package org.starhope.appius.geometry;


/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman
 *
 */
public class LineSeg2D {
    /**
     * Point 1
     */
    final Coord2D point1;

    /**
     * Point 2
     */
    final Coord2D point2;

    /**
	 * Constructor
	 * 
	 * @param p1 Point One
	 * @param p2 Point Two
	 */
    public LineSeg2D (final Coord2D p1, final Coord2D p2) {
        point1 = new Coord2D (p1);
        point2 = new Coord2D (p2);
    }
	
	/**
     * @return the first point
     */
    public Coord2D getPoint1 () {
        return new Coord2D (point1);
    }

    /**
     * @return the second point
     */
    public Coord2D getPoint2 () {
        return new Coord2D (point2);
    }

    /**
     * Gets the intersection point of two line segments
     *
     * @param lSeg2d The line segment to test intersection with
     * @return The point at which the lines intersect or null if they
     *         don't intersect
     */
    public Coord2D intersectionPoint (final LineSeg2D lSeg2d) {
        final double x43 = lSeg2d.point2.x - lSeg2d.point1.x;
        final double y13 = point1.y - lSeg2d.point1.y;
        final double y43 = lSeg2d.point2.y - lSeg2d.point1.y;
        final double x13 = point1.x - lSeg2d.point1.x;
        final double x21 = point2.x - point1.x;
        final double y21 = point2.y - point1.y;

        final double denom = y43 * x21 - x43 * y21;
        final double ua = ( x43 * y13 - y43 * x13) / denom;
        final double ub = ( x21 * y13 - y21 * x13) / denom;

        return ua > 0 && ua < 1 && ub > 0 && ub < 1 ? new Coord2D (
                point1.x + ua * (point2.x - point1.x),
                point1.y + ua * (point2.y - point1.y)):null;
    }

    /**
     * Determines if the line intersects another line
     *
     * @param lSeg2d  WRITEME
     * @return  WRITEME
     */
    public boolean intersects (final LineSeg2D lSeg2d) {
        return null != intersectionPoint (lSeg2d);
    }

    /**
     * @return WRITEME
     */
    public double length () {
        return Math.sqrt (Math.pow (point1.x - point2.x, 2)
                + Math.pow (point1.y - point2.y, 2));
    }

    /**
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString () {
        return "{" + point1.toString () + "," + point2.toString ()
                + "}";
    }

    /**
     * Creates a new line segment moved to the new position WRITEME:
     * Document this method ewinkelman
     *
     * @param x  WRITEME
     * @param y  WRITEME
     * @return  WRITEME
     */
    public LineSeg2D translate (final double x, final double y) {
        return new LineSeg2D (point1.translate (x, y), point2
                .translate (x, y));
    }

}
