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

package org.starhope.vergil.net;

import java.io.IOException;
import java.net.UnknownHostException;

import com.google.gwt.json.client.JSONObject;

/**
 * @author brpocock@star-hope.org
 */
public interface AppianClient {

	/**
	 * Close the server connection and terminate the game
	 */
	public void close ();

	/**
	 * Connect to the server based upon a hostname and port
	 * 
	 * @param serverAddress hostname or IP address of the server
	 * @param serverPort port number on the server
	 * @throws UnknownHostException If the hostname can't be interpreted
	 * @throws IOException If we're not able to connect to the server
	 * @throws ServerDisconnectedException If we're disconnected
	 */
	public void connect (final String serverAddress,
			final int serverPort) throws UnknownHostException,
			IOException, ServerDisconnectedException;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param string WRITEME
	 */
	public void send (String string);

	/**
	 * WRITEME
	 *
	 * @param result WRITEME
	 * @throws ServerDisconnectedException WRITEME
	 */
	public void sendResponse (final JSONObject result)
			throws ServerDisconnectedException;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param b WRITEME
	 */
	void setBusyState (boolean b);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param thatTime WRITEM
	 */
	public void setLastInputTime (long thatTime);

	/**
	 * @param currentTime WRITEME
	 * @param deltaTime WRITEME
	 */
	public void tick (long currentTime, long deltaTime);

	/**
	 * This returns a plethora of debugging-useful information about
	 * this particular server thread.
	 *
	 * @see java.lang.Thread#toString()
	 */
	@Override
	public String toString ();
}
