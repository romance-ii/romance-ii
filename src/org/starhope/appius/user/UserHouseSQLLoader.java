/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, brpocock@star-hope.org
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
package org.starhope.appius.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Room;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class UserHouseSQLLoader implements UserHouseRecordLoader {
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final UserHouse changedRecord) {
		DataRecordFlushManager.update (this, changedRecord);
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#initializeStorage(java.lang.String)
	 */
	@Override
	public void initializeStorage (final String storageURL)
			throws NotReadyException {
		// No op. AppiusConfig does this for us.
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
	public UserHouse loadRecord (final int id)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement getHouse = null;
		PreparedStatement getRooms = null;
		UserHouse record = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getHouse = con
					.prepareStatement ("SELECT * FROM userHouses WHERE userID=?");
			getHouse.setInt (1, id);
			record = setHouse (getHouse);
			getRooms = con
					.prepareStatement ("SELECT roomID FROM userRooms WHERE userID=?");
			getRooms.setInt (1, id);
			setRooms (record, getRooms);
		} catch (final SQLException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a SQLException in UserHouseSQLLoader.loadRecord ",
							e);
		} finally {
			LibMisc.closeAll (getRooms, getHouse, con);
		}
		return record;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public UserHouse loadRecord (final String identifier)
			throws NotFoundException {
		return loadRecord (Nomenclator.getUserIDForLogin (identifier));
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final UserHouse record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final UserHouse record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented RecordLoader<UserHouse>::removeRecord (brpocock@star-hope.org, Jul 22, 2010)");
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final UserHouse record) {
		// Connection con = null;
		// PreparedStatement st = null;
		// ResultSet keys = null;
		// try {
		// con = AppiusConfig.getDatabaseConnection ();
		// st = con.prepareStatement ("");
		// st.execute ();
		// if (1>id) {
		// keys = st.getGeneratedKeys ();
		// keys.next ();
		// record.set
		// }
		// } catch (SQLException e) {
		// BugReporter.getReporter("srv").reportBug
		// ("Caught a SQLException in UserHouseSQLLoader.saveRecord ",
		// e);
		// } finally {
		// LibMisc.closeAll (keys, st, con);
		// }
		//
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param getHouse WRITEME
	 * @return WRITEME
	 */
	private UserHouse setHouse (final PreparedStatement getHouse) {
		ResultSet rs = null;
		UserHouse house = null;
		try {
			rs = getHouse.executeQuery ();
			rs.next ();
			house = new UserHouse (Nomenclator.getUserByID (rs
					.getInt ("userID")));
			house.setLotID (rs.getInt ("lotID"));
			house.setHouseTypeID (rs.getInt ("houseID"));
		} catch (final SQLException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a SQLException in UserHouseSQLLoader.setHouse ",
							e);
		} finally {
			LibMisc.closeAll (rs);
		}
		return house;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param record WRITEME
	 * @param getRooms WRITEME
	 */
	private void setRooms (final UserHouse record,
			final PreparedStatement getRooms) {
		ResultSet rs = null;
		AbstractUser owner = null;
		try {
			rs = getRooms.executeQuery ();
			
			owner = record.getOwner ();
			while (rs.next ()) {
				final int roomID = rs.getInt ("roomID");
				try {
					record.put (Integer.valueOf (roomID),
							Room.initUserRoom (owner, roomID));
				} catch (final NotReadyException e) {
					BugReporter
							.getReporter ("srv")
							.reportBug (
									"Caught a NotReadyException in UserHouseSQLLoader.setRooms ",
									e);
				}
			}
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} finally {
			LibMisc.closeAll (rs);
		}
	}
}
