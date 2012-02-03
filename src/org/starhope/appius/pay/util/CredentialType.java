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
package org.starhope.appius.pay.util;

/**
 * This is a listing of "all possible" means of making a payment.
 * 
 * @author brpocock@star-hope.org
 * 
 */
public enum CredentialType {
	/**
	 * American Express Card
	 */
	AMEX,
	/**
	 * Automatic Cheque Handling (ACH) or ‘eCheque’
	 */
	CHECKING_ACCOUNT,
	/**
	 * Gift card redemption
	 */
	GIFT_CARD,
	/**
	 * iBC Card
	 */
	IBC_CARD,
	/**
	 * MasterCard
	 */
	MC,
	/**
	 * Money Market account ACH (or non-checking/non-savings account ACH
	 * in general)
	 */
	MM_ACCOUNT,
	/**
	 * Novus (Discover) Card
	 */
	NOVUS,
	/**
	 * PayPal electronic funds transfer
	 */
	PAYPAL,
	/**
	 * ACH from Savings account
	 */
	SAVINGS_ACCOUNT,
	/**
	 * The credentials contained by this object have been voluntarily
	 * shredded
	 */
	SHREDDED,
	/**
	 * VISA Card
	 */
	VISA
}
