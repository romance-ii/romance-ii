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
 * <p>
 * This enumeration gives the possible actions that a filter can
 * recommend based upon its input.
 * </p>
 * <p>
 * The use of an enum type is intentional, as we'll get errors from any
 * failure to implement cases in switches handling it.
 * </p>
 * 
 * @author brpocock@star-hope.org
 * 
 */
public enum FilterAction {
	/**
	 * Kick the user offline, in addition to warning him or her.
	 */
	ACT_KICK,

	/**
	 * No action should be taken. <strong>Note</strong> that this is
	 * only allowed for exceptions, <em>not</em> "top level" patterns.
	 */
	ACT_NONE,

	/**
	 * Warn the user that his or her words are inappropriate. A
	 * collective number of warnings might result in being kicked, also,
	 * however.
	 */
	ACT_WARN
}
