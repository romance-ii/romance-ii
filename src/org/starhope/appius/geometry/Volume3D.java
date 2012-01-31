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

import java.io.Serializable;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Volume3D implements Serializable {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 3701948769483763170L;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final Coord3D max;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final Coord3D min;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param newMin WRITEME
	 * @param newMax WRITEME
	 */
	Volume3D (final Coord3D newMin, final Coord3D newMax) {
		min = newMin;
		max = newMax;
	}
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param x1 WRITEME
	 * @param y1 WRITEME
	 * @param z1 WRITEME
	 * @param x2 WRITEME
	 * @param y2 WRITEME
	 * @param z2 WRITEME
	 */
	public Volume3D (final double x1, final double y1,
			final double z1, final double x2, final double y2,
			final double z2) {
		min = new Coord3D (x1, y1, z1);
		max = new Coord3D (x2, y2, z2);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public Coord3D getMax () {
		return max;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public double getMaxX () {
		return max.getX ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public double getMaxY () {
		return max.getY ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public double getMaxZ () {
		return max.getZ ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public Coord3D getMin () {
		return min;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public double getMinX () {
		return min.getX ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public double getMinY () {
		return min.getY ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public double getMinZ () {
		return min.getZ ();
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder s = new StringBuilder ();
		s.append (min.toString ());
		s.append ('-');
		s.append (max.toString ());
		return s.toString ();
	}
}
