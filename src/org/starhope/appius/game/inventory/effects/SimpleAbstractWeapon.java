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
package org.starhope.appius.game.inventory.effects;

import org.starhope.appius.game.inventory.ItemEffects;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.game.npc.HitHandler;
import org.starhope.appius.game.npc.MissHandler;
import org.starhope.appius.user.AvatarClass;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class SimpleAbstractWeapon extends ItemEffects {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 5124160042668321675L;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected int ammunition;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected String avatarUseAction;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected AvatarClass hitAvatar;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected HitHandler hitHandler;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected long lastUsed;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected boolean limitedAmmunition;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected int maxAmmunition;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected AvatarClass missAvatar;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected MissHandler missHandler;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected int repeatRateMillis;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected long useDelayMillis;
	
	/**
	 * @param theItem the item being used as a weapon
	 */
	public SimpleAbstractWeapon (final RealItem theItem) {
		super (theItem);
	}
	
	/**
	 * Add the amount to the ammunition up to the maximum allowed
	 * 
	 * @param amount WRITEME  ewinkelman 
	 */
	public void addAmmunition (final int amount) {
		final int oldAmmo = ammunition;
		ammunition = Math.min (maxAmmunition, oldAmmo + amount);
		if (ammunition != oldAmmo) {
			onAmmoCountChanged ();
		}
	}
	
	/**
	 * @return true, if the weapon has at least one round of ammo left
	 *         (or doesn't use limited ammo)
	 */
	protected boolean checkAmmunition () {
		if (limitedAmmunition && (ammunition <= 0)) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	protected boolean checkRepeatRate () {
		/* Check repeat rate */
		
		final long now = System.currentTimeMillis ();
		if (lastUsed > (now - repeatRateMillis)) {
			return false;
		}
		return true;
	}
	
	/**
	 * Decrement the ammunition count by 1
	 */
	protected void decreaseAmmunition () {
		if (limitedAmmunition) {
			--ammunition;
			onAmmoCountChanged ();
		}
	}
	
	/**
	 * @return the ammunition
	 */
	public int getAmmunition () {
		return ammunition;
	}
	
	/**
	 * @return the avatarUseAction
	 */
	public String getAvatarUseAction () {
		return avatarUseAction;
	}
	
	/**
	 * @return the hitAvatar
	 */
	public AvatarClass getHitAvatar () {
		return hitAvatar;
	}
	
	/**
	 * @return the hitHandler
	 */
	public HitHandler getHitHandler () {
		return hitHandler;
	}
	
	/**
	 * @return the maxAmmunition
	 */
	public int getMaxAmmunition () {
		return maxAmmunition;
	}
	
	/**
	 * @return the missAvatar
	 */
	public AvatarClass getMissAvatar () {
		return missAvatar;
	}
	
	/**
	 * @return the missHandler
	 */
	public MissHandler getMissHandler () {
		return missHandler;
	}
	
	/**
	 * @return the limitedAmmunition
	 */
	public boolean isLimitedAmmunition () {
		return limitedAmmunition;
	}
	
	/**
	 * Whenever a shot is fired, or the weapon is reloaded, this hook
	 * is called to give subclasses an opportunity to save the changed
	 * value, usually as the item's health value.
	 */
	protected void onAmmoCountChanged () {
	}
	
	/**
	 * @param newAmmunition the ammunition to set
	 */
	public void setAmmunition (final int newAmmunition) {
		final int oldAmmo = ammunition;
		ammunition = Math.min (maxAmmunition, newAmmunition);
		if (ammunition != oldAmmo) {
			onAmmoCountChanged ();
		}
	}
	
	/**
	 * @param newAvatarActionOnUse the avatar action to play during Use
	 *             of this item (e.g. “SwordSwing” or “DigShovel” or
	 *             “MagicCast2” or something)
	 */
	public void setAvatarUseAction (final String newAvatarActionOnUse) {
		avatarUseAction = newAvatarActionOnUse;
	}
	
	/**
	 * @param newHitAvatar the hitAvatar to set
	 */
	public void setHitAvatar (final AvatarClass newHitAvatar) {
		hitAvatar = newHitAvatar;
	}
	
	/**
	 * @param newHitHandler the hitHandler to set
	 */
	public void setHitHandler (final HitHandler newHitHandler) {
		hitHandler = newHitHandler;
	}
	
	/**
	 * @param newLimitedAmmunition the limitedAmmunition to set
	 */
	public void setLimitedAmmunition (
			final boolean newLimitedAmmunition) {
		limitedAmmunition = newLimitedAmmunition;
	}
	
	/**
	 * @param newMaxAmmunition the maxAmmunition to set
	 */
	public void setMaxAmmunition (final int newMaxAmmunition) {
		maxAmmunition = newMaxAmmunition;
	}
	
	/**
	 * @param newMissAvatar the missAvatar to set
	 */
	public void setMissAvatar (final AvatarClass newMissAvatar) {
		missAvatar = newMissAvatar;
	}
	
	/**
	 * @param newMissHandler the missHandler to set
	 */
	public void setMissHandler (final MissHandler newMissHandler) {
		missHandler = newMissHandler;
	}
	
	/**
	 * @param newRepeatRateMillis the repeatRateMillis to set
	 */
	public void setRepeatRateMillis (final int newRepeatRateMillis) {
		repeatRateMillis = newRepeatRateMillis;
	}
	
}
