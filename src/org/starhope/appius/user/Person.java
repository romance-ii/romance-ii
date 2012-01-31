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
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 */

package org.starhope.appius.user;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Date;

import javax.naming.NamingException;

import org.starhope.appius.except.DataException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.messaging.Mail;
import org.starhope.appius.types.AgeBracket;
import org.starhope.appius.util.AppiusConfig;

/**
 * This was an abstract superclass for both Parents and Users. Now, it's
 * being refactored as a static container class for common methods
 * related to all AbstractPerson instances.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 */
public class Person {
	
	/**
	 * Java serialization unique ID
	 */
	private static final long serialVersionUID = 5635026067346684335L;
	
	/**
	 * @param who WRITEME
	 * @param forgottenPasswordQ WRITEME
	 * @param forgottenPasswordA WRITEME
	 * @return WRITEME
	 * @see org.starhope.appius.user.AbstractPerson#forgotPassword(java.lang.String,
	 *      java.lang.String)
	 */
	public static boolean forgotPassword (final AbstractPerson who,
			final String forgottenPasswordQ,
			final String forgottenPasswordA) {
		
		if ( (null == forgottenPasswordA)
				|| (null == forgottenPasswordQ)
				|| "".equals (forgottenPasswordA)
				|| "".equals (forgottenPasswordQ)
				|| !who.getForgotPasswordQuestion ().equals (
						forgottenPasswordQ)
				|| !who.getForgotPasswordAnswer ()
						.equalsIgnoreCase (forgottenPasswordA)) {
			return false;
		}
		
		try {
			Person.remindPassword (who);
		} catch (final NotReadyException e) {
			return false;
		}
		return true;
	}
	
	/**
	 * @return a new, random password using only ASCII-7 printable
	 *         characters ($20 to $7e). Password's length will range
	 *         from 10-20 characters in total.
	 */
	protected static String generateNewPassword () {
		final StringBuilder newPass = new StringBuilder ();
		for (int i = 0; i < AppiusConfig.getRandomInt (10, 20); ++i) {
			newPass.append ( ((char) AppiusConfig.getRandomInt (32,
					126)));
		}
		return newPass.toString ();
	}
	
	/**
	 * <p>
	 * Get reference to User or Parent for making a purchase.
	 * </p>
	 * <p>
	 * Currently, kids under 17 return their parent.
	 * </p>
	 * 
	 * @param p The person, for whom someone else may be responsible
	 *             for payments
	 * @return the Person object that able to use a credit card.
	 */
	public static AbstractPerson getResponsiblePerson (
			final AbstractPerson p) {
		if (p instanceof Parent) {
			return p;
		}
		if ( (p instanceof User)
				&& ( ((GeneralUser) p).getAgeGroup () != AgeBracket.Adult)
				&& (null != ((User) p).getParent ())) {
			return ((User) p).getParent ();
		}
		return p;
	}
	
	/**
	 * Send a reminder eMail for a forgotten password. This presumes
	 * that the eMail address on file has been validated, and that the
	 * person has already authenticated in some way.
	 * 
	 * @param who WRITEME
	 * @throws NotReadyException if the user does not have an eMail
	 *              address, or it has not been confirmed
	 */
	public static void remindPassword (final AbstractPerson who)
			throws NotReadyException {
		if ("".equals (who.getMail ()) || (null == who.getMail ())) {
			throw new NotReadyException ("noReminder:noMailAddress");
		}
		if (null == who.getMailConfirmed ()) {
			throw new NotReadyException ("noReminder:notConfirmed");
		}
		try {
			Mail.sendPasswordRecoveryMail (who);
		} catch (final FileNotFoundException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} catch (final IOException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} catch (final NotFoundException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}
	
	/**
	 * @param who WRITEME
	 * @see org.starhope.appius.user.AbstractPerson#sendConfirmationMail()
	 */
	public static void sendConfirmationMail (final AbstractPerson who) {
		try {
			Mail.sendSignupMail (who);
			who.setMailConfirmSent (new Date (System
					.currentTimeMillis ()));
		} catch (final FileNotFoundException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} catch (final IOException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} catch (final NotFoundException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} catch (final DataException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} catch (final NamingException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}
	
	/**
	 * @param who WRITEME
	 * @see Mail#sendStaffPaswordResetMail(AbstractPerson)
	 */
	public static void sendStaffPasswordReset (final AbstractPerson who) {
		try {
			Mail.sendStaffPaswordResetMail (who);
		} catch (final FileNotFoundException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} catch (final IOException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} catch (final NotFoundException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}
	
}
