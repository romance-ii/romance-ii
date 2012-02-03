/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.appius.sys.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class CapabilityRecordsSQLLoader implements
		RecordLoader <CapabilityRecords> {

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final CapabilityRecords changedRecord) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented CapabilityRecordsSQLLoader::changed (brpocock@star-hope.org, Jun 7, 2010)");
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented CapabilityRecordsSQLLoader::getSubversionRevision (brpocock@star-hope.org, Jun 7, 2010)");
		return null;
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
	public synchronized CapabilityRecords loadRecord (final int id)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT userID, capabilityID FROM userCapabilities");
			rs = st.executeQuery ();
			CapabilityRecords rec = new CapabilityRecords (this);
			while (rs.next ()) {
				rec.addCapability (Nomenclator.getUserByID (rs
						.getInt ("userID")), new SecurityCapability (rs
						.getInt ("capabilityID")));
			}
			rec.markAsLoaded ();
			return rec;
		} catch (SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a SQLException in CapabilityRecordsSQLLoader.loadRecord ",
							e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		throw new NotFoundException ("");
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public CapabilityRecords loadRecord (final String identifier)
			throws NotFoundException {
		return loadRecord (Nomenclator.getUserIDForLogin (identifier));
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final CapabilityRecords record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus.reportBug("unimplemented RecordLoader<CapabilityRecords>::removeRecord (brpocock@star-hope.org, Jul 22, 2010)");

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final CapabilityRecords record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented CapabilityRecordsSQLLoader::saveRecord (brpocock@star-hope.org, Jun 7, 2010)");

	}

    @Override
    public void refresh (CapabilityRecords record) {
        // TODO Auto-generated method stub
        
    }

}
