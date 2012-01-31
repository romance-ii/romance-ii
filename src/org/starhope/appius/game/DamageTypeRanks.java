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
package org.starhope.appius.game;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * A collection of damage (or attack, or defence) values. This
 * implements a sort of convenient pseudo-Map, based upon the
 * {@link Map} interface.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class DamageTypeRanks implements Serializable {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 4593720566596804907L;
	/**
	 * The actual scores. Zeroes are not saved.
	 */
	private final Map <DamageArea, Double> scores = new HashMap <DamageArea, Double> ();
	
	/**
	 * @param key The damage area being described
	 * @param delta The change to apply to that damage area
	 * @return The new, resultant value for that area.
	 * @see java.util.Map#put(Object, Object)
	 */
	public double add (final DamageArea key, final double delta) {
		final Double n = scores.get (key);
		double sum = (null == n ? 0 : n.doubleValue ()) + delta;
		if (Math.abs (sum) < 0.0001) {
			scores.remove (key);
			sum = 0;
		} else {
			scores.put (key, Double.valueOf (sum));
		}
		return sum;
	}
	
	/**
	 * Add the complete set of damage ranks here, by the set supplied.
	 * 
	 * @param other another set of damage ranks
	 * @return this (for chaining)
	 * @see java.util.Map#putAll(java.util.Map)
	 */
	public DamageTypeRanks add (final DamageTypeRanks other) {
		if (null == other) {
			BugReporter.getReporter ("srv").reportBug (
					"Not adding null to DamageTypeRanks");
			return this;
		}
		for (final DamageArea area : other.keySet ()) {
			add (area, other.get (area));
		}
		return this;
	}
	
	/**
	 * @see java.util.Map#clear()
	 */
	public void clear () {
		scores.clear ();
	}
	
	/**
	 * @param key The damage area being described
	 * @param delta The change to apply to that damage area
	 * @return The new, resultant value for that area.
	 * @see java.util.Map#put(Object, Object)
	 */
	public double divide (final DamageArea key, final double delta) {
		final Double n = scores.get (key);
		double quotient = (null == n ? 0 : n.doubleValue ()) / delta;
		if (Math.abs (quotient) < 0.0001) {
			scores.remove (key);
			quotient = 0;
		} else {
			scores.put (key, Double.valueOf (quotient));
		}
		return quotient;
	}
	
	/**
	 * Divide the complete set of damage ranks supplied, by the set
	 * here.
	 * 
	 * @param other another set of damage ranks
	 * @see java.util.Map#putAll(java.util.Map)
	 */
	public void divide (final DamageTypeRanks other) {
		for (final DamageArea area : other.keySet ()) {
			add (area, other.get (area));
		}
	}
	
	/**
	 * @param key the damage area to be retrieved
	 * @return the value applied to that damage area
	 * @see java.util.Map#get(Object)
	 */
	
	public double get (final DamageArea key) {
		final Double n = scores.get (key);
		if (null == n) {
			return 0;
		}
		return n.doubleValue ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public synchronized void invert () {
		for (final Map.Entry <DamageArea, Double> entry : scores
				.entrySet ()) {
			scores.put (entry.getKey (), Double.valueOf ( -entry
					.getValue ().doubleValue ()));
		}
	}
	
	/**
	 * @return true, if this is a zero set
	 * @see java.util.Map#isEmpty()
	 */
	
	public boolean isEmpty () {
		return scores.size () == 0;
	}
	
	/**
	 * @return the keys which are non-zero in this set
	 * @see java.util.Map#keySet()
	 */
	public Set <DamageArea> keySet () {
		return scores.keySet ();
	}
	
	/**
	 * @param key The damage area being described
	 * @param delta The change to apply to that damage area
	 * @return The new, resultant value for that area.
	 * @see java.util.Map#put(Object, Object)
	 */
	public double multiply (final DamageArea key, final double delta) {
		final Double n = scores.get (key);
		double product = (null == n ? 0 : n.doubleValue ()) * delta;
		if (Math.abs (product) < 0.0001) {
			scores.remove (key);
			product = 0;
		} else {
			scores.put (key, Double.valueOf (product));
		}
		return product;
	}
	
	/**
	 * Multiply the complete set of damage ranks supplied, by the set
	 * here.
	 * 
	 * @param other another set of damage ranks
	 * @see java.util.Map#putAll(java.util.Map)
	 */
	public void multiply (final DamageTypeRanks other) {
		if (null == other) {
			BugReporter.getReporter ("srv").reportBug (
					"Can't multiple damage ranks by null");
			return;
		}
		for (final DamageArea area : other.keySet ()) {
			multiply (area, other.get (area));
		}
	}
	
	/**
	 * @param key The damage area being described
	 * @param value The new value
	 * @return The new, resultant value for that area.
	 * @see java.util.Map#put(Object,Object)
	 */
	public double put (final DamageArea key, final double value) {
		if (Math.abs (value) < 0.0001) {
			scores.remove (key);
			return 0;
		}
		scores.put (key, Double.valueOf (value));
		return value;
	}
	
	/**
	 * @return the number of non-zero damage areas in this set
	 * @see java.util.Map#size()
	 */
	
	public int size () {
		return scores.size ();
	}
	
	/**
	 * @param key The damage area being described
	 * @param delta The change to apply to that damage area
	 * @return The new, resultant value for that area.
	 * @see java.util.Map#put(Object, Object)
	 */
	public double subtract (final DamageArea key, final double delta) {
		final Double n = scores.get (key);
		double diff = (null == n ? 0 : n.doubleValue ()) - delta;
		if (Math.abs (diff) < 0.0001) {
			scores.remove (key);
			diff = 0;
		} else {
			scores.put (key, Double.valueOf (diff));
		}
		return diff;
	}
	
	/**
	 * Subtract the complete set of damage ranks supplied, from the set
	 * here.
	 * 
	 * @param other another set of damage ranks
	 * @see java.util.Map#putAll(java.util.Map)
	 */
	public void subtract (final DamageTypeRanks other) {
		for (final DamageArea area : other.keySet ()) {
			subtract (area, other.get (area));
		}
	}
	
	/**
	 * @return the sum of all damage values in this set.
	 */
	public double sum () {
		double sum = 0;
		for (final Double value : scores.values ()) {
			sum += value.doubleValue ();
		}
		return sum;
	}
	
	/**
	 * @return sum of only values greater than zero
	 */
	public double sumPositives () {
		double sum = 0;
		for (final Double value : scores.values ()) {
			sum += Math.max (0, value.doubleValue ());
		}
		return sum;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder s = new StringBuilder ();
		for (final Map.Entry <DamageArea, Double> score : scores
				.entrySet ()) {
			s.append (score.getKey ().getName ());
			s.append (": ");
			s.append (score.getValue ().toString ());
			s.append ("\t");
		}
		return s.toString ();
	}
	
}
