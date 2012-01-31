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
 * Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public
 * License along with this program. If not, see
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
package org.starhope.appius.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class UserVarSQLLoader implements RecordLoader <UserVar> {
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final UserVar changedRecord) {
		DataRecordFlushManager.update (this, changedRecord);
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
	public void initializeStorage (final String storageURL)
			throws NotReadyException {
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
	public UserVar loadRecord (final int id) throws NotFoundException {
		return loadRecord (new UserVar (this), id);
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public UserVar loadRecord (final String identifier)
			throws NotFoundException {
		return loadRecord (new UserVar (this),
				Integer.valueOf (identifier).intValue ());
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param userVar WRITEME 
	 * @param moniker WRITEME 
	 * @return WRITEME 
	 * @throws NotFoundException
	 */
	private UserVar loadRecord (final UserVar userVar, final int userID)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement getVars = null;
		ResultSet vars = null;
		userVar.markForReload ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getVars = con
					.prepareStatement ("SELECT * FROM userVars WHERE userID=?");
			getVars.setInt (1, userID);
			try {
				vars = getVars.executeQuery ();
				set (userVar, vars);
			} catch (final SQLException e) {
				// Ignore a null result
			}
			userVar.setUserID (userID);
			userVar.markAsLoaded ();
			return userVar;
		} catch (final SQLException e) {
			throw new NotFoundException ("userID = " + userID);
		} catch (final Throwable e) {
			throw new RuntimeException ("userVar load error", e);
		} finally {
			LibMisc.closeAll (vars, getVars, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final UserVar record) {
		record.markForReload ();
		try {
			loadRecord (record, record.getUserID ());
		} catch (final NotFoundException e) {
			UserVarSQLLoader.log
					.error ("Got an error trying to reload a record that doesn't exist!",
							e);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final UserVar record) {
		Connection con = null;
		PreparedStatement st = null;
		
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("DELETE FROM userVars WHERE userID=?");
			st.setInt (1, record.getUserID ());
			try {
				st.executeUpdate ();
			} catch (final SQLException e2) {
				UserVarSQLLoader.log.error (
						"Caught an SQLException in UserVar::removeRecord on "
								+ record.getUserID (), e2);
			}
			record.markAsSaved ();
		} catch (final SQLException e1) {
			UserVarSQLLoader.log
					.error ("Caught a SQLException in UserVar::removeRecord ",
							e1);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final UserVar record) {
		Connection con = null;
		PreparedStatement st = null;
		
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("DELETE FROM userVars WHERE userID=? AND keyName=?");
			st.setInt (1, record.getUserID ());
			for (final String e : record.getRemovedVars ()) {
				st.setString (2, e);
				try {
					st.executeUpdate ();
				} catch (final SQLException e2) {
					UserVarSQLLoader.log.error (
							"Caught an SQLException in UserVar::saveRecord on deleting "
									+ e, e2);
				}
			}
			st = con.prepareStatement ("INSERT INTO userVars (userID, keyName, value) VALUES (?,?,?) ON DUPLICATE KEY UPDATE value=Values(value)");
			st.setInt (1, record.getUserID ());
			for (final String e : record.getChangedVars ()) {
				st.setString (2, e);
				final String value = record.getVariable (e);
				st.setString (3, value);
				try {
					st.executeUpdate ();
				} catch (final SQLException e2) {
					UserVarSQLLoader.log.error (
							"Caught an SQLException in UserVar::saveRecord on changing "
									+ e, e2);
				}
			}
			record.markAsSaved ();
		} catch (final SQLException e1) {
			UserVarSQLLoader.log
					.error ("Caught a SQLException in UserVar::saveRecord ",
							e1);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}
	
	/**
	 * sets the values in the result set on the game variable object
	 * 
	 * @param userVar WRITEME 
	 * @param vars WRITEME 
	 * @return WRITEME 
	 * @throws SQLException
	 */
	private UserVar set (final UserVar userVar, final ResultSet vars)
			throws SQLException {
		while (vars.next ()) {
			userVar.setVariable (vars.getString ("keyName"),
					vars.getString ("value"));
		}
		userVar.markAsLoaded ();
		return userVar;
	}
	
}
