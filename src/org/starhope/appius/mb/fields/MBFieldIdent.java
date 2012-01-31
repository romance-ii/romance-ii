/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
package org.starhope.appius.mb.fields;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public enum MBFieldIdent {
	ADDRESS ("Your Address",
			"Enter your correct postal or physical address"), ADDRESS2 (
			"Address(2°)", "Second line of address (if necessary)"), BUYER_FAMILY_NAME (
			"Card Holder's Last Name", "Card Holder's Last Name"), BUYER_GIVEN_NAME (
			"Card Holder's First Name", "Card Holder's First Name"), CAN_CONTACT (
			"Can We Contact You?",
			"Is it OK for us to contact you? (We may still need to, for example, if you forget your password)"),
	
	CC_CODE ("Card Code", "Card Code"), CC_EXPIRY (
			"Credit-Card Expiry", "Credit-Card Expiry Date"), /**
	 * 
	 * Credit-card number
	 */
	CC_NUMBER ("Credit-Card Number",
			"The (usually 16-digit) account number of your credit-card."), CC_TYPE (
			"Credit-Card Type",
			"The type of credit-card which you are using to make this payment"), CHARACTER_CLASS (
			"Character Class",
			"The character you would like to play"),
	
	/**
	 * The child account selected
	 */
	CHILD ("Your Child",
			"Choose which child account you would like to work with."), CITY (
			"City", "Town, city, village"), COUNTRY ("Country",
			"Country"),
	/**
	 * was "dob"
	 */
	DATE_OF_BIRTH_GIVEN (
			"Date of Birth",
			"The full date of birth. Due to various privacy laws, we need to confirm the age of our users."), /**
	 * 
	 * was "subscription"
	 */
	ENROLMENT_CHOSEN ("Enrolment Option",
			"Choose a type of enrolment that fits your time and budget best"), /**
	 * 
	 * was "answer"
	 */
	FORGOT_PASSWORD_ANSWER ("Forgotten Password Recovery Answer",
			"The answer to the question you chose for forgotten password recovery"), /**
	 * 
	 * would probably have been "question" but I can't see it anywhere?
	 */
	
	FORGOT_PASSWORD_QUESTION ("Forgotten Password Recovery Question",
			"Choose a question that only you would know the answer."),
	
	GIVEN_NAME (
			"Given Name",
			"You can optionally provide a real-world given name (first name) for this user. This is only used for your convenience in identifying your accounts."),
	/**
	 * was "session"
	 */
	LOGIN_AUTH (
			"User Name",
			"Your user name for logging in. If you have not registered a user name yet, go to Registration instead."), /**
	 * 
	 * was "username"
	 */
	LOGIN_REQUESTED (
			"User Name Requested",
			"Choose an unique user name. We recommend that it should not be the same as your real name."), MAIL_AUTH (
			"Parent's eMail address", "Parent's eMail address"), /**
	 * 
	 * was "mail" or "email"
	 */
	MAIL_PROVIDED (
			"eMail Address",
			"Your eMail address may be needed for certain communications. We will not send marketing messages or share your address with anyone else."), /**
	 * 
	 * User's existing password
	 */
	PASSWORD_AUTH (
			"Your Password",
			"The password you have set up for your account (either at registration, or by changing it later)"), /**
	 * 
	 * was "password"
	 */
	PASSWORD_REQUESTED ("Password",
			"Enter a password to protect access to your account."),
	/**
	 * Payment credentials
	 */
	PAYMENT_CREDENTIALS ("Payment Authorization",
			"Please provide the information required to authorize your payment."), PHONE (
			"Telephone number", "Telephone number"), POSTAL_CODE (
			"ZIP/Postal Code", "ZIP/Postal Code"), PREPAID_CODE (
			"Prepaid code",
			"If you have purchased a prepaid card or electronic code, enter that code sequence here"), PROVINCE (
			"State, province, locality",
			"State, province, or locality"), /**
	 * Agree to the rules!
	 */
	RULES_AGREE ("Agree to the Rules", "Agree to the rules"), /**
	 * was
	 * "agree"
	 */
	TERMS_CONDITIONS_AGREE (
			"Agree to Terms and Conditions",
			"You must agree to the terms and conditions (rules) before you can register an account"), /**
	 * 
	 * This is a special “field” used to force a return to the main
	 * menu area
	 */
	WHO_ARE_YOU ("Hi! Who are you?",
			"Are you a new or returning player? Or the parent of a player?"),
	
	;
	
	/**
	 * Friendly user-visible default English name for the field
	 */
	private final String friendlyName;
	
	/**
	 * Friendly user-visible default description/tip/hint of the
	 * field's purpose
	 */
	private final String hint;
	
	/**
	 * @param theFriendlyName {@link #friendlyName}
	 * @param theHint {@link #hint}
	 */
	private MBFieldIdent (final String theFriendlyName,
			final String theHint) {
		friendlyName = theFriendlyName;
		hint = theHint;
	}
	
	/**
	 * @return {@link #hint}
	 */
	public String getHint () {
		return hint;
	}
	
	/**
	 * @return an user-visible friendly name for the field
	 */
	public String getName () {
		return friendlyName;
	}
	
}
