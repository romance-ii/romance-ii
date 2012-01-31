/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map.Entry;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
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
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
	 */
	@Override
	public Wallet loadRecord (final int id) throws NotFoundException {
		final Wallet newWallet = new Wallet (this);
		newWallet.setOwner (id);
		return loadRecord (id, newWallet);
	}
	
	/**
	 * Loads a wallet for a user
	 * 
	 * @param id User ID
	 * @param wallet The wallet record being loaded
	 * @return The wallet that was loaded
	 * @throws NotFoundException
	 */
	private Wallet loadRecord (final int id, final Wallet wallet)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement getWallet = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getWallet = con
					.prepareStatement ("SELECT * FROM wallet where userID=?");
			getWallet.setInt (1, id);
			rs = getWallet.executeQuery ();
			return set (rs, wallet);
		} catch (final SQLException e) {
			throw new NotFoundException ("User ID " + id
					+ " not found loading wallet");
		} finally {
			LibMisc.closeAll (rs, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public Wallet loadRecord (final String identifier)
			throws NotFoundException {
		return loadRecord (Nomenclator.getUserIDForLogin (identifier));
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final Wallet record) {
		// No refresh for wallets
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final Wallet record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented RecordLoader<Wallet>::removeRecord (brpocock@star-hope.org, Jul 22, 2010)");
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final Wallet record) {
		Connection con = null;
		PreparedStatement st = null;
		
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("INSERT INTO wallet (userID, currency, amount) VALUES (?,?,?) ON DUPLICATE KEY UPDATE amount=Values(amount)");
			st.setInt (1, record.getOwner ().getUserID ());
			for (final Entry <Currency, Long> e : record
					.getAllCurrency ().entrySet ()) {
				st.setString (2, e.getKey ().getCode ());
				st.setLong (3, e.getValue ().longValue ());
				try {
					st.executeUpdate ();
				} catch (final SQLException e2) {
					WalletSQLLoader.log.error (
							"Caught an SQLException in Wallet::saveRecord on changing "
									+ e, e2);
				}
			}
			record.markAsSaved ();
		} catch (final SQLException e1) {
			WalletSQLLoader.log
					.error ("Caught a SQLException in Wallet::saveRecord ",
							e1);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}
	
	/**
	 * Sets the results from a query into the given wallet
	 * 
	 * @param rs Result set
	 * @param wallet Wallet
	 * @return The wallet it was set to
	 * @throws SQLException
	 */
	private Wallet set (final ResultSet rs, final Wallet wallet)
			throws SQLException {
		while (rs.next ()) {
			try {
				final Currency currency = Nomenclator
						.getDataRecord (Currency.class,
								rs.getString ("currency"));
				wallet.put (currency, rs.getLong ("amount"));
			} catch (final NotFoundException e) {
				WalletSQLLoader.log.error ("Exception", e);
			}
		}
		wallet.markAsLoaded ();
		return wallet;
	}
	
}
