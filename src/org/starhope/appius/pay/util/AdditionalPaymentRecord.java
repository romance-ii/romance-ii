/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
 * </p>
 * <p>
 * Based upon public domain sample code provided by Authorize.net
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

package org.starhope.appius.pay.util;

import javax.servlet.http.Cookie;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public interface AdditionalPaymentRecord extends
		org.starhope.appius.util.CastsToJSON {
	
	/**
	 * @param authType WRITEME
	 */
	void addAuthType (String authType);
	
	/**
	 * @param cookies WRITEME
	 */
	void addCookies (Cookie [] cookies);
	
	/**
	 * @param localAddr WRITEME
	 */
	void addLocalAddress (String localAddr);
	
	/**
	 * @param localName WRITEME
	 */
	void addLocalHost (String localName);
	
	/**
	 * @param localPort WRITEME
	 */
	void addLocalPort (int localPort);
	
	/**
	 * @param pathInfo WRITEME
	 */
	void addPathInfo (String pathInfo);
	
	/**
	 * @param header WRITEME
	 */
	void addReferer (String header);
	
	/**
	 * @param remoteAddr WRITEME
	 */
	void addRemoteAddress (String remoteAddr);
	
	/**
	 * @param remoteHost WRITEME
	 */
	void addRemoteHost (String remoteHost);
	
	/**
	 * @param remotePort WRITEME
	 */
	void addRemotePort (int remotePort);
	
	/**
	 * @param remoteUser WRITEME
	 */
	void addRemoteUser (String remoteUser);
	
	/**
	 * @param scheme WRITEME
	 */
	void addScheme (String scheme);
	
	/**
	 * @param serverName WRITEME
	 */
	void addServerName (String serverName);
	
	/**
	 * @param serverPort WRITEME
	 */
	void addServerPort (int serverPort);
	
}
