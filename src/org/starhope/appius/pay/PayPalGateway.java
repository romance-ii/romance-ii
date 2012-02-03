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

package org.starhope.appius.pay;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.Payment;
import org.starhope.appius.mb.UserAddress;
import org.starhope.appius.mb.UserEnrolment;
import org.starhope.appius.pay.util.CredentialType;
import org.starhope.appius.pay.util.PaymentGatewayReal;
import org.starhope.appius.pay.util.RetryPaymentException;
import org.starhope.appius.pay.util.UnsupportedCredentialException;
import org.starhope.appius.pay.util.UnsupportedCurrencyException;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.util.AppiusConfig;

import com.paypal.sdk.core.nvp.NVPDecoder;
import com.paypal.sdk.core.nvp.NVPEncoder;
import com.paypal.sdk.exceptions.PayPalException;
import com.paypal.sdk.profiles.APIProfile;
import com.paypal.sdk.profiles.ProfileFactory;
import com.paypal.sdk.services.NVPCallerServices;

/**
 * @author brpocock@star-hope.org
 */
public class PayPalGateway implements PaymentGatewayReal {
	
	/**
	 * PayPal NVP interface
	 */
	private NVPCallerServices caller = null;
	/**
	 * PayPal API profile
	 */
	private APIProfile profile = null;
	
	/**
	 * Constructor
	 */
	public PayPalGateway () {
		caller = new NVPCallerServices ();

		/*
		 * WARNING: Do not embed plaintext credentials in your
		 * application code. Doing so is insecure and against best
		 * practices. Your API credentials must be handled securely.
		 * Please consider encrypting them for use in any production
		 * environment, and ensure that only authorized individuals may
		 * view or modify them.
		 */

		try {
			profile = ProfileFactory.createSignatureAPIProfile ();
		} catch (final PayPalException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		}
		try {
			profile.setAPIUsername (AppiusConfig.getConfigOrDefault (
					"com.paypal.sdk.apiUsername",
			"sdk-three_api1.sdk.com"));
			profile.setAPIPassword (AppiusConfig.getConfigOrDefault (
					"com.paypal.sdk.apiPassword", "QFZCWN5HZM8VBG7Q"));
			profile
			.setSignature (AppiusConfig
					.getConfigOrDefault (
							"com.paypal.sdk.signature",
					"A.d9eRKfd1yVkRrtmMfCFLTqa6M9AyodL0SJkhYztxUi8W9pCXF6.4NI"));
			profile.setEnvironment (AppiusConfig.getConfigOrDefault (
					"com.paypal.sdk.environment", "sandbox"));
		} catch (final PayPalException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		}

		profile.setSubject ("");

		try {
			caller.setAPIProfile (profile);
		} catch (final PayPalException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		}
	}

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
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#endEnrolment(org.starhope.appius.mb.Payment)
	 */
	@Override
	public void endEnrolment (final Payment payment)
	throws UnsupportedCurrencyException, NotFoundException,
	UnsupportedCredentialException, IOException,
	RetryPaymentException, GameLogicException {
		// TODO Auto-generated method stub

	}
	
	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#enumerateCredentialTypes()
	 */
	@Override
	public List <CredentialType> enumerateCredentialTypes () {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#getOrderSourceCode()
	 */
	@Override
	public String getOrderSourceCode () {
		return "ppal";
	}

	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#getPayment(java.math.BigDecimal)
	 */
	@Override
	public Payment getPayment (final BigDecimal bigDecimal) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 *
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#isAvailable()
	 */
	@Override
	public boolean isAvailable () {
		// TODO Auto-generated method stub
		return false;
	}

	/**
	 * @param title WRITEME
	 */
	public void setTitle (final String title) {
		// TODO Auto-generated method stub

	}

	/**
	 * @param userPurchasing WRITEME
	 */
	public void setUser (final GeneralUser userPurchasing) {
		// TODO Auto-generated method stub

	}

	/**
	 *
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#startEnrolment(org.starhope.appius.mb.Payment)
	 */
	@Override
	public void startEnrolment (final Payment payment)
	throws UnsupportedCurrencyException, NotFoundException,
	UnsupportedCredentialException, IOException,
	RetryPaymentException, GameLogicException {

		System.out
		.println ("\n########## Starting CreateRecurringPaymentsProfile ##########\n");

		final NVPEncoder encoder = new NVPEncoder ();
		// FIXME!!!
		final String token = "RP-7SL9714342686113K";
		encoder.add ("METHOD", "CreateRecurringPaymentsProfile");
		encoder.add ("TOKEN", token);
		encoder.add ("AMT", payment.getPrice ().toString ());
		encoder.add ("PROFILESTARTDATE", "2009-11-16T12:00:00M"); // FIXME
		encoder.add ("BILLINGPERIOD", "Day");
		encoder.add ("BILLINGFREQUENCY", "1");
		encoder.add ("VERSION", "51.0");

		String strNVPRequest = null;
		try {
			strNVPRequest = encoder.encode ();
		} catch (final PayPalException e1) {
			AppiusClaudiusCaecus.fatalBug (e1);
		}
		/*
		 * call method will send the request to the server and return
		 * the response NVPString
		 */
		String response = null;
		try {
			response = caller.call (strNVPRequest);
		} catch (final PayPalException e1) {
			AppiusClaudiusCaecus.fatalBug (e1);
		}

		// NVPDecoder object is created
		final NVPDecoder resultValues = new NVPDecoder ();

		try {
			/*
			 * decode method of NVPDecoder will parse the request and
			 * decode the name and value pair
			 */
			resultValues.decode (response);
		} catch (final Exception e) {

			e.printStackTrace ();

		}

		/*
		 * checks for Acknowledgment and redirects accordingly to
		 * display error messages
		 */
		final String strAck = resultValues.get ("ACK");
		if (strAck != null
				&& ! (strAck.equals ("Success") || strAck
						.equals ("SuccessWithWarning"))) {
			// do error processing
			System.out
			.println ("\n########## CreateRecurringPaymentsProfile call failed ##########\n");
		} else {
			// success
			System.out
			.println ("\n########## CreateRecurringPaymentsProfile call passed ##########\n");
		}
	}

	/**
	 *
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#startTransaction(org.starhope.appius.mb.Payment)
	 */
	@Override
	public void startTransaction (final Payment payment)
	throws UnsupportedCurrencyException, NotFoundException,
	UnsupportedCredentialException, IOException,
	RetryPaymentException, GameLogicException,
	AlreadyUsedException {
		// TODO Auto-generated method stub (twheys@gmail.com, Oct 1, 2009)

	}
	
	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#transactPayment(org.starhope.appius.mb.Payment)
	 */
	@Override
	public void transactPayment (final Payment payment)
	throws UnsupportedCurrencyException, NotFoundException,
	UnsupportedCredentialException, IOException,
	RetryPaymentException, GameLogicException,
	AlreadyUsedException {
		final NVPEncoder encoder = new NVPEncoder ();
		encoder.add ("VERSION", "51.0");
		encoder.add ("METHOD", "DoDirectPayment");

		// Add request-specific fields to the request string.
		encoder.add ("PAYMENTACTION", "paymentActionFIXME");
		encoder.add ("AMT", payment.getPrice ().toPlainString ());
//		 payment.getCredentials ().populate (encoder);
		encoder.add ("FIRSTNAME", payment.getPayer ());
		encoder.add ("LASTNAME", "FIXME");

		 final UserAddress billingAddress = payment.getCredentials ().getAddress ();
		 encoder.add ("STREET",
		 billingAddress.getAddress () + " " +
		 billingAddress.getAddress2 ()); encoder.add ("CITY",
		 billingAddress.getCity ()); encoder.add ("STATE",
		 billingAddress.getProvince ()); encoder.add ("ZIP",
		 billingAddress.getPostalCode ()); encoder.add ("COUNTRYCODE",
		 billingAddress.getCountry ());

		// Execute the API operation and obtain the response.
		String NVPRequest = null;
		try {
			NVPRequest = encoder.encode ();
		} catch (final PayPalException e) {
			// TODO Auto-generated catch block
			AppiusClaudiusCaecus.reportBug (e);
		}
		String NVPResponse = "";
		try {
			NVPResponse = caller.call (NVPRequest);
		} catch (final PayPalException e) {
			// TODO Auto-generated catch block
			AppiusClaudiusCaecus.reportBug (e);
		}
		final NVPDecoder decoder = new NVPDecoder ();
		try {
			decoder.decode (NVPResponse);
		} catch (final PayPalException e) {
			// TODO Auto-generated catch block
			AppiusClaudiusCaecus.reportBug (e);
		}
		// FIXME
	}
}
