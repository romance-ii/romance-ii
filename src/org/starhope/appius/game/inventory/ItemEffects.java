/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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

import java.io.Serializable;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.UserStat;
import org.starhope.appius.user.events.Quaestor;

/**
 * <p>
 * This is the base class from which all item effects must be derived.
 * It provides neutral “no-op” handlers for all mandatory hooks and
 * fires script events through {@link Quaestor}.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class ItemEffects implements Serializable {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 9064210442668177278L;
	
	/**
	 * Get the ItemEffects subclass responsible for handling effects
	 * from a given item type
	 * 
	 * @param item the item for which to get the effects-handler object
	 * @return the ItemEffects subclass responsible for that item ID
	 * @throws NotFoundException if the item doesn't exist, doesn't
	 *              define an effects type, or the effects type handler
	 *              class can't be found or instantiated
	 */
	public static ItemEffects forItem (final RealItem item)
			throws NotFoundException {
		final int effectsTypeID = item.getItemReference ()
				.getEffectsTypeID ();
		if (effectsTypeID <= 0) {
			throw new NotFoundException ("No effects on this item");
		}
		return Nomenclator.getDataRecord (ItemEffectsType.class,
				effectsTypeID).getItemEffectsInstance (item);
		
	}
	
	/**
	 * The inventory item from which these effects are emitted
	 */
	protected final RealItem item;
	
	/**
	 * @param theItem the item from which these effects are emitted
	 */
	public ItemEffects (final RealItem theItem) {
		item = theItem;
	}
	
	/**
	 * Get the amount by which the item which bears this effect alters
	 * the supplied stat
	 * 
	 * @param stat the user stat to be altered
	 * @return the amount by which equipping this item alters the
	 *         user's stats
	 */
	public int alter (final UserStat stat) {
		return 0;
	}
	
	/**
	 * @return true, if this item somehow grants the bearer the ability
	 *         to swim (which can still be subject to e.g. skill
	 *         checks, later)
	 */
	public boolean canSwim () {
		return false;
	}
	
	/**
	 * <p>
	 * For the item which bears this effect, determine whether another
	 * item conflicts with it.
	 * </p>
	 * <p>
	 * Since this comparison is done against all equipped items, the
	 * {@link GenericItemReference} is provided simply as a
	 * convenience. This method <em>must</em> be called with the
	 * correct {@link GenericItemReference} that would be returned by
	 * calling {@link InventoryItem#getGenericItem()}, simply to save
	 * on calling that routine many times during the comparison of all
	 * items.
	 * </p>
	 * 
	 * @param itemClass the {@link GenericItemReference} of this the
	 *             item is an instance
	 * @param anItem the {@link InventoryItem} against which this item
	 *             is being considered
	 * @return true, if this item conflicts with the other (they cannot
	 *         be equipped together)
	 */
	public boolean conflicts (final GenericItemReference itemClass,
			final RealItem anItem) {
		return getItem ().getItemReference ().getEquipSlot () == anItem
				.getItemReference ().getEquipSlot ();
	}
	
	/**
	 * @return true, if this item is to be considered a vehicle
	 */
	public boolean considerAsVehicle () {
		return false;
	}
	
	/**
	 * @return the item
	 */
	public RealItem getItem () {
		return item;
	}
	
	/**
	 * @return true, if this is a vehicle that floats above the ground
	 *         in some way
	 */
	public boolean isFloatingVehicle () {
		return false;
	}
	
	/**
	 * @return true, if this is an animal mount (or similar, e.g.
	 *         steam-powered horse)
	 */
	public boolean isMountedAnimal () {
		return false;
	}
	
	/**
	 * @return true, if this is a wheeled vehicle (or similar, e.g.
	 *         skis)
	 */
	public boolean isWheeledVehicle () {
		return false;
	}
	
	/**
	 * WRITEME: Document this method brpocock
	 */
	public void onDeEquip () {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method onDeEquip in ItemEffects, added Jan 31, 2012 by brpocock. TODO.");
		
	}
	
	/**
	 * WRITEME: Document this method brpocock
	 */
	public void onEquip () {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method onEquip in ItemEffects, added Jan 31, 2012 by brpocock. TODO.");
		
	}
	
	/**
	 * The item is being used. The optional target name and/or target
	 * coördinates may be provided.
	 * 
	 * @param user the user using the item. (The item's owner.
	 *             Important for NPC's, as each instanced NPC will have
	 *             the same InventoryItem in the same Inventory in the
	 *             same UserRecord, but we still need to know “which of
	 *             him” fired.)
	 * @param targetName a named object in the room against which the
	 *             item is to be used
	 * @param targetCoords the coördinates in the room against which
	 *             the item is to be used.
	 */
	public void use (final AbstractUser user, final String targetName,
			final Coord3D targetCoords) {
		// no op
	}
	
}
