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

/** WRITEME */
public class ARBNameAndAddress {
	/** WRITEME */
	private String address;
	/** WRITEME */
	private String city;
	/** WRITEME */
	private String company;
	/** WRITEME */
	private String country;
	/** WRITEME */
	private String first_name;
	/** WRITEME */
	private String last_name;
	/** WRITEME */
	private String state;
	/** WRITEME */
	private String zip;

	/** WRITEME */
	public ARBNameAndAddress () {
		address = "";
		city = "";
		company = "";
		country = "";
		first_name = "";
		last_name = "";
		state = "";
		zip = "";
	}

	/**
	 * @return WRITEME
	 */
	public String getAddress () {
		return address;
	}

	/**
	 * @return WRITEME
	 */
	public String getCity () {
		return city;
	}

	/**
	 * @return WRITEME
	 */
	public String getCompany () {
		return company;
	}

	/**
	 * @return WRITEME
	 */
	public String getCountry () {
		return country;
	}

	/**
	 * @return WRITEME
	 */
	public String getFirstName () {
		return first_name;
	}

	/**
	 * @return WRITEME
	 */
	public String getLastName () {
		return last_name;
	}

	/**
	 * @return WRITEME
	 */
	public String getState () {
		return state;
	}

	/**
	 * @return WRITEME
	 */
	public String getZip () {
		return zip;
	}

	/**
	 * @param address1 WRITEME
	 */
	public void setAddress (final String address1) {
		address = address1;
	}

	/**
	 * @param city1 WRITEME
	 */
	public void setCity (final String city1) {
		city = city1;
	}

	/**
	 * @param company1 WRITEME
	 */
	public void setCompany (final String company1) {
		company = company1;
	}

	/**
	 * @param country1 WRITEME
	 */
	public void setCountry (final String country1) {
		country = country1;
	}

	/**
	 * @param first_name1 WRITEME
	 */
	public void setFirstName (final String first_name1) {
		first_name = first_name1;
	}

	/**
	 * @param last_name1 WRITEME
	 */
	public void setLastName (final String last_name1) {
		last_name = last_name1;
	}

	/**
	 * @param state1 WRITEME
	 */
	public void setState (final String state1) {
		state = state1;
	}

	/**
	 * @param zip1 WRITEME
	 */
	public void setZip (final String zip1) {
		zip = zip1;
	}
}
