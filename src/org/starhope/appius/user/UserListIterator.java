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

import java.util.Iterator;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.RecordLoader;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public abstract class UserListIterator implements
Iterator <UserListEntry>, RecordLoader <UserListEntry> {

	/**
	 * WRITEME
	 */
	protected final String moniker;
	/**
	 * WRITEME
	 */
	protected final int userID;
	/**
	 * WRITEME
	 */
	protected final String userLogin;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param user WRITEME
	 * @param listMoniker WRITEME
	 */
	protected UserListIterator (final AbstractUser user,
			final String listMoniker) {
		userID = user.getUserID ();
		userLogin = user.getAvatarLabel ();
		moniker = listMoniker;
	}
	
	/**
	 * Add another user to the list represented by this iterator
	 * 
	 * @param user the other user
	 */
	public abstract void add (final AbstractUser user);

	/**
	 * @see java.util.Iterator#remove()
	 */
	@Override
	public void remove () {
		AppiusClaudiusCaecus
		.reportBug ("unimplemented UserListIterator::remove (brpocock@star-hope.org, Aug 17, 2010)");

	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param interestingFellow WRITEME
	 */
	public abstract void remove (AbstractUser interestingFellow);

}
