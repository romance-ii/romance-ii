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
 * WRITEME
 * 
 */
public class ARBPayment {
	/**
	 * WRITEME
	 */
	private BankAccount bank_account;
	/**
	 * WRITEME
	 */
	private CreditCard credit_card;

	/**
	 * WRITEME
	 */
	public ARBPayment () {
		bank_account = null;
		credit_card = null;
	}

	/**
	 * WRITEME
	 * 
	 * @param in_account WRITEME
	 */
	public ARBPayment (final BankAccount in_account) {
		bank_account = in_account;
	}

	/**
	 * WRITEME
	 * 
	 * @param in_credit WRITEME
	 */
	public ARBPayment (final CreditCard in_credit) {
		credit_card = in_credit;
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public BankAccount getBankAccount () {
		return bank_account;
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public CreditCard getCreditCard () {
		return credit_card;
	}

	/**
	 * WRITEME
	 * 
	 * @param bank_account1 WRITEME
	 */
	public void setBankAccount (final BankAccount bank_account1) {
		bank_account = bank_account1;
	}

	/**
	 * WRITEME
	 * 
	 * @param credit_card1 WRITEME
	 */
	public void setCreditCard (final CreditCard credit_card1) {
		credit_card = credit_card1;
	}

}
