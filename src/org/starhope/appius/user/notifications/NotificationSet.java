/**
 * <p>
 * Copyright © 2010, Timothy Heys
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
 * @author twheys@gmail.com
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.user.notifications;

import org.starhope.appius.user.UserRecord;
import org.starhope.appius.util.SimpleDataRecordSet;

/**
 * The collection of all (potentially active) {@link Notification}s
 * associated with a given user.
 * 
 * @author twheys@gmail.com
 * @author brpocock@star-hope.org
 */
public class NotificationSet extends
		SimpleDataRecordSet <Notification, NotificationSet> {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 6189835520198516038L;
	/**
	 * The user whose set of notifications this represents.
	 */
	private final int myUserID;

	/**
	 * @param userID the user ID of the user for whom this is the
	 *            notification set
	 */
	public NotificationSet (final int userID) {
		super (NotificationSet.class);
		myUserID = userID;
	}

	/**
	 * @param who the user record of the user for whom this is the
	 *            notification set
	 */
	public NotificationSet (final UserRecord who) {
		super (NotificationSet.class);
		myUserID = who.getUserID ();
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () {
		return myUserID;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () {
		return String.format ("%08x", Integer.valueOf (myUserID));
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}
}
