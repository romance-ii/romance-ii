/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.appius.user.events;

import java.math.BigDecimal;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.inventory.RarityRating;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * <h1>Event Outcome Record</h1>
 * <p>
 * Event outcomes are the rules that determine what results come from
 * ending an event.
 * </p>
 * <p>
 * Each event type is associated with a single outcome. That outcome can
 * reward the player for an event, or do nothing.
 * </p>
 * <p>
 * For events such as minigames and in-world games, outcomes will
 * general give the player some kind of reward.
 * </p>
 * <h2>The Reward Scalar</h2>
 * <p>
 * The reward scalar <em>scales</em> the reward. It is used for
 * selection of items, as well as currency rewards.
 * </p>
 * <p>
 * The reward scalar can be chosen randomly from within a given range of
 * values. (A minimum and maximum value can be set.)
 * </p>
 * <p>
 * The reward scalar can also be taken from points earned playing a game
 * or minigame, multiplied by a scaling factor. For example, in a game
 * in which the score could range from 0 to 1000, but a reward item is
 * to be chosen in the range from 0 to 9, the scaling factor would be
 * .001 with limits of 0 and 9. This would ensure that the score of 1000
 * × .001 = 10 would be limited instead to 9.
 * </p>
 * <h2>Rewarding the player with currency</h2>
 * <p>
 * Issuing a reward of currency is the simplest option. For this, the
 * unit of currency (for example, Tootsville™ Peanuts) must be chosen,
 * and the reward scalar is translated directly into currency.
 * </p>
 * <p>
 * For example, for a game with a score ranging from 0 to 1000, for
 * which you wish to reward from 0 to 50 currency units, a scaling
 * factor of .05 would give the correct results. (50 ÷ 1000 = .05; 1000
 * × .05 = 50).
 * </p>
 * <h2>Rewarding the player with items</h2>
 * <p>
 * Players can be rewarded with items based on the outcome of a game or
 * minigame. The reward item can be a specific item, an item from a
 * collection, or any item in the game's entire item database.
 * </p>
 * <p>
 * In the case of an item collection, the reward scalar is first
 * determined. Then, the scalar is taken modulo the size of the
 * collection. The item in the collection, in sequence, with the index
 * of the reward scalar is the chosen item. Note that the index and
 * scalar both begin counting with 0.
 * </p>
 * <p>
 * In other words, for a set of ten items, the items are numbered 0
 * through 9. The scalar is limited to the range of 0 to 9 (thus, 18
 * becomes 8). The first item is item 0; the next is item 1; and so
 * forth.
 * </p>
 * <p>
 * Likewise, for “all items,” the actual item rewarded is taken from the
 * item scalar. This is generally worthless, unless the scalar is
 * random.
 * </p>
 * <p>
 * Furthermore, however, the item rewarded can be restricted based upon
 * its rarity. Both a minimum and maximum rarity rating can be
 * specified. (These ratings are <em>inclusive</em>.) This allows, for
 * example, rewarding a random item from a collection, but not the
 * rarest item in that collection. It can also be combined with random
 * scalars against <em>all</em> items.
 * </p>
 * <p>
 * Note that applying a random scalar within a range does not imply even
 * distribution of random values. There will be an uneven distribution
 * based upon various factors, so the total set of all items rewarded
 * “randomly” will favour certain items mathematically. However, this
 * effect should generally be negligible.
 * </p>
 * <h2>Remedial Third-Grade Math</h2>
 * <p>
 * To figure out the scaling factor to give a scalar in the range from 0
 * to <em>x</em>, with a points-score in the range from 0 to <em>y</em>.
 * simply take <em>x</em>÷<em>y</em>. (That's the maximum scalar desired
 * divided by the maximum possible score.)
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class EventOutcomeRecord extends
		SimpleDataRecord <EventOutcomeRecord> {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -7218044225900766801L;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private MedalType giveMedal;
	
	/**
	 * event outcome ID
	 */
	private int id;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private RarityRating maxRarity;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private BigDecimal maxReward;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private RarityRating minRarity;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private BigDecimal minReward;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private boolean permitDuplicateReward;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private boolean retryDuplicateReward;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private boolean rewardByPoints;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private int rewardCollectionID;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private Currency rewardCurrency;
	
	/**
	 * the type of method of selection of an item reward
	 */
	private RewardInventoryItemType rewardInventoryItemType;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private int rewardItemID;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private BigDecimal rewardMax;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private BigDecimal rewardMin;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private boolean rewardRandom;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private BigDecimal rewardRatio;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public EventOutcomeRecord () {
		super (EventOutcomeRecord.class);
	}
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param loader WRITEME
	 */
	public EventOutcomeRecord (
			final RecordLoader <EventOutcomeRecord> loader) {
		super (loader);
	}
	
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
	 * @return the giveMedal
	 */
	public MedalType getGiveMedal () {
		return giveMedal;
	}
	
	/**
	 * @return the id
	 */
	public int getID () {
		return id;
	}
	
	/**
	 * @return the maxRarity
	 */
	public RarityRating getMaxRarity () {
		return maxRarity;
	}
	
	/**
	 * @return the maxReward
	 */
	public BigDecimal getMaxReward () {
		return maxReward;
	}
	
	/**
	 * @return the minRarity
	 */
	public RarityRating getMinRarity () {
		return minRarity;
	}
	
	/**
	 * @return the minReward
	 */
	public BigDecimal getMinReward () {
		return minReward;
	}
	
	/**
	 * @return the rewardCollectionID
	 */
	public int getRewardCollectionID () {
		return rewardCollectionID;
	}
	
	/**
	 * @return the rewardCurrency
	 */
	public Currency getRewardCurrency () {
		return rewardCurrency;
	}
	
	/**
	 * @return the method by which an item might be awarded
	 */
	public RewardInventoryItemType getRewardInventoryItemType () {
		return rewardInventoryItemType;
	}
	
	/**
	 * @return the rewardItemID
	 */
	public int getRewardItemID () {
		return rewardItemID;
	}
	
	/**
	 * @return maximum reward amount (in currency units)
	 */
	public BigDecimal getRewardMax () {
		return new BigDecimal (rewardMax.toPlainString ());
	}
	
	/**
	 * @return minimum reward amount (in currency units)
	 */
	public BigDecimal getRewardMin () {
		return new BigDecimal (rewardMin.toPlainString ());
	}
	
	/**
	 * @return the rewardRatio
	 */
	public BigDecimal getRewardRatio () {
		return rewardRatio;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}
	
	/**
	 * @return the permitDuplicateReward
	 */
	public boolean isPermitDuplicateReward () {
		return permitDuplicateReward;
	}
	
	/**
	 * @return the retryDuplicateReward
	 */
	public boolean isRetryDuplicateReward () {
		return retryDuplicateReward;
	}
	
	/**
	 * @return the rewardByPoints
	 */
	public boolean isRewardByPoints () {
		return rewardByPoints;
	}
	
	/**
	 * @return true, if reward scalars are decided randomly
	 */
	public boolean isRewardRandom () {
		return rewardRandom;
	}
	
	/**
	 * @param medalToGive the giveMedal to set
	 */
	public void setGiveMedal (final MedalType medalToGive) {
		giveMedal = medalToGive;
		changed ();
	}
	
	/**
	 * @param newID the id to set
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}
	
	/**
	 * @param newMaxRarity the maxRarity to set
	 */
	public void setMaxRarity (final RarityRating newMaxRarity) {
		maxRarity = newMaxRarity;
		changed ();
	}
	
	/**
	 * @param newMaxReward the maxReward to set
	 */
	public void setMaxReward (final BigDecimal newMaxReward) {
		maxReward = newMaxReward;
		changed ();
	}
	
	/**
	 * @param newMinRarity the minRarity to set
	 */
	public void setMinRarity (final RarityRating newMinRarity) {
		minRarity = newMinRarity;
		changed ();
	}
	
	/**
	 * @param newMinReward the minReward to set
	 */
	public void setMinReward (final BigDecimal newMinReward) {
		minReward = newMinReward;
		changed ();
	}
	
	/**
	 * @param whetherToPermitDuplicateRewards the permitDuplicateReward
	 *             to set
	 */
	public void setPermitDuplicateReward (
			final boolean whetherToPermitDuplicateRewards) {
		permitDuplicateReward = whetherToPermitDuplicateRewards;
		changed ();
	}
	
	/**
	 * @param whetherToRetryOnDuplicateRewards the retryDuplicateReward
	 *             to set
	 */
	public void setRetryDuplicateReward (
			final boolean whetherToRetryOnDuplicateRewards) {
		retryDuplicateReward = whetherToRetryOnDuplicateRewards;
		changed ();
	}
	
	/**
	 * @param whetherToRewardByPoints the rewardByPoints to set
	 */
	public void setRewardByPoints (
			final boolean whetherToRewardByPoints) {
		rewardByPoints = whetherToRewardByPoints;
		changed ();
	}
	
	/**
	 * @param newRewardCollectionID the rewardCollectionID to set
	 */
	public void setRewardCollectionID (final int newRewardCollectionID) {
		rewardCollectionID = newRewardCollectionID;
		changed ();
	}
	
	/**
	 * @param currency the rewardCurrency to set
	 */
	public void setRewardCurrency (final Currency currency) {
		rewardCurrency = currency;
		changed ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param newType WRITEME
	 */
	public void setRewardInventoryItemType (
			final RewardInventoryItemType newType) {
		rewardInventoryItemType = newType;
		changed ();
	}
	
	/**
	 * @param newRewardItemID the rewardItemID to set
	 */
	public void setRewardItemID (final int newRewardItemID) {
		rewardItemID = newRewardItemID;
		changed ();
	}
	
	/**
	 * @param bigDecimal the maximum reward scalar
	 */
	public void setRewardMax (final BigDecimal bigDecimal) {
		rewardMax = bigDecimal;
		changed ();
	}
	
	/**
	 * @param bigDecimal the minimum amount for the reward scalar
	 */
	public void setRewardMin (final BigDecimal bigDecimal) {
		rewardMin = bigDecimal;
		changed ();
	}
	
	/**
	 * @param equals whether the reward scalar is determined randomly
	 */
	public void setRewardRandom (final boolean equals) {
		rewardRandom = equals;
		changed ();
	}
	
	/**
	 * @param newRewardRatio the rewardRatio to set
	 */
	public void setRewardRatio (final BigDecimal newRewardRatio) {
		rewardRatio = newRewardRatio;
		changed ();
	}
	
}
