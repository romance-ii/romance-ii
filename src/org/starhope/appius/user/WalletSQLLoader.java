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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.user;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;


/**
 * @author brpocock@star-hope.org
 *
 */
public class WalletSQLLoader implements RecordLoader <Wallet> {


	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final Wallet changedRecord) {
		DataRecordFlushManager.update (this, changedRecord);
	}

	/**
	 * @param id the user ID
	 * @return the current peanut balance of all that user's events
	 */
	private BigDecimal getPeanutsFromEvents (final int id) {
		BigDecimal peanuts = BigDecimal.ZERO;

		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT SUM(peanuts) AS peanuts FROM events WHERE creatorID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			if (rs.next ()) {
				BigDecimal peanutTrueValue = rs
						.getBigDecimal ("peanuts");
				if (rs.wasNull ()) {
					peanutTrueValue = BigDecimal.ZERO;
				}
				peanuts = peanutTrueValue.compareTo (BigDecimal
						.valueOf (99999)) > 0 ? BigDecimal
						.valueOf (99999) : peanutTrueValue;
			}

		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a SQLException in getPeanuts", e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return peanuts;
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
	throws NotReadyException
	{
		// no op
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#isRealtime()
	 */
	@Override
	public boolean isRealtime () {
		return true;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
	 */
	@Override
	public Wallet loadRecord (final int id) throws NotFoundException {
		BigDecimal peanuts = getPeanutsFromEvents (id);

		Wallet w = new Wallet (Nomenclator.getDataRecord (
				UserRecord.class, id));
		w.put (Currency.getPeanuts (), peanuts);
		return w;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public Wallet loadRecord (final String identifier)
	throws NotFoundException
	{
		return loadRecord (Nomenclator.getUserIDForLogin (identifier));
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final Wallet record) {
		record.put (Currency.getPeanuts (),
				getPeanutsFromEvents (record.getCacheableID ()));
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final Wallet record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus.reportBug("unimplemented RecordLoader<Wallet>::removeRecord (brpocock@star-hope.org, Jul 22, 2010)");

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final Wallet record) {
		// unused.
		record.markAsSaved ();
	}

}
