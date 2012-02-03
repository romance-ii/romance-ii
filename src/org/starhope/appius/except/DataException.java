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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.except;

import org.starhope.util.LibMisc;

/**
 * A DataException is thrown when a parameter that is passed into some
 * Star-Hope routine or other is invalid, out-of-range, or badly-formed.
 * 
 * @author brpocock@star-hope.org
 */
public class DataException extends Exception {

	/**
	 *
	 */
	private static final long serialVersionUID = 3437973344124958820L;

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 5,
	 * 2009) complaint (DataException)
	 */
	private final String complaint;

	/**
	 * @param string The string complaint, which is stored in the
	 *        Exception; while it's not expected to be an
	 *        internationalised or localised string, it should be
	 *        concise and clear enough for programmer usage during
	 *        debugging
	 */
	public DataException (final String string) {
		complaint = string;
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param string WRITEME
	 * @param e WRITEME
	 */
	public DataException (final String string, final Exception e) {
		this (string + "\n\n" + LibMisc.stringify (e));
	}

	/**
	 * @return the string value stored in the Exception
	 */
	public String getComplaint () {
		return complaint;
	}

	/**
	 * @see java.lang.Throwable#toString()
	 */
	@Override
	public String toString () {
		return getComplaint () + "\n\n" + super.toString (); //$NON-NLS-1$
	}

}
