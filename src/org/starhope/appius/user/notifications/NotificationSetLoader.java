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

import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.util.RecordSetLoader;

/**
 * Load notifications. This is just the interface... specific storage
 * engines (e.g. SQL) will implement this interface
 * 
 * @author brpocock@star-hope.org
 */
public interface NotificationSetLoader extends
		RecordSetLoader <NotificationSet> {
	
	/**
	 * Get all (read and unread) notifications for a given user
	 * 
	 * @param whom the user whose notifications are to be loaded
	 * @return the notification set
	 */
	NotificationSet loadRecordSetFor (AbstractUser whom);
	
	/**
	 * Get unread (unhandled, not-deleted) notifications for a given
	 * user
	 * 
	 * @param whom the user whose notifications are to be loaded
	 * @return the unread notifications for that user
	 */
	NotificationSet loadUnreadRecordSetFor (AbstractUser whom);
	
}
