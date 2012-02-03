/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
 * </p>
 * <p>
 * Based upon public domain sample code provided by Authorize.net
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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.pay.util;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.authorize.admc.authnet.AimTransaction;
import net.authorize.arb.ARBNameAndAddress;
import net.authorize.arb.ARBPayment;
import net.authorize.arb.CreditCard;

import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.CredentialExpiredException;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotImplementedException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.UserAddress;

// import com.paypal.sdk.core.nvp.NVPEncoder;

/**
 * @author brpocock@star-hope.org
 */
public class PaymentCredential {
	/**
	 * Perform Luhn algorithm validation upon the credit-card number
	 * supplied.
	 * 
	 * @param number An arbitrary-length credit-card number
	 * @return True, if the number given is potentially valid as a
	 *         credit-card number
	 * @author Hans Peter Luhn; described in U.S. Patent No. 2,950,048,
	 *         filed on January 6, 1954, and granted on August 23, 1960.
	 */
	private static boolean doesNumberMatchLuhnChecksum (
			final BigInteger number) {
		final String num = number.toString ();
		final int [][] sumTable = { { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
				{ 0, 2, 4, 6, 8, 1, 3, 5, 7, 9 } };
		int sum = 0, flip = 0;

		for (int i = num.length () - 1; i >= 0; i-- , flip++ ) {
			sum += sumTable [flip & 0x1] [num.charAt (i) - '0'];
		}
		return sum % 10 == 0;
	}

	/**
	 * @param type a type of credentials
	 * @return a "friendly" (but possibly verbose) description of the
	 *         type of transaction credentials, suitable for displaying
	 *         to the end-user. This is used by, e.g.
	 *         UnsupportedCredentialException to display "pretty" error
	 *         messages.
	 */
	public static String getFriendlyName (final CredentialType type) {
		switch (type) {
		case AMEX:
			return "American Express Card";
		case CHECKING_ACCOUNT:
			return "Electronic transfer from Checking Account";

		case MC:
			return "MasterCard";

		case MM_ACCOUNT:
			return "Electronic transfer from Money Market or other account";

		case NOVUS:
			return "Discover or Novus Card";

		case PAYPAL:
			return "PayPal Electronic Payment";

		case SAVINGS_ACCOUNT:
			return "Electronic transfer from Savings Account";

		case VISA:
			return "VISA Card";

		case GIFT_CARD:
			return "Gift Card";

		case IBC_CARD:
			return "iBC Card";

		case SHREDDED:
			return "These payment credentials have been voluntarily shredded";

		}
		final RuntimeException e = new RuntimeException (
				"Impossible code point reached");
		AppiusClaudiusCaecus.reportBug (e);
		throw e;
	}

	/**
	 * @param ibcCode WRITEME
	 * @return WRITEME
	 * @throws NotImplementedException WRITEME
	 * @throws AlreadyUsedException WRITEME
	 * @throws NotFoundException WRITEME
	 */
	public static int verifyIBC (final String ibcCode)
			throws NotImplementedException, AlreadyUsedException,
			NotFoundException {
		// TODO Auto-generated method stub
		throw new NotImplementedException ();
	}

	/**
	 *WRITEME
	 */
	private volatile UserAddress address = new UserAddress ();

	/**
	 *WRITEME
	 */
	private volatile String buyerCompany = "";

	/**
	 *WRITEME
	 */
	private volatile String buyerFamilyName = "";

	/**
	 *WRITEME
	 */
	private volatile String buyerGivenName = "";

	/**
	 * The CCV, Card Code.
	 */
	private volatile BigDecimal cardCode = BigDecimal.ZERO;

	/**
	 * The CCV, Card Code, stored as a string. This is an historical
	 * hack due to issues with properly formatting CCVs for
	 * Authorize.Net and should be phased out as soon as those bugs have
	 * been fixed.
	 */
	@Deprecated
	private volatile String cardCodeString = "";

	/**
	 * The credit-card number
	 */
	private volatile BigInteger cardNumber = BigInteger.ZERO;

	/**
	 * The type of credentials presented. See {@link CredentialType} for
	 * all valid values. Note that at present we only actually support
	 * credit cards and gift cards.
	 */
	private CredentialType credentialType = CredentialType.SHREDDED;

	/**
	 * The expiry date of a credit card (used for validation)
	 */
	private Date expiry = new Date ();
	
	/**
	 * <p>
	 * Apply a (credit-card only) set of payment credentials to an
	 * Authorize.Net one-time-purchase (AIM, Advanced Integration
	 * Method) object.
	 * </p>
	 * <p>
	 * At present, this (or {@link #applyTo(ARBPayment)}) are the
	 * <em>only</em> supported way to extract the card information once
	 * it's entered into this object; however, the last 4 digits of the
	 * card number are visible via #toString()
	 * </p>
	 * 
	 * @param xact An Authorize.Net transaction in the form of
	 *            AimTransaction
	 * @throws UnsupportedCredentialException if attempting to apply a
	 *             credential type other than MasterCard or VISA
	 */
	public void applyTo (final AimTransaction xact)
			throws UnsupportedCredentialException {
		if (CredentialType.VISA != credentialType
				&& CredentialType.MC != credentialType) {
			throw new UnsupportedCredentialException (null,
					credentialType, "unsupportedCredentialException");
		}
		xact.setCardNum (cardNumber.toString ());
		if (null != cardCodeString && !"".equals (cardCodeString)) {
			xact.setCardCode (cardCodeString);
		} else {
			// Use the correct BigDecimal form
			final String code = "000" + cardCode.toPlainString ();
			xact.setCardCode (code.substring (code.length () - 3));
		}
		xact.setExp (new SimpleDateFormat ("MM/yy").format (expiry));
	}
	
	/**
	 * Apply these payment credentials' data to an Authorize.Net
	 * Automatic Recurring Billing name and address object, needed for
	 * Auth-net-ARB submission.
	 * 
	 * @param billTo The {@link ARBNameAndAddress} object, which will be
	 *            a part of the billing submission
	 */
	public void applyTo (final ARBNameAndAddress billTo) {
		billTo.setFirstName (buyerGivenName);
		billTo.setLastName (buyerFamilyName);
		billTo.setCompany (getBuyerCompany ());
		billTo.setAddress (address.getAddress ());
		billTo.setCity (address.getCity ());
		billTo.setState (address.getProvince ());
		billTo.setCountry (address.getCountry ());
		billTo.setZip (address.getPostalCode ());
	}
	
	/**
	 * <p>
	 * Apply the credit-card information to the Authorize.net ARBPayment
	 * object.
	 * </p>
	 * <p>
	 * At present, this (or {@link #applyTo(AimTransaction)}) are the
	 * <em>only</em> supported way to extract the card information once
	 * it's entered into this object; however, the last 4 digits of the
	 * card number are visible via #toString()
	 * </p>
	 * 
	 * @param payment The ARB Payment object to which we want to append
	 *            the card information.
	 * @throws UnsupportedCredentialException if this is not a
	 *             credit-card credentials bundle
	 */
	public void applyTo (final ARBPayment payment)
			throws UnsupportedCredentialException {
		switch (getCredentialType ()) {
		case AMEX:
		case MC:
		case VISA:
		case NOVUS:
			// OK
			break;
		default:
			throw new UnsupportedCredentialException (null,
					getCredentialType (),
					"Can't apply payment information to "
							+ "Authorize.Net payment: "
							+ "Not credit-card information");
		}

		final CreditCard card = new CreditCard ();
		card.setCardNumber (cardNumber.toString ());
		card.setExpirationDate (expiry);
		card.setCardCode (cardCodeString);

		payment.setCreditCard (card);
	}

	/**
	 * @return UserAddress address
	 */
	public UserAddress getAddress () {
		if (null == address) {
			address = new UserAddress ();
		}
		return address;
	}

	/**
	 * @return the buyerCompany
	 */
	public String getBuyerCompany () {
		return buyerCompany;
	}

	/**
	 * @return String buyerFamilyName
	 */
	public String getBuyerFamilyName () {
		return buyerFamilyName;
	}

	/**
	 * @return String buyerGivenName
	 */
	public String getBuyerGivenName () {
		return buyerGivenName;
	}

	/**
	 * @return the credentialType
	 */
	public CredentialType getCredentialType () {
		return credentialType;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 11,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	@SuppressWarnings ("deprecation")
	public int getExpiryMonth () {
		return expiry.getMonth () + 1;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 11,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	@SuppressWarnings ("deprecation")
	public int getExpiryYear () {
		return expiry.getYear () + 1900;
	}

	/**
	 * @return The last four digits of a credit-card number. Used by
	 *         {@link #toString()} and only accessible thereby.
	 */
	private String getLastFour () {
		if (cardNumber == null) {
			throw new IllegalStateException ();
		}
		final String card = cardNumber.toString ();
		return card.substring (card.length () - 4);
	}

	/**
	 * @return true, if these credentials seem plausible to present
	 */
	public boolean isReadyToGo () {
		try {
			verifyCredentials ();
		} catch (DataException e) {
			return false;
		}
		return address.validate ();
	}

	/**
	 * Apply credentials to a PayPal transaction
	 *
	 * @param encoder the PayPal transaction-in-progress
	 */
	// public void applyTo (final NVPEncoder encoder) {
	// //XXX this is wrongish, but close
	// encoder
	// .add ("CREDITCARDTYPE", getCredentialType ()
	// .toString ());
	// encoder.add ("ACCT", cardNumber.toPlainString ());
	// encoder.add ("EXPDATE", expiry.toString ());
	// encoder.add ("CVV2", cardCodeString);
	// }
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 11,
	 * 2009)
	 *
	 * @param company WRITEME
	 */
	public void setBuyerCompany (final String company) {
		buyerCompany = company;
	}

	/**
	 * @param parameter the buyerFamilyName to set
	 */
	public void setBuyerFamilyName (final String parameter) {
		buyerFamilyName = parameter;
	}

	/**
	 * @param parameter buyer's given name
	 */
	public void setBuyerGivenName (final String parameter) {
		buyerGivenName=parameter;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 *
	 * @param buyerGivenName1 WRITEME
	 * @param buyerFamilyName1 WRITEME
	 * @param address1 WRITEME
	 */
	public void setBuyerInfo (final String buyerGivenName1,
			final String buyerFamilyName1, final UserAddress address1) {
		buyerGivenName = buyerGivenName1;
		buyerFamilyName = buyerFamilyName1;
		address = address1;
	}

	/**
	 * @param num The CCV, Card Code Verification, number (3 or 4
	 *        digits)
	 */
	public void setCardCode (final BigDecimal num) {
		cardCode = num;
		cardCode = cardCode.setScale (0);
	}

	/**
	 * @param num The CCV, Card Code Verification, number (3 or 4
	 *        digits)
	 */
	public void setCardCode (final String num) {
		setCardCode (new BigDecimal (num));
	}

	/**
	 * This is an historical hack from a problem with properly
	 * formatting card codes beginning with zeroes.
	 *
	 * @param code The CCV, Card Code Verification, number (3 or 4
	 *            digits)
	 * @deprecated use {@link #setCardCode(BigDecimal)}
	 */
	@Deprecated
	public void setCardCodeAsString (final String code) {
		cardCodeString = code;
	}

	/**
	 * @param newCardNumber The credit-card number (usually 16 digits)
	 * @throws NumberFormatException if the card number does not match
	 *             checksum
	 */
	public void setCardNumber (final BigInteger newCardNumber)
			throws NumberFormatException {
		if ( !PaymentCredential
				.doesNumberMatchLuhnChecksum (newCardNumber)) {
			throw new NumberFormatException ("Luhn validation failed");
		}
		cardNumber = newCardNumber;
	}

	/**
	 * Set a card number from a user-supplied string. This method
	 * removes non-digit contents before attempting to store the value
	 * as a BigDecimal, so it should be used for user-supplied inputs
	 * that might contain spaces or dashes, or other random line noise.
	 *
	 * @param num The presumed credit-card number, possibly containing
	 *            spaces or dashes.
	 * @throws NumberFormatException if the card number has an invalid
	 *             length, non-digit contents, or does not match a
	 *             correct checksumming for the type of card provided
	 */
	public void setCardNumber (final String num)
			throws NumberFormatException {
		final Pattern notNumbers = Pattern.compile ("[^0-9]");
		final Matcher nonDigits = notNumbers.matcher (num);
		final String numOnlyDigits = nonDigits.replaceAll ("");
		if (13 != numOnlyDigits.length ()
				&& 15 != numOnlyDigits.length ()
				&& 16 != numOnlyDigits.length ()) {
			AppiusClaudiusCaecus
					.blather ("Invalid cc, not the correct length.  Length is: "
							+ numOnlyDigits.length ());
			throw new NumberFormatException ();
		}
		setCardNumber (new BigInteger (numOnlyDigits));
	}

	/**
	 * @param credentialType1 the credentialType to set
	 */
	public void setCredentialType (final CredentialType credentialType1) {
		credentialType = credentialType1;
	}

	/**
	 * @param d The expiration date. Only the month and year are used:
	 *        the day can be "1" for validity
	 * @throws CredentialExpiredException if the expiry date is in the
	 *         past
	 */
	public void setExpiry (final Date d)
			throws CredentialExpiredException {
		if (d.getTime () < System.currentTimeMillis ()) {
			throw new CredentialExpiredException ();
		}
		expiry = new Date (d.getTime ());
	}

	/**
	 * @param expiryMonth expiry month
	 */
	public void setExpiryMonth (final int expiryMonth){
		Calendar newExpiry = new GregorianCalendar ();
		newExpiry.set(Calendar.YEAR, expiry.getYear ());
		newExpiry.set (Calendar.MONTH, expiryMonth
				);
		try {
			setExpiry ( new Date(newExpiry.getTimeInMillis ()));
		} catch (CredentialExpiredException e) {
			// ignore for partial setter
		}
	}

	/**
	 * @param expiryYear expiry year
	 */
	public void setExpiryYear (final int expiryYear) {
		Calendar newExpiry = new GregorianCalendar ();
		newExpiry.set (Calendar.YEAR, expiryYear);
		newExpiry.set (Calendar.MONTH, expiry.getMonth ()
				);
		try {
			setExpiry ( new Date(newExpiry.getTimeInMillis ()));
		} catch (CredentialExpiredException e) {
			// ignore for partial setter
		}
	}

	/**
	 * This was to have been part of Project Risqué and was never
	 * implemented. The vestiges of Risqué could potentially be useful
	 * in future, so they have not been removed.
	 *
	 * @param ibcCode WRITEME
	 * @throws NotImplementedException WRITEME
	 */
	public void setIBCCard (final String ibcCode)
			throws NotImplementedException {
		throw new NotImplementedException ();
	}

	/**
	 * Discard all credential information
	 */
	public void shred () {
		cardNumber = null;
		expiry = null;
		cardCode = null;
		cardCodeString = null;
		credentialType = CredentialType.SHREDDED;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder s = new StringBuilder (
				"Payment credentials: ");
		switch (credentialType) {
		case VISA:
			s.append ("VISA card, ending in ");
			s.append (getLastFour ());
			break;
		case MC:
			s.append ("MasterCard, ending in ");
			s.append (getLastFour ());
			break;
		case AMEX:
			s.append ("American Express card, ending in ");
			s.append (getLastFour ());
			break;
		case NOVUS:
			s.append ("Novus (Discover) card, ending in ");
			s.append (getLastFour ());
			break;
		case CHECKING_ACCOUNT:
			s.append ("ACH debit from checking account");
			break;
		case SAVINGS_ACCOUNT:
			s.append ("ACH debit from savings account");
			break;
		case MM_ACCOUNT:
			s.append ("ACH debit from money-market or other account");
			break;
		case PAYPAL:
			s.append ("PayPal payment");
			break;
		case GIFT_CARD:
			s.append ("Gift card...");
			break;
		case SHREDDED:
			s.append ("These credentials have been voluntarily "
					+ "shredded by the system and cannot be "
					+ "recovered.");
			break;
		default:
			s.append ("Impossible?");
		}
		return s.toString ();
	}

	/**
	 * <p>
	 * Perform basic validation upon the credentials.
	 * </p>
	 * <p>
	 * For credit-cards, verify that the credentials appear to have a
	 * valid credit-card number.
	 * </p>
	 * <p>
	 * For electronic payments of other kinds, perform basic validation
	 * of credential values to ensure that they appear to be basically
	 * plausible.
	 * </p>
	 * <p>
	 * XXX right now, this only actually checks the first digit against
	 * VISA/MasterCard selection. This <em>should</em> do proper
	 * checksum checks against the full number...
	 * </p>
	 *
	 * @throws DataException if the card number is invalid (impossible),
	 *             or the type of credentials for payment presented are
	 *             not set to a valid/supported type (currently VISA or
	 *             MasterCard)
	 */
	public void verifyCredentials () throws DataException {
		if (null == cardNumber || null == credentialType) {
			throw new DataException ("Credentials not set");
		}

		if (credentialType == CredentialType.VISA
				&& '4' != cardNumber.toString ().charAt (0)) {
			throw new DataException ("Invalid Visa Card number");
		}

		if (credentialType == CredentialType.MC
				&& '5' != cardNumber.toString ().charAt (0)) {
			throw new DataException ("Invalid MasterCard number");
		}

		if (null == expiry) {
			throw new DataException ("Unknown expiry");
		}
		if (expiry.getTime () < System.currentTimeMillis ()) {
			throw new DataException ("Expired");
		}
	}

}
