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
 * Rectangle special case of a general polygon. Useful for it's
 * commonality
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class Rectangle implements PolygonPrimitive <Rectangle> {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -6129639463593612684L;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected final double height;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected final Coord2D origin;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected Polygon polygon;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected final double width;
	
	/**
	 * WRITEME brpocock@star-hope.org
	 * 
	 * @param oneCorner WRITEME
	 * @param otherCorner WRITEME
	 */
	public Rectangle (final Coord2D oneCorner,
			final Coord2D otherCorner) {
		origin = new Coord2D (Math.min (oneCorner.x, otherCorner.x),
				Math.min (oneCorner.y, otherCorner.y));
		height = Math.abs (otherCorner.getY () - oneCorner.getY ());
		width = Math.abs (otherCorner.getX () - oneCorner.getX ());
		
	}
	
	/**
	 * Creates a rectangle
	 * 
	 * @param ul Upper left hand coordinate
	 * @param w Width
	 * @param h Height
	 */
	public Rectangle (final Coord2D ul, final double w, final double h) {
		origin = ul;
		width = w;
		height = h;
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#contains(org.starhope.appius.geometry.Coord2D)
	 */
	@Override
	public boolean contains (final Coord2D coord2d) {
		return contains (coord2d.x, coord2d.y);
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#contains(double,
	 *      double)
	 */
	@Override
	public boolean contains (final double x, final double y) {
		return (x >= origin.x) && (x <= (origin.x + width))
				&& (y >= origin.y) && (y <= (origin.y + height));
	}
	
	/**
	 * Generates the line segments for the rectangle on demand so that
	 * we delay generating them until later if they're not going to be
	 * used
	 */
	private void generateLineSegments () {
		final Coord2D ur = new Coord2D (origin.x + width, origin.y);
		final Coord2D br = new Coord2D (origin.x + width, origin.y
				+ height);
		final Coord2D bl = new Coord2D (origin.x, origin.y + height);
		polygon = new Polygon (origin, ur, br, bl);
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#getCenter()
	 */
	@Override
	public Coord2D getCenter () {
		return origin.translate (width / 2, height / 2);
	}
	
	/**
	 * @return the height
	 */
	public double getHeight () {
		return height;
	}
	
	/**
	 * @return the origin
	 */
	public Coord2D getOrigin () {
		return origin;
	}
	
	/**
	 * @return the width
	 */
	public double getWidth () {
		return width;
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#intersection(org.starhope.appius.geometry.LineSeg2D)
	 */
	@Override
	public Coord2D [] intersection (final LineSeg2D lSeg2d) {
		if (null == polygon) {
			generateLineSegments ();
		}
		return polygon.intersection (lSeg2d);
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#intersects(org.starhope.appius.geometry.LineSeg2D)
	 */
	@Override
	public boolean intersects (final LineSeg2D lSeg2d) {
		if (null == polygon) {
			generateLineSegments ();
		}
		return polygon.intersects (lSeg2d);
	}
	
	/**
	 * Determines if this polygon intersects with another one
	 * <p>
	 * XXX: There has to be a better way than this
	 * </p>
	 * 
	 * @param otherPolygon WRITEME
	 * @return WRITEME
	 */
	@Override
	public boolean intersects (final PolygonPrimitive <?> otherPolygon) {
		if (otherPolygon instanceof Circle) {
			return intersectsCircle ((Circle) otherPolygon);
		} else if (otherPolygon instanceof Rectangle) {
			return intersectsRect ((Rectangle) otherPolygon);
		} else {
			return intersectsPoly ((Polygon) otherPolygon);
		}
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#intersectsCircle(org.starhope.appius.geometry.Circle)
	 */
	@Override
	public boolean intersectsCircle (final Circle circle) {
		if (null == polygon) {
			generateLineSegments ();
		}
		return polygon.intersects (circle);
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#intersectsPoly(org.starhope.appius.geometry.Polygon)
	 */
	@Override
	public boolean intersectsPoly (final Polygon otherPolygon) {
		if (null == otherPolygon) {
			return false;
		}
		if (null == polygon) {
			generateLineSegments ();
		}
		return polygon.intersects (otherPolygon);
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#intersectsRect(org.starhope.appius.geometry.Rectangle)
	 */
	@Override
	public boolean intersectsRect (final Rectangle rectangle) {
		if (null == polygon) {
			generateLineSegments ();
		}
		return polygon.intersects (rectangle.polygon);
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#scale(double)
	 */
	@Override
	public Rectangle scale (final double sizeScalar) {
		return new Rectangle (origin.multiply (sizeScalar), width
				* sizeScalar, height * sizeScalar);
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#translate(org.starhope.appius.geometry.Coord2D)
	 */
	@Override
	public Rectangle translate (final Coord2D coord2d) {
		return new Rectangle (origin.add (coord2d), width, height);
	}
	
	/**
	 * @see org.starhope.appius.geometry.PolygonPrimitive#translate(double,
	 *      double)
	 */
	@Override
	public Rectangle translate (final double x, final double y) {
		return new Rectangle (origin.translate (x, y), width, height);
	}
	
}
