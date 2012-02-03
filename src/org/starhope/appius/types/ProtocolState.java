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

package org.starhope.appius.types;

/**
 * @author brpocock@star-hope.org
 * 
 */
public class ProtocolState {
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Oct 23, 2009)
	 * 
	 * CLOSED (ProtocolState)
	 */
	public final static int CLOSED = 9999;

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Oct 23, 2009)
	 * 
	 * PRELOGIN (ProtocolState)
	 */
	public final static int PRELOGIN = 10;

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Oct 23, 2009)
	 * 
	 * PRELOGIN (ProtocolState)
	 */
	public final static int READY = 777;

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Oct 23, 2009)
	 * 
	 * WAITING (ProtocolState)
	 */
	public final static int WAITING = 0;

}
