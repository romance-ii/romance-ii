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

import java.io.Serializable;

/**
 * Base polygon class for 2D shapes
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @param <T> the specific subclass implementing this interface
 */
public interface PolygonPrimitive <T extends PolygonPrimitive <?>>
		extends Serializable {
	/**
	 * Determines if the polygon contains that point
	 * 
	 * @param coord2d WRITEME
	 * @return WRITEME
	 */
	boolean contains (final Coord2D coord2d);
	
	/**
	 * Determines if the polygon contains that point
	 * 
	 * @param x WRITEME
	 * @param y WRITEME
	 * @return WRITEME
	 */
	boolean contains (final double x, final double y);
	
	/**
	 * @return the center point
	 */
	Coord2D getCenter ();
	
	/**
	 * Finds the intersection points for the polygon with the line
	 * segment
	 * 
	 * @param lsSeg2d WRITEME
	 * @return WRITEME
	 */
	Coord2D [] intersection (final LineSeg2D lsSeg2d);
	
	/**
	 * Determines if the polygon intersects the line segment
	 * 
	 * @param lSeg2d WRITEME
	 * @return WRITEME
	 */
	boolean intersects (final LineSeg2D lSeg2d);
	
	/**
	 * Determines if the polygon intersects a polygon
	 * 
	 * @param polygon WRITEME
	 * @return WRITEME
	 */
	boolean intersects (final PolygonPrimitive <?> polygon);
	
	/**
	 * Determines if the polygon intersects a circle
	 * 
	 * @param circle WRITEME
	 * @return WRITEME
	 */
	boolean intersectsCircle (final Circle circle);
	
	/**
	 * Determines if the polygon intersects a polygon
	 * 
	 * @param polygon WRITEME
	 * @return WRITEME
	 */
	boolean intersectsPoly (final Polygon polygon);
	
	/**
	 * Determines if the polygon intersects a rectangle
	 * 
	 * @param rectangle WRITEME
	 * @return WRITEME
	 */
	boolean intersectsRect (final Rectangle rectangle);
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param sizeScalar WRITEME
	 * @return WRITEME
	 */
	T scale (double sizeScalar);
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param coord2d The amount to move
	 * @return WRITEME
	 */
	T translate (Coord2D coord2d);
	
	/**
	 * Translates the object
	 * 
	 * @param x The amount to move on the x-axis
	 * @param y The amount to move on the y-axis
	 * @return WRITEME
	 */
	T translate (final double x, final double y);
}
