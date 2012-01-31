/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General
 * Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any
 * later version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game.rooms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.user.Nomenclator;
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
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class RoomSQLLoader implements RecordLoader <Room> {

	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (RoomSQLLoader.class);

	/**
	 * @return all static rooms defined in the database
	 */
	static Collection <Room> getRoomsInDB () {
		final Collection <Room> everywhere = new LinkedList <Room> ();

		PreparedStatement st = null;
		java.sql.Connection con = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT moniker FROM roomList");
			if (st.execute ()) {
				rs = st.getResultSet ();
				while (rs.next ()) {
					try {
						everywhere.add (Nomenclator.getDataRecord (Room.class, rs.getString ("moniker")));
					} catch (final NotFoundException e) {
						RoomSQLLoader.log.error ("Caught a NotFoundException in Room.getRoomsInDB ", e);
					}
				}
			}
		} catch (final SQLException e) {
			RoomSQLLoader.log.error ("Exception", e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return everywhere;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final Room changedRecord) {
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
		// no op
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
	public Room loadRecord (final int id) throws NotFoundException {
		Connection con = null;
		PreparedStatement getRoom = null;
		PreparedStatement getRoomVars = null;
		ResultSet roomRS = null;
		ResultSet roomVars = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getRoom = con.prepareStatement ("SELECT * FROM roomList WHERE ID=?");
			getRoom.setInt (1, id);
			roomRS = getRoom.executeQuery ();
			return set (roomRS);
		} catch (final SQLException e) {
			throw new NotFoundException (String.valueOf (id));
		} finally {
			LibMisc.closeAll (roomVars, roomRS, getRoomVars, getRoom, con);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public Room loadRecord (final String identifier) throws NotFoundException {
		Connection con = null;
		PreparedStatement getRoom = null;
		PreparedStatement getRoomVars = null;
		ResultSet roomRS = null;
		ResultSet roomVars = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getRoom = con.prepareStatement ("SELECT * FROM roomList WHERE moniker=?");
			getRoom.setString (1, identifier);
			roomRS = getRoom.executeQuery ();
			return set (roomRS);
		} catch (final SQLException e) {
			throw new NotFoundException (identifier);
		} finally {
			LibMisc.closeAll (roomVars, roomRS, getRoomVars, getRoom, con);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final Room record) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final Room record) {
		// TODO Auto-generated method stub brpocock@star-hope.org

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final Room record) {
		// log.debug ("", record.getDebugName (), "",
		// "Not saving room record to database", false);
		record.markAsSaved ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param roomListResults WRITEME
	 * @param roomVarResults WRITEME
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 */
	private Room set (final ResultSet roomListResults) throws SQLException {
		final Room rec = new Room (this);
		roomListResults.next ();
		rec.setMoniker (roomListResults.getString ("moniker"));
		rec.setTitle (roomListResults.getString ("title"));
		rec.setID (roomListResults.getInt ("ID"));
		rec.setAutoCreate ("Y".equals (roomListResults.getString ("autocreate")));
		rec.markAsLoaded ();
		return rec;
	}

}
