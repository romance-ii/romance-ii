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
package org.starhope.appius.game;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class RoomSQLLoader implements RecordLoader <Room> {
	
	/**
	 * XXX contains SQL
	 * 
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
						everywhere.add (Nomenclator.getDataRecord (
								Room.class,
								rs.getString ("moniker")));
					} catch (final NotFoundException e) {
						BugReporter.getReporter ("srv").reportBug{
							BugReporter.getReporter("srv").reportBug (e);
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
		DataRecordFlushManager.update (this, changedRecord);
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2225 $";
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#initializeStorage(java.lang.String)
	 */
	@Override
	public void initializeStorage (final String storageURL)
			throws NotReadyException {
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
			getRoom = con
					.prepareStatement ("SELECT * FROM roomList WHERE ID=?");
			getRoom.setInt (1, id);
			roomRS = getRoom.executeQuery ();
			getRoomVars = con
					.prepareStatement ("SELECT * FROM roomVars WHERE room=(SELECT moniker FROM roomList WHERE ID=?)");
			getRoomVars.setInt (1, id);
			roomVars = getRoomVars.executeQuery ();
			return set (roomRS, roomVars);
		} catch (final SQLException e) {
			throw new NotFoundException (String.valueOf (id));
		} catch (final Throwable e) {
			throw AppiusClaudiusCaecus.fatalBug ("room load hatred",
					e);
		} finally {
			LibMisc.closeAll (roomVars, roomRS, getRoomVars,
					getRoom, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public Room loadRecord (final String identifier)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement getRoom = null;
		PreparedStatement getRoomVars = null;
		ResultSet roomRS = null;
		ResultSet roomVars = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getRoom = con
					.prepareStatement ("SELECT * FROM roomList WHERE moniker=?");
			getRoom.setString (1, identifier);
			roomRS = getRoom.executeQuery ();
			getRoomVars = con
					.prepareStatement ("SELECT * FROM roomVars WHERE room=?");
			getRoomVars.setString (1, identifier);
			roomVars = getRoomVars.executeQuery ();
			return set (roomRS, roomVars);
		} catch (final SQLException e) {
			throw new NotFoundException (identifier);
		} finally {
			LibMisc.closeAll (roomVars, roomRS, getRoomVars,
					getRoom, con);
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
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"unimplemented RoomSQLLoader::removeRecord (brpocock@star-hope.org, Aug 6, 2010)");
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final Room record) {
		// AppiusClaudiusCaecus.blather ("", record.getDebugName (),
		// "",
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
	private Room set (final ResultSet roomListResults,
			final ResultSet roomVarResults) throws SQLException {
		final Room rec = new Room (this);
		roomListResults.next ();
		rec.setFilename (roomListResults.getString ("filename"));
		rec.setMoniker (roomListResults.getString ("moniker"));
		rec.setSky (roomListResults.getString ("sky"));
		rec.setOverlay (roomListResults.getString ("overlay"));
		rec.setSkyVisible ("Y".equals (roomListResults
				.getString ("skyVisible")));
		rec.setMusic (roomListResults.getString ("music"));
		rec.setTitle (roomListResults.getString ("title"));
		rec.setID (roomListResults.getInt ("ID"));
		rec.setVariables (setRoomVars (roomVarResults));
		rec.markAsLoaded ();
		return rec;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param roomVarResults WRITEME
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 */
	private Map <String, String> setRoomVars (
			final ResultSet roomVarResults) throws SQLException {
		final Map <String, String> vars = new HashMap <String, String> ();
		while (roomVarResults.next ()) {
			vars.put (roomVarResults.getString ("keyName"),
					roomVarResults.getString ("value"));
		}
		return vars;
	}
	
}
