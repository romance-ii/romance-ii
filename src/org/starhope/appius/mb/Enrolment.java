/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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

package org.starhope.appius.mb;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * <p>
 * An Enrolment object represents a <i>potential type</i> of enrolment
 * or subscription into which an User can be subscribed. This does
 * <i>not</i> represent an actual commitment by the user to a particular
 * subscription, only that one is potentially possible.
 * </p>
 * 
 * @see UserEnrolment UserEnrolment for actual
 *      subscriptions/registrations
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Enrolment extends SimpleDataRecord <Enrolment> {
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (Enrolment.class);
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 7040272239205566945L;
	
	/**
	 * Returns all products in the products table that are flagged as
	 * Available AND Visible
	 * <p>
	 * XXX contains SQL
	 * </p>
	 * 
	 * @return all products in the products table that are flagged as
	 *         Available AND Visible
	 */
	public static Enrolment [] getAvailableEnrolments () {
		final LinkedList <Enrolment> products = new LinkedList <Enrolment> ();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT ID FROM products WHERE available='Y' AND visible='Y'");
			if (st.execute ()) {
				rs = st.getResultSet ();
				while (rs.next ()) {
					Enrolment enrolment = null;
					try {
						enrolment = Nomenclator.getDataRecord (
								Enrolment.class,
								rs.getInt ("ID"));
					} catch (final NotFoundException e) {
						Enrolment.log.error ("Exception", e);
					}
					if (null != enrolment) {
						products.add (enrolment);
					}
				}
			}
		} catch (final SQLException e) {
			return new Enrolment [] {};
		} finally {
			if (null != rs) {
				try {
					rs.close ();
				} catch (final SQLException e) { /* No Op */
				}
			}
			if (null != st) {
				try {
					st.close ();
				} catch (final SQLException e) { /* No Op */
				}
			}
			if (null != con) {
				try {
					con.close ();
				} catch (final SQLException e) { /* No Op */
				}
			}
			
		}
		return products.toArray (new Enrolment [products.size ()]);
	}
	
	/**
	 * Fetch up an enrolment by its numeric ID
	 * 
	 * @deprecated use {@link Nomenclator#getDataRecord(Class, int)}
	 *             with Enrolment.class
	 * @param productID the numeric product ID
	 * @return the enrolment with that ID
	 * @throws NotFoundException if no enrolment has that ID
	 */
	@Deprecated
	public static Enrolment getByID (final int productID)
			throws NotFoundException {
		return Nomenclator.getDataRecord (Enrolment.class, productID);
	}
	
	/**
	 * Fetch up an enrolment by its product code string
	 * 
	 * @deprecated use {@link Nomenclator#getDataRecord(Class, String)}
	 * @param productCode2 the product code for that enrolment type
	 * @return the enrolment named by the product code
	 * @throws NotFoundException if the enrolment type is not found
	 */
	@Deprecated
	public static Enrolment getByProductCode (final String productCode2)
			throws NotFoundException {
		return Nomenclator.getDataRecord (Enrolment.class,
				productCode2);
	}
	
	/**
	 * whether the enrolment type should renew from a recurring billing
	 */
	private boolean autoRenew;
	
	/**
	 * if this is true, the user (buyer) should be given the option to
	 * make their enrolment auto-renew, but not necessarily forced into
	 * doing it.
	 */
	private boolean autoRenewAsk;
	
	/**
	 * whether the enrolment type is available to be assigned to a new
	 * UserEnrolment
	 */
	private boolean available;
	/**
	 * the numeric ID for this product
	 */
	private int id;
	/**
	 * the price (XXX: only in USD)
	 */
	private BigDecimal price;
	/**
	 * the product code, typically used to uniquely and
	 * language-neutrally identify the product in user-visible ways
	 */
	private String productCode;
	/**
	 * the number of days for each renewal interval.
	 */
	private int renewDays;
	/**
	 * the number of months for each renewal interval. Note that
	 * monthly renewals are <em>not</em> 30-day renewals; they will
	 * take into account things like “he subscribed on the 31° January,
	 * so the next renewal is on the 1° March because February is too
	 * short” and stuff like that. (Note, this example might be
	 * incorrect…)
	 */
	private int renewMonths;
	/**
	 * the user-visible title (in English, XXX)
	 */
	private String title;
	
	/**
	 * Create a new enrolment with a given price-point.
	 * 
	 * @param d the price
	 */
	public Enrolment (final BigDecimal d) {
		super (Enrolment.class);
		setPrice (d);
	}
	
	/**
	 * Ctor used by loader
	 * 
	 * @param loader loader
	 */
	public Enrolment (final RecordLoader <Enrolment> loader) {
		super (loader);
	}
	
	/**
	 * @return whether to prompt the user (buyer) for the option to
	 *         auto-renew their subscription. If false, then the
	 *         {@link #isAutoRenew()} setting is controlling
	 *         automatically (they either will, or will not auto-renew
	 *         at the operator's discretion)
	 */
	public boolean askToAutoRenew () {
		return autoRenewAsk;
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof Enrolment)) {
			return false;
		}
		final Enrolment other = (Enrolment) obj;
		if (id != other.id) {
			return false;
		}
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return getID ();
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return getProductCode ();
	}
	
	/**
	 * @return the unit of currency describing the price; XXX currently
	 *         always USD
	 */
	public Currency getCurrency () {
		return Currency.get_USD ();
	}
	
	/**
	 * WRITEME WRITEME: document this method (brpocock@star-hope.org,
	 * Oct 13, 2009)
	 * 
	 * @return WRITEME
	 */
	public int getId () {
		// default getter (twheys@gmail.com, Oct 5, 2009)
		return getID ();
	}
	
	// /**
	// * Determine the appropriate expiry date, given a start date…
	// * @param begins the start date
	// * @return the expiry date
	// */
	// public Date getExpiryFor (final Date begins) {
	// final Calendar expiry = new GregorianCalendar ();
	// expiry.setTimeInMillis (begins.getTime ());
	// if (0 != getRenewalMonths()) {
	// expiry.add (Calendar.MONTH, getRenewalMonths());
	// } else {
	// expiry.add (Calendar.DATE, getRenewalDays());
	// }
	// return new Date (expiry.getTimeInMillis ());
	// }
	
	/**
	 * @return the id
	 */
	public int getID () {
		return id;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public BigDecimal getPrice () {
		return price;
	}
	
	/**
	 * @return WRITEME
	 */
	public int getPrivilegeDays () {
		return getRenewalDays ();
	}
	
	/**
	 * @return WRITEME
	 */
	public int getPrivilegeMonths () {
		return getRenewalMonths ();
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public String getProductCode () {
		// default getter (twheys@gmail.com, Oct 5, 2009)
		return productCode;
	}
	
	/**
	 * @return WRITEME
	 */
	public int getProductID () {
		return getID ();
	}
	
	/**
	 * @return the renewDays
	 */
	public int getRenewalDays () {
		return renewDays;
	}
	
	/**
	 * @return the renewMonths
	 */
	public int getRenewalMonths () {
		return renewMonths;
	}
	
	/**
	 * WRITEME WRITEME: document this method (brpocock@star-hope.org,
	 * Oct 13, 2009)
	 * 
	 * @return WRITEME
	 */
	public int getRenewMonths () {
		// default getter (twheys@gmail.com, Oct 5, 2009)
		return getRenewalMonths ();
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * @return WRITEME
	 */
	public String getTitle () {
		return title;
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result) + id;
		return result;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public boolean isAutoRenew () {
		// default getter (twheys@gmail.com, Oct 5, 2009)
		return isAutoRenewed ();
	}
	
	/**
	 * @return the autoRenew
	 */
	public boolean isAutoRenewed () {
		return autoRenew;
	}
	
	/**
	 * @return WRITEME
	 */
	public boolean isAvailable () {
		return available;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param equals WRITEME
	 */
	public void setAutoRenewalAsk (final boolean equals) {
		autoRenewAsk = equals;
		changed ();
	}
	
	/**
	 * @param alwaysAutoRenew the autoRenew to set
	 */
	public void setAutoRenewed (final boolean alwaysAutoRenew) {
		autoRenew = alwaysAutoRenew;
		changed ();
	}
	
	/**
	 * @param nowAvailable the available to set
	 */
	public void setAvailable (final boolean nowAvailable) {
		available = nowAvailable;
		changed ();
	}
	
	/**
	 * @param newID the id to set
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @param price1 WRITEME
	 */
	public void setPrice (final BigDecimal price1) {
		price = price1;
	}
	
	/**
	 * @param newProductCode the productCode to set
	 */
	public void setProductCode (final String newProductCode) {
		productCode = newProductCode;
		changed ();
	}
	
	/**
	 * @param newRenewDays the renewDays to set
	 */
	public void setRenewalDays (final int newRenewDays) {
		renewDays = newRenewDays;
		changed ();
	}
	
	/**
	 * @param newRenewMonths the renewMonths to set
	 */
	public void setRenewalMonths (final int newRenewMonths) {
		renewMonths = newRenewMonths;
		changed ();
	}
	
	/**
	 * @param newTitle the title to set
	 */
	public void setTitle (final String newTitle) {
		title = newTitle;
		changed ();
	}
	
}
