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
package org.starhope.appius.sys.op;

/**
 * 
 * 
 * TODO: The documentation for this type (FilterResult) is incomplete.
 * (brpocock@star-hope.org, Oct 13, 2009)
 * 
 * @author brpocock@star-hope.org
 * 
 */
public class FilterResult {

	/**
	 * WRITEME
	 */
	public String reason;
	/**
	 * WRITEME
	 */
	public FilterStatus status;

	/**
	 * WRITEME
	 */
	public FilterResult () {
		status = FilterStatus.Ok;
		reason = "";
	}

	/**
	 * @param newStatus WRITEME
	 * @param newReason WRITEME
	 */
	public FilterResult (final FilterStatus newStatus,
			final String newReason) {
		status = newStatus;
		reason = newReason;
	}

	/**
	 * 
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return status + ":" + reason;
	}
}
