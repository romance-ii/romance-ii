/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
 * </p>
 * <p>
 * Based upon public domain sample code provided by Authorize.net
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
 */

package org.starhope.appius.mb;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map.Entry;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.pay.AuthorizeNetGateway;
import org.starhope.appius.pay.util.Invoiceable;
import org.starhope.appius.pay.util.PaymentCredential;
import org.starhope.appius.pay.util.PaymentGatewayReal;
import org.starhope.appius.pay.util.RetryPaymentException;
import org.starhope.appius.sql.SQLPeerDatum;
import org.starhope.appius.user.AbstractPerson;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.JSONUtil;

/**
 * Fairly complete encapsulation of all things related to an individual
 * payment.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 */
public class Payment extends SQLPeerDatum {
	
	/**
	 * What type of item is paid-for? Every class implementing
	 * {@link Invoiceable} should be on this list.
	 */
	public enum InventoryItemType {
		/**
		 * Something that only exists digitally/conceptually, no
		 * physical merchandise entailed
		 */
		DIGIT,
		/**
		 * An enrolment in the game
		 */
		ENROL,
		/**
		 * This payment has not yet been applied.
		 */
		NIL,
		/**
		 * Something that is to be physically shipped out
		 */
		SHIP
	}
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (Payment.class);
	
	/**
	 * Java serialisation. Serial version number of interface
	 * compatibility
	 */
	private static final long serialVersionUID = -1771086264450320549L;
	
	/**
	 * Adds a new payment to the sequence for a User Enrolment.
	 * 
	 * @param userEnrolment The user enrolment to add a payment to.
	 * @return The new Payment.
	 * @throws NotFoundException If the last payment cannot be found.
	 */
	public static Payment addPaymentToSequence (
			final UserEnrolment userEnrolment)
			throws NotFoundException {
		final Payment lastPayment = Payment
				.getLastPaymentFor (userEnrolment);
		/*
		 * Unreachable, paranoid nullcheck.
		 */
		if (null == lastPayment) {
			throw new NotFoundException ("Last Payment for "
					+ userEnrolment.getOrderSource () + "-"
					+ userEnrolment.getOrderCode () + " is null.");
		}
		final int newSequence = lastPayment.getSequence () + 1;
		final Payment currentPayment = new Payment (userEnrolment);
		currentPayment.setSequence (newSequence);
		final BigDecimal scaledPayment = userEnrolment.getAmount ()
				.setScale (2, BigDecimal.ROUND_UNNECESSARY);
		currentPayment.setPrice (lastPayment.getPaid ());
		currentPayment.setPaid (scaledPayment);
		try {
			final DateFormat df = DateFormat
					.getDateInstance (DateFormat.MEDIUM);
			currentPayment.addAnnotation ("", df.format (new Date (
					System.currentTimeMillis ())));
		} catch (final AlreadyUsedException e) {
			Payment.log.error (
					"Cannot add annotation to ARB recur.", e);
		}
		currentPayment.setSuccess (true);
		currentPayment.shredCredentials ();
		return currentPayment;
		
	}
	
	/**
	 * Find the last/latest payment made on a specific enrolment
	 * 
	 * @param userEnrolment the enrolment (subscription) object
	 * @return the last/latest payment made, if any
	 * @throws NotFoundException if there are no payments made
	 */
	public static Payment getLastPaymentFor (
			final UserEnrolment userEnrolment)
			throws NotFoundException {
		log.info ("Searching for payment for source: "
				+ userEnrolment.getOrderSource () + " code: "
				+ userEnrolment.getOrderCode ());
		PreparedStatement st = null;
		Payment p = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM payments WHERE order_source=? AND order_code=? "
					+ "ORDER BY sequence DESC LIMIT 1");
			st.setString (1, userEnrolment.getOrderSource ());
			st.setString (2, userEnrolment.getOrderCode ());
			rs = st.executeQuery ();
			if ( !rs.next ()) {
				throw new NotFoundException (
						"No payments have been made on order "
								+ userEnrolment
										.getOrderSource ()
								+ "/"
								+ userEnrolment.getOrderCode ()
								+ " (invoice ID "
								+ userEnrolment.getInvoiceID ()
								+ ")");
			}
			p = new Payment (rs);
			log.info ("Found payment for " + p.getPayer ());
		} catch (final SQLException e) {
			Payment.log.error ("Exception", e);
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
		return p;
	}
	
	/**
	 * <p>
	 * The collection of additional annotations for record-keeping or
	 * other purposes. These are things not used by the system, but
	 * which are tracked in case they're useful for human review,
	 * auditing, etc.
	 * </p>
	 * <p>
	 * Annotations are keyed off dotted domain sequences in the same
	 * general fashion as Java class names, etc.
	 * </p>
	 */
	private HashMap <String, String> annotations = new HashMap <String, String> ();
	
	/**
	 * Once this is set, no further setting is accepted to any internal
	 * fields: the payment record is closed out completely.
	 */
	private boolean closed = false;
	
	/**
	 * The payment credentials presented. This is usually a credit-card
	 * number; or could be some other type of credentials from e.g. a
	 * gift card or PayPal or something.
	 */
	private transient PaymentCredential credentials;
	
	/**
	 * The month in which the credit-card used to pay for this
	 * transaction will expire.
	 */
	private int expiryMonth = -1;
	
	/**
	 * The year in which the credit-card used to pay for this
	 * transaction will expire. Actual year value, 2009 = 2009.
	 */
	private int expiryYear = -1;
	
	/**
	 * <p>
	 * The time at which we first tried to post this payment. If a
	 * temporary problem was encountered, we can hold on to it (in
	 * core) and retry for a while, until a (configured) timeout has
	 * been reached.
	 * </p>
	 * <p>
	 * This field is <em>not</em> persistent.
	 * </p>
	 */
	private transient Date firstTried;
	
	/**
	 * The time at which we last tried to re-submit a pending
	 * transaction
	 */
	private transient long lastTried;
	
	/**
	 * The order code is an unique string for this order among all
	 * orders placed through a specific source (payment gateway,
	 * generally)
	 */
	private String order_code = "";
	
	/**
	 * The order's source code is an identifier which maps to the
	 * payment gateway class, but is user-visible as a part of the
	 * total payment identifier (source, code, and sequence number)
	 */
	private String order_source = "";
	
	/**
	 * The amount actually paid with this payment. This should
	 * generally be the same as the price (I can't think of a valid
	 * counter-example!)
	 */
	private BigDecimal paid = BigDecimal.ZERO;
	
	/**
	 * The identification of the payer
	 */
	private String payer;
	/**
	 * WRITEME
	 */
	private String paymentFor = "NIL";
	/**
	 * Through what payment gateway was this payment processed?
	 */
	private PaymentGatewayReal paymentGateway;
	
	/**
	 * The price paid in this payment
	 */
	private BigDecimal price;
	
	/**
	 * The reason for the failure (if it failed), or the authorization
	 * code for the success (if it succeeded)
	 */
	private String resultReason;
	
	/**
	 * The sequence number indicates a series of payments that are
	 * related to the same event; this is (always, right now, but)
	 * typically a subscription recurring every month.
	 */
	private int sequence = 0;
	
	/**
	 * The moment in time at which, per <em>our</em> accounting, this
	 * payment took place. Note that the user might see a different
	 * time on his or her wall clock or credit card statements, &c.
	 * There is a degree of ambiguity about when various people
	 * consider the transaction to have been completed. Per our
	 * purposes, this is that moment.
	 */
	private Timestamp stamp;
	
	/**
	 * Was the payment a success? We keep records of failed payments,
	 * too, so it's important to ask that question.
	 */
	private boolean success = false;
	
	/**
	 * Was this a test transaction, submitted by the system? It's
	 * possible. If this is <code>true</code>, we shouldn't give out
	 * anything because of it.
	 */
	private boolean testMode = false;
	
	/**
	 * The transaction code returned by the payment gateway
	 */
	private BigDecimal transactionCode = null;
	
	/**
	 * If this payment was made for an enrolment subscription (right
	 * now (TODO) they all are), then this stores the pointer to the
	 * UserEnrolment record in question.
	 */
	private UserEnrolment userEnrolment = null;
	
	/**
	 * True, if the payment has been reconciled or verified.
	 */
	private boolean verified;
	
	/**
	 * Create a payment for which a subscription does not yet exist
	 */
	public Payment () {
		annotations = new HashMap <String, String> ();
	}
	
	/**
	 * Handle Silent Post data returned by Authorize.Net.
	 * 
	 * @param gatewayClass The class responsible for this payment;
	 *             should always be AuthorizeNetGateway for now.
	 *             Provides an easy hook to make sure we're in the
	 *             right place, not processing e.g. PayPal data here.
	 * @param authorizeNetData The key:value pairs of the data from
	 *             Authorize.Net
	 */
	public Payment (final Class <AuthorizeNetGateway> gatewayClass,
			final HashMap <String, String> authorizeNetData) {
		
		// Nobody is allowed in here without the secret word
		// “AuthorizeNetGateway”
		if ( !gatewayClass.getCanonicalName ().equals (
				AuthorizeNetGateway.class.getCanonicalName ())) {
			throw new IllegalAccessError ();
		}
		
		/*
		 * x_response_code=1& x_response_subcode=1&
		 * x_response_reason_code=1&
		 * x_response_reason_text=This+transaction
		 * +has+been+approved%2E& x_auth_code=QbJHm4& x_avs_code=Y&
		 * x_trans_id=2147490176& x_invoice_num=INV12345&
		 * x_description=My+test+description& x_amount=0%2E44&
		 * x_method=CC& x_type=auth%5Fcapture& x_cust_id=CustId&
		 * x_first_name=Firstname& x_last_name=LastNamenardkkwhczdp
		 * &x_company= &x_address=& x_city=& x_state=& x_zip=&
		 * x_country=& x_phone=& x_fax=& x_email=&
		 * x_ship_to_first_name=& x_ship_to_last_name=&
		 * x_ship_to_company=& x_ship_to_address=& x_ship_to_city=&
		 * x_ship_to_state=& x_ship_to_zip=& x_ship_to_country=&
		 * x_tax=0%2E0000& x_duty=0%2E0000&x_freight=0
		 * %2E0000&x_tax_exempt=FALSE&x_po_num=&
		 * x_MD5_Hash=B9B3D19AEFD7BECC86C5FB3DB717D565&
		 * x_cavv_response=2
		 * &x_test_request=false&x_subscription_id=101635&
		 * x_subscription_paynum=1
		 */
		
		annotations = new HashMap <String, String> ();
		
		final boolean successResponse = Integer
				.parseInt (authorizeNetData.get ("x_response_code")) == 1;
		setSuccess (successResponse);
		if ( !successResponse) {
			setResultReason (authorizeNetData
					.get ("x_response_reason_text"));
		} else {
			setResultReason (authorizeNetData.get ("x_auth_code"));
		}
		try {
			addAnnotation ("net.authorize.avsCode",
					authorizeNetData.get ("x_avs_code"));
		} catch (final AlreadyUsedException e) {
			Payment.log.error ("Exception", e);
		}
		
		// TODO: change from hard-coded authorize.net identifier here
		// to
		// something from the class passed in
		final UserEnrolment enrol;
		try {
			enrol = Nomenclator.getDataRecord (
					UserEnrolment.class,
					"auth-"
							+ authorizeNetData
									.get ("x_invoice_num"));
		} catch (final NotFoundException e) {
			Payment.log.error ("Exception", e);
			return;
		}
		AbstractUser u;
		try {
			u = enrol.getUser ();
		} catch (final NotFoundException e2) {
			Payment.log.error ("Exception", e2);
			return;
		}
		final AbstractPerson buyer = enrol.getBuyer ();
		try {
			setSequence (enrol.getLastPayment ().getSequence () + 1);
		} catch (final NotFoundException e1) {
			Payment.log.error ("NotFoundException", e1);
		}
		if (u.getUserID () != Integer.parseInt (authorizeNetData
				.get ("x_cust_id"))) {
			// TODO warning
		}
		if ( (null == buyer.getGivenName ())
				|| "".equals (buyer.getGivenName ())) {
			buyer.setGivenName (authorizeNetData
					.get ("x_first_name"));
		} else if (buyer.getGivenName () != authorizeNetData
				.get ("x_first_name")) {
			// TODO warning
		}
		
		try {
			addAnnotation ("net.authorize.description",
					authorizeNetData.get ("x_description"));
		} catch (final AlreadyUsedException e) {
			Payment.log.error ("Exception", e);
		}
		setPaid (new BigDecimal (authorizeNetData.get ("x_amount")));
		try {
			addAnnotation ("net.authorize.method", authorizeNetData
			
			.get ("x_method"));
		} catch (final AlreadyUsedException e) {
			Payment.log.error ("Exception", e);
		}
		
	}
	
	/**
	 * Instantiate a Payment from the results returned by an SQL
	 * statement. This allows an arbitrary SELECT to be performed
	 * outside of this class, and objects created from the results.
	 * Note, even if you are expecting only one return, the JDBC
	 * objects start at index -1 in the ResultSet, so you must call
	 * resultSet.next () at least once to get the first row.
	 * 
	 * @param resultSet The SQL ResultSet with the cursor currently on
	 *             the row from which this Payment is to be
	 *             instantiated.
	 * @throws SQLException if we can't cooperate with the database.
	 *              Note that we initiate a secondary query on the same
	 *              connection to obtain annotations, so there is more
	 *              happening here than just fetching results from the
	 *              existing ResultSet. If, for example, the connection
	 *              were closed in between retrieving the ResultSet
	 *              including this payment and instantiating it, it
	 *              would throw some SQL exceptions related to that
	 *              failure.
	 */
	public Payment (final ResultSet resultSet) throws SQLException {
		
		order_source = resultSet.getString ("order_source");
		order_code = resultSet.getString ("order_code");
		try {
			paymentGateway = PaymentGateway.get (order_source)
					.newInstance ();
		} catch (final InstantiationException e) {
			Payment.log.error ("Exception", e);
		} catch (final IllegalAccessException e) {
			Payment.log.error ("Exception", e);
		} catch (final NotFoundException e) {
			// Provide support for legacy applications. Older
			// transactions do
			// not have a payment gateway applicable to the current
			// system.
			paymentGateway = null;
		}
		
		setSequence (resultSet.getInt ("sequence"));
		transactionCode = resultSet.getBigDecimal ("transaction_id");
		setResultReason (resultSet.getString ("result_reason"));
		closed = true;
		setPaid (resultSet.getBigDecimal ("paid"));
		payer = resultSet.getString ("payer");
		paymentFor = resultSet.getString ("payment_for");
		setPrice (resultSet.getBigDecimal ("price"));
		stamp = resultSet.getTimestamp ("stamp");
		success = "Y".equals (resultSet.getString ("was_successful"));
		testMode = "Y".equals (resultSet.getString ("was_test"));
		try {
			userEnrolment = Nomenclator.getDataRecord (
					UserEnrolment.class, order_source + "-"
							+ order_code);
		} catch (final NotFoundException e) {
			Payment.log.error ("Exception", e);
		}
		
		annotations = new HashMap <String, String> ();
		
		final Connection whence = resultSet.getStatement ()
				.getConnection ();
		PreparedStatement getAnnotations = null;
		try {
			getAnnotations = whence
					.prepareStatement ("SELECT annotation,value FROM paymentAnnotations "
							+ "WHERE order_source=? AND order_code=? AND sequence=?");
			getAnnotations.setString (1, order_source);
			getAnnotations.setString (2, order_code);
			getAnnotations.setInt (3, sequence);
			final ResultSet gotAnnotations = getAnnotations
					.executeQuery ();
			while (gotAnnotations.next ()) {
				annotations.put (
						gotAnnotations.getString ("annotation"),
						gotAnnotations.getString ("value"));
			}
			gotAnnotations.close ();
		} catch (final SQLException e) {
			throw e;
		} finally {
			if (null != getAnnotations) {
				try {
					getAnnotations.close ();
				} catch (final SQLException e0) {
					Payment.log.error ("finally", e0);
				}
			}
		}
	}
	
	/**
	 * Instantiate a copy of the Payment for a given order and sequence
	 * number.
	 * 
	 * @param orderSourceID The payment gateway originating the order
	 * @param orderCodeString The unique order code
	 * @param paymentSequenceNumber The sequence number
	 * @throws NotFoundException if the payment cant't be found.
	 */
	public Payment (final String orderSourceID,
			final String orderCodeString,
			final int paymentSequenceNumber)
			throws NotFoundException {
		annotations = new HashMap <String, String> ();
		init (orderSourceID, orderCodeString, paymentSequenceNumber);
	}
	
	/**
	 * Create a new payment upon a given UserEnrolment
	 * 
	 * @param subscription WRITEME
	 */
	public Payment (final UserEnrolment subscription) {
		userEnrolment = subscription;
		annotations = new HashMap <String, String> ();
		order_source = subscription.getOrderSource ();
		order_code = subscription.getOrderCode ();
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jul 13,
	 * 2009)
	 * 
	 * @see #annotations
	 * @param key The annotation's key (in inverse-dotted notation)
	 * @param value The value for this annotation
	 * @throws AlreadyUsedException if the annotation exists
	 */
	public void addAnnotation (final String key, final String value)
			throws AlreadyUsedException {
		if (annotations.containsKey (key)) {
			throw new AlreadyUsedException ("Annotation exists: "
					+ key, stamp);
		}
		annotations.put (key, value);
	}
	
	/**
	 * @throws AlreadyUsedException if the payment has been posted
	 */
	private void assertOpen () throws AlreadyUsedException {
		if (stamp != null) {
			throw new AlreadyUsedException (
					"Payment cannot be altered after being committed",
					stamp);
		}
	}
	
	/**
	 * WRITEME twheys@gmail.com
	 */
	@Override
	public void changed () {
		// no op
	}
	
	/**
	 * Close out the payment completely. After
	 * {@link #setSuccess(boolean)}, the payment enters a state of
	 * “closing out” for post-processing details only to be added to
	 * it. Once this routine is called, the payment is totally frozen.
	 * 
	 * @throws SQLException WRITEME
	 */
	public void close () throws SQLException {
		closed = true;
		if (isSuccess () && (null != userEnrolment)) {
			try {
				userEnrolment.activate (0 == sequence);
			} catch (final NotFoundException e) {
				Payment.log.error ("Exception", e);
			}
		} else {
			userEnrolment.killEnrolment ();
		}
	}
	
	/**
	 * @see org.starhope.appius.sql.SQLPeerDatum#flush()
	 */
	@Override
	public synchronized void flush () {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("INSERT INTO payments "
					+ "(order_source, order_code, sequence, price, paid, transaction_id, "
					+ " payer, stamp, verified, payment_for, was_successful, was_test, result_reason,"
					+ " expiry_year, expiry_month) "
					+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			st.setString (1, order_source);
			st.setString (2, order_code);
			st.setInt (3, sequence);
			st.setBigDecimal (4, price);
			st.setBigDecimal (5, paid);
			st.setBigDecimal (6, transactionCode);
			st.setString (7, payer);
			st.setTimestamp (8, stamp);
			st.setString (9, verified ? "Y" : "N");
			st.setString (10, paymentFor);
			st.setString (11, success ? "Y" : "N");
			st.setString (12, testMode ? "Y" : "N");
			st.setString (13, resultReason);
			if (expiryYear < 2009) {
				st.setNull (14, Types.INTEGER);
			} else {
				st.setInt (14, expiryYear);
			}
			if (expiryMonth < 1) {
				st.setNull (15, Types.INTEGER);
			} else {
				st.setInt (15, expiryMonth);
			}
			st.execute ();
		} catch (final SQLException e) {
			if (null != con) {
				try {
					con.close ();
				} catch (final SQLException e1) { /* No Op */
				}
			}
			Payment.log.error ("Exception", e);
		} finally {
			if (null != st) {
				try {
					st.close ();
				} catch (final SQLException e) { /* No Op */
				}
			}
		}
		PreparedStatement saveAnnotations = null;
		try {
			saveAnnotations = con
					.prepareStatement ("INSERT INTO paymentAnnotations (order_source, order_code, sequence, annotation, value) VALUES (?,?,?,?,?)");
			saveAnnotations.setString (1, order_source);
			saveAnnotations.setString (2, order_code);
			saveAnnotations.setInt (3, sequence);
			for (final Entry <String, String> tuple : annotations
					.entrySet ()) {
				saveAnnotations.setString (4, tuple.getKey ());
				saveAnnotations.setString (5, tuple.getValue ());
				saveAnnotations.execute ();
			}
		} catch (final SQLException e) {
			Payment.log.error ("Exception", e);
		} finally {
			if (null != saveAnnotations) {
				try {
					saveAnnotations.close ();
				} catch (final SQLException e) { /* No Op */
				}
			}
			try {
				con.close ();
			} catch (final SQLException e) { /* No Op */
			}
		}
	}
	
	/**
	 * Retrieve a specific annotation made against a payment. Returns
	 * "" if the annotation were unset.
	 * 
	 * @param key the ID of the annotation
	 * @return the value
	 */
	public String getAnnotation (final String key) {
		if (annotations.containsKey (key)) {
			return annotations.get (key);
		}
		return "";
	}
	
	/**
	 * Retrieve an array of annotation names.
	 * 
	 * @return A String array of the names of annotations.
	 */
	public String [] getAnnotationNames () {
		final String [] annotationNames = new String [] {};
		return annotations.keySet ().toArray (annotationNames);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerDatum#getCacheUniqueID()
	 */
	@Override
	protected synchronized String getCacheUniqueID () {
		return order_source + "-" + order_code + "-" + sequence;
	}
	
	/**
	 * <p>
	 * <strong>Note:</strong> Credentials for payment are <em>not</em>
	 * saved to JSON or database. As such, they only persist as long as
	 * they're held in-core.
	 * </p>
	 * <p>
	 * For this reason, we need to hold on to pending payments'
	 * references to avoid potential GC. We <em>cannot</em>
	 * re-instantiate a non-completed payment from the database.
	 * </p>
	 * <p>
	 * <em>This is an <strong>intentional</strong> security precaution.</em>
	 * </p>
	 * 
	 * @return the credentials used to make the payment.
	 */
	public PaymentCredential getCredentials () {
		if (null == credentials) {
			credentials = new PaymentCredential ();
		}
		return credentials;
	}
	
	/**
	 * Get the currency with which this payment was/will be made
	 * <p>
	 * As with many things, this is still hardcoded as USD.
	 * </p>
	 * 
	 * @return the currency used to make this payment
	 */
	public Currency getCurrency () {
		return Currency.get_USD ();
	}
	
	/**
	 * @return the expiryMonth
	 */
	public synchronized int getExpiryMonth () {
		return expiryMonth;
	}
	
	/**
	 * @return the expiryYear
	 */
	public synchronized int getExpiryYear () {
		return expiryYear;
	}
	
	/**
	 * @return The transaction code provided by the payment gateway
	 */
	public synchronized BigDecimal getGatewayTransactionCode () {
		return transactionCode;
	}
	
	/**
	 * @return the paid
	 */
	public BigDecimal getPaid () {
		// default getter (brpocock@star-hope.org, Jul 14, 2009)
		return paid;
	}
	
	/**
	 * @return get the name or other identification provided by the
	 *         gateway of the payer. (Non-confidential but potentially
	 *         personally identifiable.)
	 */
	public synchronized String getPayer () {
		return payer;
	}
	
	/**
	 * Use {@link #getPaymentFor()} instead
	 * 
	 * @return the payment_for
	 */
	
	@Deprecated
	public String getPayment_for () {
		return paymentFor;
	}
	
	/**
	 * @return the payment_for
	 */
	public String getPaymentFor () {
		return paymentFor;
	}
	
	/**
	 * @return The payment gateway used to make this payment
	 */
	public synchronized PaymentGateway getPaymentGateway () {
		return (PaymentGateway) paymentGateway;
	}
	
	/**
	 * @return the price
	 */
	public BigDecimal getPrice () {
		// default getter (brpocock@star-hope.org, Jul 15, 2009)
		return price;
	}
	
	/**
	 * @return The prior payment in this subscription or other
	 *         recurring payment arrangement
	 * @throws NotFoundException if there wasn't a prior sequence
	 *              payment.
	 */
	public synchronized Payment getPriorPayment ()
			throws NotFoundException {
		if (getSequence () == 0) {
			throw new NotFoundException ("First payment in sequence");
		}
		return new Payment (order_source, order_code,
				getSequence () - 1);
	}
	
	/**
	 * @return the failedReason
	 */
	public String getResultReason () {
		// default getter (brpocock@star-hope.org, Jul 14, 2009)
		return resultReason;
	}
	
	/**
	 * <p>
	 * If this payment is pending, and we're holding credentials in
	 * core, we need to figure out how long before we try again. In the
	 * spirit of exponential back-off, we'll try every 1 minute for the
	 * first 10 minutes, then back off to every 5 minutes for the next
	 * 50 minutes, after which we'll go to every 15 minutes until it's
	 * been 12 hours, after which time, we'll try every hour until the
	 * payment record is dropped.
	 * </p>
	 * <p>
	 * Note that we need to keep a hard reference to this Payment in
	 * the timer routine handling re-submissions, because if the
	 * Payment record is purged from the cache, we lose the
	 * credentials. This is intentional: we don't want to keep
	 * credentials lying around, ever.
	 * </p>
	 * 
	 * @return the date at which we'll next try to complete this
	 *         payment
	 * @throws AlreadyUsedException if the payment can't be retried
	 * @throws DataException if there are no payment credentials
	 *              available for retrying
	 */
	public Date getRetryTime () throws AlreadyUsedException,
			DataException {
		// Can we retry at all?
		if (stamp != null) {
			throw new AlreadyUsedException ("Payment completed",
					stamp);
		}
		if (firstTried == null) {
			throw new AlreadyUsedException (
					"Not a retry:able payment", new Date (
							System.currentTimeMillis ()));
		}
		if (credentials == null) {
			throw new DataException ("No credentials available");
		}
		
		if (lastTried < firstTried.getTime ()) {
			lastTried = firstTried.getTime ();
		}
		
		// How long have we been trying? (in milliseconds)
		final long duration = System.currentTimeMillis ()
				- firstTried.getTime ();
		if (duration < (10 * 60 * 1000)) {
			return new Date (lastTried + (60 * 1000)); // 1min
		} else if (duration < (60 * 60 * 1000)) {
			return new Date (lastTried + (5 * 60 * 1000)); // 5min
		} else if (duration < (12 * 60 * 60 * 1000)) {
			return new Date (lastTried + (15 * 60 * 1000)); // 15min
		} else {
			return new Date (lastTried + (60 * 60 * 1000)); // 1h
		}
		
	}
	
	/**
	 * @return the sequence
	 */
	public synchronized int getSequence () {
		// default getter (brpocock@star-hope.org, Jul 14, 2009)
		return sequence;
	}
	
	/**
	 * @return The date and time at which this payment was made
	 */
	public Date getStamp () {
		return stamp;
	}
	
	/**
	 * FIXME ... this is silly ... ? COMPARE it?
	 * 
	 * @return verify the payment's information against the transaction
	 *         gateway
	 */
	public synchronized Payment getStatusFromGateway () {
		return paymentGateway.getPayment (transactionCode);
	}
	
	/**
	 * @return The user enrolment for which this payment was made.
	 */
	public UserEnrolment getUserEnrolment () {
		return userEnrolment;
	}
	
	/**
	 * @param orderSourceID WRITEME
	 * @param orderCodeString WRITEME
	 * @param paymentSequenceNumber WRITEME
	 * @throws NotFoundException WRITEME
	 */
	private void init (final String orderSourceID,
			final String orderCodeString,
			final int paymentSequenceNumber)
			throws NotFoundException {
		
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM payments WHERE order_source=? AND order_code=? AND sequence=?");
			st.setString (1, orderSourceID);
			st.setString (2, orderCodeString);
			st.setInt (3, paymentSequenceNumber);
			if (st.execute ()) {
				rs = st.getResultSet ();
				rs.next ();
				this.set (rs);
			}
		} catch (final SQLException e) {
			throw new NotFoundException (orderSourceID + "-"
					+ orderCodeString + "."
					+ paymentSequenceNumber);
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
	}
	
	/**
	 * @return true if the payment is closed. See {@link #closed}
	 */
	public boolean isClosed () {
		return closed;
	}
	
	/**
	 * @return true if the payment has been completed (successfully or
	 *         otherwise)
	 */
	public boolean isCompleted () {
		return stamp == null ? false : true;
	}
	
	/**
	 * @return true, if this payment object has sufficiently enough
	 *         information to be applied successfully.
	 */
	public synchronized boolean isReadyToGo () {
		if (closed) {
			return false;
		}
		if (null == credentials) {
			return false;
		}
		if ( !credentials.isReadyToGo ()) {
			return false;
		}
		if (null == order_code) {
			return false;
		}
		if (order_code.length () <= 0) {
			return false;
		}
		if (null == order_source) {
			return false;
		}
		if (order_source.length () <= 0) {
			return false;
		}
		if (null == payer) {
			return false;
		}
		if (payer.length () <= 0) {
			return false;
		}
		if (null == price) {
			return false;
		}
		if (price.compareTo (BigDecimal.ZERO) < 0) {
			return false;
		}
		if (0 > sequence) {
			return false;
		}
		return true;
	}
	
	/**
	 * @return true if the payment was successful.
	 */
	public synchronized boolean isSuccess () {
		return success;
	}
	
	/**
	 * @return true, if this was a test (and not an actual payment)
	 */
	public boolean isTest () {
		return testMode;
	}
	
	/**
	 * @return the verified
	 */
	public boolean isVerified () {
		return verified;
	}
	
	/**
	 * If a payment should retry processing in future (e.g. failure of
	 * payment gateway) this is where we enqueue that attempt
	 * 
	 * @param retryPaymentException the exception causing this to be
	 *             scheduled for a do-over
	 * @throws DataException ...
	 * @throws AlreadyUsedException ...
	 */
	public void prepareForRetry (
			final RetryPaymentException retryPaymentException)
			throws AlreadyUsedException, DataException {
		if (firstTried == null) {
			firstTried = new Date (System.currentTimeMillis ());
		}
		throw new RuntimeException ("Unimplemented");
	}
	
	/**
	 * @see org.starhope.appius.sql.SQLPeerDatum#set(java.sql.ResultSet)
	 */
	@Override
	protected synchronized void set (final ResultSet rs) {
		try {
			order_source = rs.getString ("order_source");
			order_code = rs.getString ("order_code");
			setSequence (rs.getInt ("sequence"));
			setPrice (rs.getBigDecimal ("price"));
			setPaid (rs.getBigDecimal ("paid"));
			transactionCode = rs.getBigDecimal ("transaction_id");
			payer = rs.getString ("payer");
			stamp = rs.getTimestamp ("stamp");
		} catch (final SQLException e) {
			Payment.log.error ("Exception", e);
		}
	}
	
	/**
	 * @param paymentCredentials the credentials to set
	 * @throws AlreadyUsedException if the payment is closed
	 */
	public void setCredentials (
			final PaymentCredential paymentCredentials)
			throws AlreadyUsedException {
		synchronized (this) {
			assertOpen ();
			credentials = paymentCredentials;
		}
		setPayer (paymentCredentials.getBuyerGivenName () + " "
				+ paymentCredentials.getBuyerFamilyName () + " "
				+ paymentCredentials.getBuyerCompany ());
	}
	
	/**
	 * @param expiryMonth1 the expiryMonth to set
	 */
	public synchronized void setExpiryMonth (final int expiryMonth1) {
		getCredentials ().setExpiryMonth (expiryMonth1);
		expiryMonth = expiryMonth1;
	}
	
	/**
	 * @param expiryYear1 the expiryYear to set
	 */
	public synchronized void setExpiryYear (final int expiryYear1) {
		getCredentials ().setExpiryYear (expiryYear1);
		expiryYear = expiryYear1;
	}
	
	/**
	 * @param transactionCodeNumber the transaction code number
	 *             returned by the payment gateway
	 * @throws AlreadyUsedException if this payment has already gotten
	 *              a transaction number
	 */
	public synchronized void setGatewayTransactionCode (
			final BigDecimal transactionCodeNumber)
			throws AlreadyUsedException {
		synchronized (this) {
			if (null != transactionCode) {
				throw new AlreadyUsedException (
						transactionCode.toPlainString (), stamp);
			}
			transactionCode = transactionCodeNumber;
		}
	}
	
	/**
	 * @param paid1 the amount paid
	 */
	public void setPaid (final BigDecimal paid1) {
		paid = paid1;
	}
	
	/**
	 * @param newPayer The payer for this payment
	 */
	public synchronized void setPayer (final String newPayer) {
		payer = newPayer;
	}
	
	/**
	 * use {@link #setPaymentFor(String)} instead.
	 * 
	 * @param payment_for1 WRITEME
	 */
	@Deprecated
	public void setPayment_for (final String payment_for1) {
		setPaymentFor (payment_for1);
	}
	
	/**
	 * @param payment_for1 the payment_for to set
	 */
	public void setPaymentFor (final String payment_for1) {
		paymentFor = payment_for1;
	}
	
	public void setPaymentFor (final UserEnrolment newEnrolment) {
		final Enrolment enrolment = newEnrolment.getEnrolment ();
		userEnrolment = newEnrolment;
		setPaymentFor ("ENROL");
		setPrice (enrolment.getPrice ());
		order_source = newEnrolment.getOrderSource ();
		order_code = newEnrolment.getOrderCode ();
	}
	
	/**
	 * @param paymentGatewayReal Set the payment gateway through which
	 *             this payment was made
	 * @throws AlreadyUsedException if the payment has already been
	 *              made
	 */
	public void setPaymentGateway (
			final PaymentGatewayReal paymentGatewayReal)
			throws AlreadyUsedException {
		synchronized (this) {
			if (stamp != null) {
				throw new AlreadyUsedException (
						paymentGateway.toString (), stamp);
			}
			if (paymentGatewayReal instanceof PaymentGateway) {
				paymentGateway = paymentGatewayReal;
			} else {
				paymentGateway = PaymentGateway
						.getByClass (paymentGateway.getClass ());
			}
		}
	}
	
	/**
	 * @param price1 the price to set
	 */
	public void setPrice (final BigDecimal price1) {
		// default setter (brpocock@star-hope.org, Jul 15, 2009)
		price = price1;
	}
	
	/**
	 * @param resultReason1 the failedReason to set
	 */
	public void setResultReason (final String resultReason1) {
		resultReason = resultReason1;
	}
	
	/**
	 * @param sequence1 the sequence to set
	 */
	public synchronized void setSequence (final int sequence1) {
		sequence = sequence1;
	}
	
	/**
	 * <p>
	 * <strong>Note:</strong> Once this routine has been called, most
	 * of the setters in this Payment will refuse to operate. It will
	 * begin closing-out. Only post-transaction setters will work, and
	 * they will stop working once {@link #close()} is called.
	 * </p>
	 * <p>
	 * This also causes the Payment object to
	 * <em>permanently discard</em> the credentials used for payment.
	 * </p>
	 * 
	 * @param success1 true if the payment succeeded, false otherwise.
	 */
	public synchronized void setSuccess (final boolean success1) {
		success = success1;
		// Sequential payments do not store credentials
		if (null != credentials) {
			expiryMonth = credentials.getExpiryMonth ();
			expiryYear = credentials.getExpiryYear ();
		}
		stamp ();
	}
	
	/**
	 * @param testMode1 If true, then this is meant to be a test
	 *             transaction, and not a real payment.
	 * @throws AlreadyUsedException if this payment has progressed too
	 *              far to be marked as a test now
	 */
	public void setTest (final boolean testMode1)
			throws AlreadyUsedException {
		if (null != stamp) {
			synchronized (stamp) {
				if (closed == false) {
					testMode = testMode1;
				} else {
					throw new AlreadyUsedException (
							"Payment committed", stamp);
				}
			}
		}
	}
	
	/**
	 * @param verified1 the verified to set
	 */
	public void setVerified (final boolean verified1) {
		verified = verified1;
	}
	
	/**
	 * @return true, if the engine should retry this transaction
	 */
	public boolean shouldRetry () {
		try {
			if (getRetryTime ().before (
					new Date (System.currentTimeMillis ()))) {
				return true;
			}
		} catch (final AlreadyUsedException e) {
			return false;
		} catch (final DataException e) {
			return false;
		}
		return false;
	}
	
	/**
	 * Destroy the credentials utterly, once and for all.
	 */
	public void shredCredentials () {
		if (null != credentials) {
			credentials.shred ();
		}
		credentials = null;
		if ( (null != price) && (null != stamp)) {
			flush ();
		} else if (null == price) {
			Payment.log
					.error ("Not flushing payment because price is not set.");
		} else if (null == stamp) {
			Payment.log
					.error ("Not flushing payment because payment is not stamped.");
		}
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 */
	public void stamp () {
		stamp = new Timestamp (System.currentTimeMillis ());
	}
	
	/**
	 * <p>
	 * Note, we do <em>not</em> save credentials to any kind of stream
	 * or storage (JSON, SQL, &c.). Likewise, firstTried is useless in
	 * future, since it's only useful in concert with credentials for
	 * orders that need a retry.
	 * </p>
	 * 
	 * @see SQLPeerDatum#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject o = new JSONObject ();
		try {
			o.put ("FIXME", "FIXME");
			o.put ("stamp", JSONUtil.toJSON (getStamp ()));
		} catch (final JSONException e) {
			Payment.log.error ("Exception", e);
		}
		return o;
	}
	
	/**
	 * @return The order source, code, and sequence number of this
	 *         payment as a string
	 */
	@Override
	public String toString () {
		return String.format ("Payment %4s-%30s-%03d", order_source,
				order_code, Integer.valueOf (sequence));
	}
	
}
