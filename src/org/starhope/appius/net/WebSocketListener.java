/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.appius.net;

import java.io.IOException;
import java.net.Socket;

import net.launchpad.websocket4j.client.WebSocket;
import net.launchpad.websocket4j.server.WebServerSocket;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.AppiusConfig;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class WebSocketListener extends ListeningThread {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (WebSocketListener.class);
	
	/**
	 * underlying WebSocket
	 */
	private WebServerSocket serverSocket = null;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param acceptor WRITEME
	 * @param portConfigKey WRITEME
	 * @throws SecurityException WRITEME
	 * @throws NoSuchMethodException WRITEME
	 */
	public WebSocketListener (
			final Class <? extends WebSocketProcessor> acceptor,
			final String portConfigKey) throws SecurityException,
			NoSuchMethodException {
		super (acceptor, portConfigKey);
	}
	
	/**
	 * @return the socket accepted
	 * @throws IOException if there's a problem
	 */
	@Override
	protected Socket acceptSocket () throws IOException {
		return serverSocket.accept ();
	}
	
	/**
	 * Close the listening socket
	 */
	@Override
	protected void closeListeningSocket () {
		if ( (null != serverSocket) && !serverSocket.isClosed ()) {
			final String oldSocket = serverSocket
					.getLocalSocketAddress ().toString ();
			WebSocketListener.log.debug (
					"Closing listening socket {}", oldSocket);
			try {
				serverSocket.close ();
			} catch (final IOException e) {
				WebSocketListener.log
						.error ("I/O error closing listening socket: ",
								e);
			}
		}
		AppiusClaudiusCaecus.getCharon ().addZombie (this);
		AppiusClaudiusCaecus.remove (this);
		keepListening = false;
	}
	
	/**
	 * launch a processor on a newly-accepted socket
	 * 
	 * @param userSocket the user socket
	 */
	@Override
	protected void launchProcessor (final Socket userSocket) {
		if ( ! (userSocket instanceof net.launchpad.websocket4j.server.WebSocket)) {
			WebSocketListener.log
					.error ("WebSocketListener got back a naked socket");
		}
		try {
			final ServerProcessor processor = acceptorType
					.getConstructor (WebSocket.class, String.class)
					.newInstance (
							userSocket,
							((net.launchpad.websocket4j.server.WebSocket) userSocket)
									.getRequestURI ());
			processor.start ();
			if (processor instanceof Thread) {
				AppiusClaudiusCaecus.getCharon ().addZombie (
						(Thread) processor);
			}
		} catch (final Exception e) {
			WebSocketListener.log.error ("Exception", e);
		}
	}
	
	/**
	 * Open the listening socket
	 */
	@Override
	protected void openListeningSocket () {
		final int port = AppiusConfig.getIntOrDefault (configKey, -1);
		if ( -1 == port) {
			WebSocketListener.log
					.debug ("Closing listening socket for "
							+ acceptorType.getSimpleName ()
							+ " due to configuration setting "
							+ configKey);
			closeListeningSocket ();
			return;
		}
		try {
			serverSocket = new WebServerSocket (port);
			WebSocketListener.log.debug (
					"Now listening for {} on port {}",
					acceptorType.getSimpleName (), port);
		} catch (final IOException e) {
			WebSocketListener.log.error ("Could not listen for "
					+ acceptorType.getSimpleName () + " on port: "
					+ port, e);
			return;
		}
		
	}
	
	/**
	 * @param port the port on which the socket is listening
	 */
	@Override
	protected void setListenerReceiveBufferSize (final int port) {
		WebSocketListener.log
				.debug ("Listener socket receive buffer not supported for WebServerSocket");
	}
	
}
