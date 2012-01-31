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
 * General Public License for more details.
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
package org.starhope.appius.game.inventory;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.util.HasSubversionRevision;

/**
 * WRITEME: Document this type.
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
public class ClothingSlot extends SimpleDataRecord <ClothingSlot>
		implements HasSubversionRevision {
	
	/**
	 * WRITEME: Document this field brpocock
	 */
	private static final long serialVersionUID = 7258857028344925792L;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int maxEquipable;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String name;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int slotID;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 */
	public ClothingSlot () {
		super (ClothingSlot.class);
	}
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param loader WRITEME 
	 */
	public ClothingSlot (final RecordLoader <ClothingSlot> loader) {
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
		if ( ! (obj instanceof ClothingSlot)) {
			return false;
		}
		final ClothingSlot other = (ClothingSlot) obj;
		if (slotID != other.slotID) {
			return false;
		}
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return slotID;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return Integer.toString (slotID);
	}
	
	/**
	 * @return the maxEquipable
	 */
	public int getMaxEquipable () {
		return maxEquipable;
	}
	
	/**
	 * @return the name
	 */
	public String getName () {
		return name;
	}
	
	/**
	 * @return the slotID
	 */
	public int getSlotID () {
		return slotID;
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
		result = (prime * result) + slotID;
		return result;
	}
	
	/**
	 * @param newMax the maxEquipable to set
	 */
	public void setMaxEquipable (final int newMax) {
		maxEquipable = newMax;
	}
	
	/**
	 * @param newName the name to set
	 */
	public void setName (final String newName) {
		name = newName;
	}
	
	/**
	 * @param newSlotID the slotID to set
	 */
	public void setSlotID (final int newSlotID) {
		slotID = newSlotID;
	}
	
}
