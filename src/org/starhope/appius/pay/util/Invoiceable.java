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

import java.math.BigDecimal;

import org.starhope.appius.mb.Currency;
import org.starhope.appius.user.AbstractPerson;

/**
 * @author brpocock@star-hope.org
 * 
 */
public interface Invoiceable {
	/**
	 * @return the price of a purchase
	 */
	public BigDecimal getAmount ();

	/**
	 * TODO: refactor payment gateways to use the buyer information:
	 * promote this up to Invoiceable interface.
	 * 
	 * @return the buyer, paying-for this order
	 */
	public AbstractPerson getBuyer ();

	/**
	 * @return the currency used to describe the price in
	 *         {@link #getAmount()}
	 */
	public Currency getCurrency ();

	/**
	 * @return the invoice ID ("order number") for payment
	 */
	public String getInvoiceID ();

	/**
	 * 
	 * 
	 * @return A single-character code representing this class of
	 *         invoiceable items. This permits easy identification of
	 *         the type of object being paid for, regardless of how we
	 *         come across the invoice number.
	 */
	public char getInvoiceIDPrefix ();

	/**
	 * @return the billing address for a purchase
	 */
	// public UserAddress getAddress ();
	/**
	 * @return the description of a purchase
	 */
	public String getTitle ();
}
