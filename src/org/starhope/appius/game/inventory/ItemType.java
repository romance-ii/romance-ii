/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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
 * License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
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

package org.starhope.appius.game.inventory;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class InventoryItemType extends
		SimpleDataRecord <InventoryItemType> {
	
	/**
	 * Java serialization unique ID
	 */
	private static final long serialVersionUID = 8514877584411321981L;
	
	/**
	 * Unique ID
	 */
	private int id;
	
	/**
	 * Unique name
	 */
	private String name;
	
	/**
	 * The item slots that this item type uses
	 */
	private ClothingSlot [] slots = new ClothingSlot [] {};
	
	/**
	 * Nil constructor
	 */
	public InventoryItemType () {
		super (InventoryItemType.class);
	}
	
	/**
	 * constructor to be used in the
	 * 
	 * @param loader the record loader
	 */
	public InventoryItemType (
			final RecordLoader <InventoryItemType> loader) {
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
		if ( ! (obj instanceof InventoryItemType)) {
			return false;
		}
		final InventoryItemType other = (InventoryItemType) obj;
		if (id != other.id) {
			return false;
		}
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return id;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return getName ();
	}
	
	/**
	 * @return the unique ID for this item type
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
	 * Gets the slots that this item type uses
	 * 
	 * @return WRITEME 
	 */
	public ClothingSlot [] getSlots () {
		return slots;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4570 $";
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result) + id;
		return result;
	}
	
	/**
	 * @param newID set the ID
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}
	
	/**
	 * @param newName the name to set
	 */
	public void setName (final String newName) {
		name = newName;
		changed ();
	}
	
	/**
	 * Sets the slots that this item type uses
	 * 
	 * @param slots WRITEME 
	 */
	public void setSlots (final ClothingSlot... slots) {
		this.slots = slots;
	}
	
	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#toString()
	 */
	@Override
	public String toString () {
		return "#" + id + "=" + name;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param slot WRITEME 
	 * @return WRITEME 
	 */
	public boolean usesSlot (final ClothingSlot slot) {
		boolean result = false;
		for (final ClothingSlot itemSlot : slots) {
			result |= itemSlot == slot;
		}
		return result;
	}
}
