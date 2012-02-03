/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
 * </p>
 * <p>
 * Based upon public domain sample code provided by Authorize.net
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

package org.starhope.appius.messaging;

import java.sql.Connection;

import org.starhope.appius.sys.op.FilterResult;

/**
 * WRITEME: The documentation for this type (AbstractCensor) is
 * incomplete. (brpocock@star-hope.org, Nov 19, 2009)
 * 
 * @author brpocock@star-hope.org
 */
public interface AbstractCensor {
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param token WRITEME
	 * @return WRITEME
	 */
	public abstract FilterResult checkLists (final String token);
	
	/**
	 * Filter the message.
	 * 
	 * @param text WRITEME
	 * @return true if message should be filtered.
	 */
	public abstract FilterResult filterMessage (final String text);
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public abstract int getWhiteListLength ();

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * @param databaseConnection WRITEME
	 */
	public abstract void loadLists (Connection databaseConnection);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * @param databaseConnection WRITEME
	 */
	public abstract void prime (Connection databaseConnection);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * @param databaseConnection WRITEME
	 */
	public abstract void reloadLists (Connection databaseConnection);


}
