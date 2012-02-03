/**
 * <p>
 * Copyright © 2010, brpocock@star-hope.org
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
package org.starhope.appius.net;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.Thread.UncaughtExceptionHandler;
import java.net.Socket;
import java.net.SocketAddress;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.net.datagram.ADPString;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.services.Rhadamanthus;
import org.starhope.appius.types.ProtocolState;
import org.starhope.appius.util.AcceptsMetronomeTicks;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;
import org.starhope.util.types.CanProcessCommands;

/**
 * Networking I/O threads, for either client or server using the
 * "Infinity Mode" protocol (or, to a limited extent, the surviving
 * entrails of the SmartFaux mode)
 *
 * @author brpocock@star-hope.org
 */
public abstract class NetIOThread extends Thread implements
		NetIOHandlerPeer, AcceptsMetronomeTicks,
		UncaughtExceptionHandler, CanProcessCommands,
		Comparable <Thread> {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	// protected final NetIOHandler handler;

	/**
	 * The socket connected to the other end of the communications
	 */
	protected Socket socket;

	/**
	 * The buffered input stream from the user.
	 */
	protected BufferedReader in = null;

	/**
	 * Boolean flag indicating whether the server is in debugging mode
	 * or not. True if we are in debugging mode. Defaults to true, until
	 * the configuration has been read
	 */
	protected boolean debug = true;

	/**
	 * This indicates whether the thread has voluntarily decided to
	 * exit, e.g. because the user has properly disconnected and so
	 * forth.
	 */
	protected boolean isDone = false;

	/**
	 * This is a crazy XML looking string that we have to pump out to
	 * make the Flash plug-in happy.
	 */
	protected String letsPlayWithFlash;

	/**
	 * The state of the conversation that we are having with the other
	 * party
	 */
	protected int state = ProtocolState.WAITING;

	/**
	 * WRITEME
	 */
	boolean parallelMode = false;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected String language = "en";

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected String dialect = "US";

	/**
	 * The output stream connected to the pipe
	 */
	protected PrintWriter out = null;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private boolean verboseBugReplies = false;

	/**
	 * WRITEME
	 */
	public NetIOThread () {
		super ();
		// handler = new NetIOHandler (this);
	}
	
	/**
	 * Create a new NetIOThread with the given name
	 * 
	 * @param string WRITEME
	 */
	public NetIOThread (final String string) {
		super (string);
		// handler = new NetIOHandler (this);
	}

	/**
	 * Peek for input. Try to throw an I/O exception.
	 * 
	 * @throws UserDeadException if the remote user has disconnected
	 */
	protected synchronized void checkInputStream ()
			throws UserDeadException {
		if (null == socket || null == in || null == out) {
			throw new UserDeadException ();
		}
	}
	
	/**
	 * Compare two threads
	 * 
	 * @param other another server thread
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final Thread other) {
		return other.getName ().compareTo (getName ());
	}

	/**
	 * @param theInput to be processed
	 * @return any response
	 */
	protected String doProcessing (final String theInput) {
		return processInput_Infinity (theInput);
	}

	/**
	 * The core code that actually disconnects the socket hard.
	 */
	protected void dropSocket_socketCore () {
		if (null != socket) {
			synchronized (socket) {
				try {
					socket.shutdownInput ();
				} catch (final IOException e) {
					/*
					 * Ignore. Seems to mostly mean that the socket were
					 * closed anyways.
					 */
				}
				if ( !socket.isClosed ()) {
					try {
						try {
							socket.shutdownInput ();
						} catch (final IOException e) {
							// yay
						}
						try {
							socket.shutdownOutput ();
						} catch (final IOException e) {
							// yay
						}
						try {
							socket.close ();
						} catch (final IOException e) {
							// yay
						}
					} catch (final Exception e) {
						AppiusClaudiusCaecus
								.reportBug (
										"Unexpected exception while disconnecting user",
										e);
					}
				}
			}
			socket = null;
		}
	}

	/**
	 * Drop the I/O socket for this user.
	 */
	protected synchronized void dropSocketConnection () {
		tattle ("/*/ Closing I/O socket");

		if (this != Thread.currentThread ()
				&& ! (Thread.currentThread () instanceof Rhadamanthus)) {
			AppiusClaudiusCaecus
					.reportBug ("DAMNED: The damned are to be judged only by those appointed by the gods, but "
							+ Thread.currentThread ().getName ()
							+ " wishes to judge " + getName ());
		}
		// if (!Thread.currentThread ().getName ().equals (getName ())
		// && !Thread.currentThread ().getName ().equals (
		// "metronome")) {
		// AppiusClaudiusCaecus
		// .traceThis
		// ("called dropSocketConnection on a different thread: caller is "
		// + Thread.currentThread ().getName ()
		// + " and victim is " + getName ());
		// }
		// AppiusClaudiusCaecus.getCharon ().addZombie (this);

		if (null != out) {
			synchronized (out) {
				out.close ();
			}
			out = null;
		}

		if (null != in) {
			synchronized (in) {
				try {
					in.close ();
				} catch (final IOException e) {
					// yay
				}
			}
			in = null;
		}
		dropSocket_socketCore ();
		return;
	}

	/**
	 * This is an overriding method.
	 * 
	 * @param other the other thread against which to compare
	 * @return true, if these are the same thread
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	public boolean equals (final NetIOThread other) {
		if (null == other) {
			return false;
		}
		return getName ().equals (other.getName ());
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object other) {
		if (other instanceof ServerThread) {
			return this.equals ((NetIOThread) other);
		}
		return false;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return the language and dialect separated with an "_"
	 */
	public String getLanguage_dialect () {
		return language + "_" + dialect;
	}

	/**
	 * @return the string form of the remote address
	 */
	protected String getRemoteAddress () {
		if (null == socket) {
			return "";
		}
		final SocketAddress remoteSocketAddress = socket
				.getRemoteSocketAddress ();
		if (null == remoteSocketAddress) {
			return "";
		}
		return remoteSocketAddress.toString ();
	}

	/**
	 * Get the socket connection to the pipe
	 *
	 * @return the socket connection to the pipe
	 */
	protected Socket getSocket () {
		return socket;
	}

	/**
	 * @return whether to include backtraces in exception reports to the
	 *         client
	 */
	public boolean getVerboseBugReplies () {
		return verboseBugReplies;
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getName ());
	}

	/**
	 * Determine whether the server is in debugging mode
	 *
	 * @return true, if the server is in debug mode
	 */
	public boolean isDebug () {
		return debug;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public boolean isParallelMode () {
		return parallelMode;
	}

	/**
	 * Process and dispatch input from the pipe.
	 *
	 * @param theInput The input packet from the pipe
	 * @return An output packet for the pipe, or a zero-length string if
	 *         there is no input; or, a null pointer if the pipe should
	 *         be disconnected.
	 */
	public String processInput (final String theInput) {

		superVerbose ("processInput");

		if (null == theInput) {
			return null;
		}

		if (1337 == state) {
			state = ProtocolState.PRELOGIN;
		}

		try {
			if (isDone) {
				return null;
			} else if (0 == theInput.length ()) {
				if (state == ProtocolState.WAITING) {
					tattle ("Entered via WAITING state through nothingness");
					state = 1337 /* FIXME not ProtocolState.PRELOGIN */;
					return letsPlayWithFlash;
				}
				tattle ("No input. Not going to process the emptiness");
				return "";
			}
		} catch (final Throwable e) {
			return "?ERR\tE\t[[[" + LibMisc.stringify (e)
					+ "]]]\07\n\0";
		}

		setLastInputTime (System.currentTimeMillis ());

		if ("∞".equals (theInput)
				|| "Infinity, please".equals (theInput)) {
			toInfinityAndBeyond ();
			return "∞\tYou're quite welcome.\t0\t1.1\n";
		}

		return doProcessing (theInput);
	}

	/**
	 * Process input received using the JSON-based Infinity mode
	 *
	 * @param theInput the input string identified as being
	 *            Infinity-mode data
	 * @return a response for the other party in the communication
	 */
	protected abstract String processInput_Infinity (String theInput);

	/**
	 * Send a raw error message back to the session as a JSON response
	 *
	 * @param errorSource The method that is the source of the error
	 * @param message The error message to be returned
	 */
	@Override
	public void sendError_RAW (final String errorSource,
			final String message) {
		final JSONObject result = new JSONObject ();
		try {
			tattle ("Sending error: from " + errorSource + "\n"
					+ message);
			result.put ("from", errorSource);
			result.put ("status", false);
			result.put ("err", message);
			sendResponse (result);
		} catch (final JSONException e) {
			// Default catch action, report bug (brpocock@star-hope.org,
			// Aug 19, 2009)
			AppiusClaudiusCaecus.reportBug (e);
		} catch (final UserDeadException e) {
			// Ignored
		}
	}

	/**
	 * Send a message to the user in future
	 *
	 * @param reply The message to be sent in future
	 * @throws UserDeadException if the user is already gone
	 */
	protected abstract void sendRawMessageLater (
			final AbstractDatagram reply) throws UserDeadException;
	
	/**
	 * Send a message to the user in future
	 * 
	 * @param reply The message to be sent in future
	 * @throws UserDeadException if the user is already gone
	 * @deprecated use {@link #sendRawMessageLater(AbstractDatagram)}
	 */
	@Deprecated
	protected abstract void sendRawMessageLater (final String reply)
			throws UserDeadException;

	/**
	 * Send a raw message packet to the local other party immediately
	 *
	 * @param reply The string to be transmitted to this thread's user
	 * @throws UserDeadException if the user has been disconnected
	 */
	protected abstract void sendRawMessageNow (
			final AbstractDatagram reply) throws UserDeadException;
	
	/**
	 * Send a raw message packet to the local other party immediately
	 * 
	 * @param reply The string to be transmitted to this thread's user
	 * @throws UserDeadException if the user has been disconnected
	 * @deprecated use {@link #sendRawMessageNow(AbstractDatagram)}
	 */
	@Deprecated
	protected synchronized void sendRawMessageNow (final String reply)
			throws UserDeadException {
		sendRawMessageNow (new ADPString (reply));
	}

	/**
	 * Set the server's debugging mode on (true) or off (false)
	 * 
	 * @param newDebug True, if the server should be in debug mode;
	 *            else, false
	 */
	public void setDebug (final boolean newDebug) {
		debug = newDebug;
		AppiusConfig.setConfig ("org.starhope.appius.debug",
				debug ? "true" : "false");
	}

	/**
	 * Set the language for this thread, and any offspring it might
	 * produce
	 * 
	 * @param newLanguage new language
	 * @param newDialect new dialect
	 */
	public void setLanguage (final String newLanguage,
			final String newDialect) {
		language = newLanguage;
		dialect = newDialect;
	}

	/**
	 * Send the client verbose breakdowns of bug reports
	 *
	 * @param really whether to enable this mode, or actually to disable
	 *            it.
	 */
	public void setVerboseBugReplies (final boolean really) {
		verboseBugReplies = really;
	}

	/**
	 * dump some immensely, nanosecond-stamped verbose logging
	 *
	 * @param string verbose debugging BS
	 */
	@Deprecated
	protected void superVerbose (final String string) {
		return;
		// if (AppiusConfig
		// .getConfigBoolOrFalse ("org.starhope.appius.superVerbose")) {
		// tattle (System.currentTimeMillis () + "/"
		// + System.nanoTime () + ":" + string);
		// }
	}

	/**
	 * tattle a non-urgent message
	 *
	 * @param message message
	 */
	public void tattle (final String message) {
		tattle (message, false);
	}

	/**
	 * Print a log entry to STDERR with a great deal of identifiable
	 * detail
	 *
	 * @param tattle the log entry to be printed
	 * @param urgent Display this message even in non-debug mode (in
	 *            logs)
	 */
	public void tattle (final String tattle, final boolean urgent) {
		if (false == urgent
				&& false == AppiusConfig
						.getConfigBoolOrFalse ("org.starhope.appius.debug")) {
			return;
		}
		final StringBuilder tattler = new StringBuilder ();
		tattler.append (new java.util.Date ().toString ());
		tattler.append ('\t');
		tattler.append (tattlePrefix ());
		tattler.append ('\t');
		if (null != socket) {
			tattler.append (getRemoteAddress ());
		}
		tattler.append ('\t');
		tattler.append (tattle);
		tattler.append ('\n');
		System.err.print (tattler);
		System.err.flush ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	protected abstract String tattlePrefix ();

	/**
	 * engage Infinity-mode protocol
	 */
	protected void toInfinityAndBeyond () {
		// no op
	}

}
