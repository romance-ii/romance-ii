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

/**
 * WRITEME
 */
public class CreditCard {
	/**
	 * WRITEME
	 */
	public static final String EXPIRY_DATE_FORMAT = "yyyy-MM";
	/**
	 * WRITEME
	 */
	private String card_code;
	/**
	 * 13 or 16 digits. Must pass LUHN check.
	 * 
	 * WRITEME
	 */
	private String card_number;
	/**
	 * WRITEME
	 */

	private Date expiration_date;

	/**
	 * WRITEME
	 */
	public CreditCard () {
		card_code = "";
		card_number = "";
		expiration_date = new Date ();
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public String getCardCode () {
		return card_code;
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public String getCardNumber () {
		return card_number;
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public Date getExpirationDate () {
		return new Date (expiration_date.getTime ());
	}

	/**
	 * WRITEME
	 * 
	 * @param card_code1 WRITEME
	 */
	public void setCardCode (final String card_code1) {
		card_code = card_code1;
	}

	/**
	 * WRITEME
	 * 
	 * @param card_number1 WRITEME
	 */
	public void setCardNumber (final String card_number1) {
		card_number = card_number1;
	}

	/**
	 * WRITEME
	 * 
	 * @param expiration_date1 WRITEME
	 */
	public void setExpirationDate (final Date expiration_date1) {
		expiration_date = new Date (expiration_date1.getTime ());
	}

	/**
	 * WRITEME
	 * 
	 * @param expiration_date1 WRITEME
	 */
	public void setExpirationDate (final String expiration_date1) {
		expiration_date = net.authorize.arb.util.DateUtil
		.getDateFromFormattedDate (expiration_date1,
				CreditCard.EXPIRY_DATE_FORMAT);
	}
}
