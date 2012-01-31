/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
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
package org.starhope.appius.game.events;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.HasSubversionRevision;
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
 *
 */
public class OutcomeCurrenciesSQLLoader implements HasSubversionRevision, RecordLoader <OutcomeCurrencies> {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (OutcomeCurrenciesSQLLoader.class);

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final OutcomeCurrencies changedRecord) {
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
		// Nothing to do
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#isRealtime()
	 */
	@Override
	public boolean isRealtime () {
		return false;
	}

	/**
	 * @throws NotFoundException
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
	 */
	@Override
	public OutcomeCurrencies loadRecord (final int id) throws NotFoundException {
		final OutcomeCurrencies newRecord = new OutcomeCurrencies ();
		newRecord.setOutcomeID (id);
		return loadRecord (id, newRecord);
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param id WRITEME 
	 * @param record WRITEME 
	 * @return WRITEME 
	 * @throws NotFoundException
	 */
	private OutcomeCurrencies loadRecord (final int id, final OutcomeCurrencies record) throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM outcomeCurrencies WHERE outcomeID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			set (record, rs);
		} catch (final SQLException e) {
			OutcomeCurrenciesSQLLoader.log.error ("SQL exception loading outcomeCurrencies for outcome " + id, e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return record;
	}

	/**
	 * @throws NotFoundException
	 * @throws NumberFormatException
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public OutcomeCurrencies loadRecord (final String identifier) throws NumberFormatException, NotFoundException {
		return loadRecord (Integer.valueOf (identifier).intValue ());
	}

	/**
	 * @throws NotFoundException
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final OutcomeCurrencies record) {
		try {
			loadRecord (record.getOutcomeID (), record);
		} catch (NotFoundException e) {
			OutcomeCurrenciesSQLLoader.log.error ("Exception",e);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final OutcomeCurrencies record) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final OutcomeCurrencies record) {
		// TODO Auto-generated method stub

	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param record WRITEME 
	 * @param rs WRITEME 
	 * @throws SQLException
	 * @throws NotFoundException
	 */
	private void set (final OutcomeCurrencies record, final ResultSet rs) throws SQLException, NotFoundException {
		record.markForReload ();
		while (rs.next ()) {
			final Currency currency = Nomenclator.getDataRecord (Currency.class, rs.getString ("currency"));
			record.setCurrency (currency, rs.getBigDecimal ("rewardRatio"), rs.getInt ("weight"),
					rs.getInt ("maxCount"), rs.getInt ("randMin"), rs.getInt ("randMax"));
		}
		record.markAsLoaded ();
	}

}
