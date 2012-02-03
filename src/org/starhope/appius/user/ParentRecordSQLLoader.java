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
package org.starhope.appius.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.util.LibMisc;

/**
 * load a parent record from an SQL backing-store (and save or remove
 * it, as needed)
 * 
 * @author brpocock@star-hope.org
 */
public class ParentRecordSQLLoader implements ParentRecordLoader {

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final Parent changedRecord) {
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
		// let's assume it's OK.
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#isRealtime()
	 */
	@Override
	public boolean isRealtime () {
		return false;
	}

	/**
	 * @throws NotFoundException if the record can't be loaded
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
	 */
	@Override
	public Parent loadRecord (final int id) throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement ("SELECT * FROM parents WHERE ID=?");
			st.setInt (1, id);
			return set (st);
		} catch (final SQLException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		} catch (final NotFoundException e) {
			throw e;
		} finally {
			LibMisc.closeAll (st, con);
		}
	}

	/**
	 * @throws NotFoundException if the record can't be found
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public Parent loadRecord (final String identifier)
	throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement ("SELECT * FROM parents WHERE mail=?");
			st.setString (1, identifier);
			return set (st);
		} catch (final SQLException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		} catch (final NotFoundException e) {
			throw e;
		} finally {
			LibMisc.closeAll (st, con);
		}
	}

	@Override
	public void refresh (final Parent record) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final Parent record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
		.reportBug ("unimplemented RecordLoader<Parent>::removeRecord (brpocock@star-hope.org, Jul 22, 2010)");

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final Parent record) {

		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement (
					"INSERT INTO parents (ID, mail, mailConfirmSent, mailConfirmed, canContact, givenName, password, passRecoveryQ, passRecoveryA) "
					+ "VALUES (?,?,?,?,?,?,?,?,?) "
					+ "ON DUPLICATE KEY UPDATE ID=LAST_INSERT_ID(ID),"
					+ "mail=Values(mail), mailConfirmSent=Values(mailConfirmSent), mailConfirmed=Values(mailConfirmed), "
					+ "canContact=Values(canContact), givenName=Values(givenName), password=Values(password), passRecoveryQ=Values(passRecoveryQ), passRecoveryA=Values(passRecoveryA)",
					Statement.RETURN_GENERATED_KEYS);
			if (1 > record.getID ()) {
				st.setNull (1, Types.INTEGER);
			} else {
				st.setInt (1, record.getID ());
			}
			st.setString (2, record.getMail ());
			if (null == record.getMailConfirmSent ()) {
				st.setNull (3, java.sql.Types.DATE);
			} else {
				st.setDate (3, record.getMailConfirmSent ());
			}
			if (null == record.getMailConfirmed ()) {
				st.setNull (4, java.sql.Types.DATE);
			} else {
				st.setDate (4, record.getMailConfirmed ());
			}
			st.setString (5, record.canContact () ? "Y" : "N");
			if (null == record.getGivenName ()) {
				st.setNull (6, java.sql.Types.VARCHAR);
			} else {
				st.setString (6, record.getGivenName ());
			}
			if (null == record.getPassword ()) {
				st.setNull (7, java.sql.Types.VARCHAR);
			} else {
				st.setString (7, record.getPassword ());
			}
			st.setString (8, record.getForgotPasswordQuestion ());
			st.setString (9, record.getForgotPasswordAnswer ());
			st.executeUpdate ();
			if (record.getID () <= 0) {
				final ResultSet rs = st.getGeneratedKeys ();
				rs.next ();
				record.setID (rs.getInt (1));
			}
		} catch (final SQLException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		} finally {
			LibMisc.closeAll (st, con);
		}
		record.markAsSaved ();
	}

	/**
	 * @param st WRITEME
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 * @throws NotFoundException WRITEME
	 */
	protected Parent set (final PreparedStatement st)
	throws SQLException, NotFoundException {
		final Parent p = new Parent ();
		ResultSet rs = null;
		try {
			rs = st.executeQuery ();
			if ( !rs.next ()) throw new NotFoundException ("parent");
			p.setID (rs.getInt ("id"));
			try {
				p.setMail (rs.getString ("mail"));
			} catch (final GameLogicException e) {
				AppiusClaudiusCaecus.fatalBug (e);
			}
			p.setMailConfirmSent (rs.getDate ("mailConfirmSent"));
			if (rs.wasNull ()) {
				p.setMailConfirmSent (null);
			}
			p.setMailConfirmed (rs.getDate ("mailConfirmed"));
			if (rs.wasNull ()) {
				p.setMailConfirmed (null);
			}
			p.setCanContact (rs.getString ("canContact").equals ("Y"));
			p.setGivenName (rs.getString ("givenName"));
			if (rs.wasNull ()) {
				p.setGivenName (null);
			}
			p.setPassword (rs.getString ("password"));
			if (rs.wasNull ()) {
				p.setPassword (null);
			}
			p
			.setForgotPasswordQuestion (rs
					.getString ("passRecoveryQ"));
			p.setForgotPasswordAnswer (rs.getString ("passRecoveryA"));
			p.setRecordLoader (this);
			p.markAsLoaded ();
		} catch (final SQLException e) {
			throw e;
		} catch (final NotFoundException e) {
			throw e;
		} finally {
			LibMisc.closeAll (rs);
		}
		return p;
	}

}
