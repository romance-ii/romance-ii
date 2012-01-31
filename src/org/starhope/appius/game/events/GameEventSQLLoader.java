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
package org.starhope.appius.game.events;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.HasSubversionRevision;
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
public class GameEventSQLLoader implements RecordLoader <GameEvent>, HasSubversionRevision {

	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (GameEventSQLLoader.class);

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final GameEvent changedRecord) {
		// Do nothing

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
	public GameEvent loadRecord (final int id) throws NotFoundException {
		return loadRecord (id, new GameEvent (this));
	}

	/**
	 * Loads a game event record
	 *
	 * @param id WRITEME 
	 * @param record WRITEME 
	 * @return WRITEME 
	 * @throws NotFoundException
	 */
	public GameEvent loadRecord (final int id, final GameEvent record) throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		record.markForReload ();

		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM gameEvents WHERE ID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			if (rs.next ()) {
				set (record, rs);
			}
		} catch (SQLException e) {
			GameEventSQLLoader.log.error ("Caught a SQLException in EventTypeSQLLoader.loadRecord " + id, e);
			throw new NotFoundException (String.valueOf (id));
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		record.markAsLoaded ();
		return record;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public GameEvent loadRecord (final String identifier) throws NotFoundException {
		final GameEvent record = new GameEvent (this);
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		record.markForReload ();

		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM gameEvents WHERE moniker=?");
			st.setString (1, identifier);
			rs = st.executeQuery ();
			if (rs.next ()) {
				set (record, rs);
			}
		} catch (SQLException e) {
			GameEventSQLLoader.log.error ("Caught a SQLException in EventTypeSQLLoader.loadRecord " + identifier, e);
			throw new NotFoundException (identifier);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		record.markAsLoaded ();
		return record;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final GameEvent record) {
		try {
			loadRecord (record.getID (), record);
		} catch (NotFoundException e) {
			GameEventSQLLoader.log.error ("Exception", e);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final GameEvent record) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final GameEvent record) {
		// TODO Auto-generated method stub

	}

	/**
	 * Sets the values to the record
	 *
	 * @param record WRITEME 
	 * @param rs WRITEME 
	 * @throws SQLException
	 */
	private void set (final GameEvent record, final ResultSet rs) throws SQLException {
		record.setID (rs.getInt ("ID"));
		record.setMoniker (rs.getString ("moniker"));
		record.setEndEvent (rs.getInt ("endEvent"));
		record.setLoader (rs.getString ("loader"));
		record.setFilePath (rs.getString ("filepath"));
		int fileWidth = rs.getInt ("fileWidth");
		record.setFileWidth (rs.wasNull () ? null : fileWidth);
		int fileHeight = rs.getInt ("fileHeight");
		record.setFileHeight (rs.wasNull () ? null : fileHeight);
		record.markAsLoaded ();
	}

}
