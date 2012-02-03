/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
 * @author brpocock@star-hope.org
 */
package org.starhope.vergil.net;

import java.io.IOException;

import net.launchpad.websocket4j.client.WebSocket;

import org.starhope.vergil.game.PubliusVergiliusMaro;

import com.google.gwt.json.client.JSONObject;
import com.google.gwt.json.client.JSONParser;

/**
 * implementation of {@link ServerConnection} using {@link WebSocket}
 * 
 * @author brpocock@star-hope.org
 */
public class WebSocketServerConnection implements ServerConnection {

	/**
	 * The WebSocket connection
	 */
	private WebSocket socket = null;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String host = null;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private int port = -1;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String zone = null;

	/**
	 * @see org.starhope.vergil.net.ServerConnection#connect(java.lang.String,
	 *      int, java.lang.String)
	 */
	@Override
	public void connect (final String newHost, final int newPort,
			final String newZone)
			throws IOException, ServerDisconnectedException {
		host = newHost;
		port = newPort;
		zone = newZone;
		socket = new WebSocket (newHost, newPort, "/"
				+ newZone);
	}

	/**
	 * @see org.starhope.vergil.net.ServerConnection#disconnect()
	 */
	@Override
	public void disconnect () {
		if (null != socket) {
			try {
				socket.close ();
			} catch (IOException e) {
				PubliusVergiliusMaro
						.reportBug (
								"Caught a IOException in WebSocketServerConnection.disconnect ",
								e);
			}
		}
		host = null;
		port = -1;
		zone = null;
	}

	/**
	 * @see org.starhope.vergil.net.ServerConnection#getHost()
	 */
	@Override
	public String getHost () {
		return host;
	}

	/**
	 * @see org.starhope.vergil.net.ServerConnection#getPort()
	 */
	@Override
	public int getPort () {
		return port;
	}

	/**
	 * @see org.starhope.vergil.net.ServerConnection#getZone()
	 */
	@Override
	public String getZone () {
		return zone;
	}

	/**
	 * @see org.starhope.vergil.net.ServerConnection#readMessage() TODO:
	 *      is this blocking? I forget.
	 */
	@Override
	public JSONObject readMessage () throws ServerDisconnectedException {
		try {
			return JSONParser.parse (socket.getMessage ()).isObject ();
		} catch (IOException e) {
			throw new ServerDisconnectedException (e);
		}
	}

	/**
	 * @see org.starhope.vergil.net.ServerConnection#readMessageBlocking()
	 */
	@Override
	public JSONObject readMessageBlocking ()
			throws ServerDisconnectedException {
		return readMessage (); // TODO
	}

	/**
	 * @see org.starhope.vergil.net.ServerConnection#sendMessage(com.google.gwt.json.client.JSONObject)
	 */
	@Override
	public void sendMessage (final JSONObject jso)
			throws ServerDisconnectedException {
		try {
			socket.sendMessage (jso.toString ());
		} catch (IOException e) {
			throw new ServerDisconnectedException (e);
		}
	}

}
