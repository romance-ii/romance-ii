/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Res Interactive, LLC
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

import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Set;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.BugReporter;

/**
 * This is a static singleton class which performs a number of useful
 * functions for suppressing excessive I/O writes to the backing store
 * for rapidly- changing data records
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class DataRecordFlushManager {
	
	/**
	 * WRITEME
	 */
	private static DataRecordFlushThread flushThread = null;
	
	/**
	 * records pending a flush to backing store
	 */
	public static final Set <DataRecord> pendingRecords = Collections
			.synchronizedSet (new HashSet <DataRecord> ());
	
	/**
	 * Flush a few records, then return how many remain
	 * 
	 * @param count the number of records to flush
	 * @return how many remain
	 */
	public static int flush (final int count) {
		final LinkedList <DataRecord> flushList;
		synchronized (DataRecordFlushManager.pendingRecords) {
			flushList = new LinkedList <DataRecord> (
					DataRecordFlushManager.pendingRecords);
		}
		while ( !flushList.isEmpty ()) {
			final DataRecord r = flushList.pop ();
			DataRecordFlushManager.flush (r);
			if (DataRecordFlushManager.pendingRecords.contains (r)) {
				BugReporter.getReporter ("srv").reportBug (
						"Flushed record " + r.toString ()
								+ " still pending?");
			}
		}
		final int remainingPending = DataRecordFlushManager.pendingRecords
				.size ();
		if (remainingPending > 0) {
			final DataRecord first = DataRecordFlushManager.pendingRecords
					.iterator ().next ();
			int cacheableID = -1;
			try {
				cacheableID = first.getCacheableID ();
			} catch (final NotFoundException e) {
				// no op
			}
			String cacheableIdent = "(Ø)";
			try {
				cacheableIdent = first.getCacheableIdent ();
			} catch (final NotFoundException e) {
				// no op
			}
			// BugReporter.getReporter
			// ("srv").reportBug(remainingPending
			// + " records not flushed; first is "
			// + first.getClass ().getCanonicalName () + "/"
			// + cacheableIdent + "=#" + cacheableID);
		}
		return remainingPending;
	}
	
	/**
	 * Flush a record to the database
	 * 
	 * @param <T> the record type
	 * @param r the record to be flushed
	 */
	@SuppressWarnings ("unchecked")
	static <T extends DataRecord> void flush (final T r) {
		final RecordLoader <T> l = (RecordLoader <T>) r
				.getRecordLoader ();
		if (null != l) {
			l.saveRecord (r);
			if (r.getTimeLastSaved () < (System.currentTimeMillis () - 2)) {
				BugReporter.getReporter ("srv").reportBug (
						"Record did not update save time? "
								+ r.toString ());
			}
		}
		if (DataRecordFlushManager.pendingRecords.contains (r)) {
			DataRecordFlushManager.pendingRecords.remove (r);
		}
	}
	
	/**
	 * Flush all records for shutdown
	 */
	public static void flushAll () {
		final LinkedList <DataRecord> flushList;
		synchronized (DataRecordFlushManager.pendingRecords) {
			flushList = new LinkedList <DataRecord> (
					DataRecordFlushManager.pendingRecords);
		}
		while ( !flushList.isEmpty ()) {
			final DataRecord r = flushList.pop ();
			DataRecordFlushManager.flush (r);
			if (DataRecordFlushManager.pendingRecords.contains (r)) {
				BugReporter.getReporter ("srv").reportBug (
						"Flushed record " + r.toString ()
								+ " still pending?");
			}
		}
	}
	
	/**
	 * If the Background Flush thread is not already running, make sure
	 * that it will run
	 * 
	 * @param <T> WRITEME
	 * @param record WRITEME
	 */
	private synchronized static <T extends DataRecord> void flushLater (
			final T record) {
		DataRecordFlushManager.pendingRecords.add (record);
		if (null == DataRecordFlushManager.flushThread) {
			DataRecordFlushManager.flushThread = new DataRecordFlushThread ();
			DataRecordFlushManager.flushThread.start ();
		} else {
			DataRecordFlushManager.flushThread.ping ();
		}
	}
	
	/**
	 * Decide whether to update the saved copy of a changed record
	 * based upon its current change time and modification time, and
	 * whether there are remote listeners who are interested in
	 * receiving notifications of changes
	 * 
	 * @param <T> the type of data record at question
	 * @param recordLoader the loader responsible for the data record
	 * @param record the data record which has changed
	 */
	public static <T extends DataRecord> void update (
			final RecordLoader <T> recordLoader, final T record) {
		if (null == record) {
			return;
		}
		
		if (record.isBeingLoaded ()) {
			return;
		}
		
		if (null == recordLoader) {
			BugReporter.getReporter ("srv").reportBug (
					"Record has no loader " + record.toString (),
					new RuntimeException ());
			return;
		}
		
		final long timeLastSaved = record.getTimeLastSaved ();
		if (timeLastSaved > record.getTimeLastChanged ()) {
			return;
		}
		
		if (recordLoader.isRealtime ()
				|| AppiusConfig.alwaysRealtime ()) {
			recordLoader.saveRecord (record);
			return;
		}
		
		final long flushFencepost = System.currentTimeMillis ()
				- AppiusConfig
						.getIntOrDefault (
								"org.starhope.appius.util.dataRecordFlushInterval",
								3000);
		if (timeLastSaved > flushFencepost) {
			DataRecordFlushManager.flushLater (record);
			return;
		}
		
		recordLoader.saveRecord (record);
	}
	
}
