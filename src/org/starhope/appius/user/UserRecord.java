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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author brpocock@star-hope.org
 * @author twheys@gmail.com
 */
package org.starhope.appius.user;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Collection;

import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.inventory.Inventory;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.mb.UserEnrolment;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.sql.SQLPeerEnum;
import org.starhope.appius.sys.admin.Security;
import org.starhope.appius.sys.admin.SecurityCapability;
import org.starhope.appius.types.AgeBracket;
import org.starhope.appius.types.Colour;
import org.starhope.appius.types.UserActiveState;
import org.starhope.appius.user.events.Action;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.appius.via.Setter;
import org.starhope.catullus.Copyable;
import org.starhope.catullus.OpEd;
import org.starhope.util.LibMisc;
/**
 * The record describing an user in the game — whether a theoretical
 * user account (like the System User), an actual human user's account,
 * or an NPC.
 *
 * @author brpocock@star-hope.org
 */
public class UserRecord extends SimpleDataRecord <UserRecord> implements
Copyable <UserRecord> {

	/**
	 * class property for generating unique serials for instances
	 */
	private static long nextSerial = 0;

	/**
	 * Java Serialisation Unique ID
	 */
	private static final long serialVersionUID = -4136192122359036981L;

	public static int getAgeFor (final java.util.Date birth){
		if (null == birth) {
			return 1000;
		}
		final java.util.Date now = new java.util.Date ();
		int yearsOld = now.getYear () - birth.getYear ();
		now.setYear (birth.getYear ());
		if (now.compareTo (birth) < 0) {
			--yearsOld; // no birthday yet this year
		}
		return yearsOld;
	}

	/**
	 * Whether the user account is OK (active), canceled, or banned
	 */
	private UserActiveState active = UserActiveState.OK;

	/**
	 * The age bracket to which this user belongs: currently kid (0-12),
	 * teen (13-17), or adult (18+). Computed from birth date
	 * periodically and cached.
	 */
	private AgeBracket ageGroup = AgeBracket.Kid;

	/**
	 * The date on which the account was approved (by parent) or eMail
	 * was validated (by self). Either way, it's basically eMail
	 * validation, but just differs in who gets the mail. The date on
	 * which the account was approved (by parent) or eMail was validated
	 * (by self). Either way, it's basically eMail validation, but just
	 * differs in who gets the mail.
	 */
	private Date approvedDate = null;

	/**
	 * The type of avatar in play
	 */
	private AvatarClass avatarClass;

	/**
	 * The base colour of the avatar
	 */
	private Colour baseColour = Colour.BLACK;


	/**
	 * The user's date of birth. Required, COPPA.
	 */
	private Date birthDate;

	/**
	 * True if the user can sign in to a Beta server
	 */
	private boolean canBetaTest = false;

	/**
	 * if true, the user has given his/her consent to receive marketing
	 * messages by eMail
	 */
	private boolean canContact = false;

	/**
	 * True if the user can enter a zone where people can chat freely.
	 * Lightning in Tootsville.
	 */
	private boolean canEnterChatZone = false;

	/**
	 * True if the user can enter a zone where dialogue is chosen from
	 * menus. Hearts in Tootsville.
	 */
	private boolean canEnterMenuZone = false;

	/**
	 * True if the user is allowed to type chat.
	 */
	private boolean canTalk = false;

	/**
	 * background colour for chat text
	 */
	private Colour chatBG = Colour.WHITE;

	/**
	 * foreground colour for chat text
	 */
	private Colour chatFG = Colour.BLACK;

	/**
	 * the dialect of the user's {@link #language} in which s/he prefers
	 * to see messages
	 */
	private String dialect = "US";

	/**
	 * For kids, this is the date on which eMail Plus secondary eMail is
	 * sent out. This may be past or future.
	 */
	private Date emailPlusDate = null;

	/**
	 * The extra colour of the avatar. For Master Toot (Amphibious) this
	 * is the nose/highlight colour
	 */
	private Colour extraColour = Colour.WHITE;


	/**
	 * the user's actual, given name
	 */
	private String givenName = null;

	/**
	 * The user's inventory. Note that the inventory is <em>not</em>
	 * automatically instantiated at user construction; it is
	 * opportunistically loaded later.
	 */
	private Inventory inv = null;

	/**
	 * Whether or not changes to the class will be flushed. True: Do not
	 * flush False: Flush
	 */
	private boolean isEphemeral = false;

	/**
	 * The user ID who kicked this user offline. (or -1)
	 */
	private int kickedByUserID = -1;

	/**
	 * The reason that this user is kicked offline or banned.
	 */
	private String kickedReasonCode = null;

	/**
	 * The date at which the user is no longer kicked offline. For
	 * banned users, this is Timestamp ( Long.MAX_LONG ), which means
	 * the universe should end first.
	 */
	private Timestamp kickedUntil = null;

	/**
	 * the language in which the user prefers to receive messages
	 */
	private String language = "en";

	/**
	 * the last zone on which the user had been logged on; or, their
	 * current zone, if we can see Smartfox from here.
	 */
	private String lastZoneName = "";

	/**
	 * The user's current, active login name.
	 */
	private String login = null;

	/**
	 * the user's eMail address
	 */
	private String mail = null;

	/**
	 * the date on which the user's mail address was confirmed (or null,
	 * if it hasn't been)
	 */
	private Date mailConfirmed = null;

	/**
	 * <p>
	 * the date that eMail confirmation was sent out
	 * </p>
	 * <p>
	 * XXX: save in database
	 * </p>
	 */
	private Date mailConfirmSent;

	/**
	 * The timestamp of Lifeguard approval of the user's name (or null,
	 * if it hasn't been approved yet)
	 */
	private Timestamp nameApprovedAt = null;

	/**
	 * The user ID of the moderator who approved this user's name
	 */
	private int nameApprovedByUserID = -1;

	/**
	 * The time at which this user entered his/her request for a new
	 * name.
	 */
	Timestamp nameRequestedAt = null;

	/**
	 * If true, the user hasn't picked a name for this account (but it
	 * may have a system-assigned random one), so we need to nag them to
	 * pick a name.
	 */
	protected boolean needsNaming = true;

	/**
	 * true, if this is a notable NPC/character
	 */
	private boolean notable = false;

	/**
	 * Whether the user's parent has approved the name yet.
	 */
	private boolean parentApprovedName = false;

	/**
	 * Pointer to the parent of this user, if the user's age bracket is
	 * "kid"
	 */
	private int parentID = -1;

	/**
	 * answer to the password recovery question
	 */
	private String passRecoveryA = null;

	/**
	 * password recovery question
	 */
	private String passRecoveryQ = "How much wood would a woodchuck chuck…?";

	/**
	 * WRITEME
	 */
	private String password = "\n";

	/**
	 * The 1-4 character code representing the source of a referral
	 * which resulted in this user signing up. Referrer (referer) codes
	 * are assigned in the M&B web site to “brand” users for life based
	 * upon who caused them to sign up with the site.
	 */
	protected String referer = null;

	/**
	 * Time when the user originally registered
	 */
	private Timestamp registeredAt = null;

	/**
	 * The user name which the user has requested, but has not yet been
	 * approved.
	 */
	protected String requestedName = null;

	/**
	 * unique instance serial number
	 */
	private final long serial;

	/**
	 * The level of staff authority possessed by this user.
	 */
	protected int staffLevel = 0;

	/**
	 * The security capability to act like a system operator
	 */
	final private SecurityCapability sysOpCapability = SQLPeerEnum.get (
			SecurityCapability.class,
			SecurityCapability.CAP_SYSOP_COMMANDS.intValue ());
	/**
	 * The rate of movement (in pixels per second) of this user.
	 */
	protected double travelRate = 100.0;

	/**
	 * The set of rooms in this user's house (and yard). Special values:
	 * 0 is the first room (everyone gets it for free), and 1 is the
	 * yard (lot).
	 */
	protected UserHouse userHouse = null;

	/**
	 * The user's numeric ID, for database purposes.
	 */
	protected int userID = -1;

    /**
	 * Nil constructor. Note that birthDate MUST be set before the
	 * record can be entered into the database.
	 */
	public UserRecord () {
		super (UserRecord.class);
		userID = -1;
		login = null;
		password = "\n";
		mail = null;
		try {
			avatarClass = Nomenclator.getDataRecord (AvatarClass.class,
					1);
		} catch (final NotFoundException e) {
			throw AppiusClaudiusCaecus
			.fatalBug (
					"Caught a NotFoundException in UserRecord.UserRecord ",
					e);
		}
		baseColour = avatarClass.getDefaultBaseColor ();
		extraColour = avatarClass.getDefaultExtraColor ();
		birthDate = null; // MUST be set.
		ageGroup = AgeBracket.Kid;
		language = "en";
		dialect = "US";
		parentID = -1;
		approvedDate = null;
		emailPlusDate = null;
		canTalk = false;
		canEnterChatZone = false;
		canEnterMenuZone = false;
		canBetaTest = false;
		givenName = null;
		kickedUntil = null;
		kickedByUserID = -1;
		active = UserActiveState.OK;
		needsNaming = false;
		staffLevel = 0;
		notable = false;
		canContact = false;
		requestedName = null;
		passRecoveryQ = "What are the first four digits after the decimal of the square root of the year your mother was born?";
		passRecoveryA = null;
		nameRequestedAt = null;
		mailConfirmed = null;
		referer = null;
		chatFG = Colour.BLACK;
		chatBG = Colour.WHITE;

		serial = ++UserRecord.nextSerial;
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param birthDate1 WRITEME
	 * @param avatarTitle WRITEME
	 * @param userNameRequest WRITEME
	 * @param password2 WRITEME
	 * @param passwordQuestion WRITEME
	 * @param passwordAnswer WRITEME
	 * @throws ForbiddenUserException WRITEME
	 * @throws AlreadyUsedException WRITEME
	 */
	public UserRecord (final Date birthDate1, final String avatarTitle,
            final String userNameRequest, final String passwordAnswer,
            final String passwordQuestion, final String password2)
	throws AlreadyUsedException, ForbiddenUserException {
		super (UserRecord.class);
        markForReload ();
		userID = -1;
		if (birthDate1.before (java.sql.Date.valueOf ("1900-1-1"))) {
			throw new NumberFormatException ("Birth date out of range");
		}
		if (birthDate1.after (new Date (System.currentTimeMillis ()))) {
			throw new NumberFormatException ("Birth date out of range");
		}

		serial = ++UserRecord.nextSerial;
		birthDate = birthDate1;
		setAgeGroup ();
		if (canApproveSelf ()) {
			approvedDate = new Date (System.currentTimeMillis ());
			canEnterChatZone = true;
			canTalk = false;
			canEnterMenuZone = true;
		} else {
			approvedDate = null;
			canTalk = false;
			canEnterChatZone = false;
			canEnterMenuZone = true;
		}

		requestedName = userNameRequest;

		// Give initial avatar name in string format, ex. 'zap', 'human'
		try {
			avatarClass = Nomenclator.getDataRecord (AvatarClass.class,
					avatarTitle);
		} catch (final NotFoundException e) {
			throw AppiusClaudiusCaecus
			.fatalBug (
					"Caught a NotFoundException in UserRecord.UserRecord ",
					e);
		}

		baseColour = avatarClass.getDefaultBaseColor ();
		extraColour = avatarClass.getDefaultExtraColor ();

		registeredAt = new Timestamp (System.currentTimeMillis ());

		setAgeGroup ();

        password = password2;
        passRecoveryA = passwordAnswer;
        passRecoveryQ = passwordQuestion;

		markAsLoaded ();
		
		// try {
		// inv = Nomenclator.make (Inventory.class, this);
		// } catch (NotReadyException e) {
		// inv = null;
		// }
		//
		save ();
        Nomenclator.cache (this);

        }

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param userRecordLoader loader
	 */
	public UserRecord (final RecordLoader <UserRecord> userRecordLoader) {
		super (userRecordLoader);

		serial = ++UserRecord.nextSerial;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param abstractUser WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 * @throws AlreadyUsedException if the user's name has been used by
	 *             someone else already
	 */
	public void approveName (final AbstractUser abstractUser)
	throws PrivilegeRequiredException, AlreadyUsedException {
		if (null == abstractUser) {
			throw new PrivilegeRequiredException (sysOpCapability);
		}
		if ( !Security.hasCapability (abstractUser, sysOpCapability)) {
			abstractUser.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		}
		login = requestedName;
		System.out.println ("Username set to: " + login
				+ "\nRequested set to: " + requestedName);
		nameApprovedByUserID = abstractUser.getUserID ();
		nameApprovedAt = new Timestamp (System.currentTimeMillis ());
		changed ();
	}

	/**
	 * assert that the user should have the requisite staff level;
	 * otherwise, throw an exception
	 *
	 * @param staffLevelNeeded WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 */
	private void assertStaffLevel (final int staffLevelNeeded)
	throws PrivilegeRequiredException {
		if (staffLevel < staffLevelNeeded) {
			throw new PrivilegeRequiredException (staffLevelNeeded);
		}
	}

	/**
	 * Ban a user, preventing any future access to the server.
	 *
	 * @param bannedBy The moderator by which the user was banned.
	 * @param bannedReason the reason for which the user was banned
	 * @throws PrivilegeRequiredException if the user does not have
	 *             moderator-level (or better) privileges
	 */
	public void ban (final AbstractUser bannedBy,
			final String bannedReason)
	throws PrivilegeRequiredException {
		final AbstractUser who = Nomenclator
		.getOnlineUserByLogin (login);
		active = UserActiveState.BAN;
		setKickedReasonCode (bannedReason);
		setKickedByUserID (bannedBy.getUserID ());
		setKickedUntil (new Timestamp (Integer.MAX_VALUE));

		if (null != who && who.isOnline () && null != who.getZone ()) {
			bannedBy.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
			Quaestor.getDefault ().action (
					new Action (
					who.getRoom (),
 bannedBy,
					"ban",
 who,
							bannedReason));
			{
				final ServerThread serverThread = who
				.getServerThread ();
				if (null != serverThread) {
					serverThread
					.sendAdminDisconnect (
							String.format (
									LibMisc.getText ("banned")
									+ "\n\n"
									+ LibMisc
									.getText ("rule."
											+ bannedReason),
											getLogin ()),
											"",
											(hasStaffLevel (bannedBy
													.getStaffLevel ()) ? bannedBy
															.getAvatarLabel ()
															: "Lifeguard"), "ban");
				}
			}
		} else {
			return;
		}

	}

	/**
	 * If the user is a teen (13+) or adult, they are allowed to approve
	 * their own account. This is a boolean test for that fact.
	 *
	 * @return true, if the user is permitted to approve their own
	 *         account (via their own eMail address). False, if they
	 *         require parent approval.
	 */
	public boolean canApproveSelf () {
		return ageGroup == AgeBracket.Teen
		|| ageGroup == AgeBracket.Adult;
	}

	/**
	 * @return true, if the user is permitted to log in to a beta test
	 *         server
	 */
	public boolean canBetaTest () {
		return canBetaTest || hasStaffLevel (1);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public boolean canContact () {
		return canContact;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public boolean canEnterChatZone () {
		return canEnterChatZone;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public boolean canEnterMenuZone () {
		return canEnterMenuZone;
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
		return passGuess.equals (password)
		&& UserActiveState.OK == active && !isKicked ();
	}

	/**
	 * <p>
	 * Only adults are allowed to make purchases. Determine whether this
	 * user is allowed to make purchases, or if we should ask them to
	 * get their parents to buy things for them.
	 * </p>
	 * <p>
	 * In the future, this <em>might not</em> be just a test to check
	 * whether the user is an adult. We might, for example, have kids
	 * with gift cards that will be able to make some purchases on their
	 * own.
	 * </p>
	 *
	 * @return true, if this user is allowed to purchase things. False,
	 *         if they have to get their parents' permission.
	 */
	public boolean canMakePurchase () {
		return ageGroup == AgeBracket.Adult;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public boolean canTalk () {
		return canTalk;
	}


	/*
	 * XXX implementing the ObjectInputValidation interface and
	 * overriding the validateObject() method. If something looks amiss
	 * when it is called, we throw an InvalidObjectException.
	 */

	/**
	 * @param passwordGuess the password to be checked
	 * @return true, if the password matches
	 */
	public boolean checkPassword (final String passwordGuess) {
		return password.equals (passwordGuess);
	}

	/**
	 * @see org.starhope.catullus.Copyable#copyProtoype(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public UserRecord copyProtoype (final UserRecord prototype) {
        setActive (prototype.active);
		setAgeGroup (prototype.getAgeGroup ());
		setApprovedDate (prototype.getApprovedDate ());
		setAvatarClass (prototype.getAvatarClass ());
		setBaseColor (prototype.getBaseColor ());
		setBirthDate (prototype.getBirthDate ());
		setCanBetaTest (prototype.canBetaTest ());
		setCanContact (prototype.canContact ());
		setCanEnterChatZone (prototype.canEnterChatZone ());
		setCanEnterMenuZone (prototype.canEnterMenuZone ());
		setCanTalk (prototype.canTalk ());
		setChatBG (prototype.getChatBG ());
		setChatFG (prototype.getChatFG ());
		setLanguage (prototype.getLanguage (), prototype.getDialect ());
		setEmailPlusDate (prototype.getEmailPlusDate ());
		setExtraColor (prototype.getExtraColor ());
		setGivenName (prototype.getGivenName ());
		final Inventory prototypeInventory = prototype.getInv ();
		getInv ().retainAll (prototypeInventory);
		getInv ().addAll (prototypeInventory);
		setEphemeral (prototype.isEphemeral ());
		setKickedByUserID (prototype.getKickedByUserID ());
		setKickedReasonCode (prototype.getKickedReasonCode ());
		setKickedUntil (prototype.getKickedUntil ());
		setLastZoneName (prototype.getLastZoneName ());
		setLogin (prototype.getLogin ());
		setMail (prototype.getMail ());
		setMailConfirmed (prototype.getMailConfirmed ());
		setMailConfirmSent (prototype.getMailConfirmSent ());
		setNameApprovedByUserID (prototype.getNameApprovedByUserID ());
		nameApprovedAt = prototype.getNameApprovedAt ();
		nameRequestedAt = prototype.getNameRequestedAt ();
		setNotable (prototype.isNotable ());
		setParentApprovedName (prototype.parentApprovedName);
		setParentID (prototype.getParentID ());
		setPasswordRecovery (prototype.getPasswordRecoveryQuestion (),
				prototype.getPasswordRecoveryAnswer ());
		setPassword (prototype.getPassword ());
		setReferer (prototype.getReferer ());
		setRegisteredAt (prototype.getRegisteredAt ());
		setRequestedName (prototype.getRequestedName ());
		setStaffLevel (prototype.getStaffLevel ());
		setTravelRate (prototype.getTravelRate ());
		// user house
		setUserID (prototype.getUserID ());
		return this;
	}

	/**
	 * Generate a new "anonymous user name" for the user.
	 *
	 * @return the name generated
	 */
	public String generateSystemName () {
		String newLogin = "";
		setNeedsNaming (true);
		while ("".equals (newLogin)) {
			String tryName = "";
			int tries = 0;
			do {
				tryName = getSystemNameAdjective () + "."
				+ getSystemNameNoun ();
				if (tries++ > 10) {
					tryName += String.valueOf (AppiusConfig
							.getRandomInt (1, 100));
				}
			} while ( !Nomenclator.isLoginAvailable (tryName));
			newLogin = tryName;
			setLogin (newLogin);
		}
		return newLogin;
	}

	/**
	 * Get the current age of the user. This is set up such that the
	 * user's age will increment on their birthday.
	 *
	 * @return The user's legal age, in years.
	 */
	public int getAge () {
		return UserRecord.getAgeFor (birthDate);
	}

	/**
	 * @return the ageGroup
	 */
	public AgeBracket getAgeGroup () {
		return ageGroup; /* brpocock@star-hope.org */
	}

	/**
	 * @return the approvedDate
	 */
	public Date getApprovedDate () {
		return approvedDate; /* brpocock@star-hope.org */
	}

	/**
	 * @return the avatarClass
	 */
	public AvatarClass getAvatarClass () {
		return avatarClass; /* brpocock@star-hope.org */
	}

	/**
	 * @return the baseColor
	 */
	public Colour getBaseColor () {
		return baseColour; /* brpocock@star-hope.org */
	}

	/**
	 * @return the birthDate
	 */
	public Date getBirthDate () {
		if (null == birthDate){
			birthDate = new Date (1234567890);
		}
		return birthDate;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () {
		return userID;
	}

	/**
	 * @throws NotFoundException if there's neither a login nor a
	 *             requested name
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		if (null == login) {
			if (null == requestedName) {
				throw new NotFoundException ("");
			}
			return requestedName;
		}
		return login;
	}

	/**
	 * @return the chatBG
	 */
	public Colour getChatBG () {
		return chatBG; /* brpocock@star-hope.org */
	}

	/**
	 * @return the chatFG
	 */
	public Colour getChatFG () {
		return chatFG; /* brpocock@star-hope.org */
	}

	/**
	 * @param ident the currency identifier
	 * @return the amount of that currency
	 */
	public BigDecimal getCurrency (final Currency ident) {
		return getWallet ().get (ident);
	}

	/**
	 * Returns a specific string identifying this user in a convenient
	 * form for debugging. The form is: “u:LOGIN=#ID” where LOGIN is the
	 * user's login name, and ID is their numeric
	 *
	 * @return the debugging string identifying this user
	 */
	public String getDebugName () {
		return "u:" + getLogin () + "=#" + getUserID ();
	}

	/**
	 * @return the dialect
	 */
	public String getDialect () {
		return dialect;
	}

	/**
	 * @return the name of the user as it should be displayed
	 * @see org.starhope.appius.user.AbstractPerson#getDisplayName()
	 */
	public String getDisplayName () {
		if (null != getGivenName ()) {
			return getGivenName ();
		}
		if (null != login) {
			return login;
		}
		if (null != requestedName) {
			return requestedName;
		}
		if (null != getMail ()) {
			return "<" + getMail () + ">";
		}
		return "(Unnamed)";
	}

	/**
	 * @return the emailPlusDate
	 */
	public Date getEmailPlusDate () {
		return emailPlusDate; /* brpocock@star-hope.org */
	}

	/**
	 * get all enrolments in which this user is enrolled.
	 *
	 * @return a set of enrolments.
	 */
	public Collection <UserEnrolment> getEnrolments () {
		return UserEnrolment.getAllForUserID (userID);
	}

	/**
	 * @return the extraColor
	 */
	public Colour getExtraColor () {
		return extraColour; /* brpocock@star-hope.org */
	}

	/**
	 * @return the forgotPasswordAnswer
	 * @deprecated use {@link #getPasswordRecoveryAnswer()}
	 */
	@Deprecated
	public String getForgotPasswordAnswer () {
		return passRecoveryA;
	}

	/**
	 * @return the forgotPasswordQuestion
	 * @deprecated use {@link #getPasswordRecoveryQuestion()}
	 */
	@Deprecated
	public String getForgotPasswordQuestion () {
		return passRecoveryQ;
	}

	/**
	 * @return the givenName
	 */
	public String getGivenName () {
		return givenName; /* brpocock@star-hope.org */
	}

	/**
	 * @return this user's house
	 */
	public synchronized UserHouse getHouse () {
		if (null == userHouse) {
			userHouse = new UserHouse (myUser ());
		}
		return userHouse;
	}



	/**
	 * @return the inventory
	 */
	public synchronized Inventory getInv () {
		if (null != inv) {
			return inv;
		}
		try {
			inv = Nomenclator.getDataRecord (Inventory.class,
					getUserID ());
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a NotFoundException in UserRecord.getInv ",
					e);
		}
		return inv;
	}

	/**
	 * get the user ID who kicked this user offline.
	 *
	 * @return the user ID of the moderator who kicked this user offline
	 *         (1 for the system)
	 */
	public int getKickedByUserID () {
		return kickedByUserID;
	}

	/**
	 * get the reason code for which the user was kicked offline; see
	 * WRITEME?
	 *
	 * @return the reason code
	 */
	public String getKickedReasonCode () {
		return kickedReasonCode;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public Timestamp getKickedUntil () {
		return kickedUntil;
	}

	/**
	 * @return the language
	 */
	public String getLanguage () {
		return language; /* brpocock@star-hope.org */
	}

	/**
	 * @return the lastZoneName
	 */
	public String getLastZoneName () {
		return lastZoneName;
	}

	/**
	 * @return the login
	 */
	public String getLogin () {
		return login; /* brpocock@star-hope.org */
	}

	/**
	 * @return the mail
	 */
	public String getMail () {
		return mail; /* brpocock@star-hope.org */
	}

	/**
	 * @return the mailConfirmed
	 */
	public Date getMailConfirmed () {
		return mailConfirmed; /* brpocock@star-hope.org */
	}

	/**
	 * @return the mailConfirmSent
	 */
	public Date getMailConfirmSent () {
		return mailConfirmSent;
	}

	/**
	 * @return the nameApprovedAt
	 */
	public Timestamp getNameApprovedAt () {
		return nameApprovedAt; /* brpocock@star-hope.org */
	}

	/**
	 * @return the nameApprovedByUserID
	 */
	public int getNameApprovedByUserID () {
		return nameApprovedByUserID; /* brpocock@star-hope.org */
	}

	/**
	 * @return the nameRequestedAt
	 */
	public Timestamp getNameRequestedAt () {
		return nameRequestedAt; /* brpocock@star-hope.org */
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	private Parent getParent () {
		if (getParentID () < 0) {
			return null;
		}
		return Nomenclator.getParentByID (getParentID ());
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return parent id
	 */
	public int getParentID () {
		return parentID;
	}

	/**
	 * @return password
	 */
	String getPassword () {
		return password;
	}

	/**
	 * @return answer to the password recovery question
	 */
	public String getPasswordRecoveryAnswer () {
		return passRecoveryA;
	}

	/**
	 * @return password recovery question
	 */
	public String getPasswordRecoveryQuestion () {
		return passRecoveryQ;
	}

	/**
	 * @return the referer
	 */
	public String getReferer () {
		return referer;
	}

	/**
	 * @return the registeredAt
	 */
	public Timestamp getRegisteredAt () {
		return registeredAt;
	}

	/**
	 * @return the date on which this user first registered
	 * @see #registeredAt the time registered
	 */
	public java.util.Date getRegisteredDate () {
		return new java.util.Date (registeredAt.getTime ());
	}

	/**
	 * @see #getRegisteredDate()
	 * @return Returns an user-visible string describing when the user
	 *         was registered
	 */
	public String getRegisteredDateString () {
		if (null == registeredAt) {
			return "Registration date unknown";
		}
		return "Registered on " + registeredAt.toString ();
	}

	/**
	 * @return the name that the user requested
	 */
	public String getRequestedName () {
		return null == requestedName ? login : ""
			.equals (requestedName) ? login : requestedName;
	}

	/**
	 * <p>
	 * Get the eMail address of a responsible person: either the player,
	 * or the parent.
	 * </p>
	 * <p>
	 * Currently, kids 13-17 return their own mail.
	 * </p>
	 *
	 * @return the eMail address
	 */
	public String getResponsibleMail () {
		if (ageGroup == AgeBracket.Kid) {
			final Parent p = getParent ();
			if (null == p) {
				return null;
			}
			return p.getMail ();
		}
		return getMail ();
	}

	/**
	 * Internal serial number for tracking user records through the
	 * cache
	 *
	 * @return the instance serial number
	 */
	public long getSerial () {
		return serial;
	}

	/**
	 * @return the staffLevel
	 */
	public int getStaffLevel () {
		return staffLevel; /* brpocock@star-hope.org */
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}

	/**
	 * @return an adjective usable as part of a system-generated name
	 */
	private String getSystemNameAdjective () {
		final String [] adjectives = {};
		return adjectives [(int) (Math.random () * adjectives.length)];
	}

	/**
	 * @return a noun usable as part of a system-generated name
	 */
	private String getSystemNameNoun () {
		final String [] nouns = {};
		return nouns [(int) (Math.random () * nouns.length)];
	}

	/**
	 * @return the travelRate
	 */
	public double getTravelRate () {
		return travelRate;
	}

	/**
	 * @return the userID
	 */
	public int getUserID () {
		return userID;
	}

	/**
	 * return the user's login name, if they have one; or the name that
	 * they have requested, if it hasn't been approved yet. If they have
	 * not requested any name at all, returns the string "(No name)" .
	 *
	 * @return the user's login name, or their requested name, or a
	 *         string indicating that they have neither.
	 */
	public String getUserNameOrRequest () {
		if (null != login) {
			return login;
		}
		if (null != requestedName) {
			return requestedName;
		}
		setNeedsNaming (true);
		return "(No name)";
	}

	/**
	 * @return the user's wallet
	 */
	private Wallet getWallet () {
		try {
			return Nomenclator.getDataRecord (Wallet.class, userID);
		} catch (final NotFoundException e) {
			return new Wallet (this);
		}
	}

	/**
	 * Returns true if the user has the asserted staff level, or a staff
	 * level which includes it. Returns false, otherwise.
	 *
	 * @param staffLevelNeeded The minimum staff level for which we are
	 *            testing.
	 * @return True, if the user meets the minimum staff level stated;
	 *         false, otherwise.
	 */
	public boolean hasStaffLevel (final int staffLevelNeeded) {
		try {
			assertStaffLevel (staffLevelNeeded);
		} catch (final PrivilegeRequiredException e) {
			return false;
		}
		return true;
	}

	/**
	 * @return the isActive
	 */
	public boolean isActive () {
		return UserActiveState.OK == active;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public boolean isApproved () {
		return isActive () && null != approvedDate;
	}

	/**
	 * @return the isBanned
	 */
	public boolean isBanned () {
		return UserActiveState.BAN == active;
	}

	/**
	 * @return true, if today is the user's birthday
	 */
	@SuppressWarnings ("deprecation")
	public boolean isBirthday () {
		if (AgeBracket.System == ageGroup) {
			return true;
		}
		final Date now = new Date (System.currentTimeMillis ());
		if (birthDate.getMonth () == now.getMonth ()
				&& birthDate.getDay () == now.getDay ()) {
			return true;
		}
		if (birthDate.getMonth () == 2 && now.getMonth () == 2
				&& birthDate.getDay () == 29 && now.getDay () == 28) {
			return true;
		}
		return false;
	}

    /**
     * @return the isCanceled
     */
    public boolean isCanceled () {
        return UserActiveState.CAN == active;
    }

    /**
     * @return the isEphemeral
     */
	public boolean isEphemeral () {
		return isEphemeral; /* brpocock@star-hope.org */
	}

	/**
	 * Returns true if the user has been kicked offline (and the time
	 * has not yet elapsed). Returns false otherwise. This does
	 * <em>not</em> check the status as to whether the user might have
	 * been banned.
	 *
	 * @return true, if the user is kicked offline.
	 */
	public boolean isKicked () {
		if (null == getKickedUntil ()) {
			return false;
		}
		if (getKickedUntil ().compareTo (
				new Timestamp (System.currentTimeMillis ())) <= 0) {
			setKickedUntil (null);
			setKickedByUserID (1);
			setKickedReasonCode (null);
			return false;
		}
		return true;
	}

	/**
	 * @return true, if this is a notable NPC/character
	 */
	public boolean isNotable () {
		return notable;
	}

	/**
	 * @return true, if the user is a paid member (or staff member)
	 */
	public boolean isPaidMember () {
		if (hasStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER)) {
			return true;
		}

		final Collection <UserEnrolment> enrolments = getEnrolments ();

		for (final UserEnrolment enrolment : enrolments) {
			if (enrolment.isActive ()) {
				return true;
			}
		}

		return false;
	}

	/**
	 * @return the parentApprovedName
	 */
	public boolean isParentApprovedName () {
		return parentApprovedName; /* brpocock@star-hope.org */
	}

	/**
	 * Kick the user offline, until a certain date & time.
	 *
	 * @param kickedBy The user who is kicking this user offline
	 * @param kickedReason The reason for which s/he is being kicked
	 * @param allowBack The time at which this user is permitted to be
	 *            online again.
	 * @return the time at which the user is permitted back online. May
	 *         be less than the time requested, if the user kicking
	 *         doesn't have sufficient privileges.
	 * @throws PrivilegeRequiredException if the person trying to kick
	 *             this user off doesn't have moderator privileges
	 */
	public Timestamp kick (final AbstractUser kickedBy,
			final String kickedReason, final Timestamp allowBack)
	throws PrivilegeRequiredException {
		final Timestamp welcomeBack = new Timestamp (
				allowBack.getTime ());
		final long kickMaxTime = System.currentTimeMillis ()
		+ kickedBy.getStaffLevel () * 1000L * 60 * 15;
		if (welcomeBack.getTime () > kickMaxTime) {
			kickedBy.acceptMessage (
					"Maximum Kick Time Exceeded",
					"God",
					"You can kick an user for up to "
					+ kickedBy.getStaffLevel ()
					* 15
					+ " minutes. Above that, contact a systems programmer for assistance.");
			welcomeBack.setTime (kickMaxTime);
		}
		kickedBy.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		setKickedByUserID (kickedBy.getUserID ());
		setKickedReasonCode (kickedReason);
		setKickedUntil (welcomeBack);
		changed ();
		return welcomeBack;
	}

	/**
	 * @param authority by whose authority is the ban to be lifted?
	 * @throws PrivilegeRequiredException if that user lacks authority
	 *             to lift the ban
	 */
	public void liftBan (final AbstractUser authority)
	throws PrivilegeRequiredException {
		assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		setKickedUntil (new Timestamp (System.currentTimeMillis ()));
		active = UserActiveState.OK;
		changed ();
	}

	/**
	 * find the user backed by this user record
	 *
	 * @return the user backed by this user record
	 */
	AbstractUser myUser () {
		return Nomenclator.getOnlineUserByLogin (login);
	}

	/**
	 * @return true, if the user needs naming before joining the game
	 */
	public boolean needsNaming () {
		return needsNaming;
	}

	/**
	 * Kid accounts (under 13) require parental confirmation. In order
	 * to get that, we have to get a parental contact. If this field is
	 * false, then the user is either a teenager or adult, or they have
	 * a parent on file. It does <em>not</em> mean that they have had
	 * their account approved: only that they have given us the parental
	 * information (if we needed it). If we ever encounter a user for
	 * whom this flag is true, ask them “who's your daddy?”
	 *
	 * @return true, if this is a kid account without a known parent
	 *         (yet)
	 */
	public boolean needsParent () {
		return AgeBracket.Kid == getAgeGroup () && -1 == getParentID ();
	}

	/**
	 * @param whether if true, the parents have approved the account; if
	 *            false, they did not (cancel the account)
	 */
	public void parentApprovedAccount (final boolean whether) {
		if (null != approvedDate || AgeBracket.Kid != setAgeGroup ()) {
			return;
		}
		if (1 > parentID) {
			return;
		}
		if (whether) {
			approvedDate = new Date (System.currentTimeMillis ());
			canEnterChatZone = true;
			canEnterMenuZone = true;
			canTalk = true;
			active = UserActiveState.OK;
		} else {
			approvedDate = null;
			canEnterChatZone = false;
			canEnterMenuZone = false;
			canTalk = false;
			canContact = false;
			// AppiusClaudiusCaecus
			// .reportBug
			// ("Canceling account as non-approved by parents");
			active = UserActiveState.CAN;
		}
		changed ();

	}

	/**
	 * @param whether True if the parent has approved the name; false if
	 *            they disapprove and want a system suggested name.
	 */
	public void parentApprovedName (final boolean whether) {
		if (whether) {
			parentApprovedName = true;
		} else {
			generateSystemName ();
			parentApprovedName = false;
		}
		changed ();
	}

	/**
	 * <p>
	 * Post a request to the lifeguards to get approval of a user name
	 * </p>
	 * <em>Does not work, is not used </em>
	 *
	 * @param userNameRequested The user name which the user has
	 *            requested
	 * @throws ForbiddenUserException if the user name is forbidden
	 *             (e.g. obscene or previously denied for any reason)
	 * @throws AlreadyUsedException if someone has already requested or
	 *             used it
	 */
	public void requestNewUserName (final String userNameRequested)
	throws AlreadyUsedException, ForbiddenUserException {
		Nomenclator.assertLoginAvailable (userNameRequested);
		requestedName = userNameRequested;
		nameRequestedAt = new Timestamp (System.currentTimeMillis ());
		try {
			approveName (Nomenclator.getUserByID (1));
		} catch (final PrivilegeRequiredException e) {
			AppiusClaudiusCaecus.reportBug (
					"God can't auto-approve user " + userNameRequested
					+ " name?", e);
		}
		/*
		 * final MonitorEvent ev = new MonitorEvent (
		 * "User name requested", "mb.name"); ev.attachObject
		 * ("User requested name", String.class, requestedName);
		 * ev.attachObject ("User requesting name", User.class, this);
		 * ev.post ();
		 */
		changed ();
	}

	/**
	 * Sets the active state to the given state
	 *
	 * @param state the new state (OK, CAN, BAN)
	 */
    public void setActive (final UserActiveState state) {
        if (active != state) {
            if (active == UserActiveState.BAN && !isBeingLoaded ()) {
				AppiusClaudiusCaecus
						.reportBug ("Cannot change state from BAN; must use ::liftBan");
				return;
			}

            if (state == UserActiveState.CAN) {
				AppiusClaudiusCaecus
                        .reportBug ("Still trying to cancel accounts!");
			}
            active = state;
            changed ();
        }
    }

	/**
	 * set the age bracket of the user record, based upon the specified
	 * date of birth.
	 *
	 * @return the age bracket of this user
	 */
	@Setter (getter = "getAgeGroup")
	@OpEd (isAdvanced = true, label = "Age Group", advice = "Age group is normally set automatically by setting the age. However, NPC:s must have their age group set to System (“X”).", needCap = "CAP_NPC")
	public AgeBracket setAgeGroup () {
		if (ageGroup == AgeBracket.System) {
			return AgeBracket.System;
		}

		final AgeBracket oldAgeGroup = ageGroup;
		final int age = getAge ();

		ageGroup = age >= 18 ? AgeBracket.Adult
				: age >= 13 ? AgeBracket.Teen : AgeBracket.Kid;
				if (oldAgeGroup != ageGroup) {
					changed ();
				}
				return ageGroup;

	}

	/**
	 * @param ageGroup1 the ageGroup to set
	 */
	public void setAgeGroup (final AgeBracket ageGroup1) {
		ageGroup = ageGroup1;
	}

	/**
	 * Declares this to be an inhuman, ergo ageless, user account.
	 */
	public void setAgeGroupToSystem () {
		ageGroup = AgeBracket.System;
		birthDate = null;
		changed ();
	}

	/**
	 * set the date on which the user's account was approved, to the
	 * current time.
	 */
	public void setApproved () {
		setApprovedDate (new Date (System.currentTimeMillis ()));
	}

	/**
	 * @param date the approvedDate to set
	 */
	public void setApprovedDate (final Date date) {
		approvedDate = date;
		changed ();
	}

	/**
	 * @param avatarClass1 the avatarClass to set
	 */
	public void setAvatarClass (final AvatarClass avatarClass1) {
		avatarClass = avatarClass1;
		changed ();
	}

    /**
     * @param newBaseColor the baseColor to set
     */
	public void setBaseColor (final Colour newBaseColor) {
		baseColour = newBaseColor;
		changed ();
	}

	/**
	 * @param birthDate1 the birthDate to set
	 */
	public void setBirthDate (final Date birthDate1) {
		birthDate = birthDate1;
		setAgeGroup ();
		if (ageGroup == AgeBracket.Teen || ageGroup == AgeBracket.Adult) {
			if (null == approvedDate) {
				approvedDate = new Date (System.currentTimeMillis ());
			}
			canTalk = true;
			canEnterChatZone = true;
			// canEnterMenuZone = true;
		}
		changed ();
	}

	/**
	 * @param canBetaTest1 the canBetaTest to set
	 */
	public void setCanBetaTest (final boolean canBetaTest1) {
		canBetaTest = canBetaTest1;
	}

	/**
	 * set whether the user acquiesces to be contacted
	 *
	 * @param b true, if the user will let us contact him/her
	 */
	public void setCanContact (final boolean b) {
		canContact = b;
		changed ();
	}

	/**
	 * @param newCanEnterChatZone the canEnterChatZone to set
	 */
	public void setCanEnterChatZone (final boolean newCanEnterChatZone) {
		canEnterChatZone = newCanEnterChatZone;
		changed ();
	}

	/**
	 * @param newCanEnterMenuZone the canEnterMenuZone to set
	 */
	public void setCanEnterMenuZone (final boolean newCanEnterMenuZone) {
		canEnterMenuZone = newCanEnterMenuZone;
		changed ();
	}

	/**
	 * @param newCanTalk the canTalk to set
	 */
	public void setCanTalk (final boolean newCanTalk) {
		canTalk = newCanTalk;
		changed ();
	}

	/**
	 * @param newChatBG the chatBG to set
	 */
	public void setChatBG (final Colour newChatBG) {
		chatBG = newChatBG;
		changed ();
	}

	/**
	 * @param newChatFG the chatFG to set
	 */
	public void setChatFG (final Colour newChatFG) {
		chatFG = newChatFG;
		changed ();
	}

	/**
	 * set the user's quantity of currency of a given type
	 *
	 * @param units currency units
	 * @param bigDecimal the amount to set
	 */
	public void setCurrency (final Currency units,
			final BigDecimal bigDecimal) {
		getWallet ().put (units.getCode (), bigDecimal);
		changed ();
	}

	/**
	 * set the user's currency of a given type, only if it is not
	 * already known
	 *
	 * @param units currency units
	 * @param bigDecimal the amount to set
	 */
	public void setCurrencyIfUnknown (final Currency units,
			final BigDecimal bigDecimal) {
		if (null == getWallet ().get (units)) {
			getWallet ().put (units.getCode (), bigDecimal);
		}
		changed ();
	}

	/**
	 * @param emailPlusDate1 the emailPlusDate to set
	 */
	public void setEmailPlusDate (final Date emailPlusDate1) {
		emailPlusDate = emailPlusDate1;
		changed ();
	}

	/**
	 * @param newEphemeral the isEphemeral to set
	 */
	public void setEphemeral (final boolean newEphemeral) {
		isEphemeral = newEphemeral;
		changed ();
	}

	/**
	 * @param newExtraColor the extraColor to set
	 */
	public void setExtraColor (final Colour newExtraColor) {
		extraColour = newExtraColor;
		changed ();
	}

	/**
	 * @param newName the givenName to set
	 */
	public void setGivenName (final String newName) {
		givenName = newName;
		changed ();
	}

	/**
	 * @param kickerID the kickedByUserID to set
	 */
	public void setKickedByUserID (final int kickerID) {
		kickedByUserID = kickerID;
		changed ();
	}

	/**
	 * @param reason the kickedReasonCode to set
	 */
	public void setKickedReasonCode (final String reason) {
		kickedReasonCode = reason;
		changed ();
	}

	/**
	 * @param kickedUntilTime the kickedUntil to set
	 */
	public void setKickedUntil (final Timestamp kickedUntilTime) {
		kickedUntil = kickedUntilTime;
		changed ();
	}

	/**
	 * @param newLanguage the new language
	 * @param newDialect the new dialect
	 */
	public void setLanguage (final String newLanguage,
			final String newDialect) {
		language = newLanguage;
		dialect = newDialect;
		final Thread currentThread = Thread.currentThread ();
		if (currentThread instanceof ServerThread) {
			final ServerThread myThread = (ServerThread) currentThread;
			final GeneralUser threadUser = myThread.getUser ();
			if (null != threadUser
					&& threadUser.getUserID () == getUserID ()) {
				myThread.setLanguage (newLanguage, newDialect);
			}
		}
		changed ();
	}

	/**
	 * @param lastZoneName1 the lastZoneName to set
	 */
	public void setLastZoneName (final String lastZoneName1) {
		lastZoneName = lastZoneName1;
		changed ();
	}

	/**
	 * set the user's login name
	 *
	 * @param newLogin the user's new login name
	 */
	public void setLogin (final String newLogin) {
		login = newLogin;
		if (needsNaming) {
			needsNaming = false;
		}
		changed ();
	}

	/**
	 * @param newMail the mail to set
	 */
	public void setMail (final String newMail) {
		mail = newMail;
		changed ();
	}

	/**
	 * Sets the user capabilities to allow talking, and permits the user
	 * entry into both chat zones and menu-chat-only zones.
	 *
	 * @param mailConfirmed1 the date and time at which the user's mail
	 *            was confirmed.
	 */
	public void setMailConfirmed (final Date mailConfirmed1) {
		mailConfirmed = mailConfirmed1;
		if (null != mailConfirmed1) {
			canTalk = true;
			canEnterChatZone = true;
			canEnterMenuZone = true;
		}
		changed ();
	}

	/**
	 * @param dateConfirmationSent the mailConfirmSent to set
	 */
	public void setMailConfirmSent (final Date dateConfirmationSent) {
		mailConfirmSent = dateConfirmationSent;
		changed ();
	}

	/**
	 * @param when when the confirmation eMail was sent out
	 */
	public void setMailConfirmSent (final long when) {
		mailConfirmSent = new Date (when);
		changed ();
	}

	/**
	 * @param userWhoApproved the nameApprovedByUserID to set
	 */
	public void setNameApprovedByUserID (final int userWhoApproved) {
		nameApprovedByUserID = userWhoApproved;
		changed ();
	}

	/**
	 * @param needsNaming1 the needsNaming to set
	 */
	public void setNeedsNaming (final boolean needsNaming1) {
		needsNaming = needsNaming1;
		changed ();
	}

	/**
	 * @param really true, if this is a notable NPC/character
	 */
	public void setNotable (final boolean really) {
		notable = really;
		changed ();
	}

	/**
	 * @param parentApprovedName1 the parentApprovedName to set
	 */
	public void setParentApprovedName (final boolean parentApprovedName1) {
		parentApprovedName = parentApprovedName1;
		changed ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param id parent id
	 */
	void setParentID (final int id) {
		parentID = id;
		changed ();
	}

	/**
	 * WRITEME WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param newPass WRITEME
	 */
	public void setPassword (final String newPass) {
		password = newPass;
		changed ();
	}

	/**
	 * Set the question & answer pair to be used to trigger forgotten
	 * password recovery
	 *
	 * @param question the question
	 * @param answer the answer
	 */
	public void setPasswordRecovery (final String question,
			final String answer) {
		passRecoveryQ = question;
		passRecoveryA = answer;
		changed ();
	}

	/**
	 * <p>
	 * Set the referrer from whom we were sent this new user. This value
	 * can only be set once, and is permanent for that user. The valid
	 * referrer values are stored in a table. (WRITEME twheys@gmail.com
	 * what table?)
	 * </p>
	 * <p>
	 * Yes, referer is misspelled in homage to HTTP
	 * </p>
	 *
	 * @param theReferer a four-character identifier
	 */
	public void setReferer (final String theReferer) {
		if (null == referer) {
			referer = theReferer;
			changed ();
		}
	}

	/**
	 * @param newRegisteredAt the registeredAt to set
	 */
	public void setRegisteredAt (final Timestamp newRegisteredAt) {
		registeredAt = newRegisteredAt;
		changed ();
	}

	/**
	 * @param requestedName1 the requestedName to set
	 */
	public void setRequestedName (final String requestedName1) {
		requestedName = requestedName1;
		changed ();
	}

	/**
	 * @param staffLevel1 the staffLevel to set
	 */
	public void setStaffLevel (final int staffLevel1) {
		staffLevel = staffLevel1;
		changed ();
	}

	/**
	 * @param travelRate1 the travelRate to set
	 */
	public void setTravelRate (final double travelRate1) {
		travelRate = travelRate1;
		changed ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param rate RATE
	 */
	public void setTravelRatePrivately (final double rate) {
		travelRate = rate;
		// don't call changed()
	}

	/**
	 * @param userID1 the userID to set
	 */
	public void setUserID (final int userID1) {
		userID = userID1;
	}

    /**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final String displayName = getDisplayName ();
		if (null != displayName) {
			return displayName;
		}
		return super.toString ();
	}
}
