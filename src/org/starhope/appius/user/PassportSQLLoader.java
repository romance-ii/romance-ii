/**
 * PassportSQLLoader.java (org.starhope.appius.user) Copyright © 2010,
 * Bruce-Robert Pocock This program is free software; you can
 * redistribute it and/or modify it under the terms of the GNU Affero
 * General Public License as published by the Free Software Foundation,
 * either version 3 of the License, or (at your option) any later
 * version. This program is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details. You should have received a
 * copy of the GNU Affero General Public License along with this
 * program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock Created May 5, 2010
 */
package org.starhope.appius.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.util.LibMisc;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class PassportSQLLoader implements PassportLoader {
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final Passport changedRecord) {
		DataRecordFlushManager.update (this, changedRecord);
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#initializeStorage(java.lang.String)
	 */
	@Override
	public void initializeStorage (final String storageURL)
			throws NotReadyException {
		// No op, handled by AppiusConfig
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
	public Passport loadRecord (final int id) throws NotFoundException {
		final Passport passport = new Passport ();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		passport.setRecordLoader (this);
		passport.setOwnerID (id);
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT moniker FROM userWorlds LEFT JOIN roomList ON worldID=roomList.ID WHERE userID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			while (rs.next ()) {
				passport.visited (rs.getString ("moniker"));
			}
			passport.setRecordLoader (this);
			passport.markAsLoaded ();
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return passport;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public Passport loadRecord (final String identifier)
			throws NotFoundException {
		final Passport passport = new Passport ();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		passport.setRecordLoader (this);
		passport.setOwnerID (Nomenclator
				.getUserIDForLogin (identifier));
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT moniker FROM userWorlds LEFT JOIN roomList ON worldID=roomList.ID LEFT JOIN users ON userID=users.ID WHERE userName=?");
			st.setString (1, identifier);
			rs = st.executeQuery ();
			while (rs.next ()) {
				passport.visited (rs.getString ("moniker"));
			}
			
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		passport.markAsSaved ();
		return passport;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final Passport record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final Passport record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"unimplemented RecordLoader<Passport>::removeRecord (brpocock@star-hope.org, Jul 22, 2010)");
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final Passport record) {
		Connection con = null;
		PreparedStatement st = null;
		final ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("INSERT IGNORE INTO userWorlds (userID, worldID) SELECT ?, ID FROM roomList WHERE moniker=?");
			st.setInt (1, record.getOwnerID ());
			for (final String moniker : record.getVisitedRooms ()) {
				st.setString (2, moniker);
				st.execute ();
			}
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		record.markAsSaved ();
	}
	
}
