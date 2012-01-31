/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.mb;

import java.io.IOException;
import java.io.Serializable;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.EnumMap;
import java.util.EnumSet;
import java.util.Enumeration;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.CredentialExpiredException;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.mb.fields.MBField;
import org.starhope.appius.mb.fields.MBFieldIdent;
import org.starhope.appius.mb.fields.MBField_Boolean;
import org.starhope.appius.mb.fields.MBField_Boolean_True;
import org.starhope.appius.mb.fields.MBField_Calendar;
import org.starhope.appius.mb.fields.MBField_Child;
import org.starhope.appius.mb.fields.MBField_DataRecord;
import org.starhope.appius.mb.fields.MBField_DateOfBirth;
import org.starhope.appius.mb.fields.MBField_LoginRequest;
import org.starhope.appius.mb.fields.MBField_Mail;
import org.starhope.appius.mb.fields.MBField_Password;
import org.starhope.appius.mb.fields.MBField_Payment;
import org.starhope.appius.mb.fields.MBField_String;
import org.starhope.appius.pay.util.CredentialType;
import org.starhope.appius.pay.util.PaymentCredential;
import org.starhope.appius.pay.util.PaymentGatewayReal;
import org.starhope.appius.pay.util.RetryPaymentException;
import org.starhope.appius.pay.util.UnsupportedCredentialException;
import org.starhope.appius.pay.util.UnsupportedCurrencyException;
import org.starhope.appius.types.AgeBracket;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.AvatarClass;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.Parent;
import org.starhope.appius.user.User;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;
import org.starhope.util.types.Pair;

/**
 * This is the session data collected from an arbitrary front-end system
 * (e.g. typical web-browser front-end system) performing some actions
 * involving the user's Membership & Billing records. This is typically
 * associated with a web browser session cookie in a fairly transparent
 * way.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class MBSession implements Serializable {
	/**
	 * hook to run before the engine hits a page
	 */
	private static BeforePageHook beforePageHook = null;
	
	/**
	 * fields that require double-entry confirmation in the UI
	 */
	private static final EnumMap <MBFieldIdent, Set <String>> fieldsMapConfirm = new EnumMap <MBFieldIdent, Set <String>> (
			MBFieldIdent.class);
	
	/**
	 * Mapping input fields to MBFieldIdent tokens
	 */
	private static final EnumMap <MBFieldIdent, Set <String>> fieldsMapInput = new EnumMap <MBFieldIdent, Set <String>> (
			MBFieldIdent.class);
	
	/**
	 * Sessions managed by session identifiers. Web servlets don't use
	 * this.
	 */
	private static Map <String, MBSession> identifiedSessions = new ConcurrentHashMap <String, MBSession> ();
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (MBSession.class);
	
	/**
	 * A collection of hooks to run during parameter processing
	 */
	private static final Set <MBParamTranslator> paramTranslators = new HashSet <MBParamTranslator> ();
	
	/**
	 * Hooks to run after successful parent registrations
	 */
	private static final Set <PostParentRegistrationHook> postParentRegistrationHooks = new HashSet <PostParentRegistrationHook> ();
	/**
	 * Hooks to run after enrolment payments are received.
	 */
	private static final Set <PostPaymentHook> postPaymentHooks = new HashSet <PostPaymentHook> ();
	/**
	 * Hooks to run after successful user registrations
	 */
	private static final Set <PostUserRegistrationHook> postUserRegistrationHooks = new HashSet <PostUserRegistrationHook> ();
	/**
	 * For debugging/tracking purposes, assign unique serial numbers to
	 * each session originated.
	 */
	private final static AtomicInteger serial = new AtomicInteger ();
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -6635727759761934756L;
	
	/**
	 * A mapping of URL:s to the fields that they are expected to
	 * set/provide
	 */
	private static Map <String, EnumSet <MBFieldIdent>> urls = new LinkedHashMap <String, EnumSet <MBFieldIdent>> ();
	
	/**
	 * @param translator A facility that may be able to translate
	 *             “unusual” fields submitted by forms into types that
	 *             can be understood by MBSession
	 */
	public static void addParamTranslator (
			final MBParamTranslator translator) {
		MBSession.paramTranslators.add (translator);
	}
	
	/**
	 * @param hook A hook to be run after receiving an enrolment
	 *             payment. The interface provides different methods to
	 *             easily handle various cases.
	 */
	public static void addPostEnrolmentHook (final PostPaymentHook hook) {
		MBSession.postPaymentHooks.add (hook);
	}
	
	/**
	 * @param hook a hook to run after registering a new parent
	 *             successfully
	 */
	public static void addPostParentRegistrationHook (
			final PostParentRegistrationHook hook) {
		MBSession.postParentRegistrationHooks.add (hook);
	}
	
	/**
	 * @param hook a hook to run after registering a new user
	 *             successfully
	 */
	public static void addPostUserRegistrationHook (
			final PostUserRegistrationHook hook) {
		MBSession.postUserRegistrationHooks.add (hook);
	}
	
	/**
	 * Expire (by removing from #identifiedSessions) any session
	 * objects which have not been used since a certain time
	 * 
	 * @param beforeTime The time before which sessions should be
	 *             removed.
	 */
	public static synchronized void expireSessions (
			final long beforeTime) {
		for (final Map.Entry <String, MBSession> session : MBSession.identifiedSessions
				.entrySet ()) {
			if (session.getValue ().lastUsed < beforeTime) {
				MBSession.identifiedSessions.remove (session
						.getKey ());
			}
		}
	}
	
	/**
	 * Finds an existing, or creates a new, MBSession object identified
	 * by the session identifier provided. It is the responsibility of
	 * the caller to ensure globally-unique session identifiers are
	 * provided by each class implementing HasSessionIdentifier.
	 * 
	 * @param session the session identifier object
	 * @return an MBSession uniquely associated with that session
	 */
	public synchronized static MBSession get (
			final HasSessionIdentifier session) {
		final String sessionIdent = session.getClass ()
				.getCanonicalName ()
				+ (char) 0x1f
				+ session.getSessionIdent ();
		MBSession sess = MBSession.identifiedSessions
				.get (sessionIdent);
		if (null == sess) {
			sess = new MBSession ();
			MBSession.identifiedSessions.put (sessionIdent, sess);
		}
		sess.setLatestSource (sessionIdent);
		sess.touch ();
		return sess;
	}
	
	/**
	 * Convenience method for JSP's
	 * 
	 * @param request Servlet request object
	 * @return MBSession gotten from the associated {@link HttpSession}
	 *         by {@link #get(HttpSession)}
	 */
	public static MBSession get (final HttpServletRequest request) {
		return MBSession.get (request.getSession ());
	}
	
	/**
	 * Extract the {@link MBSession} from the {@link HttpSession}
	 * 
	 * @param httpSession the {@link HttpSession} with the
	 *             {@link MBSession} stored in it
	 * @return the stored (or a new) {@link MBSession}
	 */
	public static MBSession get (final HttpSession httpSession) {
		MBSession session = (MBSession) httpSession
				.getAttribute ("mb");
		if (null == session) {
			session = new MBSession ();
			httpSession.setAttribute ("mb", session);
		}
		session.setLatestSource (httpSession.getId ());
		session.touch ();
		return session;
	}
	
	/**
	 * @param ident the M&B Field identifier
	 * @param fieldNames the names of input confirmation fields from
	 *             the {@link ServletRequest}
	 */
	public static void mapConfirmField (final MBFieldIdent ident,
			final Set <String> fieldNames) {
		MBSession.fieldsMapConfirm.put (ident, fieldNames);
	}
	
	/**
	 * @param ident the M&B Field identifier
	 * @param fieldName the name of one input confirmation field from
	 *             the {@link HttpParams}
	 */
	public static void mapConfirmField (final MBFieldIdent ident,
			final String fieldName) {
		final HashSet <String> set = new HashSet <String> ();
		set.add (fieldName);
		MBSession.mapConfirmField (ident, set);
	}
	
	/**
	 * @param ident the M&B Field identifier
	 * @param fieldNames the names of input fields from the
	 *             {@link HttpParams}
	 */
	public static void mapField (final MBFieldIdent ident,
			final Set <String> fieldNames) {
		final Set <String> was = MBSession.fieldsMapInput.get (ident);
		if (null == was) {
			MBSession.fieldsMapInput.put (ident, fieldNames);
		} else {
			was.addAll (fieldNames);
		}
	}
	
	/**
	 * @param ident the M&B Field identifier
	 * @param fieldName the name of one input field from the
	 *             {@link HttpParams}
	 */
	public static void mapField (final MBFieldIdent ident,
			final String fieldName) {
		final HashSet <String> set = new HashSet <String> ();
		set.add (fieldName);
		MBSession.mapField (ident, set);
	}
	
	/**
	 * Identify an URL which can be used to ask for a certain set of
	 * fields.
	 * 
	 * @param fields fields presented at that URL
	 * @param url the URL
	 */
	public static void provideURL (
			final Collection <MBFieldIdent> fields, final String url) {
		MBSession.urls.put (url, EnumSet.copyOf (fields));
	}
	
	/**
	 * Identify an URL which can be used to ask for a certain set of
	 * fields.
	 * 
	 * @param fields fields presented at that URL
	 * @param url the URL
	 */
	public static void provideURL (final MBFieldIdent [] fields,
			final String url) {
		final List <MBFieldIdent> fieldList = new LinkedList <MBFieldIdent> ();
		for (final MBFieldIdent field : fields) {
			fieldList.add (field);
		}
		MBSession.provideURL (fieldList, url);
	}
	
	/**
	 * @param newHook {@link #beforePage(PageContext)} hook for
	 *             {@link #beforePageHook} (singular)
	 */
	public static void setBeforePageHook (final BeforePageHook newHook) {
		MBSession.beforePageHook = newHook;
	}
	
	/**
	 * Strip the “index.jsp” and/or trailing “/” off a URI to get a
	 * normalised form for index pages
	 * 
	 * @param uri The URI to be stripped
	 * @return The original URI, less any final “/index.jsp” or “/”
	 */
	public static String stripIndex (final String uri) {
		if (uri.endsWith ("/index.jsp")) {
			return uri.substring (0,
					uri.length () - "/index.jsp".length ());
		}
		if (uri.endsWith ("/")) {
			return uri.substring (0, uri.length () - 1);
		}
		return uri;
	}
	
	/**
	 * Street address (first line)
	 */
	public final MBField_String address1 = new MBField_String (this,
			MBFieldIdent.ADDRESS);
	/**
	 * Street address (second line)
	 */
	public final MBField_String address2 = new MBField_String (this,
			MBFieldIdent.ADDRESS2);
	/**
	 * Buyer's family name / surname
	 */
	public final MBField_String buyerFamilyName = new MBField_String (
			this, MBFieldIdent.BUYER_FAMILY_NAME);
	/**
	 * Buyer's given name
	 */
	public final MBField_String buyerGivenName = new MBField_String (
			this, MBFieldIdent.BUYER_GIVEN_NAME);
	/**
	 * Permission to contact the user
	 */
	public final MBField_Boolean canContact = new MBField_Boolean (
			this, MBFieldIdent.CAN_CONTACT);
	/**
	 * The character class of which the player wants to be enrolled —
	 * for Tootsville, this is one of the Original Eight Toots, for a
	 * D&D game, it might be more like “Rogue” or something
	 */
	public final MBField_DataRecord <AvatarClass> characterClass = new MBField_DataRecord <AvatarClass> (
			AvatarClass.class, this, MBFieldIdent.CHARACTER_CLASS);
	/**
	 * The child currently selected by a parent
	 */
	public final MBField_Child child = new MBField_Child (this,
			MBFieldIdent.CHILD);
	/**
	 * City/town/village/&c
	 */
	public final MBField_String city = new MBField_String (this,
			MBFieldIdent.CITY);
	/**
	 * country
	 */
	public final MBField_String country = new MBField_String (this,
			MBFieldIdent.COUNTRY);
	/**
	 * Credit-Card confirmation code, aka CVC, CCV, and a million other
	 * names. The confirmation code off the back of the card.
	 */
	public final MBField_NumericString creditCardCode = new MBField_NumericString (
			this, MBFieldIdent.CC_CODE, 3, 3);
	
	/**
	 * expiry date (month and year only are significant)
	 */
	public final MBField_Calendar creditCardExpiry = new MBField_Calendar (
			this, MBFieldIdent.CC_EXPIRY);
	/**
	 * Credit-card number
	 */
	public final MBField_CreditCardNumber creditCardNumber = new MBField_CreditCardNumber (
			this, MBFieldIdent.CC_NUMBER);
	
	/**
	 * Credit-card type string, “visa” or “mastercard” ( XXX: change to
	 * enumerated type. )
	 */
	public final MBField_String creditCardType = new MBField_String (
			this, MBFieldIdent.CC_TYPE);
	/**
	 * New user registering, date of birth
	 */
	public final MBField_DateOfBirth dateOfBirth = new MBField_DateOfBirth (
			this, MBFieldIdent.DATE_OF_BIRTH_GIVEN);
	/**
	 * Enrolment type chosen
	 */
	public final MBField_DataRecord <Enrolment> enrolmentChosen = new MBField_DataRecord <Enrolment> (
			Enrolment.class, this, MBFieldIdent.ENROLMENT_CHOSEN);
	
	/**
	 * Collection of errors that require user intervention to correct
	 */
	private final EnumMap <MBFieldIdent, EnumSet <MBErrorReason>> errors = new EnumMap <MBFieldIdent, EnumSet <MBErrorReason>> (
			MBFieldIdent.class);
	
	/**
	 * Error message toasts
	 */
	private final Set <String> errorToasts = new HashSet <String> ();
	
	/**
	 * extra params set for local use
	 */
	private final Map <String, String> extraParams = new HashMap <String, String> ();
	
	/**
	 * Forgotten password recovery question's answer
	 */
	public final MBField_String forgotPasswordA = new MBField_String (
			this, MBFieldIdent.FORGOT_PASSWORD_ANSWER);
	
	/**
	 * Forgotten password recovery question
	 */
	public final MBField_String forgotPasswordQ = new MBField_String (
			this, MBFieldIdent.FORGOT_PASSWORD_QUESTION);
	
	/**
	 * User's self-identified given name (optional)
	 */
	public final MBField_String givenName = new MBField_String (this,
			MBFieldIdent.GIVEN_NAME);
	
	/**
	 * Goals that the user is trying to acheive
	 */
	EnumSet <MBGoal> goals = EnumSet.noneOf (MBGoal.class);
	
	/**
	 * previous page viewed
	 */
	private String lastPage = "~";
	
	/**
	 * The time at which this session was last used.
	 */
	private long lastUsed = System.currentTimeMillis ();
	
	/**
	 * current page being viewed
	 */
	private String latestPage = "~";
	
	/**
	 * The latest place from which the user accessed this session.
	 */
	String latestSource = "¿?";
	
	/**
	 * Login, being entered for authentication purposes
	 */
	public final MBField_String loginAuth = new MBField_String (this,
			MBFieldIdent.LOGIN_AUTH);
	
	/**
	 * Login, being requested for new registration or rename
	 */
	public final MBField_LoginRequest loginRequested = new MBField_LoginRequest (
			this, MBFieldIdent.LOGIN_REQUESTED);
	
	/**
	 * Parent logins
	 */
	public final MBField_Mail mailAuth = new MBField_Mail (this,
			MBFieldIdent.MAIL_AUTH);
	
	/**
	 * User's mail, maybe for registration, maybe for parent login
	 */
	public final MBField_Mail mailProvided = new MBField_Mail (this,
			MBFieldIdent.MAIL_PROVIDED);
	
	/**
	 * Local session unique serial number for debugging tracing
	 */
	private final int mySerial;
	/**
	 * Password, being provided for authentication purposes
	 */
	public final MBField_Password passwordAuth = new MBField_Password (
			this, MBFieldIdent.PASSWORD_AUTH);
	/**
	 * Password, being requested for new registration or
	 * password-change
	 */
	public final MBField_Password passwordRequested = new MBField_Password (
			this, MBFieldIdent.PASSWORD_REQUESTED);
	/**
	 * Payment being constructed
	 */
	public final MBField_Payment payment = new MBField_Payment (this,
			MBFieldIdent.PAYMENT_CREDENTIALS);
	/**
	 * phone number
	 */
	public final MBField_String phone = new MBField_String (this,
			MBFieldIdent.PHONE);
	/**
	 * postal code / ZIP code
	 */
	public final MBField_String postalCode = new MBField_String (this,
			MBFieldIdent.POSTAL_CODE);
	/**
	 * Code from a prepaid card or promotion
	 */
	public final MBField_String prepaidCode = new MBField_String (
			this, MBFieldIdent.PREPAID_CODE); // XXX DataRecord
	
	/**
	 * State/province/locality/county/whatever
	 */
	public final MBField_String province = new MBField_String (this,
			MBFieldIdent.PROVINCE);
	
	/**
	 * Agree to some rules other than the T&C
	 */
	public final MBField_Boolean_True rulesAgree = new MBField_Boolean_True (
			this, MBFieldIdent.RULES_AGREE);
	
	/**
	 * a cookie identifying the referral source for the user coming in
	 */
	private String sourceCookie = null;
	
	/**
	 * User agreeing to terms and conditions
	 */
	public final MBField_Boolean_True termsConditionsAgree = new MBField_Boolean_True (
			this, MBFieldIdent.TERMS_CONDITIONS_AGREE);
	
	/**
	 * Toasts
	 */
	private final Map <String, String> toasts = new HashMap <String, String> ();
	
	/**
	 * the parent who is visiting the site (if one, see
	 * {@link #visitorRole})
	 */
	private Parent visitorAsParent = null;
	
	/**
	 * the user who is visiting the site (if one, see
	 * {@link #visitorAsUser})
	 */
	private User visitorAsUser = null;
	
	/**
	 * whether the current visitor to the site is acting for themself,
	 * or is a parent
	 */
	private org.starhope.appius.mb.VisitorRole visitorRole = VisitorRole.unknown;
	
	/**
	 * basic ctor
	 */
	public MBSession () {
		mySerial = MBSession.serial.incrementAndGet ();
	}
	
	/**
	 * See if any goals can be fulfilled. (Note: the underscore isn't
	 * some kind of dumb “don't mess with me” marker or anything: it's
	 * just so this very important dispatcher routine alphabetises to
	 * the top in Eclipse. ~BRP)
	 */
	private void _fulfillGoals () {
		clearErrors ();
		for (final MBGoal goal : goals) {
			MBSession.log.debug ("Let's see if we can "
					+ goal.toString ());
			switch (goal) {
			case CHANGE_PASSWORD:
				changePassword ();
				break;
			case LOG_IN_AS_PARENT:
				logInParent ();
				break;
			case LOG_IN_SELF:
				logInSelf ();
				break;
			case PAY_ACCOUNT:
				payAccount ();
				break;
			case REGISTER_USER:
				registerUser ();
				break;
			case PLAY_NOW:
				playNow ();
				break;
			case REGISTER_SELF_PARENT:
				registerParent ();
				break;
			case CHOOSE_ACCOUNT_TO_PAY:
				chooseAccountToPay ();
				break;
			case SET_RESPONSIBLE_MAIL:
				setResponsibleMail ();
				break;
			case MY_ACCOUNT:
				// no op
				break;
			}
		}
	}
	
	/**
	 * Set any fields who find associated parameters, to their
	 * associated values.
	 * 
	 * @param params parameters provided by Tomcat (&c.)
	 */
	@SuppressWarnings ("unchecked")
	public void acceptInput (final ServletRequest params) {
		final Enumeration <String> allInputs = params
				.getParameterNames ();
		final Set <String> inputs = new HashSet <String> ();
		while (allInputs.hasMoreElements ()) {
			final String s = allInputs.nextElement ();
			inputs.add (s);
			MBSession.log.debug ("Param received: " + s);
		}
		
		// XXX: duplicates code in #getField(MBFieldIdent)
		
		// This whole stanza is to find the fields correctly!
		
		for (final java.lang.reflect.Field f : getClass ()
				.getFields ()) {
			final Class <?> klass;
			try {
				klass = f.getType ();
				if ( !MBField.class.isAssignableFrom (klass)) {
					continue;
				}
			} catch (final Exception e2) {
				continue;
			}
			MBField <?> field;
			try {
				field = (MBField <?>) f.get (this);
				if (null == field) {
					MBSession.log.error ("Uninitialised field: "
							+ f.getType ().getCanonicalName ()
							+ " "
							+ f.getDeclaringClass ()
									.getCanonicalName () + "."
							+ f.getName () + " == null");
					continue;
				}
			} catch (final Exception e1) {
				MBSession.log
						.error ("Caught a IllegalArgumentException in MBSession.acceptInput ",
								e1);
				continue;
			}
			
			// Figure out if we have a value
			
			Object newValue = null;
			final MBFieldIdent fieldIdent = field.getIdent ();
			Set <String> fieldSet = MBSession.fieldsMapInput
					.get (fieldIdent);
			if ( (null == fieldSet) || (fieldSet.size () == 0)) {
				// AppiusClaudiusCaecus
				// .blather
				// ("Warning, no fields defined for MBFieldIdent."
				// + fieldIdent.toString ());
				MBSession.mapField (fieldIdent, LibMisc
						.toJavaCase (fieldIdent.toString ()));
				fieldSet = MBSession.fieldsMapInput
						.get (fieldIdent);
				continue;
			}
			for (final String fieldName : fieldSet) {
				inputs.remove (fieldName);
				final Object parameter = params
						.getParameter (fieldName);
				if (null != parameter) {
					newValue = parameter;
				}
			}
			// Does the field define a confirmation field? Check that
			final Set <String> confirms = MBSession.fieldsMapConfirm
					.get (fieldIdent);
			if ( (null != newValue) && (null != confirms)) {
				Object confirmValue = null;
				for (final String fieldName : confirms) {
					inputs.remove (fieldName);
					final Object confirm = params
							.getParameter (fieldName);
					if (null != confirm) {
						confirmValue = confirm;
					}
				}
				if (null != confirmValue) {
					try {
						if ( !field.convert (newValue).equals (
								field.convert (confirmValue))) {
							add (field.getIdent (),
									MBErrorReason.CONFIRM);
							continue;
						}
					} catch (final DataException e) {
						add (field.getIdent (),
								MBErrorReason.INCORRECT);
						continue;
					}
				}
			}
			
			// Still with me? Let's set the value.
			set (fieldIdent, field, newValue);
		}
		
		for (final MBParamTranslator translator : MBSession.paramTranslators) {
			translator.translateParameters (this, params);
		}
		
		for (final String field : inputs) {
			MBSession.log.debug ("Non-input field: " + field);
		}
		
	}
	
	/**
	 * Add an error to the session — indicate that there's a problem
	 * with one of the data fields for the current session record, and
	 * the reason why.
	 * 
	 * @param field the field affected by the error
	 * @param reason what type of error
	 */
	public void add (final MBFieldIdent field,
			final MBErrorReason reason) {
		EnumSet <MBErrorReason> set = errors.get (field);
		if (null == set) {
			set = EnumSet.of (reason);
			errors.put (field, set);
		} else {
			set.add (reason);
		}
		
		if ( (field == MBFieldIdent.MAIL_PROVIDED)
				&& (reason == MBErrorReason.INCORRECT)) {
			MBSession.log.debug ("bad mail?");
		}
		
		MBSession.log.debug ("add error " + field.toString () + "/"
				+ reason.toString () + " @" + toString ());
	}
	
	/**
	 * @param goal a (possibly new) goal that the user wants to achieve
	 * @return whether the goal was new (false, if we already knew they
	 *         wanted to do that)
	 */
	public boolean add (final MBGoal goal) {
		final boolean b = goals.add (goal);
		MBSession.log.debug ("add goal to " + toString ());
		return b;
	}
	
	/**
	 * @param text a new error message toast
	 */
	public void addErrorToast (final String text) {
		errorToasts.add (text);
	}
	
	/**
	 * Add a “toast” message — a minor note to the user that something
	 * (in this case, presumably something good) has happened, that
	 * isn't significant enough to really interrupt them.
	 * 
	 * @param id An arbitrary unique ID. Only one toast with a given ID
	 *             will be displayed at once. This code is used
	 *             exclusively for duplicate-suppression.
	 * @param message The user-visible message to be displayed.
	 */
	public void addToast (final String id, final String message) {
		toasts.put (id, message);
	}
	
	/**
	 * Do stuff before starting on the page
	 * 
	 * @param context page context
	 */
	public void beforePage (final PageContext context) {
		lastPage = latestPage;
		latestPage = MBSession
				.stripIndex ( ((HttpServletRequest) context
						.getRequest ()).getRequestURI ());
		if (null != MBSession.beforePageHook) {
			MBSession.beforePageHook.beforePage (this, context);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private void changePassword () {
		passwordRequested.check ();
		checkForActiveMember ();
		if (hasErrors ()) {
			return;
		}
		getTargetMember ()
				.setPassword (passwordRequested.getValue ());
		addToast ("password",
				String.format (
						LibMisc.getTextOrDefault (
								"mb.changePassword.ok",
								"The password for “%s” has been changed."),
						getTargetMember ().getLogin ()));
		remove (MBGoal.CHANGE_PASSWORD);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private void checkForActiveMember () {
		if (null != visitorAsUser) {
			return;
		}
		if (null != visitorAsParent) {
			if (null != getTargetMember ()) {
				return;
			}
			if ( !getTargetMember ().getParent ().equals (
					visitorAsParent)) {
				add (MBFieldIdent.CHILD, MBErrorReason.INCORRECT);
			}
		}
		add (MBFieldIdent.LOGIN_AUTH, MBErrorReason.BLANK);
	}
	
	/**
	 * Choose an account for which to pay
	 */
	private void chooseAccountToPay () {
		if (null != getTargetMember ()) {
			remove (MBGoal.CHOOSE_ACCOUNT_TO_PAY);
			return;
		}
		
		switch (visitorRole) {
		case parent:
			child.check ();
			add (MBFieldIdent.CHILD, MBErrorReason.BLANK);
			break;
		case self:
			// Impossible!
			MBSession.log
					.error ("It's me, silly. Something's wrong with getTargetMember");
			remove (MBGoal.CHOOSE_ACCOUNT_TO_PAY);
			return;
		case unknown:
			add (MBFieldIdent.WHO_ARE_YOU, MBErrorReason.BLANK);
			return;
		}
	}
	
	/**
	 * Clear the enqueued errors set
	 */
	public void clearErrors () {
		errors.clear ();
	}
	
	/**
	 * clear all errors
	 * 
	 * @param field the field
	 */
	public void clearErrorsFor (final MBFieldIdent field) {
		errors.remove (field);
	}
	
	/**
	 * Forget (log out) the user. Other cachéd values are remembered.
	 */
	public void forgetVisitor () {
		visitorRole = VisitorRole.unknown;
		visitorAsParent = null;
		visitorAsUser = null;
	}
	
	/**
	 * @return The best page to go, next.
	 */
	public String getBestNextURI () {
		int mostFields = 0;
		int wrongFields = 0;
		String bestSoFar = null;
		
		final Set <MBFieldIdent> wantFields = errors.keySet ();
		if (getGoals ().size () == 1) {
			if (getGoals ().contains (MBGoal.PLAY_NOW)) {
				remove (MBGoal.PLAY_NOW);
				return "http://www.tootsville.com/playnow";
				// / XXX Tootsville
			}
			if (getGoals ().contains (MBGoal.MY_ACCOUNT)) {
				try {
					remove (MBGoal.MY_ACCOUNT);
					return AppiusConfig
							.getConfig ("com.tootsville.members.url")
							+ "/"
							+ (getVisitorRole () == VisitorRole.self ? "my-account"
									: "parent");
				} catch (final NotFoundException e) {
					MBSession.log.error ("Exception", e);
				}
				// / XXX Tootsville
			}
			
		}
		if (0 == wantFields.size ()) {
			MBSession.log
					.debug ("User has no pending actions, let's go to the menu");
			switch (getVisitorRole ()) {
			case parent:
				return "/membership/parent";
			case self:
				if (goals.contains (MBGoal.PLAY_NOW)) {
					remove (MBGoal.PLAY_NOW);
					return "http://www.tootsville.com/playnow";
					
				}
				return "/membership/my-account";
			default:
				return "/membership";
			}
		}
		
		for (final Map.Entry <String, EnumSet <MBFieldIdent>> page : MBSession.urls
				.entrySet ()) {
			final Set <MBFieldIdent> pageFields = page.getValue ();
			int wanted = 0;
			int wrong = 0;
			
			/*
			 * Perfect fit? Do it.
			 */
			if (wantFields.containsAll (pageFields)
					&& pageFields.containsAll (wantFields)) {
				return page.getKey ();
			}
			
			for (final MBFieldIdent field : pageFields) {
				if (wantFields.contains (field)) {
					++wanted;
				} else {
					++wrong;
				}
			}
			
			if ( (wanted > mostFields)
					|| ( (wanted == mostFields) && (wrong < wrongFields))) {
				mostFields = wanted;
				wrongFields = wrong;
				bestSoFar = page.getKey ();
			}
		}
		
		if (null == bestSoFar) {
			MBSession.log
					.error ("Cannot find any page to satisfy wanted fields!");
		}
		
		return bestSoFar;
	}
	
	/**
	 * @return get all errors reported, without disturbing them.
	 */
	public Map <MBFieldIdent, EnumSet <MBErrorReason>> getErrors () {
		final EnumMap <MBFieldIdent, EnumSet <MBErrorReason>> copy = new EnumMap <MBFieldIdent, EnumSet <MBErrorReason>> (
				MBFieldIdent.class);
		copy.putAll (errors);
		return copy;
	}
	
	/**
	 * @return get all errors reported, without disturbing them.
	 */
	public Map <MBFieldIdent, EnumSet <MBErrorReason>> getErrorsAndClear () {
		final Map <MBFieldIdent, EnumSet <MBErrorReason>> copy = getErrors ();
		errors.clear ();
		return copy;
	}
	
	/**
	 * <p>
	 * This gets all errors, whether associated with a particular field
	 * or not, and returns them for toasts and tool tips and such.
	 * Toasts are returned with a null field entry.
	 * </p>
	 * <p>
	 * This is <em>not</em> a Map, because one field could have
	 * multiple errors associated with it. However, the EnumSet
	 * implementation in the back end will ensure that a single error,
	 * even if detected multiple times, will only be reported once per
	 * field.
	 * </p>
	 * <p>
	 * Both field-associated error codes and general toasts are
	 * cleared.
	 * </p>
	 * 
	 * @return All errors known to date.
	 */
	public Set <org.starhope.util.types.Pair <MBFieldIdent, String>> getErrorToastsAndClear () {
		final java.util.Set <org.starhope.util.types.Pair <MBFieldIdent, String>> strings = new HashSet <org.starhope.util.types.Pair <MBFieldIdent, String>> ();
		for (final Map.Entry <MBFieldIdent, EnumSet <MBErrorReason>> error : getErrorsAndClear ()
				.entrySet ()) {
			final MBFieldIdent field = error.getKey ();
			for (final MBErrorReason reason : error.getValue ()) {
				strings.add (new org.starhope.util.types.Pair <MBFieldIdent, String> (
						field, reason.getErrorMessage (field)));
			}
		}
		for (final String toast : errorToasts) {
			strings.add (new Pair <MBFieldIdent, String> (null,
					toast));
		}
		errorToasts.clear ();
		return strings;
	}
	
	/**
	 * Store an extra param
	 * 
	 * @param key dotted-notation unique ID, e.g.
	 *             com.tootsville.peanutCode
	 * @return value saved in this session
	 */
	public String getExtraParam (final String key) {
		return extraParams.get (key);
	}
	
	/**
	 * Find a field in the session that handles the given ident
	 * 
	 * @param ident the {@link MBFieldIdent}
	 * @return the {@link MBField <>} in this session handling it
	 */
	public MBField <?> getField (final MBFieldIdent ident) {
		
		// / XXX: duplicated code in #acceptInput
		
		for (final java.lang.reflect.Field f : getClass ()
				.getFields ()) {
			final Class <?> klass;
			try {
				klass = f.getType ();
				if ( !MBField.class.isAssignableFrom (klass)) {
					continue;
				}
			} catch (final Exception e2) {
				continue;
			}
			MBField <?> field;
			try {
				field = (MBField <?>) f.get (this);
				if (null == field) {
					MBSession.log.error ("Uninitialised field: "
							+ f.getType ().getCanonicalName ()
							+ " "
							+ f.getDeclaringClass ()
									.getCanonicalName () + "."
							+ f.getName () + " == null");
					continue;
				}
			} catch (final Exception e1) {
				MBSession.log
						.error ("Caught a IllegalArgumentException in MBSession.acceptInput ",
								e1);
				continue;
			}
			
			if (field.getIdent () == ident) {
				return field;
			}
		}
		MBSession.log.error ("Can't find a field for "
				+ ident.toString ());
		return null;
	}
	
	/**
	 * @return the set of fields which have errors before the goal(s)
	 *         can be reached. Does not clear any existing error codes,
	 *         so this includes stuff we tried to process recently
	 *         (since the error stack was cleared) as well as anything
	 *         that might happen to be failing validation for one of
	 *         the expressed goals.
	 */
	public Set <MBFieldIdent> getFieldsNeeded () {
		_fulfillGoals ();
		return errors.keySet ();
	}
	
	/**
	 * @param requestURI the page
	 * @return all fields expected to be found on that page
	 */
	public Set <MBFieldIdent> getFieldsOn (final String requestURI) {
		final Set <MBFieldIdent> toReturn = new HashSet <MBFieldIdent> ();
		final EnumSet <MBFieldIdent> stuff = MBSession.urls
				.get (MBSession.stripIndex (requestURI));
		if (null != stuff) {
			toReturn.addAll (stuff);
		}
		return toReturn;
	}
	
	/**
	 * @return the answer to the forgotten password question c.v.
	 *         {@link #getForgotPasswordQuestion()}
	 */
	public String getForgotPasswordAnswer () {
		return forgotPasswordA.getValue ();
	}
	
	/**
	 * @return the question for forgotten password recovery, c.v.
	 *         {@link #getForgotPasswordAnswer()}
	 */
	public String getForgotPasswordQuestion () {
		return forgotPasswordQ.getValue ();
	}
	
	/**
	 * @return the goals that we think the user wants to acheive
	 */
	public Set <MBGoal> getGoals () {
		return goals;
	}
	
	/**
	 * @return the URI of the PRIOR page
	 */
	public String getLastURI () {
		return lastPage;
	}
	
	/**
	 * @return the latestSource
	 */
	public String getLatestSource () {
		return latestSource;
	}
	
	/**
	 * @return mail provided
	 * @deprecated {@link #mailProvided}
	 */
	@Deprecated
	public String getMail () {
		return mailProvided.getValue ();
	}
	
	/**
	 * @return password requested
	 * @deprecated {@link #passwordRequested}
	 */
	@Deprecated
	public String getPasswordRequested () {
		return passwordRequested.getValue ();
	}
	
	/**
	 * @return WRITEME payment object
	 */
	public Payment getPayment () {
		if (null == payment.getValue ()) {
			payment.setValue (new Payment ());
		}
		return payment.getValue ();
	}
	
	/**
	 * Historically was "ibc" — prepaid card identification string of
	 * some kind
	 * 
	 * @return prepaid card cookie
	 */
	public String getPrepaidCookie () {
		return prepaidCode.getValue ();
	}
	
	/**
	 * @return WRITEME
	 * @deprecated {@link #loginRequested}
	 */
	@Deprecated
	public String getRequestedUserName () {
		return loginRequested.getValue ();
	}
	
	/**
	 * Get the referral source for this user landing
	 * 
	 * @return referral source cookie string
	 */
	public String getSource () {
		return sourceCookie;
	}
	
	/**
	 * @return the member being targeted for change password, payment,
	 *         cancel account, and so forth.
	 */
	private User getTargetMember () {
		return visitorRole == VisitorRole.self ? visitorAsUser
				: child.getValue ();
	}
	
	/**
	 * Get the toasts, and clear them. (Remove them all)
	 * 
	 * @return The toasts
	 */
	public List <String> getToastsAndClear () {
		final LinkedList <String> returnToasts = new LinkedList <String> ();
		returnToasts.addAll (toasts.values ());
		toasts.clear ();
		return returnToasts;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 * @throws NotFoundException if the visitor isn't known to be a
	 *              parent
	 */
	public Parent getVisitorAsParent () throws NotFoundException {
		if (null == visitorAsParent) {
			throw new NotFoundException (
					"no parent as visitor in this session");
		}
		return visitorAsParent;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 * @throws NotFoundException WRITEME
	 */
	public User getVisitorAsUser () throws NotFoundException {
		if (null == visitorAsUser) {
			throw new NotFoundException ("visitor is not an user");
		}
		return visitorAsUser;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public VisitorRole getVisitorRole () {
		return visitorRole;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public boolean hasAgreedToTerms () {
		return termsConditionsAgree.getValue ().booleanValue ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param really WRITEME
	 * @return WRITEME
	 */
	public boolean hasAgreedToTerms (final boolean really) {
		return termsConditionsAgree.setValue (
				Boolean.valueOf (really)).booleanValue ();
	}
	
	/**
	 * @return true, if there are errors to report.
	 */
	public boolean hasErrors () {
		return errors.size () > 0;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private void logInParent () {
		if (null != visitorAsParent) {
			remove (MBGoal.LOG_IN_AS_PARENT);
			return;
		}
		mailAuth.check ();
		passwordAuth.check ();
		if (hasErrors ()) {
			return;
		}
		
		final Parent p;
		try {
			p = Nomenclator.getDataRecord (Parent.class,
					mailAuth.getValue ());
		} catch (final NotFoundException e) {
			add (MBFieldIdent.MAIL_AUTH, MBErrorReason.INCORRECT);
			return;
		}
		final boolean ok = p.checkPassword (passwordAuth.getValue ());
		if ( !ok) {
			add (MBFieldIdent.PASSWORD_AUTH, MBErrorReason.INCORRECT);
			return;
		}
		
		passwordAuth.clear ();
		addToast ("login", LibMisc.getTextOrDefault (
				"mb.login.parent",
				"You have logged in to your parent account."));
		setVisitorAsParent (p);
		remove (MBGoal.LOG_IN_AS_PARENT);
		add (MBGoal.MY_ACCOUNT);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private void logInSelf () {
		/*
		 * Already done?
		 */
		if (null != visitorAsUser) {
			remove (MBGoal.LOG_IN_SELF);
			return;
		}
		/*
		 * Data available and possibly valid?
		 */
		loginAuth.check ();
		passwordAuth.check ();
		if (hasErrors ()) {
			return;
		}
		
		/*
		 * Try to find the user
		 */
		final AbstractUser u = Nomenclator.getUserByLogin (loginAuth
				.getValue ());
		if ( (null == u) || ! (u instanceof User)) {
			add (MBFieldIdent.LOGIN_AUTH, MBErrorReason.INCORRECT);
			return;
		}
		
		/*
		 * Check password
		 */
		final boolean ok = ((User) u).checkPassword (passwordAuth
				.getValue ());
		if ( !ok) {
			add (MBFieldIdent.PASSWORD_AUTH, MBErrorReason.INCORRECT);
			return;
		}
		
		/*
		 * Mop up
		 */
		passwordAuth.clear ();
		addToast ("login", LibMisc.getTextOrDefault ("mb.login.self",
				"You have logged in to your account."));
		setVisitorAsUser ((User) u);
		remove (MBGoal.LOG_IN_SELF);
		
		if (null == u.getResponsibleMail ()) {
			// Redirect to collect email address
			add (MBGoal.SET_RESPONSIBLE_MAIL);
		}
		add (MBGoal.MY_ACCOUNT);
		
	}
	
	/**
	 * Destroy the association between this session object and the HTTP
	 * session provided
	 * 
	 * @param httpSession the session storing the reference
	 */
	public void logout (final HttpSession httpSession) {
		httpSession.setAttribute ("mb", null);
		forgetVisitor ();
		goals.clear ();
		errors.clear ();
		errorToasts.clear ();
		toasts.clear ();
		passwordAuth.clear ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private void payAccount () {
		/*
		 * Do we even know who it is we're looking-for?
		 */
		final User whom = getTargetMember ();
		
		if (null == whom) {
			add (MBGoal.CHOOSE_ACCOUNT_TO_PAY);
			return;
		}
		remove (MBGoal.CHOOSE_ACCOUNT_TO_PAY);
		
		clearErrorsFor (MBFieldIdent.PAYMENT_CREDENTIALS);
		
		// Bail out now, if anything up to this point looks scruffy
		if (hasErrors ()) {
			return;
		}
		
		/*
		 * Set payment values
		 */
		buyerFamilyName.check ();
		buyerGivenName.check ();
		creditCardNumber.check ();
		creditCardCode.check ();
		creditCardType.setValue ("VISA"); // XXX
		creditCardType.check ();
		creditCardExpiry.check ();
		
		if (hasErrors ()) {
			return;
		}
		
		try {
			enrolmentChosen.setValue (Enrolment.getByID (3));
		} catch (final NotFoundException e) {
			MBSession.log.error ("Exception", e);
		} // XXX
		
		final PaymentCredential cred = payment.getValue ()
				.getCredentials ();
		cred.setBuyerFamilyName (buyerFamilyName.getValue ());
		cred.setBuyerGivenName (buyerGivenName.getValue ());
		cred.setCardCode (creditCardCode.getValue ());
		cred.setCardNumber (creditCardNumber.getValue ());
		cred.setCredentialType (CredentialType
				.valueOf (creditCardType.getValue ()));
		try {
			cred.setExpiry (new Date (creditCardExpiry.getValue ()
					.getTimeInMillis ()));
		} catch (final CredentialExpiredException e2) {
			add (MBFieldIdent.CC_EXPIRY, MBErrorReason.INCORRECT);
			return;
		}
		
		try {
			cred.verifyCredentials ();
		} catch (final DataException e2) {
			add (MBFieldIdent.PAYMENT_CREDENTIALS,
					MBErrorReason.INCORRECT);
			return;
		}
		
		/*
		 * Buyer address?
		 */
		
		address1.check ();
		city.check ();
		country.check ();
		mailProvided.check ();
		
		if (hasErrors ()) {
			return;
		}
		
		final UserAddress addx = cred.getAddress ();
		addx.setAddress (address1.getValue (), address2.getValue ());
		addx.setCity (city.getValue ());
		addx.setProvince (province.getValue ());
		addx.setCountry (country.getValue ());
		addx.setPostalCode (postalCode.getValue ());
		addx.setPhone (phone.getValue ());
		
		try {
			addx.setMail (mailProvided.getValue ());
		} catch (final Exception e2) {
			mailProvided.clear ();
			add (MBFieldIdent.MAIL_PROVIDED, MBErrorReason.INCORRECT);
			return;
		}
		
		/*
		 * For the sake of hooks, later, we want to know, now, whether
		 * the user was (is now) a paid member, or has ever been. This
		 * is entirely for the benefit of the post-payment hooks.
		 */
		
		final boolean wasPaidMember = whom.isPaidMember ();
		
		boolean hasBeenPaidMember = false;
		if (wasPaidMember) {
			hasBeenPaidMember = true;
		} else {
			final Date now = new Date ();
			
			for (final UserEnrolment userEnrolment : whom
					.getUserEnrolmentsAsArray ()) {
				if (userEnrolment.getBegins ().before (now)) {
					hasBeenPaidMember = true;
					break;
				}
			}
		}
		
		/*
		 * OK! Time to start things rolling.
		 */
		
		Payment pay = payment.getValue ();
		
		if (pay.isClosed ()) {
			if ( !pay.isSuccess ()) {
				addErrorToast (String
						.format (LibMisc
								.getTextOrDefault (
										"cc.decline",
										"The credit-card you provided was refused for the following reason: “%s” Please verify your information below, or use a different card for your payment."),
								pay.getResultReason ()));
				add (MBFieldIdent.PAYMENT_CREDENTIALS,
						MBErrorReason.INCORRECT);
				payment.clear ();
				return;
			}
			/* else, was successful, so… */
			addToast ("payment.new",
					"Starting a new payment. For security purposes, you will need to re-enter some of your payment information to make another payment.");
			payment.clear ();
			pay = payment.getValue ();
		}
		
		final Enrolment enrolment = enrolmentChosen.getValue ();
		
		PaymentGatewayReal gateway = null;
		
		// Hard-coded: Use Authorize.Net here. XXX
		try {
			gateway = PaymentGateway.get ("auth").newInstance ();
		} catch (final Exception e1) {
			MBSession.log
					.error ("Authorization Gateway failure", e1);
			addErrorToast (LibMisc
					.getTextOrDefault (
							"mb.gateway.fail",
							"Sorry: We are unable to access our payment-processing system at this time. Please try again in 30 minutes."));
			return;
		}
		
		UserEnrolment userEnrolment = null;
		try {
			userEnrolment = new UserEnrolment (
					gateway.getOrderSourceCode (),
					enrolment.getProductID (), whom.getUserID ());
			MBSession.log.debug (userEnrolment.toString ());
			
		} catch (final NotFoundException e) {
			MBSession.log.error ("Exception", e);
			enrolmentChosen.clear ();
			add (MBFieldIdent.ENROLMENT_CHOSEN,
					MBErrorReason.INCORRECT);
			return;
		}
		
		pay.setPayer (buyerFamilyName.getValue () + ","
				+ buyerGivenName.getValue ());
		pay.setPaymentFor (userEnrolment);
		
		/*
		 * next, look at the payment object and see if it looks OK?
		 */
		payment.check ();
		
		if ( !pay.isReadyToGo ()) {
			add (MBFieldIdent.PAYMENT_CREDENTIALS,
					MBErrorReason.BLANK);
			return;
		}
		
		try {
			gateway.startTransaction (pay);
		} catch (final UnsupportedCurrencyException e) {
			addErrorToast (LibMisc
					.getTextOrDefault (
							"mb.currency.unsupported",
							"The currency selected for your payment is not supported by this service."));
			return;
			
		} catch (final NotFoundException e) {
			MBSession.log
					.error ("Transaction Failed! Exception thrown: "
							+ e.getClass ().getCanonicalName ());
			this.add (MBFieldIdent.ENROLMENT_CHOSEN,
					MBErrorReason.INCORRECT);
			return;
		} catch (final UnsupportedCredentialException e) {
			MBSession.log
					.error ("Transaction Failed! Exception thrown: "
							+ e.getClass ().getCanonicalName ());
			this.add (MBFieldIdent.CC_NUMBER,
					MBErrorReason.INCORRECT);
			return;
			
		} catch (final RetryPaymentException e) {
			MBSession.log
					.error ("Transaction Failed! Exception thrown: "
							+ e.getClass ().getCanonicalName ());
			addErrorToast (LibMisc
					.getTextOrDefault (
							"retry_payment",
							"We are unable to process your payment at this time. Please try again, later."));
			return;
			
		} catch (final GameLogicException e) {
			MBSession.log
					.error ("Transaction Failed! Exception thrown: "
							+ e.getClass ().getCanonicalName ());
			addErrorToast (LibMisc.getText ("payment_already_made"));
			return;
		} catch (final IOException e) {
			MBSession.log
					.error ("Transaction Failed! Exception thrown: "
							+ e.getClass ().getCanonicalName ());
			addErrorToast (LibMisc
					.getTextOrDefault (
							"mb.gateway.offline",
							"Sorry, we are unable to process payments at this time, as our service provider is offline. Please try again, later."));
			return;
		} catch (final AlreadyUsedException e) {
			MBSession.log
					.error ("Transaction Failed! Exception thrown: "
							+ e.getClass ().getCanonicalName ());
			addErrorToast (LibMisc.getText ("payment_already_made"));
			return;
		} catch (final DataException e) {
			MBSession.log
					.error ("Transaction Failed! Exception thrown: "
							+ e.getClass ().getCanonicalName ());
			addErrorToast (e.getComplaint ());
			return;
		} catch (final Exception e) {
			MBSession.log
					.error ("Transaction Failed! Exception thrown: "
							+ e.getClass ().getCanonicalName ());
			MBSession.log.error ("Exception", e);
			this.add (MBFieldIdent.CC_NUMBER,
					MBErrorReason.INCORRECT);
			return;
		}
		
		/*
		 * Parent approval is a side-effect of payment
		 */
		if ( (AgeBracket.Kid == whom.getAgeGroup ())
				|| (AgeBracket.Teen == whom.getAgeGroup ())) {
			whom.parentApprovedAccount (true);
			whom.parentApprovedName (true);
			try {
				whom.setParent (Parent
						.getOrCreateByMail (mailProvided
								.getValue ()));
			} catch (final Exception e) {
				// ignore as insignificant (…)
				MBSession.log.error ("Exception", e);
			}
		}
		
		// If we are here, they have paid successfully.
		
		for (final PostPaymentHook hook : MBSession.postPaymentHooks) {
			if (wasPaidMember) {
				hook.doAfterEnrolmentRenewal (this, whom,
						enrolment, userEnrolment, pay);
			} else {
				if (hasBeenPaidMember) {
					hook.doAfterEnrolmentAfterLapse (this, whom,
							enrolment, userEnrolment, pay);
				} else {
					hook.doAfterFirstTimeEnrolment (this, whom,
							enrolment, userEnrolment, pay);
				}
			}
		}
	}
	
	/**
	 * Dummy target :-)
	 */
	private void playNow () {// no op, for Engine only
	}
	
	/**
	 * Register a new parent account (but be lenient, in case they
	 * forgot they already have one)
	 */
	private void registerParent () {
		if (null != visitorAsParent) {
			remove (MBGoal.REGISTER_SELF_PARENT);
			return;
		}
		
		mailProvided.check ();
		passwordRequested.check ();
		
		if (hasErrors ()) {
			return;
		}
		
		final Parent found = Nomenclator
				.getParentByMail (mailProvided.getValue ());
		if (null != found) {
			/*
			 * Probably just forgotten they've already done this. Try
			 * logging in, instead
			 */
			passwordAuth.setValue (passwordRequested.getValue ());
			passwordRequested.clear ();
			add (MBGoal.LOG_IN_AS_PARENT);
			remove (MBGoal.REGISTER_SELF_PARENT);
			logInParent ();
			return;
		}
		
		forgotPasswordQ.check ();
		forgotPasswordA.check ();
		
		try {
			final Parent newParent = new Parent (
					mailProvided.getValue ());
			setVisitorAsParent (newParent);
			newParent.setPasswordAndPasswordRecovery (
					forgotPasswordQ.getValue (),
					forgotPasswordA.getValue (),
					passwordRequested.getValue ());
			
			final String name = givenName.getValue ();
			if (null != name) {
				newParent.setGivenName (name);
			}
			
			newParent.setCanContact ( (null != canContact
					.getValue ())
					&& canContact.getValue ().booleanValue ());
			
			newParent.sendConfirmationMail ();
			
			for (final PostParentRegistrationHook hook : MBSession.postParentRegistrationHooks) {
				hook.postParentRegistration (this, newParent);
			}
			
		} catch (final AlreadyExistsException e) {
			add (MBFieldIdent.MAIL_PROVIDED, MBErrorReason.INCORRECT);
			return;
		} catch (final GameLogicException e) {
			add (MBFieldIdent.FORGOT_PASSWORD_ANSWER,
					MBErrorReason.INCORRECT);
			add (MBFieldIdent.PASSWORD_REQUESTED,
					MBErrorReason.INCORRECT);
		}
		
	}
	
	/**
	 * Create a new user account
	 */
	private void registerUser () {
		
		if (getVisitorRole () == VisitorRole.self) {
			remove (MBGoal.REGISTER_USER);
			return;
		}
		
		characterClass.check ();
		dateOfBirth.check ();
		loginRequested.check ();
		passwordRequested.check ();
		termsConditionsAgree.check ();
		rulesAgree.check ();
		mailProvided.check ();
		
		if (hasErrors ()) {
			return;
		}
		
		final String passwordRequest = passwordRequested.getValue ();
		if ( (null != passwordRequest)
				&& (passwordRequest
						.toLowerCase (Locale.ENGLISH)
						.contains (
								loginRequested
										.getValue ()
										.toLowerCase (
												Locale.ENGLISH)) || loginRequested
						.getValue ()
						.toLowerCase (Locale.ENGLISH)
						.contains (
								passwordRequest
										.toLowerCase (Locale.ENGLISH)))) {
			add (MBFieldIdent.PASSWORD_REQUESTED,
					MBErrorReason.PASSWORD_EQ_USERNAME);
		}
		
		Parent parent = null;
		
		if (VisitorRole.parent == visitorRole) {
			parent = visitorAsParent;
		} else {
			parent = Nomenclator.getParentByMail (mailProvided
					.getValue ());
		}
		
		if (null != parent) {
			
			// Enforce free accounts limit
			
			final int maxChildren = AppiusConfig.getIntOrDefault (
					"org.starhope.appius.parent.maxChildren", 10);
			if (maxChildren < parent.getFreeChildren ().length) {
				addErrorToast (String
						.format (LibMisc
								.getTextOrDefault (
										"mb.parent.tooManyKids",
										"We're sorry, there is a limit of %d free kids' accounts per family."),
								Integer.valueOf (maxChildren)));
			}
			
			// No new registrations for bad parents
			
			for (final GeneralUser aChild : parent.getChildren ()) {
				if (aChild.isBanned ()) {
					addErrorToast (String
							.format (LibMisc
									.getTextOrDefault (
											"mb.parent.bannedKid",
											"Your child's account (%s) is banned from this service. New registrations are not permitted until you resolve this issue."),
									aChild.getDisplayName ()));
				}
			}
		}
		
		if (hasErrors ()) {
			return;
		}
		
		User newUser;
		
		try {
			final AbstractUser created = Nomenclator.create (
					dateOfBirth.getValueJavaSqlDate (),
					characterClass.getValue ().getName (),
					loginRequested.getValue ());
			if ( ! (created instanceof User)) {
				addErrorToast ("An unexpected error has occurred. Your account was partially created. Please contact Customer Service with: Error E-1783:"
						+ (null == created ? "null" : created
								.getClass ()
								.getCanonicalName ()));
			}
			newUser = (User) created;
			
		} catch (final AlreadyUsedException e) {
			MBSession.log.debug ("User creation failed!  "
					+ "Reason: Username already taken.");
			this.add (MBFieldIdent.LOGIN_REQUESTED,
					MBErrorReason.ALREADY_USED);
			return;
		} catch (final ForbiddenUserException e) {
			MBSession.log.debug ("User creation failed!  "
					+ "Reason: Username is forbidden.");
			this.add (MBFieldIdent.LOGIN_REQUESTED,
					MBErrorReason.INCORRECT);
			return;
		} catch (final NumberFormatException e) {
			MBSession.log.debug ("User creation failed!  "
					+ "Reason: Date is invalid.");
			this.add (MBFieldIdent.DATE_OF_BIRTH_GIVEN,
					MBErrorReason.FORMAT);
			return;
		}
		
		if (newUser.getAgeGroup () != AgeBracket.Kid) {
			try {
				newUser.setMail (mailProvided.getValue ());
			} catch (final GameLogicException e) {
				MBSession.log
						.error ("Caught a GameLogicException in MBSession.registerUser/setMail ",
								e);
			}
			newUser.setCanContact ( (null != canContact.getValue ())
					&& canContact.getValue ().booleanValue ());
		}
		
		newUser.setPassword (passwordRequest);
		MBSession.log
				.debug ("User Object instantiated and flushed.  Attempting to check for referer.");
		
		if (null != sourceCookie) {
			newUser.setReferer (sourceCookie);
			MBSession.log
					.debug ("Found a referer cookie!  Referer is set to "
							+ sourceCookie);
			sourceCookie = null;
		}
		
		for (final PostUserRegistrationHook hook : MBSession.postUserRegistrationHooks) {
			hook.postUserRegistration (this, newUser);
		}
		
		if (visitorRole == VisitorRole.parent) {
			MBSession.log
					.debug ("User is being created by a parent.  Setting parent for User.");
			try {
				newUser.setParentByParent (visitorAsParent);
				MBSession.log
						.debug ("Parent assigned successfully.  Set to Parent ID#"
								+ visitorAsParent.getID ());
			} catch (final GameLogicException e) {
				addErrorToast (LibMisc
						.getText ("too_old_for_parent"));
				MBSession.log
						.info ("Redirecting to prompt for e-mail for parent registration {}",
								visitorAsParent.getID ());
			}
			
			remove (MBGoal.REGISTER_USER);
			return;
		}
		
		// If a user is registering, log them in
		setVisitorAsUser (newUser);
		MBSession.log.debug ("Session being assigned to new user ID#"
				+ newUser.getUserID ());
		
		final String name = givenName.getValue ();
		if (null != name) {
			newUser.setGivenName (name);
		}
		
		remove (MBGoal.REGISTER_USER);
		add (MBGoal.PLAY_NOW);
	}
	
	/**
	 * @param goal the goal to remove (as achieved or decided against
	 *             it)
	 * @return whether that had actually been a goal before, and was
	 *         removed
	 */
	public boolean remove (final MBGoal goal) {
		final boolean b = goals.remove (goal);
		MBSession.log.debug ("remove goal " + goal.toString ()
				+ " from " + toString ());
		return b;
	}
	
	/**
	 * Set the value of a field, to the value provided by an end-user.
	 * 
	 * @param fieldIdent The field's identification
	 * @param field The field object itself
	 * @param newValue The user-provided (untrusted) value
	 */
	public Object set (final MBFieldIdent fieldIdent,
			final MBField <?> field, final Object newValue) {
		if (null == newValue) {
			return null;
		}
		clearErrorsFor (fieldIdent);
		final Object reallySet = field.setValueConverted (newValue);
		if (null != reallySet) {
			if (fieldIdent == MBFieldIdent.CC_NUMBER) {
				MBSession.log
						.debug ("Set CC_NUMBER (not logging value)");
			} else {
				try {
					MBSession.log.debug ("Set "
							+ fieldIdent.toString () + " to "
							+ reallySet.toString ());
				} catch (final Throwable t) {
					MBSession.log
							.error ("Set a field, but something went wrong trying to log that.",
									t);
				}
			}
		}
		if (null == reallySet) {
			MBSession.log.debug ("Setting " + fieldIdent.toString ()
					+ " failed (null)");
		}
		return reallySet;
	}
	
	/**
	 * Set the value of a field, to the value provided by the end-user
	 * 
	 * @param field the field identifier
	 * @param value the value provided by the end-user
	 */
	public Object set (final MBFieldIdent field, final Object value) {
		return set (field, getField (field), value);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param year WRITEME
	 * @param month WRITEME
	 * @param day WRITEME
	 * @return the calendar date set
	 * @throws NumberFormatException WRITEME
	 * @throws GameLogicException if the date is impossible(-ish) for a
	 *              date of birth
	 */
	public Calendar setBirthDate (final String year,
			final String month, final String day)
			throws NumberFormatException, GameLogicException {
		final int yearNum = Integer.parseInt (year);
		final int monthNum = Integer.parseInt (month);
		final int dayNum = Integer.parseInt (day);
		final Calendar cal = new GregorianCalendar (yearNum,
				monthNum, dayNum);
		
		return dateOfBirth.setValue (cal);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param newClass WRITEME
	 * @return WRITEME
	 */
	public String setCharacterClass (final String newClass) {
		final AvatarClass classy = characterClass
				.setValueConverted (newClass);
		if (null == classy) {
			return null;
		}
		return classy.getName ();
	}
	
	/**
	 * store something extra in the session for local handlers; use
	 * SPARINGLY
	 * 
	 * @param key dotted-notation unique ID, e.g.
	 *             com.tootsville.peanutCode
	 * @param value arbitrary value; set to null to clear.
	 * @return the value stored, for chaining
	 */
	public String setExtraParam (final String key, final String value) {
		if (null == value) {
			extraParams.remove (key);
		} else {
			extraParams.put (key, value);
		}
		return value;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param q WRITEME
	 * @param a WRITEME
	 */
	public void setForgottenPassword (final String q, final String a) {
		forgotPasswordQ.setValue (q);
		forgotPasswordA.setValue (a);
	}
	
	/**
	 * @param newSource the latestSource to set
	 */
	public void setLatestSource (final String newSource) {
		latestSource = newSource;
	}
	
	/**
	 * @param newCookie the prepaidCookie to set
	 */
	public void setPrepaidCookie (final String newCookie) {
		prepaidCode.setValue (newCookie);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param login WRITEME
	 * @return WRITEME
	 */
	public String setRequestedUserName (final String login) {
		return loginRequested.setValue (login);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private void setResponsibleMail () {
		mailProvided.check ();
		
		if (hasErrors ()) {
			return;
		}
		
		final String addx = mailProvided.getValue ();
		
		if (null != visitorAsUser) {
			if (visitorAsUser.getAgeGroup () == AgeBracket.Kid) {
				// kid, parent mail
				Parent parent = visitorAsUser.getParent ();
				if (null == parent) {
					parent = Parent.getOrCreateByMail (addx);
					try {
						visitorAsUser.setParent (parent);
					} catch (final GameLogicException e) {
						MBSession.log
								.error ("Caught a GameLogicException in MBSession.setResponsibleMail ",
										e);
						add (MBFieldIdent.MAIL_PROVIDED,
								MBErrorReason.INCORRECT);
					} catch (final ForbiddenUserException e) {
						MBSession.log
								.error ("Caught a ForbiddenUserException in MBSession.setResponsibleMail ",
										e);
						add (MBFieldIdent.MAIL_PROVIDED,
								MBErrorReason.INCORRECT);
					} catch (final AlreadyExistsException e) {
						MBSession.log
								.error ("Caught a AlreadyExistsException in MBSession.setResponsibleMail ",
										e);
						add (MBFieldIdent.MAIL_PROVIDED,
								MBErrorReason.INCORRECT);
					}
				}
				try {
					parent.setMail (addx);
				} catch (final GameLogicException e) {
					add (MBFieldIdent.MAIL_PROVIDED,
							MBErrorReason.FORMAT);
					return;
				}
				parent.sendNotificationForChild (visitorAsUser);
				remove (MBGoal.SET_RESPONSIBLE_MAIL);
				return;
			}
			// teen/adult, self mail
			try {
				visitorAsUser.setMail (addx);
			} catch (final GameLogicException e) {
				add (MBFieldIdent.MAIL_PROVIDED,
						MBErrorReason.FORMAT);
				return;
			}
			visitorAsUser.sendConfirmationMail ();
			remove (MBGoal.SET_RESPONSIBLE_MAIL);
			return;
		}
		
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param cookie WRITEME
	 * @return WRITEME
	 */
	public String setSource (final String cookie) {
		sourceCookie = cookie;
		return cookie;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param parent WRITEME
	 */
	public void setVisitorAsParent (final Parent parent) {
		visitorRole = VisitorRole.parent;
		visitorAsUser = null;
		visitorAsParent = parent;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param sessionUser WRITEME
	 */
	public void setVisitorAsUser (final User sessionUser) {
		visitorRole = VisitorRole.self;
		visitorAsUser = sessionUser;
		visitorAsParent = null;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder s = new StringBuilder ();
		s.append ("(s#");
		s.append (mySerial);
		s.append (':');
		s.append ( (null != visitorAsParent ? "p:"
				+ visitorAsParent.getMail ()
				: null != visitorAsUser ? "u:"
						+ visitorAsUser.getDebugName () : "?"));
		s.append (";");
		for (final MBGoal goal : getGoals ()) {
			s.append ('欲'); /*
						 * yu4 \346\254\262 \u6b32 “desire, want,
						 * long for; intend”
						 */
			s.append (goal.toString ());
		}
		s.append ("; ");
		for (final MBFieldIdent field : errors.keySet ()) {
			s.append ('該'); /*
						 * gai1 \350\251\262 \u8a72 “should, ought
						 * to, need to”
						 */
			s.append (field.toString ());
		}
		s.append (")");
		return s.toString ();
	}
	
	/**
	 * Set the last-used time of the session object to “now.” Useful
	 * for housekeeping.
	 */
	public void touch () {
		lastUsed = System.currentTimeMillis ();
	}
	
	/**
	 * @param pageURI page URI
	 * @return true, if we really want to be here.
	 */
	public boolean wantToVisit (final String pageURI) {
		MBSession.log.debug ("Does " + toString ()
				+ " want to be at " + pageURI + "?");
		
		final EnumSet <MBFieldIdent> fields = MBSession.urls
				.get (MBSession.stripIndex (pageURI));
		if (null == fields) {
			MBSession.log.debug (pageURI + " is not a form");
			return true; // irrelevant
		}
		
		if (goals.isEmpty () && !fields.isEmpty ()) {
			MBSession.log
					.debug ("user has no goals, but page has fields");
			return false;
		}
		
		// if (errors.isEmpty ()) {
		// return true;
		// }
		
		for (final MBFieldIdent field : fields) {
			if (errors.containsKey (field)) {
				MBSession.log.debug (pageURI + " provides "
						+ field.toString ());
				return true;
			}
		}
		
		/*
		 * If we're here, this page contains some form fields, but we
		 * don't have any reason to think that the user wants to fill
		 * them out, so we're going to skip it, and possibly let the
		 * engine redirect us to a more appropriate page.
		 */
		MBSession.log
				.debug ("probably someplace better for me… let's see.");
		return false;
	}
}
