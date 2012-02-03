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
package org.starhope.appius.user;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class UserBuddyListSQLIterator extends UserListSQLIterator {
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param user WRITEME
	 */
	public UserBuddyListSQLIterator (final AbstractUser user) {
		super (user, "$buddy");
	}

	/**
	 * @see org.starhope.appius.user.UserListIterator#add(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void add (final AbstractUser user) {
		add (user.getUserID ());
	}

	/**
	 * @param buddyID user ID to befriend
	 */
	public void add (final int buddyID) {
		Connection con = null;
		java.sql.PreparedStatement st = null;
		final ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement ("INSERT IGNORE INTO buddyList (userID, buddyID) VALUES (?,?)");
			st.setInt (1, userID);
			st.setInt (2, buddyID);
			st.executeUpdate ();
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a SQLException in UserBuddyListSQLIterator.add ("
					+ userID + "," + buddyID + ")", e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}

	/**
	 * @see org.starhope.appius.user.UserListSQLIterator#getSQL()
	 */
	@Override
	protected String getSQL () {
		return "SELECT userName AS otherName FROM buddyList LEFT JOIN users ON users.ID=buddyList.buddyID WHERE userID=?";
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final UserListEntry record) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.starhope.appius.user.UserListIterator#remove(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void remove (final AbstractUser interestingFellow) {
		final int buddyID = interestingFellow.getUserID ();
		Connection con = null;
		java.sql.PreparedStatement st = null;
		final ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement ("DELETE FROM buddyList  WHERE userID=? AND buddyID = ?");
			st.setInt (1, userID);
			st.setInt (2, buddyID);
			st.executeUpdate ();
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a SQLException in UserBuddyListSQLIterator.remove ("
					+ userID + "," + buddyID + ")", e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}

}
