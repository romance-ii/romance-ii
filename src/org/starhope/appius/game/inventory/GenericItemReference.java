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
package org.starhope.appius.game.inventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Commands;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.util.LibMisc;

/**
 * <p>
 * This represents an abstract/template item found in a store.
 * </p>
 * <p>
 * XXX Some day, the pricing information needs to be isolated in the
 * shopping stores, and eliminate the Tootsville™-style default logic of
 * all items having only one canonical price. The NPC storekeepers and
 * such should set up the pricing and handle the trading, without having
 * prices hard-coded universally for all instances of a given item.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class GenericItemReference extends
		SimpleDataRecord <GenericItemReference> implements
		AbstractItem {
	
	/**
	 * Java serialization UID
	 */
	private static final long serialVersionUID = 1330548723192564366L;
	
	/**
	 * XXX: contains SQL
	 * 
	 * @return the maximum ID for an item
	 */
	private static int getMaxID () {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT MAX(ID) FROM items");
			rs = st.executeQuery ();
			rs.next ();
			return rs.getInt (1);
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return 0;
	}
	
	/**
	 * @param minRarity the minimum rarity of an item to be chosen
	 * @param maxRarity the maximum rarity of an item to be chosen
	 * @return a random item with a rarity within that range
	 * @throws NotFoundException
	 */
	public static GenericItemReference getRandomItem (
			final RarityRating minRarity,
			final RarityRating maxRarity) throws NotFoundException {
		GenericItemReference item = null;
		final int maxID = GenericItemReference.getMaxID ();
		int termination = -maxID << 1;
		do {
			try {
				/*
				 * try random numbers for a long time. if that
				 * fails, fall back on iterating through the set of
				 * all items.
				 */
				final int take = termination++ <= 0 ? AppiusConfig
						.getRandomInt (1, maxID) : termination;
				item = Nomenclator.getDataRecord (
						GenericItemReference.class, take);
				if ( (item.getRarity ().compareTo (minRarity) < 0)
						|| (item.getRarity ().compareTo (
								maxRarity) > 0)) {
					item = null;
				}
			} catch (final NotFoundException e) {
				// no op. item will still be null.
			}
			if (termination > maxID) {
				throw new NotFoundException (
						"There are no items in range ("
								+ minRarity.getValue () + ".."
								+ maxRarity.getValue () + ")");
			}
		} while (null == item);
		return item;
	}
	
	/**
	 * Whether this item can be traded, dropped, or given away. If this
	 * is false, then the item is stuck forever in inventory (barring
	 * NPC actions or similar) once it has been lodged there.
	 */
	private boolean canTrade = false;
	
	/**
	 * the currency units for the price
	 */
	private Currency currency;
	
	/**
	 * user-visible description
	 */
	private String description;
	
	/**
	 * The ID of the {@link ItemEffectsType} to determine the
	 * {@link ItemEffects} for this item.
	 */
	private int effectsTypeID = -1;
	
	/**
	 * The effects slot for this item. See discussion at
	 * {@link GenericItemReference#setEquipSlot(char)}
	 */
	private char equipSlot;
	
	/**
	 * <p>
	 * Whether this item is an equippable item which traps a specific
	 * class of events is indicated by this field.
	 * </p>
	 */
	private EquipType equipType = EquipType.SILENT;
	
	/**
	 * Health interpretation is determined by this enumeration type.
	 */
	private HealthType healthType = HealthType.SILENT;
	
	/**
	 * unique database ID
	 */
	private int itemID;
	
	/**
	 * the general class or slot of items to which this belongs. Used
	 * principally for equipping items into particular slots and
	 * displaying inventory listings.
	 */
	private InventoryItemType itemType;
	
	/**
	 * price in currency units
	 */
	private long price = 0L;
	
	/**
	 * how rare is this item when items are randomly given out
	 */
	private RarityRating rarity;
	
	/**
	 * user-visible title
	 */
	private String title;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param loader WRITEME
	 */
	public GenericItemReference (
			final RecordLoader <GenericItemReference> loader) {
		super (loader);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public boolean canTrade () {
		return canTrade;
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
		if ( ! (obj instanceof GenericItemReference)) {
			return false;
		}
		final GenericItemReference other = (GenericItemReference) obj;
		if (itemID != other.itemID) {
			return false;
		}
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return itemID;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () {
		return title;
	}
	
	/**
	 * @see org.starhope.appius.game.inventory.AbstractItem#getCurrency()
	 */
	@Override
	public Currency getCurrency () {
		return currency;
	}
	
	/**
	 * @return the description of the item
	 * @see AbstractItem#getDescription()
	 */
	@Override
	public String getDescription () {
		if ( (null == description) || "".equals (description)) {
			return "(no description)";
		}
		return description;
	}
	
	/**
	 * @return the ID of the {@link ItemEffectsType} to determine the
	 *         {@link ItemEffects} for this item.
	 */
	public int getEffectsTypeID () {
		return effectsTypeID;
	}
	
	/**
	 * @return The effects slot for this item. See discussion at
	 *         {@link GenericItemReference#setEquipSlot(char)}
	 */
	public char getEquipSlot () {
		return equipSlot;
	}
	
	/**
	 * Get the type of events which this item, when equipped, provides;
	 * e.g. armour.
	 * 
	 * @return the equipment slot type
	 */
	public EquipType getEquipType () {
		return equipType;
	}
	
	/**
	 * Get the measurement type for interpreting this type of item's
	 * health indicator
	 * 
	 * @return the type of interpretation for this item's health
	 */
	public HealthType getHealthType () {
		return healthType;
	}
	
	/**
	 * @return the type of this item
	 */
	public InventoryItemType getInventoryItemType () {
		return itemType;
	}
	
	/**
	 * @return the item's ID
	 * @see AbstractItem#getItemID()
	 */
	@Override
	public int getItemID () {
		return itemID;
	}
	
	/**
	 * @return the item's price
	 * @see AbstractItem#getPrice()
	 */
	@Override
	public long getPrice () {
		return price;
	}
	
	/**
	 * @see org.starhope.appius.game.inventory.AbstractItem#getRarity()
	 */
	@Override
	public RarityRating getRarity () {
		return rarity;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * @return the title of the item
	 * @see AbstractItem#getTitle()
	 */
	@Override
	public String getTitle () {
		return title;
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result) + itemID;
		return result;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param equals WRITEME
	 */
	public void setCanTrade (final boolean equals) {
		canTrade = equals;
		changed ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param string WRITEME
	 */
	public void setDescription (final String string) {
		description = string;
		changed ();
	}
	
	/**
	 * set the {@link ItemEffects} class type ID pointer (via
	 * {@link ItemEffectsType} table indirection) for this item type.
	 * Note that if the item is currently set to return a
	 * {@link #getEquipType()} of {@link EquipType}
	 * {@link EquipType#SILENT}, setting a non-null handler will force
	 * it to {@link EquipType#PASSIVE}. Likewise, setting this to a -1
	 * (null) handler ID will revert to {@link EquipType#SILENT}.
	 * 
	 * @param newEffectsType the ID of the new {@link ItemEffectsType}
	 *             to be applied
	 * @return the new effects type ID
	 */
	public int setEffectsTypeID (final int newEffectsType) {
		if (effectsTypeID == newEffectsType) {
			return effectsTypeID;
		}
		if (0 > newEffectsType) {
			effectsTypeID = -1;
			setEquipType (EquipType.SILENT);
		} else {
			if (getEquipType () == EquipType.SILENT) {
				setEquipType (EquipType.PASSIVE);
			}
			effectsTypeID = newEffectsType;
		}
		changed ();
		return effectsTypeID;
	}
	
	/**
	 * <p>
	 * Set the slot into which a piece of equipment is mounted. If an
	 * equipment item has no effects (purely cosmetic), it mounts into
	 * equipment slot ' ' ({@link EquipType#SILENT}); if it has passive
	 * effects but does not consume user actions, it goes in slot '.' (
	 * {@link EquipType#PASSIVE}); if it consumes a user input action
	 * type of some kind, it goes into a slot which will typically be a
	 * single letter or digit. Punctuation marks are reserved for
	 * future globally reserved values, so please stick with 'A'..'Z' &
	 * '0'..'9' for game-specific purposes in defining such slots.
	 * </p>
	 * <p>
	 * Note that equipment slots are <em>not</em> the same as either
	 * inventory slots (see {@link InventoryItem#getSlotNumber()},
	 * which uniquely define a specific item instance throughout the
	 * game universe, nor are they the same as clothing/furniture item
	 * types ({@link InventoryItemType}), which are used to define
	 * slots and valences for clothing and equipment with regards to
	 * how and where it is held or mounted, and not what interface
	 * actions it consumes and/or alters.
	 * </p>
	 * <p>
	 * The
	 * {@link Commands#do_click(JSONObject, org.starhope.appius.user.AbstractUser, org.starhope.appius.game.Room)}
	 * handler will redirect events of the type Shift + Click to slot
	 * “1,” Control (Command) + Click to slot “2,“ and Alt (Option) +
	 * Click to slot “3.”
	 * 
	 * @param slot the slot into which this type of item is placed
	 *             (equpment slot)
	 * @return the slot into which this type of item is placed
	 *         (equipment slot)
	 */
	public char setEquipSlot (final char slot) {
		if (' ' == slot) {
			setEquipType (EquipType.SILENT);
		} else if ('.' == slot) {
			setEquipType (EquipType.PASSIVE);
		} else {
			setEquipType (EquipType.ACTIVE);
		}
		equipSlot = slot;
		changed ();
		return equipSlot;
	}
	
	/**
	 * Set the type of events which this item, when equipped, provides;
	 * e.g. armour (PASSIVE) or a tool (ACTIVE)
	 * 
	 * @param newEquipType the equipment slot type
	 * @return the new equipment slot type
	 */
	public EquipType setEquipType (final EquipType newEquipType) {
		equipType = newEquipType;
		return equipType;
	}
	
	/**
	 * Set the measurement type for interpreting this type of item's
	 * health indicator.
	 * 
	 * @param newHealthType The measurement type to be used to
	 *             interpret this type of item's health indicator.
	 * @return the new health type
	 */
	public HealthType setHealthType (final HealthType newHealthType) {
		healthType = newHealthType;
		return healthType;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param inventoryInventoryItemType WRITEME
	 */
	public void setInventoryItemType (
			final InventoryItemType inventoryInventoryItemType) {
		itemType = inventoryInventoryItemType;
		changed ();
	}
	
	/**
	 * @param newItemID the new item ID
	 * @see AbstractItem#setItemID(int)
	 */
	@Override
	public void setItemID (final int newItemID) {
		itemID = newItemID;
		changed ();
	}
	
	/**
	 * @param newPrice the new price
	 * @see AbstractItem#setPrice(Currency,java.math.BigDecimal)
	 */
	@Override
	public void setPrice (final Currency newCurrency,
			final long newPrice) {
		currency = newCurrency;
		price = newPrice;
		changed ();
	}
	
	/**
	 * @param newRarity the rarity to set
	 */
	public void setRarity (final RarityRating newRarity) {
		rarity = newRarity;
		changed ();
	}
	
	/**
	 * @param newTitle the new title
	 * @see AbstractItem#setTitle(java.lang.String)
	 */
	@Override
	public void setTitle (final String newTitle) {
		title = newTitle;
		changed ();
	}
	
	/**
	 * @see AbstractItem#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject self = new JSONObject ();
		try {
			self.put ("id", itemID);
			self.put ("title", title);
			self.put ("price", price);
			self.put ("currency", currency.getTitle ());
			self.put ("currCode", currency.getCode ());
			self.put ("currSym", currency.getSymbol ());
			self.put ("desc", description);
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		}
		return self;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return "Generic item “" + title + "” #" + itemID + " ("
				+ itemType.toString () + ")";
	}
	
}
