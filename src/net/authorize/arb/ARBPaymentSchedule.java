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

import java.util.Date;

/**
 * WRITEME: The documentation for this type (ARBPaymentSchedule) is
 * incomplete. (brpocock@star-hope.org, Sep 23, 2009)
 */
public class ARBPaymentSchedule {
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) SCHEDULE_DATE_FORMAT (ARBPaymentSchedule)
	 */
	public static final String SCHEDULE_DATE_FORMAT = "yyyy-MM-dd";
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) interval_length (ARBPaymentSchedule)
	 */
	private int interval_length = 0;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) start_date (ARBPaymentSchedule)
	 */
	private Date start_date = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) subscription_unit (ARBPaymentSchedule)
	 */
	private String subscription_unit = "days"; // days | months
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) total_occurrences (ARBPaymentSchedule)
	 */
	private int total_occurrences = 0;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) trial_occurrences (ARBPaymentSchedule)
	 */
	private int trial_occurrences = 0;

	/**
	 * WRITEME
	 */
	public ARBPaymentSchedule () {
		// do nothing
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public int getIntervalLength () {
		return interval_length;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public Date getStartDate () {
		return new Date (start_date.getTime ());
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public String getSubscriptionUnit () {
		return subscription_unit;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public int getTotalOccurrences () {
		return total_occurrences;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public int getTrialOccurrences () {
		return trial_occurrences;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param newInterval_length WRITEME
	 */
	public void setIntervalLength (final int newInterval_length) {
		interval_length = newInterval_length;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param date WRITEME
	 */
	public void setStartDate (final Date date) {
		start_date = new Date (date.getTime ());
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param newStart_date WRITEME
	 */
	public void setStartDate (final String newStart_date) {
		start_date = net.authorize.arb.util.DateUtil
		.getDateFromFormattedDate (newStart_date,
				ARBPaymentSchedule.SCHEDULE_DATE_FORMAT);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param newSubscription_unit WRITEME
	 */
	public void setSubscriptionUnit (final String newSubscription_unit) {
		subscription_unit = newSubscription_unit;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param newTotal_occurrences WRITEME
	 */
	public void setTotalOccurrences (final int newTotal_occurrences) {
		total_occurrences = newTotal_occurrences;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param newTrial_occurrences WRITEME
	 */
	public void setTrialOccurrences (final int newTrial_occurrences) {
		trial_occurrences = newTrial_occurrences;
	}
}
