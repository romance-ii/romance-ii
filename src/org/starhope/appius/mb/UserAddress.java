/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.mb;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import javax.naming.NamingException;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.DataException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.messaging.Mail;
import org.starhope.appius.sql.SQLPeerDatum;
import org.starhope.appius.user.AbstractPerson;

/**
 * @author brpocock@star-hope.org
 */
public class UserAddress extends SQLPeerDatum {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 8046742159122084295L;

	/**
	 * Street address (or similar), line 1 (of 2)
	 *
	 * @see #address2
	 */
	private String address = "";

	/**
	 * Street address (or similar), line 2 (of 2)
	 *
	 * @see #address
	 */
	private String address2 = "";

	/**
	 * The type of location described; might be e.g. Billing, Home,
	 * Office.
	 */
	private String addressType = "";

	/**
	 * The city, town, village, &c. part of the address
	 */
	private String city = "";

	/**
	 * The 2-digit ISO country code
	 */
	private String country = "";

	/**
	 * The unique ID for storing this address into the database (if so
	 * stored)
	 */
	private final int database_id = -1;

	/**
	 * if known, the latitude of the address
	 */
	private BigDecimal latitude = null;

	/**
	 * the locality or other subdivisional indicia of the address
	 */
	private String locality = "";

	/**
	 * if known, the longitude of the address
	 */
	private BigDecimal longitude = null;

	/**
	 * an eMail address
	 */
	private String mail = "";

	/**
	 * a telephone number with local formatting as desired
	 */
	private String phone = "";

	/**
	 * The postal or ZIP code. US ZIP codes must not have the ZIP+4 or
	 * 12-digit format in this variable.
	 */
	private String postalCode = "";

	/**
	 * The state or province
	 */
	private String province = "";

	/**
	 * A user-selected title for convenience of user selection of an
	 * address from a collection
	 */
	private String title = "";

	/**
	 * The user affiliated with this address
	 */
	private AbstractPerson user = null;

	/**
	 * The Internet Domain Name of the service used for validation (e.g.
	 * "google.com" for Google Maps); null, if the address has not been
	 * validated
	 */
	private String validatedByDomain = null;

	/**
	 * The date of validation, if this address has been externally
	 * validated; else, null
	 */
	private Date validatedOn = null;

	/**
	 * WRITEME
	 */
	private String zipPlus4;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 */
	public UserAddress () {
		// no-op constructor
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param addressFirst WRITEME
	 * @param addressSecond WRITEME
	 * @param theCity WRITEME
	 * @param stateProvinceOrLocality WRITEME
	 * @param theCountry WRITEME
	 * @param thePostalCode WRITEME
	 * @param phoneNumber WRITEME
	 * @param electronicMail WRITEME
	 * @throws NamingException bad eMail
	 * @throws DataException bad eMail
	 */
	public UserAddress (final String addressFirst,
			final String addressSecond, final String theCity,
			final String stateProvinceOrLocality,
			final String theCountry, final String thePostalCode,
			final String phoneNumber, final String electronicMail)
			throws DataException, NamingException {
		setAddress (addressFirst, addressSecond);
		setCity (theCity);
		setProvince (stateProvinceOrLocality);
		setCountry (theCountry);
		setPostalCode (thePostalCode);
		setPhone (phoneNumber);
		setMail (electronicMail);
	}

	/**
	 * Request an asynchronous validation against some online service or
	 * other (Google, Yahoo, whoever)
	 */
	public void asyncValidate () {
		AppiusClaudiusCaecus
				.reportBug ("Address validation not implemented");
	}

	/**
	 * <p>
	 * Convenience method, to match up against the address fields as
	 * provided by Authorize.Net. Plus, it might come in useful in other
	 * contexts as well.
	 * </p>
	 * <p>
	 * Note that this method doesn't care about address line two, but
	 * it's quite strict on the rest. It would actually make sense to
	 * run both addresses through some minimal degree of conformance
	 * first, but that's outside the current SOW. TODO?
	 * </p>
	 *
	 * @param streetAddress streetAddress
	 * @param otherCity city
	 * @param otherProvince province/state
	 * @param otherPostalCode postal/ZIP code
	 * @param otherCountry country
	 * @return True, if all of the fields match up.
	 */
	public boolean equals (final String streetAddress,
			final String otherCity, final String otherProvince,
			final String otherPostalCode, final String otherCountry) {
		return address.equals (streetAddress)
		&& city.equals (otherCity)
		&& province.equals (otherProvince)
		&& postalCode.equals (otherPostalCode)
		&& country.equals (otherCountry);
	}

	/**
	 * This is an overriding method.
	 *
	 * @see org.starhope.appius.sql.SQLPeerDatum#flush()
	 */
	@Override
	public void flush () {
		// TODO Auto-generated method stub (brpocock@star-hope.org, Aug
		// 25, 2009)

	}

	/**
	 * @return line 1 of the street address
	 */
	public String getAddress () {
		return address;
	}

	/**
	 * @return line 2 of the street address
	 */
	public String getAddress2 () {
		return address2;
	}

	/**
	 * @return both lines of the street address, separated with a
	 *         newline. If the address has only one line, it will not
	 *         have a newline and a second line.
	 */
	public String getAddressPair () {
		return address
		+ (address2 != null && address2.length () > 0 ? "\n"
				+ address2 : "");
	}

	/**
	 * @return the type of address which this represents
	 */
	public String getAddressType () {
		return addressType;
	}

	/**
	 * @return the apartment number of the address
	 */
	public String getApartment () {
		return null;
		// TODO: Get suite or apartment number
	}

	/**
	 * @see org.starhope.appius.sql.SQLPeerDatum#getCacheUniqueID()
	 */
	@Override
	protected String getCacheUniqueID () {
		return String.valueOf (database_id);
	}

	/**
	 * @return the city of the address
	 */
	public String getCity () {
		return city;
	}

	/**
	 * @return the country code for the address (2-char ISO code)
	 */
	public String getCountry () {
		return country;
	}

	/**
	 * @return the longitude (if known)
	 */
	public BigDecimal getIntitude () {
		return longitude;
	}

	/**
	 * @return the latitude (if known)
	 */
	public BigDecimal getLatitude () {
		return latitude;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 24,
	 * 2009)
	 *
	 * @return WRITEME
	 */
	public String getLocality () {
		// default getter (twheys@gmail.com, Sep 4, 2009)
		return locality;
	}

	/**
	 * @return the postal code of the address
	 */
	public String getMail () {
		return mail;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 24,
	 * 2009)
	 *
	 * @return WRITEME
	 */
	public String getPhone () {
		// default getter (twheys@gmail.com, Sep 11, 2009)
		return phone;
	}

	/**
	 * @return the postal code of the address
	 */
	public String getPostalCode () {
		return postalCode;
	}

	/**
	 * @return the property number (house number) of the address
	 */
	public String getPropertyNumber () {
		// TODO: From this.address
		return null;
	}

	/**
	 * @return the province/state part of the address
	 */
	public String getProvince () {
		return province;
	}

	/**
	 * @return the street name (without the street type, e.g. for
	 *         "123 Sesame St" this would yield "Sesame")
	 */
	public String getStreetName () {
		return null;
		// TODO: From this.address
	}

	/**
	 * @return the street type (e.g. "St" or "Ave")
	 */
	public String getStreetType () {
		return null;
		// TODO: From this.address (e.g. ST,AVE)
	}

	/**
	 * @return the title for this address, supplied by the user: e.g.
	 *         "Home" or "Office" perhaps
	 */
	public String getTitle () {
		return title;
	}

	/**
	 * @return The user owning this address
	 */
	public AbstractPerson getUser () {
		return user;
	}

	/**
	 * @return the domain of the service which validated this address
	 *         (if any)
	 */
	public String getValidatedByDomain () {
		return validatedByDomain;
	}

	/**
	 * @return the date at which this address was validated
	 */
	public Date getValidatedOn () {
		return (Date) validatedOn.clone ();
	}

	/**
	 * @return the four-digit "PLUS-4" part of a ZIP code
	 */
	public String getZipPlus4 () {
		return zipPlus4;
	}

	/**
	 * @return “true” only after an external validation has been
	 *         performed upon this address, e.g. via Google Maps or
	 *         similar
	 */
	public boolean isExternallyValidated () {
		return null != validatedByDomain && null != validatedOn;
	}

	/**
	 * This method determines whether the supplied address is
	 * <em>plausible</em> to be valid. TODO
	 *
	 * @return false, if the address is clearly not valid
	 */
	public boolean isValidAddress () {
		// FIXME validate the street address with Google or Yahoo or
		// someone
		return true;
	}

	/**
	 * @see org.starhope.appius.util.CastsToJSON#set(org.json.JSONObject)
	 */
	@Override
	public void set (final JSONObject o) {
		try {
			if (o.has ("user")) {
				/*
				 * try { setUser (User.get (o.getJSONObject ("user")));
				 * } catch (final Exception e) {
				 * AppiusClaudiusCaecus.reportBug (e); }
				 */
			}
			if (o.has ("address")) {
				setAddress (o.getString ("address"),
						o.getString ("address2"));
			}
			if (o.has ("city")) {
				setCity (o.getString ("city"));
			}
			if (o.has ("province")) {
				setProvince (o.getString ("province"));
			}
			if (o.has ("country")) {
				setCountry (o.getString ("country"));
			}
			if (o.has ("postalCode")) {
				setPostalCode (o.getString ("postalCode"));
			}
			if (o.has ("zipPlus4")) {
				setZipPlus4 (o.getString ("zipPlus4"));
			}
			if (o.has ("title")) {
				setTitle (o.getString ("title"));
			}
			if (o.has ("addressType")) {
				setAddressType (o.getString ("addressType"));
			}
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (e);
		}
	}

	/**
	 * This is an overriding method.
	 *
	 * @see org.starhope.appius.sql.SQLPeerDatum#set(java.sql.ResultSet)
	 */
	@Override
	protected void set (final ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub (brpocock@star-hope.org, Aug
		// 25, 2009)

	}

	/**
	 * @param newAddress the first line of the address
	 * @param newAddress2 the second line
	 */
	public void setAddress (final String newAddress,
			final String newAddress2) {
		System.err.println (newAddress + " " + newAddress2);
		address = newAddress;
		address2 = newAddress2;
		changed ();
	}

	/**
	 * @param newAddressType the type of the address
	 */
	public void setAddressType (final String newAddressType) {
		addressType = newAddressType;
		changed ();
	}

	/**
	 * @param newCity the city/town/village part of the address
	 */
	public void setCity (final String newCity) {
		city = newCity;
		changed ();
	}

	/**
	 * @param newCountry the country code for the address
	 */
	public void setCountry (final String newCountry) {
		country = newCountry;
		changed ();
	}

	/**
	 * @param latitude1 the latitude to set
	 */
	public void setLatitude (final BigDecimal latitude1) {
		latitude = latitude1;
		changed ();

	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 *
	 * @param locality1 WRITEME
	 */
	public void setLocality (final String locality1) {
		locality = locality1;
	}

	/**
	 * @param longitude1 the longitude to set
	 */
	public void setLongitude (final BigDecimal longitude1) {
		longitude = longitude1;
		changed ();

	}

	/**
	 * @param newMail WRITEME
	 * @throws NamingException
	 * @throws DataException
	 */
	public void setMail (final String newMail) throws DataException,
			NamingException {
		mail = newMail;
		Mail.validateMail (newMail);
		changed ();

	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 *
	 * @param phone1 WRITEME
	 */
	public void setPhone (final String phone1) {
		// default setter (twheys@gmail.com, Sep 11, 2009)
		phone = phone1;
	}

	/**
	 * @param newPostalCode the postal/ZIP code of the address
	 */
	public void setPostalCode (final String newPostalCode) {
		postalCode = newPostalCode;
		changed ();

	}

	/**
	 * @param newProvince the province/state/locality of the address
	 */
	public void setProvince (final String newProvince) {
		province = newProvince;
		changed ();
	}

	/**
	 * @param newTitle the user-visible title of the address
	 */
	public void setTitle (final String newTitle) {
		title = newTitle;
		changed ();
	}

	/**
	 * @param newUser the user whose address this is
	 */
	public void setUser (final AbstractPerson newUser) {
		user = newUser;
		changed ();
	}

	/**
	 * @param validatedByDomain1 the validatedByDomain to set
	 */
	public void setValidatedByDomain (final String validatedByDomain1) {
		validatedByDomain = validatedByDomain1;
		changed ();

	}

	/**
	 * @param validated the validated to set
	 */
	public void setValidatedOn (final Date validated) {
		validatedOn = (Date) validated.clone ();
		changed ();

	}

	/**
	 * @param newZipPlus4 the ZIP+4 code for a US address
	 */
	public void setZipPlus4 (final String newZipPlus4) {
		zipPlus4 = newZipPlus4;
		changed ();

	}

	/**
	 * This is an overriding method.
	 *
	 * @see org.starhope.appius.sql.SQLPeerDatum#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject o = new JSONObject ();
		try {
			if (null != user) {
				o.put ("user", getUser ());
			}
			if (null != address) {
				o.put ("address", getAddress ());
			}
			if (null != address2) {
				o.put ("address2", getAddress2 ());
			}
			if (null != city) {
				o.put ("city", getCity ());
			}
			if (null != province) {
				o.put ("province", getProvince ());
			}
			if (null != country) {
				o.put ("country", getCountry ());
			}
			if (null != postalCode) {
				o.put ("postalCode", getPostalCode ());
			}
			if (null != zipPlus4) {
				o.put ("zipPlus4", getZipPlus4 ());
			}
			if (null != title) {
				o.put ("title", getTitle ());
			}
			if (null != addressType) {
				o.put ("addressType", getAddressType ());
			}
			o.put ("id", database_id);
		} catch (final JSONException e) {
			// TODO Auto-generated catch block
			AppiusClaudiusCaecus.reportBug (e);
		}

		return o;
	}

	/**
	 * This method <em>should</em> validate the supplied address by
	 * passing it through a geocoding service or similar methods. A
	 * minimum level of validation should include an integrity check
	 * that values such as ZIP code and city are plausible, even if it
	 * does not accurately determine such details as the street
	 * address's actual existence.
	 *
	 * @return True, if the address supplied appears to be potentially
	 *         valid
	 */
	public boolean validate () {
		if ("us".equalsIgnoreCase (country)) {
			if (postalCode.length () != 5) {
				return false;
			}
		}
		// XXX: VALIDATE THIS ADDRESS SYNCHRONOUSLY
		return true;
	}

}
