/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Timothy Heys
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
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */

package org.starhope.appius.util;

import org.starhope.appius.except.NotFoundException;
import org.starhope.util.HasSubversionRevision;

import com.whirlycott.cache.Cacheable;

/**
 * A data record of some kind that is instantiated from a backing
 * storage medium (e.g. file, database record, or even an RPC)
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public interface DataRecord extends CTime, HasSubversionRevision,
		Cacheable {
	/**
	 * Indicates that a data record is stale and needs to be refreshed
	 */
	public void checkStale ();
	
	/**
	 * Note that all records must have either a numeric ID (
	 * {@link #getCacheableID()} or a string identifier (
	 * {@link #getCacheableIdent()} or both.
	 * 
	 * @return an unique ID number
	 * @throws NotFoundException if the item doesn't have a distinct
	 *              numeric ID
	 */
	public int getCacheableID () throws NotFoundException;
	
	/**
	 * Note that all records must have either a numeric ID (
	 * {@link #getCacheableID()} or a string identifier (
	 * {@link #getCacheableIdent()} or both.
	 * 
	 * @return an unique identifier string
	 * @throws NotFoundException if the item doesn't have a distinct
	 *              string identifier
	 */
	public String getCacheableIdent () throws NotFoundException;
	
	/**
	 * @return The record loader used to instantiate (and save) this
	 *         data record
	 */
	public RecordLoader <? extends DataRecord> getRecordLoader ();
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public boolean isBeingLoaded ();
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public void markAsLoaded ();
	
	/**
	 * Record the current time as the time last saved
	 */
	void markAsSaved ();
	
	/**
	 * @param loader The record loader that should be used to save this
	 *             data record
	 */
	public void setRecordLoader (
			RecordLoader <? extends DataRecord> loader);
}
