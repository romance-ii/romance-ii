/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Res Interactive, LLC.
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

import java.io.Serializable;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.BugReporter;

/**
 * An abstract implementation of a DataRecord performing the default
 * tasks for most of the drudgery.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @param <T> The specific subclass type is required to declare itself
 *             to bypass some very strange Java generic class issues
 */
public abstract class SimpleDataRecord <T extends SimpleDataRecord <?>>
		implements DataRecord, Comparable <T>, Serializable {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 3167537168141802669L;
	
	/**
	 * Whether this object has been cached
	 */
	private boolean beenCached = false;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private boolean beingLoaded = true;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected transient RecordLoader <T> myLoader;
	
	/**
	 * WRITEME
	 */
	protected long timeLastChanged = -1;
	
	/**
	 * WRITEME
	 */
	protected long timeLastSaved = -1;
	
	/**
	 * Protected constructor for derived classes to use, creating a new
	 * record using the default loader configured for that class
	 * 
	 * @param klass the derived class
	 */
	protected SimpleDataRecord (
			final Class <? extends SimpleDataRecord <T>> klass) {
		super ();
		setRecordLoader (AppiusConfig.getRecordLoaderForClass (klass));
		markAsLoaded ();
	}
	
	/**
	 * @param loader the record loader in use
	 */
	public SimpleDataRecord (final RecordLoader <? super T> loader) {
		setRecordLoader (loader);
		beingLoaded = true;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	@SuppressWarnings ("unchecked")
	protected void changed () {
		timeLastChanged = System.currentTimeMillis () - 1;
		DataRecordFlushManager.update (myLoader, (T) this);
	}
	
	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#checkStale()
	 */
	@SuppressWarnings ("unchecked")
	@Override
	public void checkStale () {
		final boolean stale = (timeLastChanged < timeLastSaved)
				&& ( (timeLastChanged
						+ AppiusConfig.getRandomInt (0, 6000) + AppiusConfig
							.getIntOrDefault (getClass ()
									.getCanonicalName ()
									+ ".stale", 900000)) < System
						.currentTimeMillis ());
		if (stale) {
			myLoader.refresh ((T) this);
		}
	}
	
	/**
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final T o) {
		int hisID;
		try {
			hisID = o.getCacheableID ();
		} catch (final NotFoundException e) {
			return -1;
		}
		int myID;
		try {
			myID = getCacheableID ();
		} catch (final NotFoundException e) {
			return 1;
		}
		if ( (hisID == -1) && (myID == 1)) {
			try {
				return getCacheableIdent ().compareTo (
						o.getCacheableIdent ());
			} catch (final NotFoundException e) {
				// Just eat it
			}
		}
		return hisID < myID ? 1 : hisID > myID ? -1 : 0;
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public abstract boolean equals (final Object obj);
	
	/**
	 * @see java.lang.Object#finalize()
	 */
	@SuppressWarnings ("unchecked")
	@Override
	protected synchronized void finalize () {
		if (AppiusConfig.alwaysRealtime ()) {
			return;
		}
		if ( !beingLoaded && !beenCached
				&& (timeLastChanged > timeLastSaved)) {
			myLoader.saveRecord ((T) this);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getRecordLoader()
	 */
	@Override
	public RecordLoader <? super T> getRecordLoader () {
		return myLoader;
	}
	
	/**
	 * @see org.starhope.appius.util.CTime#getTimeLastChanged()
	 */
	@Override
	public final long getTimeLastChanged () {
		return timeLastChanged;
	}
	
	/**
	 * @see org.starhope.appius.util.CTime#getTimeLastSaved()
	 */
	@Override
	public final long getTimeLastSaved () {
		return timeLastSaved;
	}
	
	@Override
	public abstract int hashCode ();
	
	/**
	 * @see org.starhope.appius.util.DataRecord#isBeingLoaded()
	 */
	@Override
	public boolean isBeingLoaded () {
		return beingLoaded;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#markAsLoaded()
	 */
	@Override
	public void markAsLoaded () {
		beingLoaded = false;
		final long now = System.currentTimeMillis ();
		timeLastSaved = now;
		timeLastChanged = now - 1;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#markAsSaved()
	 */
	@Override
	public final void markAsSaved () {
		timeLastSaved = System.currentTimeMillis ();
		if (null == myLoader) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"I've been saved? Really? I don't know by whom, but I'll bet they're calling me right now.");
		}
	}
	
	/**
	 * Marks a record as
	 */
	public void markForReload () {
		beingLoaded = true;
	}
	
	/**
	 * @see com.whirlycott.cache.Cacheable#onRemove(java.lang.Object)
	 */
	@SuppressWarnings ("unchecked")
	@Override
	public synchronized void onRemove (final Object value) {
		if (timeLastChanged > timeLastSaved) {
			myLoader.saveRecord ((T) this);
		}
		beenCached = false;
	}
	
	/**
	 * @see com.whirlycott.cache.Cacheable#onRetrieve(java.lang.Object)
	 */
	@Override
	public void onRetrieve (final Object value) {
		beenCached = true;
	}
	
	/**
	 * @see com.whirlycott.cache.Cacheable#onStore(java.lang.Object)
	 */
	@Override
	public synchronized void onStore (final Object value) {
		beenCached = true;
	}
	
	/**
	 * Saves the record immediately instead of waiting
	 */
	public void save () {
		DataRecordFlushManager.flush (this);
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#setRecordLoader(org.starhope.appius.util.RecordLoader)
	 */
	@SuppressWarnings ("unchecked")
	@Override
	public final void setRecordLoader (
			final RecordLoader <? extends DataRecord> loader) {
		myLoader = (RecordLoader <T>) loader;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder s = new StringBuilder ();
		s.append (this.getClass ().getSimpleName ());
		if (beingLoaded) {
			s.append (" (loading)");
		}
		if (beenCached) {
			s.append (" (cached)");
		}
		if (timeLastSaved < timeLastChanged) {
			s.append (" (dirty)");
		}
		return s.toString ();
	}
}
