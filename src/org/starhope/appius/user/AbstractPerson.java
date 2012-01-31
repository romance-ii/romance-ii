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
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock,twheys@gmail.com
 */

package org.starhope.appius.user;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.HashMap;

import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public interface AbstractPerson {
	
	/**
	 * Can this person be contacted for marketing and other purposes?
	 * 
	 * @return true, if this person permits communications of that sort
	 */
	public abstract boolean canContact ();
	
	/**
	 * Returns true if the password is correct. Returns false if
	 * password is not set or the guess was blank.
	 * 
	 * @param passwordGuess The password which is to be checked
	 * @return true, if the password is correct and not null
	 */
	public abstract boolean checkPassword (final String passwordGuess);
	
	/**
	 * Send the user their forgotten password if they know the answer
	 * to their secret question. If {@link #remindPassword()} throws a
	 * {@link NotFoundException}, this will fail and return false as
	 * well.
	 * 
	 * @param forgottenPasswordQ The question being answered
	 * @param forgottenPasswordA The answer provided
	 * @return true if answer is correct (also calls
	 *         {@link #remindPassword()}); and false if it is not
	 */
	public abstract boolean forgotPassword (
			final String forgottenPasswordQ,
			final String forgottenPasswordA);
	
	/**
	 * Get a cookie object for sending mail. Cookies are generated
	 * differently between User and Parent.
	 * 
	 * @see Parent
	 * @see User
	 * @return an opaque string that identifies the user uniquely
	 */
	public abstract String getApprovalCookie ();
	
	/**
	 * Get the filename of the eMail template file to be used to
	 * confirm this person's account
	 * 
	 * @return the template filename to be used for confirming this
	 *         account
	 */
	public abstract String getConfirmationTemplate ();
	
	/**
	 * Get this person's preferred language-dialect.
	 * 
	 * @return the dialect
	 */
	public abstract String getDialect ();
	
	/**
	 * Get the name to be displayed in user interface for this person.
	 * This should give the person's given name, but if that
	 * information is unavailable, fall back upon other unique
	 * identifier such as their avatar label
	 * 
	 * @return the display name
	 */
	public abstract String getDisplayName ();
	
	/**
	 * Get the forgotten password question
	 * 
	 * @return the question to ask
	 */
	public abstract String getForgotPasswordAnswer ();
	
	/**
	 * Get the forgotten password question
	 * 
	 * @return the question to ask
	 */
	public abstract String getForgotPasswordQuestion ();
	
	/**
	 * @return the givenName
	 */
	public abstract String getGivenName ();
	
	/**
	 * Returns the historical contents of this user's record.
	 * 
	 * @param after If non-null, specifies the date after which we want
	 *             to view records. To see all records, back to the
	 *             creation of the user record, supply a null.
	 * @param limit If this is a positive number, it limits the results
	 *             to this number of records.
	 * @return A map of timestamps to key/value pairs. All values are
	 *         expressed as strings (even though they may have numeric,
	 *         enumerative, or date / date-time types in the database),
	 *         since this is primarily (only?) for human-viewable
	 *         auditing.
	 */
	public abstract HashMap <Timestamp, HashMap <String, String>> getHistory (
			final Date after, final int limit);
	
	/**
	 * @return the language
	 */
	public abstract String getLanguage ();
	
	/**
	 * @return the mail
	 */
	public abstract String getMail ();
	
	/**
	 * @return the date on which the user's mail was confirmed
	 */
	public abstract Date getMailConfirmed ();
	
	/**
	 * @return the user's cleartext password, if available. If the
	 *         password storage mechanism does not permit cleartext
	 *         retrieval, returns a null.
	 */
	public abstract String getPassword ();
	
	/**
	 * <p>
	 * Get an user name suggestion for this person
	 * </p>
	 * XXX This belongs in User, only.
	 * 
	 * @return a user name that could be used
	 */
	public abstract String getPotentialUserName ();
	
	/**
	 * Get the eMail address of a responsible person: either the
	 * player, or the parent. Currently, kids 13-17 return their own
	 * mail.
	 * 
	 * @return the eMail address
	 */
	public abstract String getResponsibleMail ();
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @throws NotReadyException WRITEME
	 */
	public void remindPassword () throws NotReadyException;
	
	/**
	 * <p>
	 * Rename the user account, updating all necessary related records.
	 * Note, in particular, that Smartfox is wholly dependant upon user
	 * names, so all records related to Smartfox must be updated!
	 * </p>
	 * <p>
	 * If the user is currently online, this will fuck up hilariously,
	 * I think.
	 * </p>
	 * 
	 * @param newName The new user name
	 * @throws GameLogicException if the user is online (and therefore
	 *              can't be renamed)
	 * @throws ForbiddenUserException WRITEME
	 * @throws AlreadyUsedException WRITEME
	 */
	public abstract void rename (final String newName)
			throws GameLogicException, AlreadyUsedException,
			ForbiddenUserException;
	
	/**
	 * Sends confirmation mail to whomever should receive it
	 */
	public abstract void sendConfirmationMail ();
	
	/**
	 * Sends mail to user or parent when a staff member resets their
	 * password.
	 */
	public abstract void sendStaffPasswordReset ();
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 25,
	 * 2009)
	 */
	public abstract void sentConfirmationMail ();
	
	/**
	 * @param canContact1 if true, the user has explicitly given us
	 *             their legal consent to be contacted for marketing
	 *             and other options.
	 */
	public abstract void setCanContact (final boolean canContact1);
	
	// /**
	// * WRITEME: document this method (twheys@gmail.com, Nov 5, 2009)
	// *
	// * @param newCouponCode WRITEME
	// */
	// public abstract void setCouponCode (final String newCouponCode);
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 25,
	 * 2009)
	 * 
	 * @param answer WRITEME
	 */
	public abstract void setForgotPasswordAnswer (final String answer);
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 25,
	 * 2009)
	 * 
	 * @param question WRITEME
	 */
	public abstract void setForgotPasswordQuestion (
			final String question);
	
	/**
	 * @param givenName1 the givenName to set
	 */
	public abstract void setGivenName (final String givenName1);
	
	/**
	 * @param mail1 the mail to set
	 * @throws GameLogicException WRITEME
	 */
	public abstract void setMail (final String mail1)
			throws GameLogicException;
	
	/**
	 * @param mailConfirmed1 the mailConfirmed to set
	 */
	public abstract void setMailConfirmed (final Date mailConfirmed1);
	
	/**
	 * @param date the date on which the mail confirmation message was
	 *             sent
	 */
	public abstract void setMailConfirmSent (Date date);
	
	/**
	 * Changes the person's password
	 * 
	 * @param password1 the password to set
	 */
	public abstract void setPassword (final String password1);
	
	/**
	 * @param question WRITEME
	 * @param answer WRITEME
	 * @param newPassword WRITEME
	 * @throws GameLogicException WRITEME
	 */
	public abstract void setPasswordAndPasswordRecovery (
			final String question, final String answer,
			final String newPassword) throws GameLogicException;
	
	/**
	 * Set the password-recovery question and answer pair
	 * 
	 * @param forgottenPasswordQuestion the question
	 * @param forgottenPasswordAnswer the correct answer
	 */
	public abstract void setPasswordRecovery (
			final String forgottenPasswordQuestion,
			final String forgottenPasswordAnswer);
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 25,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public abstract String setRandomPassword ();
	
}
