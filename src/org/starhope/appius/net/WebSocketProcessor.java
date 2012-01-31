/*
 * NOTE — this relies upon my patched version of WebSocket4J v1.2, make
 * sure that you have that in lib (it's in Subversion), or have the
 * package checked-out from Star-Hope's Subversion server. Sorry…!
 */
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.net;

import java.io.IOException;
import java.net.Socket;

import net.launchpad.websocket4j.server.WebSocket;

import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.net.datagram.ADPString;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class WebSocketProcessor extends StreamProcessor {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (WebSocketProcessor.class);
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final WebSocket mySocket;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String myURI;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param newSocket WebSocket
	 */
	public WebSocketProcessor (final WebSocket newSocket) {
		super (4096); // maxSize
		mySocket = newSocket;
		socket = null;
		myURI = "/";
	}
	
	/**
	 * Ctor
	 * 
	 * @param newSocket socket
	 * @param requestURI request URI
	 */
	public WebSocketProcessor (final WebSocket newSocket,
			final String requestURI) {
		this (newSocket);
		myURI = requestURI;
		if (myURI.matches ("\\/[^\\/]+\\/[^\\/]+")) {
			// built-in login request! TODO — parse this
		}
	}
	
	/**
	 * @see org.starhope.appius.net.NetIOThread#checkInputStream()
	 */
	@Override
	protected synchronized void checkInputStream ()
			throws UserDeadException {
		// No-op.
	}
	
	/**
	 * @see org.starhope.appius.net.ServerThread#doNudge(long)
	 */
	@Override
	protected void doNudge (final long t) throws UserDeadException {
		if (null == myUser) {
			/* Prelogin thread */
			if ( (null == mySocket) || mySocket.isClosed ()) {
				throw new UserDeadException ();
			}
			tLastNudge = t;
		} else if ( !this.equals (myUser.getServerThread ())) {
			throw new UserDeadException ();
		}
	}
	
	/**
	 * @see org.starhope.appius.net.NetIOThread#dropSocket_socketCore()
	 */
	@Override
	protected void dropSocket_socketCore () {
		// No op
	}
	
	/**
	 * @see org.starhope.appius.net.NetIOThread#dropSocketConnection()
	 */
	@Override
	protected synchronized void dropSocketConnection () {
		try {
			mySocket.close ();
		} catch (final IOException e) {
			WebSocketProcessor.log
					.error ("Caught a IOException in WebSocketProcessor.dropSocketConnection ",
							e);
		}
	}
	
	/**
	 * @see org.starhope.appius.net.ServerThread#getIPAddress()
	 */
	@Override
	public String getIPAddress () {
		return mySocket.getInetAddress ().toString ();
	}
	
	/**
	 * @see org.starhope.appius.net.NetIOThread#getRemoteAddress()
	 */
	@Override
	protected String getRemoteAddress () {
		return mySocket.getRemoteSocketAddress ().toString ();
	}
	
	/**
	 * @see org.starhope.appius.net.NetIOThread#getSocket()
	 */
	@Override
	protected Socket getSocket () {
		return mySocket;
	}
	
	/**
	 * @see org.starhope.appius.net.ServerThread#getStreamsReady()
	 */
	@Override
	protected Socket getStreamsReady () throws UserDeadException,
			IOException {
		// no op
		return mySocket;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * @see org.starhope.appius.net.ServerThread#grabInput()
	 */
	@Override
	protected String grabInput () throws UserDeadException {
		try {
			return mySocket.getMessage ();
		} catch (final IOException e) {
			WebSocketProcessor.log
					.error ("Caught a IOException in WebSocketProcessor.grabInput ",
							e);
			return null;
		}
	}
	
	/**
	 * @see org.starhope.appius.net.ServerThread#run()
	 */
	@Override
	public void run () {
		/*
		 * Setup stanza
		 */
		keepRunning = true;
		setLastInputTime (System.currentTimeMillis ());
		AppiusClaudiusCaecus.updateHighWaterMark ();
		
		try {
			setup ();
			/*
			 * Main I/O loop
			 */
			while (keepRunning) {
				
				/*
				 * Process input line
				 */
				if ( (null == mySocket) || mySocket.isClosed ()) {
					close ();
					return; // End of thread.
				}
				
				final String inputLine = grabInput ();
				final String outputLine = processInput (inputLine);
				
				if ( (null == mySocket) || mySocket.isClosed ()) {
					close ();
					return;
				}
				
				/*
				 * If the output is null pointer, we're done
				 */
				if (null == outputLine) {
					close ();
					return; // End of thread.
				}
				/*
				 * If the output is empty, don't send anything.
				 */
				if ( ! ("".equals (outputLine) || "\0"
						.equals (outputLine))) {
					sendRawMessageNow (new ADPString (outputLine,
							null));
				}
				if (isDone) {
					close ();
					return; // End of thread.
				}
				
			}
			
		} catch (final IOException e) {
			WebSocketProcessor.log.error ("Exception", e);
		} catch (final UserDeadException e) {
			close ();
			return;
		} catch (final Throwable e) {
			WebSocketProcessor.log.error ("Exception", e);
		} finally {
			dropSocketConnection ();
		}
		
		AppiusClaudiusCaecus.getCharon ().addZombie (this);
		
		// End of thread.
	}
	
}
