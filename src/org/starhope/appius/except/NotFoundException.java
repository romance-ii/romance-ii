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


/**
 * An exception returned in the case that some kind of asset cannot be
 * found in the underlying data store, usually database table.
 * 
 * @author brpocock@star-hope.org
 */
public class NotFoundException extends Exception {
	/**
	 * WRITEME
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 5,
	 * 2009) msg (NotFoundException)
	 */
	private final String msg;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param e WRITEME
	 */
	public NotFoundException (final Exception e) {
		initCause (e);
		msg= e.getMessage ();
	}

	/**
	 * @param msg1 WRITEME
	 */
	public NotFoundException (final String msg1) {
		msg = msg1;
	}

	/**
	 * @see java.lang.Throwable#getMessage()
	 */
	@Override
	public String getMessage () {
		return msg;
	}


	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Throwable#toString()
	 */
	@Override
	public String toString () {
		return super.toString () + " (" + msg + ")";
	}
}
