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
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.CastsToJSON;

/**
 * Base coordinate triplet type
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @param <T> the subclass for hacky type-safety things
 */
public abstract class Tuple3D <T extends Tuple3D <T>> implements
		CastsToJSON {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 865925514616162599L;
	
	/**
	 * X
	 */
	protected final double x;
	
	/**
	 * Y
	 */
	protected final double y;
	
	/**
	 * Z
	 */
	protected final double z;
	
	/**
	 * Create a new coördinate triplet
	 * 
	 * @param x0 x ordinate
	 * @param y0 y abscissa
	 * @param z0 z ordinate
	 */
	public Tuple3D (final double x0, final double y0, final double z0) {
		if (Double.isNaN (x0) || Double.isInfinite (x0)
				|| Double.isNaN (y0) || Double.isInfinite (y0)
				|| Double.isNaN (z0) || Double.isInfinite (z0)) {
			throw new IllegalArgumentException (
					"finite coördinates are mandatory");
		}
		x = x0;
		y = y0;
		z = z0;
	}
	
	/**
	 * Instantiate from JSON data
	 * 
	 * @param o JSON coordinate object
	 * @throws JSONException if the data is malformed
	 */
	public Tuple3D (final JSONObject o) throws JSONException {
		x = o.optDouble ("x");
		y = o.optDouble ("y");
		z = o.optDouble ("z");
	}
	
	/**
	 * Create a new coordinate triplet from an existing coordinate
	 * triplet
	 * 
	 * @param t tuple
	 */
	public Tuple3D (final T t) {
		this.x = t.x;
		this.y = t.y;
		this.z = t.z;
	}
	
	/**
	 * Adds the coördinate triplet to the tuple together
	 * 
	 * @param x0 x ordinate
	 * @param y0 y abscissa
	 * @param z0 z ordinate
	 * @return a new tuple
	 */
	public T add (final double x0, final double y0, final double z0) {
		return newInstance (this.x + x0, this.y + y0, this.z + z0);
	}
	
	/**
	 * Adds two tuples together
	 * 
	 * @param p tuple
	 * @return the sum of the coördinates
	 */
	public T add (final T p) {
		return newInstance (x + p.x, y + p.y, z + p.z);
	}
	
	/**
	 * @see java.lang.Object#clone()
	 */
	@Override
	protected Object clone () throws CloneNotSupportedException {
		throw new CloneNotSupportedException ();
	}
	
	/**
	 * <p>
	 * Divides the tuple by the value
	 * </p>
	 * <p>
	 * <strong>Note:</strong> Will happily try to divide by zero if
	 * assertions are disabled!
	 * </p>
	 * 
	 * @param dividend Amount by which to divide the tuple
	 * @return the tuple divided by the scaling factor
	 */
	public T divide (final double dividend) {
		assert dividend != 0;
		return newInstance (x / dividend, y / dividend, z / dividend);
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
		if ( ! (obj instanceof Tuple3D)) {
			return false;
		}
		final Tuple3D other = (Tuple3D) obj;
		if (Double.doubleToLongBits (x) != Double
				.doubleToLongBits (other.x)) {
			return false;
		}
		if (Double.doubleToLongBits (y) != Double
				.doubleToLongBits (other.y)) {
			return false;
		}
		if (Double.doubleToLongBits (z) != Double
				.doubleToLongBits (other.z)) {
			return false;
		}
		return true;
	}
	
	/**
	 * Gets the X ordinate
	 * 
	 * @return x ordinate
	 */
	public double getX () {
		return x;
	}
	
	/**
	 * Gets the Y abscissa
	 * 
	 * @return y abscissa
	 */
	public double getY () {
		return y;
	}
	
	/**
	 * Gets the Z ordinate
	 * 
	 * @return z ordinate
	 */
	public double getZ () {
		return z;
	}
	
	/**
	 * Implementation: Takes the 64-bit binary representation of each
	 * of the double-precision floating-point values in this object,
	 * rotates them (x << 32, y << 16) and exclusive-ors them, then
	 * combines the upper and lower 32-bit words through another
	 * exclusive-or.
	 * 
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
		temp = Double.doubleToLongBits (z);
		result = (prime * result) + (int) (temp ^ (temp >>> 32));
		return result;
	}
	
	/**
	 * Multiplies the tuple by the value
	 * 
	 * @param factor Amount by which to multiply the tuple
	 * @return the tuple scaled by the given factor
	 */
	public T multiply (final double factor) {
		return newInstance (x * factor, y * factor, z * factor);
	}
	
	/**
	 * Method used to create a new object of the child's type while
	 * getting around down-casting problems in Java
	 * 
	 * @param x0 x ordinate
	 * @param y0 y abscissa
	 * @param z0 z ordinate
	 * @return a new instance of the same type, with the given values
	 */
	protected abstract T newInstance (double x0, double y0, double z0);
	
	/**
	 * Subtracts the coordinate triplet from this tuple
	 * 
	 * @param x2 Coordinate triplet to subtract from this tuple
	 * @param y2 Coordinate triplet to subtract from this tuple
	 * @param z2 Coordinate triplet to subtract from this tuple
	 * @return the difference
	 */
	public T subtract (final double x2, final double y2,
			final double z2) {
		return newInstance (this.x - x2, this.y - y2, this.z - z2);
	}
	
	/**
	 * Subtracts a tuple from this tuple
	 * 
	 * @param p Tuple to subtract from this tuple
	 * @return the difference
	 */
	public T subtract (final T p) {
		return newInstance (x - p.x, y - p.y, z - p.z);
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
			o.put ("z", z);
		} catch (final JSONException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		}
		return o;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return "(" + x + "," + y + "," + z + ")";
	}
	
}
