/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.physica;

import java.awt.Polygon;
import java.awt.geom.AffineTransform;
import java.awt.geom.Area;
import java.awt.geom.GeneralPath;
import java.awt.geom.Line2D;
import java.awt.geom.Path2D;
import java.awt.geom.PathIterator;
import java.awt.geom.Point2D;
import java.awt.geom.Point2D.Double;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Set;
import java.util.regex.Pattern;

import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Room;
import org.starhope.appius.geometry.Circle;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * Collection of useful geometric routines
 * 
 * @author brpocock@star-hope.org
 * @author edward.winkelman@gmail.com
 */
public class Geometry {
	/**
	 * @param toMove WRITEME
	 * @param ddX WRITEME
	 * @param ddY WRITEME
	 * @param rate WRITEME
	 */
	public static void deltaV (final AbstractUser toMove,
			final double ddX, final double ddY, final double rate) {
		final Coord3D start = toMove.getLocationForUpdate ();
		try {
		final Coord3D target = toMove.getTarget ();
		final double tX = target.getX ();
		double dX = tX - start.getX ();
		final double tY = target.getY ();
		double dY = tY - start.getY ();
		dX += ddX * rate;
		dY += ddY * rate;
		toMove.setTravelRate (LibMisc.distance (0, 0, dX, dY));
		toMove.getRoom ().goTo (toMove, (tX + dX), (tY + dY), 0, null,
				"Walk");
		toMove.unlockLocation ();
		} finally {
			toMove.assertLocationUnlocked ();
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param u the user, currently in a walkable space
	 * @param room the room in which the user is standing
	 * @param destX WRITEME
	 * @param destY WRITEME
	 * @return the point at which the line crosses out of the walkable
	 *         spaces of the room
	 * @throws GameLogicException if the user isn't in the room
	 */
	public static Point2D getExitPoint (final AbstractUser u,
			final Room room, final double destX,
			final double destY) throws GameLogicException {
		if ( !u.getRoom ().equals (room)) {
			throw new GameLogicException ("miss", u, room);
		}
		final Coord3D pos = u.getLocation ();
		final double x = pos.getX ();
		final double y = pos.getY ();
		final Line2D line = new Line2D.Double (x, y, destX, destY);
		final GeneralPath space = room.getWalkableSpace ();
		if (space.contains (x, y)) {
			try {
				return Geometry.getExitPoint (line, space);
			} catch (NotFoundException e) {
				return null;
			}
		}
		return null;
	}

	/**
	 * Find the first (of what could, potentially, be several) point at
	 * which a given line segment crosses any boundary of the supplied
	 * space(s).
	 * 
	 * @param line the line to be tested
	 * @param space the space against which to test it
	 * @return the point of intersection of the line with any edge of
	 *         the space
	 * @throws NotFoundException if the line does not cross the
	 *             boundaries of the space
	 */
	public static Point2D getExitPoint (final Line2D line,
			final GeneralPath space) throws NotFoundException {
		Point2D prior = new Point2D.Double (0, 0);
		Point2D lastMove = new Point2D.Double (0, 0);
		final PathIterator pi = space
				.getPathIterator (new AffineTransform ());

		while ( !pi.isDone ()) {
			final double [] coords = new double [6];
			final int segType = pi.currentSegment (coords);
			pi.next ();

			switch (segType) {
			case PathIterator.SEG_LINETO:
				final Point2D intPoint = Geometry.getIntersectionPoint (
						line, new Line2D.Double (prior.getX (), prior
								.getY (), coords [0], coords [1]));
				if (null != intPoint) {
					return intPoint;
				}
				break;
			case PathIterator.SEG_MOVETO:
					prior = new Double (coords [0], coords [1]);
					lastMove = new Double (coords [0], coords [1]);
				break;
			case PathIterator.SEG_CLOSE:
				final Point2D intersectClose = Geometry
						.getIntersectionPoint (line, new Line2D.Double (
								lastMove.getX (), lastMove.getY (),
								coords [0], coords [1]));
				if (null != intersectClose) {
					return intersectClose;
				}
				break;
			default:
				break;
			}
		}

		throw new NotFoundException (
				"Line does not cross boundary of space");
	}

	/**
	 * intersection point of two line segments
	 * 
	 * @param line1 one line
	 * @param line2 another line
	 * @return the point at which those lines intersect, or null if they
	 *         are parallel
	 */
	public static Point2D.Double getIntersectionPoint (
			final Line2D line1, final Line2D line2) {
		if ( !line1.intersectsLine (line2)) {
			return null;
		}
		final double px = line1.getX1 ();
		final double py = line1.getY1 ();
		final double rx = line1.getX2 () - px;
		final double ry = line1.getY2 () - py;
		final double qx = line2.getX1 ();
		final double qy = line2.getY1 ();
		final double sx = line2.getX2 () - qx;
		final double sy = line2.getY2 () - qy;

		final double det = sx * ry - sy * rx;
		if (det < .001) {
			return null;
		}
		final double z = (sx * (qy - py) + sy * (px - qx)) / det;
		if (z < .000001 || z > .999999) {
			return null; // intersection at end point!
		}
		return new Point2D.Double ( (px + z * rx), (py + z * ry));
	}

	/**
	 * @param space some space
	 * @return a random point within that space
	 */
	public static Coord2D getRandomPointWithin (
			final org.starhope.appius.geometry.Polygon space) {
		Circle c = space.getBoundingCircle ();
		Coord2D centre = c.getCenter ();
		double radius = c.getRadius ();
		int left = (int) (centre.getX () - radius);
		int right = (int) (centre.getX ()+radius);
		int top = (int) (centre.getY() -radius);
		int bottom = (int) (centre.getY ()+radius);
		for (int tries = 10; tries > 0; --tries) {
			Coord2D spot = new Coord2D(AppiusConfig.getRandomInt (left,right), AppiusConfig.getRandomInt (top, bottom));
			if (space.contains (spot)) {
				return spot;
			}
		}
		if (space.contains (centre)) {
			return centre;
		}
		AppiusClaudiusCaecus.reportDesignBug ("Having trouble finding a random spot within a polygon at (" + space.toString () + ")");
		while (true) {
			Coord2D spot = new Coord2D(AppiusConfig.getRandomInt (left,right), AppiusConfig.getRandomInt (top, bottom));
			if (space.contains (spot)) {
				return spot;
			}
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param thing WRITEME
	 * @param when WRITEME
	 * @return WRITEME
	 */
	public static long getTimeToTarget (final AbstractUser thing,
			final long when) {
		return Geometry.updateUserPositioning (thing, when, false);
	}

	/**
	 * @param inner WRITEME
	 * @return WRITEME
	 */
	public static List <Point2D> getVertices (final Polygon inner) {
		final List <Point2D> vertices = new LinkedList <Point2D> ();
		for (int i = 0; i < inner.npoints; ++i) {
			vertices.add (new Point2D.Double (inner.xpoints [i],
					inner.ypoints [i]));
		}
		return vertices;
	}

	/**
	 * @param positive inclusive polys
	 * @param negative exclusive polys
	 * @return simplified set
	 */
	public static Set <Polygon> simplify (final Set <Polygon> positive,
			final Set <Polygon> negative) {
		final Area positiveArea = Geometry.toArea (positive);
		positiveArea.subtract (Geometry.toArea (negative));
		return Geometry.toPolygon (positiveArea);
	}

	/**
	 * @param positive positive spaces to collapse
	 * @param negative negative spaces to collapse
	 * @return a path explaining them all away
	 */
	public static GeneralPath squash (
			final Collection <GeneralPath> positive,
			final Collection <GeneralPath> negative) {
		final Iterator <GeneralPath> i = positive.iterator ();
		final Area a = new Area ();
		while (i.hasNext ()) {
			a.add (new Area (i.next ()));
		}
		final Iterator <GeneralPath> j = negative.iterator ();
		while (j.hasNext ()) {
			a.subtract (new Area (j.next ()));
		}
		return Geometry.toGeneralPath (a);
	}

	/**
	 * @param positive positive spaces to collapse
	 * @param negative negative spaces to collapse
	 * @return a path explaining them all away
	 */
	public static GeneralPath squash (final Set <GeneralPath> positive,
			final Set <GeneralPath> negative) {
		final Iterator <GeneralPath> i = positive.iterator ();
		final Area a = new Area ();
		while (i.hasNext ()) {
			a.add (new Area (i.next ()));
		}
		final Iterator <GeneralPath> j = negative.iterator ();
		while (j.hasNext ()) {
			a.subtract (new Area (j.next ()));
		}
		return Geometry.toGeneralPath (a);
	}

	/**
	 * Stringifies a pair of doubles representing a coordinate point
	 *
	 * @param d1 x ordinate
	 * @param d2 y abessa
	 * @return a string x "," y.
	 */
	public static String stringify (final double d1, final double d2) {
		return java.lang.Double.toString (d1) + ","
				+ java.lang.Double.toString (d2);
	}

	/**
	 * Stringifies a general path in the format of (x,y~x,y~~x,y~x,y)
	 * Where x,y are coordinate pairs and ~~ denotes discontinuous
	 * spaces
	 *
	 * @param path The path to stringify
	 * @return A stringified version of the path
	 */
	public static String stringify (final GeneralPath path) {
		final LinkedList <String> allList = new LinkedList <String> ();
		final LinkedList <String> sectionList = new LinkedList <String> ();

		final PathIterator p = path.getPathIterator (null);
		while ( !p.isDone ()) {
			final double [] coords = new double [6];
			switch (p.currentSegment (coords)) {
			case PathIterator.SEG_MOVETO:
				sectionList.add (Geometry.stringify (coords [0],
						coords [1]));
				break;
			case PathIterator.SEG_LINETO:
				sectionList.add (Geometry.stringify (coords [2],
						coords [3]));
				break;
			case PathIterator.SEG_CLOSE:
				final String [] strings = sectionList
						.toArray (new String [0]);
				allList.add (LibMisc.stringJoin (strings, "~"));
				sectionList.clear ();
				break;
			default:
				break;
			}

			p.next ();
		}
		final String [] strings = allList.toArray (new String [0]);

		return LibMisc.stringJoin (strings, "~~");
	}

	/**
	 * Stringifies a 2D coordinate point
	 *
	 * @param p a 2D point
	 * @return x "," y.
	 */
	public static String stringify (final Point2D p) {
		return Geometry.stringify (p.getX (), p.getY ());
	}

	/**
	 * convert a string into a GeneralPath
	 *
	 * @param polyString the polygon string
	 * @return a GeneralPath represented by the polygon string
	 * @throws NumberFormatException if the string has invalid numbers
	 */
	public static GeneralPath stringToGeneralPath (
			final String polyString) {
		final GeneralPath space = new GeneralPath ();
		if (polyString.length () == 0) {
			return space;
		}
		int points = 0;
		for (final String segment : polyString.split (Pattern
				.quote ("~"))) {
			final String [] xy = segment.split (Pattern.quote (","));
			try {
				if (0 == points) {
					space.moveTo (
							java.lang.Double.parseDouble (xy [0]),
							java.lang.Double.parseDouble (xy [1]));
				} else {
					space.lineTo (
							java.lang.Double.parseDouble (xy [0]),
							java.lang.Double.parseDouble (xy [1]));
				}
				++points;
			} catch (final NumberFormatException e) {
				AppiusClaudiusCaecus.reportBug ("Bad space in "
						+ " string " + polyString, e);
			} catch (final ArrayIndexOutOfBoundsException e) {
				AppiusClaudiusCaecus.reportBug ("Bad space in "
						+ " string " + polyString, e);
			}
		}
		if (points < 3) {
			return null;
		}
		return space;
	}

	/**
	 * Takes a string and turns it into a collection of GeneralPaths
	 *
	 * @param polyString The string to convert
	 * @return A set of GeneralPaths
	 */
	public static Collection <GeneralPath> stringToGeneralPathSet (
			final String polyString) {
		final HashSet <GeneralPath> result = new HashSet <GeneralPath> ();
		for (final String pathString : polyString.split (Pattern
				.quote ("~~"))) {
			final GeneralPath path = Geometry
					.stringToGeneralPath (pathString);
			if (null != path) {
				result.add (path);
			}
		}
		return result;
	}

	/**
	 * @param string a polygon specifier string
	 * @return an Appius polygon from the given string
	 */
	public static org.starhope.appius.geometry.Polygon stringToNewPolygon (
			final String string) {
		final LinkedList <Coord2D> vertices = new LinkedList <Coord2D> ();
		if (string.length () == 0) {
			return new org.starhope.appius.geometry.Polygon ();
		}
		for (final String segment : string.split (Pattern.quote ("~"))) {
			final String [] xy = segment.split (Pattern.quote (","));
			try {
				vertices.add (new Coord2D ((int) java.lang.Double
						.parseDouble (xy [0]), (int) java.lang.Double
						.parseDouble (xy [1])));
			} catch (final NumberFormatException e) {
				AppiusClaudiusCaecus.reportBug ("Bad space in "
						+ " string " + string, e);
			} catch (final ArrayIndexOutOfBoundsException e) {
				AppiusClaudiusCaecus.reportBug ("Bad space in "
						+ " string " + string, e);
			}
		}
		final Coord2D [] result = new Coord2D [vertices.size ()];
		vertices.toArray (result);
		return new org.starhope.appius.geometry.Polygon (result);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param polyString WRITEME
	 * @return WRITEME
	 * @throws NumberFormatException WRITEME
	 */
	@Deprecated
	public static Polygon stringToPolygon (final String polyString) {
		final Polygon space = new Polygon ();
		if (polyString.length () == 0) {
			return space;
		}
		for (final String segment : polyString.split (Pattern
				.quote ("~"))) {
			final String [] xy = segment.split (Pattern.quote (","));
			try {
				space.addPoint ((int) java.lang.Double
						.parseDouble (xy [0]), (int) java.lang.Double
						.parseDouble (xy [1]));
			} catch (final NumberFormatException e) {
				AppiusClaudiusCaecus.reportBug ("Bad space in "
						+ " string " + polyString, e);
			} catch (final ArrayIndexOutOfBoundsException e) {
				AppiusClaudiusCaecus.reportBug ("Bad space in "
						+ " string " + polyString, e);
			}
		}
		return space;
	}

	/**
	 * @param positive a set of polygons to be included
	 * @return the polygon set as an area
	 */
	private static Area toArea (final Set <Polygon> positive) {
		final Area a = new Area ();
		for (final Polygon p : positive) {
			if (p.npoints > 2) {
				final Path2D path = new Path2D.Double ();
				path.moveTo (p.xpoints [0], p.ypoints [0]);
				for (int i = 0; i < p.npoints; ++i) {
					path.lineTo (p.xpoints [i], p.ypoints [i]);
				}
				path.closePath ();
				a.add (new Area (path));
			}
		}
		return a;
	}

	/**
	 * @param area area
	 * @return path
	 */
	private static GeneralPath toGeneralPath (final Area area) {
		final GeneralPath p = new GeneralPath ();
		final PathIterator i = area.getPathIterator (null);
		p.moveTo (0, 0);
		final double [] coords = new double [4];
		while ( !i.isDone ()) {
			int how;
			try {
				how = i.currentSegment (coords);
			} catch (final NoSuchElementException e) {
				how = PathIterator.SEG_CLOSE;
			}
			switch (how) {
			case PathIterator.SEG_CLOSE:
				p.closePath ();
				break;
			case PathIterator.SEG_CUBICTO:
				AppiusClaudiusCaecus
						.reportBug ("cubic parametric curves not supported");
				break;
			case PathIterator.SEG_QUADTO:
				AppiusClaudiusCaecus
						.reportBug ("quadratic parametric curves not supported");
				break;
			case PathIterator.SEG_LINETO:
				p.lineTo (coords [0], coords [1]);
				break;
			case PathIterator.SEG_MOVETO:
				p.moveTo (coords [0], coords [1]);
				break;
			default:
				AppiusClaudiusCaecus
						.reportBug ("Unknown path operator");
			}
			i.next ();
		}
		return p;
	}

	/**
	 * @param area a polygon area
	 * @return a polygon set
	 */
	public static Set <Polygon> toPolygon (final Area area) {
		final Set <Polygon> polys = new HashSet <Polygon> ();
		Polygon p = new Polygon ();
		PathIterator i = area.getPathIterator (null);
		final double [] coords = new double [4];
		final int start = i.currentSegment (coords);
		if (PathIterator.SEG_MOVETO == start) {
			p.addPoint ((int) coords [0], (int) coords [1]);
		} else {
			AppiusClaudiusCaecus
					.reportBug ("path doesn't start with a moveTo, using 0");
			i = area.getPathIterator (null);
			p.addPoint (0, 0);
		}
		while ( !i.isDone ()) {
			int how;
			try {
				how = i.currentSegment (coords);
			} catch (final NoSuchElementException e) {
				how = PathIterator.SEG_CLOSE;
			}
			switch (how) {
			case PathIterator.SEG_CLOSE:
				p.addPoint (p.xpoints [0], p.ypoints [0]);
				break;
			case PathIterator.SEG_CUBICTO:
				AppiusClaudiusCaecus
						.reportBug ("cubic parametric curves not supported");
				break;
			case PathIterator.SEG_QUADTO:
				AppiusClaudiusCaecus
						.reportBug ("quadratic parametric curves not supported");
				break;
			case PathIterator.SEG_LINETO:
				p.addPoint ((int) coords [0], (int) coords [1]);
				break;
			case PathIterator.SEG_MOVETO:
				polys.add (p);
				p = new Polygon ();
				p.addPoint ((int) coords [0], (int) coords [1]);
				break;
			default:
				AppiusClaudiusCaecus
						.reportBug ("Unknown path operator");
			}
			i.next ();
		}
		if (p.npoints > 2) {
			polys.add (p);
		}
		return polys;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param thing WRITEME
	 * @return WRITEME
	 */
	public static long updateUserPositioning (final AbstractUser thing) {
		return Geometry.updateUserPositioning (thing, System
				.currentTimeMillis (), true);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param thing WRITEME
	 * @param when WRITEME
	 * @return WRITEME
	 */
	public static long updateUserPositioning (final AbstractUser thing,
			final long when) {
		return Geometry.updateUserPositioning (thing, when, true);
	}

	/**
	 * Determine the object's current position, and the time until it
	 * reaches its target (from now). Note that this is the preferred
	 * routine to be used to update the position of an object
	 *
	 * @param thing what is moving
	 * @param when what time is it now
	 * @param sideEffects if false, don't execute any side-effect
	 *            corrections: just return the time to travel
	 * @return how long until it gets there
	 */
	public static long updateUserPositioning (final AbstractUser thing,
			final long when, final boolean sideEffects) {

		final Coord3D startPos = thing.getLocation ();
		final Coord3D endPos = thing.getTarget ();

		double x1 = LibMisc.limit (startPos.getX (), 0, Room.MAX_X);
		final double x2 = LibMisc.limit (endPos.getX (), 0, Room.MAX_X);
		double y1 = LibMisc.limit (startPos.getY (), 0, Room.MAX_Y);
		final double y2 = LibMisc.limit (endPos.getY (), 0, Room.MAX_Y);

		final long travelStart = thing.getTravelStart ();
		final double rate = thing.getTravelRate ();

		if (0 == rate) {
			if (sideEffects) {
				thing.setTarget (startPos);
			}
			return 0;
		}

		final long traveledT = when - travelStart;
		final double distance = startPos.distance (endPos);
		final long tripT = (long) (distance / rate * 1000d);
		final long duration = tripT - traveledT;

		// Already arrived at their destination?
		if (traveledT >= tripT || distance < 1) {
			if (sideEffects) {
				thing.setLocation (endPos);
				thing.setTarget (endPos);
				thing.setTravelStart (when);
			}
			return 0;
		}

		x1 += (x2 - x1) / distance * traveledT * rate / 1000;
		y1 += (y2 - y1) / distance * traveledT * rate / 1000;
		thing.setLocation (new Coord3D (x1, y1, startPos.getZ ()));
		thing.setTravelStart (when);

		// Close enough as no matter. Declare them “there”
		if (Math.abs (x2 - x1) + Math.abs (y2 - y1) < 1) {
			if (sideEffects) {
				thing.setLocation (endPos);
				thing.setTravelStart (when);
			}
			return 0;
		}

		return duration;
	}
}
