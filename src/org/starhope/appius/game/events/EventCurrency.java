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
import org.starhope.appius.mb.Currency;
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
public class EventCurrency extends SimpleDataRecord <EventCurrency> implements HasSubversionRevision {
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (EventCurrency.class);

	/**
	 * Event ID of the event
	 */
	private int eventID = -1;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private WeakReference <EventRecord> event = new WeakReference <EventRecord> (null);

	/**
	 * A map of the item and count of that item
	 */
	final private HashMap <Currency, Long> currencies = new HashMap <Currency, Long> ();

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = 7501957881373678790L;

	/**
	 * Default constructor
	 */
	public EventCurrency () {
		super (EventCurrency.class);
	}

	/**
	 * Constructor taking a loader as a parameter
	 *
	 * @param loader WRITEME
	 */
	public EventCurrency (final RecordLoader <EventCurrency> loader) {
		super (loader);
	}
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * @param currency WRITEME 
	 * @param amount WRITEME 
	 */
	public void addCurrency (final Currency currency, final long amount) {
		long currAmount = containsCurrency (currency) ? currencies.get (currency).longValue () : 0;
		currencies.put (currency, new Long (amount + currAmount));
		changed ();
	}

	/**
	 * Finds out if the item is in the event currency
	 *
	 * @param currency The currency
	 * @return WRITEME 
	 */
	public boolean containsCurrency (final Currency currency) {
		return currencies.containsKey (currency);
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
		if ( ! (obj instanceof EventCurrency)) {
			return false;
		}
		EventCurrency other = (EventCurrency) obj;
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
		return getEventID ();
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return Integer.toString (getEventID ());
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @return WRITEME 
	 */
	public Map <Currency, Long> getCurrencies () {
		final HashMap <Currency, Long> result = new HashMap <Currency, Long> (currencies);
		return result;
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @return WRITEME 
	 */
	public EventRecord getEvent () {
		EventRecord result = event.get ();
		if(result==null) {
			try {
				event = new WeakReference <EventRecord> (Nomenclator.getDataRecord (EventRecord.class, eventID));
			} catch (NotFoundException e) {
				EventCurrency.log.error ("Exception", e);
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
	 * @param currency WRITEME 
	 * @param amount WRITEME 
	 */
	public void putCurrency (final Currency currency, final long amount) {
		currencies.put (currency, new Long (amount));
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
