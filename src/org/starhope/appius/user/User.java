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
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author twheys@gmail.com Timothy W. Heys
 */

package org.starhope.appius.user;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Locale;
import java.util.Map.Entry;
import java.util.Vector;
import java.util.concurrent.ConcurrentSkipListSet;
import java.util.concurrent.Semaphore;
import java.util.concurrent.atomic.AtomicInteger;

import javax.mail.MessagingException;
import javax.naming.NamingException;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.except.ParameterException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Channel;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.game.Commands;
import org.starhope.appius.game.GameRoom;
import org.starhope.appius.game.GameStateFlag;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.RoomChannel;
import org.starhope.appius.game.RoomListener;
import org.starhope.appius.game.Zone;
import org.starhope.appius.game.inventory.Inventory;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.game.inventory.InventoryItemType;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.mb.Enrolment;
import org.starhope.appius.mb.UserEnrolment;
import org.starhope.appius.messaging.Mail;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.net.datagram.ADPChannelJoin;
import org.starhope.appius.net.datagram.ADPChannelPart;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.physica.Kalendor;
import org.starhope.appius.types.AgeBracket;
import org.starhope.appius.types.Colour;
import org.starhope.appius.types.Gender;
import org.starhope.appius.types.UserActiveState;
import org.starhope.appius.user.events.Action;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.Activity;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.HasSubversionRevision;
import org.starhope.util.LibMisc;

/**
 * This class encapsulates all of the user/player information for the
 * game. Most of the neat stuff is in UserRecord now, though.
 * 
 * @see UserRecord
 * @see AbstractUser
 * @author twheys@gmail.com Timothy W. Heys
 * @author Bruce-Robert Pocock brpocock@star-hope.org
 * @author twheys@gmail.com Timothy W. Heys
 * @author Timothy W. Heys twheys@gmail.com
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public abstract class User extends GeneralUser implements
		AbstractPerson, HasSubversionRevision {
	
	/**
	 * Considered the first date before which this is your first login
	 */
	private final static Timestamp firstLoginDate = new Timestamp (
			1294675200000L);
	
	/**
	 * Maximum length of a login/username (in characters)
	 */
	public final static int MAX_LOGIN_LENGTH = 30;
	
	/**
	 * Maximum length of a password (in characters)
	 */
	public final static int MAX_PW_LENGTH = 30;
	
	/**
	 * Minimum length of a login/username (in characters)
	 */
	public final static int MIN_LOGIN_LENGTH = 3;
	
	/**
	 * Minimum length of a password (in characters)
	 */
	public final static int MIN_PW_LENGTH = 3;
	
	/**
	 * the instantiation serial number for the next user instantiated
	 */
	private static AtomicInteger serial = new AtomicInteger ( -1);
	
	/**
	 * Serial Version Unique Identifier for Java Serialization.
	 * serialVersionUID (long)
	 */
	private static final long serialVersionUID = 4146069318927248889L;
	
	/**
	 * The Smart Fox Server that we might be able to talk to.
	 */
	// private static SmartFoxServer sfs = null;
	/**
	 * Staff level for users able to view account (subscription) data
	 */
	public static final int STAFF_LEVEL_ACCOUNT_SERVICE = 3;
	
	/**
	 * Staff level for users able to edit the game world
	 */
	public static final int STAFF_LEVEL_DESIGNER = 4;
	
	/**
	 * Staff level for software developers
	 */
	public final static int STAFF_LEVEL_DEVELOPER = 8;
	
	/**
	 * Staff level for moderators (including life guards and tour
	 * guides)
	 */
	public static final int STAFF_LEVEL_MODERATOR = 2;
	
	/**
	 * Staff level for public users (free or paid users)
	 */
	public static final int STAFF_LEVEL_PUBLIC = 0;
	
	/**
	 * Staff level for all members of the staff (Sidereal employees)
	 */
	public static final int STAFF_LEVEL_STAFF_MEMBER = 1;
	
	/**
	 * <p>
	 * Make the assertion that the user name supplied is available to
	 * be requested or assigned to this user.
	 * </p>
	 * <p>
	 * Note that having another user request the name, which has not
	 * been either permitted or denied, will still throw an
	 * AlreadyUsedException.
	 * </p>
	 * <p>
	 * This routine returns void, because it throws exceptions if the
	 * name is forbidden or already used. For a boolean version, see
	 * {@link Nomenclator#isLoginAvailable(String)}
	 * 
	 * @param userNameRequested The name which is being requested
	 * @throws AlreadyUsedException if the user name has been requested
	 *              or accepted already
	 * @throws ForbiddenUserException if the user name is forbidden
	 *              from use (obscene, gives away personal information,
	 *              or so forth). See
	 *              {@link Nomenclator#isLoginForbidden(String)}
	 * @deprecated Use {@link Nomenclator#assertLoginAvailable(String)}
	 *             instead
	 */
	@Deprecated
	public static void assertUserNameAvailable (
			final String userNameRequested)
			throws AlreadyUsedException, ForbiddenUserException {
		Nomenclator.assertLoginAvailable (userNameRequested);
	}
	
	/**
	 * Check whether the SmartFox Server is available and visible to us
	 * (sharing this VM). If so, the static member variable "sfs" will
	 * be set to it. Since this is not longer supported, the results
	 * will always be false and this method is deprecated.
	 * 
	 * @return true, if we have access to Smart Fox Server.
	 */
	@Deprecated
	public static boolean canSeeSmartFoxServer () {
		return false;
	}
	
	/**
	 * This is the callback that is called whenever the AppiusConfig
	 * reloads the configuration or has a runtime configuration value
	 * changed.
	 */
	public static void configUpdated () {
		// No op ...?
	}
	
	/**
	 * Create a new user account
	 * 
	 * @param date User's date of birth
	 * @param string Character class or type designator
	 * @param nick User's requested nickname
	 * @return the new user object
	 * @throws AlreadyUsedException if the nickname is not available
	 * @throws ForbiddenUserException if the user account is not
	 *              permitted to be created, e.g. for having an obscene
	 *              user ID
	 * @deprecated Use {@link Nomenclator#create(Date,String,String)}
	 *             instead
	 */
	@Deprecated
	public static AbstractUser create (final Date date,
			final String string, final String nick)
			throws AlreadyUsedException, ForbiddenUserException {
		return Nomenclator.create (date, string, nick);
	}
	
	/**
	 * Pick up a user from a JSON object containing either the ID or
	 * login (user name) string
	 * 
	 * @param object A JSON object with either an { id: userID } or {
	 *             login: userName }
	 * @return the User thusly fetched
	 * @deprecated Use {@link Nomenclator#get(JSONObject)} instead
	 */
	@Deprecated
	public static AbstractUser get (final JSONObject object) {
		return Nomenclator.get (object);
	}
	
	/**
	 * Instantiate a user object from an existing user account ID
	 * 
	 * @param id The user ID to instantiate
	 * @return the instantiated user record, or null if the user ID
	 *         doesn't represent a user record (too high, or the record
	 *         was destroyed somehow) — not returned for deleted or
	 *         banned accounts, though.
	 * @deprecated Use {@link Nomenclator#getUserByID(int)} instead
	 */
	@Deprecated
	public static AbstractUser getByID (final int id) {
		return Nomenclator.getUserByID (id);
	}
	
	/**
	 * @param login the user login name
	 * @return the User record, or null if no user <em>currently</em>
	 *         has that login name
	 * @deprecated Use {@link Nomenclator#getUserByLogin(String)}
	 *             instead
	 */
	@Deprecated
	public static AbstractUser getByLogin (final String login) {
		return Nomenclator.getUserByLogin (login);
	}
	
	/**
	 * Returns an array of all users associated with a given eMail
	 * address. This includes all users who report it as being their
	 * own eMail address, as well as the children of any parents using
	 * it.
	 * 
	 * @param mail The eMail address for which we are searching
	 * @return An array of any/all such users. If the array consists
	 *         only of one element, which is the value "null," then
	 *         there are too many results and special effort is
	 *         required to recall the list.
	 * @deprecated Use {@link Nomenclator#getUsersByMail(String)}
	 *             instead
	 */
	@Deprecated
	public static AbstractUser [] getByMail (final String mail) {
		return Nomenclator.getUsersByMail (mail);
	}
	
	/**
	 * Get the user who has requested a certain name, if any.
	 * 
	 * @param userNameRequested the user name for which we're searching
	 * @return null, if no user has requested the name; otherwise, the
	 *         user who requested it. (Note that the name might have
	 *         been approved, or might not have been.)
	 * @deprecated Use
	 *             {@link Nomenclator#getUserByRequestedName(String)}
	 *             instead
	 */
	@Deprecated
	public static AbstractUser getByRequestedName (
			final String userNameRequested) {
		return Nomenclator.getUserByRequestedName (userNameRequested);
	}
	
	/**
	 * Find the user name for a user who is currently signed on.
	 * 
	 * @param name User name to look up
	 * @return The user ID number, if the user is online; else -1
	 * @deprecated Use {@link Nomenclator#getIDForLiveUserName(String)}
	 *             instead
	 */
	@Deprecated
	public static int getIDForLiveUserName (final String name) {
		return Nomenclator.getIDForLiveUserName (name);
	}
	
	/**
	 * Fetch the user ID number for a user name
	 * 
	 * @param name The user name (login)
	 * @return the user ID
	 * @deprecated Use {@link Nomenclator#getUserIDForLogin(String)}
	 *             instead
	 */
	@Deprecated
	public static int getIDForLogin (final String name) {
		return Nomenclator.getUserIDForLogin (name);
	}
	
	/**
	 * Fetch the user ID number for a user name
	 * 
	 * @param name The user name (login)
	 * @return the user ID
	 * @deprecated {@link Nomenclator#getUserIDForLogin(String)}
	 */
	@Deprecated
	public static int getIDForUserName (final String name) {
		return Nomenclator.getUserIDForLogin (name);
	}
	
	/**
	 * @param login user login
	 * @return an online user, if one is found, else, null.≥
	 * @deprecated Use {@link Nomenclator#getOnlineUserByLogin(String)}
	 *             instead
	 */
	@Deprecated
	public static AbstractUser getOnlineUserByLogin (final String login) {
		return Nomenclator.getOnlineUserByLogin (login);
	}
	
	/**
	 * Based upon configuration settings, determine the outline colour
	 * for a given base colour
	 * 
	 * @param baseColour the base colour (will not be altered)
	 * @return the outline colour
	 * @throws DataException
	 */
	public static Colour getOutlineColourForBaseColour (
			final Colour baseColour) throws DataException {
		
		if ( !AppiusConfig
				.getConfigBoolOrTrue ("org.starhope.appius.user.outlineColour.baseOnBase")) {
			return Colour.BLACK;
		}
		
		final Colour outlineColour = new Colour (baseColour);
		if (Math.max (
				Math.max (outlineColour.getBlue (),
						outlineColour.getGreen ()),
				outlineColour.getRed ()) < AppiusConfig
				.getIntOrDefault (
						"org.starhope.appius.user.outlineColour.darkPoint",
						0x80)) {
			final int brightener = AppiusConfig
					.getIntOrDefault (
							"org.starhope.appius.user.outlineColour.darkBrightener",
							0x40);
			return outlineColour.add (brightener, brightener,
					brightener);
		}
		final double darkener = Double
				.parseDouble (AppiusConfig
						.getConfigOrDefault (
								"org.starhope.appius.user.outlineColour.darkener",
								"0.5"));
		return outlineColour.multiply (darkener, darkener, darkener);
	}
	
	/**
	 * @return the Subversion revision number of this file
	 */
	public static String getRev () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * Get the System user object (the user which represents the system
	 * program itself). In particular, the System object's eMail
	 * address and givenName are used to address mail to users.
	 * 
	 * @return the System user object
	 * @deprecated Use {@link Nomenclator#getSystemUser()} instead
	 */
	@Deprecated
	public static AbstractUser getSystemUser () {
		return Nomenclator.getSystemUser ();
	}
	
	/**
	 * @param id The user ID value
	 * @return The user's login name
	 * @deprecated Use {@link Nomenclator#getLoginForID(int)} instead
	 */
	@Deprecated
	public static String getUserNameForID (final int id) {
		return Nomenclator.getLoginForID (id);
	}
	
	/**
	 * <p>
	 * Get up to 20 users who are awaiting approval of their names.
	 * Will not return more than 20 users in a set, but could return an
	 * empty set.
	 * </p>
	 * <p>
	 * XXX contains SQL
	 * </p>
	 * 
	 * @return A set of users who are awaiting name approval
	 */
	public static Collection <AbstractUser> getUsersAwaitingNameApproval () {
		final Vector <AbstractUser> them = new Vector <AbstractUser> ();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT ID FROM users LIMIT 20");
			if (st.execute ()) {
				rs = st.getResultSet ();
				while (rs.next ()) {
					them.add (Nomenclator.getUserByID (rs
							.getInt ("ID")));
				}
			}
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return them;
	}
	
	/**
	 * Z$Z
	 * 
	 * @return Z$Z
	 */
	public static String [] getZ$Z () {
		return new String [] {};
	}
	
	/**
	 * Perform basic self-tests upon the User database to identify
	 * whether things are good enough to proceed with booting.
	 * 
	 * @return true if things are good.
	 */
	public static boolean isItGood () {
		String secret;
		String godLogin;
		long godSerial;
		{
			final User god = (User) Nomenclator.getUserByID (1);
			godSerial = god.getSerial ();
			godLogin = god.getLogin ();
			final User lah = (User) Nomenclator.getUserByID (1);
			if (godSerial != lah.getSerial ()) {
				throw BugReporter
						.getReporter ("srv")
						.fatalBug (
								"User cache corruption or failure in getByID.");
			}
			secret = god.getPassword ();
			lah.setPassword ("xyzzy" + secret);
			
			if ( !god.checkPassword ("xyzzy" + secret)) {
				BugReporter.getReporter ("srv").reportBug (
						"Password sync test failed for Arabs");
			}
		}
		
		final User el = (User) Nomenclator.getUserByLogin (godLogin);
		if (godSerial != el.getSerial ()) {
			throw BugReporter
					.getReporter ("srv")
					.fatalBug (
							"User cache corruption or failure in getByLogin");
		}
		if ( !el.checkPassword ("xyzzy" + secret)) {
			BugReporter.getReporter ("srv").reportBug (
					"Password sync test failed for Hebrews");
		}
		el.setPassword (secret);
		return true;
	}
	
	/**
	 * Determine whether the given name is potentially available for
	 * use. Returns false if the name has already been forbidden (by
	 * virtue of matching a negative filter rule, or having been
	 * previously denied to another user), or if the name is currently
	 * either in use or requested by another user.
	 * 
	 * @param name The user name being checked
	 * @return true, if the name can potentially be tried.
	 * @deprecated Use {@link Nomenclator#isLoginAvailable(String)}
	 *             instead
	 */
	@Deprecated
	public static boolean isNameAvailable (final String name) {
		return Nomenclator.isLoginAvailable (name);
	}
	
	/**
	 * Determine whether a name is forbidden
	 * <p>
	 * ... A user name is “forbidden” if it matches a negative filter
	 * (if it contains forbidden word(s) or phrase(s)), or if it has
	 * previously been banned for some reason
	 * </p>
	 * 
	 * @param userNameRequested The name to be checked
	 * @return True, if the requested name is forbidden
	 * @deprecated Use {@link Nomenclator#isLoginForbidden(String)}
	 *             instead
	 */
	@Deprecated
	public static boolean isNameForbidden (
			final String userNameRequested) {
		
		return Nomenclator.isLoginForbidden (userNameRequested);
	}
	
	/**
	 * Determines whether the name provided contains allowed characters
	 * for an user name.
	 * 
	 * @param userName the user name to be checked
	 * @return true, if the name consists of valid characters
	 */
	public static boolean isNameValid (final String userName) {
		final char first = userName.charAt (0);
		if ( ! ( ( (first >= 'a') && (first <= 'z')) || ( (first >= 'A') && (first <= 'Z')))) {
			return false;
		}
		
		int numbersInARow = 0;
		boolean wasPunctuation = false;
		
		for (final char ch : userName.toCharArray ()) {
			if ( ! ( ( (ch >= 'a') && (ch <= 'z'))
					|| ( (ch >= 'A') && (ch <= 'Z'))
					|| ( (ch >= '0') && (ch <= '9'))
					|| (ch == '.') || (ch == '-'))) {
				return false;
			}
			
			if ( (ch == '.') || (ch == '-')) {
				if (wasPunctuation) {
					return false;
				}
				wasPunctuation = true;
			} else {
				wasPunctuation = false;
			}
			
			if ( (ch >= '0') && (ch <= '9')) {
				++numbersInARow;
			} else {
				numbersInARow = 0;
			}
			if (numbersInARow > 3) {
				return false;
			}
		}
		
		return true;
	}
	
	/**
	 * List of channels this user is subscribed to
	 */
	private final ConcurrentSkipListSet <Channel> channels = new ConcurrentSkipListSet <Channel> ();
	
	/**
	 * Simple boolean flag to determine if this is the user's first
	 * time logging in
	 */
	private boolean firstLogin = false;
	
	/**
	 * gender of the user
	 */
	private Gender gender = Gender.GENDER_UNKNOWN;
	
	/**
	 * Hashcode for this user
	 */
	private transient int hashcode;
	
	/**
	 * the time at which the user last was logged on, or the current
	 * time (plus 5 seconds) if they're on now.
	 */
	private Timestamp lastActive;
	
	/**
	 * unique instance ID
	 */
	private transient final int mySerial;
	
	/**
	 * Are we being controlled by a pathing routine? This should be the
	 * timer event for the next path-finding {@link Kalendor}
	 * {@link Activity}.
	 */
	private final long pathController = -1;
	
	/**
	 * Semaphore to lock down positioning updates by physics and such
	 */
	public Semaphore positioning = new Semaphore (1);
	
	/**
	 * round-trip lag/latency to/from the client
	 */
	private long roundTripLag = 10;
	
	/**
	 * The server thread through which this user is connected.
	 */
	transient ServerThread serverThread;
	
	/**
	 * Create a new user account
	 * 
	 * @param birthDate1 The player's date of birth
	 * @param avatarTitle The name of the avatar (class) which the
	 *             player wants to use. This must be one of the fixed
	 *             string names of the Basic 8 Toots™
	 * @param userNameRequest The user name requested
	 * @param password the user's password
	 * @param passwordQuestion the password recovery question
	 * @param passwordAnswer the answer to the password recovery
	 *             question
	 * @throws ForbiddenUserException If the user is administratively
	 *              prohibited from registering, e.g. due to a bad user
	 *              name
	 * @throws AlreadyUsedException If the user name is not available
	 * @throws NumberFormatException If the date of birth is irrational
	 */
	protected User (final Date birthDate1, final String avatarTitle,
			final String userNameRequest,
			final String passwordAnswer,
			final String passwordQuestion, final String password)
			throws AlreadyUsedException, ForbiddenUserException,
			NumberFormatException {
		Nomenclator.assertLoginAvailable (userNameRequest);
		
		userRecord = new UserRecord (birthDate1, avatarTitle,
				userNameRequest, passwordAnswer, passwordQuestion,
				password);
		
		mySerial = User.serial.incrementAndGet ();
		AppiusClaudiusCaecus.blather ("Instantiated S#" + mySerial
				+ " as new user");
		
		AppiusClaudiusCaecus.blather ("#" + userRecord.getUserID (),
				"", "", "New user created, database ID =  "
						+ userRecord.getUserID (), true);
		
		if (AppiusConfig
				.getConfigBoolOrTrue ("org.starhope.appius.users.autoApproveNames")) {
			try {
				approveName (Nomenclator.getSystemUser ());
			} catch (final PrivilegeRequiredException e1) {
				AppiusClaudiusCaecus.fatalBug (e1);
			}
		}
		
		local_create ();
	}
	
	/**
	 * Instantiate a user object from an existing user account ID
	 * 
	 * @param id user ID value
	 * @throws NotFoundException if the user can't be found in the
	 *              database.
	 */
	public User (final int id) throws NotFoundException {
		this (Nomenclator.getDataRecord (UserRecord.class, id));
		AppiusClaudiusCaecus.blather ("Instantiated S#" + mySerial
				+ ", populated by ID");
	}
	
	/**
	 * Instantiate a user object from an existing user account ID
	 * 
	 * @param newUserLogin user login name
	 * @throws NotFoundException if the user can't be found in the
	 *              database.
	 */
	public User (final String newUserLogin) throws NotFoundException {
		this (Nomenclator.getDataRecord (UserRecord.class,
				newUserLogin));
		AppiusClaudiusCaecus.blather (newUserLogin, "", "",
				"Instantiated S#" + mySerial
						+ ", populated by login", false);
	}
	
	/**
	 * Instantiate the user who goes with a given record. Also sets the
	 * “notable” user variable, if applicable.
	 * 
	 * @param rec the user record
	 * @throws NotFoundException
	 */
	public User (final UserRecord rec) throws NotFoundException {
		super (rec);
		mySerial = User.serial.incrementAndGet ();
		AppiusClaudiusCaecus.blather (rec.getDebugName (), "", "",
				"Instantiated S#" + mySerial
						+ ", populating by DataRecord", false);
		userRecord = rec;
		if (userRecord.isNotable ()) {
			setVariable ("notable", "true");
		}
		Quaestor.getDefault ().action (new Action (this, "load"));
	}
	
	/**
	 * @see org.starhope.appius.user.GeneralUser#acceptDatagram(org.starhope.appius.net.datagram.AbstractDatagram)
	 */
	@Override
	public void acceptDatagram (final AbstractDatagram datagram) {
		final String channelName = datagram.getChannel () == null ? null
				: datagram.getChannel ().getMoniker ();
		
		if (null != serverThread) {
			boolean echo = datagram.echoClient ();
			echo &= ! ( (datagram instanceof ADPChannelJoin) && (""
					.equals (channelName) || (datagram
					.getSource () != this)));
			echo &= ! ( (datagram instanceof ADPChannelPart) && (""
					.equals (channelName) || (datagram
					.getSource () != this)));
			
			if (echo) {
				sendResponse (datagram);
			}
			
			// Live buddy list updates
			if ( ( (datagram instanceof ADPChannelJoin) || (datagram instanceof ADPChannelPart))
					&& "".equals (channelName)) {
				final ChannelListener listener = datagram
						.getSource ();
				if (listener instanceof AbstractUser) {
					final AbstractUser user = (AbstractUser) listener;
					if ( (this != user) && isBuddy (user)) {
						final LinkedList <String> list = new LinkedList <String> ();
						list.add (user.getAvatarLabel ());
						sendBuddyList ("$buddy", list);
					}
				}
			}
		}
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#acceptErrorReply(java.lang.String,
	 *      java.lang.String, org.json.JSONObject,
	 *      org.starhope.appius.game.Room)
	 */
	@Override
	@Deprecated
	public void acceptErrorReply (final String command,
			final String error, final JSONObject result,
			final Room room) {
		if (null != serverThread) {
			try {
				serverThread.sendErrorReply (command, error,
						result, this,
						null == room ? -1 : room.getID ());
			} catch (final JSONException e) {
				BugReporter.getReporter ("srv").reportBug (e);
			} catch (final UserDeadException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a UserDeadException in acceptErrorReply",
								e);
			}
		}
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.RoomListener#acceptGameAction(AbstractUser,
	 *      JSONObject)
	 */
	@Override
	public void acceptGameAction (final AbstractUser sender,
			final JSONObject action) {
		try {
			serverThread.sendGameActionMessage (sender, action);
		} catch (final UserDeadException e) {
			// nifty, they've died
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptGameStateChange(org.starhope.appius.game.GameEvent,
	 *      org.starhope.appius.game.GameStateFlag)
	 */
	@Override
	public void acceptGameStateChange (final GameRoom gameCode,
			final GameStateFlag gameState) {
		// No op
	}
	
	/**
	 * Accept an administrative/moderator message with the full range
	 * of options. If the user is currently online, forward this
	 * message to them.
	 * 
	 * @param title The title of the message
	 * @param caption The caption; usually ADMIN for administrative
	 *             messages
	 * @param message The message body text
	 */
	@Override
	public void acceptMessage (final String title,
			final String caption, final String message) {
		if (null != serverThread) {
			try {
				serverThread.sendAdminMessage (message, title,
						caption, true);
			} catch (final UserDeadException e) {
				/* Don't ask, don't tell */
			}
		}
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptObjectJoinRoom(org.starhope.appius.game.Room,
	 *      org.starhope.appius.game.RoomListener)
	 */
	@Override
	public void acceptObjectJoinChannel (final RoomChannel channel,
			final RoomListener object) {
		if ( (null != serverThread)
				&& (object instanceof AbstractUser)) {
			try {
				final AbstractUser user = (AbstractUser) object;
				if (user != this) {
					serverThread.sendRoomEnteredByUser (
							channel.getRoom (),
							(AbstractUser) object);
				} else {
					serverThread.sendUserJoin (channel.getRoom ());
				}
			} catch (final UserDeadException e) {
				/* Don't ask, don't care */
			}
		}
	}
	
	/**
	 * Accept notification of a user or object joining the room.
	 * 
	 * @param room the room in question
	 * @param object the object leaving the room
	 * @see org.starhope.appius.game.RoomListener#acceptObjectJoinRoom(Room,
	 *      RoomListener)
	 */
	public void acceptObjectJoinRoom (final Room room,
			final AbstractUser object) {
		if (null != serverThread) {
			try {
				serverThread.sendRoomEnteredByUser (room, object);
				serverThread.sendRoomUserCount (room);
			} catch (final UserDeadException e) {
				// don't ask, don't tell
			}
		}
	}
	
	/**
	 * Accept notification of a user or object departing the room.
	 * 
	 * @see org.starhope.appius.game.RoomListener#acceptObjectPartRoom(Room,
	 *      RoomListener)
	 */
	@Override
	public void acceptObjectPartChannel (final RoomChannel channel,
			final RoomListener object) {
		/*
		 * TODO: Res had removed the entirety of this function. Is it
		 * no longer needed?
		 */
		return;
		final ServerThread serv = getServerThread ();
		if (null != serv) {
			try {
				if (object instanceof AbstractUser) {
					serv.sendRoomPartedBy (channel.getRoom (),
							(AbstractUser) object);
				}
				serv.sendRoomUserCount (channel.getRoom ());
			} catch (final UserDeadException e) {
				/* No op */
			}
		}
	}
	
	/**
	 * Accept an out-of-band message from a room.
	 * 
	 * @param sender The user transmitting the out-of-band message
	 * @param body The contents of that message (in JSO)
	 * @param room The room in which the sender is found — and,
	 *             typically, also this recipient.
	 */
	@Override
	public void acceptOutOfBandMessage (final AbstractUser sender,
			final RoomChannel channel, final JSONObject body) {
		try {
			final JSONObject reply = new JSONObject ();
			reply.put ("body", body);
			reply.put ("sender", sender.getAvatarLabel ());
			final Room room = channel.getRoom ();
			if ( (null != room) && (null != room.getZone ())) {
				sendSuccessReply ("outOfBand", reply, sender,
						room.getID ());
			}
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}
	
	/**
	 * Accept an incoming private message (“whisper”) from another
	 * user.
	 * 
	 * @param from The user “whispering” to this one
	 * @param message The contents of the message
	 */
	@Override
	public void acceptPrivateMessage (final AbstractUser from,
			final String message) {
		try {
			if (null != serverThread) {
				serverThread.sendPrivateMessage (from, message);
			}
		} catch (final UserDeadException e) {
			// nifty, I'm dead… let's ignore that.
			serverThread = null;
		}
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.RoomListener#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.Room, java.lang.String)
	 */
	@Override
	public void acceptPublicMessage (final AbstractUser sender,
			final RoomChannel channel, final String message) {
		this.acceptPublicMessage (sender, message);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.RoomListener#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	@Override
	public void acceptPublicMessage (final AbstractUser speaker,
			final String message) {
		try {
			if (null != serverThread) {
				if (ignoring (speaker)) {
					return;
				}
				serverThread.sendPublicMessage (speaker, message);
			}
		} catch (final UserDeadException e) {
			// nifty, we died
			serverThread = null;
		}
	}
	
	/**
	 * @param command the command sending the successful reply
	 * @param jsonData additional JSON data
	 * @param room the room in which the success happened
	 */
	@Override
	public void acceptSuccessReply (final String command,
			final JSONObject jsonData, final Room room) {
		final ServerThread thread = getServerThread ();
		if (null != thread) {
			try {
				thread.sendSuccessReply (command, jsonData, this,
						null == room ? -1 : room.getID ());
			} catch (final JSONException e) {
				BugReporter.getReporter ("srv").reportBug (e);
			}
		}
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptUserAction(Room,
	 *      AbstractUser)
	 */
	@Override
	public void acceptUserAction (final RoomChannel c,
			final AbstractUser u) {
		/* TODO: Res removed this… is that OK now? */
		return;
		final Room r = c.getRoom ();
		if ( !r.equals (getRoom ())) {
			return;
		}
		final JSONObject response = r.getUserAction_JSON (u);
		acceptSuccessReply ("go", response, r);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.RoomListener#acceptUserVariableUpdate(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String, java.lang.String)
	 */
	@Override
	public void acceptUserVariableUpdate (final AbstractUser user,
			final String varName, final String varValue) {
		if ( !isNPC ()) {
			final ServerThread someThread = getServerThread ();
			if (null != someThread) {
				try {
					someThread.sendUserVariable (user, varName,
							varValue);
				} catch (final UserDeadException e) {
					/*
					 * Guess they really don't need to know, then,
					 * do they
					 */
				}
			}
		}
	}
	
	/**
	 * <p>
	 * Create a gift subscription for a user, to last the given number
	 * of months plus the given number of days.
	 * </p>
	 * <p>
	 * To create a lifetime subscription, provide 1000 as the number of
	 * months.
	 * </p>
	 * 
	 * @param months either 1000 (or any greater value over 1000) for a
	 *             lifetime subscription, or, the number of months for
	 *             a gift subscription.
	 * @param days the number of days for a gift subscription. Ignored
	 *             for lifetime subscriptions.
	 */
	@Override
	public void addGiftSubscription (final int months, final int days) {
		UserEnrolment subscription = null;
		try {
			if (999 < months) {
				subscription = new UserEnrolment ("life",
						Nomenclator.getDataRecord (
								Enrolment.class, 6)
								.getProductID (), getUserID ());
				subscription.activate (false);
				return;
			}
			if ( (0 < months) || (0 < days)) {
				subscription = new UserEnrolment ("gift",
						Nomenclator.getDataRecord (
								Enrolment.class, 8)
								.getProductID (), getUserID ());
				subscription.setBegins (new Date (System
						.currentTimeMillis ()));
				final Calendar cal = Calendar.getInstance ();
				subscription.activate (false);
				cal.setTimeInMillis (subscription.getBegins ()
						.getTime ());
				cal.add (Calendar.MONTH, months);
				cal.add (Calendar.DATE, days);
				subscription.setExpires (new java.sql.Date (cal
						.getTimeInMillis ()));
				return;
			}
		} catch (final NotFoundException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		}
	}
	
	/**
	 * @param roomNumber add a room to the user's house
	 */
	public void addRoom (final int roomNumber) {
		try {
			userRecord.getHouse ().put (
					Integer.valueOf (roomNumber),
					Room.initUserRoom (this, roomNumber));
		} catch (final NotReadyException e) {
			BugReporter.getReporter ("srv").reportBug (
					"Caught a NotReadyException in User.addRoom ",
					e);
		}
	}
	
	/**
	 * Affirm that this is a free (non-premium) member and remove
	 * clothing and patterns.
	 */
	public void affirmFreeMember () {
	}
	
	/**
	 * Ensure that this user has the benefits of being a paid member,
	 * effective immediately
	 */
	public void affirmPaidMember () {
	}
	
	/**
	 * Approve the user's requested name, and make it active
	 * 
	 * @param abstractUser the user approving the name (requires
	 *             moderator privileges)
	 * @throws PrivilegeRequiredException if the user approving the
	 *              name does not have moderator privileges
	 * @throws AlreadyUsedException if the name is already in use by
	 *              someone else
	 */
	public void approveName (final AbstractUser abstractUser)
			throws PrivilegeRequiredException, AlreadyUsedException {
		try {
			getUserRecord ().approveName (abstractUser);
		} catch (final AlreadyUsedException e) {
			getUserRecord ().setLogin (null);
			throw e;
		}
	}
	
	/**
	 * Ban a user, preventing any future access to the server.
	 * 
	 * @param bannedBy The moderator by which the user was banned.
	 * @param bannedReason the reason for which the user was banned
	 * @throws PrivilegeRequiredException if the user does not have
	 *              moderator-level (or better) privileges
	 */
	@Override
	public void ban (final AbstractUser bannedBy,
			final String bannedReason)
			throws PrivilegeRequiredException {
		getUserRecord ().ban (bannedBy, bannedReason);
	}
	
	/**
	 * send a message with various debugging information to the
	 * journals
	 * 
	 * @param message the message to be recorded
	 */
	public void blog (final String message) {
		if (null == serverThread) {
			AppiusClaudiusCaecus
					.blather (getAvatarLabel (),
							(getRoom () == null ? "" : "Room “"
									+ getRoom ().getName ()
									+ "” in ")
									+ (getZone () == null ? ""
											: "Zone “"
													+ getZone ()
															.getName ()
													+ "”"),
							"", message, false);
		} else {
			serverThread.tattle (message);
		}
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#canContact()
	 */
	@Override
	public boolean canContact () {
		return getUserRecord ().canContact ();
	}
	
	/**
	 * Determine whether the user can log in with the given password.
	 * 
	 * @param passGuess The user's attempted password
	 * @return true, if the user gave the correct password, and is
	 *         allowed to log in. False, if any of these is not true
	 *         (but does not give any information why)
	 */
	public boolean canLogIn (final String passGuess) {
		return getUserRecord ().canLogIn (passGuess);
	}
	
	/**
	 * <p>
	 * Only adults are allowed to make purchases. Determine whether
	 * this user is allowed to make purchases, or if we should ask them
	 * to get their parents to buy things for them.
	 * </p>
	 * <p>
	 * In the future, this <em>might not</em> be just a test to check
	 * whether the user is an adult. We might, for example, have kids
	 * with gift cards that will be able to make some purchases on
	 * their own.
	 * </p>
	 * 
	 * @return true, if this user is allowed to purchase things. False,
	 *         if they have to get their parents' permission.
	 */
	public boolean canMakePurchase () {
		return getUserRecord ().canMakePurchase ();
	}
	
	/**
	 * @return the canTalk
	 */
	@Override
	public boolean canTalk () {
		return getUserRecord ().canTalk ();
	}
	
	/**
	 * @param room the new room to be joined
	 * @return the old room which was departed (if any)
	 * @deprecated use {@link #setRoom(Room)}
	 */
	@Deprecated
	public Room changeRoom (final Room room) {
		final Room oldRoom = currentRoom;
		setRoom (room);
		return oldRoom;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	public boolean checkFirstTimeAndReset () {
		final boolean result = firstLogin;
		firstLogin = false;
		return result;
	}
	
	/**
	 * @param passwordGuess the supplied password that we want to check
	 * @return true, if the password supplied is correct
	 */
	@Override
	public boolean checkPassword (final String passwordGuess) {
		return getUserRecord ().checkPassword (passwordGuess);
	}
	
	/**
	 * @see org.starhope.appius.user.GeneralUser#compareTo(java.lang.Object)
	 */
	public int compareTo (final User o) {
		return getUserRecord ().compareTo (o.getUserRecord ());
	}
	
	/**
	 * Mark a message as being deleted in the messages database.
	 * 
	 * @param messageID The message ID to be marked as deleted.
	 * @return true if anything were deleted
	 */
	public boolean deleteMail (final int messageID) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("UPDATE messages SET isDeleted='D' WHERE ID=?");
			
			st.setInt (1, messageID);
			return st.executeUpdate () != 0;
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} finally {
			LibMisc.closeAll (st, con);
		}
		return false;
	}
	
	/**
	 * Get naked
	 */
	@Override
	public void doffClothes () {
		final Inventory inventory = getInventory ();
		for (final InventoryItem i : inventory.getActiveClothing ()) {
			inventory.doff (i);
		}
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#doTransport()
	 */
	@Override
	public void doTransport () {
		// no op
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object o) {
		if ( ! (o instanceof User)) {
			return false;
		}
		return this.equals ((User) o);
	}
	
	/**
	 * Determine if two user objects are identical. Two objects are
	 * equal if they have both the same serial number and user ID.
	 * 
	 * @param o the other user
	 * @return true, if the two instances are totally identical
	 */
	public boolean equals (final User o) {
		return (o.getSerial () == getSerial ())
				&& (o.getUserID () == getUserID ());
	}
	
	/**
	 * Equip an item
	 * 
	 * @param item The item to be equipped
	 * @throws GameLogicException if the user does not have the item
	 */
	public void equip (final InventoryItem item)
			throws GameLogicException {
		if ( !getInventory ().contains (item)) {
			throw new GameLogicException (
					"Can not equip an item that this user does not own",
					item, Integer.valueOf (item.getOwnerID ()));
		}
		getInventory ().don (item, null);
	}
	
	/**
	 * Send the user their forgotten password if they know the answer
	 * to their secret question. WRITEME clarify
	 * 
	 * @param forgottenPasswordQ The question being answered
	 * @param forgottenPasswordA The answer provided
	 * @return true if answer is correct and false if it is not also
	 *         triggers the send password e-mail if correct.
	 */
	@Override
	public boolean forgotPassword (final String forgottenPasswordQ,
			final String forgottenPasswordA) {
		
		if ( (null == forgottenPasswordA)
				|| (null == forgottenPasswordQ)
				|| "".equals (forgottenPasswordA)
				|| "".equals (forgottenPasswordQ)
				|| isCanceled ()
				|| isBanned ()
				|| !getUserRecord ().getPasswordRecoveryQuestion ()
						.equals (forgottenPasswordQ)
				|| !getUserRecord ().getPasswordRecoveryAnswer ()
						.equalsIgnoreCase (forgottenPasswordA)) {
			return false;
		}
		
		try {
			remindPassword ();
		} catch (final NotReadyException e) {
			return false;
		}
		return true;
	}
	
	/**
	 * Generate a new "anonymous user name" for the user.
	 * 
	 * @deprecated Use
	 *             {@link org.starhope.appius.user.UserRecord#generateSystemName()}
	 *             instead
	 */
	@Deprecated
	public void generateSystemName () {
		getUserRecord ().generateSystemName ();
	}
	
	/**
	 * @return A JSON array of clothing being worn (including pattern
	 *         and Pivitz) in the order preferred by the client
	 * @deprecated use {@link Inventory#getActiveClothing_JSON()}
	 */
	@Deprecated
	public JSONObject getActiveClothing () {
		return getInventory ().getActiveClothing_JSON ();
	}
	
	/**
	 * get the decorations active (placed) in a room of this user's
	 * house
	 * 
	 * @param roomNumber which room of the user's house
	 * @return home décor items in this room
	 * @throws NotFoundException if the room does not exist
	 */
	public Collection <InventoryItem> getActiveDecorations (
			final int roomNumber) throws NotFoundException {
		final UserHouse house = userRecord.getHouse ();
		if ( !house.containsKey (Integer.valueOf (roomNumber))) {
			if ( (0 == roomNumber) || (1 == roomNumber)) {
				// free rooms
				try {
					house.put (Integer.valueOf (roomNumber),
							Room.initUserRoom (this, roomNumber));
				} catch (final NotReadyException e) {
					BugReporter
							.getReporter ("srv")
							.reportBug (
									"Caught a NotReadyException in User.getActiveDecorations ",
									e);
				}
			} else {
				throw new NotFoundException (
						"User does not have room #" + roomNumber);
			}
		}
		return house.get (Integer.valueOf (roomNumber))
				.getActiveDecorations ();
	}
	
	/**
	 * @param oneTypeString An {@link InventoryItemType} string
	 * @return an item of that type which is active; or, null.
	 * @deprecated use
	 *             {@link Inventory#getActiveItemsByType(InventoryItemType)}
	 */
	@Deprecated
	public InventoryItem getActiveItemByType (
			final String oneTypeString) {
		try {
			return getInventory ().getActiveItemByType (
					Nomenclator.getDataRecord (
							InventoryItemType.class,
							oneTypeString));
		} catch (final NotFoundException e) {
			return null;
		}
	}
	
	/**
	 * Returns the active item for an item type.
	 * 
	 * @param t An Item type to match by.
	 * @return The active inventory item for type t
	 */
	public Collection <InventoryItem> getActiveItemsByType (
			final InventoryItemType t) {
		System.out.println ("Getting active items by type for type: "
				+ t.getName ());
		return getInventory ().getActiveItemsByType (t);
	}
	
	/**
	 * Returns the active item for an item type.
	 * 
	 * @param t A string of the item type. Use Constants from
	 *             {@link InventoryItem}
	 * @return The active inventory item for type t
	 * @deprecated use {@link #getActiveItemsByType(InventoryItemType)}
	 */
	@Deprecated
	public Collection <InventoryItem> getActiveItemsByType (
			final String t) {
		try {
			return getInventory ().getActiveItemsByType (
					Nomenclator.getDataRecord (
							InventoryItemType.class, t));
		} catch (final NotFoundException e) {
			return new HashSet <InventoryItem> ();
		}
	}
	
	/**
	 * Get the current age of the user. This is set up such that the
	 * user's age will increment on their birthday.
	 * 
	 * @return The user's legal age, in years.
	 */
	@Override
	public int getAge () {
		return getUserRecord ().getAge ();
	}
	
	/**
	 * @return the ageGroup
	 */
	@Override
	public AgeBracket getAgeGroup () {
		return getUserRecord ().getAgeGroup ();
	}
	
	/**
	 * @return the date on which this account was approved
	 */
	public Date getApprovedDate () {
		return getUserRecord ().getApprovedDate ();
	}
	
	/**
	 * @see #getApprovedDate()
	 * @return Returns an user-visible string describing whether the
	 *         user has been approved, and if so, when
	 */
	@Override
	public String getApprovedDateString () {
		if (null == getApprovedDate ()) {
			return "Not Approved";
		}
		return "Approved on " + getApprovedDate ().toString ();
	}
	
	/**
	 * @return the avatarClassID
	 */
	@Override
	public AvatarClass getAvatarClass () {
		return getUserRecord ().getAvatarClass ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.user.AbstractUser#getAvatarLabel()
	 */
	@Override
	public String getAvatarLabel () {
		final String name = getUserName ();
		if ( (null == name) || "".equals (name)) {
			return "#" + getUserID ();
		}
		return name;
	}
	
	/**
	 * @return player's date of birth, if known
	 */
	public Date getBirthDate () {
		return getUserRecord ().getBirthDate ();
	}
	
	/**
	 * Get the names of everyone on the user's buddy list. See
	 * {@link #getUserListIterator(String)}
	 * 
	 * @return set of user strings
	 */
	@Override
	public Collection <String> getBuddyListNames () {
		final Collection <String> buddyList = new LinkedList <String> ();
		try {
			final Iterator <String> i = getUserListIterator ("$buddy");
			while (i.hasNext ()) {
				buddyList.add (i.next ());
			}
		} catch (final ParameterException e) {
			User.log.error ("Exception", e);
		}
		return buddyList;
	}
	
	/**
	 * Get the names of everyone on the user's buddy list.
	 * 
	 * @return String array of user names
	 */
	public String [] getBuddyListNamesAsArray () {
		return getBuddyListNames ().toArray (new String [] {});
	}
	
	/**
	 * @return the chat background colour
	 */
	public Colour getChatBG () {
		return getUserRecord ().getChatBG ();
	}
	
	/**
	 * @return the chat foreground colour
	 */
	public Colour getChatFG () {
		return getUserRecord ().getChatFG ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.user.AbstractPerson#getConfirmationTemplate()
	 */
	@Override
	public String getConfirmationTemplate () {
		return AgeBracket.Kid == getAgeGroup () ? "ParentNotification"
				: "UserConfirmation";
	}
	
	/**
	 * Get the IP address or hostname from which the user is connected
	 * (if we can tell). See {@link #isOnline()} for the usual caveats
	 * 
	 * @return Hostname "/" IP address. Hostname is often absent.
	 */
	public String getConnectedFrom () {
		if (isOnline ()) {
			return getIPAddress ();
		}
		return "";
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.user.AbstractUser#getDebugName()
	 */
	@Override
	public String getDebugName () {
		return "“" + getLogin () + "” #" + getUserID ();
	}
	
	/**
	 * @return the dialect
	 */
	@Override
	public String getDialect () {
		return getUserRecord ().getDialect ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#getDisplayName()
	 */
	@Override
	public String getDisplayName () {
		return getUserRecord ().getDisplayName ();
	}
	
	/**
	 * @return the emailPlusDate
	 */
	public Date getEmailPlusDate () {
		return getUserRecord ().getEmailPlusDate ();
	}
	
	/**
	 * @see User#getEmailPlusDate()
	 * @return Returns a user-displayable English string describing
	 *         when the eMail Plus confirmation happened, if it has.
	 */
	public String getEmailPlusDateString () {
		final Date emailPlusDate = getEmailPlusDate ();
		if (null == emailPlusDate) {
			return "No eMail Plus";
		}
		return "eMail Plus on " + emailPlusDate.toString ();
	}
	
	/**
	 * @return the facing
	 */
	@Override
	public String getFacing () {
		return facing;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#getForgotPasswordAnswer()
	 */
	@Override
	public String getForgotPasswordAnswer () {
		return getUserRecord ().getPasswordRecoveryAnswer ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#getForgotPasswordQuestion()
	 */
	@Override
	public String getForgotPasswordQuestion () {
		return getUserRecord ().getPasswordRecoveryQuestion ();
	}
	
	/**
	 * Return the status of the indicated game flag. Note that all game
	 * flags default to false.
	 * 
	 * @param name The unique identifier for the game flag
	 * @return the state (or presence) of the flag
	 */
	public boolean getGameFlag (final String name) {
		return false;
	}
	
	/**
	 * @return the gender
	 */
	public Gender getGender () {
		return gender;
	}
	
	/**
	 * @return the given name of the user, if one were set.
	 */
	@Override
	public String getGivenName () {
		return getUserRecord ().getGivenName ();
	}
	
	/**
	 * Returns the historical contents of this user's record.
	 * 
	 * @param after If non-null, specifies the date after which we want
	 *             to view records. To see all records, back to the
	 *             creation of the user record, supply a null.
	 * @param limit If this is a positive number, it limits the results
	 *             to this number of records.
	 * @return A map of timestamps to key/value pairs. All values are
	 *         expressed as strings (even though they may have numeric,
	 *         enumerative, or date / datetime types in the database),
	 *         since this is primarily (only?) for human-viewable
	 *         auditing.
	 */
	@Override
	public HashMap <Timestamp, HashMap <String, String>> getHistory (
			final Date after, final int limit) {
		final HashMap <Timestamp, HashMap <String, String>> history = new HashMap <Timestamp, HashMap <String, String>> ();
		String limits = "";
		if (null != after) {
			limits += " AND stamp > ? ";
		}
		limits += " ORDER BY stamp DESC ";
		if (limit > 0) {
			limits += " LIMIT " + limit;
		}
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM userHistory WHERE ID=? "
					+ limits);
			
			st.setInt (1, getUserRecord ().getUserID ());
			if (null != after) {
				st.setDate (2, after);
			}
			st.execute ();
			rs = st.getResultSet ();
			while (rs.next ()) {
				Timestamp when;
				try {
					when = rs.getTimestamp ("stamp");
				} catch (final SQLException e) {
					when = null;
				}
				final HashMap <String, String> details = new HashMap <String, String> ();
				details.put ("userName", rs.getString ("userName"));
				details.put ("password", rs.getString ("password"));
				details.put ("avatarClass",
						"" + rs.getInt ("avatarClass"));
				details.put ("baseColor",
						"" + rs.getInt ("baseColor"));
				details.put ("extraColor",
						"" + rs.getInt ("extraColor"));
				details.put ("mail", rs.getString ("mail"));
				details.put ("birthDate", rs.getDate ("birthDate")
						.toString ());
				details.put ("ageGroup", rs.getString ("ageGroup"));
				details.put ("language", rs.getString ("language"));
				details.put ("dialect", rs.getString ("dialect"));
				details.put ("parentID",
						"" + rs.getInt ("parentID"));
				details.put ("approvedDate",
						rs.getDate ("approvedDate").toString ());
				details.put ("emailPlusDate",
						rs.getDate ("emailPlusDate").toString ());
				details.put ("canTalk", rs.getString ("canTalk"));
				details.put ("canEnterChatZone",
						rs.getString ("canEnterChatZone"));
				details.put ("canEnterMenuZone",
						rs.getString ("canEnterMenuZone"));
				details.put ("givenName",
						rs.getString ("givenName"));
				try {
					final Timestamp ku = rs
							.getTimestamp ("kickedUntil");
					details.put ("kickedUntil", ku.toString ());
				} catch (final SQLException e) {
					details.put ("kickedUntil", "null");
				}
				details.put ("kickedReasonCode",
						rs.getString ("kickedReasonCode"));
				details.put ("kickedBy",
						"" + rs.getInt ("kickedBy"));
				details.put ("isActive", rs.getString ("isActive"));
				details.put ("needsNaming",
						rs.getString ("needsNaming"));
				details.put ("staffLevel",
						"" + rs.getInt ("staffLevel"));
				details.put ("peanuts", rs
						.getBigDecimal ("peanuts")
						.toPlainString ());
				details.put ("tootTimeLeft",
						rs.getBigDecimal ("tootTimeLeft")
								.toPlainString ());
				details.put ("tootTimeLeftMinutes", rs
						.getBigDecimal ("tootTimeLeftMinutes")
						.toPlainString ());
				details.put ("tootTimeRefill",
						rs.getBigDecimal ("tootTimeLeftRefill")
								.toPlainString ());
				details.put ("tootTimerType",
						rs.getString ("tootTimerType"));
				details.put ("canContact",
						rs.getString ("canContact"));
				history.put (when, details);
			}
		} catch (final SQLException e) {
			User.log.error ("Exception", e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return history;
	}
	
	/**
	 * @return The string form of the user's IP address (may be IPv4 or
	 *         IPv6)
	 * @deprecated Smart Fox Server misspelling of
	 *             {@link #getIPAddress()}
	 */
	@Deprecated
	public String getIpAddress () {
		return getIPAddress ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getIPAddress()
	 */
	@Override
	public String getIPAddress () {
		if (null != getServerThread ()) {
			return serverThread.getIPAddress ();
		}
		return "";
	}
	
	/**
	 * @return the user ID by which this user was kicked (or banned)
	 */
	@Override
	public int getKickedByUserID () {
		return getUserRecord ().getKickedByUserID ();
	}
	
	/**
	 * @return the message explaining the user being kicked (or banned)
	 */
	@Override
	public String getKickedMessage () {
		String s = "";
		if ( !isKicked () && !isBanned ()) {
			s = LibMisc.getText ("kick.not-kicked", getLanguage (),
					getDialect ());
		} else {
			if ( (null == getKickedReasonCode ())
					|| "null".equals (getKickedReasonCode ())) {
				s = LibMisc.getText (isBanned () ? "banned"
						: "kick.kicked") + "\n";
			} else {
				s = LibMisc.getText (isBanned () ? "banned"
						: "kick.kicked")
						+ "\n\n"
						+ LibMisc.getText ("rule."
								+ getKickedReasonCode ());
			}
		}
		return String.format (s, getUserName ());
	}
	
	/**
	 * @return the reason code, explaining why the user was kicked (or
	 *         banned)
	 */
	@Override
	public String getKickedReasonCode () {
		return getUserRecord ().getKickedReasonCode ();
	}
	
	/**
	 * @return the time at which the user can return to playing the
	 *         game, if s/he has been kicked out temporarily
	 */
	@Override
	public Timestamp getKickedUntil () {
		return getUserRecord ().getKickedUntil ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getLag()
	 */
	@Override
	public long getLag () {
		return roundTripLag;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#getLanguage()
	 */
	@Override
	public String getLanguage () {
		return getUserRecord ().getLanguage ();
	}
	
	/**
	 * @return the time at which the user last was logged on or active
	 */
	public Timestamp getLastActive () {
		return getUserRecord ().getLastActive ();
	}
	
	/**
	 * @return the last (or current) zone for the player
	 */
	public String getLastZone () {
		if (isOnline ()) {
			final Zone currentZone = getZone ();
			if (null != currentZone) {
				final String zoneName = currentZone.getName ();
			}
		}
		return getUserRecord ().getLastZoneName ();
	}
	
	/**
	 * @return the user's login
	 */
	public String getLogin () {
		return getUserRecord ().getLogin ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#getMail()
	 */
	@Override
	public String getMail () {
		return getUserRecord ().getMail ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#getMailConfirmed()
	 */
	@Override
	public Date getMailConfirmed () {
		return getUserRecord ().getMailConfirmed ();
	}
	
	/**
	 * @return the mySerial
	 */
	public int getMySerial () {
		return mySerial;
	}
	
	/**
	 * @return Get the user's login name
	 */
	public String getName () {
		return getUserName ();
	}
	
	/**
	 * @return The time at which the user's name was approved, if it
	 *         has been (null if not).
	 */
	@Override
	public Timestamp getNameApprovedAt () {
		return getUserRecord ().getNameApprovedAt ();
	}
	
	/**
	 * @return the user ID of the moderator who approved this user's
	 *         name, if approved. (-1 if not)
	 */
	public long getNameApprovedByUserID () {
		return getUserRecord ().getNameApprovedByUserID ();
	}
	
	/**
	 * @return the date & time at which the moderator approved this
	 *         user's name, if approved (null if not).
	 */
	@Override
	public Timestamp getNameRequestedAt () {
		return getUserRecord ().getNameRequestedAt ();
	}
	
	/**
	 * @return this user's parent (if any) — null if none.
	 */
	public Parent getParent () {
		return Nomenclator.getParentByID (getParentID ());
	}
	
	/**
	 * @return true, if the parent has approved this user's name
	 */
	public boolean getParentApprovedName () {
		return getUserRecord ().isParentApprovedName ();
	}
	
	/**
	 * @return the ID number of this user's parent, if any (-1 if none)
	 */
	public int getParentID () {
		return getUserRecord ().getParentID ();
	}
	
	/**
	 * @return a JSON object representing the user's Passport.
	 * @throws SQLException if the passport records can't be obtained
	 *              or interpreted
	 * @throws JSONException if the passport can't be represented in
	 *              JSON form
	 */
	public JSONObject getPassport_JSON () throws SQLException,
			JSONException {
		Passport passport;
		try {
			passport = Nomenclator.getDataRecord (Passport.class,
					getUserID ());
		} catch (final NotFoundException e) {
			passport = new Passport (this);
		}
		final JSONObject ret = new JSONObject ();
		ret.put ("passport", passport.toJSON ());
		return ret;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#getPassword()
	 */
	@Override
	public String getPassword () {
		return getUserRecord ().getPassword ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.user.AbstractPerson#getPotentialUserName()
	 */
	@Override
	public String getPotentialUserName () {
		return getUserNameOrRequest ();
	}
	
	/**
	 * Get the referral/affiliate code from this user's initial signup
	 * 
	 * @return the referral or affiliate code
	 */
	public String getReferer () {
		return getUserRecord ().getReferer ();
	}
	
	/**
	 * @return the round-trip lag time to the client in milliseconds
	 */
	public long getRoundTripLag () {
		return roundTripLag;
	}
	
	/**
	 * Get the unique instance serial number for this instance of this
	 * user. Ideally, there should never be two instances of the same
	 * user in core at once; these serial numbers are used for
	 * debugging to be able to detect if that were to happen.
	 * 
	 * @return the unique instance serial number
	 */
	public long getSerial () {
		return mySerial;
	}
	
	/**
	 * Get the Appius Claudius Caecus server thread (if any) associated
	 * with this User (if they are logged-in).
	 * 
	 * @return the active server thread, or null
	 */
	@Override
	public synchronized ServerThread getServerThread () {
		if ( !isOnline ()) {
			return null;
		}
		return serverThread;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * @return all enrolments for this user
	 */
	public Collection <UserEnrolment> getUserEnrolments () {
		return UserEnrolment.getAllForUserID (getUserID ());
	}
	
	/**
	 * @return all enrolments for this user
	 */
	public UserEnrolment [] getUserEnrolmentsAsArray () {
		final Collection <UserEnrolment> allForUserID = UserEnrolment
				.getAllForUserID (getUserRecord ().getUserID ());
		return allForUserID.toArray (new UserEnrolment [allForUserID
				.size ()]);
	}
	
	/**
	 * return the user's login name, if they have one; or the name that
	 * they have requested, if it hasn't been approved yet. If they
	 * have not requested any name at all, returns the string
	 * "(No name)" .
	 * 
	 * @return the user's login name, or their requested name, or a
	 *         string indicating that they have neither.
	 */
	public String getUserNameOrRequest () {
		return getUserRecord ().getUserNameOrRequest ();
	}
	
	/**
	 * @see org.starhope.appius.user.GeneralUser#handleWalkFail(org.starhope.appius.game.Room,
	 *      org.starhope.appius.geometry.Coord3D)
	 */
	@Override
	public Coord3D handleWalkFail (final Room room, final Coord3D to) {
		return super.handleWalkFail (room, to);
	}
	
	/**
	 * Get a (hopefully unique) hash code for this user.
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		if (hashcode == 0) {
			hashcode = LibMisc.makeHashCode (String
					.valueOf (getUserRecord ().getUserID ())
					+ '/'
					+ mySerial);
		}
		return hashcode;
	}
	
	/**
	 * @return true, if the account is banned (neither active nor
	 *         canceled)
	 */
	@Override
	public boolean isBanned () {
		return getUserRecord ().isBanned ();
	}
	
	/**
	 * @return true, if today is the user's birthday
	 */
	public boolean isBirthday () {
		return getUserRecord ().isBirthday ();
	}
	
	/**
	 * @return true if the user account was canceled (not active, nor
	 *         banned)
	 */
	@Override
	public boolean isCanceled () {
		return getUserRecord ().isCanceled ();
	}
	
	/**
	 * @return the canContact
	 * @deprecated use {@link #canContact()}
	 */
	@Deprecated
	public boolean isCanContact () {
		return canContact ();
	}
	
	/**
	 * @return the canEnterChatZone
	 * @deprecated {@link #canEnterChatZone()}
	 */
	@Deprecated
	public boolean isCanEnterChatZone () {
		return getUserRecord ().canEnterChatZone ();
	}
	
	/**
	 * @return the canEnterMenuZone
	 * @deprecated use {@link #canEnterMenuZone()}
	 */
	@Deprecated
	public boolean isCanEnterMenuZone () {
		return getUserRecord ().canEnterMenuZone ();
	}
	
	/**
	 * @return {@link #canTalk()}
	 */
	public boolean isCanTalk () {
		return canTalk ();
	}
	
	/**
	 * @return the isEphemeral
	 */
	public boolean isEphemeral () {
		return getUserRecord ().isEphemeral ();
	}
	
	/**
	 * Returns true if the user has been kicked offline (and the time
	 * has not yet elapsed). Returns false otherwise. This does
	 * <em>not</em> check the status as to whether the user might have
	 * been banned.
	 * 
	 * @return true, if the user is kicked offline.
	 */
	@Override
	public boolean isKicked () {
		return getUserRecord ().isKicked ();
	}
	
	/**
	 * Returns whether this account has a system-provided (not
	 * user-provided) name, or no name at all, and we need to prompt
	 * the user (or parent) to name it.
	 * 
	 * @return true if this user needs to be named
	 */
	public boolean isNeedsNaming () {
		return needsNaming ();
	}
	
	/**
	 * @return true if there is a flag of some kind on this user, that
	 *         the parent needs to pay attention to.
	 */
	public boolean isNeedsParentAttention () {
		if (getAgeGroup () != AgeBracket.Kid) {
			return false;
		}
		if ( !isApproved () && !isCanceled () && !isBanned ()) {
			return true;
		}
		if (isBanned ()) {
			return true;
		}
		if (isKicked ()) {
			return true;
		}
		if (isNeedsNaming ()) {
			return true;
		}
		if (needsParent ()) {
			return true;
		}
		if (isBanned ()) {
			return true;
		}
		return false;
	}
	
	/**
	 * Determine whether this user is a player-character, or
	 * non-player-character.
	 * 
	 * @return true, if this User is NPC-controlled.
	 */
	@Override
	public boolean isNPC () {
		return AgeBracket.System == getAgeGroup ();
	}
	
	/**
	 * @return true, if the user is online; false, if they're offline
	 *         (or we can't tell for certain, e.g. we can't see the
	 *         SmartFox Server / Appius Claudius Caecus)
	 */
	@Override
	public boolean isOnline () {
		return (null != serverThread) && serverThread.isLoggedIn ();
	}
	
	/**
	 * @return true, if the user is a paid member (or staff member)
	 * @see org.starhope.appius.user.UserRecord#isPaidMember()
	 */
	@Override
	public boolean isPaidMember () {
		return getUserRecord ().isPaidMember ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.user.AbstractUser#kick(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String, int)
	 */
	@Override
	public void kick (final AbstractUser u, final String kickReason,
			final int duration) throws PrivilegeRequiredException {
		this.kick (u, kickReason, (long) duration);
	}
	
	/**
	 * Kick a user offline for a number of minutes.
	 * 
	 * @param kickedBy The user who is kicking this user offline
	 * @param kickedReason The reason for which s/he is being kicked
	 * @param kickedMinutes The duration for which s/he should be
	 *             kicked, in minutes. Read that again: minutes — not
	 *             msec!
	 * @throws PrivilegeRequiredException if the person trying to kick
	 *              this user off doesn't have moderator privileges
	 */
	public void kick (final AbstractUser kickedBy,
			final String kickedReason, final long kickedMinutes)
			throws PrivilegeRequiredException {
		final Timestamp until = new Timestamp (
				System.currentTimeMillis ()
						+ (kickedMinutes * 60 * 1000));
		this.kick (kickedBy, kickedReason, until);
	}
	
	/**
	 * Kick the user offline, until a certain date & time.
	 * 
	 * @param kickedBy The user who is kicking this user offline
	 * @param kickedReason The reason for which s/he is being kicked
	 * @param allowBack The time at which this user is permitted to be
	 *             online again.
	 * @throws PrivilegeRequiredException if the person trying to kick
	 *              this user off doesn't have moderator privileges
	 */
	public synchronized void kick (final AbstractUser kickedBy,
			final String kickedReason, final Timestamp allowBack)
			throws PrivilegeRequiredException {
		final Timestamp welcomeBack = getUserRecord ().kick (
				kickedBy, kickedReason, allowBack);
		if (null != serverThread) {
			serverThread
					.sendAdminDisconnect (
							String.format (
									LibMisc.getText ("kick.kicked")
											+ "\n\n"
											+ LibMisc.getText ("rule."
													+ kickedReason),
									getUserName ()),
							"",
							hasStaffLevel (kickedBy
									.getStaffLevel ()) ? kickedBy
									.getAvatarLabel ()
									: "Lifeguard", "kick");
			log.info ("Kicked! By " + kickedBy.getAvatarLabel ()
					+ " #" + getKickedByUserID () + " for "
					+ kickedReason + " until "
					+ welcomeBack.toString ());
		}
	}
	
	/**
	 * Lift the ban upon this user.
	 * 
	 * @see org.starhope.appius.user.AbstractUser#liftBan(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void liftBan (final AbstractUser authority)
			throws PrivilegeRequiredException {
		getUserRecord ().liftBan (authority);
	}
	
	/**
	 * Hook for special stuff to be done right after a new user account
	 * is created
	 */
	public void local_create () {
		
	}
	
	/**
	 * @param zoneName The name of the zone too which the user has
	 *             logged in
	 * @param newServerThread The server thread in which the user is
	 *             logged in
	 */
	public void loggedIn (final String zoneName,
			final ServerThread newServerThread) {
		if (zoneName.charAt (0) != '$') {
			getUserRecord ().setLastZoneName (zoneName);
		}
		if (getLastActive ().before (User.firstLoginDate)) {
			firstLogin = true;
		}
		this.setLastActive ();
		setServerThread (newServerThread);
		setLoggedIn (newServerThread.getIPAddress (), zoneName);
		loggedIn ();
		acceptDatagram (getWallet ().toDatagram (this));
	}
	
	/**
	 * Validate the user's login attempt, returning a failure message
	 * if it could not happen (e.g. the user is kicked). Returns null
	 * if the user CAN log in. DOES NOT log the user in to SFS though!
	 * 
	 * @param chapSeed The CHAP random seed (or null, if no seed was
	 *             used)
	 * @param passwordGuess The guessed password. This should be an
	 *             MD5sum if CHAP is being used (if the seed is not
	 *             null), or the plaintext password otherwise
	 * @return an error string for the user, or null, if successful.
	 */
	public String login (final String chapSeed,
			final String passwordGuess) {
		if (isCanceled ()) {
			return LibMisc.getText ("login.canceled");
		}
		if (isKicked ()) {
			return LibMisc.getText ("kicked");
		}
		if (isBanned ()) {
			return LibMisc.getText ("banned");
		}
		boolean passwordOK = false;
		if (null == chapSeed) {
			passwordOK = getUserRecord ().checkPassword (
					passwordGuess);
		} else {
			// final MD5 md5 = MD5.instance ();
			// passwordOK = md5.getHash (password + chapSeed).equals
			// (
			// passwordGuess);
		}
		if (true == passwordOK) {
			return null;
		}
		return LibMisc.getText ("login.fail");
	}
	
	/**
	 * Returns true if this user has requested a name but it hasn't yet
	 * been approved by a Lifeguard
	 * 
	 * @return true, if user has requested a new name and it hasn't yet
	 *         been approved
	 */
	public boolean nameNeedsApproval () {
		return (null == getNameApprovedAt ())
				&& (null != getNameRequestedAt ());
	}
	
	/**
	 * @return true if the name hasn't been approved by the parent yet
	 */
	public boolean nameNeedsParentalApproval () {
		return (AgeBracket.Kid == getAgeGroup ())
				&& (false == getUserRecord ().needsNaming ())
				&& (false == getUserRecord ()
						.isParentApprovedName ());
	}
	
	/**
	 * Returns whether this account has a system-provided (not
	 * user-provided) name, or no name at all, and we need to prompt
	 * the user (or parent) to name it.
	 * 
	 * @return true if this user needs to be named
	 */
	public boolean needsNaming () {
		return setNeedsNaming ( (null == getLogin ())
				|| (null == getRequestedName ()));
	}
	
	/**
	 * sent notification of the furniture inventory
	 * 
	 * @param room room
	 */
	public void notifyFurnitureInventory (final Room room) {
		final JSONObject blah = new JSONObject ();
		try {
			blah.put ("type", "furniture");
			Commands.do_getInventory (blah, this,
					room.getRoomChannel ());
			blah.put ("type", "structure");
			Commands.do_getInventory (blah, this,
					room.getRoomChannel ());
		} catch (final JSONException e) {
			User.log.error ("Exception", e);
		}
	}
	
	/**
	 * Call this method when the parent determines whether to approve
	 * or disapprove this account.
	 * 
	 * @param whether whether the parent has approved the account; true
	 *             = approved; false = disapproved
	 */
	public void parentApprovedAccount (final boolean whether) {
		if (isBanned ()) {
			return;
		}
		getUserRecord ().parentApprovedAccount (whether);
	}
	
	/**
	 * @param whether True if the parent has approved the name; false
	 *             if they disapprove and want a system suggested name.
	 */
	public void parentApprovedName (final boolean whether) {
		getUserRecord ().parentApprovedName (whether);
	}
	
	/**
	 * Perform global post-login handling — right now, just sends the
	 * Message of the Day if the zone isn't a "$" zone.
	 */
	public void postLoginGlobal () {
		if ( (null != getZone ())
				&& (getZone ().getName ().charAt (0) == '$')) {
			final String motd = AppiusClaudiusCaecus.getMOTD ();
			if (motd.length () > 0) {
				acceptMessage ("Message of the Day", "MOTD", motd);
			}
		}
	}
	
	/**
	 * <p>
	 * Send the user a (presumably forgotten) password via eMail.
	 * </p>
	 * <p>
	 * If this user is a staff member, resets their password.
	 * </p>
	 * <p>
	 * TODO: Add a limiter to this to avoid bulk-spamming people.
	 * </p>
	 * 
	 * @throws NotReadyException if the reminder can't be sent because
	 *              the user has no confirmed mail address on file
	 * @see org.starhope.appius.user.AbstractPerson#remindPassword()
	 */
	@Override
	public void remindPassword () throws NotReadyException {
		if (hasStaffLevel (1)) {
			getUserRecord ().setPassword (
					Person.generateNewPassword ());
		}
		if ("".equals (getMail ()) || (null == getMail ())) {
			throw new NotReadyException ("noReminder:noMailAddress");
		}
		if (null == getMailConfirmed ()) {
			throw new NotReadyException ("noReminder:notConfirmed");
		}
		try {
			Mail.sendPasswordRecoveryMail (this);
		} catch (final FileNotFoundException e) {
			User.log.error ("Exception", e);
		} catch (final IOException e) {
			User.log.error ("Exception", e);
		} catch (final NotFoundException e) {
			User.log.error ("Exception", e);
		}
	}
	
	/**
	 * <p>
	 * Rename the user account, updating all necessary related records.
	 * Note, in particular, that Smartfox is wholly dependant upon user
	 * names, so all records related to Smartfox must be updated!
	 * </p>
	 * <p>
	 * If the user is currently online, this will fuck up hilariously,
	 * I think.
	 * </p>
	 * This is an overriding method.
	 * 
	 * @throws GameLogicException if the user is online (and therefore
	 *              can't be renamed)
	 * @throws ForbiddenUserException if the user isn't allowed to
	 *              choose the name (e.g. filter violation)
	 * @throws AlreadyUsedException if the new name is already taken by
	 *              someone else
	 * @see org.starhope.appius.user.AbstractPerson#rename(java.lang.String)
	 */
	@Override
	public void rename (final String newName)
			throws GameLogicException, AlreadyUsedException,
			ForbiddenUserException {
		if (isOnline ()) {
			throw new GameLogicException (
					"Renaming an account that is currently online is unimplemented",
					getLogin (), newName);
		}
		getUserRecord ().setLogin (newName);
	}
	
	/**
	 * Another user reported this user. No reason given.
	 * 
	 * @param u User that is reporting this user.
	 */
	@Override
	public void reportedToModeratorBy (final AbstractUser u) {
		this.reportedToModeratorBy (u, "No reason given");
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 17, 2010
	 * </pre>
	 * 
	 * TO reportedToModeratorBy Mail customer service with a report of
	 * users reporting each other. WRITEME twheys@gmail.com
	 * 
	 * @param u WRITEME twheys@gmail.com
	 * @param reason WRITEME twheys@gmail.com
	 */
	@Override
	public void reportedToModeratorBy (final AbstractUser u,
			final String reason) {
		if (hasStaffLevel (u.getStaffLevel ())) {
			acceptMessage ("Reported", "Lifeguard",
					"You have been reported to the lifeguard by "
							+ u.getAvatarLabel ());
		}
		final String customerServiceMail = Nomenclator
				.getSystemUser ().getMail ();
		final String subjectLine = AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.sys.op.report.subject",
				"User Reported");
		final long timeMillis = System.currentTimeMillis ();
		final String timestamp = new java.sql.Timestamp (timeMillis)
				.toString ();
		final String reportPostMessage = timestamp + "\nUser ID#"
				+ u.getUserID () + " is reporting User ID# "
				+ getUserID () + "\nReason:\n\n" + reason;
		try {
			Mail.sendMail (customerServiceMail, subjectLine,
					reportPostMessage);
		} catch (final MessagingException e) {
			e.printStackTrace ();
		}
	}
	
	/**
	 * <p>
	 * Post a request to the lifeguards to get approval of a user name
	 * </p>
	 * <em>Does not work, is not used </em>
	 * 
	 * @param userNameRequested The user name which the user has
	 *             requested
	 * @throws ForbiddenUserException if the user name is forbidden
	 *              (e.g. obscene or previously denied for any reason)
	 * @throws AlreadyUsedException if someone has already requested or
	 *              used it
	 */
	public void requestNewUserName (final String userNameRequested)
			throws AlreadyUsedException, ForbiddenUserException {
		getUserRecord ().requestNewUserName (userNameRequested);
	}
	
	/**
	 * request parent approval
	 */
	public void requestParentApproval () {
		if (null != getUserRecord ().getApprovedDate ()) {
			return;
		}
		if (getParentID () >= 0) {
			getParent ().requestApproval (this);
		}
	}
	
	/**
	 * Send a confirmation eMail for a premium user.
	 */
	public void sendConfirmationForPremium () {
		try {
			Mail.sendPremiumMail (this);
		} catch (final FileNotFoundException e) {
			User.log.error ("Exception", e);
		} catch (final IOException e) {
			User.log.error ("Exception", e);
		} catch (final NotFoundException e) {
			User.log.error ("Exception", e);
		} catch (final DataException e) {
			User.log.error ("Exception", e);
		} catch (final NamingException e) {
			User.log.error ("Exception", e);
		}
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#sendConfirmationMail()
	 */
	@Override
	public void sendConfirmationMail () {
		Person.sendConfirmationMail (this);
	}
	
	/**
	 * Send a game action to another user.
	 * 
	 * @param from The user sending the game action (to this user)
	 * @param data The game action data
	 * @throws JSONException if the data can't be sent in JSON
	 */
	@Deprecated
	public void sendGameAction (final GeneralUser from,
			final JSONObject data) throws JSONException {
		acceptGameAction (from, data);
	}
	
	/**
	 * Send a notification to the user that s/he should reconnect to a
	 * different zone
	 * 
	 * @param refugeeZone the zone to which the user should migrate
	 * @throws UserDeadException if the user is no longer online anyway
	 */
	@Override
	public void sendMigrate (final Zone refugeeZone)
			throws UserDeadException {
		try {
			final JSONObject migration = new JSONObject ();
			migration.put ("from", "migrate");
			migration.put ("status", "true");
			migration.put ("toZone", refugeeZone.getName ());
			migration.put ("host", refugeeZone.getHost ());
			// migration.put ("port", portNumber);
			serverThread.sendResponse (migration,
					Integer.valueOf (getRoomNumber ()));
		} catch (final JSONException e) {
			User.log.error ("Exception", e);
		}
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#sendOops()
	 */
	@Override
	public void sendOops () {
		if (AppiusConfig
				.getConfigBoolOrFalse ("com.tootsville.bugs.noEmotes")) {
			acceptPrivateMessage (this, "Oops!\nYou can't say that.");
		} else {
			acceptPrivateMessage (this, "/00p$");
		}
	}
	
	/**
	 * Deprecated. See the more accurately-named
	 * {@link #acceptPrivateMessage(AbstractUser, String)}
	 * 
	 * @param from the user speaking
	 * @param message the words spoken
	 * @see #acceptPrivateMessage(AbstractUser, String)
	 */
	@Deprecated
	public void sendPrivateMessage (final AbstractUser from,
			final String message) {
		acceptPrivateMessage (from, message);
	}
	
	/**
	 * Accept a public message.
	 * 
	 * @param from The user speaking
	 * @param speech the words spoken
	 * @see #acceptPublicMessage(AbstractUser, String)
	 * @deprecated use
	 *             {@link #acceptPublicMessage(AbstractUser, String)}
	 */
	@Deprecated
	public void sendPublicMessage (final GeneralUser from,
			final String speech) {
		this.acceptPublicMessage (from, speech);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#sendResponse(org.starhope.appius.net.datagram.AbstractDatagram)
	 */
	@Override
	public void sendResponse (final AbstractDatagram datagram) {
		try {
			serverThread.sendResponse (datagram);
		} catch (final UserDeadException e) {
			// No need to worry about it
		}
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#sendResponse(org.json.JSONObject)
	 */
	@Override
	public void sendResponse (final JSONObject result) {
		if (null != serverThread) {
			try {
				serverThread.sendResponse (result,
						getRoomNumber (), true);
			} catch (final UserDeadException e) {
				// No worries
			}
		}
	}
	
	/**
	 * Send a response to this user's client, if one is connected.
	 * 
	 * @param result the response datagram in JSON
	 * @param room the room from which the response is coming (or -1
	 *             for not-specified) (ignored)
	 * @deprecated use {@link #sendResponse(JSONObject)}
	 */
	@Deprecated
	public void sendResponse (final JSONObject result, final int room) {
		this.sendResponse (result);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#sendStaffPasswordReset()
	 */
	@Override
	public void sendStaffPasswordReset () {
		Person.sendStaffPasswordReset (this);
	}
	
	/**
	 * Send a “success” reply to the client if one is connected
	 * 
	 * @param source The method returning success
	 * @param reply additional details of the success to be returned to
	 *             the client
	 * @param sender the user reporting success
	 * @param room the room in which the success happened, or -1 if not
	 *             specified
	 */
	private void sendSuccessReply (final String source,
			final JSONObject reply, final AbstractUser sender,
			final int room) {
		if (null != serverThread) {
			try {
				serverThread.sendSuccessReply (source, reply,
						sender, room);
			} catch (final JSONException e) {
				User.log.error (
						"Caught a JSONException in sendSuccessReply",
						e);
			}
		}
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#sentConfirmationMail()
	 */
	@Override
	public void sentConfirmationMail () {
		getUserRecord ().setMailConfirmSent (
				System.currentTimeMillis ());
	}
	
	/**
	 * @param isActive1 the isActive to set
	 */
	public void setActive (final boolean isActive1) {
		getUserRecord ().setActive (UserActiveState.OK);
	}
	
	/**
	 * Sets the age group based upon the user's date of birth.
	 * 
	 * @return The age group computed for this user
	 */
	public AgeBracket setAgeGroup () {
		return getUserRecord ().setAgeGroup ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setAgeGroupToSystem()
	 */
	@Override
	public void setAgeGroupToSystem () {
		getUserRecord ().setAgeGroup (AgeBracket.System);
	}
	
	/**
	 * @param date the approvedDate to set
	 */
	public void setApprovedDate (final Date date) {
		getUserRecord ().setApprovedDate (date);
	}
	
	/**
	 * set the avatar class for this user
	 * 
	 * @param avatarClass the new avatar class
	 */
	public void setAvatarClass (final AvatarClass avatarClass) {
		getUserRecord ().setAvatarClass (avatarClass);
	}
	
	/**
	 * @param birthDate1 the birthDate to set
	 */
	public void setBirthDate (final Date birthDate1) {
		getUserRecord ().setBirthDate (birthDate1);
	}
	
	/**
	 * @param isCanceled1 the isCanceled to set
	 */
	public void setCanceled (final boolean isCanceled1) {
		getUserRecord ().setActive (UserActiveState.CAN);
	}
	
	/**
	 * @param canContact1 the canContact to set
	 */
	@Override
	public void setCanContact (final boolean canContact1) {
		getUserRecord ().setCanContact (canContact1);
	}
	
	/**
	 * @param canEnterChatZone1 the canEnterChatZone to set
	 */
	public void setCanEnterChatZone (final boolean canEnterChatZone1) {
		// default setter (brpocock@star-hope.org, Jul 8, 2009)
		getUserRecord ().setCanEnterChatZone (canEnterChatZone1);
	}
	
	/**
	 * @param canEnterMenuZone1 the canEnterMenuZone to set
	 */
	public void setCanEnterMenuZone (final boolean canEnterMenuZone1) {
		getUserRecord ().setCanEnterMenuZone (canEnterMenuZone1);
	}
	
	/**
	 * @param canTalk1 the canTalk to set
	 */
	@Override
	public void setCanTalk (final boolean canTalk1) {
		getUserRecord ().setCanTalk (canTalk1);
	}
	
	/**
	 * @param newChatBG the new chat background colour
	 */
	public void setChatBG (final Colour newChatBG) {
		getUserRecord ().setChatBG (newChatBG);
	}
	
	/**
	 * @param newChatFG the chat foreground colour to set
	 */
	public void setChatFG (final Colour newChatFG) {
		getUserRecord ().setChatFG (newChatFG);
	}
	
	/**
	 * @param emailPlusDate1 the emailPlusDate to set
	 */
	public void setEmailPlusDate (final Date emailPlusDate1) {
		getUserRecord ().setEmailPlusDate (emailPlusDate1);
	}
	
	/**
	 * @param newFacing the facing to set
	 */
	@Override
	public void setFacing (final String newFacing) {
		facing = newFacing;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#setForgotPasswordAnswer(java.lang.String)
	 */
	@Override
	public void setForgotPasswordAnswer (final String answer) {
		getUserRecord ().setPasswordRecovery (
				getForgotPasswordQuestion (), answer);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#setForgotPasswordQuestion(java.lang.String)
	 */
	@Override
	public void setForgotPasswordQuestion (final String question) {
		getUserRecord ().setPasswordRecovery (question,
				getForgotPasswordAnswer ());
	}
	
	/**
	 * @param setGender the gender to set
	 */
	public void setGender (final Gender setGender) {
		gender = setGender;
	}
	
	/**
	 * @param givenName1 the givenName to set
	 */
	@Override
	public void setGivenName (final String givenName1) {
		getUserRecord ().setGivenName (givenName1);
	}
	
	/**
	 * WRITEME
	 */
	@Override
	public void setLastActive () {
		this.setLastActive (new Timestamp (System
				.currentTimeMillis ()));
	}
	
	/**
	 * @param timestamp the time at which this user was last active
	 */
	void setLastActive (final Timestamp timestamp) {
		getUserRecord ().setLastActive (timestamp);
	}
	
	/**
	 * Set the user's location; but <em>note</em> that you should be
	 * using {@link Room#putHere(AbstractUser, Coord3D)} to position a
	 * player
	 * 
	 * @param coord3d new location
	 */
	@Override
	public void setLocation (final Coord3D coord3d) {
		if (Double.isNaN (coord3d.getX ())
				|| Double.isNaN (coord3d.getY ())
				|| Double.isNaN (coord3d.getZ ())) {
			throw new IllegalArgumentException ("NaN");
		}
		location = coord3d;
	}
	
	/**
	 * <p>
	 * Notify the multiverse that the user is logging in
	 * </p>
	 * <p>
	 * Set up the User records, indicating that the user has (in fact)
	 * logged in to the game. Record the IP address and Zone server.
	 * </p>
	 * XXX: contains SQL
	 * 
	 * @param ipAddress The IP address (or something like it) from
	 *             which the user has logged-in
	 * @param zone The active server zone into which the User has
	 *             logged-in.
	 */
	public void setLoggedIn (final String ipAddress, final String zone) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("INSERT INTO userLaston (userID, timestamp, ipAddress, lastZoneName) VALUES (?,NOW(),?,?) "
					+ "ON DUPLICATE KEY UPDATE userID=Values(userID),timestamp=NOW(),ipAddress=Values(ipAddress),lastZoneName=Values(lastZoneName)");
			st.setInt (1, getUserID ());
			st.setString (2, ipAddress);
			st.setString (3, zone);
			st.execute ();
		} catch (final SQLException e) {
			User.log.error ("Exception", e);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}
	
	/**
	 * @deprecated use {@link #setLoggedIn(String, String)} — less
	 *             ambiguous/misleading name
	 * @param from the login source
	 * @param zone the zone into which the user logged in
	 */
	@Deprecated
	public void setLogin (final String from, final String zone) {
		setLoggedIn (from, zone);
	}
	
	/**
	 * @param newMail the mail to set
	 * @throws GameLogicException if attempting to set an eMail address
	 *              on a kid account
	 */
	@Override
	public void setMail (final String newMail)
			throws GameLogicException {
		if (AgeBracket.Kid == getUserRecord ().getAgeGroup ()) {
			throw new GameLogicException ("kid mail", newMail,
					newMail);
		}
		User.log.info ("Setting mail for {} to {}",
				getAvatarLabel (), newMail);
		getUserRecord ().setMail (newMail);
		getUserRecord ().setMailConfirmed (null);
		sendConfirmationMail ();
	}
	
	/**
	 * Sets the user capabilities to allow talking, and permits the
	 * user entry into both chat zones and menu-chat-only zones.
	 * 
	 * @param mailConfirmed1 the date and time at which the user's mail
	 *             was confirmed.
	 */
	@Override
	public void setMailConfirmed (final Date mailConfirmed1) {
		getUserRecord ().setMailConfirmed (mailConfirmed1);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#setMailConfirmSent(java.sql.Date)
	 */
	@Override
	public void setMailConfirmSent (final Date date) {
		getUserRecord ().setMailConfirmSent (date);
	}
	
	/**
	 * @param needsNaming1 the needsNaming to set
	 * @return whether the user needs naming
	 */
	public boolean setNeedsNaming (final boolean needsNaming1) {
		getUserRecord ().setNeedsNaming (needsNaming1);
		if (needsNaming1) {
			getUserRecord ().setRequestedName (null);
		}
		return getUserRecord ().needsNaming;
	}
	
	/**
	 * Set this to be a child account with the specified parent.
	 * 
	 * @param parent the parent to set
	 * @throws GameLogicException if this user is an adult
	 * @throws ForbiddenUserException if the parent has banned child
	 *              accounts (and therefore cannot adopt more)
	 * @throws AlreadyExistsException if the parent has more than the
	 *              maximum allowed children.
	 */
	@Override
	public void setParent (final Parent parent)
			throws GameLogicException, ForbiddenUserException,
			AlreadyExistsException {
		if (null == parent) {
			return;
		}
		// no change if it's the same parent.
		if (getParentID () == parent.getID ()) {
			return;
		}
		if (getAgeGroup () == AgeBracket.Adult) {
			throw new GameLogicException (
					"We don't need to know about the parents of adults.",
					this, parent);
		}
		
		final int maxChildren = AppiusConfig.getIntOrDefault (
				"org.starhope.appius.parent.maxChildren", 10);
		if (maxChildren < parent.getFreeChildren ().length) {
			throw new AlreadyExistsException ("too many kids");
		}
		
		if (parent.hasBannedKids ()) {
			throw new ForbiddenUserException (getLogin ());
		}
		
		if ( (null == getUserRecord ().getApprovedDate ())
				&& (AgeBracket.Kid == getAgeGroup ())) {
			getUserRecord ().setParentID (parent.getID ());
			
			parent.sendNotificationForChild (this);
		} else {
			getUserRecord ().setParentID (parent.getID ());
		}
	}
	
	/**
	 * Set this to be a child account with the specified parent.
	 * 
	 * @param parent the parent to set
	 * @throws GameLogicException if this user is an adult
	 */
	public void setParentByParent (final Parent parent)
			throws GameLogicException {
		if (null == parent) {
			return;
		}
		if (getAgeGroup () == AgeBracket.Adult) {
			throw new GameLogicException (
					"We don't need to know about the parents of adults.",
					this, parent);
		}
		final UserRecord userRecord = getUserRecord ();
		if (getParentID () != parent.getID ()) {
			if ( (null == userRecord.getApprovedDate ())
					&& (AgeBracket.Kid == getAgeGroup ())) {
				userRecord.setParentID (parent.getID ());
			}
			userRecord.setApproved ();
			userRecord.setParentApprovedName (true);
			userRecord.setCanEnterChatZone (true);
			userRecord.setCanEnterMenuZone (true);
			userRecord.setCanTalk (true);
			userRecord.setCanContact (false);
			userRecord.setParentID (parent.getID ());
		}
		// no change if it's the same parent.
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#setPassword(java.lang.String)
	 */
	@Override
	public void setPassword (final String password1) {
		getUserRecord ().setPassword (password1);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#setPasswordAndPasswordRecovery(java.lang.String,
	 *      java.lang.String, java.lang.String)
	 */
	@Override
	public void setPasswordAndPasswordRecovery (final String question,
			final String answer, final String newPassword)
			throws GameLogicException {
		getUserRecord ().setPasswordRecovery (question, answer);
		getUserRecord ().setPassword (newPassword);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#setPasswordRecovery(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public void setPasswordRecovery (
			final String forgottenPasswordQuestion,
			final String forgottenPasswordAnswer) {
		getUserRecord ().setPasswordRecovery (
				forgottenPasswordQuestion, forgottenPasswordAnswer);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractPerson#setRandomPassword()
	 */
	@Override
	public String setRandomPassword () {
		final String newPass = Person.generateNewPassword ();
		getUserRecord ().setPassword (newPass);
		return newPass;
	}
	
	/**
	 * <p>
	 * Set the referrer from whom we were sent this new user. This
	 * value can only be set once, and is permanent for that user. The
	 * valid referrer values are stored in a table. (WRITEME
	 * twheys@gmail.com what table?)
	 * </p>
	 * <p>
	 * Yes, referer is misspelled in homage to HTTP
	 * </p>
	 * 
	 * @param theReferer a four-character identifier
	 */
	public void setReferer (final String theReferer) {
		getUserRecord ().setReferer (theReferer);
	}
	
	/**
	 * @param newRegisteredAt the registeredAt to set
	 */
	public void setRegisteredAt (final Timestamp newRegisteredAt) {
		getUserRecord ().setRegisteredAt (newRegisteredAt);
	}
	
	/**
	 * Update the lag time associated with this user
	 * 
	 * @param l milliseconds round-trip lag
	 */
	public void setRoundTripLag (final long l) {
		if (l < 1) {
			roundTripLag = 1;
		} else {
			roundTripLag = l;
		}
	}
	
	/**
	 * Set the server thread controlling this user. Disconnect any
	 * pre-existing server thread.
	 * 
	 * @param serverThread2 The new server thread.
	 */
	public synchronized void setServerThread (
			final ServerThread serverThread2) {
		if ( (null != serverThread) && (serverThread2 != null)) {
			if (serverThread.equals (serverThread2)) {
				return;
			}
			serverThread.disconnectDuplicate ();
		}
		serverThread = serverThread2;
	}
	
	/**
	 * @param newStaffLevel the staffLevel to set
	 */
	public void setStaffLevel (final int newStaffLevel) {
		getUserRecord ().setStaffLevel (newStaffLevel);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.user.AbstractUser#setStartT(long)
	 */
	@Override
	public void setStartT (final long when) {
		lastUserMovement = when;
	}
	
	/**
	 * Set the values specific to a subclass of User
	 * 
	 * @param resultSet WRITEME
	 * @throws SQLException WRITEME
	 */
	protected void setSubclassValues (final ResultSet resultSet)
			throws SQLException {
		/* No op */
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setTravelStart(long)
	 */
	@Override
	public void setTravelStart (final long l) {
		travelStartTime = l;
	}
	
	/**
	 * @param newLogin the userName to set
	 * @throws ForbiddenUserException if the user name is not allowed
	 * @throws AlreadyUsedException if the user name is in-use
	 * @throws GameLogicException if the user is online and can't be
	 *              renamed
	 */
	public void setUserName (final String newLogin)
			throws AlreadyUsedException, ForbiddenUserException,
			GameLogicException {
		Nomenclator.assertLoginAvailable (newLogin);
		if ( (null == getLogin ()) || "".equals (getLogin ())) {
			getUserRecord ().setLogin (newLogin);
		} else {
			rename (newLogin);
		}
	}
	
	/**
	 * <p>
	 * Set a user name, requested by the user. (Sends to lifeguards for
	 * approval)
	 * </p>
	 * <p>
	 * Clears needsNaming.
	 * </p>
	 * 
	 * @param userRequestedLogin the userName to set
	 * @throws ForbiddenUserException if the user name isn't allowed
	 * @throws AlreadyUsedException if the user name has already been
	 *              used (or requested)
	 */
	public void setUserNameFromUser (final String userRequestedLogin)
			throws AlreadyUsedException, ForbiddenUserException {
		if (isBanned ()) {
			throw new ForbiddenUserException (userRequestedLogin);
		}
		Nomenclator.assertLoginAvailable (userRequestedLogin);
		requestNewUserName (userRequestedLogin);
		setNeedsNaming (false);
	}
	
	/**
	 * @param userEnrolment the enrolment to be started for this user
	 */
	public void startEnrolment (final UserEnrolment userEnrolment) {
		// nothing to do...
	}
	
	/**
	 * This is analogous to {@link #toSFSXML()} for the pure JSON “to
	 * infinity and beyond” interface
	 * 
	 * @return the brief JSON record giving the user's name, ID, and
	 *         variables.
	 */
	public JSONObject toJSONRef () {
		final JSONObject jso = new JSONObject ();
		try {
			jso.put ("name", getAvatarLabel ());
			jso.put ("id", getUserID ());
			final JSONObject vars = new JSONObject ();
			for (final Entry <String, String> var : getVariables ()
					.entrySet ()) {
				vars.put (var.getKey (), var.getValue ());
			}
			jso.put ("vars", vars);
		} catch (final JSONException e) {
			User.log.error ("Exception", e);
		}
		return jso;
	}
	
	/**
	 * @return The User record in the sense of Smart Fox Server's XML
	 *         format, as used in joinOK and uER (user enters room)
	 *         messages
	 */
	@Override
	public String toSFSXML () {
		final StringBuilder reply = new StringBuilder ();
		reply.append ("<u i='");
		reply.append (getUserID ());
		reply.append ("' m='0'><n><![CDATA[");
		reply.append (getUserName ().toLowerCase (Locale.ENGLISH));
		reply.append ("]]></n><vars>");
		for (final Entry <String, String> var : getVariables ()
				.entrySet ()) {
			reply.append ("<var n='");
			reply.append (var.getKey ());
			reply.append ("' t='s'><![CDATA[");
			reply.append (var.getValue ());
			reply.append ("]]></var>");
		}
		reply.append ("</vars></u>");
		return reply.toString ();
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder result = new StringBuilder ();
		result.append (getAvatarLabel ());
		result.append ("\nat ");
		result.append (getLocation ().toString ());
		// result.append ("\nactiveClothing = ");
		// result
		// .append (getInventory ().getActiveClothing ()
		// .toString ());
		result.append ("\nageGroup = ");
		result.append (getAgeGroup ().toString ());
		result.append ("\napprovedDate = ");
		result.append (getApprovedDateString ());
		result.append ("\navatarClass = ");
		result.append (getAvatarClass ().toString ());
		final Date birthdate = getUserRecord ().getBirthDate ();
		result.append ("\nbirthDate = ");
		result.append (birthdate.getTime () > 100 ? birthdate
				.toString () : "undefined");
		result.append ("\nconnectedFrom = ");
		result.append (getConnectedFrom ());
		result.append ("\nlanguage _ dialect = ");
		result.append (getLanguage ());
		result.append (" _ ");
		result.append (getDialect ());
		result.append ("\ndisplayName = ");
		result.append (getDisplayName ());
		result.append ("\neMail Plus Date = ");
		result.append (getEmailPlusDateString ());
		result.append ("\ngivenName = ");
		result.append (getGivenName ());
		result.append ("\nhistory = TODO");
		result.append ("\nkicked ( by ");
		result.append (getKickedByUserID ());
		result.append (" until ");
		result.append (getKickedUntil ());
		result.append (" for ");
		result.append (getKickedReasonCode ());
		result.append (" ) ");
		result.append (getKickedMessage ());
		result.append ("\nmail = ");
		result.append (getMail ());
		result.append ("\nmailConfirmed = ");
		result.append (getMailConfirmed ());
		result.append ("\nnameApprovedAt = ");
		result.append (getNameApprovedAt ());
		result.append ("; nameApprovedBy = ");
		result.append (getNameApprovedByUserID ());
		result.append ("\nnameRequestedAt = ");
		result.append (getNameRequestedAt ());
		result.append ("; requestedName = ");
		result.append (getRequestedName ());
		final Parent p = getParent ();
		result.append ("\nparent = "
				+ (null == p ? "null" : p.toString ()));
		// result.append ("\npassword = " + getPassword ());
		// result.append ("\npublicInfo = " + getPublicInfo ());
		result.append ("\nresponsibleMail = ");
		final String responsibleMailAddress = getResponsibleMail ();
		if (null == responsibleMailAddress) {
			result.append ("(null)");
		} else {
			result.append (responsibleMailAddress);
		}
		result.append ("\nstaffLevel = " + getStaffLevel ());
		// result.append ("\ntootTime = " + getTootTimeLeft () + ":"
		// + getTootTimeLeftMinutes ());
		// result.append ("\ntootTime = " + getTootTimeRefill () +
		// " per "
		// + (isTootTimerDay () ? "day" : "month"));
		result.append ("\nuserEnrolments = "
				+ LibMisc.listToDisplay (getUserEnrolments (),
						"en", "US"));
		result.append ("\nuserID = " + getUserID ());
		result.append ("\nuserName = " + getUserName ());
		result.append ("\nactive = " + (isActive () ? "Y" : "N"));
		result.append ("\napproved = " + (isApproved () ? "Y" : "N"));
		result.append ("\nbanned = " + (isBanned () ? "Y" : "N"));
		result.append ("\nbirthday = " + (isBirthday () ? "Y" : "N"));
		result.append ("\ncanceled = " + (isCanceled () ? "Y" : "N"));
		result.append ("\ncanContact = "
				+ (canContact () ? "Y" : "N"));
		result.append ("\ncanEnterChatZone = "
				+ (canEnterChatZone () ? "Y" : "N"));
		result.append ("\ncaneEnterMenuZone = "
				+ (canEnterMenuZone () ? "Y" : "N"));
		result.append ("\ncanTalk = " + (isCanTalk () ? "Y" : "N"));
		result.append ("\nkicked = " + (isKicked () ? "Y" : "N"));
		result.append ("\nneedsNaming = "
				+ (needsNaming () ? "Y" : "N"));
		result.append ("\nneedsParentAttention = "
				+ (isNeedsParentAttention () ? "Y" : "N"));
		// result.append ("\nonline = " + (isOnline () ? "Y" : "N"));
		result.append ("\nlag = " + getLag () + "ms");
		result.append ("\npaidMember = "
				+ (isPaidMember () ? "Y" : "N"));
		result.append ("\nnameNeedsApproval = "
				+ (nameNeedsApproval () ? "Y" : "N"));
		result.append ("\nnameNeedsParentalApproval = "
				+ (nameNeedsParentalApproval () ? "Y" : "N"));
		result.append ("\nparentApprovedName = "
				+ (getParentApprovedName () ? "Y" : "N"));
		result.append ("\npassword recovery Q&A = "
				+ getForgotPasswordQuestion () + " "
				+ getForgotPasswordAnswer ());
		return result.toString ();
	}
	
}
