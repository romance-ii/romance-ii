/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
package org.starhope.appius.mb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.util.AppiusConfig;
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
public class EnrolmentSQLLoader implements RecordLoader <Enrolment> {
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (EnrolmentSQLLoader.class);
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final Enrolment changedRecord) {
		// TODO Auto-generated method stub brpocock@star-hope.org
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
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @param id WRITEME
	 * @return WRITEME
	 * @throws NotFoundException WRITEME
	 */
	@Override
	public Enrolment loadRecord (final int id)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM products WHERE id=?");
			st.setInt (1, id);
			st.execute ();
			rs = st.getResultSet ();
			rs.next ();
			return set (rs);
		} catch (final SQLException e) {
			EnrolmentSQLLoader.log.error ("Exception", e);
			throw new NotFoundException ("Product with id (" + id
					+ ") does not exist.");
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public Enrolment loadRecord (final String identifier)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM products WHERE productCode=?");
			st.setString (1, identifier);
			st.execute ();
			rs = st.getResultSet ();
			rs.next ();
			return set (rs);
		} catch (final SQLException e) {
			EnrolmentSQLLoader.log.error ("Exception", e);
			throw new NotFoundException ("Product with code ("
					+ identifier + ") does not exist.");
		} finally {
			LibMisc.closeAll (rs, st, con);
			
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final Enrolment record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final Enrolment record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final Enrolment record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param rs WRITEME
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 */
	protected Enrolment set (final ResultSet rs) throws SQLException {
		final Enrolment enrolment = new Enrolment (this);
		enrolment.setID (rs.getInt ("id"));
		enrolment.setProductCode (rs.getString ("productCode"));
		enrolment.setPrice (rs.getBigDecimal ("price"));
		enrolment.setRenewalMonths (rs.getInt ("renewMonths"));
		enrolment.setRenewalDays (rs.getInt ("days"));
		final String autoRenew = rs.getString ("autoRenew");
		enrolment.setAutoRenewed ("Y".equals (autoRenew));
		enrolment.setAutoRenewalAsk ("A".equals (autoRenew));
		enrolment.setAvailable ("Y".equals (rs
				.getString ("available")));
		enrolment.setTitle (rs.getString ("title"));
		enrolment.markAsLoaded ();
		return enrolment;
	}
}
