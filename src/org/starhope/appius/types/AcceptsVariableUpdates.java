/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.types;

/**
 * Interface for classes that understand accepting variable updates from
 * the database
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public interface AcceptsVariableUpdates {
	
	/**
	 * Sends an update to the object for the variable and it's relative
	 * value
	 * 
	 * @param variable WRITEME  ewinkelman 
	 * @param value WRITEME  ewinkelman 
	 */
	public void acceptVariableUpdate (String variable, String value);
}
