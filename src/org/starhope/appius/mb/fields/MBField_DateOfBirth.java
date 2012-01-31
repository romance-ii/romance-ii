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

import java.util.Calendar;

import org.starhope.appius.mb.MBSession;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class MBField_DateOfBirth extends MBField_Calendar {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 6806207507638701775L;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param mySession WRITEME  brpocock 
	 * @param myIdent WRITEME  brpocock 
	 */
	public MBField_DateOfBirth (final MBSession mySession,
			final MBFieldIdent myIdent) {
		super (mySession, myIdent);
	}
	
	/**
	 * @see org.starhope.appius.mb.fields.MBField_Calendar#checkValue(java.util.Calendar)
	 */
	@Override
	protected boolean checkValue (final Calendar newValue) {
		if (null == newValue) {
			return false;
		}
		final long ageInMillis = System.currentTimeMillis ()
				- newValue.getTimeInMillis ();
		if (ageInMillis < (24 * 60 * 60000)) {
			return false;
		}
		if (ageInMillis > (110 * 365.2489 * 24 * 60 * 60000)) {
			return false;
		}
		return super.checkValue (newValue);
	}
	
	/**
	 * @return the current value as a java.sql.Date object
	 */
	public java.sql.Date getValueJavaSqlDate () {
		return new java.sql.Date (value.getTimeInMillis ());
	}
	
}
