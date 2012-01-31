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
package org.starhope.appius.except;

import java.util.Date;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class AlreadyUsedException extends Exception {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 1464192624700398564L;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 5,
	 * 2009) reason (AlreadyUsedException)
	 */
	private final String reason;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 5,
	 * 2009) when (AlreadyUsedException)
	 */
	private final Date when;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param i some number
	 */
	public AlreadyUsedException (final int i) {
		reason = String.valueOf (i);
		when = new Date (System.currentTimeMillis ());
	}
	
	/**
	 * @param reason1 WRITEME
	 * @param date WRITEME
	 */
	public AlreadyUsedException (final String reason1, final Date date) {
		reason = reason1;
		if (null == date) {
			when = new Date (0);
		} else {
			when = new Date (date.getTime ());
		}
	}
	
	/**
	 * @return the reason
	 */
	public String getReason () {
		return reason;
	}
	
	/**
	 * @return the when
	 */
	public Date getWhen () {
		return new Date (when.getTime ());
	}
	
	/**
	 * @see java.lang.Throwable#toString()
	 */
	@Override
	public String toString () {
		return getReason () + " (used " + getWhen () + ")";
	}
}
