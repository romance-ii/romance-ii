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
package net.authorize.arb.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * WRITEME
 */
public class DateUtil {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (DateUtil.class);
	
	/**
	 * @param dateStr WRITEME
	 * @param format WRITEME
	 * @return WRITEME
	 */
	public static Date getDateFromFormattedDate (final String dateStr,
			final String format) {
		try {
			final SimpleDateFormat sdf = new SimpleDateFormat (
					format);
			if (dateStr != null) {
				final Date date = sdf.parse (dateStr);
				return date;
			}
		} catch (final ParseException pe) {
			log.error ("Exception: ", pe);
		}
		return new Date (0);
	}
	
	/**
	 * @param date WRITEME
	 * @param format WRITEME
	 * @return WRITEME
	 */
	public static String getFormattedDate (final Date date,
			final String format) {
		try {
			final SimpleDateFormat sdf = new SimpleDateFormat (
					format);
			return sdf.format (date);
		} catch (final Exception e) {
			log.error ("Exception", e);
		}
		return null;
	}
}
