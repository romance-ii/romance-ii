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
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package net.authorize.arb;

import java.math.BigDecimal;
import java.net.URL;
import java.util.ArrayList;

import net.authorize.arb.http.HttpUtil;
import net.authorize.arb.util.BasicXmlDocument;

import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

/**
 * WRITEME
 */
public class ARBAPI {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (ARBAPI.class);
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) current_request (ARBAPI)
	 */
	private BasicXmlDocument current_request = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) current_response (ARBAPI)
	 */
	private BasicXmlDocument current_response = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) http_util (ARBAPI)
	 */
	private HttpUtil http_util = null;
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) merchant_name (ARBAPI)
	 */
	private String merchant_name = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) messages (ARBAPI)
	 */
	private ArrayList <Message> messages = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) result_code (ARBAPI)
	 */
	private String result_code = null;
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) result_subscription_id (ARBAPI)
	 */
	private String result_subscription_id = null;
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) transaction_key (ARBAPI)
	 */
	private String transaction_key = null;
	
	/**
	 * @param in_api_url WRITEME
	 * @param in_merchant_name WRITEME
	 * @param in_transaction_key WRITEME
	 */
	public ARBAPI (final URL in_api_url,
			final String in_merchant_name,
			final String in_transaction_key) {
		
		messages = new ArrayList <Message> ();
		
		merchant_name = in_merchant_name;
		transaction_key = in_transaction_key;
		http_util = new HttpUtil (in_api_url);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param document WRITEME
	 */
	private void addAuthenticationToRequest (
			final BasicXmlDocument document) {
		final Element auth_el = document
				.createElement (ARBAPIRequests.ELEMENT_MERCHANT_AUTHENTICATION);
		final Element name_el = document
				.createElement (ARBAPIRequests.ELEMENT_NAME);
		name_el.appendChild (document.getDocument ().createTextNode (
				merchant_name));
		final Element trans_key = document
				.createElement (ARBAPIRequests.ELEMENT_TRANSACTION_KEY);
		trans_key.appendChild (document.getDocument ()
				.createTextNode (transaction_key));
		auth_el.appendChild (name_el);
		auth_el.appendChild (trans_key);
		document.getDocumentElement ().appendChild (auth_el);
		
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param document WRITEME
	 * @param subscription WRITEME
	 * @param subscr_el WRITEME
	 */
	private void addBillingInfoToSubscription (
			final BasicXmlDocument document,
			final ARBSubscription subscription,
			final Element subscr_el) {
		if (subscription.getBillTo () == null) {
			return;
		}
		final ARBNameAndAddress bill_info = subscription.getBillTo ();
		final Element bill_el = document
				.createElement (ARBAPIRequests.ELEMENT_BILL_TO);
		
		final Element fname_el = document
				.createElement (ARBAPIRequests.ELEMENT_FIRST_NAME);
		fname_el.appendChild (document.getDocument ().createTextNode (
				bill_info.getFirstName ()));
		bill_el.appendChild (fname_el);
		
		final Element lname_el = document
				.createElement (ARBAPIRequests.ELEMENT_LAST_NAME);
		lname_el.appendChild (document.getDocument ().createTextNode (
				bill_info.getLastName ()));
		bill_el.appendChild (lname_el);
		
		if (bill_info.getCompany () != null) {
			final Element company_el = document
					.createElement (ARBAPIRequests.ELEMENT_COMPANY);
			company_el.appendChild (document.getDocument ()
					.createTextNode (bill_info.getCompany ()));
			bill_el.appendChild (company_el);
		}
		
		if (bill_info.getAddress () != null) {
			final Element address_el = document
					.createElement (ARBAPIRequests.ELEMENT_ADDRESS);
			address_el.appendChild (document.getDocument ()
					.createTextNode (bill_info.getAddress ()));
			bill_el.appendChild (address_el);
		}
		
		if (bill_info.getCity () != null) {
			final Element city_el = document
					.createElement (ARBAPIRequests.ELEMENT_CITY);
			city_el.appendChild (document.getDocument ()
					.createTextNode (bill_info.getCity ()));
			bill_el.appendChild (city_el);
		}
		
		if (bill_info.getState () != null) {
			final Element state_el = document
					.createElement (ARBAPIRequests.ELEMENT_STATE);
			state_el.appendChild (document.getDocument ()
					.createTextNode (bill_info.getState ()));
			bill_el.appendChild (state_el);
		}
		
		if (bill_info.getZip () != null) {
			final Element zip_el = document
					.createElement (ARBAPIRequests.ELEMENT_ZIP);
			zip_el.appendChild (document.getDocument ()
					.createTextNode (bill_info.getZip ()));
			bill_el.appendChild (zip_el);
		}
		
		if (bill_info.getCountry () != null) {
			final Element country_el = document
					.createElement (ARBAPIRequests.ELEMENT_COUNTRY);
			country_el.appendChild (document.getDocument ()
					.createTextNode (bill_info.getCountry ()));
			bill_el.appendChild (country_el);
		}
		
		subscr_el.appendChild (bill_el);
		
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param document WRITEME
	 * @param subscription WRITEME
	 * @param subscr_el WRITEME
	 */
	private void addCustomerInfoToSubscription (
			final BasicXmlDocument document,
			final ARBSubscription subscription,
			final Element subscr_el) {
		if (subscription.getCustomer () == null) {
			return;
		}
		final ARBCustomer cust_info = subscription.getCustomer ();
		final Element cust_el = document
				.createElement (ARBAPIRequests.ELEMENT_CUSTOMER);
		
		if (cust_info.getId () != null) {
			final Element custId_el = document
					.createElement (ARBAPIRequests.ELEMENT_ID);
			custId_el.appendChild (document.getDocument ()
					.createTextNode (cust_info.getId ()));
			cust_el.appendChild (custId_el);
		}
		
		if (cust_info.getEmail () != null) {
			final Element email_el = document
					.createElement (ARBAPIRequests.ELEMENT_EMAIL);
			email_el.appendChild (document.getDocument ()
					.createTextNode (cust_info.getEmail ()));
			cust_el.appendChild (email_el);
		}
		
		if (cust_info.getPhoneNumber () != null) {
			final Element phone_el = document
					.createElement (ARBAPIRequests.ELEMENT_PHONE_NUMBER);
			phone_el.appendChild (document.getDocument ()
					.createTextNode (cust_info.getPhoneNumber ()));
			cust_el.appendChild (phone_el);
		}
		
		if (cust_info.getFaxNumber () != null) {
			final Element fax_el = document
					.createElement (ARBAPIRequests.ELEMENT_FAX_NUMBER);
			fax_el.appendChild (document.getDocument ()
					.createTextNode (cust_info.getFaxNumber ()));
			cust_el.appendChild (fax_el);
		}
		
		subscr_el.appendChild (cust_el);
		
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param document WRITEME
	 * @param subscription WRITEME
	 * @param subscr_el WRITEME
	 */
	private void addOrderInfoToSubscription (
			final BasicXmlDocument document,
			final ARBSubscription subscription,
			final Element subscr_el) {
		if (subscription.getOrder () == null) {
			return;
		}
		final ARBOrder ord_info = subscription.getOrder ();
		final Element ord_el = document
				.createElement (ARBAPIRequests.ELEMENT_ORDER);
		
		if (ord_info.getInvoiceNumber () != null) {
			final Element invoice_el = document
					.createElement (ARBAPIRequests.ELEMENT_INVOICE_NUMBER);
			invoice_el.appendChild (document.getDocument ()
					.createTextNode (ord_info.getInvoiceNumber ()));
			ord_el.appendChild (invoice_el);
		}
		
		if (ord_info.getDescription () != null) {
			final Element descript_el = document
					.createElement (ARBAPIRequests.ELEMENT_DESCRIPTION);
			descript_el.appendChild (document.getDocument ()
					.createTextNode (ord_info.getDescription ()));
			ord_el.appendChild (descript_el);
		}
		
		subscr_el.appendChild (ord_el);
		
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param document WRITEME
	 * @param subscription WRITEME
	 * @param subscr_el WRITEME
	 */
	private void addPaymentScheduleToSubscription (
			final BasicXmlDocument document,
			final ARBSubscription subscription,
			final Element subscr_el) {
		final ARBPaymentSchedule schedule = subscription
				.getSchedule ();
		if (schedule == null) {
			return;
		}
		
		final Element payment_el = document
				.createElement (ARBAPIRequests.ELEMENT_PAYMENT_SCHEDULE);
		
		// Add the interval
		//
		if (schedule.getIntervalLength () > 0) {
			final Element interval_el = document
					.createElement (ARBAPIRequests.ELEMENT_INTERVAL);
			final Element length_el = document
					.createElement (ARBAPIRequests.ELEMENT_LENGTH);
			final Element unit_el = document
					.createElement (ARBAPIRequests.ELEMENT_UNIT);
			length_el.appendChild (document.getDocument ()
					.createTextNode (
							Integer.toString (schedule
									.getIntervalLength ())));
			interval_el.appendChild (length_el);
			interval_el.appendChild (unit_el);
			unit_el.appendChild (document.getDocument ()
					.createTextNode (
							schedule.getSubscriptionUnit ()));
			
			payment_el.appendChild (interval_el);
		}
		
		final Element start_date_el = document
				.createElement (ARBAPIRequests.ELEMENT_START_DATE);
		start_date_el
				.appendChild (document
						.getDocument ()
						.createTextNode (
								net.authorize.arb.util.DateUtil.getFormattedDate (
										schedule.getStartDate (),
										ARBPaymentSchedule.SCHEDULE_DATE_FORMAT)));
		payment_el.appendChild (start_date_el);
		
		final Element total_el = document
				.createElement (ARBAPIRequests.ELEMENT_TOTAL_OCCURRENCES);
		total_el.appendChild (document.getDocument ().createTextNode (
				Integer.toString (schedule.getTotalOccurrences ())));
		payment_el.appendChild (total_el);
		
		final Element trial_el = document
				.createElement (ARBAPIRequests.ELEMENT_TRIAL_OCCURRENCES);
		trial_el.appendChild (document.getDocument ().createTextNode (
				Integer.toString (schedule.getTrialOccurrences ())));
		payment_el.appendChild (trial_el);
		
		subscr_el.appendChild (payment_el);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param document WRITEME
	 * @param subscription WRITEME
	 * @param subscr_el WRITEME
	 */
	private void addPaymentToSubscription (
			final BasicXmlDocument document,
			final ARBSubscription subscription,
			final Element subscr_el) {
		final ARBPayment payment = subscription.getPayment ();
		if (payment == null) {
			return;
		}
		
		final Element payment_el = document
				.createElement (ARBAPIRequests.ELEMENT_PAYMENT);
		final CreditCard credit_card = payment.getCreditCard ();
		
		if (credit_card != null) {
			final Element cc_el = document
					.createElement (ARBAPIRequests.ELEMENT_CREDIT_CARD);
			
			final Element cc_num_el = document
					.createElement (ARBAPIRequests.ELEMENT_CREDIT_CARD_NUMBER);
			cc_num_el.appendChild (document.getDocument ()
					.createTextNode (credit_card.getCardNumber ()));
			cc_el.appendChild (cc_num_el);
			
			final Element cc_exp_el = document
					.createElement (ARBAPIRequests.ELEMENT_CREDIT_CARD_EXPIRY);
			cc_exp_el.appendChild (document
					.getDocument ()
					.createTextNode (
							net.authorize.arb.util.DateUtil.getFormattedDate (
									credit_card
											.getExpirationDate (),
									CreditCard.EXPIRY_DATE_FORMAT)));
			cc_el.appendChild (cc_exp_el);
			
			final Element cc_cvv_el = document
					.createElement (ARBAPIRequests.ELEMENT_CREDIT_CARD_CVV);
			cc_cvv_el.appendChild (document.getDocument ()
					.createTextNode (credit_card.getCardCode ()));
			cc_el.appendChild (cc_cvv_el);
			
			payment_el.appendChild (cc_el);
		}
		
		final BankAccount bank_account = payment.getBankAccount ();
		
		if (bank_account != null) {
			final Element ach_el = document
					.createElement (ARBAPIRequests.ELEMENT_BANK_ACCOUNT);
			
			final Element ach_acc_type_el = document
					.createElement (ARBAPIRequests.ELEMENT_ACCOUNT_TYPE);
			ach_acc_type_el.appendChild (document.getDocument ()
					.createTextNode (
							bank_account.getAccountType ()));
			ach_el.appendChild (ach_acc_type_el);
			
			final Element ach_route_el = document
					.createElement (ARBAPIRequests.ELEMENT_ROUTING_NUMBER);
			ach_route_el.appendChild (document.getDocument ()
					.createTextNode (
							bank_account.getRoutingNumber ()));
			ach_el.appendChild (ach_route_el);
			
			final Element ach_account_el = document
					.createElement (ARBAPIRequests.ELEMENT_ACCOUNT_NUMBER);
			ach_account_el.appendChild (document.getDocument ()
					.createTextNode (
							bank_account.getAccountNumber ()));
			ach_el.appendChild (ach_account_el);
			
			final Element ach_name_el = document
					.createElement (ARBAPIRequests.ELEMENT_NAME_ON_ACCOUNT);
			ach_name_el.appendChild (document.getDocument ()
					.createTextNode (
							bank_account.getNameOnAccount ()));
			ach_el.appendChild (ach_name_el);
			
			final Element ach_type_el = document
					.createElement (ARBAPIRequests.ELEMENT_ECHECK_TYPE);
			ach_type_el
					.appendChild (document
							.getDocument ()
							.createTextNode (
									bank_account
											.getEcheckType ()));
			ach_el.appendChild (ach_type_el);
			
			if (bank_account.getBankName () != null) {
				final Element bank_name_el = document
						.createElement (ARBAPIRequests.ELEMENT_BANK_NAME);
				bank_name_el.appendChild (document.getDocument ()
						.createTextNode (
								bank_account.getBankName ()));
				ach_el.appendChild (bank_name_el);
			}
			
			payment_el.appendChild (ach_el);
		}
		
		subscr_el.appendChild (payment_el);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param document WRITEME
	 * @param subscription WRITEME
	 * @param subscr_el WRITEME
	 */
	private void addShippingInfoToSubscription (
			final BasicXmlDocument document,
			final ARBSubscription subscription,
			final Element subscr_el) {
		if (subscription.getShipTo () == null) {
			return;
		}
		final ARBNameAndAddress ship_info = subscription.getShipTo ();
		final Element ship_el = document
				.createElement (ARBAPIRequests.ELEMENT_SHIP_TO);
		
		if (ship_info.getFirstName () != null) {
			final Element fname_el = document
					.createElement (ARBAPIRequests.ELEMENT_FIRST_NAME);
			fname_el.appendChild (document.getDocument ()
					.createTextNode (ship_info.getFirstName ()));
			ship_el.appendChild (fname_el);
		}
		
		if (ship_info.getLastName () != null) {
			final Element lname_el = document
					.createElement (ARBAPIRequests.ELEMENT_LAST_NAME);
			lname_el.appendChild (document.getDocument ()
					.createTextNode (ship_info.getLastName ()));
			ship_el.appendChild (lname_el);
		}
		
		if (ship_info.getCompany () != null) {
			final Element company_el = document
					.createElement (ARBAPIRequests.ELEMENT_COMPANY);
			company_el.appendChild (document.getDocument ()
					.createTextNode (ship_info.getCompany ()));
			ship_el.appendChild (company_el);
		}
		
		if (ship_info.getAddress () != null) {
			final Element address_el = document
					.createElement (ARBAPIRequests.ELEMENT_ADDRESS);
			address_el.appendChild (document.getDocument ()
					.createTextNode (ship_info.getAddress ()));
			ship_el.appendChild (address_el);
		}
		
		if (ship_info.getCity () != null) {
			final Element city_el = document
					.createElement (ARBAPIRequests.ELEMENT_CITY);
			city_el.appendChild (document.getDocument ()
					.createTextNode (ship_info.getCity ()));
			ship_el.appendChild (city_el);
		}
		
		if (ship_info.getState () != null) {
			final Element state_el = document
					.createElement (ARBAPIRequests.ELEMENT_STATE);
			state_el.appendChild (document.getDocument ()
					.createTextNode (ship_info.getState ()));
			ship_el.appendChild (state_el);
		}
		
		if (ship_info.getZip () != null) {
			final Element zip_el = document
					.createElement (ARBAPIRequests.ELEMENT_ZIP);
			zip_el.appendChild (document.getDocument ()
					.createTextNode (ship_info.getZip ()));
			ship_el.appendChild (zip_el);
		}
		
		if (ship_info.getCountry () != null) {
			final Element country_el = document
					.createElement (ARBAPIRequests.ELEMENT_COUNTRY);
			country_el.appendChild (document.getDocument ()
					.createTextNode (ship_info.getCountry ()));
			ship_el.appendChild (country_el);
		}
		
		subscr_el.appendChild (ship_el);
		
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param document WRITEME
	 * @param subscription WRITEME
	 */
	private void addSubscriptionIdToRequest (
			final BasicXmlDocument document,
			final ARBSubscription subscription) {
		if (subscription.getSubscriptionId () != null) {
			final Element subscr_id_el = document
					.createElement (ARBAPIRequests.ELEMENT_SUBSCRIPTION_ID);
			subscr_id_el.appendChild (document.getDocument ()
					.createTextNode (
							subscription.getSubscriptionId ()));
			document.getDocumentElement ()
					.appendChild (subscr_id_el);
		}
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param document WRITEME
	 * @param subscription WRITEME
	 */
	private void addSubscriptionToRequest (
			final BasicXmlDocument document,
			final ARBSubscription subscription) {
		
		addSubscriptionIdToRequest (document, subscription);
		
		final Element subscr_el = document
				.createElement (ARBAPIRequests.ELEMENT_SUBSCRIPTION);
		if (subscription.getName () != null) {
			final Element name_el = document
					.createElement (ARBAPIRequests.ELEMENT_NAME);
			name_el.appendChild (document.getDocument ()
					.createTextNode (subscription.getName ()));
			subscr_el.appendChild (name_el);
		}
		
		addPaymentScheduleToSubscription (document, subscription,
				subscr_el);
		if ( (BigDecimal.ZERO != subscription.getAmount ())
				|| (subscription.getTrialAmount () != 0)) {
			final Element amount_el = document
					.createElement (ARBAPIRequests.ELEMENT_AMOUNT);
			amount_el.appendChild (document.getDocument ()
					.createTextNode (
							subscription.getAmount ()
									.toPlainString ()));
			subscr_el.appendChild (amount_el);
			final Element trial_el = document
					.createElement (ARBAPIRequests.ELEMENT_TRIAL_AMOUNT);
			trial_el.appendChild (document.getDocument ()
					.createTextNode (
							Double.toString (subscription
									.getTrialAmount ())));
			subscr_el.appendChild (trial_el);
		}
		
		addPaymentToSubscription (document, subscription, subscr_el);
		addOrderInfoToSubscription (document, subscription, subscr_el);
		addCustomerInfoToSubscription (document, subscription,
				subscr_el);
		addBillingInfoToSubscription (document, subscription,
				subscr_el);
		addShippingInfoToSubscription (document, subscription,
				subscr_el);
		document.getDocumentElement ().appendChild (subscr_el);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param subscription WRITEME
	 * @return WRITEME
	 */
	public String cancelSubscriptionRequest (
			final ARBSubscription subscription) {
		
		clearRequest ();
		
		final BasicXmlDocument document = new BasicXmlDocument ();
		document.parseString ("<"
				+ ARBAPIRequests.REQUEST_CANCEL_SUBSCRIPTION
				+ " xmlns = \"" + ARBAPIRequests.XML_NAMESPACE
				+ "\" />");
		
		addAuthenticationToRequest (document);
		addSubscriptionIdToRequest (document, subscription);
		current_request = document;
		
		return result_code;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 */
	public void clearRequest () {
		messages.clear ();
		result_code = null;
		result_subscription_id = null;
		current_request = null;
		current_response = null;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param subscription WRITEME
	 * @return WRITEME
	 */
	public String createSubscriptionRequest (
			final ARBSubscription subscription) {
		
		clearRequest ();
		
		final BasicXmlDocument document = new BasicXmlDocument ();
		document.parseString ("<"
				+ ARBAPIRequests.REQUEST_CREATE_SUBSCRIPTION
				+ " xmlns = \"" + ARBAPIRequests.XML_NAMESPACE
				+ "\" />");
		
		addAuthenticationToRequest (document);
		addSubscriptionToRequest (document, subscription);
		current_request = document;
		return result_code;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 */
	public void destroy () {
		http_util.cleanup ();
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public BasicXmlDocument getCurrentRequest () {
		return current_request;
		
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public BasicXmlDocument getCurrentResponse () {
		return current_response;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param parent_el WRITEME
	 * @param element_name WRITEME
	 * @return WRITEME
	 */
	private String getElementText (final Element parent_el,
			final String element_name) {
		String out_val = null;
		final NodeList match_list = parent_el
				.getElementsByTagName (element_name);
		if (match_list.getLength () == 0) {
			return out_val;
		}
		final Element match_el = (Element) match_list.item (0);
		if (match_el.hasChildNodes ()) {
			out_val = match_el.getFirstChild ().getNodeValue ();
		}
		return out_val;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public String getMessages () {
		final StringBuffer messageList = new StringBuffer ();
		for (int i = 0; i < messages.size (); i++ ) {
			final Message message = messages.get (i);
			messageList.append (message.getCode () + " - "
					+ message.getText () + "\n");
		}
		return messageList.toString ();
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public String getResultCode () {
		return result_code;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public String getResultSubscriptionId () {
		return result_subscription_id;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 */
	private void importResponseMessages () {
		final NodeList messages_list = current_response
				.getDocument ().getElementsByTagName (
						ARBAPIRequests.ELEMENT_MESSAGES);
		if (messages_list.getLength () == 0) {
			return;
		}
		final Element messages_el = (Element) messages_list.item (0);
		
		result_code = getElementText (messages_el,
				ARBAPIRequests.ELEMENT_RESULT_CODE);
		result_subscription_id = getElementText (
				current_response.getDocumentElement (),
				ARBAPIRequests.ELEMENT_SUBSCRIPTION_ID);
		
		final NodeList message_list = messages_el
				.getElementsByTagName (ARBAPIRequests.ELEMENT_MESSAGE);
		for (int i = 0; i < message_list.getLength (); i++ ) {
			final Element message_el = (Element) message_list
					.item (i);
			final Message new_message = new Message ();
			new_message.setCode (getElementText (message_el,
					ARBAPIRequests.ELEMENT_CODE));
			// new_message.setResultCode(getElementText(message_el,ARBAPIRequests.ELEMENT_RESULT_CODE));
			new_message.setText (getElementText (message_el,
					ARBAPIRequests.ELEMENT_TEXT));
			messages.add (new_message);
		}
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 */
	public void printMessages () {
		log.info ("Result Code: "
				+ (result_code != null ? result_code
						: "No result code"));
		if (result_subscription_id != null) {
			log.info ("Result Subscription Id: "
					+ result_subscription_id);
		}
		for (int i = 0; i < messages.size (); i++ ) {
			final Message message = messages.get (i);
			log.info (message.getCode () + " - "
					+ message.getText ());
		}
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public BasicXmlDocument sendRequest () {
		return sendRequest (current_request);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param request_document WRITEME
	 * @return WRITEME
	 */
	public BasicXmlDocument sendRequest (
			final BasicXmlDocument request_document) {
		BasicXmlDocument response = null;
		result_code = null;
		messages.clear ();
		
		final String in_response = http_util
				.postUrl (request_document.dump ());
		
		if (in_response == null) {
			return null;
		}
		
		final int mark = in_response.indexOf ("<?xml");
		if (mark == -1) {
			log.info ("Invalid response");
			log.info (in_response);
			return null;
		}
		response = new BasicXmlDocument ();
		
		response.parseString (in_response.substring (mark,
				in_response.length ()));
		if (response.IsAccessible () == false) {
			log.info ("Invalid response");
			log.info (in_response);
			return null;
		}
		
		current_response = response;
		importResponseMessages ();
		return response;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param subscription WRITEME
	 * @return WRITEME
	 */
	public String updateSubscriptionRequest (
			final ARBSubscription subscription) {
		
		clearRequest ();
		
		final BasicXmlDocument document = new BasicXmlDocument ();
		document.parseString ("<"
				+ ARBAPIRequests.REQUEST_UPDATE_SUBSCRIPTION
				+ " xmlns = \"" + ARBAPIRequests.XML_NAMESPACE
				+ "\" />");
		
		addAuthenticationToRequest (document);
		addSubscriptionToRequest (document, subscription);
		current_request = document;
		
		return result_code;
	}
	
}
