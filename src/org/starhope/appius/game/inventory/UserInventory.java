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

import java.lang.ref.WeakReference;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.starhope.appius.except.NonSufficientItemsException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.net.datagram.ADPEquipment;
import org.starhope.appius.net.datagram.ADPInventory;
import org.starhope.appius.net.datagram.ADPItemUpdate;
import org.starhope.appius.net.datagram.ADPPower;
import org.starhope.appius.net.datagram.ADPPowers;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.UserPowerKeeper;
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
public class UserInventory extends SimpleDataRecord <UserInventory>
		implements HasSubversionRevision {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = 2856716727681831695L;
	
	/**
	 * Which powers are registered to what click power slots
	 */
	private final Map <ClickPowerSlots, RealItem> clickPowerSlots = new HashMap <ClickPower.ClickPowerSlots, RealItem> ();
	
	/**
	 * Which items are equipped in what slots
	 */
	private final Map <ClothingSlot, LinkedList <RealItem>> equippedItems = Collections
			.synchronizedMap (new HashMap <ClothingSlot, LinkedList <RealItem>> ());
	
	/**
	 * The list of all equipped items with powers
	 */
	private final Map <RealItem, InventoryPowerController> equippedPowers = new HashMap <RealItem, InventoryPowerController> ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final LinkedList <RealItem> forcedEquipment = new LinkedList <RealItem> ();
	
	/**
	 * Which items are in the inventory and how many they have
	 */
	private final Map <RealItem, Integer> items = Collections
			.synchronizedMap (new HashMap <RealItem, Integer> ());
	
	/**
	 * A set of all items that have been modified since last save
	 */
	private final Set <RealItem> modifiedItems = Collections
			.synchronizedSet (new HashSet <RealItem> ());
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final LinkedList <RealItem> removedEquipment = new LinkedList <RealItem> ();
	
	/**
	 * Weak references to the owning user
	 */
	private WeakReference <AbstractUser> user = new WeakReference <AbstractUser> (
			null);
	
	/**
	 * User ID of the user that owns this inventory
	 */
	private int userID = -1;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 */
	public UserInventory () {
		super (UserInventory.class);
	}
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param loader WRITEME 
	 */
	public UserInventory (final RecordLoader <UserInventory> loader) {
		super (loader);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param realID WRITEME 
	 * @param count WRITEME 
	 */
	public void addItem (final int realID, final int count) {
		try {
			addItem (Nomenclator.getDataRecord (RealItem.class,
					realID), count);
		} catch (final NotFoundException e) {
			UserInventory.log.error ("Exception", e);
		}
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param item WRITEME 
	 * @param count WRITEME 
	 */
	public void addItem (final RealItem item, final int count) {
		final Integer amount = new Integer (getCount (item) + count);
		items.put (item, amount);
		modifiedItems.add (item);
		changed ();
		if (amount.intValue () < 1) {
			unequip (item);
			if ( (getUser ().getRoom () != null)
					&& (getUser ().getRoom ().getRoomChannel () != null)) {
				getUser ().getRoom ()
						.getRoomChannel ()
						.broadcast (
								getEquipmentDatagram (getUser ()
										.getRoom ()),
								getUser ());
			}
			getUser ().acceptDatagram (
					getEquipmentDatagram (getUser ()));
		}
		final ADPItemUpdate adpItemUpdate = new ADPItemUpdate (
				getUser ());
		adpItemUpdate.addItem (item, getCount (item));
		getUser ().acceptDatagram (adpItemUpdate);
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
		final UserInventory other = (UserInventory) obj;
		if (userID != other.userID) {
			return false;
		}
		return true;
	}
	
	/**
	 * Attempts to equip the given item
	 * 
	 * @param item WRITEME 
	 * @return True if the powers for the user changed as a result of
	 *         this equip change
	 * @throws NotFoundException
	 * @throws NonSufficientItemsException
	 */
	public boolean equip (final RealItem item)
			throws NonSufficientItemsException {
		boolean forceFullUserUpdate = false;
		if (getCount (item) < 1) {
			throw new NonSufficientItemsException (
					item.getRealID (), 1, getCount (item));
		}
		
		if (item.hasUsePowers ()) {
			addItem (item, -1);
			final Power power = item.getItemPowers ();
			if (power instanceof TempPower.Factory) {
				UserPowerKeeper.instance ().addPower (getUser (),
						item.getRealID (),
						(TempPower.Factory) power);
			}
			forceFullUserUpdate = true;
		} else {
			synchronized (equippedItems) {
				// Check for clothing slot conflicts and unequip
				// anything necessary to equip this item
				for (final ClothingSlot slot : item
						.getItemReference ()
						.getInventoryItemType ().getSlots ()) {
					LinkedList <RealItem> slotItems = equippedItems
							.get (slot);
					if (slotItems == null) {
						slotItems = new LinkedList <RealItem> ();
						equippedItems.put (slot, slotItems);
					}
					if ( !slotItems.contains (item)) {
						slotItems.add (item);
					}
					while (slotItems.size () > slot
							.getMaxEquipable ()) {
						final RealItem oldItem = slotItems
								.peekFirst ();
						if (oldItem != null) {
							forceFullUserUpdate |= unequip (oldItem);
						}
					}
				}
				// Check for item powers and unequip anything that
				// conflicts
				if (item.hasItemPowers ()) {
					final Power itemPower = item.getItemPowers ();
					if (itemPower != null) {
						equippedPowers.put (item,
								new InventoryPowerController (
										itemPower, this));
						final ClickPower clickPower = itemPower instanceof ClickPower ? (ClickPower) itemPower
								: null;
						if (clickPower != null) {
							final ClickPowerSlots slot = clickPower
									.usesSlot ();
							if (clickPowerSlots
									.containsKey (slot)) {
								final RealItem oldItem = clickPowerSlots
										.get (slot);
								unequip (oldItem);
							}
							clickPowerSlots.put (slot, item);
						}
						forceFullUserUpdate = true;
					}
				}
			}
			changed ();
		}
		
		return forceFullUserUpdate;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param item WRITEME 
	 * @return WRITEME 
	 * @throws NonSufficientItemsException
	 */
	public boolean equipForce (final RealItem item)
			throws NonSufficientItemsException {
		if (equip (item)) {
			forcedEquipment.add (item);
			return true;
		}
		return false;
	}
	
	/**
	 * Gets the list of modified items and clears them from the
	 * modified list
	 * 
	 * @return WRITEME 
	 */
	Map <RealItem, Integer> getAndClearModifiedItems () {
		final Map <RealItem, Integer> result = new HashMap <RealItem, Integer> ();
		synchronized (items) {
			for (final RealItem item : modifiedItems) {
				result.put (item, Integer.valueOf (getCount (item)));
			}
			modifiedItems.clear ();
		}
		return result;
	}
	
	/**
	 * Gets a set of the items that have been unequipped since last
	 * save and clears it to empty
	 * 
	 * @return WRITEME 
	 */
	Set <RealItem> getAndClearUnequippedItems () {
		synchronized (equippedItems) {
			final Set <RealItem> result = new HashSet <RealItem> ();
			while (removedEquipment.size () > 0) {
				result.add (removedEquipment.removeFirst ());
			}
			return result;
		}
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return userID;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return Integer.toString (userID);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param realItemID WRITEME 
	 * @return WRITEME 
	 */
	public int getCount (final int realItemID) {
		RealItem item = null;
		try {
			item = Nomenclator.getDataRecord (RealItem.class,
					realItemID);
		} catch (final NotFoundException e) {
			UserInventory.log.error ("Exception", e);
		}
		return item != null ? getCount (item) : 0;
	}
	
	/**
	 * Gets the current count of items of this kind in the inventory
	 * Always returns 0 if the item is not in inventory
	 * 
	 * @param invItem WRITEME 
	 * @return WRITEME 
	 */
	public int getCount (final RealItem invItem) {
		return items.containsKey (invItem) ? items.get (invItem)
				.intValue () : 0;
	}
	
	/**
	 * Gets the equipped items datagram
	 * 
	 * @param s WRITEME 
	 * @param itemTypes WRITEME 
	 * @return WRITEME 
	 */
	public ADPEquipment getEquipmentDatagram (final ChannelListener s,
			final InventoryItemType... itemTypes) {
		final ADPEquipment result = new ADPEquipment (s);
		final List <InventoryItemType> validTypes = Arrays
				.asList (itemTypes);
		synchronized (equippedItems) {
			for (final RealItem realItem : getEquippedItems ()) {
				if ( (validTypes.size () < 1)
						|| validTypes.contains (realItem
								.getItemReference ()
								.getInventoryItemType ())) {
					result.addItem (realItem);
				}
			}
		}
		if (getUser () != s) {
			result.setUser (getUser ());
		}
		return result;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	public Set <RealItem> getEquippedItems () {
		final HashSet <RealItem> result = new HashSet <RealItem> ();
		synchronized (equippedItems) {
			for (final Entry <ClothingSlot, LinkedList <RealItem>> entry : equippedItems
					.entrySet ()) {
				final LinkedList <RealItem> itemList = entry
						.getValue ();
				for (final RealItem realItem : itemList) {
					result.add (realItem);
				}
			}
		}
		return result;
	}
	
	/**
	 * Gets the height scalar applying power effects
	 * 
	 * @return WRITEME 
	 */
	public double getHeightScalar () {
		double scalar = 0;
		synchronized (equippedItems) {
			for (final Entry <RealItem, InventoryPowerController> entry : equippedPowers
					.entrySet ()) {
				final HeightPower power = entry.getKey ()
						.getItemPowers () instanceof HeightPower ? (HeightPower) entry
						.getKey ().getItemPowers () : null;
				if (power != null) {
					scalar += power.getHeightScalar ();
				}
			}
		}
		return scalar;
	}
	
	/**
	 * Gets the inventory datagram
	 * 
	 * @param s WRITEME 
	 * @param itemTypes WRITEME 
	 * @return WRITEME 
	 */
	public ADPInventory getInventoryDatagram (final ChannelListener s,
			final InventoryItemType... itemTypes) {
		final ADPInventory result = new ADPInventory (s);
		final List <InventoryItemType> validTypes = Arrays
				.asList (itemTypes);
		synchronized (items) {
			for (final Entry <RealItem, Integer> entry : items
					.entrySet ()) {
				if ( ( (validTypes.size () < 1) || validTypes
						.contains (entry.getKey ()
								.getItemReference ()
								.getInventoryItemType ()))
						&& (getCount (entry.getKey ()) > 0)) {
					result.addItem (entry.getKey (),
							entry.getValue ());
				}
			}
		}
		if (getUser () != s) {
			result.setUser (getUser ());
		}
		return result;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	public Map <RealItem, Integer> getItems () {
		synchronized (items) {
			return new HashMap <RealItem, Integer> (items);
		}
	}
	
	/**
	 * Gets a datagram for the powers on this user
	 * 
	 * @param s WRITEME 
	 * @return WRITEME 
	 */
	public ADPPowers getPowersDatagram (final ChannelListener s) {
		final ADPPowers powers = new ADPPowers (s);
		synchronized (equippedItems) {
			for (final Entry <RealItem, InventoryPowerController> entry : equippedPowers
					.entrySet ()) {
				final Power power = entry.getValue ().getPower ();
				if (power instanceof EquipPower) {
					powers.add ((EquipPower) power);
				}
				if (power instanceof ClickPower) {
					final ClickPower clickPower = (ClickPower) power;
					if (clickPower.projectileUsesAmmo ()) {
						powers.add (clickPower, entry.getValue ());
					}
				}
			}
		}
		for (final TempPower power : UserPowerKeeper.instance ()
				.getPowers (getUser ())) {
			powers.add (power);
		}
		
		return powers;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	public double getSpeedScalar () {
		double scalar = 0;
		synchronized (equippedItems) {
			for (final Entry <RealItem, InventoryPowerController> entry : equippedPowers
					.entrySet ()) {
				final SpeedPower equipPower = entry.getValue ()
						.getPower () instanceof SpeedPower ? (SpeedPower) entry
						.getValue ().getPower () : null;
				if (equipPower != null) {
					scalar += equipPower.getSpeedScalar ();
				}
			}
		}
		return scalar;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}
	
	/**
	 * Gets the user for this inventory
	 * 
	 * @return WRITEME 
	 */
	public AbstractUser getUser () {
		AbstractUser result = user.get ();
		if (result == null) {
			user = new WeakReference <AbstractUser> (
					Nomenclator.getUserByID (userID));
			result = user.get ();
		}
		return result;
	}
	
	/**
	 * @return the userID
	 */
	public int getUserID () {
		return userID;
	}
	
	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result) + userID;
		return result;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param invItem WRITEME 
	 * @return WRITEME 
	 */
	public boolean isEquipped (final RealItem invItem) {
		return equippedItems.containsValue (invItem);
	}
	
	/**
	 * WRITEME: Document this method brpocock
	 */
	public void notifyEquipChange () {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method notifyEquipChange in UserInventory, added Jan 31, 2012 by brpocock. TODO.");
		
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param item WRITEME 
	 * @param count WRITEME 
	 */
	void setItem (final RealItem item, final int count) {
		items.put (item, new Integer (count));
	}
	
	/**
	 * @param userID the userID to set
	 */
	public void setUserID (final int userID) {
		this.userID = userID;
		user = new WeakReference <AbstractUser> (null);
	}
	
	/**
	 * Performs a trigger event
	 * 
	 * @param clickedOn What in the world was clicked on
	 * @param target Where in the world the click happened
	 * @param shift If shift was being held
	 * @param ctrl If control was being held
	 * @param alt If alt was being held
	 * @return Returns true if something was triggered
	 */
	public boolean triggerClick (final String clickedOn,
			final Coord2D target, final boolean shift,
			final boolean ctrl, final boolean alt) {
		final boolean result = false;
		final RealItem realItem = shift ? alt ? ctrl ? clickPowerSlots
				.get (ClickPowerSlots.ctrlAltShiftClick)
				: clickPowerSlots
						.get (ClickPowerSlots.altShiftClick)
				: ctrl ? clickPowerSlots
						.get (ClickPowerSlots.ctrlShiftClick)
						: clickPowerSlots
								.get (ClickPowerSlots.shiftClick)
				: alt ? ctrl ? clickPowerSlots
						.get (ClickPowerSlots.ctrlAltClick)
						: clickPowerSlots
								.get (ClickPowerSlots.altClick)
						: ctrl ? clickPowerSlots
								.get (ClickPowerSlots.ctrlClick)
								: null;
		if (realItem != null) {
			synchronized (equippedItems) {
				final Power power = equippedPowers.get (realItem)
						.getPower ();
				final ClickPower clickPower = (power != null)
						&& (power instanceof ClickPower) ? (ClickPower) power
						: null;
				final PowerController powerController = equippedPowers
						.get (realItem);
				if ( (power != null) && (clickPower != null)
						&& (powerController != null)) {
					clickPower.onClick (powerController,
							clickedOn, target.getX (),
							target.getY ());
					if (clickPower.projectileUsesAmmo ()) {
						final ADPPower adpPower = new ADPPower (
								getUser ());
						adpPower.setID (power.getID ());
						adpPower.setIcon (clickPower.getIcon ());
						adpPower.setCount (clickPower
								.projectileAmmoCount (powerController));
						getUser ().acceptDatagram (adpPower);
					}
				}
			}
		}
		return result;
	}
	
	/**
	 * Unequips an item
	 * 
	 * @param item WRITEME 
	 * @return True if the powers for the user changed as a result of
	 *         this equip change
	 */
	public boolean unequip (final RealItem item) {
		boolean forceFullUserUpdate = false;
		synchronized (equippedItems) {
			for (final ClothingSlot slot : equippedItems.keySet ()) {
				LinkedList <RealItem> slotItems = equippedItems
						.get (slot);
				if (slotItems == null) {
					slotItems = new LinkedList <RealItem> ();
					equippedItems.put (slot, slotItems);
				}
				if (slotItems.contains (item)) {
					slotItems.remove (item);
					removedEquipment.add (item);
				}
			}
			if (equippedPowers.containsKey (item)) {
				equippedPowers.remove (item);
				final ClickPower itemClickPowers = item
						.getItemPowers () instanceof ClickPower ? (ClickPower) item
						.getItemPowers () : null;
				final ClickPowerSlots slot = itemClickPowers != null ? itemClickPowers
						.usesSlot () : null;
				if (slot != null) {
					clickPowerSlots.remove (slot);
				}
				forceFullUserUpdate = true;
			}
		}
		changed ();
		return forceFullUserUpdate;
	}
	
}
