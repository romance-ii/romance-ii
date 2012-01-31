/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.util;

import java.lang.ref.WeakReference;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.user.Nomenclator;

/**
 * Holds a weak reference to a record held in the cache so that if it
 * gets cleaned out then the reference will be as well
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @param <T>
 */
public class WeakRecord <T extends SimpleDataRecord <?>> {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final int hashcode;
	
	/**
	 * ID to use, if one
	 */
	private final int ID;
	
	/**
	 * Identifier to use, if one
	 */
	private final String identifier;
	
	/**
	 * Cludge to hold class info and get around type erasure
	 */
	final private Class <T> klass;
	
	/**
	 * Weak references to the record
	 */
	private WeakReference <T> record = new WeakReference <T> (null);
	
	/**
	 * Determines if this uses an ID or a string identifier
	 */
	private final boolean usesID;
	
	/**
	 * Creates a weak record reference using a numeric ID
	 * 
	 * @param k WRITEME 
	 * @param id WRITEME 
	 */
	public WeakRecord (final Class <T> k, final int id) {
		usesID = true;
		ID = id;
		identifier = "";
		klass = k;
		hashcode = computeHash ();
	}
	
	/**
	 * Creates a weak record reference using a string identifier
	 * 
	 * @param k WRITEME 
	 * @param id WRITEME 
	 */
	public WeakRecord (final Class <T> k, final String id) {
		usesID = false;
		ID = 0;
		identifier = id;
		klass = k;
		hashcode = computeHash ();
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	private int computeHash () {
		final int prime = 31;
		int result = 1;
		result = (prime * result) + ID;
		return (prime * result)
				+ (identifier == null ? 0 : identifier.hashCode ());
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
		if ( ! (obj instanceof WeakRecord)) {
			return false;
		}
		@SuppressWarnings ("unchecked")
		final WeakRecord <T> other = (WeakRecord <T>) obj;
		if (ID != other.ID) {
			return false;
		}
		if (identifier == null) {
			if (other.identifier != null) {
				return false;
			}
		} else if ( !identifier.equals (other.identifier)) {
			return false;
		}
		return true;
	}
	
	/**
	 * Gets the record reference
	 * 
	 * @return WRITEME 
	 */
	public T get () {
		T result = record.get ();
		if (result == null) {
			try {
				if (usesID) {
					record = new WeakReference <T> (
							Nomenclator
									.getDataRecord (klass, ID));
				} else {
					record = new WeakReference <T> (
							Nomenclator.getDataRecord (klass,
									identifier));
				}
			} catch (final NotFoundException e) {
				BugReporter.getReporter ("srv").reportBug (
						"Exception", e);
			}
			result = record.get ();
		}
		return result;
		
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return hashcode;
	}
}
