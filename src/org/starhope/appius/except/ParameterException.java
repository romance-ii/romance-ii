/**
 * <p> Copyright © 2010, Timothy W. Heys </p>
 * <p> Copyright © 2010-2012, Bruce-Robert Pocock </p>
 * <p> This program is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU Affero General Public License as
  *       published by the Free Software Foundation, either version 3 of the
   *          License, or (at your option) any later version. </p>
    * <p> This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
            MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                GNU Affero General Public License for more details. </p>
                * <p> You should have received a copy of the GNU Affero General Public License
                    along with this program.  If not, see <http://www.gnu.org/licenses/>. </p>         
 */
package org.starhope.appius.except;

/**
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ParameterException extends Exception {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6973758282644073298L;
	
	/**
	 * WRITEME
	 */
	private final String reason;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param e WRITEME
	 */
	public ParameterException (final Exception e) {
		initCause (e);
		reason = e.getMessage ();
	}
	
	/**
	 * @param message WRITEME
	 */
	public ParameterException (final String message) {
		super (message);
		reason = message;
	}
	
	/**
	 * @see java.lang.Throwable#getMessage()
	 */
	@Override
	public String getMessage () {
		final String superMessage = super.getMessage ();
		return null == superMessage ? reason : superMessage + "\t"
				+ reason;
	}
}
