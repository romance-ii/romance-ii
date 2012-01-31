/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.appius.user;

import org.starhope.appius.util.DataRecord;

/**
 * This is a marker interface used to bypass the type system. While the
 * interface does not have the ability to explicitly enforce this
 * limitation, it's mandatory to provide a 1-argument constructor which
 * takes <T>.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @param <T> the type of data record backing objects of this class
 */
public interface DataRecordBacked <T extends DataRecord> {
	// marker interface
	
	/**
	 * Force the backing record for this object to be the given one.
	 * This is used to ensure that the backing record can't fall out of
	 * sync due to caché users.
	 * 
	 * @param rec the backing record
	 */
	void setBackingRecord (T rec);
}
