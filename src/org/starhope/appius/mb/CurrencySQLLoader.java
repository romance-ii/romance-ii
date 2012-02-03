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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.mb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.DataException;
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
public class CurrencySQLLoader implements RecordLoader <Currency> {

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final Currency changedRecord) {
		DataRecordFlushManager.update (this, changedRecord);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param resultSet WRITEME
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 * @throws DataException WRITEME
	 */
	protected Currency from (final ResultSet resultSet)
			throws DataException, SQLException {
		resultSet.next ();
		Currency rec = new Currency (this);
		rec.setCode (resultSet.getString ("isoCode"));
		rec.setTitle (resultSet.getString ("name"));
		rec.setSymbol (resultSet.getString ("sym"));
		rec.markAsLoaded ();
		return rec;
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
	public Currency loadRecord (final int id) throws NotFoundException {
		throw new NotFoundException ("No numeric ID:s for currencies");
	}

	/**
	 * @param id database ID
	 * @return currency with that database ID
	 * @throws NotFoundException if it's not found in the database
	 * @throws RuntimeException if something else wonky were to happen
	 */
	@Override
	public Currency loadRecord (final String id)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT * FROM currencies WHERE isoCode=?");
			st.setString (1, id);
			rs = st.executeQuery ();
			return from (rs);
		} catch (final SQLException e) {
			throw new NotFoundException (LibMisc.stringify (e));
		} catch (DataException e) {
			throw new NotFoundException (LibMisc.stringify (e));
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}

	@Override
	public void refresh (final Currency record) {
		// TODO Auto-generated method stub
		AppiusClaudiusCaecus
				.reportBug ("unimplemented CurrencySQLLoader::refresh (brpocock@star-hope.org)");

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final Currency record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented CurrencySQLLoader::removeRecord (brpocock@star-hope.org, Jul 26, 2010)");
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final Currency record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented CurrencySQLLoader::saveRecord (brpocock@star-hope.org, Jul 26, 2010)");
	}

}
