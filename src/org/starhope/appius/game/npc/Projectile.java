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
package org.starhope.appius.game.npc;

import java.io.Serializable;

import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.DamageTypeRanks;
import org.starhope.appius.game.PhysicsScheduler;
import org.starhope.appius.game.Room;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.geometry.PolygonPrimitive;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.AvatarClass;
import org.starhope.appius.user.events.Action;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.AcceptsMetronomeTicks;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Projectile extends Ejecta {
	
	/**
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private static final class ProjectileWatcher implements
			AcceptsMetronomeTicks, Serializable {
		
		/**
		 * Java serialisation unique ID
		 */
		private static final long serialVersionUID = 494319176010006645L;
		
		/**
		 * the projectile I'm watching
		 */
		private final Projectile myProjectile;
		
		/**
		 * The polygon outline of the projectile (scaled)
		 */
		private final PolygonPrimitive <?> polygon;
		
		/**
		 * @param projectile to be watched
		 */
		public ProjectileWatcher (final Projectile projectile) {
			myProjectile = projectile;
			polygon = myProjectile.getAvatarClass ()
					.getCollisionBounds ()
					.scale (myProjectile.getSizeScalar ());
		}
		
		/**
		 * @see org.starhope.appius.util.HasName#getName()
		 */
		@Override
		public String getName () {
			return "ProjectileWatcher/"
					+ myProjectile.getDebugName ();
		}
		
		/**
		 * @see org.starhope.appius.util.AcceptsMetronomeTicks#tick(long,
		 *      long)
		 */
		@Override
		public void tick (final long currentTime, final long deltaTime)
				throws UserDeadException {
			
			if (null == myProjectile.getRoom ()) {
				myProjectile.destroy ();
				PhysicsScheduler.remove (this);
				return;
			}
			
			final PolygonPrimitive <?> shotPoly = polygon
					.translate (myProjectile.getLocation ()
							.toCoord2D ());
			final AbstractUser shooter = myProjectile.getShooter ();
			for (final AbstractUser candidate : myProjectile
					.getRoom ().getAllUsers ()) {
				if (candidate.equals (shooter)) {
					continue;
				}
				if (candidate instanceof Ejecta) {
					continue;
				}
				final PolygonPrimitive <?> candidatePoly = candidate
						.getAvatarClass ()
						.getCollisionBounds ()
						.scale (candidate.getSizeScalar ())
						.translate (
								candidate.getLocation ()
										.toCoord2D ());
				if (shotPoly.intersects (candidatePoly)) {
					myProjectile.hit (candidate);
					return;
				}
			}
			if (myProjectile.getLocation ().distance (
					myProjectile.getTarget ()) < 1) {
				myProjectile.miss ();
			}
		}
		
	}
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -601773981170045064L;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private AbstractUser attacker = null;
	/**
	 * WRITEME brpocock@star-hope.org
	 */
	private DamageHitHandler hitEffect = null;
	/**
	 * WRITEME
	 */
	private DamageMissHandler missEffect = null;
	/**
	 * WRITEME
	 */
	protected final DamageTypeRanks myDamage;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final AvatarClass myHitParticleAvatar;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final AvatarClass myMissParticleAvatar;
	
	/**
	 * Who fired this shot
	 */
	private final AbstractUser myShooter;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final ProjectileWatcher myWatcher;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private Coord3D startLocation;
	
	/**
	 * Specify the avatar file to be provided to the client, and the
	 * point of origination, and motion vector.
	 * 
	 * @param avatar The avatar file to be provided to the client
	 * @param shooter person firing the shot
	 * @param hitParticle particle to play on hit
	 * @param missParticle particle to play on miss
	 * @param damage the type of damage to use for determining hits
	 */
	
	public Projectile (final AvatarClass avatar,
			final AbstractUser shooter,
			final AvatarClass hitParticle,
			final AvatarClass missParticle,
			final DamageTypeRanks damage) {
		super (avatar);// , room, origin, birth, target, travelRate);
		myShooter = shooter;
		myHitParticleAvatar = hitParticle;
		myMissParticleAvatar = missParticle;
		myWatcher = new ProjectileWatcher (this);
		myDamage = damage;
	}
	
	/**
	 * @see org.starhope.appius.game.npc.Ejecta#fire(org.starhope.appius.game.Room,
	 *      org.starhope.appius.geometry.Coord3D, long,
	 *      org.starhope.appius.geometry.Coord3D, double)
	 */
	@Override
	public void fire (final Room room, final Coord3D origin,
			final long birth, final Coord3D target,
			final double travelRate) {
		super.fire (room, origin, birth, target, travelRate);
		startLocation = origin;
		PhysicsScheduler.add (myWatcher);
		PhysicsScheduler.addPersonOfInterest (this);
	}
	
	/**
	 * @return the attacker
	 */
	@Override
	public AbstractUser getAttacker () {
		return attacker;
	}
	
	/**
	 * @return the hitEffect
	 */
	@Override
	public DamageHitHandler getHitEffect () {
		return hitEffect;
	}
	
	/**
	 * Gets the hit particle
	 * 
	 * @return WRITEME  ewinkelman 
	 */
	protected Particle getHitParticle () {
		return new Particle (getHitParticleAvatar ());
	}
	
	/**
	 * @return the myHitParticle
	 */
	public AvatarClass getHitParticleAvatar () {
		return myHitParticleAvatar;
	}
	
	/**
	 * @return the missEffect
	 */
	@Override
	public DamageMissHandler getMissEffect () {
		return missEffect;
	}
	
	/**
	 * Gets the miss particle
	 * 
	 * @return WRITEME  ewinkelman 
	 */
	protected Particle getMissParticle () {
		return new Particle (getMissParticleAvatar ());
	}
	
	/**
	 * @return the myMissParticle
	 */
	public AvatarClass getMissParticleAvatar () {
		return myMissParticleAvatar;
	}
	
	/**
	 * @return who fired this shot
	 */
	@Override
	public AbstractUser getShooter () {
		return myShooter;
	}
	
	/**
	 * @return the origin coördinates
	 */
	@Override
	public Coord3D getStartLocation () {
		return startLocation;
	}
	
	/**
	 * @return the myWatcher
	 */
	@Override
	public ProjectileWatcher getWatcher () {
		return myWatcher;
	}
	
	/**
	 * @param victim WRITEME
	 */
	@Override
	public void hit (final AbstractUser victim) {
		if (null != getHitEffect ()) {
			getHitEffect ().hitForDamage (this, victim);
		}
		Quaestor.getDefault ().action (
				new Action (getRoom (), this, "projectile.hit",
						victim));
		if (null != myHitParticleAvatar) {
			getHitParticle ().fire (getRoom (), getLocation (),
					System.currentTimeMillis (), getLocation (),
					0, (long) (1000 / getTravelRate ()));
		}
		destroy ();
		PhysicsScheduler.add (myWatcher);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	@Override
	public void miss () {
		if (null != missEffect) {
			missEffect.damageMiss (this);
		}
		if (null != myMissParticleAvatar) {
			new Particle (myMissParticleAvatar).fire (getRoom (),
					getLocation (), System.currentTimeMillis (),
					getLocation (), 0,
					(long) (1000 / getTravelRate ()));
		}
		destroy ();
		PhysicsScheduler.remove (myWatcher);
	}
	
	/**
	 * @param myAttacker the attacker to set
	 */
	@Override
	public void setAttacker (final AbstractUser myAttacker) {
		attacker = myAttacker;
	}
	
	/**
	 * @param newHitEffect the hitEffect to set
	 */
	public void setHitEffect (final DamageHitHandler newHitEffect) {
		hitEffect = newHitEffect;
	}
	
	/**
	 * @param newMissEffect the missEffect to set
	 */
	public void setMissEffect (final DamageMissHandler newMissEffect) {
		missEffect = newMissEffect;
	}
	
}
