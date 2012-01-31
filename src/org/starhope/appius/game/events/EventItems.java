/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at
 * your option) any later version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.game.events;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.util.HasSubversionRevision;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 *
 */
public class EventItems extends SimpleDataRecord <EventItems> implements HasSubversionRevision {

	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (EventItems.class);

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = -6679589523033270181L;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int eventID;

	/**
	 * Weak reference to the event these event items belong to
	 */
	private WeakReference <EventRecord> event = new WeakReference <EventRecord> (null);

	/**
	 * A map of the item and count of that item
	 */
	final private HashMap <RealItem, Integer> items = new HashMap <RealItem, Integer> ();

	/**
	 * Default constructor
	 */
	public EventItems () {
		super (EventItems.class);
	}

	/**
	 * Constructor taking a loader as a parameter
	 *
	 * @param loader WRITEME
	 */
	public EventItems (final RecordLoader <EventItems> loader) {
		super (loader);
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param itemID WRITEME 
	 * @param count WRITEME 
	 */
	public void addItem (final RealItem item, final int count) {
		int currAmount = containsItem (item) ? items.get (item).intValue () : 0;
		items.put (item, new Integer (count + currAmount));
		changed ();
	}

	/**
	 * Finds out if the item is in the event items
	 *
	 * @param itemID ID of the generic item reference we're looking for
	 * @return WRITEME 
	 */
	public boolean containsItem (final RealItem item) {
		return items.containsKey (item);
	}

	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof EventItems)) {
			return false;
		}
		EventItems other = (EventItems) obj;
		if (eventID != other.eventID) {
			return false;
		}
		return true;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return eventID;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return Integer.toString (eventID);
	}

	/**
	 * @return the event
	 */
	public EventRecord getEvent () {
		EventRecord result = event.get ();
		if (result == null) {
			try {
				event = new WeakReference <EventRecord> (Nomenclator.getDataRecord (EventRecord.class, eventID));
			} catch (NotFoundException e) {
				EventItems.log.error ("Exception", e);
			}
			result = event.get ();
		}
		return result;
	}

	/**
	 * @return the eventID
	 */
	public int getEventID () {
		return eventID;
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @return WRITEME 
	 */
	public Map <RealItem, Integer> getItems () {
		final HashMap <RealItem, Integer> result = new HashMap <RealItem, Integer> (items);
		return result;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = prime * result + eventID;
		return result;
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param item WRITEME 
	 * @param count WRITEME 
	 */
	public void putItem (final RealItem item, final int count) {
		items.put (item, new Integer (count));
		changed ();
	}

	/**
	 * @param eventID the eventID to set
	 */
	public void setEventID (final int eventID) {
		this.eventID = eventID;
		event = new WeakReference <EventRecord> (null);
		changed ();
	}

}
