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

import org.starhope.appius.game.AppiusClaudiusCaecus;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class UserListGeneralSQLIterator extends UserListSQLIterator {

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param user WRITEME
	 * @param list WRITEME
	 */
	public UserListGeneralSQLIterator (final AbstractUser user,
			final String list) {
		super (user, list); // FIXME
	}

	/**
	 * @see org.starhope.appius.user.UserListIterator#add(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void add (final AbstractUser user) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus.reportBug("unimplemented UserListIterator::add (brpocock@star-hope.org, Aug 18, 2010)");
	}

	/**
	 * @see org.starhope.appius.user.UserListSQLIterator#getSQL()
	 */
	@Override
	protected String getSQL () {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented UserListSQLIterator::getSQL (brpocock@star-hope.org, Aug 17, 2010)");
		return null;
	}

	@Override
    public void refresh (final UserListEntry record) {
        // TODO
        
    }

    /**
	 * @see org.starhope.appius.user.UserListIterator#remove(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void remove (final AbstractUser interestingFellow) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented UserListIterator::remove (brpocock@star-hope.org, Aug 18, 2010)");

	}

}
