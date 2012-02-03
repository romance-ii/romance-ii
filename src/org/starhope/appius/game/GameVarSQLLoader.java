/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
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
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author ewinkelman
 */
package org.starhope.appius.game;

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
 * @author ewinkelman
 *
 */
public class GameVarSQLLoader implements RecordLoader <GameVar> {
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2223 $";
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (GameVar changedRecord) {
		DataRecordFlushManager.update (this, changedRecord);
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#initializeStorage(java.lang.String)
	 */
	@Override
	public void initializeStorage (String storageURL)
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
	public GameVar loadRecord (int id) throws NotFoundException {
		throw new NotFoundException ("GameVars don't have numeric IDs");
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public GameVar loadRecord (String identifier)
			throws NotFoundException {
		return loadRecord (new GameVar (this), identifier);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param gameVar
	 * @param identifier
	 * @return
	 * @throws NotFoundException
	 */
	private GameVar loadRecord (GameVar gameVar, String identifier)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement getVars = null;
		ResultSet vars = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getVars = con
					.prepareStatement ("SELECT * FROM gameVars WHERE klass=?");
			getVars.setString (1, identifier);
			vars = getVars.executeQuery ();
			set (gameVar, vars);
			gameVar.setMoniker (identifier);
			return gameVar;
		} catch (final SQLException e) {
			throw new NotFoundException (identifier);
		} catch (final Throwable e) {
			throw AppiusClaudiusCaecus.fatalBug ("gameVar load error",
					e);
		} finally {
			LibMisc.closeAll (vars, getVars, con);
		}
	}
	
	/**
	 * sets the values in the result set on the game variable object
	 * 
	 * @param gameVar
	 * @param vars
	 * @return
	 * @throws SQLException
	 */
	private GameVar set (GameVar gameVar, ResultSet vars)
			throws SQLException {
		while (vars.next ()) {
			gameVar.setVariable (vars.getString ("var"),
					vars.getString ("value"));
		}
		gameVar.markAsLoaded ();
		return gameVar;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (GameVar record) {
		record.markForReload ();
		try {
			loadRecord (record, record.getMoniker ());
		} catch (NotFoundException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Got an error trying to reload a record that doesn't exist!");
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (GameVar record) {
		Connection con = null;
		PreparedStatement st = null;
		
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("DELETE FROM gameVars WHERE klass=?");
			st.setString (1, record.getMoniker ());
			try {
				st.executeUpdate ();
			} catch (final SQLException e2) {
				AppiusClaudiusCaecus.reportBug (
						"Caught an SQLException in GameVar::removeRecord on "
								+ record.getMoniker (), e2);
			}
			record.markAsSaved ();
		} catch (final SQLException e1) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a SQLException in GameVar::removeRecord ",
					e1);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (GameVar record) {
		Connection con = null;
		PreparedStatement st = null;
		
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("DELETE FROM gameVars WHERE klass=? AND var=?");
			st.setString (1, record.getMoniker ());
			for (final String e : record.getRemovedVars ()) {
				st.setString (2, e);
				try {
					st.executeUpdate ();
				} catch (final SQLException e2) {
					AppiusClaudiusCaecus.reportBug (
							"Caught an SQLException in GameVar::saveRecord on deleting "
									+ e, e2);
				}
			}
			st = con.prepareStatement ("INSERT INTO gameVars (klass, var, value) VALUES (?,?,?) ON DUPLICATE KEY UPDATE value=Values(value)");
			st.setString (1, record.getMoniker ());
			for (final String e : record.getChangedVars ()) {
				st.setString (2, e);
				final String value = record.getVariable (e);
				st.setString (3, value);
				try {
					st.executeUpdate ();
				} catch (final SQLException e2) {
					AppiusClaudiusCaecus.reportBug (
							"Caught an SQLException in GameVar::saveRecord on changing "
									+ e, e2);
				}
			}
			record.markAsSaved ();
		} catch (final SQLException e1) {
			AppiusClaudiusCaecus.reportBug (
							"Caught a SQLException in GameVar::saveRecord ",
							e1);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}
	
}
