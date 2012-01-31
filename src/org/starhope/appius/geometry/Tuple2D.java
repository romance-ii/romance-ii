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

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.util.CastsToJSON;

/**
 * Base coordinate pair type
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @param <T> WRITEME
 */
public abstract class Tuple2D <T extends Tuple2D <T>> implements
		CastsToJSON {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 8247530573802654281L;
	
	/**
	 * X
	 */
	protected final double x;
	
	/**
	 * Y
	 */
	protected final double y;
	
	/**
	 * Create a new coordinate pair
	 * 
	 * @param x0 WRITEME
	 * @param y0 WRITEME
	 */
	public Tuple2D (final double x0, final double y0) {
		this.x = x0;
		this.y = y0;
	}
	
	/**
	 * Create a new coordinate pair from an existing coordinate pair
	 * 
	 * @param t WRITEME
	 */
	public Tuple2D (final T t) {
		this.x = t.x;
		this.y = t.y;
	}
	
	/**
	 * Adds the coordinate pair to the tuple together
	 * 
	 * @param x0 WRITEME
	 * @param y0 WRITEME
	 * @return WRITEME
	 */
	public T add (final double x0, final double y0) {
		return newInstance (this.x + x0, this.y + y0);
	}
	
	/**
	 * Adds two tuples together
	 * 
	 * @param p WRITEME
	 * @return WRITEME
	 */
	public T add (final T p) {
		return newInstance (x + p.x, y + p.y);
	}
	
	/**
	 * @see java.lang.Object#clone()
	 */
	@Override
	protected Object clone () throws CloneNotSupportedException {
		throw new CloneNotSupportedException ();
	}
	
	/**
	 * Divides the tuple by the value NOTE: Will happily try to divide
	 * by zero!
	 * 
	 * @param factor Amount to divide the tuple by
	 * @return WRITEME
	 */
	public T divide (final double factor) {
		return newInstance (x / factor, y / factor);
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof Tuple2D)) {
			return false;
		}
		final Tuple2D other = (Tuple2D) obj;
		if (Double.doubleToLongBits (x) != Double
				.doubleToLongBits (other.x)) {
			return false;
		}
		if (Double.doubleToLongBits (y) != Double
				.doubleToLongBits (other.y)) {
			return false;
		}
		return true;
	}
	
	/**
	 * Gets the X coordinate
	 * 
	 * @return WRITEME
	 */
	public double getX () {
		return x;
	}
	
	/**
	 * Gets the Y coordinate
	 * 
	 * @return WRITEME
	 */
	public double getY () {
		return y;
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		long temp;
		temp = Double.doubleToLongBits (x);
		result = (prime * result) + (int) (temp ^ (temp >>> 32));
		temp = Double.doubleToLongBits (y);
		result = (prime * result) + (int) (temp ^ (temp >>> 32));
		return result;
	}
	
	/**
	 * Multiplies the tuple by the value
	 * 
	 * @param factor Amount to multiply the tuple by
	 * @return WRITEME
	 */
	public T multiply (final double factor) {
		return newInstance (x * factor, y * factor);
	}
	
	/**
	 * Method used to create a new object of the child's type while
	 * getting around downcasting problems in Java
	 * 
	 * @param x0 x
	 * @param y0 y
	 * @return (x,y)
	 */
	protected abstract T newInstance (double x0, double y0);
	
	/**
	 * Subtracts the coordinate pair from this tuple
	 * 
	 * @param x2 Coordinate pair to subtract from this tuple
	 * @param y2 Coordinate pair to subtract from this tuple
	 * @return WRITEME
	 */
	public T subtract (final double x2, final double y2) {
		return newInstance (this.x - x2, this.y - y2);
	}
	
	/**
	 * Subtracts a tuple from this tuple
	 * 
	 * @param p Tuple to subtract from this tuple
	 * @return WRITEME
	 */
	public T subtract (final T p) {
		return newInstance (x - p.x, y - p.y);
	}
	
	/**
	 * @see org.starhope.appius.util.CastsToJSON#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject o = new JSONObject ();
		try {
			o.put ("x", x);
			o.put ("y", y);
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
			throw new Error (e);
		}
		return o;
	}
	
	@Override
	public String toString () {
		return "(" + Double.toString (x) + "," + Double.toString (y)
				+ ")";
	}
	
}
