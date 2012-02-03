/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at
 * your option) any later version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.game.inventory.effects;

import org.starhope.appius.game.Room;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.game.npc.Projectile;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.geometry.Vector3D;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.AvatarClass;

/**
 * A simple ranged weapon in the style of a gun, bow & arrows, or so
 * forth. The ammunition can be limited, and there can be repeat rate
 * limits, and so forth.
 *
 * @author brpocock@star-hope.org
 */
public class SimpleRangedWeapon extends SimpleAbstractWeapon {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -7991920704746624263L;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private AvatarClass projectileAvatar;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private double travelRate;

	/**
	 * Determines if the projectile's destination should be translated
	 * so that it travels to the edge of the screen
	 */
	protected boolean travelsToEdgeOfScreen = false;

	/**
	 * @param theItem the item to serve as a simple ranged weapon
	 */
	public SimpleRangedWeapon (final InventoryItem theItem) {
		super (theItem);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param targetName WRITEME
	 * @param targetCoords WRITEME
	 * @return WRITEME
	 */
	protected Coord3D acquireTarget (final String targetName,
			final Coord3D targetCoords) {
		/* Acquire target */

		Coord3D destination = new Coord3D (targetCoords);
		if (null == targetCoords) {
			// TODO…
			return null;
		}

		if (travelsToEdgeOfScreen) {
			final AbstractUser owner = item.getOwner ();
			final Room room = owner.getRoom ();
			if (null != room) {
				final Coord3D oLocation = owner.getLocation ();
				Vector3D vector3d = new Vector3D (oLocation,
						destination);
				final double max = Math.max (Math.max (room.getMaxX (),
						room.getMaxY ()), room.getMaxZ ());
				vector3d = vector3d.normalize ().multiply (max);
				destination = new Coord3D (oLocation.getX ()
						+ vector3d.getX (), oLocation.getY ()
						+ vector3d.getY (), oLocation.getZ ()
						+ vector3d.getZ ());
			}
		}

		return destination;
	}
	
	/**
	 * fire a shot
	 * 
	 * @param archer the one shooting
	 * @param destination the target
	 */
	protected void fire (final AbstractUser archer,
			final Coord3D destination) {

		lastUsed = System.currentTimeMillis ();

		final Room room = archer.getRoom ();

		/* Play animation */

		if (null != avatarUseAction) {
			archer.setCurrentAction (avatarUseAction);
			room.notifyUserAction (archer);
		}

		/* Launch projectile */
		final Projectile projectile = getProjectile (archer);
		projectile.setAttacker (archer);
		projectile.setHitEffect (getHitHandler ());
		projectile.setMissEffect (getMissHandler());
		final Coord3D origin = archer.getLocation ().subtract (0,
				archer.getHeight () / 3, 0);
		final long birth=System.currentTimeMillis ()
		+ (long) (room.getLag () * 1.5);

		projectile.fire (room, origin, birth, destination, travelRate);
		decreaseAmmunition ();
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param archer
	 * @return
	 */
	protected Projectile getProjectile (AbstractUser archer) {
		return new Projectile (getProjectileAvatar (), archer,
				getHitAvatar (), getMissAvatar (), attackDamage);
	}
	
	/**
	 * @return the projectileAvatar
	 */
	public AvatarClass getProjectileAvatar () {
		return projectileAvatar;
	}

	/**
	 * @return the repeatRateMillis
	 */
	public int getRepeatRateMillis () {
		return repeatRateMillis;
	}

	/**
	 * @return the useDelayMillis
	 */
	public long getShotDelayMillis () {
		return useDelayMillis;
	}

	/**
	 * @return the travelRate
	 */
	public double getTravelRate () {
		return travelRate;
	}

	/**
	 * @param newProjectileAvatar the projectileAvatar to set
	 */
	public void setProjectileAvatar (
			final AvatarClass newProjectileAvatar) {
		projectileAvatar = newProjectileAvatar;
	}

	/**
	 * @param newShotDelayMillis the useDelayMillis to set
	 */
	public void setShotDelayMillis (final long newShotDelayMillis) {
		useDelayMillis = newShotDelayMillis;
	}

	/**
	 * @param newTravelRate the travelRate to set
	 */
	public void setTravelRate (final double newTravelRate) {
		travelRate = newTravelRate;
	}

	/**
	 * @see org.starhope.appius.game.inventory.ItemEffects#use(AbstractUser,java.lang.String,
	 *      org.starhope.appius.geometry.Coord3D)
	 */
	@Override
	public synchronized void use (final AbstractUser user,
			final String targetName, final Coord3D targetCoords) {
		super.use (user, targetName, targetCoords);
		final Coord3D destination = acquireTarget (targetName,
				targetCoords);
		if (null == destination) {
			return;
		}
		if (checkAmmunition () && checkRepeatRate ()) {
			fire (user, destination);
		}

	}
}
