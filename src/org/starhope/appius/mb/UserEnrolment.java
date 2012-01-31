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
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 */

package org.starhope.appius.mb;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.GregorianCalendar;
import java.util.LinkedList;
import java.util.Vector;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.pay.util.Invoiceable;
import org.starhope.appius.user.AbstractPerson;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.User;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.CastsToJSON;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.appius.via.Setter;
import org.starhope.catullus.OpEd;
import org.starhope.util.LibMisc;

/**
 * This class represents an instance of a purchased enrolment
 * (subscription) to a game, as bound to a particular user and period of
 * time.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock, <a href="mailto:twheys@gmail.com">Tim
 *         Heys</a>
 */
public class UserEnrolment extends SimpleDataRecord <UserEnrolment>
		implements Invoiceable, CastsToJSON {
	
	/**
	 * A timestamp far enough in the past to be sure to have passed
	 * before this could be created. This value is 2007-01-01 at
	 * midnight, and no current Appius implementor had any members
	 * before that time.
	 */
	public final static long BEFORE_WE_BEGIN = 1167627600000L;
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (UserEnrolment.class);
	
	/**
	 * <p>
	 * An often-used array of characters used to create order codes.
	 * </p>
	 * <p>
	 * This excludes letters and digits which reasonably might be
	 * confused in some handwriting or stylised fonts: <tt>O/Q/0</tt>,
	 * <tt>I/1</tt>, <tt>2/Z</tt>, <tt>5/S</tt>, <tt>7/T</tt>, and
	 * <tt>U/V</tt>.
	 * </p>
	 * <p>
	 * Note that this gives us a base-21 system, thus possible
	 * permutations are:
	 * </p>
	 * 
	 * <pre>
	 * n×1                   21
	 * n×2                  441
	 * n×3                9,261
	 * n×4              194,481
	 * n×5            4,084,101
	 * n×6           85,766,121
	 * n×7        1,801,088,541
	 * n×8       37,822,859,361
	 * n×9      764,280,046,581
	 * n×10  16,679,880,978,201
	 * </pre>
	 * <p>
	 * ∴ we have about 17 trillion available 10-digit order codes even
	 * after excluding all of those potential characters
	 * </p>
	 */
	private static final char orderCodeChars[] = { '3', '4', '6', '9',
			'A', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M',
			'N', 'P', 'R', 'W', 'X', 'Y' };
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 9064687357655345112L;
	
	/**
	 * Create a 10-character sequence using the “non-ambiguous”
	 * character set of order code characters. This routine
	 * <em>does not</em> attempt to validate whether that code is in
	 * use. Used internally by the method {@link #generateOrderCode()},
	 * for which you probably are looking, if you found this.
	 * 
	 * @return the order code
	 */
	private static String genRandomOrderCode () {
		final StringBuilder code = new StringBuilder ();
		for (int i = 0; i < 10; ++i) {
			code.append (String.valueOf (UserEnrolment
					.getOrderCodeChars () [AppiusConfig.getRandomInt (
					0,
					UserEnrolment.getOrderCodeChars ().length - 1)]));
		}
		return code.toString ();
	}
	
	/**
	 * @param userID user enrolled
	 * @return array of all current enrolments FIXME contains SQL
	 */
	public static Collection <UserEnrolment> getAllForUserID (
			final int userID) {
		final LinkedList <UserEnrolment> enrolments = new LinkedList <UserEnrolment> ();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT id FROM subscriptions WHERE user_id=? ORDER BY expires_at DESC");
			
			st.setInt (1, userID);
			if (st.execute ()) {
				rs = st.getResultSet ();
				final long twoYears = 63113851900l;
				final Date twoYearsAgo = new Date (
						System.currentTimeMillis () - twoYears);
				while (rs.next ()) {
					UserEnrolment enrolment = null;
					try {
						enrolment = Nomenclator.getDataRecord (
								UserEnrolment.class,
								rs.getInt ("ID"));
					} catch (final NotFoundException e) {
						UserEnrolment.log
								.error ("User ID#"
										+ userID
										+ " subscription can't be found, user claims to have a subscription to "
										+ rs.getInt ("product_id"),
										e);
					}
					if (null != enrolment) {
						if (enrolment.getExpires ().after (
								twoYearsAgo)) {
							enrolments.add (enrolment);
						}
					}
				}
			}
		} catch (final SQLException e) {
			return new Vector <UserEnrolment> ();
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return enrolments;
	}
	
	/**
	 * Retrieve a User Enrolment based off the invoice number split
	 * into orderSource and orderCode.
	 * 
	 * @param orderSource The source of the order (ex. 'auth')
	 * @param orderCode The code of the order
	 * @return A UserEnrolment with the invoice number of
	 *         {orderSource}-{orderCode}
	 * @throws NotFoundException if an enrolment cannot be found with
	 *              the given orderSource and orderCode.
	 */
	public static UserEnrolment getBySourceAndCode (
			final String orderSource, final String orderCode)
			throws NotFoundException {
		return Nomenclator.getDataRecord (UserEnrolment.class,
				orderSource + "-" + orderCode);
	}
	
	/**
	 * Get all enrolments for a given user in the past two years from
	 * today's date.
	 * 
	 * @param userID user enrolled
	 * @return array of all current enrolments
	 */
	public static UserEnrolment [] getLastTwoYearsForUserID (
			final int userID) {
		final LinkedList <UserEnrolment> enrolments = new LinkedList <UserEnrolment> ();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT ID FROM subscriptions WHERE user_id=? ORDER BY expires_at DESC");
			
			st.setInt (1, userID);
			if (st.execute ()) {
				rs = st.getResultSet ();
				final long twoYears = 63113851900l;
				final Date twoYearsAgo = new Date (
						System.currentTimeMillis () - twoYears);
				while (rs.next ()) {
					UserEnrolment enrolment = null;
					try {
						enrolment = Nomenclator.getDataRecord (
								UserEnrolment.class,
								rs.getInt ("ID"));
					} catch (final NotFoundException e) {
						UserEnrolment.log
								.error ("User subscription can't be found, user claims to have a subscription to "
										+ rs.getInt ("product_id"),
										e);
					}
					if (null != enrolment) {
						if (enrolment.getExpires ().after (
								twoYearsAgo)) {
							enrolments.add (enrolment);
						}
					}
				}
			}
		} catch (final SQLException e) {
			return new UserEnrolment [] {};
		} finally {
			if (null != rs) {
				try {
					rs.close ();
				} catch (final SQLException e) { /* No Op */
				}
			}
			if (null != st) {
				try {
					st.close ();
				} catch (final SQLException e) { /* No Op */
				}
			}
			if (null != con) {
				try {
					con.close ();
				} catch (final SQLException e) { /* No Op */
				}
			}
			
		}
		return enrolments.toArray (new UserEnrolment [enrolments
				.size ()]);
	}
	
	/**
	 * get the order code from an order number
	 * 
	 * @param orderNumber an order number string
	 * @return the order code part (after the “-”)
	 */
	public static String getOrderCode (final String orderNumber) {
		return orderNumber.substring (orderNumber.indexOf ('-') + 1);
	}
	
	/**
	 * Get a set of characters that are unlikely to be confused for one
	 * another.
	 * 
	 * @see #orderCodeChars
	 * @return the characters permitted in order codes.
	 */
	public static char [] getOrderCodeChars () {
		return Arrays.copyOf (UserEnrolment.orderCodeChars,
				UserEnrolment.orderCodeChars.length);
	}
	
	/**
	 * get the order source from an order number
	 * 
	 * @param orderNumber an order number
	 * @return the order source (part before the “-”)
	 */
	public static String getOrderSource (final String orderNumber) {
		return orderNumber.substring (0, orderNumber.indexOf ('-'));
	}
	
	/**
	 * Authorize.net subscription ID
	 */
	private BigDecimal authSubID;
	
	/**
	 * start date
	 */
	private java.sql.Date begins;
	
	/**
	 * expiry date
	 */
	private Date expires;
	
	/**
	 * database ID
	 */
	private int id;
	
	/**
	 * Has this enrolment been activated already?
	 */
	private volatile boolean isActivated = false;
	
	/**
	 * order code
	 */
	private String orderCode;
	
	/**
	 * order source
	 */
	private String orderSource;
	
	/**
	 * Enrolment product ID
	 */
	private int productID;
	
	/**
	 * The user who owns this enrolment
	 */
	private int userID;
	
	/**
	 * Constructor used by SQL loader
	 * 
	 * @param userEnrolmentRecordLoader the loader
	 */
	public UserEnrolment (
			final RecordLoader <UserEnrolment> userEnrolmentRecordLoader) {
		super (UserEnrolment.class);
		myLoader = userEnrolmentRecordLoader;
	}
	
	/**
	 * <p>
	 * Create a new enrolment for the given user.
	 * </p>
	 * <p>
	 * Note: this is the ctor called from {@link MBSession}
	 * .payAccount()
	 * </p>
	 * 
	 * @param order_source order source code
	 * @param product_id the product for which the user is enrolling
	 * @param user_id the user being enrolled
	 * @throws NotFoundException if the enrolment type is not found.
	 */
	public UserEnrolment (final String order_source,
			final int product_id, final int user_id)
			throws NotFoundException {
		super (UserEnrolment.class);
		generateOrderCode ();
		orderSource = order_source;
		
		begins = new Date (0);
		productID = product_id;
		userID = user_id;
		expires = new Date (0);
		try {
			insert ();
		} catch (final SQLException e1) {
			UserEnrolment.log.error ("Cannot create enrolment", e1);
		}
	}
	
	/**
	 * Create a new user enrolment with the specified order source and
	 * order code. Dates and enrolment type options must be set later.
	 * 
	 * @param orderSource2 the order source for the new enrolment
	 * @param orderCode2 the order code for the new enrolment
	 */
	public UserEnrolment (final String orderSource2,
			final String orderCode2) {
		super (UserEnrolment.class);
		orderSource = orderSource2;
		orderCode = orderCode2;
	}
	
	/**
	 * <p>
	 * XXX: This method should probably be checking
	 * activatedUser.isPaidMember () instead of requiring a boolean
	 * into it
	 * </p>
	 * 
	 * @param newEnrolment true if this is a new account
	 * @throws NotFoundException
	 */
	public void activate (final boolean newEnrolment)
			throws NotFoundException {
		if (isActivated) {
			UserEnrolment.log
					.error ("Called UserEnrolment.activate twice in a row");
			return;
		}
		if (userID > 1) {
			if (newEnrolment) {
				final AbstractUser activatedUser = Nomenclator
						.getUserByID (userID);
				if (null == activatedUser) {
					throw new NotFoundException (
							"Can't activate enrolment, no user #"
									+ userID);
				}
				if (activatedUser instanceof GeneralUser) {
					((User) activatedUser)
							.sendConfirmationForPremium ();
					((User) activatedUser).startEnrolment (this);
				} else {
					UserEnrolment.log
							.error ("Unhandled case... non-local user got enrolment...");
				}
				startEnrolment ();
			} else {
				continueEnrolment ();
			}
		} else {
			UserEnrolment.log
					.error ("Trying to create an enrolment for User #1");
		}
		isActivated = true;
	}
	
	/**
	 * <p>
	 * Extend the expiration date by a given amount. Months are added
	 * based upon the calendar day; i.e. we take into account the
	 * length differences of months and so forth; then, additional days
	 * are appended.
	 * </p>
	 * <p>
	 * Out of paranoia, the base date (to which the new months & days
	 * are added) will be set to the <em>later</em> of
	 * <em> either </em> the current expiry date, or the current date.
	 * This means that if an enrolment expires in the past, and is then
	 * extended, it will end at the proper date from now; but if it has
	 * not yet expired, the renewal will be tacked onto the end.
	 * </p>
	 * 
	 * @param months months to extend
	 * @param days days to extend.
	 */
	private void add (final int months, final int days) {
		final Calendar cal = new GregorianCalendar ();
		cal.setTimeInMillis (Math.max (System.currentTimeMillis (),
				getExpires ().getTime ()));
		cal.add (Calendar.MONTH, months);
		cal.add (Calendar.DATE, days);
		setExpires (new Date (cal.getTimeInMillis ()));
	}
	
	/**
	 * cancel the enrolment, effective immediately.
	 */
	public void cancelNow () {
		setExpires (new Date (System.currentTimeMillis ()));
	}
	
	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#checkStale()
	 */
	@Override
	public void checkStale () {
		final boolean stale = (timeLastChanged < timeLastSaved)
				&& ( (timeLastChanged + AppiusConfig
						.getIntOrDefault (
								"org.starhope.appius.game.userenrolment.stale",
								300000)) < System
						.currentTimeMillis ());
		if (stale) {
			myLoader.refresh (this);
		}
	}
	
	/**
	 * <p>
	 * Based upon the current expiry date, extend the expiry by the
	 * number of months and days indicated by the enrolment type.
	 * </p>
	 */
	private void continueEnrolment () {
		final int privilegeMonths = getEnrolment ()
				.getPrivilegeMonths ();
		final int privilegeDays = getEnrolment ().getPrivilegeDays ();
		add (privilegeMonths, privilegeDays);
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof UserEnrolment)) {
			return false;
		}
		final UserEnrolment other = (UserEnrolment) obj;
		if (id != other.id) {
			return false;
		}
		return true;
	}
	
	/**
	 * Create a pseudo-random, unique order code consisting of the
	 * approved letters and numbers in {@link #orderCodeChars}
	 */
	private void generateOrderCode () {
		String tryCode = "";
		
		while (true) {
			// generate 10 random characters from the given
			tryCode = UserEnrolment.genRandomOrderCode ();
			try {
				UserEnrolment.getBySourceAndCode (orderSource,
						tryCode);
			} catch (final NotFoundException e) {
				break;
			}
		}
		orderCode = tryCode;
		return;
	}
	
	/**
	 * @see org.starhope.appius.pay.util.Invoiceable#getAmount()
	 */
	@Override
	public BigDecimal getAmount () {
		return getEnrolment ().getPrice ();
	}
	
	/**
	 * @return authorize.net subscriber ID
	 */
	public BigDecimal getAuthSubID () {
		return authSubID;
	}
	
	/**
	 * @return begin date
	 */
	public Date getBegins () {
		return begins;
	}
	
	/**
	 * @see org.starhope.appius.pay.util.Invoiceable#getBuyer()
	 */
	@Override
	public AbstractPerson getBuyer () {
		// return getLastPayment ().getPayer ();
		return null;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return getID ();
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		final StringBuilder orderNumber = new StringBuilder ();
		orderNumber.append (orderSource);
		orderNumber.append ("-");
		orderNumber.append (orderCode);
		return orderNumber.toString ();
	}
	
	/**
	 * @see org.starhope.appius.pay.util.Invoiceable#getCurrency()
	 */
	@Override
	public Currency getCurrency () {
		return Currency.get_USD (); // XXX: Currency support
	}
	
	/**
	 * Get the description of the subscription: typically, this says a
	 * subscription to a given product (“Subscription to Tootsville”),
	 * plus “for,” and the display name of the subscriber. This is an
	 * user-visible string.
	 * 
	 * @return the user-visible description of this user enrolment
	 */
	public String getDescription () {
		return getEnrolment ().getTitle ()
				+ " for " // XXX i18n
				+ Nomenclator.getUserByID (getUserID ())
						.getDisplayName ();
	}
	
	/**
	 * @return enrolment
	 */
	public Enrolment getEnrolment () {
		try {
			return Nomenclator.getDataRecord (Enrolment.class,
					productID);
		} catch (final NotFoundException e) {
			return null;
		}
	}
	
	/**
	 * @return expiry
	 */
	public Date getExpires () {
		return expires;
	}
	
	/**
	 * @return unique ID
	 */
	public int getID () {
		return id;
	}
	
	/**
	 * @see org.starhope.appius.pay.util.Invoiceable#getInvoiceID()
	 */
	@Override
	public String getInvoiceID () {
		return orderSource + "-" + orderCode;
	}
	
	/**
	 * @see org.starhope.appius.pay.util.Invoiceable#getInvoiceIDPrefix()
	 */
	@Override
	public char getInvoiceIDPrefix () {
		return 'B'; // Bruce-Robert Pocock
	}
	
	/**
	 * Checks all enrolments for current user to determine when their
	 * last expiration ends and if it ends before today. Returns the
	 * date farthest into the future.
	 * 
	 * @return the last (future-most) expiration date
	 */
	private java.sql.Date getLastExpiration () {
		Date lastExpiration = new Date (System.currentTimeMillis ());
		
		for (final UserEnrolment enrolment : UserEnrolment
				.getAllForUserID (getUserID ())) {
			if (lastExpiration.before (enrolment.getExpires ())) {
				UserEnrolment.log.debug ("Unit Test ("
						+ lastExpiration + ") is before ("
						+ enrolment.getExpires () + ")");
				lastExpiration = enrolment.getExpires ();
			}
		}
		
		return lastExpiration;
	}
	
	/**
	 * @return last payment
	 * @throws NotFoundException if nobody's paid anything yet
	 */
	public Payment getLastPayment () throws NotFoundException {
		return Payment.getLastPaymentFor (this);
	}
	
	/**
	 * @return order code
	 */
	public String getOrderCode () {
		return orderCode;
	}
	
	/**
	 * @return order source
	 */
	public String getOrderSource () {
		return orderSource;
	}
	
	/**
	 * @return product ID of enrolment
	 */
	public int getProductID () {
		return productID;
	}
	
	/**
	 * @return the next date where billing will reoccur
	 */
	public java.util.Date getRecurs () {
		final int months = getEnrolment ().getPrivilegeMonths ();
		final Calendar cal = Calendar.getInstance ();
		cal.setTimeInMillis (begins.getTime ());
		cal.add (Calendar.MONTH, months);
		return cal.getTime ();
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * @see org.starhope.appius.pay.util.Invoiceable#getTitle()
	 */
	@Override
	public String getTitle () {
		return "Enrolment for Tootsville.com";
	}
	
	/**
	 * @return user who is enrolled
	 * @throws NotFoundException
	 */
	public AbstractUser getUser () throws NotFoundException {
		final AbstractUser u = Nomenclator.getUserByID (getUserID ());
		if (null == u) {
			throw new NotFoundException ("Can't find user by ID #"
					+ getUserID ());
		}
		return u;
	}
	
	/**
	 * @return the user ID of the user who �owns� this enrolment
	 */
	public int getUserID () {
		return userID;
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result) + id;
		return result;
	}
	
	/**
	 * insert the enrolment into the database
	 * 
	 * @throws SQLException if the record can't be inserted into the
	 *              database
	 */
	public void insert () throws SQLException {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("INSERT INTO subscriptions (user_id, begins_at, expires_at, order_source, order_code, product_id, auth_sub_id) VALUES (?,?,?,?,?,?,?)");
			st.setInt (1, userID);
			st.setDate (2, begins);
			st.setDate (3, expires);
			st.setString (4, orderSource);
			st.setString (5, orderCode);
			st.setInt (6, productID);
			st.setBigDecimal (7, authSubID);
			st.execute ();
		} catch (final SQLException e) {
			UserEnrolment.log.error ("Exception", e);
		} finally {
			if (null != st) {
				try {
					st.close ();
				} catch (final SQLException e) { /* No Op */
				}
			}
			if (null != con) {
				try {
					con.close ();
				} catch (final SQLException e) { /* No Op */
				}
			}
		}
	}
	
	/**
	 * @return true if the enrolment hasn't expired yet
	 */
	public boolean isActive () {
		final Date now = new Date (System.currentTimeMillis ());
		return begins.before (now) && expires.after (now);
	}
	
	/**
	 * Simple validation checks.
	 * 
	 * @return true, if this object passes a self-test
	 */
	public boolean isGood () {
		return getExpires ().getTime () > UserEnrolment.BEFORE_WE_BEGIN;
		// TODO
	}
	
	/**
	 * find whether this is a recurring enrolment type
	 * 
	 * @return true, if this is a recurring enrolment type
	 */
	public boolean isRecurring () {
		return getEnrolment ().isAutoRenew ();
	}
	
	/**
	 * set both the start and end effective dates to the epoch
	 */
	public void killEnrolment () {
		final java.sql.Date epoch = new java.sql.Date (0);
		setBegins (epoch);
		setExpires (epoch);
	}
	
	/**
	 * @param authSubID1 authorize.net subscription ID
	 */
	@Setter (getter = "getAuthSubID")
	@OpEd (advice = "The Authorize.Net (or other payment authenticator) Subscription ID number", isAdvanced = true, label = "Authenticator Subscription ID")
	public void setAuthSubID (final BigDecimal authSubID1) {
		authSubID = authSubID1;
		changed ();
	}
	
	/**
	 * set the authorize.net subscription ID
	 * 
	 * @param authSubID2 authorize.net subscription ID
	 * @throws NumberFormatException if the id or something can't be
	 *              interpreted? but I don't know what circumstances
	 *              might cause this, probably a non-numeric subscriber
	 *              ID being returned from the provider? WRITEME
	 */
	public void setAuthSubID (final String authSubID2)
			throws NumberFormatException {
		if (null == authSubID2) {
			UserEnrolment.log
					.error ("ARB failing. subscription id: "
							+ getID () + " order code: "
							+ orderSource + "-" + orderCode);
			authSubID = null;
		} else {
			setAuthSubID (new BigDecimal (authSubID2));
		}
		changed ();
	}
	
	/**
	 * @param newBegins begin date
	 */
	@Setter (getter = "getBegins")
	public void setBegins (final Date newBegins) {
		begins = newBegins;
		changed ();
	}
	
	/**
	 * @param newEnrolment enrolment product
	 */
	public void setEnrolment (final Enrolment newEnrolment) {
		productID = newEnrolment.getProductID ();
		changed ();
	}
	
	/**
	 * @param newExpires expiry date
	 */
	public void setExpires (final Date newExpires) {
		expires = newExpires;
		changed ();
	}
	
	/**
	 * @param newID the id to set
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}
	
	/**
	 * @param orderCode1 order code
	 */
	public void setOrderCode (final String orderCode1) {
		orderCode = orderCode1;
		changed ();
	}
	
	/**
	 * @param orderSource1 order source
	 */
	public void setOrderSource (final String orderSource1) {
		orderSource = orderSource1;
		changed ();
	}
	
	/**
	 * @param productID1 enrolment product
	 */
	public void setProductID (final int productID1) {
		productID = productID1;
		changed ();
	}
	
	/**
	 * @param newUser user enrolled
	 */
	public void setUser (final GeneralUser newUser) {
		setUserID (newUser.getUserID ());
		changed ();
	}
	
	/**
	 * @param userID1 user enrolled
	 */
	public void setUserID (final int userID1) {
		userID = userID1;
		changed ();
	}
	
	/**
	 * <p>
	 * Set the proper enrolment start date. This might not work right?
	 * </p>
	 * FIXME: apparently it doesn't work right.
	 */
	private void startEnrolment () {
		final java.sql.Date beginsOn = getLastExpiration ();
		if (beginsOn.getTime () < 1289933972 /* Thu 16 Nov 2010, 2pm */) {
			UserEnrolment.log
					.error ("Enrolment start date incorrect: "
							+ beginsOn.toString ());
		}
		try {
			setBegins (beginsOn);
			final Enrolment enrolment = Nomenclator.getDataRecord (
					Enrolment.class, productID);
			add (enrolment.getRenewalMonths (),
					enrolment.getRenewalDays ());
		} catch (final NotFoundException e) {
			UserEnrolment.log.error ("Exception", e);
		}
		changed ();
	}
	
	/**
	 * @see org.starhope.appius.util.CastsToJSON#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject o = new JSONObject ();
		try {
			o.put ("userID", getUserID ());
			o.put ("authSubID", getAuthSubID ());
			o.put ("orderCode", getOrderCode ());
			o.put ("orderSource", getOrderSource ());
			o.put ("userEnrolmentID", getID ());
			o.put ("product", getEnrolment ());
			o.put ("begins", getBegins ().toString ());
			o.put ("expires", getExpires ().toString ());
			o.put ("enrolment", getEnrolment ().getPrice ());
			try {
				o.put ("lastPayment", getLastPayment ().toJSON ());
			} catch (final NotFoundException e) {
				UserEnrolment.log.error ("Exception", e);
			}
		} catch (final JSONException e) {
			UserEnrolment.log.error ("Exception", e);
		}
		return o;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return "UserEnrolment [authSubID=" + authSubID + ", begins="
				+ begins + ", expires=" + expires + ", id="
				+ getID () + ", isActivated=" + isActivated
				+ ", orderCode=" + orderCode + ", orderSource="
				+ orderSource + ", productID=" + productID
				+ ", userID=" + userID + "]";
	}
	
}
