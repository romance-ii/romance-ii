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

/**
 * WRITEME: The documentation for this type (ARBOrder) is incomplete.
 * (brpocock@star-hope.org, Nov 19, 2009)
 * 
 * @author brpocock@star-hope.org
 */
public class ARBOrder {
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) description (ARBOrder)
	 */
	private String description;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) invoiceNumber (ARBOrder)
	 */
	private String invoiceNumber;
	
	/**
	 *
	 */
	public ARBOrder () {
		// do nothing
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public String getDescription () {
		return description;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public String getInvoiceNumber () {
		return invoiceNumber;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param newDescription WRITEME
	 */
	public void setDescription (final String newDescription) {
		description = newDescription;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param newInvoiceNumber WRITEME
	 */
	public void setInvoiceNumber (final String newInvoiceNumber) {
		invoiceNumber = newInvoiceNumber;
	}
}
