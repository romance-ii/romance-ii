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
package org.starhope.appius.net;

import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Constructor;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.GetsConfigReload;
import org.starhope.util.HasSubversionRevision;
import org.starhope.util.LibMisc;

/**
 * This is a listener thread to accept connections and create an
 * appropriate ServerProcessor (ServerThread)
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class ListeningThread extends Thread implements
		GetsConfigReload, Comparable <Object>, HasSubversionRevision {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static Logger log = LoggerFactory
			.getLogger (ListeningThread.class);
	
	/**
	 * The class of server thread which will be used to handle incoming
	 * connections on this port
	 */
	protected final Class <? extends ServerProcessor> acceptorType;
	/**
	 * The configuration key specifying the port number upon which we
	 * will listen for incoming connections.
	 */
	protected final String configKey;
	
	/**
	 * The constructor to be used to instantiate ServerProcessor:s
	 */
	private final Constructor <? extends ServerProcessor> constructor;
	
	/**
	 * continue listening for connections, as long as this flag is true
	 */
	protected boolean keepListening = true;
	
	/**
	 * The listening socket on which to listen for connections
	 */
	private ServerSocket listener = null;
	
	/**
	 * Instantiate the listening thread
	 * 
	 * @param acceptor The class used to dispatch incoming connections
	 *             on this port
	 * @param portConfigKey the configuration key used to specific the
	 *             port number on which we should be listening
	 * @throws NoSuchMethodException if the specified class doesn't
	 *              have an appropriate constructor
	 * @throws SecurityException if the specified class's constructor
	 *              can't be accessed
	 */
	public ListeningThread (
			final Class <? extends ServerProcessor> acceptor,
			final String portConfigKey) throws SecurityException,
			NoSuchMethodException {
		super ("ListeningThread/" + acceptor.getSimpleName ());
		AppiusConfig.wantConfigReload (this);
		acceptorType = acceptor;
		constructor = acceptorType.getConstructor (Socket.class);
		configKey = portConfigKey;
	}
	
	/**
	 * @return the socket accepted
	 * @throws IOException if there's a problem
	 */
	protected Socket acceptSocket () throws IOException {
		return listener.accept ();
	}
	
	/**
	 * Close the listening socket
	 */
	protected void closeListeningSocket () {
		if ( (null != listener) && listener.isBound ()) {
			final String oldSocket = listener
					.getLocalSocketAddress ().toString ();
			// ListeningThread.log.debug (
			// "Closing listening socket {}", oldSocket);
			try {
				listener.close ();
			} catch (final IOException e) {
				BugReporter.getReporter ("srv").reportBug (
						"I/O error closing listening socket "
								+ oldSocket, e);
			}
		}
		AppiusClaudiusCaecus.getCharon ().addZombie (this);
		AppiusClaudiusCaecus.remove (this);
		keepListening = false;
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
		/*
		 * SHOULD be a no-op at this point, however, one last
		 * connection will be accepted from the previous port, so (of
		 * course) … we cheat.
		 */
		if (null != listener) {
			try {
				final Socket blather = new Socket (
						listener.getInetAddress (),
						listener.getLocalPort ());
				blather.getOutputStream ().write ('\07');
				blather.close ();
			} catch (final IOException e) {
				/* no op */
			}
		}
	}
	
	/**
	 * Disconnect the socket because the address is banned
	 * 
	 * @param userSocket The remote socket to be disconnected
	 */
	private void disconnectForBanhammer (final Socket userSocket) {
		// ListeningThread.log.info ("Refusing new "
		// + acceptorType.getSimpleName ()
		// + "connection: quenched (banhammer)");
		try {
			final OutputStream outputStream = userSocket
					.getOutputStream ();
			outputStream
					.write ( ("HTTP/1.0 404\nContent-Type: text/plain\n\n"
							+ "You are not able to connect to this server at this time.\n\07\0")
							.getBytes ());
			outputStream.flush ();
		} catch (final IOException e) { /* don't care */
		}
		try {
			userSocket.close ();
		} catch (final IOException e) {
			/* don't care */
		}
		// shutdown ();
	}
	
	/**
	 * Disconnect the socket because the address is banned
	 * 
	 * @param userSocket The remote socket to be disconnected
	 */
	private void disconnectForServerDown (final Socket userSocket) {
		try {
			final OutputStream outputStream = userSocket
					.getOutputStream ();
			outputStream
					.write ( ("HTTP/1.0 404\nContent-Type: text/plain\n\n"
							+ "The server is currently down for maintenance.\n\07\0")
							.getBytes ());
			outputStream.flush ();
		} catch (final IOException e) { /* don't care */
		}
		try {
			userSocket.close ();
		} catch (final IOException e) {
			/* don't care */
		}
		// shutdown ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if ( (null == obj) || ! (obj instanceof ListeningThread)) {
			return false;
		}
		return listener.equals ( ((ListeningThread) obj).listener);
	}
	
	/**
	 * @return the port number on which we're listening
	 */
	public int getPortNumber () {
		if (null == listener) {
			return 65536;
		}
		return listener.getLocalPort ();
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getClass ()
				+ listener.toString ());
	}
	
	/**
	 * launch a processor on a newly-accepted socket
	 * 
	 * @param userSocket the user socket
	 */
	protected void launchProcessor (final Socket userSocket) {
		try {
			final ServerProcessor processor = constructor
					.newInstance (userSocket);
			processor.start ();
			if (processor instanceof Thread) {
				AppiusClaudiusCaecus.getCharon ().addZombie (
						(Thread) processor);
			}
		} catch (final Exception e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		}
	}
	
	/**
	 * Listen for a new connection and dispatch it
	 */
	private void listenAndDispatch () {
		if (null == listener) {
			BugReporter.getReporter ("srv").reportBug (
					"listener is null");
			return;
		}
		
		if (null == acceptorType) {
			BugReporter.getReporter ("srv").reportBug (
					"acceptorType is null");
			return;
		}
		
		if ( !keepListening) {
			return;
		}
		
		// ListeningThread.log.info ("Listening on port {} for {}",
		// listener.getLocalPort (),
		// acceptorType.getSimpleName ());
		
		try {
			final Socket userSocket = acceptSocket ();
			
			// ListeningThread.log.debug (
			// "Inbound connection accepted from {}",
			// userSocket.getInetAddress ());
			
			if ( !AppiusConfig
					.getConfigBoolOrFalse ("org.starhope.appius.allowInternet")) {
				final String ip = userSocket.getInetAddress ()
						.toString ();
				if ( !ip.startsWith ("/172.27")
						&& !ip.startsWith ("/0:0:0:0:0:0:0:1")
						&& !ip.startsWith ("/74.113.137")) {
					disconnectForServerDown (userSocket);
					return;
				}
			}
			
			if (AppiusClaudiusCaecus.getQuenchedAddresses ()
					.contains (
							userSocket.getInetAddress ()
									.getHostAddress ())) {
				disconnectForBanhammer (userSocket);
				// ListeningThread.log.debug (
				// "Disconnect for banhammer: {}",
				// userSocket.getInetAddress ());
				return;
			}
			// ListeningThread.log.debug (
			// "Accepting new {} connection",
			// acceptorType.getSimpleName ());
			launchProcessor (userSocket);
		} catch (final IOException e) {
			final StringBuilder ioEMessage = new StringBuilder ();
			ioEMessage.append ("I/O exception in ListeningThread for ");
			ioEMessage.append (acceptorType.getSimpleName ());
			ioEMessage.append (" on ");
			ioEMessage.append (listener.getLocalPort ());
			BugReporter.getReporter ("srv").reportBug (
					ioEMessage.toString (), e);
		}
	}
	
	/**
	 * Open the listening socket
	 */
	protected void openListeningSocket () {
		final int newPort = AppiusConfig.getIntOrDefault (configKey,
				-1);
		if ( -1 == newPort) {
			// ListeningThread.log
			// .debug
			// ("Closing listening socket for {} due to configuration setting {}",
			// acceptorType.getSimpleName (),
			// configKey);
			closeListeningSocket ();
			return;
		}
		try {
			listener = new ServerSocket (newPort);
			// ListeningThread.log.debug (
			// "Now listening for {} on port {} ",
			// acceptorType.getSimpleName (), newPort);
		} catch (final IOException e) {
			BugReporter.getReporter ("srv").reportBug (
					"Could not listen for "
							+ acceptorType.getSimpleName ()
							+ " on port " + newPort);
			return;
		}
		
		setListenerReceiveBufferSize (newPort);
		
	}
	
	/**
	 * The main thread loop.
	 */
	@Override
	public void run () {
		AppiusClaudiusCaecus.add (this);
		
		keepListening = true;
		while (keepListening) {
			openListeningSocket ();
			listenAndDispatch ();
		}
		
		// ListeningThread.log.debug ("Stopped listening!");
	}
	
	/**
	 * @param newPort the port on which the socket is listening
	 */
	protected void setListenerReceiveBufferSize (final int newPort) {
		final int size = AppiusConfig.getIntOrDefault (configKey
				+ ".buffer", 2048);
		try {
			listener.setReceiveBufferSize (size);
		} catch (final SocketException e) {
			BugReporter.getReporter ("srv").reportBug (
					"Could not listen for "
							+ acceptorType.getSimpleName ()
							+ " on port: " + newPort, e);
		}
		try {
			// ListeningThread.log.debug (
			// "Listener socket {} receive buffer: {}",
			// newPort, listener.getReceiveBufferSize ());
		} catch (final SocketException e1) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Can't get size of listener socket receive buffer",
							e1);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public void shutdown () {
		keepListening = false;
	}
	
}
