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
 *
 */
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
public class GroundSpawnSQLLoader implements RecordLoader <GroundSpawn> {

	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (GroundSpawnSQLLoader.class);

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final GroundSpawn changedRecord) {
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
	public GroundSpawn loadRecord (final int id) throws NotFoundException {
		return loadRecord (id, new GroundSpawn (this));
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param id WRITEME 
	 * @param record WRITEME 
	 * @return WRITEME 
	 * @throws NotFoundException
	 */
	private GroundSpawn loadRecord (final int id, final GroundSpawn record) throws NotFoundException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		record.markForReload ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			ps = con.prepareStatement ("SELECT * FROM groundSpawns WHERE groundSpawnID=?");
			ps.setInt (1, id);
			rs = ps.executeQuery ();
			if (rs.next ()) {
				set (record, rs);
			}
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
	public GroundSpawn loadRecord (final String identifier) throws NotFoundException {
		try {
			return loadRecord (Integer.valueOf (identifier), new GroundSpawn (this));
		} catch (NumberFormatException e) {
			throw new NotFoundException ("GroundSpawns don't have names.  Couldn't find a ground spawn with the ID of "
					+ identifier);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final GroundSpawn record) {
		try {
			loadRecord (record.getID (), record);
		} catch (NotFoundException e) {
			GroundSpawnSQLLoader.log.error ("Exception",e);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final GroundSpawn record) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final GroundSpawn record) {
		record.markAsSaved ();
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param record WRITEME 
	 * @param rs WRITEME 
	 * @throws SQLException
	 */
	private void set (final GroundSpawn record, final ResultSet rs) throws SQLException {
		record.setID (rs.getInt ("groundSpawnID"));
		record.setRealItem (rs.getInt ("realItemID"));
		record.setEventType (rs.getInt ("rewardEvent"));
		record.setEventRadius (rs.getInt ("eventRadius"));
	}

}
