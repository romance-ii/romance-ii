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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.geometry;

import java.util.regex.Pattern;

import org.starhope.appius.game.AppiusClaudiusCaecus;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class PolygonBuilder {
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param stringDescriptor WRITEME
	 * @return WRITEME
	 */
	public static PolygonPrimitive <?> instanceOf (
			final String stringDescriptor) {
		if ( (stringDescriptor.length () < 3)
				|| (stringDescriptor.charAt (1) != ':')) {
			throw AppiusClaudiusCaecus
					.fatalBug ("Invalid polyhedron string: "
							+ stringDescriptor);
		}
		final String [] parts = stringDescriptor.substring (2).split (
				Pattern.quote ("~"));
		switch (stringDescriptor.charAt (0)) {
		case 'c':
			return new Circle (Coord2D.parseCoord2D (parts [0]),
					Integer.parseInt (parts [1]));
		case 'r':
			return new Rectangle (Coord2D.parseCoord2D (parts [0]),
					Coord2D.parseCoord2D (parts [1]));
		case 'p':
			return new Polygon (Coord2D.parseCoord2D (parts));
		default:
			throw AppiusClaudiusCaecus
					.fatalBug ("Invalid polyhedron string: "
							+ stringDescriptor);
		}
	}
	
}
