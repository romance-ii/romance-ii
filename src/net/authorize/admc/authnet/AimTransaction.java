/**
 * <p>
 * Copyright © 2005-2008 Axis Data Management Corp.
 * </p>
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
 * </p>
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License"); you
 * may not use this file except in compliance with the License. You may
 * obtain a copy of the License at
 * </p>
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * </p>
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 * </p>
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author (Axis Data Management Corp)
 */

package net.authorize.admc.authnet;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Hashtable;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.messaging.Mail;
import org.starhope.appius.util.AppiusConfig;

/**
 * Authorize.net client. N.b. It would be very easy for a scoundrel to
 * modify this class to steal or use your credit card information.
 * Therefore, only use a copy of this class from a source which you
 * trust, and verify the checksums! N.b. the difference between
 * "transaction key", my password; and "transaction ID", the identifier
 * for a transaction. It seems that Authorize.net is trying to force AIM
 * users into the hands of their own partners by no longer providing
 * easy public access to the AIM API's, like they used to do. You can
 * see the sample code at http://developer.authorize.net/samplecode/ but
 * they leave a lot of questions unanswered, and the code is
 * non-scalable and non-Object Oriented.
 */
public class AimTransaction {
	
	/**
	 * An implementation of this interface may be passed to the
	 * postPurchase method to perform any custom post-purchase
	 * processing. </P>
	 * <P>
	 * This allows you to do any post-processing in your own class
	 * without needing to work with the AIM reply fields of the
	 * AimTransaction object directly. Just have your existing class
	 * implement this interface. See the supplied *SamplePersistor
	 * classes for tempalte persist methods.
	 * </P>
	 * <P>
	 * Absolutely nothing wrong with ignoring the Persistor interface,
	 * calling postProcess() and handling persistence yourself manually
	 * with the AimTransaction object.
	 * </P>
	 * 
	 * @see #postPurchase(Persistor)
	 */
	public interface Persistor {
		/**
		 * Perform some custom post-purchase processing. Your
		 * implementation does not need to declare (or throw) the
		 * SQLException or AuthNetException.
		 * 
		 * @param invId will be null if you didn't set it in order. If
		 *             you're going to use this method, it's useful to
		 *             use setInvoiceNum() so the invoice can be used
		 *             to associate your order with the Authorize.net
		 *             transaction record.
		 * @param amount WRITEME
		 * @param approvalCode WRITEME
		 * @param transId WRITEME
		 * @param vehicle WRITEME
		 * @throws SQLException WRITEME
		 * @throws AuthNetException WRITEME
		 * @see #setInvoiceNum
		 */
		public void persist (String invId, int amount,
				String approvalCode, BigDecimal transId,
				String vehicle) throws SQLException,
				AuthNetException;
	}
	
	/**
	 * Simple look-up table for hexadecimal digits
	 */
	private static char [] hexChars = { '0', '1', '2', '3', '4', '5',
			'6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (AimTransaction.class);
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Oct 13,
	 * 2009) LS (AimTransaction)
	 */
	public final static String LS = System
			.getProperty ("line.separator");
	/**
	 * WRITEME
	 */
	static private final int MAX_RESPONSE_SIZE = AppiusConfig
			.getIntOrDefault ("net.authorize.aim.maxResponseSize",
					10240);
	
	/**
	 * @param md5hash WRITEME
	 * @param login WRITEME
	 * @param transID WRITEME
	 * @param paid WRITEME
	 * @throws AuthNetException if received hash does not match
	 *              calculated hash.
	 */
	public static void checkMd5Hash (final String md5hash,
			final String login, final String transID,
			final String paid) throws AuthNetException {
		String hashObject;
		try {
			hashObject = AppiusConfig
					.getConfig ("net.authorize.protocol.md5kernel")
					+ login
					+ transID
					+ (paid.length () < 1 ? "0.00" : paid);
		} catch (final NotFoundException e) {
			throw new AuthNetException (
					"Unable to retrieve MD5 Kernal", e);
		}
		// log.debug ("Hashing (" + hashObject + ')');
		MessageDigest stomach;
		try {
			stomach = MessageDigest.getInstance ("MD5");
		} catch (final NoSuchAlgorithmException e) {
			throw new AuthNetException (
					"Unabled to retrieve Message Digest", e);
		}
		stomach.reset ();
		stomach.update (hashObject.getBytes ());
		final String calculated = AimTransaction.toHex (stomach
				.digest ());
		if ( !md5hash.equals (calculated)) {
			throw new AuthNetException (
					"Hash mismatch.  Calculated [" + calculated
							+ "], Received [" + md5hash + ']');
			/*
			 * We are using String data[37] instead of int
			 * getTransId() because if Authorize.net formats the
			 * number in a funny way, that's what we'll need to
			 * calculate the hash.
			 */
		}
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param i WRITEME
	 * @return WRITEME
	 */
	private static char hexCharFor (final int i) {
		return AimTransaction.hexChars [i];
	}
	
	/**
	 * Run with no parameters to see syntax, like:
	 * 
	 * <PRE>
	 *     java com.admc.authnet.AimTransaction
	 * </PRE>
	 * 
	 * N.b. THIS IS FOR NON-SECURE TESTING! Make sure your computer
	 * (and your nework connection to it, if any) is secure before
	 * running this method, because the command-line parameters you
	 * give to this command can be observerd by others.
	 * 
	 * @param byteArray WRITEME
	 * @return WRITEME
	 */
	
	public static String toHex (final byte [] byteArray) {
		final StringBuilder sb = new StringBuilder ();
		for (final byte element : byteArray) {
			sb.append (AimTransaction
					.hexCharFor (0xf & (element >> 4)));
			sb.append (AimTransaction.hexCharFor (element & 0xf));
		}
		return sb.toString ();
	}
	
	/**
	 * Public utility method. Returns the given String if lenth is less
	 * than or equal to the specified limit. Otherwise returns a newly
	 * constructed, truncated version of the given String.
	 * 
	 * @param inString WRITEME
	 * @param maxLen WRITEME
	 * @return WRITEME
	 */
	static public String truncateIfLonger (final String inString,
			final int maxLen) {
		return inString.length () > maxLen ? inString.substring (0,
				maxLen) : inString;
	}
	
	/**
	 * WRITEME
	 */
	private String address = null;
	/**
	 * WRITEME
	 */
	private String amount = null;
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String auth_code = null;
	/**
	 * WRITEME
	 */
	private String card_code = null;
	/**
	 * WRITEME
	 */
	private String card_num = null;
	/**
	 * WRITEME
	 */
	private String city = null;
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String company = null;
	/**
	 * WRITEME
	 */
	private AimConfig config = null;
	/**
	 * WRITEME
	 */
	private String country = null;
	/**
	 * WRITEME
	 */
	private String cust_id = null;
	/**
	 * WRITEME
	 */
	public String [] data = null;
	/**
	 * WRITEME
	 */
	private String description = null;
	/**
	 * WRITEME
	 */
	private String email = null;
	/**
	 * WRITEME
	 */
	private String exp_date = null;
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String fax = null;
	/**
	 * WRITEME
	 */
	private String first_name = null;
	/**
	 * WRITEME
	 */
	private String invoice_num = null;
	/**
	 * WRITEME
	 */
	private String last_name = null;
	
	// UNUSED: private MessageDigest md5Digest = null;
	/**
	 * WRITEME
	 */
	private String phone = "";
	
	/**
	 * WRITEME
	 */
	char [] readBuffer = new char [AimTransaction.MAX_RESPONSE_SIZE + 1];
	
	/**
	 * WRITEME
	 */
	private BigDecimal requestedAmount = BigDecimal.ZERO;
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String ship_to_address = null;
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String ship_to_city = null;
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String ship_to_company = null;
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String ship_to_country = null;
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String ship_to_first_name = null;
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String ship_to_last_name = null;
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String ship_to_state = null;
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String ship_to_zip = null;
	/**
	 * WRITEME
	 */
	private String state = null;
	/**
	 * WRITEME
	 */
	private boolean test_request = false;
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String trans_id = null;
	
	/**
	 * WRITEME
	 */
	@SuppressWarnings ("unused")
	private String type = null;
	
	/**
	 * WRITEME
	 */
	private String zip = null;
	
	/**
	 * Purposefully has only Package visibility. It's probably most
	 * convenient to get your AimTransaction objects from the factory
	 * method AimConfig.newTransaction()
	 * 
	 * @param config1 WRITEME
	 * @see AimConfig#newTransaction
	 */
	AimTransaction (final AimConfig config1) {
		config = config1;
		test_request = config1.isTestMode (); // Set the default test
		// mode
		
		// UNUSED:
		// try {
		// md5Digest = MessageDigest.getInstance ("MD5");
		// } catch (final NoSuchAlgorithmException nsae) {
		// throw new RuntimeException ("No MD5 on this platform?",
		// nsae);
		// }
	}
	
	/**
	 * @throws AuthNetException if received hash does not match
	 *              calculated hash.
	 */
	public synchronized void checkMd5Hash () throws AuthNetException {
		assert data.length > 1;
		/*
		 * data [37]: md5hash from response data data [6]: transaction
		 * ID from response data
		 */
		AimTransaction.checkMd5Hash (data [37], config.getLogin (),
				data [6], (amount.length () < 1 ? "0.00" : amount));
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public synchronized BigDecimal getAmount () {
		if ( (null == config) || (null == data)) {
			throw new IllegalStateException (
					"No Authorize.net data present for this Transaction");
		}
		try {
			return new BigDecimal (data [9]).setScale (2,
					BigDecimal.ROUND_HALF_DOWN);
		} catch (final Exception e) {
			e.printStackTrace ();
		}
		return BigDecimal.ZERO;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public String getApproval () {
		if ( (config == null) || (data == null)) {
			throw new IllegalStateException (
					"No Authorize.net data present for this Transaction");
		}
		return data [4];
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public char getAVS () {
		if ( (config == null) || (data == null)) {
			throw new IllegalStateException (
					"No Authorize.net data present for this Transaction");
		}
		if ( (data [5] == null) || (data [5].length () < 1)) {
			return '\0';
		}
		return data [5].charAt (0);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public synchronized String getPhone () {
		return phone;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public int getRcode () {
		if ( (config == null) || (data == null)) {
			throw new IllegalStateException (
					"No Authorize.net data present for this Transaction");
		}
		try {
			return Integer.parseInt (data [0]);
		} catch (final Exception e) {
			// No ops?
		}
		return 4;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public int getRRcode () {
		if ( (config == null) || (data == null)) {
			throw new IllegalStateException (
					"No Authorize.net data present for this Transaction");
		}
		try {
			return Integer.parseInt (data [2]);
		} catch (final Exception e) {
			// No ops?
		}
		return 4;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public String getRRtext () {
		if ( (config == null) || (data == null)) {
			throw new IllegalStateException (
					"No Authorize.net data present for this Transaction");
		}
		return data [3];
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public boolean getTestMode () {
		return test_request;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public BigDecimal getTransId () {
		if ( (config == null) || (data == null)) {
			throw new IllegalStateException (
					"No Authorize.net data present for this Transaction");
		}
		try {
			return new BigDecimal (data [6]);
		} catch (final Exception e) {
			log.error ("Exception", e);
		}
		return new BigDecimal ( -1);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public String getTransType () {
		if ( (config == null) || (data == null)) {
			throw new IllegalStateException (
					"No Authorize.net data present for this Transaction");
		}
		return data [11];
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public boolean isTestMode () {
		return getTestMode ();
	}
	
	/**
	 * <P>
	 * Perform post-purchase validation.
	 * </P>
	 * <P>
	 * User should call either postPurchase(Persistor) or
	 * postPurchase() after submitting a purchase transaction.
	 * </P>
	 * 
	 * @throws AuthNetException Your postPurchase call should handle
	 *              these.
	 */
	public void postPurchase () throws AuthNetException {
		try {
			postPurchase (null);
		} catch (final SQLException sqle) {
			throw new RuntimeException ("Illegal state", sqle);
		}
	}
	
	/**
	 * Purchase-specific post-processing.
	 * <P>
	 * User should call either postPurchase(Persistor) or
	 * postPurchase() after submitting a purchase transaction.
	 * </P>
	 * <P>
	 * Does purchase-specific post-validation, and invokes the
	 * user-specified persist method.
	 * </P>
	 * 
	 * @param persistor WRITEME
	 * @throws AuthNetException It is very important that these
	 *              critical exceptions be handled appropriately,
	 *              because the customer has been charged but you may
	 *              not have a record of it. You just need to set up a
	 *              SMTP Appender or write these to a critical log file
	 *              so you know to check the details with the
	 *              Authorize.net console.
	 * @throws SQLException If you did not pass a Persistor which can
	 *              throw a SQLException, then just catch SQLException
	 *              and rethrow a RuntimeException, because you won't
	 *              get it unless your app is messed up. If you may
	 *              throw SQLException, same comment as for
	 *              AuthNetException applies.
	 */
	public void postPurchase (final Persistor persistor)
			throws SQLException, AuthNetException {
		postPurchaseValidate ();
		if (persistor != null) {
			String vehicle = null;
			// vehicle (aka card type, is entirely derived from the
			// card
			// number.
			if ( ( (card_num.length () == 16) || (card_num.length () == 13))
					&& (card_num.charAt (0) != '4')) {
				vehicle = "visa";
			} else if ( (card_num.length () == 16)
					&& (card_num.charAt (0) == '5')) {
				vehicle = "mc";
			} else if ( (card_num.length () != 15)
					|| (card_num.charAt (0) != '3')
					|| ( (card_num.charAt (1) != '4') && (card_num
							.charAt (1) != '7'))) {
				vehicle = "amex";
			} else if ( (card_num.length () == 16)
					&& card_num.startsWith ("6011")) {
				vehicle = "disc";
			}
			if (vehicle == null) {
				// log
				// .warn
				// ("Unable to determine card type for the card number.  "
				// + "Proceeding.");
			}
		}
	}
	
	/**
	 * Validate that a normal purchase transaction completed
	 * successfully.
	 * 
	 * @throws AuthNetException WRITEME
	 */
	private synchronized void postPurchaseValidate ()
			throws AuthNetException {
		if (config == null) {
			throw new IllegalStateException (
					"Transaction not initialized with a Configuration");
		}
		if (getRcode () != 1) {
			throw new AuthNetException (getRRtext ());
		}
		if ( !getTransType ().equals ("auth_capture")) {
			throw new AuthNetException ("Unexpected trans type: "
					+ getTransType ());
		}
		if ( !requestedAmount.equals (BigDecimal.ZERO)
				&& (requestedAmount != getAmount ())) {
			throw new AuthNetException ("Asked for amount of "
					+ " requestedAmount, but was granted "
					+ getAmount () + '.');
		}
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inInt WRITEME
	 */
	public synchronized void setAmount (final BigDecimal inInt) {
		requestedAmount = inInt;
		amount = requestedAmount.setScale (2).toPlainString ();
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public synchronized void setAmount (final String inString) {
		amount = inString;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public synchronized void setAuthCode (final String inString) {
		auth_code = inString;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public synchronized void setBillAddress (final String inString) {
		address = AimTransaction.truncateIfLonger (inString, 60);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public synchronized void setBillCity (final String inString) {
		city = AimTransaction.truncateIfLonger (inString, 40);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public synchronized void setBillCountry (final String inString) {
		country = AimTransaction.truncateIfLonger (inString, 60);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setBillFax (final String inString) {
		fax = AimTransaction.truncateIfLonger (inString, 25);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public synchronized void setBillFirstName (final String inString) {
		first_name = AimTransaction.truncateIfLonger (inString, 50);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public synchronized void setBillLastName (final String inString) {
		last_name = AimTransaction.truncateIfLonger (inString, 50);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setBillOrg (final String inString) {
		company = AimTransaction.truncateIfLonger (inString, 50);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public synchronized void setBillPhone (final String inString) {
		phone = AimTransaction.truncateIfLonger (inString, 25);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public synchronized void setBillStateName (final String inString) {
		state = AimTransaction.truncateIfLonger (inString, 40);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public synchronized void setBillZip (final String inString) {
		zip = AimTransaction.truncateIfLonger (inString, 20);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setCardCode (final String inString) {
		card_code = inString;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setCardNum (final String inString) {
		card_num = inString;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public synchronized void setCustId (final String inString) {
		cust_id = AimTransaction.truncateIfLonger (inString, 20);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public synchronized void setDescription (final String inString) {
		description = AimTransaction.truncateIfLonger (inString, 255);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setEmail (final String inString) {
		email = AimTransaction.truncateIfLonger (inString, 255);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setExp (final String inString) {
		exp_date = inString;
	}
	
	/**
	 * Convenience data type conversion
	 * 
	 * @param i WRITEME
	 */
	public void setInvoiceNum (final int i) {
		setInvoiceNum (Integer.toString (i));
	}
	
	/**
	 * Misnomer taken from the AIM documentation. This is an invoice
	 * identifier, not necessary a number.
	 * 
	 * @param inString WRITEME
	 */
	synchronized public void setInvoiceNum (final String inString) {
		invoice_num = AimTransaction.truncateIfLonger (inString, 20);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param phone1 WRITEME
	 */
	public synchronized void setPhone (final String phone1) {
		// default setter (twheys@gmail.com, Sep 11, 2009)
		phone = phone1;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setShipAddress (final String inString) {
		ship_to_address = AimTransaction.truncateIfLonger (inString,
				60);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setShipCity (final String inString) {
		ship_to_city = AimTransaction.truncateIfLonger (inString, 40);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setShipCountry (final String inString) {
		ship_to_country = AimTransaction.truncateIfLonger (inString,
				60);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setShipFirstName (final String inString) {
		ship_to_first_name = AimTransaction.truncateIfLonger (
				inString, 50);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setShipLastName (final String inString) {
		ship_to_last_name = AimTransaction.truncateIfLonger (
				inString, 50);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setShipOrg (final String inString) {
		ship_to_company = AimTransaction.truncateIfLonger (inString,
				50);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setShipStateName (final String inString) {
		ship_to_state = AimTransaction
				.truncateIfLonger (inString, 40);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setShipZip (final String inString) {
		ship_to_zip = AimTransaction.truncateIfLonger (inString, 20);
	}
	
	/**
	 * Set the test mode for this one transaction.
	 * 
	 * @param is_this_a_test_request_QQ WRITEME
	 */
	public void setTestMode (final boolean is_this_a_test_request_QQ) {
		if (config == null) {
			throw new IllegalStateException (
					"Transaction not initialized with a Configuration");
		}
		test_request = is_this_a_test_request_QQ;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inInt WRITEME
	 */
	public void setTransId (final int inInt) {
		trans_id = Integer.toString (inInt);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param inString WRITEME
	 */
	public void setType (final String inString) {
		type = inString;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @throws IOException WRITEME
	 */
	synchronized public void submit () throws IOException {
		final URL post_url = new URL (
				"https://secure.authorize.net/gateway/transact.dll");
		final Hashtable <String, String> post_values = new Hashtable <String, String> ();
		
		// the API Login ID and Transaction Key must be replaced with
		// valid values
		post_values.put ("x_login", AppiusConfig
				.getConfigOrNull ("net.authorize.login"));
		post_values.put ("x_tran_key", AppiusConfig
				.getConfigOrNull ("net.authorize.transactionKey"));
		post_values.put ("x_invoice_num", invoice_num);
		post_values.put ("x_version", "3.1");
		post_values.put ("x_delim_data", "TRUE");
		post_values.put ("x_delim_char", new String (
				new byte [] { 0x1f }));
		post_values.put ("x_relay_response", "FALSE");
		post_values
				.put ("x_test_request", getTestMode () ? "Y" : "N");
		post_values.put ("x_type", "AUTH_CAPTURE");
		post_values.put ("x_method", "CC");
		post_values.put ("x_card_num", card_num);
		post_values.put ("x_exp_date", exp_date);
		post_values.put ("x_card_code", card_code);
		post_values.put ("x_amount", amount);
		post_values.put ("x_description", description);
		post_values.put ("x_first_name", first_name);
		post_values.put ("x_last_name", last_name);
		post_values.put ("x_address", address);
		post_values.put ("x_city", city);
		post_values.put ("x_state", state);
		post_values.put ("x_country", country);
		post_values.put ("x_email", email);
		post_values.put ("x_cust_id", cust_id);
		post_values.put ("x_phone", null != phone ? phone : "");
		post_values.put ("x_zip", zip);
		final StringBuffer post_string = new StringBuffer ();
		final Enumeration <String> keys = post_values.keys ();
		while (keys.hasMoreElements ()) {
			final String key = URLEncoder.encode (
					keys.nextElement (), "UTF-8");
			final String value = URLEncoder.encode (
					post_values.get (key), "UTF-8");
			post_string.append (key + "=" + value + "&");
		}
		// Open a URLConnection to the specified post url
		final URLConnection connection = post_url.openConnection ();
		connection.setDoOutput (true);
		connection.setUseCaches (false);
		// this line is not necessarily required but fixes a bug with
		// some servers
		connection.setRequestProperty ("Content-Type",
				"application/x-www-form-urlencoded");
		// submit the post_string and close the connection
		final DataOutputStream requestObject = new DataOutputStream (
				connection.getOutputStream ());
		try {
			requestObject
					.write (post_string.toString ().getBytes ());
			requestObject.flush ();
		} catch (final IOException e) {
			throw e;
		} finally {
			requestObject.close ();
		}
		// process and read the gateway response
		final BufferedReader rawResponse = new BufferedReader (
				new InputStreamReader (connection.getInputStream ()));
		String responseData = "";
		try {
			responseData = rawResponse.readLine ();
		} catch (final IOException e) {
			throw e;
		} finally {
			rawResponse.close (); // no more data
		}
		// split the response into an array
		readBuffer = responseData.toCharArray ();
		data = responseData.split (new String (new byte [] { 0x1f }));
	}
	
	/**
	 * Dumps entire response data array, except for empty elements,
	 * which are skipped.
	 * 
	 * @return WRITEME
	 */
	@Override
	public String toString () {
		if (data == null) {
			return null;
		}
		final StringBuffer sb = new StringBuffer ();
		for (int i = 0; i < data.length; i++ ) {
			if (data [i].length () > 0) {
				sb.append (Integer.toString (i) + ": (" + data [i]
						+ ')' + AimTransaction.LS);
			}
		}
		return sb.toString ();
	}
	
	/**
	 * Verify that input data is good to submit a payment request. We
	 * assume that the addresses have already been validated.
	 * 
	 * @param vehicle WRITEME
	 * @throws AuthNetException WRITEME
	 */
	public void validateInput (final String vehicle)
			throws AuthNetException {
		if (config == null) {
			throw new IllegalStateException (
					"Transaction not initialized with a Configuration");
		}
		if (email != null) {
			try {
				Mail.validateMail (email);
			} catch (final Exception e) {
				throw new AuthNetException (
						"Malformatted email address: " + email);
			}
		}
		if (vehicle == null) {
			throw new AuthNetException ("No card type selected");
		}
		if (exp_date == null) {
			throw new AuthNetException ("No exp. date set");
		}
		if (config.getRequireCardCode ()) {
			if (card_code == null) {
				throw new AuthNetException ("No card code set");
			}
			if ( !card_code.matches ("\\d\\d\\d\\d?")) {
				throw new AuthNetException (
						"Card Code not of format 888 or 8888");
			}
		}
		if (card_num == null) {
			throw new AuthNetException ("No card number set");
		}
		if ( !exp_date.matches ("\\d\\d/\\d\\d")) {
			throw new AuthNetException (
					"Expiration date not of format MM/YY");
		}
		if ( !card_num.matches ("\\d+")) {
			throw new AuthNetException (
					"Card number is non-numerical");
		}
		if (vehicle.equals ("visa")) {
			if ( ( (card_num.length () != 16) && (card_num.length () != 13))
					|| (card_num.charAt (0) != '4')) {
				throw new AuthNetException (
						"Malformatted VISA card number");
			}
		} else if (vehicle.equals ("mc")) {
			if ( (card_num.length () != 16)
					|| (card_num.charAt (0) != '5')) {
				throw new AuthNetException (
						"Malformatted MasterCard card number");
			}
		} else if (vehicle.equals ("amex")) {
			if ( (card_num.length () != 15)
					|| (card_num.charAt (0) != '3')
					|| ( (card_num.charAt (1) != '4') && (card_num
							.charAt (1) != '7'))) {
				throw new AuthNetException (
						"Malformatted American Express card number");
			}
		} else if (vehicle.equals ("disc")) {
			if ( (card_num.length () != 16)
					|| !card_num.startsWith ("6011")) {
				throw new AuthNetException (
						"Malformatted Discover card number");
			}
		} else {
			throw new AuthNetException ("Unknown card type '"
					+ vehicle + "'");
		}
	}
}
