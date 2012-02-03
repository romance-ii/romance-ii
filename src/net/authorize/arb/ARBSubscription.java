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

import java.math.BigDecimal;

/**
 * WRITEME
 */
public class ARBSubscription {
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * amount (ARBSubscription)
	 */
	// private boolean amount_specified = false;
	private BigDecimal amount = new BigDecimal ("0.0");

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * bill_to (ARBSubscription)
	 */
	private ARBNameAndAddress bill_to = null;
	// private boolean order_specified = false;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * customer (ARBSubscription)
	 */
	private ARBCustomer customer = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * name (ARBSubscription)
	 */
	private String name = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * order (ARBSubscription)
	 */
	private ARBOrder order = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * payment (ARBSubscription)
	 */
	private ARBPayment payment = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * schedule (ARBSubscription)
	 */
	private ARBPaymentSchedule schedule = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * ship_to (ARBSubscription)
	 */
	private ARBNameAndAddress ship_to = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * subscription_id (ARBSubscription)
	 */
	private String subscription_id = null;
	// private boolean trial_amount_specified = false;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * trial_amount (ARBSubscription)
	 */
	private double trial_amount = 0.0;

	/**
	 * 
	 */
	public ARBSubscription () {
		// do nothing
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @return WRITEME
	 */
	public BigDecimal getAmount () {
		return amount;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @return WRITEME
	 */
	public ARBNameAndAddress getBillTo () {
		return bill_to;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @return WRITEME
	 */
	public ARBCustomer getCustomer () {
		return customer;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @return WRITEME
	 */
	public String getName () {
		return name;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @return WRITEME
	 */
	public ARBOrder getOrder () {
		return order;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @return WRITEME
	 */
	public ARBPayment getPayment () {
		return payment;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @return WRITEME
	 */
	public ARBPaymentSchedule getSchedule () {
		return schedule;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @return WRITEME
	 */
	public ARBNameAndAddress getShipTo () {
		return ship_to;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @return WRITEME
	 */
	public String getSubscriptionId () {
		return subscription_id;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @return WRITEME
	 */
	public double getTrialAmount () {
		return trial_amount;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @param newAmount WRITEME
	 */
	public void setAmount (final BigDecimal newAmount) {
		amount = newAmount;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @param newBill_to WRITEME
	 */
	public void setBillTo (final ARBNameAndAddress newBill_to) {
		bill_to = newBill_to;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @param newCustomer WRITEME
	 */
	public void setCustomer (final ARBCustomer newCustomer) {
		customer = newCustomer;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @param newName WRITEME
	 */
	public void setName (final String newName) {
		name = newName;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @param newOrder WRITEME
	 */
	public void setOrder (final ARBOrder newOrder) {
		order = newOrder;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @param newPayment WRITEME
	 */
	public void setPayment (final ARBPayment newPayment) {
		payment = newPayment;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @param newSchedule WRITEME
	 */
	public void setSchedule (final ARBPaymentSchedule newSchedule) {
		schedule = newSchedule;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @param newShip_to WRITEME
	 */
	public void setShipTo (final ARBNameAndAddress newShip_to) {
		ship_to = newShip_to;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @param newSubscription_id WRITEME
	 */
	public void setSubscriptionId (final String newSubscription_id) {
		subscription_id = newSubscription_id;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19, 2009)
	 * 
	 * @param newTrial_amount WRITEME
	 */
	public void setTrialAmount (final double newTrial_amount) {
		trial_amount = newTrial_amount;
	}
}
