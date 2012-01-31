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
package org.starhope.appius.user;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public abstract class UserListSQLIterator extends UserListIterator {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private Connection con = null;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private boolean hasNext = true;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private UserListEntry next;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private ResultSet rs = null;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private java.sql.PreparedStatement st = null;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param user WRITEME
	 * @param listMoniker WRITEME
	 */
	public UserListSQLIterator (final AbstractUser user,
			final String listMoniker) {
		super (user, listMoniker);
		initSQL ();
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final UserListEntry changedRecord) {
		DataRecordFlushManager.update (this, changedRecord);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private void fetchNext () {
		if (null != rs) {
			try {
				final boolean got = rs.next ();
				if ( !got) {
					hasNext = false;
					next = null;
					return;
				}
				next = new SimpleUserListEntry (this, userLogin,
						moniker, rs.getString ("otherName"));
			} catch (final SQLException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a SQLException in UserListSQLIterator.fetchOne ",
								e);
				LibMisc.closeAll (rs, st, con);
				rs = null;
				st = null;
				con = null;
			}
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	protected abstract String getSQL ();
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Revision: 2293 $";
	}
	
	/**
	 * @see java.util.Iterator#hasNext()
	 */
	@Override
	public boolean hasNext () {
		return hasNext;
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
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private void initSQL () {
		LibMisc.closeAll (rs, st, con);
		con = null;
		st = null;
		rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement (getSQL ());
			st.setInt (1, userID);
			rs = st.executeQuery ();
		} catch (final SQLException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a SQLException in UserListSQLIterator.initSQL ",
							e);
			LibMisc.closeAll (rs, st, con);
			rs = null;
			st = null;
			con = null;
		}
		fetchNext ();
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
	public UserListEntry loadRecord (final int id)
			throws NotFoundException {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented RecordLoader<UserListEntry>::loadRecord (brpocock@star-hope.org, Aug 17, 2010)");
		return null;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public UserListEntry loadRecord (final String identifier)
			throws NotFoundException {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented RecordLoader<UserListEntry>::loadRecord (brpocock@star-hope.org, Aug 17, 2010)");
		return null;
	}
	
	/**
	 * @see java.util.Iterator#next()
	 */
	@Override
	public UserListEntry next () {
		if ( !hasNext) {
			return null;
		}
		final UserListEntry now = next;
		fetchNext ();
		return now;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final UserListEntry record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented RecordLoader<UserListEntry>::removeRecord (brpocock@star-hope.org, Aug 17, 2010)");
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final UserListEntry record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented RecordLoader<UserListEntry>::saveRecord (brpocock@star-hope.org, Aug 17, 2010)");
		
	}
	
}
