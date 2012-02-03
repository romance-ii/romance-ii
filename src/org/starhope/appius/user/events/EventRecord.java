/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.user.events;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NonSufficientFundsException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.inventory.GenericItemReference;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.game.inventory.collections.ItemCollection;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.net.datagram.ADPCurrencyEarned;
import org.starhope.appius.net.datagram.ADPEndEvent;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.catullus.Copyable;
import org.starhope.util.LibMisc;

/**
 * <p>
 * Events are any thing that happens in the world that can influence a
 * player's currency or inventory.
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
 * @author brpocock@star-hope.org
 */
public class EventRecord extends SimpleDataRecord <EventRecord>
		implements Copyable <EventRecord> {

	/**
	 * WRITEME: Document this ewinkelman
	 */
	private static final long serialVersionUID = 7812621767536153282L;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private long completionTimestamp = -1;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private long creationTimestamp = -1;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private int creatorID = -1;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private BigDecimal currencyAmountEarned = BigDecimal.ZERO;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private Currency currencyEarned = Currency.getPeanuts ();

	/**
	 * WRITEME
	 */
	private int earnedItemID = -1;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private int eventTypeID = -1;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private int id = -1;
	/**
	 * WRITEME
	 */
	private final Collection <MedalType> medals = new HashSet <MedalType> ();

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private BigInteger points = BigInteger.ZERO;

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
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param medalTypeID WRITEME
	 */
	public void addMedalEarned (final int medalTypeID) {
		medals.add (new MedalType (medalTypeID));
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param medal WRITEME
	 * @throws NotFoundException invalid medal name
	 */
	public void addMedalEarned (final String medal)
			throws NotFoundException {
		medals.add (new MedalType (medal));
	}

	/**
	 * Cancel an event in progress. Awards no points and triggers
	 * outcomes.
	 */
	public void cancel () {
		final AbstractUser creator = getCreator ();
		Quaestor.getDefault ().action (
				new Action (creator, "event.cancel",
						(AbstractUser) null, getEventType ()
								.getDescription (), BigDecimal.ZERO));
		setPoints (0);
		doOutcome ();
		try {
			final JSONObject result = toJSON ();
			result.put ("canceled", id);
			creator.acceptSuccessReply ("endEvent", result, null);
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a JSONException in EventRecord.cancel ", e);
		}
		return;
	}

	/**
	 * Create a copy of this event record for another player in a
	 * multiplayer event
	 *
	 * @param player the other player
	 * @return the copy of thsi record
	 */
	private EventRecord copyFor (final AbstractUser player) {
		EventRecord copy = new EventRecord (myLoader);
		copy.completionTimestamp = completionTimestamp;
		copy.creationTimestamp = creationTimestamp;
		copy.creatorID = player.getUserID ();
		copy.currencyAmountEarned = currencyAmountEarned;
		copy.currencyEarned = currencyEarned;
		copy.earnedItemID = earnedItemID;
		copy.eventTypeID = eventTypeID;
		for (MedalType medal : medals) {
			addMedalEarned (medal.getID ());
		}
		copy.markAsLoaded ();
		copy.changed ();
		return copy;
	}

	/**
	 * @see org.starhope.catullus.Copyable#copyProtoype(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public EventRecord copyProtoype (final EventRecord prototype) {
		completionTimestamp = prototype.completionTimestamp;
		creationTimestamp = prototype.creationTimestamp;
		creatorID = prototype.creatorID;
		currencyAmountEarned = prototype.currencyAmountEarned;
		currencyEarned = prototype.currencyEarned;
		earnedItemID = prototype.earnedItemID;
		eventTypeID = prototype.eventTypeID;
		id = prototype.id;
		medals.clear ();
		for (MedalType medal : prototype.medals) {
			medals.add (medal);
		}
		points = prototype.points;
		return this;
	}

	/**
	 * @param outcome the outcome being executed
	 * @return the reward scalar for this event
	 */
	private BigDecimal determineRewardScalar (
			final EventOutcomeRecord outcome) {

		if (outcome.isRewardRandom ()) {
			return BigDecimal.valueOf (AppiusConfig.getRandomInt (
					outcome.getRewardMin ().intValueExact (), outcome
							.getRewardMax ().intValueExact ()));
		}

		// if (outcome.isRewardByPoints ()) {
		return new BigDecimal (points);
		// }

		// return BigDecimal.ZERO;
	}

	/**
	 * perform actions specified by the outcome for this event type
	 */
	private void doOutcome () {
		final EventOutcomeRecord outcome = getEventType ()
				.getOutcome ();

		final BigDecimal rewardScalar = determineRewardScalar (outcome);
		rewardWithMedal (outcome, rewardScalar);
		rewardWithCurrency (outcome, rewardScalar);
		rewardWithItem (outcome, rewardScalar);
		completionTimestamp = System.currentTimeMillis ();
		changed ();
		try {
			getCreator ().acceptSuccessReply ("endEvent", toJSON (),
					null);
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a JSONException in EventRecord.doOutcome ",
					e);
		}
	}

	/**
	 * End an event (such as a game or minigame) with a singular score
	 *
	 * @param score score earned by this player
	 */
	public void end (final BigInteger score) {
		setPoints (score);
		doOutcome ();
		Quaestor.getDefault ().action (
				new Action (getCreator (), "event.end",
						(AbstractUser) null, getEventType ()
								.getMoniker (), score, this));
	}

	/**
	 * purchase something.
	 *
	 * @param itemPurchased what was purchased
	 * @throws NonSufficientFundsException couldn't afford it
	 */
	public void end (final GenericItemReference itemPurchased)
			throws NonSufficientFundsException {
		final BigDecimal price = itemPurchased.getPrice ();
		end (itemPurchased, price);
	}

	/**
	 * End a purchase-type event, but they might not have actually
	 * purchased something, the price is specified
	 *
	 * @param itemPurchased the item purchased (or given)
	 * @param price the price to pay (which can be
	 *            {@link BigDecimal#ZERO}
	 * @throws NonSufficientFundsException if they can't afford it
	 */
	public void end (final GenericItemReference itemPurchased,
			final BigDecimal price) throws NonSufficientFundsException {
		final AbstractUser buyer = getCreator ();

		final Currency currency = itemPurchased.getCurrency ();

		if (price.compareTo (BigDecimal.ZERO) == 0) {

			setCurrencyEarned (currency.getCode (), BigDecimal.ZERO);

		} else {

			if (price.compareTo (buyer.getWallet ().get (currency)) > 0) {
				throw new NonSufficientFundsException (price, buyer
						.getWallet ().get (currency));
			}
			setCurrencyEarned (currency.getCode (), price.negate ()); // XXX
			buyer.sendEarnings (buyer.getRoom (), currency,
					price.negate ());

		}

		final int itemPurchasedID = itemPurchased.getItemID ();
		setItemEarned (itemPurchasedID);
		buyer.sendEarnings (buyer.getRoom (), buyer.getInventory ()
				.add (itemPurchasedID));
		setCompletionTimestamp (System.currentTimeMillis ());

		Quaestor.getDefault ()
				.action (
						new Action (getCreator (),
								"event.end.purchase",
								(AbstractUser) null, getEventType ()
										.getDescription (),
								itemPurchased, this));
		doOutcome ();
	}

	/**
	 * End a “gift” event whereby an user has given an item to another
	 * user
	 *
	 * @param item the item being given as a gift
	 * @param u the user giving the item as a gift
	 * @throws GameLogicException if the transaction cannot be completed
	 */
	public void end (final InventoryItem item, final AbstractUser u)
			throws GameLogicException {
		if ( ! (item.getOwnerID () == u.getUserID ())) {
			throw new GameLogicException ("not owner", item, u);
		}
		if ( !item.getGenericItem ().canTrade ()) {
			throw new GameLogicException ("can't trade", item, u);
		}
		Quaestor.getDefault ().action (
				new Action (getCreator (), "event.end.gift",
						(AbstractUser) null, getEventType ()
								.getDescription (), item
								.getGenericItem ()));
		item.setOwnerID (creatorID);
		Nomenclator.getUserByID (creatorID).getInventory ().add (item);
		u.getInventory ().remove (item);
		earnedItemID = item.getGenericItem ().getItemID ();
		doOutcome ();
	}

	/**
	 * End this event <em>for this player</em>. Note that the scores
	 * will be reported to him/her, so it's usually the case that this
	 * should happen simultaneously for all players
	 *
	 * @param sortedScores scores earned by all players of a multiplayer
	 *            event.
	 */
	public void end (
			final LinkedHashMap <AbstractUser, BigInteger> sortedScores) {
		JSONObject multiplayerScores = new JSONObject ();
		int i = 0;
		for (Map.Entry <AbstractUser, BigInteger> playerScore : sortedScores
				.entrySet ()) {
			AbstractUser player = playerScore.getKey ();
			BigInteger score = playerScore.getValue ();
			JSONObject playerScoreJSON = new JSONObject ();
			try {
				playerScoreJSON.put ("p", player.getAvatarLabel ());
				playerScoreJSON.put ("s", score.toString ());
				multiplayerScores.put (String.valueOf ( ++i),
						playerScoreJSON);
			} catch (JSONException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a JSONException in EventRecord.end ",
								e);
			}
			EventRecord playerCopy = copyFor (player);
			playerCopy.end (score);
		}
		JSONObject endEventInfo = new JSONObject ();
		try {
			endEventInfo.put ("event", toJSON ());
			endEventInfo.put ("scores", multiplayerScores);
		} catch (JSONException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a JSONException in EventRecord.end ", e);
		}
		for (AbstractUser player : sortedScores.keySet ()) {
			player.acceptSuccessReply ("endMultiplayerEvent",
					endEventInfo, null);
		}
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
	 * @return the completionTimestamp
	 */
	public long getCompletionTimestamp () {
		return completionTimestamp;
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
	 * @return amount of currency earned
	 */
	public BigDecimal getCurrencyAmountEarned () {
		return currencyAmountEarned;
	}

	/**
	 * @return currency type earned
	 */
	public Currency getCurrencyEarned () {
		return currencyEarned;
	}

	/**
	 * @return the type of event of which this record describes once
	 *         incidence
	 */
	public EventType getEventType () {
		try {
			return Quaestor.getEventTypeByID (eventTypeID);
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a NotFoundException in EventRecord.getEventType ",
							e);
			return null;
		}
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
	public int getItemEarned () {
		return earnedItemID;
	}

	/**
	 * WRITEME WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public Collection <MedalType> getMedalsEarned () {
		final HashSet <MedalType> copy = new HashSet <MedalType> ();
		copy.addAll (medals);
		return copy;
	}

	/**
	 * @return the points
	 */
	public BigInteger getPoints () {
		return points;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2291 $";
	}

	/**
	 * @return whether to send high scores when printing this event
	 */
	public boolean isSendHighScore () {
		return sendHighScore;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 1,
	 * 2009)
	 *
	 * @param getHighScores WRITEME
	 * @param wrapper WRITEME
	 * @throws SQLException WRITEME
	 * @throws JSONException WRITEME
	 */
	private void pushHighScoresIntoJSON (
			final PreparedStatement getHighScores,
			final JSONObject wrapper) throws SQLException,
			JSONException {
		final JSONObject highScoreList = new JSONObject ();

		ResultSet scores = null;
		try {
			scores = getHighScores.getResultSet ();
			int i = 1;
			while (scores.next ()) {
				final JSONObject scoreInfo = new JSONObject ();
				final int thatID = scores.getInt ("ID");
				BigDecimal scorePoints = scores
						.getBigDecimal ("points");
				if (scores.wasNull ()) {
					scorePoints = BigDecimal.ZERO;
				}
				if (scorePoints.compareTo (BigDecimal.ZERO) > 0) {
					if (id == thatID) {
						wrapper.put ("gotHighScore", i);
						Quaestor.getDefault ().action (
								new Action (null, getCreator (),
										"event.gotHighScore",
										(AbstractUser) null,
										getEventType ().getMoniker (),
										scorePoints, Integer
												.valueOf (i)));
					}
					scoreInfo
							.put ("points", scorePoints.doubleValue ());
					scoreInfo.put ("ID", thatID);
					scoreInfo.put ("userName", scores
							.getString ("userName"));
					highScoreList
							.put (String.valueOf (i++ ), scoreInfo);
				}
			}
		} finally {
			LibMisc.closeAll (scores);
		}

		wrapper.put ("highScores", highScoreList);
	}

	/**
	 * Get high score information from the database and return it as a
	 * JSON object
	 *
	 * @param wrapper the JSON container to absorb the high score list
	 */
	protected void putEventHighScoresIntoJSON (final JSONObject wrapper) {
		PreparedStatement st = null;
		Connection con = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT events.ID AS ID, points, userName FROM events LEFT JOIN users ON users.ID = events.creatorID WHERE eventTypeID = ? AND completionTimestamp > DATE(NOW() - INTERVAL 1 MONTH) ORDER BY points DESC LIMIT 24");
			st.setInt (1, eventTypeID);
			if (st.execute ()) {
				pushHighScoresIntoJSON (st, wrapper);
			}
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a Exception in getHighScores", e);
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a Exception in getHighScores", e);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}

	/**
	 * Award any currency earned
	 *
	 * @param outcome the outcome being executed
	 * @param scalar the reward scalar
	 */
	private void rewardWithCurrency (final EventOutcomeRecord outcome,
			final BigDecimal scalar) {
		if (null != currencyEarned
				&& null != currencyAmountEarned
				&& BigDecimal.ZERO.compareTo (currencyAmountEarned) != 0) {
			return;
		}
		final Currency currencyUnits = outcome.getRewardCurrency ();
		if (null != currencyUnits) {
			final AbstractUser creator = getCreator ();
			AppiusClaudiusCaecus.blather ("Rewarding "
					+ creator.getDebugName () + " with "
					+ currencyUnits.getCode () + " ("
					+ scalar.toPlainString () + " × "
					+ outcome.getRewardRatio ().toPlainString () + ")");
			BigDecimal currencyFigure = outcome.getRewardRatio ()
					.multiply (scalar);
			if (currencyFigure.compareTo (outcome.getRewardMin ()) < 0) {
				currencyFigure = outcome.getRewardMin ();
			}
			if (currencyFigure.compareTo (outcome.getRewardMax ()) > 0) {
				currencyFigure = outcome.getRewardMax ();
			}
			setCurrencyEarned (currencyUnits.getCode (), currencyFigure);
			creator.updateWallet ();
			creator.sendEarnings (creator.getRoom (), currencyUnits,
					currencyFigure);
			Quaestor.getDefault ().action (
					new Action (creator, "earned.currency",
							(AbstractUser) null, currencyFigure
									.toPlainString (), currencyUnits));
		}
	}

	/**
	 * Award any item earned
	 *
	 * @param outcome the event outcome being applied
	 * @param scalar the scalar used to determine the outcome
	 */
	private void rewardWithItem (final EventOutcomeRecord outcome,
			final BigDecimal scalar) {
		GenericItemReference rewardItem = null;

		switch (outcome.getRewardItemType ()) {
		case ITEM:
			try {
				if (outcome.getRewardRatio ().multiply (scalar)
						.compareTo (BigDecimal.ONE) >= 0) {
					rewardItem = Nomenclator.getDataRecord (
							GenericItemReference.class, outcome
									.getRewardItemID ());
				}
			} catch (final NotFoundException e) {
				AppiusClaudiusCaecus.reportBug (
						"Reward item failure for "
								+ outcome.getRewardItemID (), e);
			}
			break;
		case COLLECTION:
			rewardItem = rewardWithItemFromCollection (outcome, scalar);
			break;
		case GLOBAL:
			rewardItem = GenericItemReference.getRandomItem (outcome
					.getMinRarity (), outcome.getMaxRarity ());
			break;
		default:
			return;
		}

		if (null == rewardItem && earnedItemID > 0) {
			try {
				rewardItem = Nomenclator.getDataRecord (
						GenericItemReference.class, earnedItemID);
			} catch (NotFoundException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a NotFoundException in EventRecord.rewardWithItem ",
								e);
			}
		}

		if (null != rewardItem) {
			final int itemID = rewardItem.getItemID ();
			final AbstractUser creator = getCreator ();
			boolean hasItem = creator.getInventory ().contains (
					Integer.valueOf (itemID));
			if ( !hasItem || hasItem
					&& outcome.isPermitDuplicateReward ()) {
				setItemEarned (itemID);
				InventoryItem rewarded = creator.getInventory ().add (
						itemID);
				creator.sendEarnings (creator.getRoom (), rewarded);
				Quaestor.getDefault ().action (
						new Action (creator, "earned.item",
								(AbstractUser) null, "", rewardItem));
			} else if (hasItem && outcome.isRetryDuplicateReward ()) {
				rewardWithItem (outcome, scalar);
			}
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param outcome WRITEME
	 * @param scalar WRITEME
	 * @return WRITEME
	 */
	private GenericItemReference rewardWithItemFromCollection (
			final EventOutcomeRecord outcome, final BigDecimal scalar) {
		ItemCollection collection;
		try {
			collection = Nomenclator.getDataRecord (
					ItemCollection.class, outcome
							.getRewardCollectionID ());
			return collection.get (scalar.intValueExact ()
					% collection.size ());
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus.reportBug (
					"Reward collection failure for "
							+ outcome.getRewardCollectionID (), e);
		}
		return null;
	}

	/**
	 * Is a medal to be awarded at this point? Note that this will
	 * overrule any medal earned during the event, presently, as medals
	 * are in the events table.
	 *
	 * @param outcome the outcome being executed
	 * @param scalar the reward scalar
	 */
	private void rewardWithMedal (final EventOutcomeRecord outcome,
			final BigDecimal scalar) {
		final MedalType medal = outcome.getGiveMedal ();
		if (null != medal && scalar.signum () > 0) {
			addMedalEarned (medal.getID ());
			Quaestor.getDefault ().action (
					new Action (getCreator (), "earned.medal", medal
							.getString ()));
		}
	}

	/**
	 * @param newTimestamp the completionTimestamp to set
	 */
	public void setCompletionTimestamp (final long newTimestamp) {
		completionTimestamp = newTimestamp;
		changed ();

	}

	/**
	 * @param timestamp the new completion timestamp
	 */
	public void setCompletionTimestamp (final Timestamp timestamp) {
		if (null == timestamp) {
			completionTimestamp = -1;
		} else {
			completionTimestamp = timestamp.getTime ();
		}
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
	 * Set the amount of currency earned during an event
	 *
	 * @param currencyType Currency units
	 * @param amount Quantity (signed, i.e. may be negative)
	 */
	public void setCurrencyEarned (final String currencyType,
			final BigDecimal amount) {
		if ("".equals (currencyType) || null == currencyType
				|| null == amount) {
			currencyEarned = null;
			currencyAmountEarned = null;
			return;
		}
		currencyEarned = Currency.getPeanuts ();
		// XXX: new Currency (currencyType);
		currencyAmountEarned = amount;
		if ( !isBeingLoaded ()) {
			myLoader.saveRecord (this); // Sucky hack for Peanuts
		}
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
		changed ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param itemID WRITEME
	 */
	public void setItemEarned (final int itemID) {
		earnedItemID = itemID;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param score WRITEME
	 */
	private void setPoints (final BigInteger score) {
		points = score;
		changed ();
	}

	/**
	 * @param newPoints the points to set
	 */
	public void setPoints (final long newPoints) {
		points = BigInteger.valueOf (newPoints);
		changed ();

	}

	/**
	 * WRITEME: Document this method ewinkelman
	 *
	 * @return
	 */
	public ADPEndEvent toDatagram () {
		final ADPEndEvent result = new ADPEndEvent (getCreator ());
		result.setCompletionTimestamp (completionTimestamp);
		result.setCreationTimestamp (creationTimestamp);
		if (creatorID > 0) {
			result.setCreator (Nomenclator.getLoginForID (creatorID));
		}
		if (null != currencyAmountEarned && null != currencyEarned) {
			final ADPCurrencyEarned earned = new ADPCurrencyEarned (
					getCreator ());
			earned.setCurrencyEarned (currencyEarned,
					currencyAmountEarned);
			result.setCurrencyEarned (earned);
		}

		return result;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 * @throws JSONException if the contents can't be encoded in JSON
	 *             for some reason
	 */
	@Deprecated
	public JSONObject toJSON () throws JSONException {
		final JSONObject jso = new JSONObject ();
		if (0 < completionTimestamp) {
			jso.put ("completed", completionTimestamp);
		}
		if (0 < creationTimestamp) {
			jso.put ("created", creationTimestamp);
		}
		if (0 < creatorID) {
			jso.put ("creator", Nomenclator.getLoginForID (creatorID));
		}
		if (null != currencyAmountEarned && null != currencyEarned) {
			final JSONObject curr = new JSONObject ();
			curr.put ("cu", currencyEarned.getCode ());
			if (AppiusConfig
					.getConfigBoolOrTrue ("org.starhope.appius.events.currencyInt")) {
				curr.put ("amt", currencyAmountEarned.round (
						MathContext.DECIMAL32).intValue ());
			} else {
				curr.put ("amt", currencyAmountEarned.toPlainString ());
			}
			jso.put ("currencyEarned", curr);
			if (AppiusConfig
					.getConfigBoolOrTrue ("com.tootsville.events.callPeanuts")) {
				if (currencyEarned.equals (Currency.getPeanuts ())) {
					jso.put ("peanuts", currencyAmountEarned.round (
							MathContext.DECIMAL32).intValue ());
					jso.put ("totalPeanuts", getCreator ().getWallet ()
							.get (Currency.getPeanuts ()));
					// TODO
					// jso.put("totalPeanuts", ((User)getCreator
					// ()).getWallet().
					// getCurrencyAmount(Currency.getPeanuts ()));
				}
			}
		}
		final EventType type = getEventType ();
		if (type.hasHighScores () && 0 < completionTimestamp) {
			putEventHighScoresIntoJSON (jso);
		}
		if (0 < earnedItemID) {
			jso.put ("earnedItemID", earnedItemID);
		}
		if (0 < eventTypeID) {
			jso.put ("type", type.toJSON ());
		}
		if (0 < id) {
			jso.put ("id", id);
		}
		if (medals.size () > 0) {
			final JSONObject m = new JSONObject ();
			int i = 0;
			for (final MedalType medal : medals) {
				m.put (String.valueOf (i++ ), medal.toJSON ());
			}
			jso.put ("medalsEarned", m);
		}
		if (null != points) {
			jso.put ("points", points.toString ());
		}
		if (AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.events.format1.0")) {
			jso.put ("asVersion", type.getEngine ());
			jso.put ("eventID", id);
			jso.put ("moniker", type.getMoniker ());
		}
		return jso;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		try {
			return toJSON ().toString ();
		} catch (final JSONException e) {
			return super.toString ();
		}
	}

}
