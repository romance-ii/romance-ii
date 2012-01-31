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

import java.util.Collection;

import org.starhope.appius.except.NotReadyException;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @param <T> the type of record set to be loaded
 */
public interface RecordSetLoader <T extends DataRecordSet <?>> {
	/**
	 * Prepare the RecordSetLoader for accessing a given storage
	 * medium. Usually identifies a URL for the storage mechanism, but
	 * can also pull information from AppiusConfig.
	 * 
	 * @param storageURL A URL or identifier of the storage engine. The
	 *             syntax is specific to the RecordLoader
	 *             implementation.
	 * @throws NotReadyException if the storage engine can't be
	 *              initialized
	 */
	public void initializeStorage (String storageURL)
			throws NotReadyException;
	
	/**
	 * Load the data record identified from the storage system. The
	 * format and interpretation of the identifier is specific to the
	 * data record type, but must be a guaranteed-unique
	 * 
	 * @param identifiers the identifiers for the record set
	 * @param offset the first record to include
	 * @param limit the maximum number of records to include
	 * @return the data record in question
	 */
	public T loadRecordSet (Collection <String> identifiers,
			long offset, long limit);
	
	/**
	 * Load the records with the given ID number from the storage
	 * system
	 * 
	 * @param ids the ID numbers for the records
	 * @param offset the first record to include
	 * @param limit the maximum number of records to include
	 * @return the data record in question
	 */
	public T loadRecordSetByIDs (Collection <Integer> ids,
			long offset, long limit);
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param recordSet the records to be saved
	 */
	
	public void saveRecordSet (T recordSet);
}
