/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public
 * License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
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



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
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
public class GroundSpawnSetSQLLoader implements RecordLoader <GroundSpawnSet> {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (GroundSpawnSetSQLLoader.class);

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final GroundSpawnSet changedRecord) {
		// Not needed
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#initializeStorage(java.lang.String)
	 */
	@Override
	public void initializeStorage (final String storageURL) throws NotReadyException {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#isRealtime()
	 */
	@Override
	public boolean isRealtime () {
		return false;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
	 */
	@Override
	public GroundSpawnSet loadRecord (final int id) throws NotFoundException {
		return loadRecord (id, new GroundSpawnSet (this));
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param id WRITEME 
	 * @param record WRITEME 
	 * @return WRITEME 
	 * @throws NotFoundException
	 */
	private GroundSpawnSet loadRecord (final int id, final GroundSpawnSet record) throws NotFoundException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		record.markForReload ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			ps = con.prepareStatement ("SELECT * FROM groundSpawnSet WHERE spawnSetID=?");
			ps.setInt (1, id);
			rs = ps.executeQuery ();
			if (rs.next ()) {
				set (record, rs);
			}
			ps = con.prepareStatement ("SELECT * FROM groundSpawnSetSpawns WHERE spawnSetID=?");
			ps.setInt (1, id);
			rs = ps.executeQuery ();
			set2 (record, rs);
		} catch (final SQLException e) {
			throw new NotFoundException ("Not found spawnSetID" + id);
		} finally {
			LibMisc.closeAll (rs, ps, con);
		}
		record.markAsLoaded ();
		return record;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public GroundSpawnSet loadRecord (final String identifier) throws NotFoundException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		final GroundSpawnSet record = new GroundSpawnSet (this);
		record.markForReload ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			ps = con.prepareStatement ("SELECT * FROM groundSpawnSet WHERE name=?");
			ps.setString (1, identifier);
			rs = ps.executeQuery ();
			if (rs.next ()) {
				set (record, rs);
			}
		} catch (final SQLException e) {
			throw new NotFoundException (identifier);
		} finally {
			LibMisc.closeAll (rs, ps, con);
		}
		record.markAsLoaded ();
		return record;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final GroundSpawnSet record) {
		try {
			loadRecord (record.getID (), record);
		} catch (NotFoundException e) {
			GroundSpawnSetSQLLoader.log.error ("Exception",e);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final GroundSpawnSet record) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final GroundSpawnSet record) {
		record.markAsSaved ();
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param record WRITEME 
	 * @param rs WRITEME 
	 * @throws SQLException
	 */
	private void set (final GroundSpawnSet record, final ResultSet rs) throws SQLException {
		record.setID (rs.getInt ("spawnSetID"));
		record.setName (rs.getString ("name"));
		record.setPointGroup (rs.getString ("pointGroup"));
		record.setMinLife (rs.getLong ("minLife"));
		record.setMaxLife (rs.getLong ("maxLife"));
		record.setSpawns (rs.getInt ("spawns"));
		record.setMaxSpawnsPerRoom (rs.getInt ("maxSpawnsPerRoom"));
		final String roomsString = rs.getString ("spawnRooms");
		if ( !rs.wasNull ()) {
			final String [] strings = roomsString.split (",");
			for (String string : strings) {
				record.addRoom (string.trim ());
			}
		}
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param record WRITEME 
	 * @param rs WRITEME 
	 * @throws SQLException
	 */
	private void set2 (final GroundSpawnSet record, final ResultSet rs) throws SQLException {
		record.clearSpawns ();
		while (rs.next ()) {
			record.addSpawn (rs.getInt ("groundSpawnID"), rs.getInt ("min"), rs.getInt ("max"), rs.getInt ("weight"));
		}
	}

}
