/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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

package org.starhope.util.types;

import org.json.JSONObject;
import org.starhope.appius.except.UserDeadException;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public interface CanProcessCommands {
	
	/**
	 * @return The name of this thread or other thing that can process
	 *         commands
	 */
	String getName ();
	
	/**
	 * @param cmd the command producing an error
	 * @param errCode the error code string
	 */
	void sendError_RAW (String cmd, String errCode);
	
	/**
	 * @param ret a JSON-encoded response
	 * @throws UserDeadException if the user has been disconnected
	 */
	void sendResponse (JSONObject ret) throws UserDeadException;
	
	/**
	 * @param b whether the thread or processor is “busy”
	 */
	void setBusyState (boolean b);
	
	/**
	 * @param thatTime WRITEME
	 */
	void setLastInputTime (long thatTime);
	
}
