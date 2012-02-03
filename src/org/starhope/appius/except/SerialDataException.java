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
 * 
 * An exception thrown if there is a problem with serialized data
 * 
 * @author brpocock@star-hope.org
 * 
 */
public class SerialDataException extends RuntimeException {

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 6, 2009)
	 * 
	 * serialVersionUID (long)
	 */
	private static final long serialVersionUID = 5151664588572493321L;
	/**
	 * The reason that the serial data is naughty
	 * 
	 * reasonCode (SerialDataException)
	 */
	private String reasonCode;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param e WRITEME
	 */
	public SerialDataException (final Exception e) {
		initCause (e);
		reasonCode = e.getMessage ();
	}

	/**
	 * @param string Message
	 */
	public SerialDataException (final String string) {
		setReasonCode (string);
	}

	/**
	 * @return the reasonCode
	 */
	public String getReasonCode () {
		// default getter (brpocock@star-hope.org, Nov 6, 2009)
		return reasonCode;
	}

	/**
	 * @param newReasonCode the reasonCode to set
	 */
	public void setReasonCode (final String newReasonCode) {
		// default setter (brpocock@star-hope.org, Nov 6, 2009)
		reasonCode = newReasonCode;
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Throwable#toString()
	 */
	@Override
	public String toString () {
		return getReasonCode () + '\n' + super.toString ();
	}

}
