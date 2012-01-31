/**
 * <p> Copyright © 2012, Bruce-Robert Pocock</p> 
 *
 * <p> Copyright © 2011 Res Interactive, LLC </p>
 *
 * <p> This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version.  </p>
 *
 * <p> This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Affero General Public License for more details.  </p>
 *
 * <p> You should have received a copy of the GNU Affero General
 * Public License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.  </p>
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game.powers;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 */
@Deprecated
public interface ClickPower extends Power {

	/**
	 * Different slots that the click power can 'claim'
	 *
	 */
	public enum ClickPowerSlots {
		altClick, altShiftClick, ctrlAltClick, ctrlAltShiftClick, ctrlClick, ctrlShiftClick, shiftClick, ;
	}

	/**
	 * Decreases the ammo used by the number given
	 *
	 * @param i WRITEME 
	 */
	void decreaseAmmo (PowerController pc, int i);

	/**
	 * Gets the item ID to use as the icon for this power. Should be set to -1 if not used.
	 *
	 * @return WRITEME 
	 */
	int getIcon ();

	/**
	 * Performs an action when the item is equipped and a click is registered
	 *
	 * @param clickedOn WRITEME 
	 * @param x WRITEME 
	 * @param y WRITEME 
	 */
	void onClick (PowerController pc, String clickedOn, double x, double y);

	/**
	 * How many charges(ammo) are left. Meaningless if projectileUsesAmmo() is false.
	 *
	 * @return WRITEME 
	 */
	int projectileAmmoCount (PowerController pc);

	/**
	 * Gets the name of the projectile's avatar class
	 * If this is NULL, then it is assumed that this click power DOES NOT implement a projectile
	 *
	 * @return WRITEME 
	 */
	String projectileAvatarClass ();

	/**
	 * Gets the hit action, if any, for when a projectile hit someone
	 *
	 * @param pc WRITEME 
	 * @param victim WRITEME 
	 * @return The action string or null if none
	 */
	String projectileHitAction (PowerController pc, String victim);

	/**
	 * Gets the direction to play the hit action, if any
	 *
	 * @param pc WRITEME 
	 * @param victim WRITEME 
	 * @return The action facing, or null if none or default facing
	 */
	String projectileHitFacing (PowerController pc, String victim);

	/**
	 * Gets the string that the victim speaks when hit by this projectile
	 *
	 * @param pc WRITEME 
	 * @param victim WRITEME 
	 * @return WRITEME 
	 */
	String projectileHitSpeech (PowerController pc, String victim);

	/**
	 * The name of the event that fires for the owner when someone is hit by the projectile
	 *
	 * @return WRITEME 
	 */
	String projectileOwnerHitEvent ();

	/**
	 * Number of points to assign for an event that fires for the owner when someone is hit
	 *
	 * @param pc WRITEME 
	 * @param victim WRITEME 
	 * @return WRITEME 
	 */
	int projectileOwnerHitEventPoints (PowerController pc, String victim);

	/**
	 * The range of the projectile
	 *
	 * @return WRITEME 
	 */
	double projectileRange ();

	/**
	 * Gets the number if milliseconds to wait before allowing another shot
	 *
	 * @param pc WRITEME 
	 * @return WRITEME 
	 */
	int projectileRefireDelay (PowerController pc);

	/**
	 * The name of the event that fires for the person hit by the projectile if a hit occurs
	 *
	 * @return WRITEME 
	 */
	String projectileTargetHitEvent ();

	/**
	 * Number of points to assign for an event that fires when someone is hit
	 *
	 * @param pc WRITEME 
	 * @param victim WRITEME 
	 * @return WRITEME 
	 */
	int projectileTargetHitEventPoints (PowerController pc, String victim);

	/**
	 * True if the projectile uses ammo, false otherwise
	 *
	 * @return WRITEME 
	 */
	boolean projectileUsesAmmo();

	/**
	 * Which click power slot this item claims for its use
	 *
	 * @return WRITEME 
	 */
	ClickPowerSlots usesSlot ();
}
