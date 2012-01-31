/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General
 * Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any
 * later version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game.events;

import java.lang.ref.WeakReference;
import java.sql.Timestamp;
import java.util.Map;
import java.util.Map.Entry;



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.net.datagram.ADPEarning;
import org.starhope.appius.net.datagram.ADPEventResult;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.User;
import org.starhope.appius.user.Wallet;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.catullus.Copyable;

/**
 * <p>
 * Events are any thing that happens in the world that can influence a player's currency or inventory.
 * </p>
 * <p>
 * XXX:contains SQL
 * </p>
 *
 * <pre>
 * ALTER TABLE eventTypes CHANGE COLUMN outcome outcome INT NOT NULL DEFAULT 3;
 * ALTER TABLE eventTypes ADD CONSTRAINT FOREIGN KEY (outcome) REFERENCES eventOutcomes (ID);
 * ALTER TABLE eventTypes CHANGE COLUMN filename filename VARCHAR(64) NOT NULL DEFAULT '';
 * ALTER TABLE eventTypes CHANGE COLUMN description description TEXT NOT NULL;
 * </pre>
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class EventRecord extends SimpleDataRecord <EventRecord> implements Copyable <EventRecord> {

	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (EventRecord.class);

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = 7812621767536153282L;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private long creationTimestamp = -1;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private int creatorID = -1;

	/**
	 * Weak references to the earned currencies
	 */
	private WeakReference <EventCurrency> earnedCurrencies = new WeakReference <EventCurrency> (null);

	/**
	 * Weak reference to the earned items object that holds the list of items this event rewards
	 */
	private WeakReference <EventItems> earnedItems = new WeakReference <EventItems> (null);

	/**
	 * Weak reference to the event type that spawned this event
	 */
	private WeakReference <EventType> eventType = new WeakReference <EventType> (null);

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private int eventTypeID = -1;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private int id = -1;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private long points = 0L;

	/**
	 * Whether to send high scores when printing this event
	 *
	 * @deprecated unused, refer to {@link EventType#hasHighScores()}
	 */
	@Deprecated
	private final boolean sendHighScore = true;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public EventRecord () {
		super (EventRecord.class);
		markForReload ();
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param loader WRITEME
	 */
	public EventRecord (final RecordLoader <EventRecord> loader) {
		super (loader);
	}

	/**
	 * Adds an set of items to the current reward items
	 *
	 * @param map WRITEME 
	 * @throws NotFoundException
	 */
	private void addCurrenciesEarned (final Map <Currency, Long> map) {
		for (Entry <Currency, Long> item : map.entrySet ()) {
			addCurrencyEarned (item.getKey (), item.getValue ().intValue ());
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param currency WRITEME 
	 * @param amount WRITEME 
	 * @throws NotFoundException
	 */
	public void addCurrencyEarned (final Currency currency, final long amount) {
		EventCurrency eventCurrency = getEventCurrencies ();
		if (eventCurrency != null) {
			eventCurrency.addCurrency (currency, amount);
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param item WRITEME 
	 * @param count WRITEME 
	 * @param itemID WRITEME
	 * @throws NotFoundException
	 */
	public void addItemEarned (final RealItem item, final int count) {
		EventItems items = getEventItems ();
		if (null != items) {
			items.addItem (item, count);
		}
	}

	/**
	 * Adds an set of items to the current reward items
	 *
	 * @param map WRITEME 
	 * @throws NotFoundException
	 */
	private void addItemsEarned (final Map <RealItem, Integer> map) {
		for (Entry <RealItem, Integer> item : map.entrySet ()) {
			addItemEarned (item.getKey (), item.getValue ().intValue ());
		}
	}

	/**
	 * @see org.starhope.catullus.Copyable#copyProtoype(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public EventRecord copyProtoype (final EventRecord prototype) {
		creationTimestamp = prototype.creationTimestamp;
		creatorID = prototype.creatorID;
		addItemsEarned (prototype.getItemsEarned ());
		addCurrenciesEarned (prototype.getCurrenciesEarned ());
		eventTypeID = prototype.eventTypeID;
		id = prototype.id;
		points = prototype.points;
		return this;
	}

	/**
	 * perform actions specified by the outcome for this event type
	 *
	 * @throws NotFoundException
	 */
	private void doOutcome () {
		final EventOutcome outcome = getEventType ().getOutcome ();
		final AbstractUser creator = getCreator ();

		// Populate with rewards
		addItemsEarned (outcome.getRewardItems (points));
		addCurrenciesEarned (outcome.getRewardCurrencies (points));
		changed ();
		// Actually reward the currencies
		if (getCurrenciesEarned ().size () > 0) {
			for (Entry <Currency, Long> earnedCurrency : getCurrenciesEarned ().entrySet ()) {
				creator.getWallet ().add (earnedCurrency.getKey (), earnedCurrency.getValue ().longValue ());
			}
			creator.acceptDatagram (creator.getWallet ().toDatagram (creator));
		}
		// Actually reward the items
		if (getItemsEarned ().size () > 0) {
			for (Entry <RealItem, Integer> earnedItem : getItemsEarned ().entrySet ()) {
				creator.getInventory ().addItem (earnedItem.getKey ().getItemID (), earnedItem.getValue ().intValue ());
			}
		}
		// Send results
		EventScore score = new EventScore (id, points, getCreator ().getAvatarLabel ());
		getEventType ().considerForHighscore (score);
		final ADPEventResult result = getResultDatagram ();
		getCreator ().acceptDatagram (result);
		if (getCreator ().getRoom () != null) {
			final ADPEarning earning = getEarningDatagram (false);
			earning.setUser (getCreator ());
			getCreator ().getRoom ().getRoomChannel ().broadcast (earning, getCreator ());
		}
	}

	/**
	 * /**
	 * End an event (such as a game or minigame) with a singular score
	 *
	 * @param score score earned by this player
	 * @throws NotFoundException
	 */
	void end (final long score) {
		setPoints (score);
		doOutcome ();
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
		if ( ! (obj instanceof EventRecord)) {
			return false;
		}
		EventRecord other = (EventRecord) obj;
		if (id != other.id) {
			return false;
		}
		return true;
	}

// /**
	// * purchase something.
	// *
	// * @param itemPurchased what was purchased
	// * @throws NonSufficientFundsException couldn't afford it
	// * @throws NotFoundException
	// */
	// public void end (final GenericItemReference itemPurchased) throws NonSufficientFundsException, NotFoundException
	// {
	// final long price = itemPurchased.getPrice ();
	// end (itemPurchased, price);
	// }
	//
	// /**
	// * End a purchase-type event, but they might not have actually
	// * purchased something, the price is specified
	// *
	// * @param itemPurchased the item purchased (or given)
	// * @param price the price to pay (which can be 0)
	// * @throws NonSufficientFundsException if they can't afford it
	// * @throws NotFoundException
	// */
	// public void end (final GenericItemReference itemPurchased, final long price) throws NonSufficientFundsException,
	// NotFoundException {
	// final AbstractUser buyer = getCreator ();
	//
	// final Currency currency = itemPurchased.getCurrency ();
	//
	// if (price != 0 && price > buyer.getWallet ().get (currency)) { throw new NonSufficientFundsException (price,
	// buyer.getWallet ().get (currency)); }
	//
	// if (price != 0) {
	// addCurrencyEarned (currency, -price);
	// }
	//
	// addItemEarned (itemPurchased, 1);
	//
	// doOutcome ();
	// }
	//
	// /**
	// * End a “gift” event whereby an user has given an item to another
	// * user
	// *
	// * @param item the item being given as a gift
	// * @param u the user giving the item as a gift
	// * @throws GameLogicException if the transaction cannot be completed
	// * @throws NotFoundException
	// */
	// public void end (final InventoryItem item, final AbstractUser u) throws GameLogicException, NotFoundException {
	// if ( ! (item.getOwnerID () == u.getUserID ())) { throw new GameLogicException ("not owner", item, u); }
	// if ( !item.getGenericItem ().canTrade ()) { throw new GameLogicException ("can't trade", item, u); }
	// item.setOwnerID (creatorID);
	// Nomenclator.getUserByID (creatorID).getInventory ().add (item);
	// u.getInventory ().remove (item);
	// addItemEarned (item.getGenericItem (), 1);
	// doOutcome ();
	// }

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return id;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () {
		return String.valueOf (id);
	}

	/**
	 * @return the creationTimestamp
	 */
	public long getCreationTimestamp () {
		return creationTimestamp;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	private AbstractUser getCreator () {
		return Nomenclator.getUserByID (creatorID);
	}

	/**
	 * @return the creatorID
	 */
	public int getCreatorID () {
		return creatorID;
	}

	/**
	 * @return the itemEarned
	 */
	public Map <Currency, Long> getCurrenciesEarned () {
		return getEventCurrencies ().getCurrencies ();
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param includeTotals WRITEME 
	 * @return WRITEME 
	 */
	public ADPEarning getEarningDatagram (final boolean includeTotals) {
		ADPEarning result = null;
		if (getCreator () instanceof User) {
			final User user = (User) getCreator ();
			result = new ADPEarning (user);
			if (getCurrenciesEarned ().size () > 0 && creationTimestamp > 0) {
				for (Entry <Currency, Long> item : getCurrenciesEarned ().entrySet ()) {
					result.setCurrencyEarned (item.getKey (), item.getValue ().longValue ());
				}
			}
			if (getItemsEarned ().size () > 0 && creationTimestamp > 0) {
				for (Entry <RealItem, Integer> item : getItemsEarned ().entrySet ()) {
					result.setItem (item.getKey (), item.getValue ().intValue ());
				}
			}
		}

		return result;
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @return WRITEME 
	 */
	private EventCurrency getEventCurrencies () {
		EventCurrency result = earnedCurrencies.get ();
		if (result == null) {
			if (id >= 0) {
				try {
					earnedCurrencies =
							new WeakReference <EventCurrency> (Nomenclator.getDataRecord (EventCurrency.class, id));
				} catch (NotFoundException e) {
					EventRecord.log.error ("Exception", e);
				}
			} else {
				earnedCurrencies = new WeakReference <EventCurrency> (new EventCurrency ());
			}
			result = earnedCurrencies.get ();
		}
		return result;
	}

	/**
	 * Gets the related event items class, if there is one
	 *
	 * @return WRITEME 
	 */
	private EventItems getEventItems () {
		EventItems result = earnedItems.get ();
		if (result == null) {
			if (id >= 0) {
				try {
					earnedItems = new WeakReference <EventItems> (Nomenclator.getDataRecord (EventItems.class, id));
				} catch (NotFoundException e) {
					EventRecord.log.error ("Exception", e);
				}
			} else {
				earnedItems = new WeakReference <EventItems> (new EventItems ());
			}
			result = earnedItems.get ();
		}
		return result;
	}

	/**
	 * @return the type of event of which this record describes once
	 *         incidence
	 */
	public EventType getEventType () {
		EventType result = eventType.get ();
		if (result == null) {
			try {
				eventType = new WeakReference <EventType> (Nomenclator.getDataRecord (EventType.class, eventTypeID));
			} catch (NotFoundException e) {
				EventRecord.log.error ("Exception", e);
			}
			result = eventType.get ();
		}
		return result;
	}

	/**
	 * @return the eventTypeID
	 */
	public int getEventTypeID () {
		return eventTypeID;
	}

	/**
	 * @return the id
	 */
	public int getID () {
		return id;
	}

	/**
	 * @return the itemEarned
	 */
	public Map <RealItem, Integer> getItemsEarned () {
		return getEventItems ().getItems ();
	}

	/**
	 * @return the points
	 */
	public long getPoints () {
		return points;
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @return WRITEME 
	 */
	public ADPEventResult getResultDatagram () {
		ADPEventResult result = null;

		if (getCreator () instanceof User) {
			final User user = (User) getCreator ();
			result = new ADPEventResult (user);
			result.setType (getEventType ());
			if (creatorID > 0) {
				result.setCreator (user.getAvatarLabel ());
			}
			if (getCurrenciesEarned ().size () > 0 && creationTimestamp > 0) {
				final Wallet wallet = user.getWallet ();
				for (Entry <Currency, Long> item : getCurrenciesEarned ().entrySet ()) {
					result.setCurrencyEarned (item.getKey (), item.getValue ().longValue ());
					result.setCurrencyTotal (item.getKey (), wallet.get (item.getKey ()));
				}
			}
			final EventType type = getEventType ();
			if (type.hasHighScores () && creationTimestamp > 0) {
				result.setHighScores (type.getHighScoresDatagram (user));
				final int rank = type.getHighScoreRank (id);
				if (rank > 0) {
					result.setHighScoreRank (rank);
				}
			}
			if (getItemsEarned ().size () > 0 && creationTimestamp > 0) {
				for (Entry <RealItem, Integer> item : getItemsEarned ().entrySet ()) {
					result.setItemEarned (item.getKey (), item.getValue ().intValue ());
				}
			}
		}
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
		result = prime * result + id;
		return result;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param newTimestamp WRITEME
	 */
	public void setCreationTimestamp (final long newTimestamp) {
		creationTimestamp = newTimestamp;
		changed ();
	}

	/**
	 * @param timestamp the new creation timestamp
	 */
	public void setCreationTimestamp (final Timestamp timestamp) {
		if (null == timestamp) {
			creationTimestamp = -1;
		} else {
			creationTimestamp = timestamp.getTime ();
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param user the creator of the event
	 */
	public void setCreator (final AbstractUser user) {
		creatorID = user.getUserID ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param newCreatorID WRITEME
	 */
	public void setCreatorID (final int newCreatorID) {
		creatorID = newCreatorID;
		changed ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param newEventTypeID WRITEME
	 */
	public void setEventTypeID (final int newEventTypeID) {
		eventTypeID = newEventTypeID;
		changed ();
	}

	/**
	 * set the event's unique ID (normally done only once at creation)
	 *
	 * @param newID the new ID
	 */
	public void setID (final int newID) {
		id = newID;
		getEventItems ().setEventID (newID);
		getEventCurrencies ().setEventID (newID);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param score WRITEME
	 */
	public void setPoints (final long score) {
		points = score;
		changed ();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return "Event " + id + " of type " + eventTypeID;
	}

}
