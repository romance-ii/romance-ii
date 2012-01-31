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

package net.authorize.admc.authnet;

/**
 * authnet-specific exception.
 */
public class AuthNetException extends
		net.authorize.admc.AppendableException {
	// static final long serialVersionUID = -;
	
	// public AuthNetException() {}
	// Purposefully require some diagnostic details by not implementing
	// this information-less constructor.
	
	/**
	 * WRITEME
	 */
	private static final long serialVersionUID = -1511655475719179950L;
	
	/**
	 * WRITEME
	 * 
	 * @param s WRITEME
	 */
	public AuthNetException (final String s) {
		super (s);
	}
	
	/**
	 * WRITEME
	 * 
	 * @param string WRITEME
	 * @param cause WRITEME
	 */
	public AuthNetException (final String string, final Throwable cause) {
		super (string, cause);
	}
	
	/**
	 * @param cause WRITEME
	 */
	public AuthNetException (final Throwable cause) {
		super (cause);
	}
}
