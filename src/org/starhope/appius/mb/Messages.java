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

package org.starhope.appius.mb;

import java.text.DateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import org.starhope.appius.user.User;
import org.starhope.util.LibMisc;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Messages {
	
	/**
	 * @return "Your account has not been approved."
	 */
	@Deprecated
	public static final String account_not_approved () {
		return LibMisc.getText ("account_not_approved");
	}
	
	/**
	 * @return 
	 *         "You must agree to the Terms and Conditions to play in Tootsville."
	 */
	@Deprecated
	public static final String agree_ts_and_cs () {
		return LibMisc.getText ("agree_terms");
	}
	
	/**
	 * @return 
	 *         "You have answered your question incorrectly.  Please try again or contact customer service if you are having trouble"
	 */
	@Deprecated
	public static final String answer_incorrect () {
		return LibMisc.getText ("passRecovery.answer_incorrect");
	}
	
	/**
	 * @deprecated use {@link LibMisc#getText(String)} "card_declined"
	 * @return 
	 *         "Oops!  We are having trouble processing your Credit Card.  The card is being declined.  Please try again with a different Credit Card."
	 */
	@Deprecated
	public static final String bad_cc () {
		return LibMisc.getText ("card_declined");
	}
	
	/**
	 * FIXME (twheys@gmail.com)
	 * 
	 * @param field WRITEME
	 * @return "You have left the required " + field +
	 *         " field blank.  Please try again.";
	 */
	public static final String blank_field (final String field) {
		return "You have left the required "
				+ field
				+ " field blank.  Please complete all the required fields.";
	}
	
	/**
	 * The credit card processing failed, but the processor
	 * (authorize.net) did not return a detailed explanation of the
	 * reason for the failure.
	 * 
	 * @return a user-visible message explaining this situation
	 */
	@Deprecated
	public static String card_fail_generic () {
		return Messages.getText ("card_fail_generic");
	}
	
	/**
	 * @return 
	 *         "The credit card number you have entered is invalid. Please try again."
	 */
	@Deprecated
	public static final String cc_invalid () {
		return Messages.getText ("cc_invalid");
	}
	
	/**
	 * credit-card number entered is not 13 nor 16 digits
	 * 
	 * @return WRITEME
	 */
	@Deprecated
	public static String cc_num_not_16_digits () {
		return LibMisc.getTextOrDefault ("cc.num.invalid",
				"That credit card number seems to be invalid.");
	}
	
	/**
	 * FIXME: getText version
	 * 
	 * @return "Your password is already set as that!"
	 */
	@Deprecated
	public static final String ccv_invalid () {
		return LibMisc
				.getTextOrDefault ("ccv.fail",
						"The CCV number you have entered is invalid. Please check your typing.");
	}
	
	/**
	 * FIXME: getText version
	 * 
	 * @return 
	 *         "The peanut code you have entered is either invalid or already used."
	 */
	@Deprecated
	public static final String code_invalid () {
		return "The peanut code you have entered is either invalid or already taken.";
	}
	
	/**
	 * WRITEME: document this method (twheys@gmail.com, Sep 26, 2009)
	 * FIXME: getText version
	 * 
	 * @return WRITEME
	 */
	@Deprecated
	public static final String dob_invalid () {
		return "The date of birth you have entered is invalid or does not exist.  Please re-enter your date of birth.";
	}
	
	/**
	 * WRITEME: document this method (twheys@gmail.com, Sep 26, 2009)
	 * FIXME: getText version
	 * 
	 * @return WRITEME
	 */
	@Deprecated
	public static final String exp_invalid () {
		return "The expiration date you have entered is invalid.  Please re-enter your expiration date.";
	}
	
	/**
	 * Format a date into a user-friendly visible object relative to
	 * "now."
	 * 
	 * @deprecated use {@link LibMisc#formatFutureDate(Date)}
	 * @param targetDate the date (in the future)
	 * @return a user-visible string form
	 */
	@Deprecated
	public static String formatFutureDate (final Date targetDate) {
		return LibMisc.formatFutureDate (targetDate);
	}
	
	/**
	 * @deprecated use {@link LibMisc#formatMemory(long)}
	 * @param numBytes WRITEME
	 * @return WRITEME
	 */
	@Deprecated
	public static String formatMemory (final long numBytes) {
		return LibMisc.formatMemory (numBytes);
	}
	
	/**
	 * Get suggested question(s) for the forgotten password recovery
	 * system
	 * 
	 * @return array of possible security questions.
	 */
	public static String [] getSecurityQuestion () {
		final String securityQuestion[] = { "What is your favorite food?" };
		return securityQuestion;
	}
	
	/**
	 * @deprecated use {@link LibMisc#getText(String)}
	 * @param string WRITEME
	 * @return WRITEME
	 */
	@Deprecated
	public static String getText (final String string) {
		return Messages.getText (string, "en", "US");
	}
	
	/**
	 * @deprecated use {@link LibMisc#getText(String,String,String)}
	 * @param string The identifier (dotted hierarchy) of the string to
	 *             be returned
	 * @param language WRITEME
	 * @param dialect WRITEME
	 * @return The translated, locale-specific — haha. I lie. The US
	 *         English message in user-visible format.
	 */
	@Deprecated
	public static String getText (final String string,
			final String language, final String dialect) {
		return org.starhope.util.LibMisc.getText (string, language,
				dialect);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 10,
	 * 2009)
	 * 
	 * @param buddyListNames WRITEME
	 * @param language WRITEME
	 * @param dialect WRITEME
	 * @return WRITEME
	 */
	public static String listToDisplay (
			final Collection <String> buddyListNames,
			final String language, final String dialect) {
		final List <String> list = new LinkedList <String> (
				buddyListNames);
		return LibMisc.listToDisplay (list, language, dialect);
	}
	
	/**
	 * <p>
	 * Given a list of strings, combine then into a string for display
	 * purposes.
	 * </p>
	 * <p>
	 * For English, the list will obey the traditional grammatical
	 * usage of commas: List elements are joined with commas, except
	 * that the conjunction (in our case, always “and”) occurs
	 * penultimate, and two or three element lists do not use commas.
	 * </p>
	 * <p>
	 * For Spanish, works essentially the same way.
	 * </p>
	 * <p>
	 * For other languages, we just join the words with commas and omit
	 * the conjunction
	 * </p>
	 * 
	 * @param words A list of words.
	 * @param language The user's display language
	 * @param dialect The user's sublanguage dialect
	 * @return The list formatted into a string.
	 */
	@Deprecated
	public static String listToDisplay (final List <String> words,
			final String language, final String dialect) {
		return LibMisc.listToDisplay (words, language, dialect);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Aug 24,
	 * 2009)
	 * 
	 * @param stuff WRITEME
	 * @param language WRITEME
	 * @param dialect WRITEME
	 * @return WRITEME
	 */
	@Deprecated
	public static String listToDisplay (final Object [] stuff,
			final String language, final String dialect) {
		final List <String> junk = new LinkedList <String> ();
		for (final Object o : stuff) {
			junk.add (o.toString ());
		}
		return LibMisc.listToDisplay (junk, language, dialect);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 26,
	 * 2009)
	 * 
	 * @param words WRITEME
	 * @param language WRITEME
	 * @param dialect WRITEME
	 * @return WRITEME
	 */
	@Deprecated
	public static String listToDisplay (final Set <String> words,
			final String language, final String dialect) {
		final List <String> relay = new LinkedList <String> ();
		final Iterator <String> i = words.iterator ();
		while (i.hasNext ()) {
			relay.add (i.next ());
		}
		return Messages.listToDisplay (relay, language, dialect);
	}
	
	/**
	 * @return 
	 *         "Your username or password is incorrect.  Please check your typnig and try logging in again."
	 */
	@Deprecated
	public static final String login_invalid () {
		return Messages.getText ("login_invalid");
	}
	
	/**
	 * @return 
	 *         "The username you choose is too short.  Please pick a new one at least "
	 *         + User.MIN_LOGIN_LENGTH + " characters long."
	 */
	@Deprecated
	public static final String login_length () {
		return String.format (Messages.getText ("login_length"),
				Integer.valueOf (User.MIN_LOGIN_LENGTH));
	}
	
	/**
	 * @return "You have successfully updated your e-mail address.
	 *         Please make sure you verify your e-mail by following the
	 *         instructions in the e-mail we just sent you."
	 */
	@Deprecated
	public static final String mail_change () {
		return Messages.getText ("mail_change");
	}
	
	/**
	 * @return 
	 *         "The email address you have entered appears to be invalid, please check your typing."
	 */
	@Deprecated
	public static final String mail_invalid () {
		return Messages.getText ("mail_invalid");
	}
	
	/**
	 * @return "The email addresses you have entered do not match."
	 */
	@Deprecated
	public static final String mail_mismatch () {
		return Messages.getText ("mail_mismatch");
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 17,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	@Deprecated
	public static final String mail_not_on_file () {
		return Messages.getText ("mail_not_on_file");
	}
	
	/**
	 * The message catalogue
	 * 
	 * @return 
	 *         "Please confirm your e-mail address.  Tootsville Customer Service has just resent the e-mail with verification instructions in case you have lost the original."
	 */
	@Deprecated
	public static final String mail_not_verified () {
		return Messages.getText ("mail_not_verified");
	}
	
	/**
	 * @return "The amount of the payment supplied included fractional
	 *         values of less than 1¢ (USD $.01). This is not
	 *         supported. Payment values must be in increments of 1¢."
	 */
	@Deprecated
	public static String minPrecisionOneCent () {
		return Messages.getText ("one_cent_accuracy");
	}
	
	/**
	 * @return "You must be logged in to do that."
	 */
	public static final String not_logged_in () {
		return "This action requires you to be logged in.  Please log in.";
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 17,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	@Deprecated
	public static String one_cent_accuracy () {
		return Messages.getText ("one_cent_accuracy");
	}
	
	/**
	 * @return 
	 *         "The subscription system only supports VISA or MasterCard, sorry."
	 */
	@Deprecated
	public static String onlyVisaOrMC () {
		return Messages.getText ("onlyVisaOrMC");
	}
	
	/**
	 * WRITEME: document this method (twheys@gmail.com, Aug 26, 2009)
	 * 
	 * @return WRITEME
	 */
	@Deprecated
	public static final String parent_account_already_exists () {
		return Messages
				.getText ("parent_account_already_exists.html");
	}
	
	/**
	 * @return "You have successfully changed your password."
	 */
	@Deprecated
	public static final String password_change () {
		return Messages.getText ("password_change");
	}
	
	/**
	 * @return "The password you have entered is incorrect."
	 */
	@Deprecated
	public static final String password_invalid () {
		return Messages.getText ("password_invalid");
	}
	
	/**
	 * @return 
	 *         "That password is too short, please pick one that is 6 characters long."
	 */
	@Deprecated
	public static final String password_length () {
		return String.format (Messages.getText ("password_length"),
				Integer.valueOf (User.MIN_PW_LENGTH));
	}
	
	/**
	 * @return 
	 *         "Your password does not match the confirmation, please retype your password in both fields."
	 */
	@Deprecated
	public static final String password_mismatch () {
		return Messages.getText ("password_mismatch");
	}
	
	/**
	 * The message catalogue
	 * 
	 * @return WRITEME
	 */
	@Deprecated
	public static final String password_reset () {
		return Messages.getText ("password_change");
	}
	
	/**
	 * @return "Your password is already set as that!"
	 */
	@Deprecated
	public static final String password_same () {
		return Messages.getText ("password_same");
	}
	
	/**
	 * The message catalogue
	 * 
	 * @return WRITEME
	 */
	@Deprecated
	public static final String password_send () {
		return Messages.getText ("password_send");
	}
	
	/**
	 * @return 
	 *         "A payment has already been made for that subscription for the Toots Account you have selected."
	 */
	@Deprecated
	public static final String payment_already_made () {
		return Messages.getText ("payment_already_made");
	}
	
	/**
	 * @param date WRITEME
	 * @return WRITEME
	 */
	public static String prettyDate (final Date date) {
		if (null == date) {
			return "(null)";
		}
		return DateFormat.getDateInstance (DateFormat.LONG).format (
				date);
	}
	
	/**
	 * payment gateway asked us to retry transaction later
	 * 
	 * @return WRITEME
	 */
	@Deprecated
	public static final String retry_payment () {
		return Messages.getText ("retry_payment");
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 17,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	@Deprecated
	public static String retry_payment_message () {
		return Messages.getText ("retry_payment_message");
	}
	
	/**
	 * @return "You must agree to the rules to play Tootsville."
	 */
	@Deprecated
	public static final String rulesAgree () {
		return Messages.getText ("rules_agree");
	}
	
	/**
	 * @return 
	 *         "Please click your child's Toots account, from the 'My Child's Toots Account(s)' list, and then click 'Make Me A V.I.T.' to upgrade. "
	 */
	@Deprecated
	public static final String select_toot_upgrade () {
		return Messages.getText ("toot_upgrade");
	}
	
	/**
	 * WRITEME: document this method (twheys@gmail.com, Sep 4, 2009)
	 * 
	 * @return WRITEME
	 */
	@Deprecated
	public static final String subscription_invalid () {
		return Messages.getText ("subscription_unavailable");
	}
	
	/**
	 * WRITEME: document this method (twheys@gmail.com, Sep 4, 2009)
	 * 
	 * @return WRITEME
	 */
	@Deprecated
	public static final String unsupported_currency () {
		return Messages.getText ("unsupported_currency");
	}
	
	/**
	 * @return 
	 *         "The credit card number you have entered is invalid. Please try again."
	 */
	@Deprecated
	public static final String user_does_not_exist () {
		return Messages.getText ("user_does_not_exist");
	}
	
	/**
	 * @return 
	 *         "That username contains invalid characters or is not allowed, please choose another one."
	 */
	@Deprecated
	public static final String username_invalid () {
		return Messages.getText ("username_invalid");
	}
	
	/**
	 * @return 
	 *         "That username is not available, please choose another one."
	 */
	@Deprecated
	public static final String username_unavail () {
		return Messages.getText ("username_unavail");
	}
}
