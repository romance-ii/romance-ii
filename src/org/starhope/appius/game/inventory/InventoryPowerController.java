package org.starhope.appius.game.inventory;

import org.starhope.appius.except.MembershipException;
import org.starhope.appius.except.NonSufficientFundsException;
import org.starhope.appius.except.NonSufficientItemsException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.npc.Ejecta;
import org.starhope.appius.game.npc.HitHandler;
import org.starhope.appius.game.npc.MissHandler;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.geometry.Vector3D;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.AvatarClass;
import org.starhope.appius.user.events.EventType;
import org.starhope.appius.util.WeakRecord;

/**
 * <p> Copyright © 2010-2011, Res Interactive, LLC </p>
 *
 * <p> Copyright © 2010-2012, Bruce-Robert Pocock </p>
 *
 * <p> This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU Affero General Public License as
 *     published by the Free Software Foundation, either version 3 of the
 *     License, or (at your option) any later version.  </p>
 *          
 * <p> This program is distributed in the hope that it will be useful, but
 *     WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *     Affero General Public License for more details.  </p>
 *                    
 * <p> You should have received a copy of the GNU Affero General Public License
 *     along with this program.  If not, see <http://www.gnu.org/licenses/>.</p>
 *
 * <p> Power controller utility class </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
@Deprecated
public class InventoryPowerController implements PowerController {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final UserInventory inventory;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final private Power power;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private WeakRecord <AvatarClass> projAvatarClass = null;
	
	/**
	 * Last time the projectile was fired
	 */
	private long projLastFired = 0;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private WeakRecord <EventType> projOwnerHitEvent = null;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private WeakRecord <EventType> projTargetHitEvent = null;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param itemPower WRITEME 
	 * @param item WRITEME 
	 * @param inv WRITEME 
	 */
	public InventoryPowerController (final Power itemPower,
			final UserInventory inv) {
		inventory = inv;
		power = itemPower;
		
		final ClickPower clickPower = power instanceof ClickPower ? (ClickPower) power
				: null;
		if ( (clickPower != null)
				&& (clickPower.projectileAvatarClass () != null)) {
			projAvatarClass = new WeakRecord <AvatarClass> (
					AvatarClass.class,
					clickPower.projectileAvatarClass ());
			projTargetHitEvent = clickPower
					.projectileTargetHitEvent () != null ? new WeakRecord <EventType> (
					EventType.class,
					clickPower.projectileTargetHitEvent ()) : null;
			projOwnerHitEvent = clickPower
					.projectileOwnerHitEvent () != null ? new WeakRecord <EventType> (
					EventType.class,
					clickPower.projectileOwnerHitEvent ()) : null;
		}
		
	}
	
	/**
	 * @see org.starhope.appius.game.powers.PowerController#addInventory(int,
	 *      int)
	 */
	@Override
	public void addInventory (final int realItemID, final int count) {
		inventory.addItem (realItemID, count);
	}
	
	/**
	 * @see org.starhope.appius.game.powers.PowerController#fireProjectile(double,
	 *      double)
	 */
	@SuppressWarnings ("serial")
	@Override
	public boolean fireProjectile (final double destX,
			final double destY) {
		final boolean firedAShot = false;
		final long currentTime = System.currentTimeMillis ();
		final ClickPower clickPower = power instanceof ClickPower ? (ClickPower) power
				: null;
		final AvatarClass avClass = projAvatarClass != null ? projAvatarClass
				.get () : null;
		final EventType targetEvent = projTargetHitEvent != null ? projTargetHitEvent
				.get () : null;
		final EventType ownerEvent = projOwnerHitEvent != null ? projOwnerHitEvent
				.get () : null;
		
		// Fire a projectile if there's a projectile to fire and
		// enough ammo
		if ( (avClass != null)
				&& ( !clickPower.projectileUsesAmmo () || (clickPower
						.projectileAmmoCount (this) > 0))
				&& (currentTime > (projLastFired + clickPower
						.projectileRefireDelay (this)))) {
			projLastFired = currentTime;
			
			// Calculate target coordinates
			Coord3D target = new Coord3D (destX, destY, 0);
			final Coord3D startLoc = inventory
					.getUser ()
					.getLocation ()
					.subtract (
							0,
							inventory.getUser ().getHeight () / 3,
							0);
			Vector3D vector = new Vector3D (startLoc, target);
			vector = vector.normalize ();
			vector = vector.multiply (clickPower.projectileRange ());
			target = startLoc.add (vector.getX (), vector.getY (),
					vector.getZ ());
			final Ejecta projectile = new Ejecta (avClass,
					inventory.getUser ());
			
			// What happens if it hits someone
			projectile.setHitEffect (new HitHandler () {
				
				@Override
				public void hitForDamage (final AbstractUser victim) {
					final String hitSpeech = clickPower
							.projectileHitSpeech (
									InventoryPowerController.this,
									victim.getAvatarLabel ());
					final String hitAction = clickPower
							.projectileHitAction (
									InventoryPowerController.this,
									victim.getAvatarLabel ());
					final String hitFacing = clickPower
							.projectileHitFacing (
									InventoryPowerController.this,
									victim.getAvatarLabel ());
					if (hitAction != null) {
						victim.getRoom ().goTo (victim,
								victim.getLocation (),
								hitFacing, hitAction);
					}
					if (hitSpeech != null) {
						victim.speak (hitSpeech);
					}
					if (targetEvent != null) {
						final EventPrototypeInfo info = new EventPrototypeInfo ();
						info.setPoints (clickPower
								.projectileTargetHitEventPoints (
										InventoryPowerController.this,
										victim.getAvatarLabel ()));
						try {
							targetEvent.doEvent (info, victim);
						} catch (final NotReadyException e) {
							InventoryPowerController.log.error (
									"Exception", e);
						} catch (final NonSufficientFundsException e) {
							InventoryPowerController.log.error (
									"Exception", e);
						} catch (final NonSufficientItemsException e) {
							InventoryPowerController.log.error (
									"Exception", e);
						} catch (final MembershipException e) {
							InventoryPowerController.log.error (
									"Exception", e);
						}
					}
					if (ownerEvent != null) {
						final EventPrototypeInfo info = new EventPrototypeInfo ();
						info.setPoints (clickPower
								.projectileOwnerHitEventPoints (
										InventoryPowerController.this,
										inventory.getUser ()
												.getAvatarLabel ()));
						try {
							ownerEvent.doEvent (info,
									inventory.getUser ());
						} catch (final NotReadyException e) {
							InventoryPowerController.log.error (
									"Exception", e);
						} catch (final NonSufficientFundsException e) {
							InventoryPowerController.log.error (
									"Exception", e);
						} catch (final NonSufficientItemsException e) {
							InventoryPowerController.log.error (
									"Exception", e);
						} catch (final MembershipException e) {
							InventoryPowerController.log.error (
									"Exception", e);
						}
					}
				}
			});
			// What happens if it misses everyone and runs out of
			// range (i.e. reaches the target coords)
			projectile.setMissEffect (new MissHandler () {
				
				@Override
				public void damageMiss () {
					// TODO Auto-generated method stub
					
				}
			});
			
			if (clickPower.projectileUsesAmmo ()) {
				clickPower.decreaseAmmo (this, 1);
			}
			projectile.fire (inventory.getUser ().getRoom (),
					startLoc, currentTime, target);
		}
		return firedAShot;
	}
	
	/**
	 * @see org.starhope.appius.game.powers.PowerController#getCount(int)
	 */
	@Override
	public int getCount (final int realItemID) {
		return inventory.getCount (realItemID);
	}
	
	/**
	 * @see org.starhope.appius.game.powers.PowerController#getOwnerName()
	 */
	@Override
	public String getOwnerName () {
		return inventory.getUser ().getAvatarLabel ();
	}
	
	/**
	 * @see org.starhope.appius.game.powers.PowerController#getOwnerUserVar(java.lang.String)
	 */
	@Override
	public String getOwnerUserVar (final String varName) {
		return inventory.getUser ().getVariable (varName);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	public Power getPower () {
		return power;
	}
	
}
