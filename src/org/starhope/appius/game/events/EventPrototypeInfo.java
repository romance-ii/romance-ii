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

import java.util.HashMap;
import java.util.Map;

import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.mb.Currency;
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
public class EventPrototypeInfo implements HasSubversionRevision {

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final private HashMap <RealItem, Integer> earnedItems = new HashMap <RealItem, Integer> ();

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final private HashMap <Currency, Long> earnedCurrency = new HashMap <Currency, Long> ();

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final private HashMap <Currency, Long> requiredCurrency = new HashMap <Currency, Long> ();

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final private HashMap <RealItem, Integer> requiredItems = new HashMap <RealItem, Integer> ();

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Boolean paidOnly;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private long points;

	/**
	 * Adds a set amount of a given currency to be earned with this event
	 *
	 * @param currency WRITEME 
	 * @param amount WRITEME 
	 */
	public void earn(final Currency currency, final long amount) {
		final long previousAmount =
				earnedCurrency.containsKey (currency) ? earnedCurrency.get (currency).longValue () : 0L;
		earnedCurrency.put (currency, new Long (amount + previousAmount));
	}

	/**
	 * Adds a requirement for this many items to already be owned for this event to happen
	 *
	 * @param item WRITEME 
	 * @param count WRITEME 
	 */
	public void earn (final RealItem item, final int count) {
		final int previousQuantity = earnedItems.containsKey (item) ? earnedItems.get (item).intValue () : 0;
		earnedItems.put (item, new Integer (count + previousQuantity));
	}

	/**
	 * Gets the currencies earned by this prototype
	 *
	 * @return WRITEME 
	 */
	public Map <Currency, Long> getEarnedCurrencies(){
		return new HashMap <Currency, Long> (earnedCurrency);
	}

	/**
	 * Gets the items earned by this prototype
	 *
	 * @return WRITEME 
	 */
	public Map <RealItem, Integer> getEarnedItems () {
		return new HashMap <RealItem, Integer> (earnedItems);
	}

	/**
	 * @return the paidOnly
	 */
	public Boolean getPaidOnly () {
		return paidOnly;
	}

	/**
	 * @return the points
	 */
	public long getPoints () {
		return points;
	}

	/**
	 * Gets the currencies required by this prototype
	 *
	 * @return WRITEME 
	 */
	public Map <Currency, Long> getRequiredCurrencies(){
		return new HashMap <Currency, Long> (requiredCurrency);
	}

	/**
	 * Gets the items required by this prototype
	 *
	 * @return WRITEME 
	 */
	public Map <RealItem, Integer> getRequiredItems () {
		return new HashMap <RealItem, Integer> (requiredItems);
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}

	/**
	 * Adds a requirement for this much currency to allow this event to happen
	 *
	 * @param currency WRITEME 
	 * @param amount WRITEME 
	 */
	public void require (final Currency currency, final long amount) {
		final long previousAmount =
				requiredCurrency.containsKey (currency) ? requiredCurrency.get (currency).longValue () : 0L;
		requiredCurrency.put (currency, new Long (amount + previousAmount));
	}

	/**
	 * Adds a requirement for this many items to already be owned for this event to happen
	 *
	 * @param item WRITEME 
	 * @param count WRITEME 
	 */
	public void require (final RealItem item, final int count) {
		final int previousQuantity = requiredItems.containsKey (item) ? requiredItems.get (item).intValue () : 0;
		requiredItems.put (item, new Integer (count + previousQuantity));
	}
	
	/**
	 * @param paidOnly the paidOnly to set
	 */
	public void setPaidOnly (final Boolean paidOnly) {
		this.paidOnly = paidOnly;
	}
	
	/**
	 * @param points the points to set
	 */
	public void setPoints (final long points) {
		this.points = points;
	}

}
