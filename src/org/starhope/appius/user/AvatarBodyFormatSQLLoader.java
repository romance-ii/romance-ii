/**
 * <p>
 * Copyright © 2010-2012 Bruce-Robert Pocock
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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
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
public class AvatarBodyFormatSQLLoader implements
		RecordLoader <AvatarBodyFormat> {
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final AvatarBodyFormat changedRecord) {
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
	 * Actually parse the SQL record into the DataRecord
	 * 
	 * @param body record to be loaded
	 * @param rs result set from which to load
	 * @return the record, loaded with the values from the result set
	 * @throws SQLException if the record can't be parsed
	 */
	private AvatarBodyFormat load (final AvatarBodyFormat body,
			final ResultSet rs) throws SQLException {
		body.setID (rs.getInt ("id"));
		body.setName (rs.getString ("name"));
		body.markAsLoaded ();
		return body;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
	 */
	@Override
	public AvatarBodyFormat loadRecord (final int id)
			throws NotFoundException {
		java.sql.Connection con = null;
		ResultSet rs = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM avatarBodyFormats WHERE id=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			rs.next ();
			final AvatarBodyFormat body = new AvatarBodyFormat (this);
			return load (body, rs);
		} catch (final SQLException e) {
			throw new NotFoundException (e);
		} finally {
			LibMisc.closeAll (st, rs, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public AvatarBodyFormat loadRecord (final String identifier)
			throws NotFoundException {
		java.sql.Connection con = null;
		ResultSet rs = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM avatarBodyFormats WHERE name=?");
			st.setString (1, identifier);
			rs = st.executeQuery ();
			rs.next ();
			final AvatarBodyFormat body = new AvatarBodyFormat (this);
			return load (body, rs);
		} catch (final SQLException e) {
			throw new NotFoundException (e);
		} finally {
			LibMisc.closeAll (st, rs, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final AvatarBodyFormat record) {
		java.sql.Connection con = null;
		ResultSet rs = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM avatarBodyFormats WHERE id=?");
			st.setInt (1, record.getID ());
			rs = st.executeQuery ();
			rs.next ();
			record.markForReload ();
			load (record, rs);
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
					.reportBug ("Record can't be found to refresh");
		} finally {
			LibMisc.closeAll (st, rs, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final AvatarBodyFormat record) {
		java.sql.Connection con = null;
		ResultSet rs = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("DELETE FROM avatarBodyFormats WHERE id=?");
			st.setInt (1, record.getID ());
			rs = st.executeQuery ();
		} catch (final SQLException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a SQLException in AvatarBodyFormatSQLLoader.removeRecord ",
							e);
		} finally {
			LibMisc.closeAll (st, rs, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final AvatarBodyFormat record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented RecordLoader<AvatarBodyFormat>::saveRecord (brpocock@star-hope.org, Sep 21, 2010)");
		
	}
	
}
