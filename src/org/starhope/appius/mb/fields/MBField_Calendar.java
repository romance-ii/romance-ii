/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.mb.fields;

import java.sql.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.TimeZone;

import org.starhope.appius.except.DataException;
import org.starhope.appius.mb.MBSession;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class MBField_Calendar extends MBField <Calendar> {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -8142176462016612498L;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param mySession WRITEME  brpocock 
	 * @param myIdent WRITEME  brpocock 
	 */
	public MBField_Calendar (final MBSession mySession,
			final MBFieldIdent myIdent) {
		super (mySession, myIdent);
	}
	
	/**
	 * @see org.starhope.appius.mb.fields.MBField#checkValue(java.lang.Object)
	 */
	@Override
	protected boolean checkValue (final Calendar newValue) {
		return null != newValue;
	}
	
	/**
	 * @see org.starhope.appius.mb.fields.MBField#convert(java.lang.Object)
	 */
	@Override
	public Calendar convert (final Object newValue)
			throws DataException {
		if (newValue instanceof Calendar) {
			return (Calendar) newValue;
		}
		if (newValue instanceof Date) {
			final Calendar c = new GregorianCalendar (
					TimeZone.getTimeZone ("America/New_York"));
			c.setTime ((Date) newValue);
			return c;
		}
		if (newValue instanceof java.util.Date) {
			final Calendar c = new GregorianCalendar (
					TimeZone.getTimeZone ("America/New_York"));
			c.setTime ((java.util.Date) newValue);
			return c;
		}
		if (newValue instanceof Long) {
			final Calendar c = new GregorianCalendar (
					TimeZone.getTimeZone ("America/New_York"));
			c.setTime (new Date ( ((Long) newValue).longValue ()));
			return c;
		}
		
		if (newValue instanceof String) {
			final Calendar c = new GregorianCalendar ();
			
			final String s = (String) newValue;
			if (s.matches ("[12][0-9]{3}-[01]?[0-9]-[0-3]?[0-9]")) {
				final String [] parts = s.split ("-");
				c.set (Calendar.YEAR, Integer.parseInt (parts [0]));
				c.set (Calendar.MONTH, Integer.parseInt (parts [1]));
				c.set (Calendar.DAY_OF_MONTH,
						Integer.parseInt (parts [2]));
				return c;
			}
		}
		
		throw new DataException (newValue.toString ());
	}
	
	/**
	 * @return the day of the month as an integer, or -1 for null
	 */
	public int getDate () {
		return null == value ? -1 : value.get (Calendar.DAY_OF_MONTH);
	}
	
	/**
	 * Used for Julian Dates (e.g. 2010.319 for 2010-11-15) — the day
	 * of the year, rather than the day of the month. Analogous to %j
	 * in date formatting strings.
	 * 
	 * @return the day of the year as an integer, or -1 for null.
	 */
	public int getJDate () {
		return null == value ? -1 : value.get (Calendar.DAY_OF_YEAR);
	}
	
	/**
	 * @return The month as an integer, or -1 for null
	 */
	public int getMonth () {
		return null == value ? -1 : value.get (Calendar.MONTH);
	}
	
	/**
	 * @return The year as an integer, or -1 for null
	 */
	public int getYear () {
		return null == value ? -1 : value.get (Calendar.YEAR);
	}
}
