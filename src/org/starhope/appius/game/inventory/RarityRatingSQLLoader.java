/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.game.inventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 * 
 * @author brpocock@star-hope.org
 */
public class RarityRatingSQLLoader implements
RecordLoader <RarityRating> {

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final RarityRating changedRecord) {
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
	public RarityRating loadRecord (final int id) throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM itemRarities WHERE ID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			return set (rs);
		} catch (final SQLException e) {
			throw new NotFoundException (e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public RarityRating loadRecord (final String identifier)
	throws NotFoundException {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
		.reportBug ("unimplemented RarityRatingSQLLoader::loadRecord (brpocock@star-hope.org, Aug 6, 2010)");
		return null;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final RarityRating record) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("DELETE FROM itemRarities WHERE ID=?");
			st.setInt (1, record.getID ());
			st.execute ();
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
			.reportBug (
					"Caught a SQLException in RarityRatingSQLLoader.removeRecord ",
					e);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final RarityRating record) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("INSERT INTO itemRarities (ID,name,description) VALUES (?,?,?) ON DUPLICATE KEY UPDATE SET name=Values(name),description=Values(description)");
			st.setInt (1, record.getID ());
			st.setString (2, record.getValue ());
			st.setString (3, record.getDescription ());
			st.execute ();
			record.markAsSaved ();
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
			.reportBug (
					"Caught a SQLException in RarityRatingSQLLoader.saveRecord ",
					e);
		} finally {
			LibMisc.closeAll (st, con);
		}

	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param rs WRITEME
	 * @return WRITETE
	 * @throws SQLException WRITEME
	 */
	private RarityRating set (final ResultSet rs) throws SQLException {
		final RarityRating rec = new RarityRating (this);
		rs.next ();
		rec.setID (rs.getInt("ID"));
		rec.setValue (rs.getString("name"));
		rec.setDescription (rs.getString ("description"));
		rec.markAsLoaded ();
		return rec;
	}

    @Override
    public void refresh (RarityRating record) {
        // TODO Auto-generated method stub
        
    }

}
