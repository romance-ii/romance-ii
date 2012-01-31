/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public
 * License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
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
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map.Entry;



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.inventory.GenericItemReference;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
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
 */
public class OutcomeItems extends SimpleDataRecord <OutcomeItems> implements HasSubversionRevision {

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
	 */
	final private class OutcomeItemInfo {

		/**
		 * The reward ratio used to determine how many of this item to reward
		 */
		public BigDecimal rewardRatio;

		/**
		 * The weight used to determine if this is the winning item for a random reward
		 */
		public int weight;

		/**
		 * The total number of these items the user is allowed to get
		 */
		public int maxCount;

		/**
		 * WRITEME: Document this constructor ewinkelman@resinteractive.com
		 *
		 * @param rewardRatio WRITEME 
		 * @param weight WRITEME 
		 */
		public OutcomeItemInfo () {
			// Nothing
		}
	}

	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (OutcomeItems.class);

	/**
	 * Set of random items and their weights
	 */
	private final HashMap <Integer, Integer> randomItems = new HashMap <Integer, Integer> ();

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int totalRandomWeights = 0;

	/**
	 * Set of fixed items
	 */
	private final HashSet <Integer> fixedItems = new HashSet <Integer> ();

	/**
	 * Map of extra information about the items
	 */
	private final HashMap <Integer, OutcomeItemInfo> info = new HashMap <Integer, OutcomeItems.OutcomeItemInfo> ();

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = 3959929995807443593L;

	/**
	 * ID of the outcome that this set of item rewards is for
	 */
	private int outcomeID;

	/**
	 * The outcome this set of item rewards is attached to
	 */
	private WeakReference <EventOutcome> outcome = new WeakReference <EventOutcome> (null);

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public OutcomeItems () {
		super (OutcomeItems.class);
		markForReload ();
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param loader WRITEME
	 */
	public OutcomeItems (final RecordLoader <OutcomeItems> loader) {
		super (loader);
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 */
	public void clearItems () {
		info.clear ();
		randomItems.clear ();
		fixedItems.clear ();
		totalRandomWeights = 0;
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
		if ( ! (obj instanceof OutcomeItems)) {
			return false;
		}
		OutcomeItems other = (OutcomeItems) obj;
		if (outcomeID != other.outcomeID) {
			return false;
		}
		return true;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return outcomeID;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return Integer.toString (outcomeID);
	}

	/**
	 * Gets the max count assigned to this item
	 *
	 * @param item WRITEME 
	 * @return WRITEME 
	 */
	public int getMaxCount (final GenericItemReference item) {
		return info.containsKey (item) ? info.get (item).maxCount : 0;
	}

	/**
	 * @return the outcome
	 */
	public EventOutcome getOutcome () {
		EventOutcome result = outcome.get ();
		if (result == null) {
			try {
				outcome = new WeakReference <EventOutcome> (Nomenclator.getDataRecord (EventOutcome.class, outcomeID));
			} catch (NotFoundException e) {
				OutcomeItems.log.error ("Exception",e);
			}
			result = outcome.get ();
		}
		return result;
	}

	/**
	 * @return the outcomeID
	 */
	public int getOutcomeID () {
		return outcomeID;
	}

	/**
	 * Gets the reward ration assigned to this item
	 *
	 * @param item WRITEME 
	 * @return WRITEME 
	 */
	public BigDecimal getRatio (final GenericItemReference item) {
		return info.containsKey (item) ? info.get (item).rewardRatio : BigDecimal.ZERO;
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param points WRITEME 
	 * @return WRITEME 
	 */
	public HashMap <RealItem, Integer> getRewardItems (final long points) {
		final HashMap <RealItem, Integer> results = new HashMap <RealItem, Integer> ();

		// Initialize with fixed items
		List <Integer> outcomeItems = new LinkedList <Integer> (fixedItems);

		// Hand out random items
		if (randomItems.size () > 0) {
			int targetNum = AppiusConfig.getRandomInt (0, totalRandomWeights - 1);
			for (Entry <Integer, Integer> entry : randomItems.entrySet ()) {
				targetNum -= entry.getValue ().intValue ();
				if (targetNum <= 0) {
					outcomeItems.add (entry.getKey ());
					break;
				}
			}
		}

		for (Integer item : outcomeItems) {
			final OutcomeItemInfo fo = info.get (item);
			final BigDecimal rewardRatio = fo.rewardRatio;
			// Negative values in the reward ratio indicate a fixed amount to be awarded
			// Positive values in the reward ratio are multiplied by the points to determine
			// How many to reward
			int totalItems =
					rewardRatio.compareTo (BigDecimal.ZERO) <= 0 ? Math.abs (rewardRatio.intValue ()) : rewardRatio
							.multiply (new BigDecimal (points)).intValue ();
			totalItems = fo.maxCount > 0 ? Math.min (fo.maxCount, totalItems) : totalItems;
			try {
				results.put (Nomenclator.getDataRecord (RealItem.class, item.intValue ()), new Integer (
						totalItems));
			} catch (NotFoundException e) {
				OutcomeItems.log.error ("Exception",e);
			}
		}

		return results;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}

	/**
	 * Gets the weight assigned to this item
	 *
	 * @param item WRITEME 
	 * @return WRITEME 
	 */
	public int getWeight (final GenericItemReference item) {
		return info.containsKey (item) ? info.get (item).weight : 0;
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = prime * result + outcomeID;
		return result;
	}

	/**
	 * Sets the extra info for one of the reward items
	 *
	 * @param item WRITEME 
	 * @param rewardRatio WRITEME 
	 * @param weight WRITEME 
	 * @param maxCount WRITEME 
	 */
	public void setItem (final Integer item, final BigDecimal rewardRatio, final int weight,
			final int maxCount) {
		OutcomeItemInfo outcomeItemInfo = new OutcomeItemInfo ();
		outcomeItemInfo.maxCount = maxCount;
		outcomeItemInfo.rewardRatio = rewardRatio;
		outcomeItemInfo.weight = weight;
		info.put (item, outcomeItemInfo);
		if (weight < 1) {
			fixedItems.add (item);
		} else {
			randomItems.put (item, new Integer (weight));
			totalRandomWeights += weight;
		}
	}

	/**
	 * @param outcomeID the outcomeID to set
	 */
	public void setOutcomeID (final int outcomeID) {
		this.outcomeID = outcomeID;
	}

}
