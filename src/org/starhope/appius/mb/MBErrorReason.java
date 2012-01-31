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
package org.starhope.appius.mb;

import java.util.Locale;

import org.starhope.appius.mb.fields.MBFieldIdent;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public enum MBErrorReason {
	/**
	 * The requested entry is already in use, e.g. someone else has
	 * registered with a certain login, or eMail, or whatever
	 */
	ALREADY_USED (
			"The %s you entered has already been used. Please use another."),
	/**
	 * The field was left blank, and is required
	 */
	BLANK (
			"In order to continue, please fill in the required field %s"),
	/**
	 * The confirmation of a field failed; for eMail or password
	 * entries that have to be entered twice
	 */
	CONFIRM (
			"The two values you typed for %s did not match. Please, try again."),
	/**
	 * The field does not meet format requirements, e.g. too short, not
	 * enough unique chars, &c.
	 */
	FORMAT (
			"The value you entered for %s does not meet the requirements. Please try again."),
	/**
	 * The value provided was incorrect or invalid
	 */
	INCORRECT ("Please enter a correct value for %s"),
	/**
	 * Password cannot be set to match username
	 */
	PASSWORD_EQ_USERNAME (
			"Your password cannot be the same as your user name (login name)"),
	/**
	 * Value is too long
	 */
	TOO_LONG (
			"The %s you entered was too long. Please enter a shorter value."),
	/**
	 * Value (likely user name or password) was too short.
	 */
	TOO_SHORT (
			"The %s you entered was too short. Please enter a longer value.");
	/**
	 * Format string for default message creation (in English)
	 */
	private final String defaultMessageFormat;
	
	/**
	 * @param defaultFormat A string used to create a default error
	 *             message for this reason.
	 */
	private MBErrorReason (final String defaultFormat) {
		defaultMessageFormat = defaultFormat;
	}
	
	/**
	 * Get an error message. This will look for (lower-cased)
	 * mb.FIELD.REASON as the text, but will fall back upon the default
	 * message provided by the reason with the field's friendly name
	 * inserted.
	 * 
	 * @param field the field for which an error message is wanted
	 * @return the error message text
	 */
	public String getErrorMessage (final MBFieldIdent field) {
		final String fieldEnum = field.toString ().toLowerCase (
				Locale.ENGLISH);
		return LibMisc.getTextOrDefault (
				"mb."
						+ fieldEnum
						+ "."
						+ toString ()
								.toLowerCase (Locale.ENGLISH),
				String.format (defaultMessageFormat,
						field.getName ()));
	}
}
