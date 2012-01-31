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

package org.starhope.util;

import java.util.Date;
import java.util.Properties;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class GetTexty {
	
	/**
	 * The message catalog
	 */
	public static final Properties messages = new Properties ();
	
	/**
	 * Format a date into a user-friendly visible object relative to
	 * "now."
	 * 
	 * @param targetDate the date (in the future)
	 * @return a user-visible string form
	 */
	public static String formatFutureDate (final Date targetDate) {
		final Date now = new Date ();
		if (targetDate.compareTo (now) < 0) {
			return "the past";
		}
		if (targetDate.compareTo (now) == 0) {
			return "right now";
		}
		
		final long diffSec = targetDate.getTime () - now.getTime ();
		
		if (diffSec == 1) {
			return "a second from now";
		}
		
		if (diffSec < 6) {
			return "a few seconds from now";
		}
		
		if (diffSec < 60) {
			return "" + diffSec + " seconds from now";
		}
		
		if (diffSec < 180) {
			final long remSec = diffSec - 60;
			return "a minute and " + diffSec + " second"
					+ (remSec > 1 ? "s" : "") + " from now";
		}
		
		if (diffSec < (60 * 90)) {
			return "" + (int) (diffSec / 60) + " minutes from now";
		}
		
		if (diffSec < (60 * 60 * 36)) {
			final long hours = diffSec / (60 * 60);
			final long minutes = ( (diffSec % (60 * 60)) / (60 * 15)) * 15;
			return "about " + hours + " hours and " + minutes
					+ " minutes from now";
		}
		
		final long days = diffSec / (60 * 60 * 24);
		return "about " + days + " days from now";
	}
	
}
