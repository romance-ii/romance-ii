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
package org.starhope.appius.game.rooms;

import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.actions.ActionEventAreaEnter;
import org.starhope.appius.game.actions.ActionEventAreaExit;
import org.starhope.appius.game.events.EventPrototypeInfo;
import org.starhope.appius.game.events.EventType;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.WeakRecord;

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
class EventPlace extends ZonePlace {
	
	/**
	 * Internal currency info class
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
	private class CurrencyInfo{
		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		WeakRecord <Currency> currency;
		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		long currencyAmount;
		/**
		 * WRITEME: Document this constructor ewinkelman@resinteractive.com
		 *
		 */
		Boolean paid = null;
		
		/**
		 * WRITEME: Document this constructor ewinkelman@resinteractive.com
		 */
		public CurrencyInfo () {}
	}
	
	/**
	 * Internal item info class
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
	private class ItemInfo {
		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		WeakRecord <RealItem> item;
		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		int count;
		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		final HashMap <WeakRecord <Currency>, Long> purchasePrice = new HashMap <WeakRecord <Currency>, Long> ();
		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		Boolean paid = null;
		
		/**
		 * WRITEME: Document this constructor ewinkelman@resinteractive.com
		 */
		public ItemInfo () {}
	}
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (EventPlace.class);
	
	/**
	 * List of users currently in this event space
	 */
	private final Set <AbstractUser> eventUsers = Collections.synchronizedSet (new HashSet <AbstractUser> ());
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final List <ItemInfo> itemList = new LinkedList <EventPlace.ItemInfo> ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final List <CurrencyInfo> currencyList = new LinkedList <EventPlace.CurrencyInfo> ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private WeakRecord <EventType> eventType;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final Boolean paidOnly = null;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 *
	 * @param name WRITEME 
	 * @param jsonObject WRITEME 
	 * @param room WRITEME 
	 * @throws JSONException
	 */
	EventPlace (final String name, final JSONObject jsonObject, final Room room) throws JSONException {
		super (name, jsonObject,room);
		
		// Process any items that this event is supposed to give or purchase
		if (getRoomVar ().has ("items")) {
			final JSONArray items = getRoomVar ().getJSONArray ("items");
			for (int i = 0; i < items.length (); i++ ) {
				// item info
				final JSONObject itemObject = items.getJSONObject (i);
				if ( !itemObject.has ("realID")) {
					continue;
				}
				final int realID = itemObject.getInt ("realID");
				final ItemInfo info = new ItemInfo ();
				info.item = new WeakRecord <RealItem> (RealItem.class, realID);
				info.count = itemObject.has ("count") ? itemObject.getInt ("count") : 1;
				if (itemObject.has ("paid")) {
					info.paid = new Boolean (itemObject.getBoolean ("paid"));
				}
				
				// purchase costs
				if (itemObject.has ("price")) {
					final JSONArray priceStuff = itemObject.getJSONArray ("price");
					for (int j = 0; j < priceStuff.length (); j++ ) {
						final JSONObject priceObject = priceStuff.getJSONObject (j);
						final String curr = priceObject.getString ("curr");
						final long cost = priceObject.getLong ("amount");
						info.purchasePrice.put (new WeakRecord <Currency> (Currency.class, curr), new Long (cost));
					}
				} else {
					long cost = 0L;
					try {
						final RealItem realItem = Nomenclator.getDataRecord (RealItem.class, realID);
						cost = realItem.getItemReference ().getPrice () * info.count;
						info.purchasePrice.put (new WeakRecord <Currency> (Currency.class, "x-TvPn"), new Long (cost));
					} catch (NotFoundException e) {
						EventPlace.log.error ("Exception",e);
					}
				}
				
				// Put in list
				itemList.add (info);
			}
		}
		
		// Process any currencies that this event is supposed to give/take
		if (getRoomVar ().has ("currency")) {
			final JSONObject currency = getRoomVar ().getJSONObject ("currency");
			for (Iterator <?> iterator = currency.keys (); iterator.hasNext ();) {
				final String key = (String) iterator.next ();
				final JSONObject currObject = currency.getJSONObject (key);
				final CurrencyInfo info = new CurrencyInfo ();
				info.currency = new WeakRecord <Currency> (Currency.class, key);
				info.currencyAmount = currObject.has ("amount") ? currObject.getLong ("amount") : 0L;
				if (currObject.has ("paid")) {
					info.paid = new Boolean (currObject.getBoolean ("paid"));
				}
				currencyList.add (info);
			}
		}
		
		// Check for an event type
		if (getRoomVar ().has ("eventType")) {
			eventType = new WeakRecord <EventType> (EventType.class, getRoomVar ().getString ("eventType"));
		}
		
	}
	
	/**
	 * Considers a list of users against the parameters of this event place
	 * If the user is not in the list of current users and the user is inside of the event place, then
	 * the user is added to the list of current users and all appropriate events are triggered
	 * If the user is in the list of current users then nothing is triggered
	 * If there is a user in the list of current users who is NOT in the list of users to be considered,
	 * then they are removed from the list of current users and all appropriate events are triggered
	 *
	 * @param users WRITEME 
	 */
	public void consider (final Set <AbstractUser> users) {
		Set <AbstractUser> currentUsers = null;
		synchronized (eventUsers) {
			currentUsers = new HashSet <AbstractUser> (eventUsers);
		}
		// Check first for users leaving the area
		for (AbstractUser user : currentUsers) {
			final Coord3D p = user.getLocation ();
			if ( !currentUsers.contains (user) || !inArea (p.getX (), p.getY ())) {
				eventUsers.remove (user);
				room.eventAreaExitHandlers.fire (new ActionEventAreaExit (room, user, getName ()));
			}
		}
		// Now look for users entering the area
		for (AbstractUser user : users) {
			final Coord3D p = user.getLocation ();
			if ( !currentUsers.contains (user) && inArea (p.getX (), p.getY ())) {
				if (eventType != null) {
					EventPrototypeInfo prototype = new EventPrototypeInfo ();
					prototype.setPaidOnly (paidOnly);
					for (ItemInfo itemInfo : itemList) {
						if (itemInfo.paid == null || itemInfo.paid.booleanValue () ^ !user.isPaidMember ()) {
							prototype.earn (itemInfo.item.get (), itemInfo.count);
							for (Entry <WeakRecord <Currency>, Long> itemPrice : itemInfo.purchasePrice.entrySet ()) {
								prototype.require (itemPrice.getKey ().get (), itemPrice.getValue ().longValue ());
								prototype.earn (itemPrice.getKey ().get (), -itemPrice.getValue ().longValue ());
							}
						}
					}
					for (CurrencyInfo currencyInfo : currencyList) {
						if (currencyInfo.paid == null || currencyInfo.paid.booleanValue () ^ !user.isPaidMember ()) {
							prototype.earn (currencyInfo.currency.get (), currencyInfo.currencyAmount);
						}
					}
					try {
						eventType.get ().doEvent (prototype, user);
					} catch (Exception e) {
						// Probably bad form, but this can throw a lot of exceptions and they all mean that this event
						// didn't work for this user, so we need to continue on to the next
						continue;
					}
					eventUsers.add (user);
					room.eventAreaEnterHandlers.fire (new ActionEventAreaEnter (room, user, getName ()));
				}
			}
		}
	}
	
	/**
	 * @return the eventType
	 */
	public EventType getEventType () {
		return eventType != null ? eventType.get () : null;
	}
	
	/**
	 * Returns true, false or null for if this event is meant to trigger for paid, unpaid or both
	 *
	 * @return the paidOnly
	 */
	public Boolean getPaidOnly () {
		return paidOnly;
	}
	
}
