/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.game;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * This is a base class used to express enumerated values. It enables a
 * simplified form for SQL record loading, as well. This covers the
 * ground for basic types that simply enumerate int:String mappings.
 * 
 * @author brpocock@star-hope.org
 * @param <T> the child class's type
 */
public abstract class SimpleDataEnum <T extends SimpleDataEnum <?>>
		extends
SimpleDataRecord <T> {
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -3794637927217760102L;
	/**
	 * The value of this enumerated name
	 */
	private int id;
	/**
	 * The name of this enumeration value
	 */
	private String name;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param subclass
	 */
	public SimpleDataEnum (
			final Class <? extends SimpleDataRecord <T>> subclass) {
		super (subclass);
		id =-1;
		name=null;
	}

	/**
	 * Constructor to be used by derived classes
	 *
	 * @param loader the record loader
	 */
	protected SimpleDataEnum (final RecordLoader <T> loader) {
		super (loader);
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return getID();
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return getName();
	}

	/**
	 * @return the id
	 */
	public int getID () {
		return id;
	}

	/**
	 * @return the name
	 */
	public String getName () {
		return name;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}

	/**
	 * @param newID the id to set
	 */
	public void setID (final int newID) {
		this.id = newID;
		changed ();
	}

	/**
	 * @param newName the name to set
	 */
	public void setName (final String newName) {
		this.name = newName; changed();
	}
	
	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#toString()
	 */
	@Override
	public String toString () {
		return name + "=#" + id;
	}
}
