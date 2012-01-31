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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game.inventory.effects;

import java.util.Set;
import java.util.concurrent.ConcurrentSkipListSet;

import org.starhope.appius.game.Room;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.game.inventory.ItemEffects;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.user.AbstractUser;

/**
 * <p>
 * The stock item of many games: The Shovel. It's possible that someone
 * might want to override this, but unlike the Simple* classes in this
 * package, it's actually fairly reasonable to assign this effect
 * directly to an item.
 * </p>
 * <p>
 * Here's how it works: the Shovel will look at the event spaces defined
 * for the room. If there's are $earth/* spaces defined (spaces whose
 * names begin with “evt_$earth/”), it will permit digging in those
 * areas. The player can then attempt to dig a hole. There are settings
 * for the digging Action, whether the digging Action requires specific
 * facings, and what sort of particle is dropped to represent a hole, as
 * well as that particle's lifetime (so holes can auto-refill over
 * time). Digging where there is already a hole will refill and remove
 * it.
 * </p>
 * <p>
 * To bury an item, a room variable is set named “evt_$earth/item” with
 * the InventoryItem slot# of the buried item. Note that the inventory
 * item will be owned by User ID #1 when buried. If a player digs at the
 * given spot, they will pick up the item and receive the usual
 * “earning” message identifying it. The room variable will also be
 * removed, so only one user can retrieve the item.
 * </p>
 * <p>
 * An option to actually bury an item as an user has not been designed
 * yet.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Shovel extends ItemEffects {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 8304323736093523921L;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String digAction = "Digging";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final Set <String> digFacings = new ConcurrentSkipListSet <String> ();
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String fillAction = "FillingDug";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String getItemAction = "PickingUp";
	
	/**
	 * @param theItem the item to be a shovel
	 */
	public Shovel (final InventoryItem theItem) {
		super (theItem);
		for (final String facing : Room.octantFacing) {
			digFacings.add (facing);
		}
	}
	
	/**
	 * @param facing the facing to be allowed when digging
	 */
	public void addDigFacing (final String facing) {
		digFacings.add (facing);
	}
	
	/**
	 * @return the digAction
	 */
	public String getDigAction () {
		return digAction;
	}
	
	/**
	 * @return the digFacings
	 */
	public Set <String> getDigFacings () {
		return digFacings; /* TODO make a copy brpocock@star-hope.org */
	}
	
	/**
	 * @return the fillAction
	 */
	public String getFillAction () {
		return fillAction;
	}
	
	/**
	 * @return the getItemAction
	 */
	public String getGetItemAction () {
		return getItemAction;
	}
	
	/**
	 * @param facing the facing to be removed from digging
	 */
	public void removeDigFacing (final String facing) {
		digFacings.remove (facing);
	}
	
	/**
	 * @param newDigAction the digAction to set
	 */
	public void setDigAction (final String newDigAction) {
		digAction = newDigAction; /* TODO brpocock@star-hope.org */
	}
	
	/**
	 * @param newFillAction the fillAction to set
	 */
	public void setFillAction (final String newFillAction) {
		fillAction = newFillAction; /* TODO brpocock@star-hope.org */
	}
	
	/**
	 * @param newGetItemAction the getItemAction to set
	 */
	public void setGetItemAction (final String newGetItemAction) {
		getItemAction = newGetItemAction; /*
									 * TODO
									 * brpocock@star-hope.org
									 */
	}
	
	/**
	 * @see org.starhope.appius.game.inventory.ItemEffects#use(java.lang.String,
	 *      org.starhope.appius.geometry.Coord3D)
	 */
	@Override
	public void use (final AbstractUser user, final String targetName,
			final Coord3D targetCoords) {
		// XXX: handle targetName
		if (targetCoords.distance (user.getLocation ()) > user
				.getHeight ()) {
			// XXX: walk over there, first
			user.acceptPrivateMessage (user,
					"I can't dig over there, unless I walk closer, first.");
			return;
		}
		// TODO: check for soft earth
		// TODO: start digging
		// TODO: schedule after animation: add a hole, and removed
		// earth
		// TODO: schedule after that: check for buried items
	}
	
}
