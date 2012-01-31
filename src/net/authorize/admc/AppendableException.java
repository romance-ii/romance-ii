/**
 * <p>
 * Copyright © 2005-2008 Axis Data Management Corp.
 * </p>
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
 * </p>
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License"); you
 * may not use this file except in compliance with the License. You may
 * obtain a copy of the License at
 * </p>
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * </p>
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 * </p>
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author (Axis Data Management Corp.)
 */
package net.authorize.admc;

import java.util.ArrayList;
import java.util.List;

/**
 * Allows additional messages to be appended. It often makes for better
 * (and more efficient) design to add context details to an exception at
 * intermediate points in the thread. This class makes it easy and
 * efficient to catch and re-throw for that purpose. It does this in a
 * much more straight-forward way than wrapping Throwables when all you
 * really want to do is add more text.
 */
public class AppendableException extends Exception {
	/**
	 * local line separator
	 */
	public final static String LS = System
			.getProperty ("line.separator");
	
	/**
	 *
	 */
	private static final long serialVersionUID = 1118698211607092030L;
	/**
	 *
	 */
	public List <String> appendages = null;
	
	/**
	 *
	 */
	public AppendableException () {
		// no op
	}
	
	/**
	 * @param s WRITEME
	 */
	public AppendableException (final String s) {
		super (s);
	}
	
	/**
	 * @param string message
	 * @param cause exception to bubble up
	 */
	public AppendableException (final String string,
			final Throwable cause) {
		super (string, cause);
	}
	
	/**
	 * @param cause an exception we want to bubble up
	 */
	public AppendableException (final Throwable cause) {
		super (cause);
	}
	
	/**
	 * @param s message to append
	 */
	public void appendMessage (final String s) {
		if (appendages == null) {
			appendages = new ArrayList <String> ();
		}
		appendages.add (s);
	}
	
	/**
	 * @see java.lang.Throwable#getMessage()
	 */
	@Override
	public String getMessage () {
		final String message = super.getMessage ();
		
		if (appendages == null) {
			return message;
		}
		
		final StringBuffer sb = new StringBuffer ();
		if (message != null) {
			sb.append (message);
		}
		for (int i = 0; i < appendages.size (); i++ ) {
			if (sb.length () > 0) {
				sb.append (AppendableException.LS);
			}
			sb.append (appendages.get (i));
		}
		return sb.toString ();
	}
}
