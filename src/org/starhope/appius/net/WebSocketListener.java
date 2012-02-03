/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.appius.net;

import java.io.IOException;
import java.net.Socket;

import net.launchpad.websocket4j.client.WebSocket;
import net.launchpad.websocket4j.server.WebServerSocket;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * @author brpocock@star-hope.org
 */
public class WebSocketListener extends ListeningThread {
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
		if (null != serverSocket && !serverSocket.isClosed ()) {
			final String oldSocket = serverSocket
					.getLocalSocketAddress ().toString ();
			AppiusClaudiusCaecus.blather ("", "", oldSocket,
					"Closing listening socket", false);
			try {
				serverSocket.close ();
			} catch (final IOException e) {
				AppiusClaudiusCaecus.blather ("", "", oldSocket,
						"I/O error closing listening socket: "
								+ LibMisc.stringify (e), false);
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
			AppiusClaudiusCaecus.fatalBug ("WebSocketListener got back a naked socket");
		}
		try {
			final ServerProcessor processor = acceptorType
					.getConstructor (WebSocket.class, String.class)
					.newInstance (userSocket,
							((net.launchpad.websocket4j.server.WebSocket) userSocket)
									.getRequestURI ());
			processor.start ();
			if (processor instanceof Thread) {
				AppiusClaudiusCaecus.getCharon ().addZombie (
						(Thread) processor);
			}
		} catch (final Exception e) {
			AppiusClaudiusCaecus.reportBug (e);
		}
	}

	/**
	 * Open the listening socket
	 */
	@Override
	protected void openListeningSocket () {
		final int port = AppiusConfig
				.getIntOrDefault (configKey, -1);
		if ( -1 == port) {
			AppiusClaudiusCaecus
					.blather ("Closing listening socket for "
							+ acceptorType.getSimpleName ()
							+ " due to configuration setting "
							+ configKey);
			closeListeningSocket ();
			return;
		}
		try {
			serverSocket = new WebServerSocket (port);
			AppiusClaudiusCaecus.blather ("", "", ":" + port,
					"Now listening for "
							+ acceptorType.getSimpleName ()
							+ " on port: " + port, true);
		} catch (final IOException e) {
			AppiusClaudiusCaecus.blather ("", "", ":" + port,
					"Could not listen for "
							+ acceptorType.getSimpleName ()
							+ " on port: " + port, true);
			return;
		}

	}

	/**
	 * @param port the port on which the socket is listening
	 */
	@Override
	protected void setListenerReceiveBufferSize (final int port) {
		AppiusClaudiusCaecus
				.blather (
						"",
						"",
						":" + port,
						"Listener socket receive buffer not supported for WebServerSocket",
						false);
	}

}
