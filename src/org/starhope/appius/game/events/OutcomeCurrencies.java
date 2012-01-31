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
import org.starhope.appius.mb.Currency;
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
public class OutcomeCurrencies extends SimpleDataRecord <OutcomeCurrencies> implements HasSubversionRevision {

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
	final private class OutcomeCurrencyInfo {

		/**
		 * The reward ratio used to determine how much of this currency to reward
		 */
		public BigDecimal rewardRatio;

		/**
		 * The weight used to determine if this is the winning currency for a random reward
		 */
		public int weight;

		/**
		 * The maximum amount of currency this outcome is allowed to award for this currency
		 */
		public int maxCount;

		/**
		 * The minimum amount to hand out if a random amount is to be used
		 */
		public int randMin;

		/**
		 * The maximum amount to hand out if a random amount is to be used
		 */
		public int randMax;

		/**
		 * WRITEME: Document this constructor ewinkelman@resinteractive.com
		 */
		public OutcomeCurrencyInfo () {
			// Nothing
		}
	}

	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (OutcomeCurrencies.class);

	/**
	 * Set of random currencies and their weights
	 */
	private final HashMap <Currency, Integer> randomCurrencies = new HashMap <Currency, Integer> ();

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int totalRandomWeights = 0;

	/**
	 * Set of fixed currencies
	 */
	private final HashSet <Currency> fixedCurrencies = new HashSet <Currency> ();

	/**
	 * Map of extra information about the currencies
	 */
	private final HashMap <Currency, OutcomeCurrencyInfo> info = new HashMap <Currency, OutcomeCurrencyInfo> ();

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = 3959929995807443594L;

	/**
	 * ID of the outcome that this set of currencies rewards is for
	 */
	private int outcomeID;

	/**
	 * The outcome this set of currency rewards is attached to
	 */
	private WeakReference <EventOutcome> outcome = new WeakReference <EventOutcome> (null);

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public OutcomeCurrencies () {
		super (OutcomeCurrencies.class);
		markForReload ();
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param loader WRITEME
	 */
	public OutcomeCurrencies (final RecordLoader <OutcomeCurrencies> loader) {
		super (loader);
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 */
	public void clearItems () {
		info.clear ();
		randomCurrencies.clear ();
		fixedCurrencies.clear ();
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
		if ( ! (obj instanceof OutcomeCurrencies)) {
			return false;
		}
		OutcomeCurrencies other = (OutcomeCurrencies) obj;
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
	 * Gets the max count assigned to this currency
	 *
	 * @param currency WRITEME 
	 * @return WRITEME 
	 */
	public int getMaxCount (final Currency currency) {
		return info.containsKey (currency) ? info.get (currency).maxCount : 0;
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
				OutcomeCurrencies.log.error ("Exception", e);
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
	 * Gets the reward ration assigned to this currency
	 *
	 * @param currency WRITEME 
	 * @return WRITEME 
	 */
	public BigDecimal getRatio (final Currency currency) {
		return info.containsKey (currency) ? info.get (currency).rewardRatio : BigDecimal.ZERO;
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param points WRITEME 
	 * @return WRITEME 
	 */
	public HashMap <Currency, Long> getRewardCurrencies (final long points) {
		final HashMap <Currency, Long> results = new HashMap <Currency, Long> ();

		// Initialize with fixed currencies
		List <Currency> outcomeItems = new LinkedList <Currency> (fixedCurrencies);

		// Hand out random currencies
		if (randomCurrencies.size () > 0) {
			int targetNum = AppiusConfig.getRandomInt (0, totalRandomWeights - 1);
			for (Entry <Currency, Integer> entry : randomCurrencies.entrySet ()) {
				targetNum -= entry.getValue ().intValue ();
				if (targetNum <= 0) {
					outcomeItems.add (entry.getKey ());
					break;
				}
			}
		}

		for (Currency currency : outcomeItems) {
			final OutcomeCurrencyInfo fo = info.get (currency);
			final BigDecimal rewardRatio = fo.rewardRatio;
			// Negative values in the reward ratio indicate a fixed amount to be awarded
			// Positive values in the reward ratio are multiplied by the points to determine
			// How many to reward
			int total = 0;
			if (rewardRatio.compareTo (BigDecimal.ZERO) != 0) {
				total =
						rewardRatio.compareTo (BigDecimal.ZERO) <= 0 ? Math.abs (rewardRatio.intValue ()) : rewardRatio
								.multiply (new BigDecimal (points)).intValue ();
			} else {
				total = AppiusConfig.getRandomInt (fo.randMin, fo.randMax);
			}
			total = fo.maxCount > 0 ? Math.min (fo.maxCount, total) : total;
			results.put (currency, new Long (total));
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
	 * Gets the weight assigned to this currency
	 *
	 * @param currency WRITEME 
	 * @return WRITEME 
	 */
	public int getWeight (final Currency currency) {
		return info.containsKey (currency) ? info.get (currency).weight : 0;
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
	 * Sets the extra info for one of the reward currencies
	 *
	 * @param currency WRITEME 
	 * @param rewardRatio WRITEME 
	 * @param weight WRITEME 
	 * @param maxCount WRITEME 
	 * @param randMin WRITEME 
	 * @param randMax WRITEME 
	 */
	public void setCurrency (final Currency currency, final BigDecimal rewardRatio, final int weight,
			final int maxCount, final int randMin, final int randMax) {
		OutcomeCurrencyInfo outcomeCurrencyInfo = new OutcomeCurrencyInfo ();
		outcomeCurrencyInfo.maxCount = maxCount;
		outcomeCurrencyInfo.rewardRatio = rewardRatio;
		outcomeCurrencyInfo.weight = weight;
		outcomeCurrencyInfo.randMin = randMin;
		outcomeCurrencyInfo.randMax = randMax;
		info.put (currency, outcomeCurrencyInfo);
		if (weight < 1) {
			fixedCurrencies.add (currency);
		} else {
			randomCurrencies.put (currency, new Integer (weight));
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
