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
package net.authorize.arb;

/**
 * WRITEME
 */
public class BankAccount {
	/**
	 * WRITEME
	 */
	private String account_number; // 5 to 17 digits
	/**
	 * WRITEME // one of // "checking","savings","businessChecking"
	 */
	private String account_type;
	/**
	 * WRITEME
	 */
	private String bank_name;
	/**
	 * WRITEME one of // "PPD","WEB","CCD","TEL"
	 */
	private String echeck_type;
	/**
	 * WRITEME
	 */
	private String name_on_account;
	/**
	 * 9 digits WRITEME
	 */
	private String routing_number; // 9 digits
	
	/**
	 * WRITEME
	 */
	public BankAccount () {
		super ();
	}
	
	/**
	 * @return WRITEME
	 */
	public String getAccountNumber () {
		return account_number;
	}
	
	/**
	 * @return WRITEME
	 */
	public String getAccountType () {
		return account_type;
	}
	
	/**
	 * @return WRITEME
	 */
	public String getBankName () {
		return bank_name;
	}
	
	/**
	 * @return WRITEME
	 */
	public String getEcheckType () {
		return echeck_type;
	}
	
	/**
	 * @return WRITEME
	 */
	public String getNameOnAccount () {
		return name_on_account;
	}
	
	/**
	 * @return WRITEME
	 */
	public String getRoutingNumber () {
		return routing_number;
	}
	
	/**
	 * @param account_number1 WRITEME
	 */
	public void setAccountNumber (final String account_number1) {
		account_number = account_number1;
	}
	
	/**
	 * @param account_type1 WRITEME
	 */
	public void setAccountType (final String account_type1) {
		account_type = account_type1;
	}
	
	/**
	 * @param bank_name1 WRITEME
	 */
	public void setBankName (final String bank_name1) {
		bank_name = bank_name1;
	}
	
	/**
	 * @param echeck_type1 WRITEME
	 */
	public void setEcheckType (final String echeck_type1) {
		echeck_type = echeck_type1;
	}
	
	/**
	 * @param name_on_account1 WRITEME
	 */
	public void setNameOnAccount (final String name_on_account1) {
		name_on_account = name_on_account1;
	}
	
	/**
	 * @param routing_number1 WRITEME
	 */
	public void setRoutingNumber (final String routing_number1) {
		routing_number = routing_number1;
	}
}
