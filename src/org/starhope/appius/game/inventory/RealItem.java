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
package org.starhope.appius.game.inventory;

import java.util.Collections;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.net.datagram.ADPItem;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.appius.util.WeakRecord;

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
public class RealItem extends SimpleDataRecord <RealItem> {
	
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
	public enum DatagramFormat {
		Count, Desc, InventoryItemType, ItemID, Rarity, RealID, Title;
	}
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = 7677578643617464028L;
	
	/**
	 * Map of the attributes
	 */
	final Map <String, String> attributes = Collections
			.synchronizedMap (new HashMap <String, String> ());
	
	/**
	 * Weak reference to the base item that is this item's template
	 */
	private WeakRecord <GenericItemReference> baseItem = null;
	
	/**
	 * The item ID of the generic base for this item
	 */
	private int itemID = -1;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Power itemPowers = null;
	
	/**
	 * The real/instance ID of this item
	 */
	private int realID = -1;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 */
	public RealItem () {
		super (RealItem.class);
	}
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param loader WRITEME 
	 */
	public RealItem (final RecordLoader <RealItem> loader) {
		super (loader);
	}
	
	/**
	 * Clears all attributes
	 */
	public void clearAttributes () {
		attributes.clear ();
	}
	
	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass () != obj.getClass ()) {
			return false;
		}
		final RealItem other = (RealItem) obj;
		if (realID != other.realID) {
			return false;
		}
		return true;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param attribute WRITEME 
	 * @return WRITEME 
	 */
	public String getAttribute (final String attribute) {
		return attributes.get (attribute);
	}
	
	/**
	 * Gets all the attributes
	 * 
	 * @return WRITEME 
	 */
	public Map <String, String> getAttributes () {
		synchronized (attributes) {
			return new HashMap <String, String> (attributes);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return realID;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return Integer.toString (realID);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param source WRITEME 
	 * @param format WRITEME 
	 * @return WRITEME 
	 */
	public ADPItem getDatagram (final ChannelListener source,
			final EnumSet <DatagramFormat> format) {
		final ADPItem adpItem = new ADPItem (source);
		
		if (format.contains (DatagramFormat.ItemID)) {
			adpItem.setItemID (getItemID ());
		}
		if (format.contains (DatagramFormat.RealID)) {
			adpItem.setRealID (getRealID ());
		}
		if (format.contains (DatagramFormat.InventoryItemType)) {
			adpItem.setInventoryItemType (getItemReference ()
					.getInventoryItemType ());
		}
		if (format.contains (DatagramFormat.Title)) {
			adpItem.setTitle (getItemReference ().getTitle ());
		}
		if (format.contains (DatagramFormat.Rarity)) {
			adpItem.setRarity (getItemReference ().getRarity ());
		}
		if (format.contains (DatagramFormat.Desc)) {
			adpItem.setDescription (getItemReference ()
					.getDescription ());
		}
		
		return adpItem;
	}
	
	/**
	 * @return the itemID
	 */
	public int getItemID () {
		return itemID;
	}
	
	/**
	 * @return the itemPowers
	 */
	public Power getItemPowers () {
		return itemPowers;
	}
	
	/**
	 * Gets the base item
	 * 
	 * @return WRITEME 
	 */
	public GenericItemReference getItemReference () {
		if ( (baseItem == null) && (itemID != -1)) {
			baseItem = new WeakRecord <GenericItemReference> (
					GenericItemReference.class, itemID);
		}
		return baseItem != null ? baseItem.get () : null;
	}
	
	/**
	 * @return the itemID
	 */
	public int getRealID () {
		return realID;
	}
	
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param attribute WRITEME 
	 * @return WRITEME 
	 */
	public boolean hasAttribute (final String attribute) {
		return attributes.containsKey (attribute);
	}
	
	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result) + realID;
		return result;
	}
	
	/**
	 * Returns true if the item has equip type powers
	 * 
	 * @return WRITEME 
	 */
	public boolean hasItemPowers () {
		return itemPowers != null;
	}
	
	/**
	 * Returns true if the item has on use type powers
	 * 
	 * @return WRITEME 
	 */
	public boolean hasUsePowers () {
		return (itemPowers != null)
				&& (itemPowers instanceof TempPower.Factory);
	}
	
	/**
	 * Sets an attribute
	 * 
	 * @param attribute WRITEME 
	 * @param value WRITEME 
	 */
	public void setAttribute (final String attribute,
			final String value) {
		final String oldValue = attributes.put (attribute, value);
		if (oldValue != value) {
			if ( !isBeingLoaded ()) {
				RealItem.log.debug (
						"Real Item #{} attribute changed to {}",
						realID, value);
			}
			changed ();
		}
	}
	
	/**
	 * Sets attributes based on a map of attribute pairs
	 * 
	 * @param attributes WRITEME 
	 */
	public void setAttributes (final Map <String, String> attributes) {
		this.attributes.putAll (attributes);
	}
	
	/**
	 * @param itemID the itemID to set
	 */
	public void setItemID (final int itemID) {
		this.itemID = itemID;
		baseItem = new WeakRecord <GenericItemReference> (
				GenericItemReference.class, itemID);
		if ( !isBeingLoaded ()) {
			RealItem.log.debug (
					"Real Item #{} item ID changed to {}", realID,
					itemID);
		}
		changed ();
	}
	
	/**
	 * @param itemPowers the itemPowers to set
	 */
	public void setItemPowers (final Power itemPowers) {
		this.itemPowers = itemPowers;
	}
	
	/**
	 * @param realID the realID to set
	 */
	public void setRealID (final int realID) {
		this.realID = realID;
	}
	
	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#toString()
	 */
	@Override
	public String toString () {
		return super.toString () + Integer.toString (realID);
	}
	
}
