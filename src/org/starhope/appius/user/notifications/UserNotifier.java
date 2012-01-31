/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Timothy Heys
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
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.user.notifications;

import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.util.AppiusConfig;

/**
 * Gather the notifications relevant ot one user
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class UserNotifier {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static NotificationSetLoader storage;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param whom WRITEME
	 * @return WRITEME
	 */
	public static NotificationSet getNotificationsTo (
			final AbstractUser whom) {
		UserNotifier.initStorage ();
		return UserNotifier.storage.loadRecordSetFor (whom);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param whom WRITEME
	 * @return WRITEME
	 */
	public static NotificationSet getUnreadNotificationsTo (
			final AbstractUser whom) {
		UserNotifier.initStorage ();
		return UserNotifier.storage.loadUnreadRecordSetFor (whom);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private static synchronized void initStorage () {
		if (null != UserNotifier.storage) {
			return;
		}
		
		UserNotifier.storage = (NotificationSetLoader) AppiusConfig
				.getRecordSetLoaderForClass (NotificationSet.class);
	}
}
