/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.ConcurrentSkipListSet;

import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.physica.Geometry;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.AvatarClass;
import org.starhope.util.types.Pair;

/**
 * <p>
 * The ItemManager handles side-effects of equipping and removing items
 * for an user.
 * </p>
 * <p>
 * There are two main purposes to the inventory management performed in
 * this class:
 * </p>
 * <ul>
 * <li>Handle effects of ACTIVE or PASSIVE items being
 * equipped/de-equipped</li>
 * <li>Handle conflicts between items, for various reasons</li>
 * </ul>
 * <p>
 * The effects of items can be bridged through scripted event handlers,
 * which might be specific to a given generic item type, which is
 * typically the effect of an ACTIVE item. ACTIVE effect items will
 * respond to a given user interface demand (e.g. “press the (A) button”
 * or “click on a target”) specific to their equipment type. For
 * example, a player might have melée weapons and ranged weapons which
 * respond to their (A) and (B) buttons. The equipment reaction slots
 * for those items are simply (A) and (B). The items which respond,
 * however, might actually mount in various equipment slots. A ranged
 * weapon might be in the “Hat” slot, and the player might have a melée
 * weapon in each of the “LeftHand” and “RightHand” slots. In this case,
 * the action handling for the items will have to run together,
 * presuming that there is no conflict in mounting them.
 * </p>
 * <p>
 * PASSIVE items will typically have ongoing status effects, but may
 * also register scripted event hooks. For example, magic shoes might
 * simultaneously grant the player access to the verb “Skipping,” as a
 * basic movement action, but they also might increase the player's
 * “Karma” statistic at the same time.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class ItemManager {
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param u WRITEME
	 * @return WRITEME
	 * @throws NotFoundException if the user can't get an ItemManager
	 *              (not ready, usually)
	 */
	public static ItemManager get (final AbstractUser u)
			throws NotFoundException {
		if (null == u) {
			throw new NotFoundException ("null");
		}
		return ItemManager.get (u, u.getAvatarClass (),
				u.getInventory ());
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param user owner
	 * @param avatarClass WRITEME
	 * @param inventory WRITEME
	 * @return WRITEME
	 */
	public static ItemManager get (final AbstractUser user,
			final AvatarClass avatarClass, final Inventory inventory) {
		return new ItemManager (user, avatarClass, inventory);
	}
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final AvatarClass avatar;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final Inventory inv;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final AbstractUser owner;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param user owner
	 * @param avatarClass WRITEME
	 * @param inventory WRITEME
	 */
	public ItemManager (final AbstractUser user,
			final AvatarClass avatarClass, final Inventory inventory) {
		avatar = avatarClass;
		inv = inventory;
		owner = user;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param item WRITEME
	 */
	private void addEffects (final InventoryItem item) {
		if (EquipType.SILENT == item.getGenericItem ()
				.getEquipType ()) {
			return;
		}
		try {
			item.getItemEffects ().onEquip ();
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a NotFoundException in ItemManager.addEffects ",
							e);
		}
	}
	
	/**
	 * @return the avatar
	 */
	public AvatarClass getAvatarClass () {
		return avatar; /* TODO brpocock@star-hope.org */
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param item WRITEME
	 * @return WRITEME
	 * @throws AlreadyUsedException if conflicts can't be determined
	 *              because the item couldn't be equipped due to slot
	 *              or valence restrictions
	 */
	public Collection <InventoryItem> getConflicts (
			final InventoryItem item) throws AlreadyUsedException {
		final HashSet <InventoryItem> conflicts = new HashSet <InventoryItem> ();
		conflicts.addAll (getSlotConflicts (item));
		conflicts.addAll (getItemConflicts (item));
		conflicts.remove (item);
		return conflicts;
	}
	
	/**
	 * @return the inventory
	 */
	public Inventory getInventory () {
		return inv;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param item WRITEME
	 * @return WRITEME
	 * @throws AlreadyUsedException if the item can't be equipped due
	 *              to lack of a slot on the avatar for items of this
	 *              type
	 */
	private Collection <InventoryItem> getItemConflicts (
			final InventoryItem item) throws AlreadyUsedException {
		final HashSet <InventoryItem> conflicts = new HashSet <InventoryItem> ();
		final GenericItemReference itemClass = item.getGenericItem ();
		
		if ( !avatar.getBodyFormat ().canEquip (
				itemClass.getInventoryItemType ())) {
			throw new AlreadyUsedException (0);
		}
		
		for (final InventoryItem equipped : getInventory ()
				.getEquippedItems (true)) {
			try {
				if (equipped.getItemEffects ().conflicts (
						itemClass, item)) {
					conflicts.add (equipped);
				}
			} catch (final NotFoundException e) {
				// No op.
			}
		}
		return conflicts;
	}
	
	/**
	 * @return the owner
	 */
	public AbstractUser getOwner () {
		return owner;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param item WRITEME
	 * @return WRITEME
	 * @throws AlreadyUsedException if there is not a slot or valence
	 *              free for this item at all
	 */
	private Collection <InventoryItem> getSlotConflicts (
			final InventoryItem item) throws AlreadyUsedException {
		final InventoryItemType itemType = item.getGenericItem ()
				.getInventoryItemType ();
		if (itemType.hasValences ()) {
			final Set <Pair <Integer, Integer>> valences = itemType
					.getValences ();
			int maxAtValence = 0;
			for (final Pair <Integer, Integer> valence : valences) {
				if (valence.head ().equals (
						Integer.valueOf ((int) item.getZ ()))) {
					maxAtValence = valence.tail ().intValue ();
				}
			}
			if (1 > maxAtValence) {
				throw new AlreadyUsedException (0);
			}
			final Collection <InventoryItem> conflicts = new ConcurrentSkipListSet <InventoryItem> ();
			conflicts.addAll (getInventory ().getItemsByType (
					itemType));
			for (final InventoryItem inSlot : conflicts) {
				if ((int) inSlot.getZ () != (int) item.getZ ()) {
					conflicts.remove (inSlot);
				} else {
					if (maxAtValence > 1) {
						conflicts.remove (inSlot);
						--maxAtValence;
					}
				}
			}
			return conflicts;
		}
		// No valences, no problems
		return new HashSet <InventoryItem> ();
	}
	
	/**
	 * Acknowledge that an item has been de-equipped, and its status
	 * effects should be removed, and also remove any items that
	 * require this one to be equipped. If this routine returns
	 * “false,” then it is impossible to resolve conflicts, and the
	 * item must not be de-equipped.
	 * 
	 * @param item the item being de-equipped
	 * @return true, if the item can be de-equipped.
	 */
	public boolean noteDeEquip (final InventoryItem item) {
		// TODO Incomplete
		if (EquipType.SILENT == item.getGenericItem ()
				.getEquipType ()) {
			return true;
		}
		try {
			item.getItemEffects ().onDeEquip ();
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a NotFoundException in ItemManager.addEffects ",
							e);
		}
		return true;
	}
	
	/**
	 * Acknowledge that an item has been equipped, and its status
	 * effects should be applied, and conflicting items removed. If
	 * this routine returns “false,” then it is impossible to resolve
	 * conflicts, and the item must not be equipped.
	 * 
	 * @param item the item being equipped
	 * @return true, if the item is permitted to be equipped.
	 */
	public boolean noteEquip (final InventoryItem item) {
		Collection <InventoryItem> conflicts;
		try {
			conflicts = getConflicts (item);
		} catch (final AlreadyUsedException e) {
			return false; // this item cannot be equipped, regardless
		}
		for (final InventoryItem badItem : conflicts) {
			getInventory ().doff (badItem);
		}
		addEffects (item);
		return true; // OK to proceed
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param slot WRITEME
	 * @param targetName WRITEME
	 * @param targetCoords WRITEME
	 */
	public void useEquipment (final char slot,
			final String targetName, final Coord3D targetCoords) {
		Geometry.updateUserPositioning (owner);
		for (final InventoryItem item : inv.getEquippedItems (false)) {
			if (item.getGenericItem ().getEquipSlot () == slot) {
				try {
					item.getItemEffects ().use (owner, targetName,
							targetCoords);
					return;
				} catch (final NotFoundException e) {
					// No op
				}
			}
		}
	}
	
}
