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

/**
 * This exception is thrown in registration and similar code to denote
 * that an user is forbidden from registering, probably because they
 * were previously banned. Note that the User Interface is NOT to tell
 * the user this fact.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class ForbiddenUserException extends Exception {
	
	/**
	  * 
	  */
	private static final long serialVersionUID = 4022968581619547737L;
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 5,
	 * 2009) message (ForbiddenUserException)
	 */
	private final String message;
	
	/**
	 * @param message1 The descriptive message to be returned to the
	 *             user
	 */
	public ForbiddenUserException (final String message1) {
		message = message1;
	}
	
	/**
	 * @return the message
	 */
	@Override
	public String getMessage () {
		// default getter (brpocock@star-hope.org, Nov 5, 2009)
		return message;
	}
	
}
