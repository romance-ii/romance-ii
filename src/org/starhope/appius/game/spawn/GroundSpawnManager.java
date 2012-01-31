/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
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
package org.starhope.appius.game.spawn;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;



import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Zone;
import org.starhope.appius.util.AcceptsMetronomeTicks;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.WeakRecord;
import org.starhope.util.LibMisc;

/**
 * Manages ground spawns for a given zone
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
public class GroundSpawnManager implements AcceptsMetronomeTicks {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (GroundSpawnManager.class);

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final Zone zone;

	/**
	 * List of all spawners
	 */
	private final List <WeakRecord <GroundSpawnSet>> spawners = new LinkedList <WeakRecord <GroundSpawnSet>> ();

	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 *
	 * @param zone WRITEME 
	 */
	public GroundSpawnManager (final Zone zone) {
		this.zone = zone;
	}

	@Override
	public String getName () {
		return "Ground Spawn Manager";
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 */
	public void start () {
		synchronized (spawners) {
			spawners.clear ();
			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			try {
				con = AppiusConfig.getDatabaseConnection ();
				ps = con.prepareStatement ("SELECT spawnSetID FROM groundSpawnSet");
				rs = ps.executeQuery ();
				while (rs.next ()) {
					try {
						spawners.add (new WeakRecord <GroundSpawnSet> (GroundSpawnSet.class, rs.getInt ("spawnSetID")));
					} catch (SQLException e) {
						GroundSpawnManager.log.error ("Exception",e);
					}
				}
			} catch (final SQLException e) {
				GroundSpawnManager.log.error ("Exception",e);
			} finally {
				LibMisc.closeAll (rs, ps, con);
			}
		}
		AppiusClaudiusCaecus.add (this);
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 */
	public void stop () {
		synchronized (spawners) {
			for (WeakRecord <GroundSpawnSet> spawner : spawners) {
				spawner.get ().shutdown ();
			}
		}
		AppiusClaudiusCaecus.remove (this);
	}

	/**
	 * @see org.starhope.appius.util.AcceptsMetronomeTicks#tick(long, long)
	 */
	@Override
	public void tick (final long currentTime, final long deltaTime) throws UserDeadException {
		synchronized (spawners) {
			for (WeakRecord <GroundSpawnSet> spawner : spawners) {
				spawner.get ().doSpawn (zone);
			}
		}
	}
}
