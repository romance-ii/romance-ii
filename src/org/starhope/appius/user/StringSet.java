/**
 * <h1>GreetingSet.java (org.starhope.appius.user)</h1> <h2>Project:
 * Romance</h2>
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
 * License along with this program. If not, see
 * &lt;http://www.gnu.org/licenses/&gt;.
 * </p>
 */
package org.starhope.appius.user;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecordSet;

/**
 * A collection of strings obtained from an arbitrary source, with
 * minimal translation support; a set of {@link StringRecord}s
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class StringSet extends
		SimpleDataRecordSet <StringRecord, StringSet> {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -3646494586383185976L;
	
	/**
	 * unique ID for this set of strings
	 */
	private int myID;
	
	/**
	 * unique name for this set of strings
	 */
	private String myName;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param loader the record loader
	 */
	public StringSet (
			final RecordLoader <SimpleDataRecordSet <StringRecord, StringSet>> loader) {
		super (loader);
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
		if ( ! (obj instanceof StringSet)) {
			return false;
		}
		final StringSet other = (StringSet) obj;
		if (myID != other.myID) {
			return false;
		}
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return myID;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return myName;
	}
	
	/**
	 * @return an unique ID for this set of strings
	 */
	public int getID () {
		return myID;
	}
	
	/**
	 * @return an unique name for this set of strings
	 */
	public String getName () {
		return myName;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2262 $";
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result) + myID;
		return result;
	}
	
	/**
	 * @param id the unique ID for this set of strings
	 */
	public void setID (final int id) {
		myID = id;
		changed ();
	}
	
	/**
	 * @param name the unique name for this set of strings
	 */
	public void setName (final String name) {
		myName = name;
		changed ();
	}
	
}
