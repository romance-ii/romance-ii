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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package net.authorize.arb;

import java.util.Date;

/** WRITEME */
public class ARBDriversLicense {
	/** WRITEME */
	public static final String LICENSE_DATE_FORMAT = "yyyy-MM-dd";
	/** WRITEME */
	private Date birth_date;
	/** WRITEME */
	private String number;
	/** WRITEME */
	private String state;

	/** WRITEME */
	public ARBDriversLicense () {
		birth_date = null;
		number = "";
		state = "";
	}

	/**
	 * @return WRITEME
	 */
	public Date getBirthDate () {
		if (null == birth_date)
			return null;
		return new Date (birth_date.getTime ());
	}

	/**
	 * @return WRITEME
	 */
	public String getNumber () {
		return number;
	}

	/**
	 * @return WRITEME
	 */
	public String getState () {
		return state;
	}

	/**
	 * @param birth_date1 WRITEME
	 */
	public void setBirthDate (final Date birth_date1) {
		birth_date = new Date (birth_date1.getTime ());
	}

	/**
	 * @param date WRITEME
	 */
	public void setBirthDate (final String date) {
		birth_date = net.authorize.arb.util.DateUtil
		.getDateFromFormattedDate (date,
				ARBDriversLicense.LICENSE_DATE_FORMAT);
	}

	/**
	 * @param number1 WRITEME
	 */
	public void setNumber (final String number1) {
		number = number1;
	}

	/**
	 * @param state1 WRITEME
	 */
	public void setState (final String state1) {
		state = state1;
	}
}
