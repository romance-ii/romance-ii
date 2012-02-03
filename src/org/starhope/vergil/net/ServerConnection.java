/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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

import com.google.gwt.json.client.JSONObject;
import com.google.gwt.json.client.JSONValue;

/**
 * Generic interface for some kind of connection to the server, must
 * provide only the most basic functionality.
 * 
 * @author brpocock@star-hope.org
 */
public interface ServerConnection {
	/**
	 * Connect to a game server
	 * 
	 * @param newHost host name or IP address (in whatever notation the
	 *            local networking code understands)
	 * @param port TCP (or UDP…?) port number
	 * @param newZone the zone on that port, to which to connect ($Eden
	 *            is login zone)
	 * @throws IOException if some kind of problem prevents a
	 *             connection; subclasses might make sense to the local
	 *             code, to be able to provide better diagnostic
	 *             information for the end-user
	 * @throws ServerDisconnectedException if the connection is lost
	 *             (but was basically established)
	 */
	public void connect (String newHost, int port, String newZone)
			throws IOException, ServerDisconnectedException;

	/**
	 * Disconnect.
	 */
	public void disconnect ();

	/**
	 * @return the host address or name; or null, if not connected
	 */
	public String getHost ();

	/**
	 * @return the host TCP (or UDP…) port number. -1 can be returned
	 *         for either not-connected or not-applicable (e.g. using
	 *         some kind of RPC mechanism)
	 */
	public int getPort ();

	/**
	 * @return the current Zone, or null, if not connected
	 */
	public String getZone ();

	/**
	 * Retrieve the next message from the server's queue, or null if
	 * there are no messages waiting
	 * 
	 * @return the next message from the server, or null if there are
	 *         none pending
	 * @throws ServerDisconnectedException if the connection is lost
	 */
	public JSONValue readMessage () throws ServerDisconnectedException;

	/**
	 * Retrieves the next message from the server, blocking to wait for
	 * one if there are none queued.
	 * 
	 * @return the next message from the server
	 * @throws ServerDisconnectedException if the connection is lost
	 */
	public JSONObject readMessageBlocking ()
			throws ServerDisconnectedException;

	/**
	 * Send a message to the server
	 * @param jso JSON data
	 * @throws ServerDisconnectedException if the connection is lost
	 */
	public void sendMessage (JSONObject jso) throws ServerDisconnectedException;
}
