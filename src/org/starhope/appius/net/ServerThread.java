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
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.Socket;
import java.net.SocketException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.util.Locale;
import java.util.NoSuchElementException;
import java.util.Queue;
import java.util.Set;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ConcurrentSkipListSet;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Commands;
import org.starhope.appius.game.PreLoginCommands;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.Zone;
import org.starhope.appius.net.datagram.ADPRoomJoin;
import org.starhope.appius.net.datagram.ADPString;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.services.Clodia;
import org.starhope.appius.services.Rhadamanthus;
import org.starhope.appius.sys.admin.TheZones;
import org.starhope.appius.types.ProtocolState;
import org.starhope.appius.user.AbstractPerson;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.User;
import org.starhope.appius.user.events.Action;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;
import org.starhope.util.types.CommandExecutorThread;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/**
 * This is the server thread for Appius Claudius Caecus. One server
 * thread is instantiated for each connected user.
 *
 * @author brpocock@star-hope.org
 */
public class ServerThread extends NetIOThread implements
		ServerProcessor {

	/**
	 * threads adopted by this one
	 */
	private final Set <Thread> adopted = new ConcurrentSkipListSet <Thread> ();

	/**
	 * While we are processing a transaction for the user (during
	 * command processing), this flag is brought high to block idle
	 * timeouts due to overlong transactions
	 */
	protected boolean busyState;

	/**
	 * The queue of all datagrams pending for this user. The user should
	 * receive these as soon as possible.
	 */
	protected final Queue <AbstractDatagram> futureDatagrams = new ConcurrentLinkedQueue <AbstractDatagram> ();

	/**
	 * At what time was the user warned about being idle for too long?
	 */
	protected long idleWarned = 0;

	/**
	 * This variable controls the main loop of the server thread. When
	 * it transitions to “false,” the thread will die.
	 */
	protected boolean keepRunning = true;

	/**
	 * The user's language and dialect string for internationalization
	 * and localization
	 */
	private String language_dialect = "en_US";

	/**
	 * The time at which we last received input from the remote user.
	 */
	protected long lastInputTime = -1;

	/**
	 * If the user has been logged in, this flag will be true
	 */
	protected boolean loggedIn = false;

	/**
	 * The maximum number of characters (or is it bytes? I'm unclear on
	 * my own implementation there!) that can be accepted from the
	 * client in a single packet
	 */
	protected final int maxInputSize;

	/**
	 * The user account that is logged in on this thread
	 */
	protected User myUser;

	/**
	 * The number of prelogin commands that can be accepted before the
	 * user is dropped for failing to log in
	 */
	protected int preloginCountdown = AppiusConfig.getIntOrDefault (
			"org.starhope.appius.prelogin.max", 10);

	/**
	 * random key used for SHA1 sum in login
	 */
	protected transient String randomKey;

	/**
	 * The language variant that the session is speaking.
	 */
	protected float streamProtocolLanguage = Float.POSITIVE_INFINITY;
	// 0;
	/**
	 * Time at which users were last nudged to check their online status
	 */
	protected long tLastNudge = System.currentTimeMillis ();

	/**
	 * Default values constructor.
	 */
	UserAgentInfo uaInfo = new UserAgentInfo ();

	/**
	 * Infinity protocol Alef level.
	 */
	private final int infinityAlef = 1;

	/**
	 * constructor used sôlely for {@link WebSocketProcessor} to be
	 * happy.
	 *
	 * @param maxSize the maximum input buffer size
	 */
	protected ServerThread (final int maxSize) {
		maxInputSize = maxSize;
	}

	/**
	 * Create a new thread connected to a given client, in a certain
	 * zone.
	 *
	 * @param newSocket The socket connected to the client
	 */
	public ServerThread (final Socket newSocket) {
		setPriority (Thread.NORM_PRIORITY);
		setName ("prelogin @"
				+ newSocket.getRemoteSocketAddress ().toString ());
		final StringBuilder crossDomain = new StringBuilder ();
		crossDomain
				.append ("<?xml version=\"1.0\"?>\n"
						+ "<!DOCTYPE cross-domain-policy SYSTEM \"http://www.macromedia.com/xml/dtds/cross-domain-policy.dtd\">\n"
						+ "<cross-domain-policy>\n"
						+ "<!-- Place top level domain name -->\n"
						+ "<allow-access-from domain=\"");
		crossDomain.append (AppiusConfig.getTLD ());
		crossDomain.append ("\" secure=\"false\"/>\n");
		crossDomain
				.append ("<allow-access-from domain=\"tootsville.com\" to-ports=\"");
		crossDomain.append (AppiusClaudiusCaecus.getServerPorts ());
		crossDomain.append ("80,443\"/>\n");
		crossDomain
				.append ("<allow-http-request-headers-from domain=\"tootsville.com\" headers=\"*\" />\n");
		crossDomain
				.append ("<!-- use if you need access from subdomains. testing/www/staging.domain.com -->\n");
		crossDomain.append ("<allow-access-from domain=\"*.");
		crossDomain.append (AppiusConfig.getTLD ());
		crossDomain.append ("\" secure=\"false\" />\n");
		crossDomain.append ("<allow-access-from domain=\"*.");
		crossDomain.append (AppiusConfig.getTLD ());
		crossDomain.append ("\" to-ports=\"");
		crossDomain.append (AppiusClaudiusCaecus.getServerPorts ());
		crossDomain.append ("80,443\" />\n");
		crossDomain
				.append ("<allow-http-request-headers-from domain=\"*.tootsville.com\" headers=\"*\" />\n");
		crossDomain
				.append ("<allow-access-from domain=\"*\" secure=\"false\" />\n");
		crossDomain
				.append ("<allow-access-from domain=\"*\" to-ports=\"");
		crossDomain.append (AppiusClaudiusCaecus.getServerPorts ());
		crossDomain.append ("80,443\" />\n");
		crossDomain
				.append ("<allow-http-request-headers-from domain=\"*\" headers=\"*\" />\n");
		crossDomain.append ("</cross-domain-policy>\n");
		letsPlayWithFlash = crossDomain.toString ();
		maxInputSize = AppiusConfig.getMaxInputSize ();
		socket = newSocket;
		genRandomKey (0);
		tattle ("> New connection.", true);
		tattle ("> Set random key:\t" + randomKey);
		lastInputTime = System.currentTimeMillis ();
		AppiusClaudiusCaecus.startTicking (this);
	}

	/**
	 * Just for uncaught exception handler faux-thread
	 *
	 * @param string thread name
	 */
	public ServerThread (final String string) {
		super (string);
		randomKey = getRandomKey ();
		letsPlayWithFlash = "";
		maxInputSize = 1;
	}

	/**
	 * Adopt a thread into this one, starting it executing. This thread
	 * will be made a part of the thread group with the server thread as
	 * its parent (XXX), and should be terminated when the user logs
	 * off. (This does not work… I don't think it does, anyways.)
	 *
	 * @param t a thread to be adopted
	 */
	public void adopt (final Thread t) {
		adopted.add (t);
		t.start ();
		Thread.yield ();
	}

	/**
	 * Send a packet to the user to see if they're still there
	 *
	 * @throws UserDeadException if the user is disconnected
	 */
	protected void areYouThere () throws UserDeadException {
		if (sendFutureDatagrams ()) {
			throw new UserDeadException ();
		}
		final long t = System.currentTimeMillis ();
		final long nudgeTime = AppiusConfig.getNudgeTime ();
		if (t - tLastNudge < nudgeTime) {
			return;
		}
		tLastNudge = t;
		if (null == myUser) {
			if (t - tLastNudge * 10 < nudgeTime) {
				AppiusClaudiusCaecus
						.blather ("Disconnecting due to timeout in prelogin");
				throw new UserDeadException ();
			}
		} else {
			/* Logged-in user thread */
			final JSONObject areYouThere = new JSONObject ();
			try {
				areYouThere.put ("from", "ayt");
				areYouThere.put ("status", true);
				areYouThere.put ("serverTime",
						System.currentTimeMillis ());
				sendResponse (areYouThere, myUser.getRoomNumber (),
						false);
			} catch (final JSONException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"unsolicited ayt packet could not be constructed",
								e);
			}
		}
	}

	/**
	 * Schedule the socket to be closed and terminated ASAP
	 */
	public void close () {
		tattle ("/*/ Closing out this server thread");
		AppiusClaudiusCaecus.stopTicking (this);
		setLoggedIn (false);
		isDone = true;
		state = ProtocolState.PRELOGIN;

		Quaestor.getDefault ().action (
				new Action (myUser, "net.close", getRemoteAddress ()));

		tattle ("/*/ And of the three judges came Rhadamanthus the lawgiver to judge him");
		final Rhadamanthus judge = new Rhadamanthus (this);
		judge.start ();
	}
	
	/**
	 * Process a command from a JSON source
	 * 
	 * @param cmd The command to be processed
	 * @param jso The JSON data object to be passed into the relevant
	 *            command
	 * @param channel the channel the JSON command came in on
	 * @param klass The dispatcher class responsible for handling this
	 *            command
	 */
	public void commandJSON (final String cmd, final JSONObject jso,
			final String channel,
			final Class <?> klass) {
		LibMisc.commandJSON (cmd, jso, this, myUser, channel, klass);
	}

	/**
	 * Disconnect *this* user, with a notification that they have logged
	 * in from someplace else.
	 */
	public void disconnectDuplicate () {
		if (null != myUser && null != myUser.getZone ()) {
			tattle ("disconnecting duplicate instance of "
					+ myUser.getAvatarLabel ());
			AppiusClaudiusCaecus.logEvent ("login.duplicate", myUser
					.getZone ().getName (), myUser.getUserName (),
					myUser.getPassword (), null);
			sendAdminDisconnect (LibMisc.getText ("login.duplicate"),
					"Duplicate Login", "System", "login.duplicate");
			myUser.getZone ().remove (myUser);
			myUser = null;
		} else {
			tattle ("disconnecting duplicate failed for "
					+ (null == myUser ? "null user ... " : ""));
		}
	}

	/**
	 * Nudge the user to see if they're dead yet
	 *
	 * @param t the current time
	 * @throws UserDeadException if they are, in fact, dead
	 */
	protected void doNudge (final long t) throws UserDeadException {
		if (null == myUser) {
			/* Prelogin thread */
			if (null == socket) {
				throw new UserDeadException ();
			}
			checkInputStream ();
			if ( !socket.isConnected ()) {
				dropSocketConnection ();
				throw new UserDeadException ();
			}
			tLastNudge = t;
		} else if ( !this.equals (myUser.getServerThread ())) {
			throw new UserDeadException ();
		}
	}

	/**
	 * @param theInput to be processed
	 * @return the results
	 */
	@Override
	protected String doProcessing (final String theInput) {
		if (Float.POSITIVE_INFINITY == streamProtocolLanguage) {
			return processInput_Infinity (theInput);
		}

		return processInput_SmartFoxServer (theInput);
	}

	/**
	 * Close the socket, terminate the connection
	 */
	public void doRealClose () {
		tattle ("/*/ Performing deferred processing of death in side thread");

		dropSocketConnection ();

		Room userRoom = null;
		try {
			if (null == myUser) {
				return;
			}
			synchronized (myUser) {
				userRoom = myUser.getRoom ();
			}
		} catch (final NullPointerException e) {
			// No op
		}
		final Zone zone = myUser.getZone ();
		try {
			if (null != userRoom) {
				tattle ("/*/ Parting from room "
						+ userRoom.getMoniker () + " (#"
						+ userRoom.getID () + ")");
				userRoom.part (myUser);
			}
		} catch (final NullPointerException e) {
			// No op
		}

		try {
			if (null != zone) {
				tattle ("/*/ Parting from zone " + zone.getName ());
				zone.remove (myUser);
			}
		} catch (final NullPointerException e) {
			// No op
		}

		myUser = null;
	}

	/**
	 * Indicate that this thread should cease to breathe. This sets the
	 * keepRunning flag to “false” to terminate the main loop, and
	 * throws an arbitrary interrupt to smash whatever might be going on
	 * already.
	 */
	public void end () {
		tattle ("Good-bye, cruel worlds!");
		keepRunning = false;
		interrupt ();
	}

	/**
	 * Enter into a Zone (set the local zone indicator)
	 *
	 * @param zoneName the name of the Zone
	 */
	public void enterZone (final String zoneName) {
		final Zone zone = AppiusClaudiusCaecus.getZone (zoneName);
		if (zone != null) {
			zone.add (myUser);
		}
	}

	/**
	 * Enter into a Zone (set the local zone indicator)
	 *
	 * @param whichZone The zone being entered
	 */
	public void enterZone (final Zone whichZone) {
		if (whichZone != null) {
			whichZone.add (myUser);
		}
	}

	/**
	 * @see org.starhope.appius.net.NetIOThread#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object other) {
		if (null == other) {
			return false;
		}
		return toString ().equals (other.toString ());
	}

	/**
	 * This method is called when login fails. At present, it just
	 * closes the connection.
	 */
	public void failLogin () {
		tattle ("fail Login");
		close ();
	}

	/**
	 * @see java.lang.Object#finalize()
	 */
	@Override
	protected void finalize () throws Throwable {
		for (final Thread t : adopted) {
			if (t instanceof Clodia) {
				((Clodia) t).quit ();
			}
			if (t instanceof CommandExecutorThread) {
				((CommandExecutorThread) t).quit ();
			}
		}
		super.finalize ();
	}

	/**
	 * <p>
	 * Generate a new random key:
	 * </p>
	 * <p>
	 * If mode is 0, avoid characters that won't work with Smart Fox
	 * Server clients;
	 * </p>
	 * <p>
	 * If mode is Double.POSITIVE_INFINITY, don't worry about it
	 * </p>
	 *
	 * @param mode the random key generation mode
	 */
	protected void genRandomKey (final double mode) {
		final StringBuilder randy = new StringBuilder ();
		boolean truncate = false;
		debug = AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.debug");

		if (Double.POSITIVE_INFINITY == mode) {
			for (int i = 0; i < 32
					&& (i > 16 ? truncate == false : true); ++i) {
				randy.append ((char) AppiusConfig
						.getRandomInt (33, 126));
				truncate = AppiusConfig.getRandomInt (1, 5) == 1;
			}
		} else if (0 == mode) {
			for (int i = 0; i < 20
					&& (i > 10 ? truncate == false : true); ++i) {
				char tryChar = '\0';
				while (tryChar <= ' ' || tryChar == '&'
						|| tryChar == '<' || tryChar == '\'') {
					tryChar = (char) AppiusConfig
							.getRandomInt (33, 126);
				}
				randy.append (tryChar);
				truncate = AppiusConfig.getRandomInt (1, 10) > 7;
			}
		} else {
			throw new NoSuchElementException ("unknown apple mode");
		}
		randomKey = randy.toString ();
	}
	
	/**
	 * Get the “apple” (CHAP authentication string SHA1 digest encoded
	 * in hex) for the login system
	 * 
	 * @param pass The plaintext password to be used
	 * @return the “apple” string
	 */
	public String getApple (final String pass) {
		/* Check the CHAP apple hex code sequence */
		final String apple = getRandomKey ();

		final String appleSeed = apple + pass;
		return sha1hexify (appleSeed);
	}

	/**
	 * @return The string form of the client's IP address (may be IPv4
	 *         or IPv6)
	 */
	public String getIPAddress () {
		if (null == socket) {
			close ();
			return null;
		}
		final String hostAndAddress = socket.getInetAddress ()
				.toString ();
		final String [] chunky = hostAndAddress.split ("/");
		if (chunky.length < 2) {
			close ();
			return null;
		}
		return chunky [1];
	}

	/**
	 * @see LocalisedThread#getLanguage()
	 * @return the language and dialect to be used for
	 *         Internationalisations and localisation
	 */
	public String getLanguage () {
		return language_dialect;
	}

	/**
	 * @return the random key sequence generated for this client thread
	 */
	public String getRandomKey () {
		return randomKey;
	}

	/**
	 * Generate a new random key in the specified mode, and then return
	 * it. This destroys any existing apple that might have existed
	 *
	 * @param mode the random mode for {@link #genRandomKey(double)}
	 * @return the newly-generated random key
	 */
	public String getRandomKey (final double mode) {
		genRandomKey (mode);
		return randomKey;
	}

	/**
	 * @deprecated use {@link #getStreamProtocolLanguage()}
	 * @return the sfVersion
	 */
	@Deprecated
	public double getSFSVersion () {
		return getStreamProtocolLanguage ();
	}

	/**
	 * get the language code used for the stream protocol
	 *
	 * @return the language code used for the stream protocol
	 */
	public double getStreamProtocolLanguage () {
		return streamProtocolLanguage;
	}

	/**
	 * Prepare the I/O streams, so that they can be used.
	 * 
	 * @return the socket
	 * @throws UserDeadException WRITEME
	 * @throws IOException WRITEME
	 */
	protected Socket getStreamsReady () throws UserDeadException,
			IOException {
		final Socket sock = getSocket ();
		if (null == sock) {
			throw new UserDeadException ();
		}
		out = new PrintWriter (sock.getOutputStream (), true);
		in = new BufferedReader (new InputStreamReader (
				sock.getInputStream ()));
		if (null == out || null == in) {
			throw new UserDeadException ();
		}
		return sock;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2234 $";
	}

	/**
	 * @return the user connected to this server thread
	 */
	public GeneralUser getUser () {
		return myUser;
	}

	/**
	 * @return the user-agent information about the currently-connected
	 *         client on this thread. (Note that this is voluntarily
	 *         supplied by clients using Infinity mode Aleph-2)
	 */
	public UserAgentInfo getUserAgentInfo () {
		return uaInfo;
	}

	/**
	 * Get input from the client stream
	 *
	 * @return the input from the client
	 * @throws UserDeadException if the user disconnects
	 */
	protected String grabInput () throws UserDeadException {

		final StringBuilder inputBuilder = new StringBuilder ();
		int chr = -1;
		boolean notReady = false;
		while (keepRunning) {

			if (null == socket || socket.isClosed ()) {
				return null;
			}

			if (sendFutureDatagrams ()) {
				return null;
			}

			/*
			 * Any input
			 */
			try {

				if (in.ready ()) {
					try {
						chr = in.read ();
					} catch (final java.net.SocketException e) {
						chr = -1;
						tattle ("//quit// User disconnected (or something like that)");
					}
					if (chr == '\0') {
						break;
					}
					if (chr == -1) {
						isDone = true;
						tattle ("End of file");
						close ();
						break;
					}
					inputBuilder.append ((char) chr);
					if (inputBuilder.length () > maxInputSize) {
						tattle ("!Input exceeds " + maxInputSize
								+ " chars; cutting it off here.\n");
						break;
					}
				} else { // no input pending
					notReady = true;
				}

			} catch (final IOException e) {
				AppiusClaudiusCaecus.reportBug (e);
				tattle ("I/O exception");
				close ();
				return null;
			}
			if (notReady) {
				// try {
				// superVerbose ("ayt");
				areYouThere ();
				// superVerbose ("yield");
				Thread.yield ();
				// superVerbose ("sleep");
				// Thread.sleep (AppiusConfig.getIntOrDefault (
				// "org.starhope.appius.ioDelay", 5));
				// } catch (final InterruptedException e) {
				// // no problem, keep going
				// }
			}

		} // While true ...

		final String inputLine = inputBuilder.toString ();
		if (isDebug ()) {
			tattle ("//recv//" + inputLine);
		}

		return inputLine;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getName ());
	}

	/**
	 * @return true, if a user has logged in on this thread
	 */
	public boolean isLoggedIn () {
		return loggedIn;
	}

	/**
	 * Kick offline any duplicates of the given user as s/he logs in
	 *
	 * @param user The user logging in (whose duplicates should be
	 *            disconnected)
	 * @param nick The user's nickname (login name)
	 */
	protected void kickDuplicates (final User user, final String nick) {
		if (null == user) {
			return;
		}
		if (user.isOnline () && !this.equals (user.getServerThread ())) {
			tattle (nick
					+ " is now here in two zones. Let's get rid of that evil twin from "
					+ user.getLastZone () + "...");
			final ServerThread otherThread = user.getServerThread ();
			myUser = user;
			if (null != otherThread) {
				otherThread.disconnectDuplicate ();
			}
		}
	}

	/**
	 * Kick offline any duplicates of the given user as s/he logs in
	 *
	 * @param user The user logging in (whose duplicates should be
	 *            disconnected)
	 * @param nick The user's nickname (login name)
	 * @param password The user's password (ignored)
	 * @deprecated use {@link #kickDuplicates(User, String)}
	 */
	@Deprecated
	protected void kickDuplicates (final User user, final String nick,
			final String password) {
		kickDuplicates (user, nick);
	}

	/**
	 * Process a login request from the user
	 *
	 * @param z The zone into which the user is trying to log in
	 * @param bigNick The user's requested nickname (attempted user
	 *            name)
	 * @param password This is a bit of a misnomer. We actually are
	 *            checking for the secret key (CHAP cookie) for the
	 *            current channel, to which has been appended the user's
	 *            actual password, as presented as a hex-coded SHA1
	 *            digest. (In brief: pseudocode of sha1( cookie +
	 *            password ).toHex )
	 * @return true, if the user can log in; false, if they were refused
	 */
	public boolean logIn (final Zone z, final String bigNick,
			final String password) {
		final String nick = bigNick.toLowerCase (Locale.ENGLISH);
		AppiusClaudiusCaecus.blather ("attempt as “" + nick + "”", "",
				getRemoteAddress (), "Login attempt with “" + password
						+ "” against “" + randomKey + "”", true);
		if (null == z) {
			return false;
		}
		final String zoneName = z.getName ();

		if (AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.load.test")
				&& nick.startsWith ("$loadclient.")) {
			if (false == logIn_loadTest_autoCreateFakeUser (nick)) {
				return false;
			}
		}

		/* See if there's a user with the specified nickname */
		final AbstractUser user = Nomenclator.getUserByLogin (nick);
		if (null == user || ! (user instanceof GeneralUser)) {
			sendNoSuchUser (nick, zoneName, password);
			return false;
		}

		/* Check password */
		if (false == logIn_checkPassword ((User) user, password, z)) {
			return false;
		}

		/* See if the user is kicked or banned */
		if (false == logIn_checkUserAllowed (user)) {
			return false;
		}

		/* At this point, they are actually logging in */
		postLogIn (z, password, user);

		return true;
	}

	/**
	 * Check whether the supplied password (encrypted in SHA-1) is
	 * correct. If it's incorrect, send a norification to that effect.
	 *
	 * @param user the user attempting to log in
	 * @param password the seeded SHA-1 hash of the password
	 * @param z the zone into which the user is attempting to log in
	 * @return true, if the password was correct, else false.
	 */
	protected boolean logIn_checkPassword (final User user,
			final String password, final Zone z) {
		if ( !password.equals (getApple ( ((AbstractPerson) user)
				.getPassword ()))) {
			sendBadPassword (z, user, password);
			return false;
		}
		return true;
	}

	/**
	 * Check whether the user is permitted to log in. Reasons to
	 * <em>not</em> be permitted include being kicked, banned, canceled,
	 * or not having permission to connect to a beta test server
	 *
	 * @param user the user in question
	 * @return true, if the user is allowed to log in
	 */
	protected boolean logIn_checkUserAllowed (final AbstractUser user) {
		if ( !AppiusConfig
				.getConfigBoolOrFalse ("com.tootsville.bugs.ignoreCancel")) {
			if (user.isCanceled ()) {
				Quaestor.getLocal ().action (
						new Action (null, user, "login.fail.canceled"));
				sendLogKO (LibMisc.getText ("canceled"));
				return false;
			}
		}

		if (user.isBanned () || user.isKicked ()) {
			sendLogKO (user.getKickedMessage ());
			return false;
		}

		if (AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.betaTest")) {
			if ( ! ((GeneralUser) user).canBetaTest ()) {
				sendLogKO ("This is a protected server. Your account is not enabled here.");
				return false;
			}
		}

		return true;
	}

	/**
	 * Automatically create a fake user in the database for load-testing
	 * purposes only.
	 *
	 * @param nick the new user's nickname
	 * @return true, if the user was created
	 */
	protected boolean logIn_loadTest_autoCreateFakeUser (
			final String nick) {
		AbstractUser load = Nomenclator.getUserByLogin (nick);
		if (null == load) {
			try {
				load = Nomenclator
						.create (
								new Date (
										System.currentTimeMillis ()
												- AppiusClaudiusCaecus.TWENTY_ONE_YEARS_MSEC),
								"moo", nick);
			} catch (final NumberFormatException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Load client autocreation hit an irrational date of birth",
								e);
				return false;
			} catch (final AlreadyUsedException e) {
				load = Nomenclator.getUserByLogin (nick);
			} catch (final ForbiddenUserException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a ForbiddenUserException for load client login",
								e);
				return false;
			}

		}
		if (load instanceof GeneralUser) {
			((User) load).setPassword ("p4$$w0rd");
		}
		load.setAgeGroupToSystem ();
		return true;
	}

	/**
	 * Log out of the game
	 */
	public void logout () {
		setLoggedIn (false);
		state = ProtocolState.PRELOGIN;
		preloginCountdown = AppiusConfig.getIntOrDefault (
				"org.starhope.appius.prelogin.max", 10);
		if (null != myUser) {
			final Room r = myUser.getRoom ();
			if (null != r && null != r.getZone ()) {
				r.part (myUser);
			}
		}
		if (null != myUser.getZone ()) {
			myUser.getZone ().remove (myUser);
		}
		myUser = null;
		sendFutureDatagrams ();
	}

	/**
	 * Order this user to migrate to another Appius Claudius Caecus
	 * server.
	 *
	 * @param hostName The alternate server's public host name or IP
	 *            address string
	 * @param portNumber The listening port on the alternate server
	 * @param zoneName The zone name to which the user should connect
	 */
	public void migrate (final String hostName, final int portNumber,
			final String zoneName) {
		try {
			final JSONObject migration = new JSONObject ();
			try {
				migration.put ("from", "migrate");
				migration.put ("status", "true");
				migration.put ("host", hostName);
				migration.put ("port", portNumber);
				migration.put ("zone", zoneName);
			} catch (final JSONException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a JSONException in ServerThread.migrate ",
								e);
			}
			sendRawMessageNow (new ADPString (migration.toString (),
					null));
		} catch (final UserDeadException e) {
			// Dead users don't have to migrate.
		}
	}

	/**
	 * Handle post-login events
	 *
	 * @param z zone
	 * @param password user's (encrypted) password sequence
	 * @param user user
	 */
	protected void postLogIn (final Zone z, final String password,
			final AbstractUser user) {

		myUser = (User) user;
		// myUser.updateCache ();
		final Socket s = getSocket ();
		final String remoteAddress = null == s ? "(local)"
				: getRemoteAddress ();

		Thread.currentThread ().setName (
				"u:" + user.getAvatarLabel () + "=#"
						+ user.getUserID () + "@" + remoteAddress);

		if (null != s) {
			synchronized (socket) {
				AppiusClaudiusCaecus.blather (user.getAvatarLabel (),
						"Zone “" + z.getName () + "”", remoteAddress,
						"Welcome", false);
			}
		}

		/* Check for duplicate user in any Zone */
		kickDuplicates ((User) user, password);

		setLoggedIn (true);
		myUser.setServerThread (this);
		state = ProtocolState.READY;
		z.add (user);

		sendLoginPacket (z.getName (), user.getAvatarLabel (), password);
		myUser.postLoginGlobal ();
	}
	
	/**
	 * Prepare the connection pipelines
	 * 
	 * @throws UserDeadException WRITEME
	 */
	private void primeConnection () throws UserDeadException {
		String outputLine;
		try {
			tattle ("//helo//Priming with null input");
			outputLine = processInput ("");
		} catch (final Exception e) {
			AppiusClaudiusCaecus.reportBug (e);
			outputLine = "?ERR\tE\t" + e.toString () + "\n"
					+ LibMisc.stringify (e) + "\07\n\0";
		} catch (final Error e) {
			AppiusClaudiusCaecus.reportBug (e.toString () + "\n"
					+ LibMisc.stringify (e));
			outputLine = "?ERR\tERR\t" + e.toString () + "\n"
					+ LibMisc.stringify (e) + "\07\n\0";
		}
		if (null == outputLine) {
			tattle ("//bye//Null output means nobody's there");
			dropSocketConnection ();
			return;
		}
		if (outputLine.length () > 0) {
			if (isDebug ()) {
				tattle ("//send//" + outputLine);
			}
			sendRawMessageNow (new ADPString (outputLine, null));
		} else if (isDebug ()) {
			tattle ("// nothing to send //");
		}
	}

	/**
	 * @see #processInput(String) handler for Infinity protocol
	 * @param theInput an input string from the client
	 * @return a string to output to the client
	 */
	@Override
	protected String processInput_Infinity (final String theInput) {
		switch (state) {
		case ProtocolState.CLOSED:
		default:
			sendAdminDisconnect (
					"You were disconnected from the server successfully",
					"Disconnect", "System", "protocol.closed");
			return null;
		case ProtocolState.PRELOGIN:
			return processJSONPreLogin (theInput);
		case ProtocolState.READY:
			return processJSONInput (theInput);
		}
	}

	/**
	 * @see #processInput(String) handler for Smart Fox Server
	 *      compatibility protocol
	 * @param theInput the input string from the client
	 * @return an output string to the client
	 */
	protected String processInput_SmartFoxServer (final String theInput) {
		/* Smart Fox Server Protocol */
		switch (state) {
		case ProtocolState.CLOSED:
		default:
			sendAdminDisconnect (
					"You were disconnected from the server successfully",
					"Disconnect", "System", "protocol.closed");
			return null;
		case ProtocolState.WAITING:
			tattle ("Entered via WAITING state");
			state = ProtocolState.PRELOGIN;
			return letsPlayWithFlash;
		case ProtocolState.PRELOGIN:
			try {
				return processPreLogin (theInput);
			} catch (final UserDeadException e) {
				return null;
			}
		case ProtocolState.READY:
			if (theInput.charAt (0) == '<') {
				return processXMLInput (theInput);
			} else if (theInput.charAt (0) == '{') {
				return processJSONInput (theInput);
			} else {
				return "?ERR\tformat\07\n";
			}
		}
	}

	/**
	 * Process a JSON string from the client
	 *
	 * @param theInput The JSON string containing the command and data
	 * @return A sequence to return to the client
	 */
	protected String processJSONInput (final String theInput) {
		JSONObject jso = null;
		try {
			jso = new JSONObject (theInput);
			final JSONObject callParams;
			final String channel = jso.has ("ch") ? jso
					.optString ("ch") : null;
			if (jso.has ("c")) {
				commandJSON (jso.getString ("c"),
						jso.getJSONObject ("d"), channel,
						Commands.class);
			} else if (jso.has ("o")) {
				callParams = jso.getJSONObject ("o");
				// final int roomNumber = jso.getInt ("r");
				final String cmd = jso.getString ("xt");
				commandJSON (cmd, callParams, channel, Commands.class);
			} else {
				final JSONObject bParams = jso.getJSONObject ("b");
				final String cmd = bParams.getString ("c");
				// final int roomNumber = bParams.getInt ("r");
				callParams = bParams.getJSONObject ("p");
				commandJSON (cmd, callParams, channel, Commands.class);
			}
			return "";
		} catch (final JSONException e) {
			return "?ERR\tjson\t" + e.toString ();
		}
	}

	/**
	 * Process a prelogin JSON command
	 *
	 * @param theInput The input string, which must contain a
	 *            properly-formatted JSON command sequence
	 * @return a result string to be returned to the client
	 */
	protected String processJSONPreLogin (final String theInput) {
		JSONObject jso = null;
		try {
			jso = new JSONObject (theInput);

			if (jso.has ("c")) {
				final JSONObject callParams = jso.getJSONObject ("d");

				commandJSON (jso.getString ("c"), callParams,
						null, PreLoginCommands.class);
			} else {
				return "?ERR\tjson\tno c\n";
			}
		} catch (final JSONException e) {
			return "?ERR\tjson\t" + e.toString ();
		}
		return "";
	}

	/**
	 * Process a prelogin input sequence
	 *
	 * @param theInput the prelogin input sequence
	 * @return the output string to return to the client
	 * @throws UserDeadException if the user disconnects
	 */
	protected String processPreLogin (final String theInput)
			throws UserDeadException {
		if ( --preloginCountdown < 0) {
			sendRawMessageNow (new ADPString ("?ERR\tnolog\07\n", null));
			sendAdminDisconnect (
					"Failed to present login credentials: You did not provide a user name and password within the allowed limits",
					"Failed to log in", "System", "protocol.nolog");
			return null;
		}

		if (theInput.charAt (0) == '{') {
			return processJSONPreLogin (theInput);
		}

		if (theInput.indexOf ("policy-file-request") > -1) {
			return letsPlayWithFlash;
		}

		if (theInput.indexOf ("rndK") > -1) {
			return "<msg t='sys'><body action='rndK' r='-1'><k>"
					+ getRandomKey () + "</k></body></msg>";
		}

		if (theInput.indexOf ("verChk") > -1) {
			if (theInput.indexOf ("158") > -1) {
				setSFSVersion ((float) 1.58);
			} else if (theInput.indexOf ("\u221e") > -1) {
				setSFSVersion (Float.POSITIVE_INFINITY);
			} else {
				return "?ERR\tverChk\07\n";
			}
			return "<msg t='sys'><body action='apiOK' r='0'></body></msg>";
		}

		if (theInput.indexOf ("login") > -1) {
			final String [] segments = theInput.split ("'");
			if (segments.length < 7) {
				return "?ERR\tlogin.syntax\07\n";
			}
			final String zoneName = segments [7];
			final String userName = theInput.substring (
					theInput.indexOf ("<nick><![CDATA[") + 15,
					theInput.indexOf ("]]>"));
			String password = theInput.substring (theInput
					.indexOf ("<pword><![CDATA[") + 16);
			password = password.substring (0, password.indexOf ("]]>"));
			tattle ("login attempt\tzone:" + zoneName + "\tlogin:"
					+ userName + "\tpass:" + password);
			if (zoneName.length () > 0 && userName.length () > 0
					&& password.length () > 0) {
				final Zone zone = AppiusClaudiusCaecus
						.getZone (zoneName);
				if (null == zone || !zone.getName ().equals (zoneName)) {
					tattle ("didn't find the zone");
					return "{\"from\":\"zone\", \"success\":\"false\", \"err\":\"zone.notFound\", \"msg\":\"That zone does not exist\"}";
				}
				tattle ("handling login process");
				if (logIn (zone, userName, password)) {
					state = ProtocolState.READY;
				}
			}
			return "";
		}

		return "?ERR\tprelogin\tsyntax\07\n";
	}

	/**
	 * @param theInput The input stream, expected to be in Smart Fox
	 *            Server Pro XML format
	 * @return A result string to be returned to the user
	 */
	protected String processXMLInput (final String theInput) {
		tattle ("XML input: " + theInput);
		final Document xml;
		try {
			final DocumentBuilderFactory dbf = DocumentBuilderFactory
					.newInstance ();

			try {

				// Using factory get an instance of document builder
				final DocumentBuilder db = dbf.newDocumentBuilder ();

				// parse using builder to get DOM representation of the
				// XML file
				xml = db.parse (new ByteArrayInputStream (theInput
						.getBytes ()));

			} catch (final ParserConfigurationException pce) {
				AppiusClaudiusCaecus.reportBug (pce);
				return "?ERR\txml\tconfig\07\n";
			} catch (final SAXException se) {
				AppiusClaudiusCaecus.reportBug (se);
				return "?ERR\txml\tsax\07\n";
			} catch (final IOException ioe) {
				AppiusClaudiusCaecus.reportBug (ioe);
				return "?ERR\txml\tio\07\n";
			}

		} catch (final java.lang.ExceptionInInitializerError e) {
			return "?ERR\txml\tcan't initialize XMLParser\07\n";
		}
		final Node msgEl = xml.getChildNodes ().item (0);
		if (null == msgEl) {
			return "?ERR\txml\tno top element\07\n";
		}
		if ( !msgEl.getNodeName ().equals ("msg")) {
			return "?ERR\txml\texpected msg element\tgot\t"
					+ msgEl.getNodeName () + "\07\n";
		}
		final Node tAttr = msgEl.getAttributes ().getNamedItem ("t");
		if (null == tAttr) {
			return "?ERR\txml\texpected t attribute\07\n";
		}
		if ( !tAttr.getNodeValue ().equals ("sys")) {
			return "?ERR\txml\texpected t=sys\07\n";
		}
		final Node body = msgEl.getChildNodes ().item (0);
		if (null == body) {
			return "?ERR\txml\texpected body element\07\n";
		}
		final Node actionAttr = body.getAttributes ().getNamedItem (
				"action");
		if (null == actionAttr) {
			return "?ERR\txml\texpected action attribute\07\n";
		}
		final String cmd = actionAttr.getNodeValue ();
		final Node rAttr = body.getAttributes ().getNamedItem ("r");
		if (null == rAttr) {
			return "?ERR\txml\texpected room attribute\07\n";
		}
		final Integer roomNum = new Integer (rAttr.getNodeValue ());
		final NodeList data = body.getChildNodes ();
		tattle ("XML (SmartFaux) command\t" + cmd);
		if (cmd.equals ("getRmList")) {
			return myUser.getZone ().getRoomListSFSXML ();
		} else if (cmd.equals ("logout")) {
			logout ();
			return "";
		} else if (cmd.equals ("setRvars")) {
			final NodeList vars = data.item (0).getChildNodes ();
			for (int i = 0; i < vars.getLength (); ++i) {
				final Node var = vars.item (i);
				myUser.getZone ()
						.getRoom (roomNum)
						.setVariable (
						var.getAttributes ().getNamedItem ("n")
								.getNodeValue (),
						var.getFirstChild ().getNodeValue ());
			}
			return "";
		} else if (cmd.equals ("setUvars")) {
			final NodeList vars = data.item (0).getChildNodes ();
			for (int i = 0; i < vars.getLength (); ++i) {
				final Node var = vars.item (i);
				myUser.setVariable (
						var.getAttributes ().getNamedItem ("n")
								.getNodeValue (), var.getFirstChild ()
								.getNodeValue ());
			}
			return "";
		} else if (cmd.equals ("joinRoom")) {
			final Node room = data.item (0);
			if ( !room.getNodeName ().equals ("room")) {
				return "?ERR\tjoinRoom\texpected room\07\n";
			}
			final Node idAttr = room.getAttributes ().getNamedItem (
					"id");
			if (null == idAttr) {
				return "?ERR\tjoinRoom\texpected room ID\07\n";
			}
			final Integer roomToJoin = new Integer (
					idAttr.getNodeValue ());
			// return zone.handleJoin (myUser, roomNum, roomToJoin);
			myUser.getZone ().getRoom (roomToJoin).join (myUser);
			return "";
		} else if (cmd.equals ("pubMsg")) {
			final String txt = data.item (0).getChildNodes ().item (0)
					.getNodeValue ();
			tattle ("Speech: “" + txt + "” from "
					+ data.item (0).getNodeName ());
			if (null != myUser) {
				myUser.speak (myUser.getZone ().getRoom (roomNum), txt);
			}
			return "";
		} else {
			return "?ERR\tcmd?\07\n\0";
		}
	}

	/**
	 * Run the server thread connected to a client
	 *
	 * @see java.lang.Thread#run()
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

				sendDeferredDatagrams ();
				/*
				 * Process input line
				 */
				if (null == socket || socket.isClosed ()) {
					tattle ("null or closed socket before grabbing input");
					close ();
					return; // End of thread.
				}

				final String inputLine = grabInput ();
				final String outputLine = processInput (inputLine);

				if (null == socket || socket.isClosed ()) {
					tattle ("null or closed socket after grabbing input");
					close ();
					return;
				}

				/*
				 * If the output is null pointer, we're done
				 */
				if (null == outputLine) {
					if (isDebug ()) {
						tattle ("//end.// The End.");
					}
					close ();
					return; // End of thread.
				}
				/*
				 * If the output is empty, don't send anything.
				 */
				if ( ! ("".equals (outputLine) || "\0"
						.equals (outputLine))) {
					sendRawMessageNow (new ADPString (outputLine, null));
				}
				if (isDone) {
					tattle ("//end.// Ending from EOF");
					close ();
					return; // End of thread.
				}

			}

		} catch (final IOException e) {
			AppiusClaudiusCaecus.reportBug (e);
		} catch (final UserDeadException e) {
			tattle ("//end.// UserDeadException");
			// AppiusClaudiusCaecus.reportBug (e);
			close ();
			return;
		} catch (final Throwable e) {
			AppiusClaudiusCaecus.reportBug (e);
		} finally {
			dropSocketConnection ();
		}

		AppiusClaudiusCaecus.getCharon ().addZombie (this);

		// End of thread.
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param result WRITEME
	 * @return WRITEME
	 * @throws JSONException WRITEME
	 */
	private boolean send$EdenLogin (final JSONObject result)
			throws JSONException {

		/*
		 * If there are not 2 zones active already (at least $Eden and
		 * one “real” zone), then wait for up to 30 seconds.
		 */
		int waitForZones = 30;
		while (TheZones.local ()
				.getZonesOn (AppiusClaudiusCaecus.getServerHostname ())
				.size () < 2) {
			try {
				Thread.sleep (1000);
				if ( --waitForZones < 0) {
					sendAdminDisconnect (
							"The server does not have any active game zones at this time. Please come back later.",
							"Server Unavailable", "Server",
							"srv.noZones");
					return true;
				}
			} catch (InterruptedException e) {
				// No op, but don't count down the 30 seconds, either.
			}
		}
		result.put ("zoneList",
				myUser.getZone ().getZoneList_JSON (myUser));
		if (null == myUser) {
			AppiusClaudiusCaecus.reportBug ("Logged in a null user?");
			sendLogKO ("An unexpected error has occurred and we are not able to identify the user account that you have named. "
					+ userDebug ("E001"));
			return true;
		}
		final String lastZone = myUser.getLastZone ();
		result.put ("lastZone", null == lastZone ? "" : lastZone);
		return false;
	}

	/**
	 * Send a disconnection message, and drop the user on the next
	 * client cycle. This is an asynchronous drop, but it clears all
	 * other pending output, ensuring that the client will receive this
	 * message next in queue and then disconnect.
	 *
	 * @param message User-visible message explaining the disconnection
	 * @param title Title to display in message box
	 * @param label Label to display in corner of message box
	 * @param disconnectCause Cause code to return to client application
	 *            giving general cause for disconnection; e.g. "kick" or
	 *            "ban" usually
	 */
	public void sendAdminDisconnect (final String message,
			final String title, final String label,
			final String disconnectCause) {

		final JSONObject messagePacket = new JSONObject ();
		try {
			messagePacket.put ("from", "admin");
			messagePacket.put ("status", true);
			messagePacket.put ("title", title);
			messagePacket.put ("label", label);
			messagePacket.put ("message", message);
			messagePacket.put ("disconnect", true);
			messagePacket.put ("cause", disconnectCause);
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (e);
			tattle ("adminDisconnect hit JSONException");
			close ();
			return;
		}
		futureDatagrams.clear ();
		if (Double.POSITIVE_INFINITY == streamProtocolLanguage) {
			futureDatagrams.add (new ADPString (messagePacket
					.toString (), true, null));
		} else {
			futureDatagrams.add (new ADPString (
					"{\"t\":\"xt\",\"b\":{\"r\":-1,\"o\":"
							+ messagePacket.toString () + "}}", true,
					null));
		}
		return;
	}

	/**
	 * Send an administrative message to the user.
	 *
	 * @param message administrative message to send
	 * @param remote if true, this is being written to another user
	 * @throws UserDeadException if the user has been disconnected
	 * @see #sendAdminMessage(String, String, String, boolean)
	 */
	public void sendAdminMessage (final String message,
			final boolean remote) throws UserDeadException {
		sendAdminMessage (message, "", "ADMIN", remote);
	}

	/**
	 * Send an administrative message. Attempts to use the JSON protocol
	 * for all clients now. If the data can't be successfully encoded
	 * into
	 *
	 * @param message The actual message text
	 * @param title The title, which displays in the same font above the
	 *            message, but does not scroll
	 * @param hatLabel A short label which identifies the general source
	 *            of the message, for dialog box decoration
	 * @param remote Whether to send this message remotely (true =
	 *            deferred delivery) or immediately (false)
	 * @throws UserDeadException if the user isn't there to receive the
	 *             message
	 */
	public void sendAdminMessage (final String message,
			final String title, final String hatLabel,
			final boolean remote) throws UserDeadException {

		if ( !AppiusConfig
				.getConfigBoolOrFalse ("it.gotoandplay.sfs.xmlAdminMessages")) {
			try {
				final JSONObject messagePacket = new JSONObject ();
				messagePacket.put ("from", "admin");
				messagePacket.put ("status", "true");
				messagePacket.put ("title", title);
				messagePacket.put ("label", hatLabel);
				messagePacket.put ("message", message);
				sendResponse (messagePacket, -1, remote);
				return;
			} catch (final JSONException e) {
				if (streamProtocolLanguage == Float.POSITIVE_INFINITY) {
					AppiusClaudiusCaecus.fatalBug (e);
				}
				// else, fall through to the XML dmnMsg form
			}
		}
		int roomID = -1;
		int userID = -1;
		if (null != myUser) {
			roomID = myUser.getRoomNumber ();
			userID = myUser.getUserID ();
			// if (myUser.isOnline () && null != myUser.getZone ()) {
			// myUser.getZone ().tellEaves (myUser, myUser.getRoom (),
			// "mod", message);
			// }
		}
		if (remote) {
			sendRawMessageLater (new ADPString ("<msg t='sys'>"
					+ "<body action='dmnMsg' r='" + roomID + "'>"
					+ "<user id='" + userID + "'/>" + "<txt><![CDATA["
					+ message + "]]></txt>" + "</body></msg>", null));
		} else {
			sendRawMessageNow (new ADPString ("<msg t='sys'>"
					+ "<body action='dmnMsg' r='" + roomID + "'>"
					+ "<user id='" + userID + "'/>" + "<txt><![CDATA["
					+ message + "]]></txt>" + "</body></msg>", null));
		}
	}

	/**
	 * <p>
	 * Send the user a notification that their password was incorrect.
	 * </p>
	 * <p>
	 * Note that the user will actually just get a logKO, we don't give
	 * them any further information — this routine sends some more
	 * logging information, though.
	 * </p>
	 * 
	 * @param failZone The failed zone
	 * @param user The user attempting to log in
	 * @param password The attempted password
	 */
	public void sendBadPassword (final Zone failZone, final User user,
			final String password) {
		sendLogKO ();
		Quaestor.getLocal ().action (
				new Action (user, "login.fail", password));
		tattle ("Our friend "
				+ user.getAvatarLabel ()
				+ " isn't actually here: it's an imposter! (I wanted to hear “"
				+ getApple (user.getPassword ()) + "”)", true);
		AppiusClaudiusCaecus.logEvent ("login.badPass",
				failZone.getName (), user.getAvatarLabel (), password,
				null);
	}

	/**
	 * Send all deferred (future) datagrams pending in the queue
	 *
	 * @throws UserDeadException if the user has disconnected
	 * @deprecated for {@link #sendFutureDatagrams()}
	 */
	@Deprecated
	protected void sendDeferredDatagrams () throws UserDeadException {
		sendFutureDatagrams ();
	}

	/**
	 * <p>
	 * send an error packet to the other party.
	 * </p>
	 *
	 * @param source The method returning the error message
	 * @param error The error message
	 * @param result The payload, if any. May be altered.
	 * @param u The user to whom to send the success reply
	 * @param room The room in which the user is standing
	 * @throws JSONException if the packet can't be created
	 * @throws UserDeadException if the user is not there
	 */
	public void sendErrorReply (final String source,
			final String error, final JSONObject result, final User u,
			final int room) throws JSONException, UserDeadException {
		JSONObject results = result;
		if (null == result) {
			results = new JSONObject ();
		}
		results.put ("status", false);
		results.put ("from", source);
		results.put ("err", error);
		System.err.println ("ERROR: For " + u.getName () + " "
				+ results.toString ());
		sendResponse (results, Integer.valueOf (room), u);
	}

	/**
	 * Send any future datagrams that are pending for this user
	 *
	 * @return true, if the user has been disconnected
	 */
	protected boolean sendFutureDatagrams () {
		/*
		 * All “remote” output enqueued
		 */
		if (futureDatagrams.size () > 0) {
			// tattle ("// sending " + futureDatagrams.size ()
			// + " enqueued datagrams //");
			while (futureDatagrams.size () > 0) {
				if (sendNextFutureDatagram ()) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * Send a game action event message to the client
	 *
	 * @param sender The user sending the game action
	 * @param data Arbitrary data associated with the game action
	 * @throws JSONException if the data can't be represented as JSON
	 * @throws UserDeadException if the user has been disconnected
	 */
	public void sendGameActionMessage (final AbstractUser sender,
			final JSONObject data) throws JSONException,
			UserDeadException {
		final JSONObject result = new JSONObject ();
		result.put ("fromUser", sender.getAvatarLabel ());
		result.put ("from", "gameAction");
		result.put ("status", "true");
		result.put ("data", data);
		sendResponse (result,
				Integer.valueOf (myUser.getRoomNumber ()), myUser);
	}

	/**
	 * Send the bucketfuls of information that we force-feed the client
	 * at login...
	 *
	 * @param zoneName The name of the zone into which the user has
	 *            logged in
	 * @param nick The user's nickname
	 * @param password The user's password (SHA1 encoded with the local
	 *            random key)
	 */
	protected void sendLoginPacket (final String zoneName,
			final String nick, final String password) {
		/*
		 * Send login packet
		 */
		AppiusClaudiusCaecus.logEvent ("login", zoneName, nick,
				password, null);

		if (null == myUser) {
			AppiusClaudiusCaecus.reportBug ("Logged in no user?");
			sendLogKO ("An unexpected error has occurred and we are not able to identify the user account that you have named. "
					+ userDebug ("E001"));
			return;
		}
		myUser.loggedIn (zoneName, this);

		final JSONObject result = new JSONObject ();
		try {
			result.put ("_cmd", "logOK");
			/*
			 * In $Eden, send the list of “real” zones
			 */
			if ("$Eden".equals (zoneName)) {
				if (send$EdenLogin (result)) {
					return;
				}
			} else {
				AppiusClaudiusCaecus
						.blather ("Cast out from the garden…");
				// result.put ("lobby", zone.getNextLobby ());
				/*
				 * BRP: the "lobby" line had been commented out, but I
				 * don't know why, so, I've re-enabled it. … 2010-5-26
				 * BRP: it throws an NPE, that's why. 2010-5-26 TODO
				 */
			}
			/*
			 * Other stuff we tell them about themselves.
			 */
			result.put ("user", myUser.toJSON ());
			result.put ("sfsUserID", myUser.getUserID ());
			AppiusClaudiusCaecus.blather ("LOGIN: " + result);
			try {
				sendResponse (result, ( -1), false);
			} catch (final UserDeadException e) {
				// Don't ask, don't care.
			}
			final Clodia myLittleSocialite = new Clodia (myUser, this);
			adopt (myLittleSocialite);
			Quaestor.getDefault ().action (
					new Action (myUser, "login", zoneName));
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (e);
		}
	}

	/**
	 * Send a login failure message to the client, using the default
	 * (generic) message.
	 */
	protected void sendLogKO () {
		sendLogKO (LibMisc.getText ("login.fail"));
	}

	/**
	 * Send a “KO” message to the client, informing them that they are
	 * not permitted to log in.
	 *
	 * @param messageText The user-visible message given to the user
	 */
	protected void sendLogKO (final String messageText) {
		final JSONObject result = new JSONObject ();
		try {
			result.put ("_cmd", "logKO");
			result.put ("from", "logKO");
			result.put ("err", "login.fail");
			result.put ("msg", messageText);
			try {
				sendResponse (result, -1, false);
			} catch (final UserDeadException e) {
				// ironic
			}
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (e);
		}
		failLogin ();
	}

	/**
	 * Send a single datagram off the queue.
	 *
	 * @return true, if we should disconnect now
	 */
	protected boolean sendNextFutureDatagram () {
		final AbstractDatagram gram = futureDatagrams.remove ();
		try {
			sendRawMessageNow (gram);
		} catch (final UserDeadException e) {
			gram.setDisconnectAfterSending (true);
		}
		if (gram.getDisconnectAfterSending ()) {
			try {
				Thread.sleep (AppiusConfig
						.getIntOrDefault (
								"org.starhope.appius.futureDatagram.disconnectDelay",
								250));
			} catch (final InterruptedException e) {
				// Don't care.
			}
			tattle ("disconnectAfterSending with delay");
			close ();
			return true;
		}
		return false;
	}

	/**
	 * Tell the user to bugger off, because they don't exist. Produces a
	 * login.fail (logKO) packet and makes some nice log entries.
	 *
	 * @param nick the user nickname (login name) attempted
	 * @param zoneName the zone into which they attempted to log in
	 * @param password the password attempted
	 */
	public void sendNoSuchUser (final String nick,
			final String zoneName, final String password) {
		sendLogKO ();
		tattle ("I don't think anyone named " + nick
				+ " really exists.");
		Quaestor.getLocal ().action (
				new Action (null, "login.fail.noUser", nick));
		AppiusClaudiusCaecus.logEvent ("login.noUser", zoneName, nick,
				password, null);
	}

	/**
	 * Send a private (“whisper”) message to the user
	 *
	 * @param from The user sending the message
	 * @param message The message being whispered
	 * @throws UserDeadException if the user has been disconnected
	 */
	public void sendPrivateMessage (final AbstractUser from,
			final String message) throws UserDeadException {
		if (AppiusConfig
				.getConfigBoolOrFalse ("com.tootsville.bugs.noPrivate")) {
			sendPublicMessage (from, message);
			return;
		}
		if (Double.POSITIVE_INFINITY == streamProtocolLanguage) {
			final JSONObject response = new JSONObject ();
			try {
				response.put ("from", "priv");
				response.put ("u", from.getUserID ());
				response.put ("userName", from.getAvatarLabel ());
				response.put ("t", message);
			} catch (final JSONException e) {
				AppiusClaudiusCaecus.fatalBug (e);
			}
			sendResponse (response,
					Integer.valueOf (from.getRoomNumber ()));
			return;
		}
		sendRawMessageLater (new ADPString (
				"<msg t='sys'><body action='prvMsg' r='"
						+ from.getRoomNumber () + "'><user id='"
						+ from.getUserID () + "' /><txt><![CDATA["
						+ message + "]]></txt></body></msg>", null));
	}

	/**
	 * Send a public message
	 *
	 * @param from sender of the message (speaker)
	 * @param message The public message
	 * @throws UserDeadException if the user has been disconnected
	 */
	public void sendPublicMessage (final AbstractUser from,
			final String message) throws UserDeadException {
		if (Double.POSITIVE_INFINITY == streamProtocolLanguage) {
			final JSONObject response = new JSONObject ();
			try {
				response.put ("from", "pub");
				response.put ("u", from.getAvatarLabel ());
				response.put ("id", from.getUserID ());
				response.put ("t", message);
			} catch (final JSONException e) {
				AppiusClaudiusCaecus.fatalBug (e);
			}
			sendResponse (
					response,
					Integer.valueOf (from instanceof GeneralUser ? ((GeneralUser) from)
							.getRoomNumber () : -1));
			return;
		}

		sendRawMessageLater (new ADPString (
				"<msg t='sys'><body action='pubMsg' r='"
						+ (from instanceof GeneralUser ? ((GeneralUser) from).getRoomNumber ()
								: -1) + "'><user id='"
						+ from.getUserID () + "' /><txt><![CDATA["
						+ message + "]]></txt></body></msg>", null));
	}

	/**
	 * @deprecated probably clearer to call
	 *             {@link #sendRawMessageLater(AbstractDatagram)} or
	 *             {@link #sendRawMessageNow(AbstractDatagram)}
	 * @param reply The string to be transmitted to this thread's user
	 * @param remote True, if being written to another user (if being
	 *            written as a deferred future datagram)
	 * @throws UserDeadException if the user has been disconnected
	 */
	@Deprecated
	public void sendRawMessage (final AbstractDatagram reply,
			final boolean remote) throws UserDeadException {
		if (remote) {
			sendRawMessageLater (reply);
			return;
		}

		sendRawMessageNow (reply);
	}

	/**
	 * @deprecated probably clearer to call
	 *             {@link #sendRawMessageLater(String)} or
	 *             {@link #sendRawMessageNow(String)}
	 * @param reply The string to be transmitted to this thread's user
	 * @param remote True, if being written to another user (if being
	 *            written as a deferred future datagram)
	 * @throws UserDeadException if the user has been disconnected
	 */
	@Deprecated
	public void sendRawMessage (final String reply, final boolean remote)
			throws UserDeadException {
		if (remote) {
			sendRawMessageLater (reply);
			return;
		}
		sendRawMessageNow (reply);
	}

	/**
	 * @deprecated use {@link #sendResponse(AbstractDatagram)}
	 */
	@Override
	@Deprecated
	protected void sendRawMessageLater (final AbstractDatagram reply)
			throws UserDeadException {
		sendResponse (reply);
	}

	/**
	 * @param reply the packet to be sent
	 * @throws UserDeadException if the user has disconnected already
	 * @deprecated use {@link #sendRawMessageLater(AbstractDatagram)}
	 */
	@SuppressWarnings ("deprecation")
	@Override
	@Deprecated
	protected void sendRawMessageLater (final String reply)
			throws UserDeadException {
		sendRawMessageLater (new ADPString (reply));
	}

	/**
	 * @see org.starhope.appius.net.NetIOThread#sendRawMessageNow(org.starhope.appius.net.datagram.AbstractDatagram)
	 */
	@Override
	protected void sendRawMessageNow (final AbstractDatagram reply)
			throws UserDeadException {
				if (null == out) {
					throw new UserDeadException ();
				}
				// tattle ("//SEND////" + reply); //
				// {" + futureDatagrams.size () + "}
		final String replyString = reply.toString (
				streamProtocolLanguage, uaInfo);
		if (uaInfo.isPascalMode ()) {
			int replyLength = replyString.getBytes ().length;
			if (replyLength > 0xfe) {
				out.print ((char) 0xff);
				out.print ((long) replyLength);
			} else {
				out.print ((char) replyLength);
			}
		}
		out.print (replyString);
		if ( !uaInfo.isPascalMode ()) {
			out.print ('\0');
		}
				out.flush ();
				if (out.checkError ()) {
					tattle ("//end.//error in output stream");
					throw new UserDeadException ();
				}
				checkInputStream ();
			}

	/**
	 * @param reply the raw string to be sent
	 * @throws UserDeadException if the user has already disconnected
	 * @deprecated use {@link #sendRawMessageNow(AbstractDatagram)}
	 */
	@SuppressWarnings ("deprecation")
	@Override
	@Deprecated
	protected synchronized void sendRawMessageNow (final String reply)
			throws UserDeadException {
		sendRawMessageNow (new ADPString (reply));
	}

	/**
	 * Sends a response as a future datagram
	 *
	 * @param response the datagram to be sent
	 * @throws UserDeadException if the user has already disconnected
	 */
	public void sendResponse (final AbstractDatagram response)
			throws UserDeadException {
		tattle ("//send//(" + futureDatagrams.size () + ")//"
				+ response);
		if (futureDatagrams.size () > AppiusConfig
				.getFutureDatagramsMax ()) {
			final StringBuilder errorMessage = new StringBuilder ();
			errorMessage
					.append ("User has too many future datagrams enqueued (");
			errorMessage.append (futureDatagrams.size ());
			errorMessage
					.append (" exceeds org.starhope.appius.futureDatagramsMax of ");
			errorMessage.append (AppiusConfig.getFutureDatagramsMax ());
			errorMessage.append (") and will be disconnected");
			tattle (errorMessage.toString ());
			sendAdminDisconnect (
					LibMisc.getTextOrDefault (
							"net.backlog",
							"Your connection to the game has become backlogged due to a slow Internet connection. If you are running other programs that access the Internet, such as music or movie players or large downloads, you might need to stop them before signing in."),
					LibMisc.getTextOrDefault ("net.backlog.title",
							"Internet connection backlogged"),
					"System", "backlog");
			throw new UserDeadException ();
		}
		futureDatagrams.add (response);
	}

	/**
	 * Send a response as a future (deferred remote) datagram without a
	 * room specified
	 *
	 * @throws UserDeadException if the user disconnects
	 * @see #sendResponse(JSONObject, int, boolean)
	 * @see org.starhope.util.types.CanProcessCommands#sendResponse(org.json.JSONObject)
	 * @deprecated use {@link #sendResponse(AbstractDatagram)}
	 */
	@Override
	@Deprecated
	public void sendResponse (final JSONObject result)
			throws UserDeadException {
		sendResponse (result, -1, true);
	}

	/**
	 * send a response
	 *
	 * @deprecated use {@link #sendResponse(AbstractDatagram)}
	 * @param result result set
	 * @param room room of event
	 * @param u user to notify
	 * @throws UserDeadException if the user is detected to have been
	 *             disconnected
	 */
	@Deprecated
	public void sendResponse (final JSONObject result, final int room,
			final AbstractUser u) throws UserDeadException {
		sendResponse (result, room, null != myUser && null != u
				&& myUser.getUserID () != u.getUserID ());
	}

	/**
	 * Send a response to the other party in JSON form. In Smart Fox
	 * Server Pro compatibility mode, this goes through as a JSON
	 * Extension Response packet. In Cubist JSON form, the JSON object
	 * is returned “intact,” with the room number (if supplied as a
	 * positive number) added into it as the “r” key.
	 *
	 * @param result the JSON object to be returned to the other party
	 * @param room The room number from which the response is being
	 *            sent.
	 * @param remote Whether to send the message as a remote (deferred
	 *            future datagram) message
	 * @throws UserDeadException if the user has been disconnected
	 * @deprecated use {@link #sendResponse(AbstractDatagram)}
	 */
	@Deprecated
	public void sendResponse (final JSONObject result, final int room,
			final boolean remote) throws UserDeadException {
		final String msg;
		if (Double.POSITIVE_INFINITY == streamProtocolLanguage) {
			if (room > 0) {
				try {
					result.put ("r", room);
				} catch (final JSONException e) {
					AppiusClaudiusCaecus.fatalBug (e);
				}
			}
			msg = result.toString ();
		} else {
			msg = "{\"t\":\"xt\",\"b\":{\"r\":" + room + ",\"o\":"
					+ result.toString () + "}}";
		}
		if (remote) {
			sendRawMessageLater (new ADPString (msg, null));
		} else {
			sendRawMessageNow (new ADPString (msg, null));
		}
	}

	/**
	 * Send a response as a future (deferred remote) datagram
	 *
	 * @see #sendResponse(JSONObject, int, boolean)
	 * @param result the JSON result object to be sent (“extension
	 *            response”)
	 * @param room The room in which the event occurred.
	 * @throws UserDeadException if the user has disconnected
	 * @deprecated use {@link #sendResponse(AbstractDatagram)}
	 */
	@Deprecated
	public void sendResponse (final JSONObject result,
			final Integer room) throws UserDeadException {
		sendResponse (result, room.intValue (), true);
	}

	/**
	 * @param result the JSON result object to be sent (“extension
	 *            response”)
	 * @param room The room in which the event occurred.
	 * @param u The user to whom the message is being sent
	 * @throws UserDeadException if the user has disconnected
	 * @deprecated perhaps use
	 *             {@link #sendResponse(JSONObject,int,boolean)}
	 *             directly with the room ID and the “remote” boolean
	 *             flag probably as “true”
	 */
	@Deprecated
	public void sendResponse (final JSONObject result,
			final Integer room, final AbstractUser u)
			throws UserDeadException {
		sendResponse (
				result,
				null == room ? -1 : room.intValue (),
				null != myUser && null != u
						&& myUser.getUserID () != u.getUserID ());
	}

	/**
	 * Send a response as a future datagram, presumably to a remote
	 * user's thread
	 *
	 * @param result the JSON object to send to the client
	 * @param room the room number in which the event occurred
	 * @param u ignored…
	 * @throws UserDeadException if the user has already disconnected
	 * @deprecated use {@link #sendResponse(JSONObject, Integer)}
	 */
	@Deprecated
	public void sendResponseRemote (final JSONObject result,
			final Integer room, final AbstractUser u)
			throws UserDeadException {
		sendResponse (result, room.intValue (), true);
	}

	/**
	 * <p>
	 * Send notification that an user has joined a room.
	 * </p>
	 *
	 * @param room the room that has been joined by an user
	 * @param user the user joining the room
	 * @throws UserDeadException if the user has been disconnected
	 * @deprecated use {@link ADPRoomJoin} with
	 *             {@link #sendResponse(AbstractDatagram)}
	 */
	@Deprecated
	public void sendRoomEnteredByUser (final Room room,
			final AbstractUser user) throws UserDeadException {
		if (room.isLimbo ()) {
			return;
		}
		tattle ("roomJoin\t" + room.getMoniker ());
		sendResponse (new ADPRoomJoin (room, user));
	}

	/**
	 * Send the user a room list for their current zone
	 *
	 * @throws UserDeadException if the user has been disconnected
	 */
	public void sendRoomList () throws UserDeadException {
		sendRoomList (myUser.getZone (), true);
	}

	/**
	 * Send the user a room list for an arbitrary zone
	 *
	 * @param forZone The zone for which the user will receive a room
	 *            list
	 * @param remote If true, writing to a remote user
	 * @throws UserDeadException if the user has been disconnected
	 */
	public void sendRoomList (final Zone forZone, final boolean remote)
			throws UserDeadException {
		if (Double.POSITIVE_INFINITY == streamProtocolLanguage) {
			final JSONObject result = new JSONObject ();
			final JSONObject rooms = new JSONObject ();
			try {
				result.put ("from", "roomList");
				for (final Room room : forZone.getRoomList ()) {
					rooms.put (String.valueOf (room.getID ()),
							room.toJSON ());
				}
				result.put ("rooms", rooms);
			} catch (final JSONException e) {
				AppiusClaudiusCaecus.fatalBug (e);
			}
			if (remote) {
				sendRawMessageLater (new ADPString (result.toString (),
						null));
			} else {
				sendRawMessageNow (new ADPString (result.toString (),
						null));
			}
			return;
		}

		final String zoneXML = forZone.getRoomListSFSXML ();
		if (remote) {
			sendRawMessageLater (new ADPString (zoneXML, null));
		} else {
			sendRawMessageNow (new ADPString (zoneXML, null));
		}
	}

	/**
	 * Send a notification that an user has departed from a room
	 *
	 * @param room The room from which someone has departed
	 * @param user The user who has departed from the room
	 * @throws UserDeadException if the user has been disconnected
	 */
	public void sendRoomPartedBy (final Room room,
			final AbstractUser user) throws UserDeadException {
		if (room.isLimbo ()) {
			return;
		}
		if (Double.POSITIVE_INFINITY == streamProtocolLanguage) {
			final JSONObject response = new JSONObject ();
			try {
				response.put ("from", "part");
				response.put ("status", true);
				response.put ("u", user.getUserID ());
				response.put ("userName", user.getAvatarLabel ());
				response.put ("fromRoom", room.getMoniker ());
			} catch (final JSONException e) {
				AppiusClaudiusCaecus.fatalBug (e);
			}
			sendResponse (response, Integer.valueOf (room.getID ()));
			return;
		}
		final StringBuilder partMessage = new StringBuilder ();
		partMessage.append ("<msg t='sys'><body action='userGone' r='");
		partMessage.append (room.getID ());
		partMessage.append ("'><user id='");
		partMessage.append (user.getUserID ());
		partMessage.append ("' /></body></msg>");
		sendRawMessageLater (new ADPString (partMessage.toString (),
				null));
	}

	/**
	 * Send the user count for the given room
	 *
	 * @param room The room whose user count is being updated
	 * @throws UserDeadException if the user has been disconnected
	 */
	public void sendRoomUserCount (final Room room)
			throws UserDeadException {
		if (Double.POSITIVE_INFINITY == streamProtocolLanguage) {
			final JSONObject response = new JSONObject ();
			try {
				response.put ("from", "userCount");
				response.put ("count", room.getUserCount ());
			} catch (final JSONException e) {
				AppiusClaudiusCaecus.fatalBug (e);
			}
			sendResponse (response, Integer.valueOf (room.getID ()));
			return;
		}
		sendRawMessageLater (new ADPString (
				"<msg t='sys'><body action='uCount' r='"
						+ room.getID () + "' u='"
						+ room.getUserCount () + "'></body></msg>",
				null));
	}
	
	/**
	 * @param roomNum The room number for which the variable is being
	 *            set
	 * @param varName The name of the room variable
	 * @param varValue The new value of the variable
	 * @throws UserDeadException if the user has been disconnected
	 * @deprecated Use ADPRoomVar datagrams instead
	 */
	@Deprecated
	public void sendRoomVar (final int roomNum, final String varName,
			final String varValue) throws UserDeadException {
		if (Double.POSITIVE_INFINITY == streamProtocolLanguage) {
			final JSONObject response = new JSONObject ();
			try {
				response.put ("from", "rv");
				final JSONObject var = new JSONObject ();
				var.put (varName, varValue);
				response.put ("var", var);
			} catch (final JSONException e) {
				AppiusClaudiusCaecus.fatalBug (e);
			}
			sendResponse (response, Integer.valueOf (roomNum));
			return;
		}
		sendResponse (new ADPString (
				"<msg t='sys'><body action='rVarsUpdate' r='" + roomNum
						+ "'><vars><var n='" + varName
						+ "' t='s'><![CDATA[" + varValue
						+ "]]></var></vars></body></msg>", null));
	}

	/**
	 * Send a JSON success packet back to the client
	 *
	 * @param source the method returning success
	 * @param resultIn additional information to be returned to the
	 *            client
	 * @param u the user responsible for the successful reply (ignored)
	 * @param room the room in which the user is standing (ignored)
	 * @throws JSONException if the success reply can't be encoded in
	 *             JSON form
	 */
	public void sendSuccessReply (final String source,
			final JSONObject resultIn, final AbstractUser u,
			final int room) throws JSONException {
		JSONObject result = resultIn;
		if (null == result) {
			result = new JSONObject ();
		}
		result.put ("status", true);
		result.put ("from", source);

		try {
			sendResponse (result);
		} catch (final UserDeadException e) {
			// Don't ask, don't care
		}
	}

	/**
	 * Send the event to the user indicated that this user has joined a
	 * room successfully. This also engages Parallel mode, since the
	 * login process in both Smart Fox Server clients and Persephone II
	 * is known to have bad race conditions and not deal well with
	 * parallel mode.
	 *
	 * @param room the room joined
	 * @throws UserDeadException if the user has disconnected
	 */
	public void sendUserJoin (final Room room) throws UserDeadException {
		setParallelMode (true); // XXX Hacky
		if (Double.POSITIVE_INFINITY == streamProtocolLanguage) {
			sendRawMessageLater (new ADPString (room.getRoomJoinJSON (
					myUser).toString (), null));
		} else {
			sendRawMessageLater (new ADPString (
					room.getRoomJoinSFSXML (myUser), null));
		}
	}

	/**
	 * Send notification that a user has departed from the room
	 *
	 * @param user The user departing from the room
	 * @param room The room from which the user has departed
	 * @throws UserDeadException if the user has been disconnected
	 * @deprecated use {@link #sendRoomPartedBy(Room, AbstractUser)}
	 */
	@Deprecated
	public void sendUserPart (final AbstractUser user, final Room room)
			throws UserDeadException {
		sendRoomPartedBy (room, user);
	}

	/**
	 * Send an update to an user variable
	 *
	 * @param user The user whose variable has been updated
	 * @param varName The name of the user variable
	 * @param varValue The new value of the user variable
	 * @throws UserDeadException if the user has been disconnected
	 */
	public void sendUserVariable (final AbstractUser user,
			final String varName, final String varValue)
			throws UserDeadException {
		if (Double.POSITIVE_INFINITY == streamProtocolLanguage) {
			final JSONObject result = new JSONObject ();
			try {
				result.put ("from", "uv");
				result.put ("v", varName);
				result.put ("e", varValue);
				result.put ("u", user.getUserID ());
			} catch (final JSONException e) {
				AppiusClaudiusCaecus.fatalBug (e);
			}
			sendRawMessageLater (new ADPString (result.toString (),
					user));
			return;
		}

		sendRawMessageLater (new ADPString (
				"<msg t='sys'><body action='uVarsUpdate' r='"
						+ user.getRoomNumber () + "'><user id='"
						+ user.getUserID () + "' /><vars><var n='"
						+ varName + "' t='s'><![CDATA[" + varValue
						+ "]]></var></vars></body></msg>", user));
	}

	/**
	 * @param b true, if the thread is in a busy state and should not be
	 *            interrupted for idle timeout
	 */
	@Override
	public void setBusyState (final boolean b) {
		busyState = b;
	}

	/**
	 * @param new_language_dialect the language and dialect to be used
	 *            for internationalisation and localisation
	 */
	public void setLanguage (final String new_language_dialect) {
		language_dialect = new_language_dialect;
	}

	/**
	 * @param thatTime the time of last input from the client
	 */
	@Override
	public void setLastInputTime (final long thatTime) {
		lastInputTime = thatTime;
	}

	/**
	 * @param amILoggedInNow True, if the thread represents a logged-in
	 *            user
	 */
	public void setLoggedIn (final boolean amILoggedInNow) {
		loggedIn = amILoggedInNow;
	}

	/**
	 * @param newParallelMode the parallelMode to set
	 */
	public void setParallelMode (final boolean newParallelMode) {
		parallelMode = newParallelMode;
	}

	/**
	 * @param smartFoxServerCommProtocolVersion The protocol version to
	 *            be used. This version of the server supports Smart Fox
	 *            Server Pro version 1.58, or Cubist JSON form using the
	 *            value Double.POSITIVE_INFINITY
	 */
	public void setSFSVersion (
			final float smartFoxServerCommProtocolVersion) {
		streamProtocolLanguage = smartFoxServerCommProtocolVersion;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param sock WRITEME
	 * @throws SocketException WRITEME
	 */
	private void setSocketOptionsFromConfig (final Socket sock)
			throws SocketException {
		sock.setSoTimeout (AppiusConfig.getIntOrDefault (
				"org.starhope.appius.tcp.SO_TIMEOUT", 200));
		try {
			sock.setKeepAlive (AppiusConfig
					.getConfigBool ("org.starhope.appius.tcp.keepAlive"));
		} catch (final NotFoundException e1) {
			sock.setKeepAlive (true);
		}
		sock.setOOBInline (AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.tcp.oobInline"));
		sock.setPerformancePreferences (AppiusConfig.getIntOrDefault (
				"org.starhope.appius.tcp.perfTime", 1), AppiusConfig
				.getIntOrDefault (
						"org.starhope.appius.tcp.perfLatency", 10),
				AppiusConfig.getIntOrDefault (
						"org.starhope.appius.tcp.perfBandwidth", 2));
		// sock.setSoLinger (true, 100);
		try {
			sock.setTcpNoDelay (AppiusConfig
					.getConfigBool ("org.starhope.appius.tcp.noDelay"));
		} catch (final NotFoundException e1) {
			sock.setTcpNoDelay (true);
		}
	}

	/**
	 * Set up this thread to execute
	 *
	 * @throws IOException if the I/O streams can't be initialised
	 * @throws UserDeadException if the user disconnects before setup is
	 *             complete
	 */
	protected synchronized void setup () throws IOException,
			UserDeadException {
		final Socket sock = getStreamsReady ();

		setSocketOptionsFromConfig (sock);

		primeConnection ();
	}

	/**
	 * @param seed a string to be hashed
	 * @return the seed's SHA1 hash in hex
	 */
	protected String sha1hexify (final String seed) {
		byte [] sha1digest;
		try {
			final MessageDigest stomach = MessageDigest
					.getInstance ("SHA1");
			stomach.reset ();
			try {
				stomach.update (seed.getBytes ("US-ASCII"));
			} catch (final UnsupportedEncodingException e) {
				AppiusClaudiusCaecus.blather ("can't go 16 bit");
			}
			sha1digest = stomach.digest ();
		} catch (final NoSuchAlgorithmException e) {
			throw AppiusClaudiusCaecus.fatalBug (new Exception (
					"Can't understand how to do SHA1 digests"));
		} catch (final NumberFormatException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (new Exception (
							"Can't do some magic to make the SHA1 digest for login"));
		}
		final StringBuilder sha1hex = new StringBuilder (
				sha1digest.length * 2);
		for (final byte element : sha1digest) {
			sha1hex.append (Integer.toString (
					(element & 0xff) + 0x100, 16).substring (1));
		}
		return sha1hex.toString ();
	}

	/**
	 * @see org.starhope.appius.net.NetIOThread#tattlePrefix()
	 */
	@Override
	protected String tattlePrefix () {
		final StringBuilder prefix = new StringBuilder ();
		if (null == myUser) {
			prefix.append ("prelogin " + preloginCountdown);
			prefix.append ('\t');
		} else {
			prefix.append ("user #" + myUser.getUserID () + " “"
					+ myUser.getUserName () + "”");
			prefix.append (" S#" + myUser.getMySerial ());
			prefix.append ('\t');
			if (null != myUser.getRoom ()) {
				prefix.append ("room “"
						+ myUser.getRoom ().getMoniker () + "” in ");
			}
			if (null != myUser.getZone ()) {
				prefix.append ("zone “" + myUser.getZone ().getName ()
						+ "”");
			}
		}
		return prefix.toString ();
	}

	/**
	 * Propagate a metronome tick
	 *
	 * @param t The value of System.currentTimeMillis at the start of
	 *            this tick
	 * @param dT The delta-T since the prior tick
	 * @throws UserDeadException if the user has been disconnected
	 */
	@Override
	public void tick (final long t, final long dT)
			throws UserDeadException {
		final long tIdle = t - lastInputTime;
		if ( !busyState) {
			if (tick_checkIdleKick (tIdle)) {
				return;
			}
			if (tick_checkIdleWarnTime (tIdle)) {
				return;
			}
		}
		if (t - tLastNudge > AppiusConfig.getNudgeTime ()) {
			doNudge (t);
		}
	}

	/**
	 * Check whether the user has been idle for too long, and kick them
	 * offline if so
	 *
	 * @param tIdle Time that the user has been idle (milliseconds)
	 * @return true, if the user was kicked off
	 * @throws UserDeadException if the user is disconnected
	 */
	protected boolean tick_checkIdleKick (final long tIdle)
			throws UserDeadException {
		if (tIdle > AppiusConfig.getIdleKickTime ()) {
			sendAdminDisconnect (LibMisc.getText ("idleKick"), "Idle",
					"System", "idleKick");
			return true;
		}
		return false;
	}

	/**
	 * Check how long the user has been idle, and send a warning if the
	 * time idle has exceeded a limit
	 *
	 * @param tIdle The time that this connection or user has been idle
	 * @return true, if the user was warned; false, if not
	 * @throws UserDeadException if the user went away
	 */
	protected boolean tick_checkIdleWarnTime (final long tIdle)
			throws UserDeadException {
		if (tIdle > AppiusConfig.getIdleWarnTime ()
				&& ! (idleWarned == lastInputTime)) {
			sendAdminMessage (LibMisc.getText ("idleWarn"), false);
			idleWarned = lastInputTime;
			return true;
		}
		return false;
	}

	/**
	 * engage Infinity-mode protocol
	 */
	@Override
	protected void toInfinityAndBeyond () {
		setSFSVersion (Float.POSITIVE_INFINITY);
	}

	/**
	 * This returns a plethora of debugging-useful information about
	 * this particular server thread.
	 *
	 * @see java.lang.Thread#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder res = new StringBuilder (super.toString ());
		res.append ("\nAppius Claudius Caecus:");
		if (null != myUser) {
			res.append ("\n\tUser:\t");
			res.append (myUser.getUserName ());
			res.append (" #");
			res.append (myUser.getUserID ());
		}
		if (loggedIn) {
			res.append ("\n\t\tLogged in");
		} else {
			res.append ("\n\tPrelogin countdown:\t");
			res.append (preloginCountdown);
		}
		if (null != myUser && null != myUser.getZone ()) {
			res.append ("\n\tZone:\t");
			res.append (myUser.getZone ().getName ());
		}
		res.append ("\n\tProtocol language:\t");
		res.append (streamProtocolLanguage);
		if (streamProtocolLanguage == Float.POSITIVE_INFINITY) {
			res.append ("  א" + infinityAlef);
		}
		res.append ("\n\tDebug mode:\t");
		res.append (debug);
		res.append ("\n\tFuture datagrams enqueued:\t");
		res.append (futureDatagrams.size ());
		res.append ("\n\tLast input:\t");
		res.append (LibMisc.formatPastDate (new Date (lastInputTime)));
		res.append ("\n\tLast nudge:\t");
		res.append (LibMisc.formatPastDate (new Date (tLastNudge)));
		res.append ("\n\tState code:\t");
		res.append (state);
		res.append ('\n');
		return res.toString ();
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.lang.Thread.UncaughtExceptionHandler#uncaughtException(java.lang.Thread,
	 *      java.lang.Throwable)
	 */
	@Override
	public void uncaughtException (final Thread t, final Throwable e) {
		if (e instanceof ThreadDeath) {
			return;
		}
		AppiusClaudiusCaecus.reportBug (
				"Uncaught Exception in " + t.getName (), e);
	}

	/**
	 * Create a message string informing the user that an error has
	 * occurred, and instructing them to contact Customer Service.
	 *
	 * @param string The debugging code to append to the message
	 * @return A string to return to the user
	 */
	protected String userDebug (final String string) {
		final StringBuilder debugString = new StringBuilder (
				LibMisc.getTextOrDefault (
						"userDebug",
						"\nWe're sorry that you have encountered an unexpected error. So that we can help you better, please contact Customer Service and give them the following code:\n"));
		debugString.append (string);
		debugString.append (' ');
		debugString.append (AppiusClaudiusCaecus.getRev ());
		debugString.append ('\n');
		return debugString.toString ();
	}
}
