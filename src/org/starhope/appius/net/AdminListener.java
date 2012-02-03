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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.net;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.GetsConfigReload;
import org.starhope.util.HasSubversionRevision;
import org.starhope.util.LibMisc;

/**
 * This is a listener thread for logging in for specific administrative
 * functions XXX replace with ListeningThread
 * 
 * @author brpocock@star-hope.org
 */
public class AdminListener extends Thread implements GetsConfigReload,
		Comparable <Object>, HasSubversionRevision {

	/**
	 * The server socket on which to listen for connections
	 */
	private ServerSocket serverSocket = null;

	/**
	 * Instantiate the AdminListener thread
	 */
	public AdminListener () {
		super ("AdminListener");
		AppiusConfig.wantConfigReload (this);
	}

	/**
	 * Close the server socket
	 */
	private void closeServerSocket () {
		if (null != serverSocket && serverSocket.isBound ()) {
			final String oldSocket = serverSocket
			.getLocalSocketAddress ().toString ();
			AppiusClaudiusCaecus.blather ("", "", oldSocket,
					"Closing admin socket", false);
			try {
				serverSocket.close ();
			} catch (final IOException e) {
				AppiusClaudiusCaecus.blather ("", "", oldSocket,
						"I/O error closing server socket: "
						+ LibMisc.stringify (e),
						false);
			}
		}
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final Object someoneElse) {
		if (null == someoneElse) {
			return -1;
		}
		return toString ().compareTo (someoneElse.toString ());
	}

	/**
	 * This is an overriding method.
	 *
	 * @see org.starhope.appius.util.GetsConfigReload#configUpdated()
	 */
	@Override
	public void configUpdated () {
		closeServerSocket ();
		openServerSocket ();
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (null == obj || !(obj instanceof AdminListener)) {
			return false;
		}
		return serverSocket.equals(((AdminListener)obj).serverSocket) ;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getClass ()
				+ serverSocket.toString ());
	}

	/**
	 * Listen for a new connection and dispatch it
	 */
	private void listenAndDispatch () {
		AppiusClaudiusCaecus
		.blather ("", "", serverSocket.getLocalSocketAddress ()
				.toString (),
				"Listening on admin port "
				+ AppiusConfig.getAdminPort ()
				+ " for clients", true);

		try {
			final Socket userSocket = serverSocket.accept ();
			AppiusClaudiusCaecus.blather ("", "", userSocket
					.getRemoteSocketAddress ().toString (),
					"Accepting new admin connection", false);
			new AdminProcessor (userSocket).start ();

		} catch (final IOException e) {
			AppiusClaudiusCaecus.reportBug ("admin listener", e);
		}
	}

	/**
	 * Open the server socket and start listening
	 */
	private void openServerSocket () {
		if ( !AppiusConfig.isBackdoorOpen ()) {
			AppiusClaudiusCaecus
			.blather ("Closing backdoor due to configuration setting");
			if (null != serverSocket) {
				try {
					serverSocket.close ();
				} catch (final IOException e) {
					AppiusClaudiusCaecus
					.reportBug (
							"Caught a IOException closing serverSocket",
							e);
				}
			}
			AppiusClaudiusCaecus.getCharon ().addZombie (this);
			return;
		}
		try {
			serverSocket = new ServerSocket (AppiusConfig
					.getAdminPort ());
		} catch (final IOException e) {
			AppiusClaudiusCaecus.blather ("", "", ":"
					+ AppiusConfig.getAdminPort (),
					"Could not listen on admin port: "
					+ AppiusConfig.getAdminPort (), true);
			return;
		}

		int size;
		try {
			size = AppiusConfig.getBackdoorBufferSize ();
			serverSocket.setReceiveBufferSize (size);
		} catch (final NumberFormatException e1) {
			AppiusClaudiusCaecus.fatalBug (e1);
		} catch (final SocketException e) {
			AppiusClaudiusCaecus.fatalBug (e);
		}

		try {
			AppiusClaudiusCaecus.blather ("", "", ":"
					+ AppiusConfig.getAdminPort (),
					"Server socket receive buffer: "
					+ serverSocket.getReceiveBufferSize (),
					false);
		} catch (final SocketException e1) {
			AppiusClaudiusCaecus.blather ("", "", ":"
					+ AppiusConfig.getAdminPort (),
					"Can't get size of server socket receive buffer",
					false);
		}
	}

	/**
	 * The main thread loop.
	 */
	@Override
	public void run () {
		openServerSocket ();

		while (AppiusConfig.isBackdoorOpen ()) {
			listenAndDispatch ();
		}
	}

}
