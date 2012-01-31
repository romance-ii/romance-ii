/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
package org.starhope.catullus;

import org.starhope.appius.except.CredentialExpiredException;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.except.ParameterException;
import org.starhope.appius.except.SerialDataException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecord;
import org.starhope.appius.util.RecordLoader;

/**
 * This is an interface class for the bridge to a remote object of a
 * given type. The data record on the remote server must implement the
 * matching Porta interface. (that's not true, WRITEME, this works
 * through some new {@link AppiusConfig} hacking on the
 * {@link DataRecord}/{@link RecordLoader} model)
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @param <T> the remote data record type to be loaded
 */
public class Via <T extends DataRecord> implements RecordLoader <T> {
	
	/**
	 * the class for which this is acting as a RecordLoader
	 */
	private final Class <T> klass;
	/**
	 * the vehicle for communications
	 */
	private Vehicle vehicle;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param myClass WRITEME
	 */
	@SuppressWarnings ("unchecked")
	public Via (final Class <T> myClass) {
		klass = myClass;
		try {
			final Class <Vehicle> vehicleClass = (Class <Vehicle>) Class
					.forName (AppiusConfig
							.getConfig ("org.starhope.catullus.Via.vehicle"));
			vehicle = vehicleClass.newInstance ();
		} catch (final ClassNotFoundException e) {
			throw new ClassCastException (e.getMessage ());
		} catch (final IllegalAccessException e) {
			throw new ClassCastException (e.getMessage ());
		} catch (final Exception e) {
			vehicle = new JavaRMIVehicle ();
		}
		try {
			vehicle.setURL (AppiusConfig
					.getConfig ("org.starhope.catullus.serviceName"));
		} catch (final NotFoundException e) {
			throw new RuntimeException (
					"Caught a NotFoundException in Via.Via ", e);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final T changedRecord) {
		saveRecord (changedRecord);
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Revision: 2293 $";
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public Vehicle getVehicle () {
		return vehicle;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#initializeStorage(java.lang.String)
	 */
	@Override
	public void initializeStorage (final String storageURL)
			throws NotReadyException {
		try {
			vehicle.connect ();
		} catch (final SerialDataException e) {
			throw new NotReadyException (e);
		} catch (final NotFoundException e) {
			throw new NotReadyException (e);
		} catch (final CredentialExpiredException e) {
			throw new NotReadyException (e);
		} catch (final ForbiddenUserException e) {
			throw new NotReadyException (e);
		} catch (final ParameterException e) {
			throw new NotReadyException (e);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#isRealtime()
	 */
	@Override
	public boolean isRealtime () {
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
	 */
	@Override
	public T loadRecord (final int id) throws NotFoundException {
		try {
			return vehicle.read (this, klass, id);
		} catch (final NotReadyException e) {
			throw new RuntimeException (
					"Caught a NotReadyException in Via.loadRecord ",
					e);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public T loadRecord (final String identifier)
			throws NotFoundException {
		try {
			return vehicle.read (this, klass, identifier);
		} catch (final NotReadyException e) {
			throw new RuntimeException (
					"Caught a NotReadyException in Via.changed ",
					e);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final T record) {
		// TODO Auto-generated method stub
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final T record) {
		try {
			vehicle.remove (record);
		} catch (final NotReadyException e) {
			throw new RuntimeException (
					"Caught a NotReadyException in Via.removeRecord ",
					e);
		} catch (final NotFoundException e) {
			throw new RuntimeException (
					"Caught a NotFoundException in Via.removeRecord ",
					e);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final T record) {
		int id = Integer.MIN_VALUE;
		try {
			id = record.getCacheableID ();
			if ( (0 == id) || ( -1 == id)) {
				final T newRecord = vehicle.writeSync (record);
				final int newID = newRecord.getCacheableID ();
				if (newID != id) {
					try {
						GaiusValeriusCatullus.setAll (record,
								newRecord);
					} catch (final DataException e) {
						throw new NotReadyException (
								"Can't update record, ID changed from "
										+ id + " to " + newID,
								e);
					}
				} else {
					throw new NotReadyException (
							"Record ID not changed from " + id
									+ " for "
									+ record.toString ());
				}
				return;
			}
			// fall through
		} catch (final NotFoundException e) {
			// no op; fall through.
		} catch (final NotReadyException e) {
			throw new RuntimeException (
					"Caught a NotReadyException in Via.changed (id == "
							+ id + ")", e);
		}
		try {
			vehicle.write (record);
		} catch (final NotReadyException e) {
			BugReporter.getReporter ("srv").reportBug (
					"Caught a NotReadyException in Via.changed ",
					e);
		}
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return "Via <"
				+ klass.getCanonicalName ()
				+ "> over "
				+ (null == vehicle ? "(null)" : vehicle.toString ());
	}
	
}
