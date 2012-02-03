/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.pay;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import net.authorize.admc.authnet.AimConfig;
import net.authorize.admc.authnet.AimTransaction;
import net.authorize.admc.authnet.AuthNetException;
import net.authorize.arb.ARBAPI;
import net.authorize.arb.ARBCustomer;
import net.authorize.arb.ARBNameAndAddress;
import net.authorize.arb.ARBOrder;
import net.authorize.arb.ARBPayment;
import net.authorize.arb.ARBPaymentSchedule;
import net.authorize.arb.ARBSubscription;

import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.CredentialExpiredException;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.mb.Enrolment;
import org.starhope.appius.mb.Payment;
import org.starhope.appius.mb.PaymentGateway;
import org.starhope.appius.mb.UserAddress;
import org.starhope.appius.mb.UserEnrolment;
import org.starhope.appius.pay.util.AddressVerificationCode;
import org.starhope.appius.pay.util.CredentialType;
import org.starhope.appius.pay.util.PaymentCredential;
import org.starhope.appius.pay.util.RetryPaymentException;
import org.starhope.appius.pay.util.UnsupportedCredentialException;
import org.starhope.appius.pay.util.UnsupportedCurrencyException;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * @author brpocock@star-hope.org, twheys@gmail.com
 */
public class AuthorizeNetGateway extends PaymentGateway {

	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 2097382055172793482L;
	/**
	 * Buyer's postal address for CC billing
	 */
	private UserAddress address;
	/**
	 *Company name for buyer
	 */
	private String buyerCompany;
	/**
	 *Buyer's surname
	 */
	private String buyerFamilyName;

	/**
	 * Buyer's given name
	 */
	private String buyerGivenName;

	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#alterEnrolment(org.starhope.appius.mb.Payment,
	 *      org.starhope.appius.mb.UserEnrolment)
	 */
	@Override
	public void alterEnrolment (final Payment payment,
			final UserEnrolment newForm)
			throws UnsupportedCurrencyException, NotFoundException,
			UnsupportedCredentialException, IOException,
			RetryPaymentException, GameLogicException {

		if (Math.sqrt (4) == 2) {
			throw new Error ("Unimplemented");
		}

		/*
		 * First, validate our inputs a bit.
		 */
		final UserEnrolment paymentFor = payment.getUserEnrolment ();

		if (null == paymentFor) {
			throw new IllegalStateException (
					"Payment is not for an enrolment");
		}

		final Enrolment enrolment = newForm.getEnrolment ();

		if ( !enrolment.isAvailable ()) {
			throw new NotFoundException (
					"The requested enrolment type is not available.");
		}
		if ( !"USD".equals (enrolment.getCurrency ().getCode ())) {
			throw new UnsupportedCurrencyException (
					"The subscription system currently only operates on U.S. Dollars (USD)");
		}

		final BigDecimal scaledAmount;
		try {
			scaledAmount = enrolment.getPrice ().setScale (2,
					BigDecimal.ROUND_UNNECESSARY);
		} catch (final ArithmeticException e) {
			throw new UnsupportedCurrencyException (
					"The amount of the payment supplied included "
							+ "fractional values of less than 1¢ "
							+ "(USD $.01). This is not supported. "
							+ "Payment values must be in increments "
							+ "of 1¢.");
		}

		final PaymentCredential credentials = payment.getCredentials ();

		switch (credentials.getCredentialType ()) {
		case VISA:
		case MC:
			// OK
			break;
		default:
			throw new UnsupportedCredentialException (this.getClass (),
					credentials.getCredentialType (),
					"The subscription system only supports VISA or MasterCard, sorry.");
		}

		/*
		 * Create the ARB data
		 */
		final ARBAPI api = getARBAPI ();

		/*
		 * Billing name and address information
		 */

		if (buyerGivenName == null || "".equals (buyerGivenName)
				|| buyerFamilyName == null
				|| "".equals (buyerFamilyName)) {
			throw new NotFoundException (
					"Payer's given and family names (first and last names) are required");
		}
		if (address == null || !address.isValidAddress ()) {
			throw new NotFoundException (
					"Payer's valid billing address information is required");
		}

		final ARBNameAndAddress billTo = new ARBNameAndAddress ();
		credentials.applyTo (billTo);

		/*
		 * The customer ID and eMail, plus name & address.
		 */

		final ARBCustomer customer = new ARBCustomer ();
		customer.setBillTo (billTo);
		customer.setDriversLicenseSpecified (false);
		customer.setEmail (payment.getPayer ());
		customer.setId (payment.getPayer ());

		/*
		 * Credit-card information is secret!
		 */

		final ARBPayment arbPayment = new ARBPayment ();
		credentials.applyTo (arbPayment);

		/*
		 * Payment schedule
		 */

		final ARBPaymentSchedule schedule = new ARBPaymentSchedule ();

		if (enrolment.getPrivilegeMonths () > 0) {
			schedule
					.setIntervalLength (enrolment.getPrivilegeMonths ());
			schedule.setSubscriptionUnit ("months");
		} else {
			schedule.setIntervalLength (enrolment.getPrivilegeDays ());
			schedule.setSubscriptionUnit ("days");
		}
		schedule.setStartDate (paymentFor.getBegins ());
		schedule.setTotalOccurrences (Integer.MAX_VALUE);
		schedule.setTrialOccurrences (0);

		/*
		 * The actual subscription object
		 */

		final ARBSubscription subscription = new ARBSubscription ();
		subscription.setAmount (scaledAmount);
		subscription.setCustomer (customer);
		subscription.setPayment (arbPayment);
		subscription.setSchedule (schedule);
		subscription.setName (enrolment.getTitle ());

		/*
		 * Send it out
		 */

		api.createSubscriptionRequest (subscription);
		// System.out.println(api.getCurrentRequest().dump());
		api.sendRequest ();

		/*
		 * Collect the response/results
		 */

		payment.setSuccess ("ok".equals (api.getResultCode ()
				.toLowerCase (Locale.ENGLISH)));
		try {
			payment.addAnnotation ("net.authorize.resultCode", api
					.getResultCode ());
			payment.addAnnotation ("net.authorize.arb.subscriptionID",
					api.getResultSubscriptionId ());
			try {
				payment.close ();
			} catch (final SQLException e) {
				AppiusClaudiusCaecus.reportBug (
						"Post-processing error in Payment class!", e);
			}
		} catch (final AlreadyUsedException e) {
			AppiusClaudiusCaecus.reportBug (
					"Post-processing error in Payment class!", e);
		}
		payment.flush ();

		/*
		 * Get out of there
		 */

		api.destroy ();

	}

	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#endEnrolment(org.starhope.appius.mb.Payment)
	 */
	@Override
	public void endEnrolment (final Payment payment)
			throws IllegalStateException, NotFoundException {

		final String buyer = payment.getPayer ();

		final UserEnrolment enrol = payment.getUserEnrolment ();
		if (null == enrol) {
			final IllegalStateException e = new IllegalStateException (
					"Canceling a non-subscription?");
			AppiusClaudiusCaecus.reportBug (e);
			throw e;
		}
		if ( !enrol.isActive ()) {
			AppiusClaudiusCaecus
					.reportBug ("Canceling an expired subscription? I'll try it anways... "
							+ enrol.getInvoiceID ());
		}

		/*
		 * Create the ARB data
		 */
		final ARBAPI api = getARBAPI ();

		/*
		 * Billing name and address information
		 */

		final ARBNameAndAddress billTo = new ARBNameAndAddress ();
		billTo.setFirstName (buyerGivenName);
		billTo.setLastName (buyerFamilyName);
		billTo.setCompany (buyerCompany);
		billTo.setAddress (address.getAddress ());
		billTo.setCity (address.getCity ());
		billTo.setState (address.getProvince ());
		billTo.setCountry (address.getCountry ());
		billTo.setZip (address.getPostalCode ());

		/*
		 * The customer ID and eMail, plus name & address.
		 */

		final ARBCustomer customer = new ARBCustomer ();
		customer.setBillTo (billTo);
		customer.setDriversLicenseSpecified (false);
		customer.setEmail (buyer);
		customer.setId (buyer);

		/*
		 * The actual cancelation object
		 */

		final ARBSubscription subscription = new ARBSubscription ();
		subscription.setCustomer (customer);
		final String subscriptionID = payment
				.getAnnotation ("net.authorize.arb.subscriptionID");
		if (subscriptionID.length () == 0) {
			throw new NotFoundException (
					"Payment does not have a subscription ID specified");
		}
		subscription.setSubscriptionId (subscriptionID);

		/*
		 * Send it out
		 */
		api.cancelSubscriptionRequest (subscription);
		api.sendRequest ();

		/*
		 * Collect the response/results
		 */
		try {
			payment.addAnnotation ("net.authorize.arb.subscriptionID",
					api.getResultSubscriptionId ());
			payment.addAnnotation (
					"net.authorize.arb.cancel.resultCode", api
							.getResultCode ());
			try {
				payment.close ();
			} catch (final SQLException e) {
				AppiusClaudiusCaecus.reportBug (
						"Post-processing error in Payment class!", e);
			}
		} catch (final AlreadyUsedException e) {
			AppiusClaudiusCaecus.reportBug (
					"Post-processing error in Payment class!", e);
		}

		/*
		 * Get out of there
		 */

		api.destroy ();

		/*
		 * Terminate our enrolment to match!
		 */

		enrol.cancelNow ();

	}

	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#enumerateCredentialTypes()
	 */
	@Override
	public List <CredentialType> enumerateCredentialTypes () {
		return Arrays.asList (CredentialType.VISA, CredentialType.MC);
	}

	/**
	 * @return a valid ARBAPI object, properly configured
	 */
	private ARBAPI getARBAPI () {
		ARBAPI api;
		/*
		 * validate the configuration data.
		 */
		try {
			api = new ARBAPI (new URL (AppiusConfig
					.getConfig ("net.authorize.arbURL")), AppiusConfig
					.getConfig ("net.authorize.login"), AppiusConfig
					.getConfig ("net.authorize.transactionKey"));
		} catch (final MalformedURLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Authorize.Net Automated Recurring Billing URL missing from configuration",
							e);
			throw new RuntimeException (e);
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Critical Authorize.Net settings missing from configuration",
							e);
			throw new RuntimeException (e);
		}
		return api;
	}

	/**
	 * @see org.starhope.appius.mb.PaymentGateway#getOrderSourceCode()
	 */
	@Override
	public String getOrderSourceCode () {
		return "auth";
	}

	/**
	 * This is an overriding method.
	 *
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#getPayment(java.math.BigDecimal)
	 */
	@Override
	public Payment getPayment (final BigDecimal id) {
		throw new Error ("I don't do that");
	}

	/**
	 * @param gatewayTransactionCode The transaction code of the payment
	 *            in question
	 * @return As much information as possible about the past
	 *         transaction
	 */
	public Payment getPayment (final String gatewayTransactionCode) {
		throw AppiusClaudiusCaecus.fatalBug (new Exception (
				"unimplemented"));
	}

	/**
	 * Submits a known-good test transaction.
	 *
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#isAvailable()
	 */
	@Override
	public boolean isAvailable () {
		final PaymentCredential credentials = new PaymentCredential ();
		credentials.setCardCode (new BigDecimal ("123"));
		credentials.setCardNumber (new BigInteger ("4111111111111111"));
		credentials.setCredentialType (CredentialType.VISA);
		try {
			credentials.setExpiry (new Date (System
					.currentTimeMillis ()
					+ 60 * 60 * 24 * 30));
		} catch (final CredentialExpiredException e1) {
			AppiusClaudiusCaecus
					.fatalBug (
							"Caught a CredentialExpiredException in isAvailable",
							e1);
		}
		AimConfig authNet;
		try {
			authNet = new AimConfig ();
		} catch (final AuthNetException e) {
			AppiusClaudiusCaecus.reportBug (e);
			return false;
		}

		final AimTransaction xact = authNet.newTransaction ();
		xact.setAmount ("1.00");
		// xact.setAuthCode ("unused...");

		xact.setBillAddress ("123 Sesame St");
		xact.setBillCity ("Titusville");
		xact.setBillStateName ("FL");
		xact.setBillCountry ("US");
		xact.setBillZip ("32780");

		xact.setBillFirstName ("John");
		xact.setBillLastName ("Doe");
		xact.setBillOrg ("Sidereal");
		xact.setCustId ("test-000");
		xact
				.setEmail ("brpocock@star-hope.org+authnet+test@star-hope.org");

		try {
			credentials.applyTo (xact);
		} catch (final UnsupportedCredentialException e1) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a UnsupportedCredentialException in isAvailable",
							e1);
			return false;
		}

		xact.setDescription ("Testing if Authorize.Net is alive");
		xact.setInvoiceNum ("test-"
				+ String.format ("%x", Long.valueOf (System
						.currentTimeMillis ())));

		xact.setShipAddress ("227 Main St");
		xact.setShipCity ("Franklin");
		xact.setShipCountry ("US");
		xact.setShipFirstName ("Jane");
		xact.setShipLastName ("Jones");
		xact.setShipOrg ("AnyCorp");
		xact.setShipStateName ("MA");
		xact.setShipZip ("02038");

		xact.setTestMode (true);
		try {
			xact.validateInput ("visa");
		} catch (final AuthNetException e) {
			AppiusClaudiusCaecus.reportBug (e);
			return false;
		}

		try {
			xact.submit ();
		} catch (final IOException e) {
			AppiusClaudiusCaecus.reportBug (e);
			return false;
		}

		try {
			xact.checkMd5Hash ();
		} catch (final AuthNetException e) {
			AppiusClaudiusCaecus.reportBug (
					"Warning only: MD5 mismatch", e);
			// return false;
		}

		try {
			xact.postPurchase ();
		} catch (final AuthNetException e) {
			AppiusClaudiusCaecus.reportBug (e);
			return false;
		}

		return true;

	}

	/**
	 * Sets the user for this transaction to either the given user, or
	 * (if the given user is not an adult), his/her parent.
	 * <p>
	 * This method <em>does not work</em> right now.
	 * </p>
	 *
	 * @param possibleUser The user or child of the user to be set
	 */
	@Deprecated
	public void setUser (final GeneralUser possibleUser) {
		// if (possibleUser.getAgeGroup () != AgeBracket.Adult) {
		// user = possibleUser.getParent ();
		// return;
		// }
		// user = possibleUser;
	}

	/**
	 * Start an Authorize.Net subscription through their
	 * (now-beautiful!! WTF?) Automated Recurring Billing engine.
	 *
	 * @param payment WRITEME
	 * @throws UnsupportedCurrencyException WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws UnsupportedCredentialException WRITEME
	 * @throws IOException WRITEME
	 * @throws RetryPaymentException WRITEME
	 * @throws GameLogicException WRITEME
	 * @throws AlreadyUsedException WRITEME
	 */
	@Override
	public void startEnrolment (final Payment payment)
			throws UnsupportedCurrencyException, NotFoundException,
			UnsupportedCredentialException, IOException,
			RetryPaymentException, GameLogicException,
			AlreadyUsedException {

		if (AppiusConfig
				.getConfigBoolOrFalse ("net.authorize.testMode")) {
			return;
		}

		final UserEnrolment paymentFor = payment.getUserEnrolment ();
		final PaymentCredential credentials = payment.getCredentials ();

		if (paymentFor == null) {
			throw new IllegalStateException (
					"Payment is not for an enrolment");
		}

		final Enrolment enrolment = paymentFor.getEnrolment ();

		if (enrolment.isAvailable () == false) {
			throw new NotFoundException (
					"The requested enrolment type is not available.");
		}
		if ( !enrolment.getCurrency ().getSymbol ().equals (
				Currency.get_USD ().getSymbol ())) {
			throw new UnsupportedCurrencyException (
					"The subscription system currently only operates on U.S. Dollars (USD)");
		}

		final BigDecimal scaledAmount;
		try {
			scaledAmount = enrolment.getPrice ().setScale (2,
					BigDecimal.ROUND_UNNECESSARY);
		} catch (final ArithmeticException e) {
			throw new UnsupportedCurrencyException (LibMisc
					.getText ("one_cent_accuracy"));
		}

		switch (credentials.getCredentialType ()) {
		case VISA:
		case MC:
			// OK
			break;
		default:
			throw new UnsupportedCredentialException (this.getClass (),
					credentials.getCredentialType (), LibMisc
							.getText ("onlyVisaOrMC"));
		}

		/*
		 * Create the ARB data
		 */
		final ARBAPI api = getARBAPI ();

		/*
		 * Billing name and address information
		 */

		address = credentials.getAddress ();
		if (null == address) {
			System.err.println ("Address data is null");
		}

		final ARBNameAndAddress billTo = new ARBNameAndAddress ();
		billTo.setFirstName (credentials.getBuyerGivenName ());
		billTo.setLastName (credentials.getBuyerFamilyName ());
		// billTo.setCompany (buyerCompany);
		if (null == address) {
			throw new NotFoundException ("address not specified");
		}
		billTo.setAddress (address.getAddress ());
		billTo.setCity (address.getCity ());
		billTo.setState (address.getProvince ());
		billTo.setCountry (address.getCountry ());
		billTo.setZip (address.getPostalCode ());

		/*
		 * The customer ID and eMail, plus name & address.
		 */

		final ARBCustomer customer = new ARBCustomer ();
		customer.setBillTo (billTo);
		customer.setDriversLicenseSpecified (false);
		customer.setEmail (address.getMail ());
		customer.setPhoneNumber (address.getPhone ());
		customer.setId (String.valueOf (paymentFor.getUserID ()));

		/*
		 * Credit-card information is secret!
		 */

		final ARBOrder order = new ARBOrder ();
		order.setInvoiceNumber (paymentFor.getInvoiceID ());
		order.setDescription (paymentFor.getDescription ());

		final ARBPayment arbPayment = new ARBPayment ();
		credentials.applyTo (arbPayment);

		/*
		 * Payment schedule
		 */

		final ARBPaymentSchedule schedule = new ARBPaymentSchedule ();

		if (enrolment.getPrivilegeMonths () > 0) {
			schedule
					.setIntervalLength (enrolment.getPrivilegeMonths ());
			schedule.setSubscriptionUnit ("months");
		} else {
			schedule.setIntervalLength (enrolment.getPrivilegeDays ());
			schedule.setSubscriptionUnit ("days");
		}

		if (payment.isTest ()) {
			schedule.setStartDate (new Date (System
					.currentTimeMillis () + 528400000L));
		} else {
			schedule.setStartDate (paymentFor.getRecurs ());
		}

		// 9999 means an unlimited amount of charges, this transaction
		// with continue billing forever until canceled
		schedule.setTotalOccurrences (9999);
		schedule.setTrialOccurrences (0);

		/*
		 * The actual subscription object
		 */

		final ARBSubscription subscription = new ARBSubscription ();
		subscription.setBillTo (billTo);
		subscription.setAmount (scaledAmount);
		subscription.setOrder (order);
		subscription.setCustomer (customer);
		subscription.setPayment (arbPayment);
		subscription.setSchedule (schedule);
		subscription.setName (enrolment.getTitle ());

		/*
		 * Send it out
		 */

		api.createSubscriptionRequest (subscription);
		// System.out.println (api.getCurrentRequest ().dump ());
		api.sendRequest ();

		/*
		 * Collect the response/results
		 */

		try {
			api.printMessages ();
			payment.addAnnotation ("net.authorize.arb.subscriptionID",
					api.getResultSubscriptionId ());
			payment.addAnnotation ("net.authorize.arb.subscribe", api
					.getResultCode ());
			payment.addAnnotation ("net.authorize.arb.messages", api
					.getMessages ());

			try {
				paymentFor
						.setAuthSubID (api.getResultSubscriptionId ());
			} catch (final NumberFormatException e) {
				AppiusClaudiusCaecus.reportBug (e);
			}

			try {
				payment.close ();
			} catch (final SQLException e) {
				AppiusClaudiusCaecus.reportBug (
						"Post-processing error in Payment class!", e);
			}
		} catch (final AlreadyUsedException e) {
			AppiusClaudiusCaecus.reportBug (
					"Post-processing error in Payment class!", e);
		} catch (final NumberFormatException e) {
			paymentFor.setAuthSubID ("000000");
			payment.addAnnotation ("net.authorize.arb.error", api
					.getResultCode ());

		}

		/*
		 * Get out of there
		 */

		api.destroy ();
		// }

	}

	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#startTransaction(org.starhope.appius.mb.Payment)
	 */
	@Override
	public void startTransaction (final Payment payment)
			throws UnsupportedCurrencyException, NotFoundException,
			UnsupportedCredentialException, IOException,
			RetryPaymentException, GameLogicException,
			AlreadyUsedException, DataException {
		try {
			transactPayment (payment);
			if (payment.getUserEnrolment ().isRecurring ()) {
				startEnrolment (payment);
			}
		} catch (final RuntimeException e) {
			AppiusClaudiusCaecus.reportBug (
					"Runtime exception in startTransaction.", e);
		} finally {
			payment.shredCredentials ();
		}
	}
	
	/**
	 * @param payment payment
	 * @throws UnsupportedCurrencyException if the payment is not
	 *             expressed in USD or if the scale is less than 1¢. We
	 *             re-throw an {@link ArithmeticException} from
	 *             {@link java.math.BigDecimal#setScale} (q.v. for
	 *             remarks) if setting the scale to "2" (thus, 1¢
	 *             increments) would induce rounding.
	 * @throws NotFoundException if the buyer or address aren't found or
	 *             mismatch in some exciting way
	 * @throws UnsupportedCredentialException if a type of payment
	 *             credentials are presented which we don't support.
	 *             This shouldn't happen, since we enumerate supported
	 *             types in enumerateCredentialTypes specifically to
	 *             prevent that.
	 * @throws IOException if a connection to Authorize.Net can't be
	 *             established due to a network failure or similar
	 *             problem.
	 * @throws RetryPaymentException if the payment can't be processed
	 *             right now, but we should retry after a few minutes.
	 * @throws GameLogicException if the payment has already been
	 *             completed
	 * @throws AlreadyUsedException if the Payment object is already
	 *             closed (used)
	 * @throws DataException if Authorize.Net rejects the payment
	 */
	@Override
	public void transactPayment (final Payment payment)
			throws UnsupportedCurrencyException, NotFoundException,
			UnsupportedCredentialException, IOException,
			RetryPaymentException, GameLogicException,
			AlreadyUsedException, DataException {

		/*
		 * Validate some basic information.
		 */

		if (payment.isClosed ()) {
			AppiusClaudiusCaecus.blather (payment.toString ()
					+ " is already closed!");
			throw new AlreadyUsedException ("Payment closed", payment
					.getStamp ());
		}

		final PaymentCredential credentials = payment.getCredentials ();

		/*
		 * Find the applicable enrolment
		 */

		final UserEnrolment userEnrolment = payment.getUserEnrolment ();

		/*
		 * Payment amount. No rounding!
		 */

		final BigDecimal scaledPayment;
		try {
			if (null == userEnrolment.getAmount ()) {
				throw new GameLogicException ("No freebies!",
						userEnrolment, Integer.valueOf (0));
			}
			scaledPayment = userEnrolment.getAmount ().setScale (2,
					BigDecimal.ROUND_UNNECESSARY);
			AppiusClaudiusCaecus.blather ("Setting "
					+ payment.toString () + " price to: "
					+ scaledPayment);
		} catch (final ArithmeticException e) {
			System.err.println ("Unsupported exception: ["
					+ userEnrolment.getAmount () + "]");
			throw new UnsupportedCurrencyException (LibMisc
					.getText ("one_cent_accuracy"));
		}

		/*
		 * Instantiate the request stuff.
		 */
		AimConfig authNet;
		try {
			authNet = new AimConfig ();
		} catch (final AuthNetException e) {
			AppiusClaudiusCaecus.reportBug (e);
			throw new Error (e);
		}

		final AimTransaction xact = authNet.newTransaction ();
		xact.setAmount (scaledPayment.toPlainString ());
		payment.setPrice (scaledPayment);
		// xact.setAuthCode ("unused");

		/*
		 * Validation now that payment is set
		 */
		if ( !"USD".equals (payment.getCurrency ().getCode ())) {
			throw new UnsupportedCurrencyException (
					"The payment engine only supports payments in US Dollars (USD) right now.");
		}

		switch (credentials.getCredentialType ()) {
		case VISA:
		case MC:
			// OK
			break;
		default:
			throw new UnsupportedCredentialException (this.getClass (),
					credentials.getCredentialType (),
					"The subscription system only supports VISA or MasterCard, sorry.");
		}

		address = credentials.getAddress ();
		if (null == address) {
			throw new NotFoundException ("address not specified");
		}

		xact.setBillAddress (address.getAddress ());
		xact.setBillCity (address.getCity ());
		xact.setBillStateName (address.getProvince ());
		xact.setBillCountry (address.getCountry ());
		xact.setBillZip (address.getPostalCode ());

		xact.setBillFirstName (credentials.getBuyerGivenName ());
		xact.setBillLastName (credentials.getBuyerFamilyName ());
		xact.setCustId (String.valueOf (userEnrolment.getUserID ()));
		xact.setEmail (address.getMail ());
		xact.setPhone (address.getPhone ());

		credentials.applyTo (xact);

		xact.setDescription (userEnrolment.getTitle ());
		xact.setInvoiceNum (userEnrolment.getInvoiceID ());

		/*
		 * if (paymentFor instanceof ShippingInvoice) { final
		 * ShippingInvoice ship = (ShippingInvoice) paymentFor; final
		 * User shipToUser = ship.getShipToUser ();
		 * xact.setShipFirstName (shipToUser.getGivenName ());
		 * xact.setShipLastName (shipToUser.getFamilyName ());
		 * xact.setShipOrg (ship.getShipToOrganization ()); final
		 * UserAddress shipToAddress = ship.getShipToAddress ();
		 * xact.setShipAddress (shipToAddress.getAddressPair ());
		 * xact.setShipCity (shipToAddress.getCity ());
		 * xact.setShipStateName (shipToAddress.getProvince ());
		 * xact.setShipZip (shipToAddress.getPostalCode ());
		 * xact.setShipCountry (shipToAddress.getCountry ()); } else {
		 */
		xact.setShipAddress ("");
		xact.setShipCity ("");
		xact.setShipCountry ("");
		xact.setShipFirstName ("");
		xact.setShipLastName ("");
		xact.setShipOrg ("");
		xact.setShipStateName ("");
		xact.setShipZip ("");

		xact.setTestMode (AppiusConfig
				.getConfigBoolOrFalse ("net.authorize.testMode"));
		xact.setType ("AUTH_CAPTURE");

		System.err.println ("ACTUAL TRANSACTION TEST MODE? "
				+ xact.getTestMode ());

		try {
			switch (credentials.getCredentialType ()) {
			case VISA:
				xact.validateInput ("visa");
				payment.setPaymentFor ("ENROL");
				break;
			case MC:
				xact.validateInput ("mc");
				payment.setPaymentFor ("ENROL");
				break;
			case AMEX:
				xact.validateInput ("amex");
				payment.setPaymentFor ("ENROL");
				break;
			case NOVUS:
				xact.validateInput ("disc");
				payment.setPaymentFor ("ENROL");
				break;
			default:
				payment.setPaymentFor ("NIL");
				final UnsupportedCredentialException e = new UnsupportedCredentialException (
						this.getClass (),
						credentials.getCredentialType (),
						"The credentials are in a format not "
								+ "supported by the transaction software.");
				AppiusClaudiusCaecus.reportBug (
						"This should be unreachable code. "
								+ "I've already checked this before.",
						e);
				throw e;
			}
		} catch (final AuthNetException e) {
			AppiusClaudiusCaecus.reportBug (
					"Unable to process a CC transaction for CC type: "
							+ credentials.getCredentialType (), e);
			payment.setSuccess (false);
			payment.setTest (xact.getTestMode ());
			payment.setResultReason ("CC IS INVALID");
			try {
				payment.addAnnotation (
						"net.authorize.exception.validation",
						"Exception thrown in validation");
				e.printStackTrace ();
			} catch (final AlreadyUsedException e1) {
				AppiusClaudiusCaecus.reportBug (e1);
			}
			try {
				payment.close ();
			} catch (final SQLException e1) {
				// Default catch action, report bug (twheys@gmail.com,
				// Sep 18,
				// 2009)
				AppiusClaudiusCaecus.fatalBug (e1);
			}
			throw new DataException (e.getMessage ());
		}

		try {
			xact.submit ();
			payment.setResultReason (xact.getRRtext ());
			System.out.println (payment.getResultReason ());
		} catch (final Exception e) {
			AppiusClaudiusCaecus.reportBug (e);
			payment.setSuccess (false);
			payment.setTest (xact.getTestMode ());
			payment.setResultReason (xact.getRRtext ());
			System.err.println (payment.getResultReason ());
			try {
				payment.addAnnotation ("net.authorize.exception.xact",
						"Exception thrown in transaction");
			} catch (final AlreadyUsedException e1) {
				AppiusClaudiusCaecus.reportBug (e1);
			}
			try {
				payment.close ();
			} catch (final SQLException e1) {
				AppiusClaudiusCaecus.fatalBug (e1);
			}
			throw new DataException (LibMisc.getText ("cc_bad"));
		}

		try {
			xact.checkMd5Hash ();
			payment.setVerified (true);
		} catch (final AuthNetException e) {
			payment.setVerified (false);
			payment.addAnnotation (
					"net.authorize.exception.md5hash.authnet",
					"Exception thrown checking MD5 hash!");
			payment.addAnnotation (
					"net.authorize.exception.md5hash.message", e
							.getMessage ());
			AppiusClaudiusCaecus
					.reportBug ("Possible attempt to bypass security!"
							+ "\n\n" + "I'm allowing this transaction "
							+ "to continue, and entering it "
							+ "into the database, but the MD5 "
							+ "checksum returned from the "
							+ "Authorize.Net servers "
							+ "*** DOES NOT VALIDATE. ***" + "\n\n"
							+ "This is likely to indicate an "
							+ "attempt to forge a response, "
							+ "possibly violating the "
							+ "integrity of customer data. " + "\n\n"
							+ "**********************************\n"
							+ "* THIS IS A VERY, VERY BIG DEAL. *\n"
							+ "**********************************\n", e);
		}

		try {
			xact.postPurchase ();
			payment.stamp ();
			payment.setSuccess (true);
			payment.setTest (xact.getTestMode ());
		} catch (final AuthNetException e) {
			payment.setSuccess (false);
			payment.setTest (xact.getTestMode ());
			payment.addAnnotation (
					"net.authorize.exception.postPurchase",
					"Exception thrown checking MD5 hash!");
			payment.addAnnotation (
					"net.authorize.exception.postPurchase.message", e
							.getMessage ());
			payment.setResultReason (xact.getRRtext ());
			try {
				payment.close ();
			} catch (final SQLException e1) {
				AppiusClaudiusCaecus.fatalBug (e1);
			}
			throw new DataException (e.getMessage ());
		}

		/*
		 * Put together the results.
		 */

		final String msg;

		final BigDecimal paidAmt = xact.getAmount ().setScale (2,
				BigDecimal.ROUND_UNNECESSARY);
		switch (payment.getPrice ().compareTo (paidAmt)) {
		case -1:
			msg = "Received more money than asked for, wanted "
					+ payment.getPrice ().toPlainString ()
					+ " and got " + paidAmt;
			payment.addAnnotation ("net.authorize.overpaid", msg);
			AppiusClaudiusCaecus.reportBug (msg);
			break;
		case 0:
			// all's well. no op.
			break;
		case 1:
			msg = "Received less money than asked for, wanted "
					+ payment.getPrice ().toPlainString ()
					+ " and got " + paidAmt;
			payment.addAnnotation ("net.authorize.underpaid", msg);
			AppiusClaudiusCaecus.reportBug (msg);
			// proceed anyways, for now.
			break;
		default:
			msg = "Can't tell how much money we got paid? wanted "
					+ payment.getPrice ().toPlainString ()
					+ " and got " + paidAmt;
			payment.addAnnotation ("net.authorize.didWeGetPaidOrWhat",
					msg);
			AppiusClaudiusCaecus.reportBug (msg);

		}
		payment.setPaid (paidAmt);
		payment.setResultReason (xact.getRRtext ());
		payment.setGatewayTransactionCode (xact.getTransId ());
		payment.addAnnotation ("net.authorize.rCode", "R:"
				+ xact.getRcode ());
		payment.addAnnotation ("net.authorize.rrCode", "RR:"
				+ xact.getRRcode ());
		payment.addAnnotation ("net.authorize.rrText", xact
				.getRRtext ());
		payment.addAnnotation ("net.authorize.transactionType", xact
				.getTransType ());

		/*
		 * AVS last. For two reasons. First, it's a long, ugly block.
		 * Second, it's one of the places where we might want to throw
		 * that retry exception, so we want to do it last, so the other
		 * values are already saved.
		 */
		AddressVerificationCode avsCode;
		switch (xact.getAVS ()) {
		case 'A':
			avsCode = AddressVerificationCode.ADDRESS_OK_ZIP_BAD;
			break;
		case 'B':
			avsCode = AddressVerificationCode.ADDRESS_NOT_PROVIDED;
			break;
		case 'C':
			avsCode = AddressVerificationCode.NON_US_ADDRESS;
			break;
		case 'D':
			avsCode = AddressVerificationCode.NON_US_STREET_AND_POSTAL_OK;
			break;
		case 'E':
			avsCode = AddressVerificationCode.AVS_ERROR;
			break;
		case 'G':
			avsCode = AddressVerificationCode.NON_US_BANK;
			break;
		case 'N':
			avsCode = AddressVerificationCode.ADDRESS_AND_ZIP_MISMATCH;
			break;
		case 'P':
			avsCode = AddressVerificationCode.AVS_NOT_APPLICABLE;
			break;
		case 'R':
			avsCode = AddressVerificationCode.AVS_SYSTEM_UNAVAIL_RETRY;
			// Stash it now, so we can retry via Exception
			payment.addAnnotation ("net.authorize.avsCode", avsCode
					.toString ());

			throw new RetryPaymentException (AppiusConfig
					.getConfigOrDefault (
							"net.authorize.avs.retryTitle",
							"Identity fraud Prevention At Work"),
					AppiusConfig.getConfigOrDefault (
							"net.authorize.avs.retryMessage", LibMisc
									.getText ("retry_payment")),
					payment);
		default:
			avsCode = AddressVerificationCode.INVALID_AVS;
		}
		payment.addAnnotation ("net.authorize.avsCode", avsCode
				.toString ());

		try {
			payment.close ();
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.fatalBug (e);
		}
	}
}
