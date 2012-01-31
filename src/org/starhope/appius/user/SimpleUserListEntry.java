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

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * an entry on a {@link UserList}
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class SimpleUserListEntry extends
		SimpleDataRecord <SimpleUserListEntry> implements
		UserListEntry {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -2698186565644948819L;
	
	/**
	 * whether the user is online
	 */
	private boolean isOnline = false;
	
	/**
	 * the user's login
	 */
	private final String login;
	/**
	 * the list on which this entry occurs
	 */
	private final String myList;
	/**
	 * the user owning this list
	 */
	private final String myUser;
	/**
	 * the zone in which the user is logged-in (if they are)
	 */
	private String zone = "";
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param loader WRITEME
	 * @param listOwner WRITEME WRITEME
	 * @param listIdentifier WRITEME
	 * @param userNameOnList WRITEME
	 */
	public SimpleUserListEntry (
			final RecordLoader <UserListEntry> loader,
			final String listOwner, final String listIdentifier,
			final String userNameOnList) {
		super (loader);
		myUser = listOwner;
		myList = listIdentifier;
		login = userNameOnList;
		markAsLoaded ();
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof SimpleUserListEntry)) {
			return false;
		}
		final SimpleUserListEntry other = (SimpleUserListEntry) obj;
		if (myList == null) {
			if (other.myList != null) {
				return false;
			}
		} else if ( !myList.equals (other.myList)) {
			return false;
		}
		if (myUser == null) {
			if (other.myUser != null) {
				return false;
			}
		} else if ( !myUser.equals (other.myUser)) {
			return false;
		}
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		throw new NotFoundException ("no");
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return myUser + "/" + myList + "/" + login;
	}
	
	/**
	 * @see org.starhope.appius.user.UserListEntry#getLogin()
	 */
	@Override
	public String getLogin () {
		return login;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Revision: 2262 $";
	}
	
	/**
	 * @see org.starhope.appius.user.UserListEntry#getZone()
	 */
	@Override
	public String getZone () {
		return zone;
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result)
				+ (myList == null ? 0 : myList.hashCode ());
		result = (prime * result)
				+ (myUser == null ? 0 : myUser.hashCode ());
		return result;
	}
	
	/**
	 * @see org.starhope.appius.user.UserListEntry#isOnline()
	 */
	@Override
	public boolean isOnline () {
		return isOnline;
	}
	
	/**
	 * @see org.starhope.appius.user.UserListEntry#setOnline(boolean)
	 */
	@Override
	public void setOnline (final boolean really) {
		isOnline = really;
		changed ();
	}
	
	/**
	 * @see org.starhope.appius.user.UserListEntry#setZone(java.lang.String)
	 */
	@Override
	public void setZone (final String newZone) {
		zone = newZone;
		changed ();
	}
	
}
