/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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

package org.starhope.appius.util;

/**
 * A reason for which an account might be closed
 * 
 * @author brpocock@star-hope.org
 * 
 */
public enum UserCloseReason {
	/**
	 * Account was closed for foul or abusive language
	 */
	BAD_LANGUAGE,
	/**
	 * Account was closed because the eMail address supplied was invalid
	 */
	BAD_MAIL,
	/**
	 * Account was closed for cheating
	 */
	CHEATING,
	/**
	 * Account has not, in fact, been closed at all; it's open.
	 */
	NOT_CLOSED,
	/**
	 * Closed by request of user (self, or in Tootsville, parent)
	 */
	USER_REQUEST

}
