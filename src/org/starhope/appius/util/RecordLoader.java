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
package org.starhope.appius.util;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.util.HasSubversionRevision;

/**
 * This interface defines a mechanism for loading and saving data
 * records from an arbitrary storage engine, most likely an SQL database
 * of some kind. The backing store could potentially be something like a
 * file or RPC server as well.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @param <T> The data record type
 */
public interface RecordLoader <T extends DataRecord> extends
		HasSubversionRevision {
	/**
	 * accept a notification from a record that it has been changed.
	 * 
	 * @param changedRecord the record that has been changed
	 */
	public void changed (T changedRecord);
	
	/**
	 * Prepare the RecordLoader for accessing a given storage medium.
	 * Usually identifies a URL for the storage mechanism, but can also
	 * pull information from AppiusConfig.
	 * 
	 * @param storageURL A URL or identifier of the storage engine. The
	 *             syntax is specific to the RecordLoader
	 *             implementation.
	 * @throws NotReadyException if the storage engine can't be
	 *              initialised
	 */
	public void initializeStorage (String storageURL)
			throws NotReadyException;
	
	/**
	 * @return true, if this is a type that requires realtime
	 *         performance on changes. Note that I/O bound storage such
	 *         as SQL database saves and file writes will generally
	 *         return false, whereas RPC mirroring will probably want
	 *         to return true, unless latency is not an issue.
	 */
	public boolean isRealtime ();
	
	/**
	 * Load the record with the given ID number from the storage system
	 * 
	 * @param id the ID number for the record
	 * @return the data record in question
	 * @throws NotFoundException if the record can't be loaded
	 */
	public T loadRecord (int id) throws NotFoundException;
	
	/**
	 * Load the data record identified from the storage system. The
	 * format and interpretation of the identifier is specific to the
	 * data record type, but must be a guaranteed-unique
	 * 
	 * @param identifier the identifier for the record
	 * @return the data record in question
	 * @throws NotFoundException if the record can't be loaded
	 */
	public T loadRecord (String identifier) throws NotFoundException;
	
	/**
	 * Refreshes the record: Re-read the contents of the database into
	 * the given record. This is a rather cruel hack to work around
	 * some of the legacy tools in Tootsville™ that aren't hooked into
	 * the game server properly, and might be fiddling around with the
	 * SQL backing-store directly. This works together with e.g.
	 * {@link SimpleDataRecord#checkStale()} to try to reload data when
	 * it might have been changed: it's trading elegance and efficiency
	 * for expediency, but eventually, it should be removed.
	 * 
	 * @param record the record to be reloaded.
	 */
	public void refresh (T record);
	
	/**
	 * @param record Record to be deleted/removed
	 */
	public void removeRecord (T record);
	
	/**
	 * Save a record back to the storage system
	 * 
	 * @param record the record to be saved
	 */
	public void saveRecord (T record);
}
