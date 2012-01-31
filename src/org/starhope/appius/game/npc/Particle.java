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

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Room;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.user.AvatarClass;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Particle extends Ejecta {
	
	/**
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final static class ParticleDestroyer implements Runnable {
		/**
		 * WRITEME brpocock@star-hope.org
		 */
		private final Particle particle;
		
		/**
		 * WRITEME brpocock@star-hope.org
		 * 
		 * @param victim WRITEME
		 */
		ParticleDestroyer (final Particle victim) {
			particle = victim;
		}
		
		/**
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run () {
			particle.destroy ();
		}
	}
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 6734832968465418853L;
	
	/**
	 * Specify the avatar file to be provided to the client, and the
	 * point of origination, and motion vector.
	 * 
	 * @param avatar The avatar file to be provided to the client
	 */
	
	public Particle (final AvatarClass avatar) {
		super (avatar);
	}
	
	/**
	 * Fires off the particle effect
	 * 
	 * @param room The room in which the Ejecta is born
	 * @param origin The point of origin
	 * @param birth The time of origination
	 * @param target The destination of motion
	 * @param travelRate The rate of travel
	 * @param duration the time to survive
	 */
	public void fire (final Room room, final Coord3D origin,
			final long birth, final Coord3D target,
			final double travelRate, final long duration) {
		super.fire (room, origin, birth, target, travelRate);
		final Particle particle = this;
		AppiusClaudiusCaecus.getKalendor ().schedule (
				birth + duration, new ParticleDestroyer (particle));
	}
	
}
