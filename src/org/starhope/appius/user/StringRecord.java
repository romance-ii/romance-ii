/**
 * <h1>StringRecord.java (org.starhope.appius.user)</h1> <h2>Project:
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

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.net.LocalisedThread;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * A string, tied to identifiers, with minimal translation support
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class StringRecord extends SimpleDataRecord <StringRecord> {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -9038677613899529652L;
	
	/**
	 * unique ID
	 */
	private int myID;
	
	/**
	 * unique ID
	 */
	private String myIdent;
	
	/**
	 * The collection of versions of this string in various languages
	 */
	private final Map <String, String> values = new ConcurrentHashMap <String, String> ();
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param loader WRITEME
	 */
	public StringRecord (final RecordLoader <StringRecord> loader) {
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
		if ( ! (obj instanceof StringRecord)) {
			return false;
		}
		final StringRecord other = (StringRecord) obj;
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
		return getID ();
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return getIdent ();
	}
	
	/**
	 * @return the myID
	 */
	public int getID () {
		return myID;
	}
	
	/**
	 * @return the myIdent
	 */
	public String getIdent () {
		return myIdent;
	}
	
	/**
	 * @param language_dialect language and dialect code
	 * @return the string in that language and dialect, if possible;
	 *         else, fall back upon English
	 */
	public String getLocalised (final String language_dialect) {
		String s = values.get (language_dialect);
		if (null != s) {
			return s;
		}
		s = values.get ("en_US");
		if (null != s) {
			return s + " (en_US)";
		}
		return "";
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
	 * @param id the myID to set
	 */
	public void setID (final int id) {
		myID = id;
		changed ();
	}
	
	/**
	 * @param newIdent the myIdent to set
	 */
	public void setIdent (final String newIdent) {
		myIdent = newIdent;
		changed ();
	}
	
	/**
	 * @param language language
	 * @param value value
	 */
	public void setValue (final String language, final String value) {
		final String prior = values.put (language, value);
		if ( !prior.equals (value)) {
			changed ();
		}
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final Thread current = Thread.currentThread ();
		if (current instanceof LocalisedThread) {
			return getLocalised ( ((LocalisedThread) current)
					.getLanguage ());
		}
		return getLocalised ("en_US");
	}
	
}
