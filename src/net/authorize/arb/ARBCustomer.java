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

/** WRITEME */
public class ARBCustomer {
	/** WRITEME */
	private ARBNameAndAddress bill_to;
	/** WRITEME */
	private boolean driversLicenseSpecified;
	/** WRITEME */
	private String email;
	
	/** WRITEME */
	private String faxNumber;
	/** WRITEME */
	private String id;
	/** WRITEME */
	private ARBDriversLicense license;
	/** WRITEME */
	private String phoneNumber;
	/** WRITEME */
	private ARBNameAndAddress ship_to;
	/** WRITEME */
	private String taxId;
	
	/** type = individual | business */
	private String type;
	
	/** WRITEME */
	public ARBCustomer () {
		bill_to = null;
		driversLicenseSpecified = false;
		email = "";
		faxNumber = "";
		id = "";
		license = null;
		phoneNumber = "";
		ship_to = null;
		taxId = "";
		type = "";
	}
	
	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public ARBNameAndAddress getBillTo () {
		return bill_to;
	}
	
	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public String getEmail () {
		return email;
	}
	
	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public String getFaxNumber () {
		return faxNumber;
	}
	
	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public String getId () {
		return id;
	}
	
	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public ARBDriversLicense getLicense () {
		return license;
	}
	
	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public String getPhoneNumber () {
		return phoneNumber;
	}
	
	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public ARBNameAndAddress getShipTo () {
		return ship_to;
	}
	
	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public String getTaxId () {
		return taxId;
	}
	
	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public String getType () {
		return type;
	}
	
	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public boolean isDriversLicenseSpecified () {
		return driversLicenseSpecified;
	}
	
	/**
	 * WRITEME
	 * 
	 * @param bill_to1 WRITEME
	 */
	public void setBillTo (final ARBNameAndAddress bill_to1) {
		bill_to = bill_to1;
	}
	
	/** @param driversLicenseSpecified1 WRITEME */
	public void setDriversLicenseSpecified (
			final boolean driversLicenseSpecified1) {
		driversLicenseSpecified = driversLicenseSpecified1;
	}
	
	/** @param email1 WRITEME */
	public void setEmail (final String email1) {
		email = email1;
	}
	
	/** @param faxNumber1 WRITEME */
	public void setFaxNumber (final String faxNumber1) {
		faxNumber = faxNumber1;
	}
	
	/** @param id1 WRITEME */
	public void setId (final String id1) {
		id = id1;
	}
	
	/** @param license1 WRITEME */
	public void setLicense (final ARBDriversLicense license1) {
		license = license1;
	}
	
	/**
	 * @param phoneNumber1 WRITEME
	 */
	public void setPhoneNumber (final String phoneNumber1) {
		phoneNumber = phoneNumber1;
	}
	
	/**
	 * @param ship_to1 WRITEME
	 */
	public void setShipTo (final ARBNameAndAddress ship_to1) {
		ship_to = ship_to1;
	}
	
	/**
	 * @param taxId1 WRITEME
	 */
	public void setTaxId (final String taxId1) {
		taxId = taxId1;
	}
	
	/**
	 * @param type1 WRITEME
	 */
	public void setType (final String type1) {
		type = type1;
	}
}
