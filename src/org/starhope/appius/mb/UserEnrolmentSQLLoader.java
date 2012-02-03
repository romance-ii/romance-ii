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
package org.starhope.appius.mb;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * The SQL Loader for {@link UserEnrolment} using the Tootsville
 * database schema
 * 
 * @author brpocock@star-hope.org
 */
public class UserEnrolmentSQLLoader implements
RecordLoader <UserEnrolment> {

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final UserEnrolment changedRecord) {
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
	public UserEnrolment loadRecord (final int id)
	throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement ("SELECT * FROM subscriptions WHERE id=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			rs.next ();
			return set (rs);
		} catch (final SQLException e) {
			throw new NotFoundException (String.valueOf (id));
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}

	/**
	 * @param orderNumber order source + "-" + order code
	 * @throws NotFoundException if the order doesn't already exist
	 */
	@Override
	public UserEnrolment loadRecord (final String orderNumber)
	throws NotFoundException {
		final String orderSource = UserEnrolment.getOrderSource (orderNumber);
		final String orderCode = UserEnrolment.getOrderCode (orderNumber);
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement ("SELECT * FROM subscriptions WHERE order_source=? AND order_code=?");

			st.setString (1, orderSource);
			st.setString (2, orderCode);
			rs = st.executeQuery ();
			rs.next ();
			return set (rs);
		} catch (final SQLException e) {
			throw new NotFoundException (orderNumber);
		} finally {
			LibMisc.closeAll (rs, st, con);

		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final UserEnrolment record) {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement ("SELECT * FROM subscriptions WHERE id=?");
			st.setInt (1, record.getID ());
			rs = st.executeQuery ();
			if (rs.next ()) {
				reload (record, rs);
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (
					"Database failed to find user enrolment record ID="
					+ record.getID (), e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param rec WRITEME
	 * 
	 * @param rs WRITEME
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 */
	private UserEnrolment reload (final UserEnrolment rec,
			final ResultSet rs) throws SQLException {
		rec.markForReload ();
		rec.setID (rs.getInt ("id"));
		rec.setUserID (rs.getInt ("user_id"));
		rec.setBegins (rs.getDate ("begins_at"));
		rec.setExpires (rs.getDate ("expires_at"));
		rec.setOrderSource (rs.getString ("order_source"));
		rec.setOrderCode (rs.getString ("order_code"));
		rec.setProductID (rs.getInt ("product_id"));
		rec.setAuthSubID (rs.getBigDecimal ("auth_sub_id"));
		if (rs.wasNull ()) {
			rec.setAuthSubID ((BigDecimal) null);
		}
		rec.markAsLoaded ();
		return rec;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final UserEnrolment record) {
		AppiusClaudiusCaecus
		.reportBug ("unimplemented UserEnrolmentSQLLoader::removeRecord (brpocock@star-hope.org, Jul 23, 2010)");

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final UserEnrolment record) {
		// System.err.println ("Flushing enrolments");
		// System.err.println ("begins: " + record.getBegins ());
		// System.err.println ("expires: " + record.getExpires());
		// System.err.println ("for id: " + record.getUserID ());
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement ("UPDATE subscriptions SET user_id=?, begins_at=?, expires_at=?, product_id=?, auth_sub_id=? WHERE order_source=? AND order_code=?");
			st.setInt (1, record.getUserID ());
			st.setDate (2, record.getBegins ());
			st.setDate (3, record.getExpires ());
			st.setInt (4, record.getProductID ());
			if (null == record.getAuthSubID ()) {
				st.setNull (5, Types.DECIMAL);
			} else {
				st.setBigDecimal (5, record.getAuthSubID ());
			}
			st.setString (6, record.getOrderSource ());
			st.setString (7, record.getOrderCode ());
			st.execute ();
			record.markAsSaved ();
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.fatalBug (e);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param rs WRITEME
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 */
	public UserEnrolment set (final ResultSet rs) throws SQLException {
		final UserEnrolment rec = new UserEnrolment (this);
		return reload (rec, rs);
	}

}
