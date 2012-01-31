/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, brpocock@star-hope.org
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

import org.starhope.util.LibMisc;

/**
 * This is an exception used to indicate that a component (e.g.
 * subsystem, host, device, …) is not ready, offline, unavailable, or
 * otherwise non-functional, and that it's probably not the caller's
 * fault, but they'll have to deal with the consequences, nonetheless.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class NotReadyException extends Exception {
	
	/**
	 * Java Serialisation unique ID
	 */
	private static final long serialVersionUID = -1313612310477058201L;
	
	/**
	 * @param string reason something isn't ready
	 */
	public NotReadyException (final String string) {
		super (string);
	}
	
	/**
	 * @param string what isn't ready
	 * @param e why not
	 */
	public NotReadyException (final String string,
			final DataException e) {
		super (string + "\n\n" + LibMisc.stringify (e));
	}
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param e WRITEME
	 */
	public NotReadyException (final Throwable e) {
		super (e);
	}
	
}
