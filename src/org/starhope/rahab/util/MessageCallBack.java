/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Timothy W. Heys
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
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 */
package org.starhope.rahab.util;

/**
 * WRITEME: Document this type. twheys@gmail.com Dec 30, 2009
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys Timothy W. Heys
 */
public interface MessageCallBack {
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 31, 2009
	 * </pre>
	 * 
	 * TO sendCommand WRITEME...
	 * 
	 * @param command WRITEME
	 * @param params WRITEME
	 */
	public void sendCommand (String command, String... params);
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO sendMessage WRITEME...
	 * 
	 * @param message WRITEME
	 */
	public void sendMessage (String message);
	
}
