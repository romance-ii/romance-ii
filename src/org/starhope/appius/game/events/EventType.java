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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map.Entry;
import java.util.SortedSet;
import java.util.TreeSet;

import org.json.JSONException;
import org.json.JSONObject;


import org.starhope.appius.except.MembershipException;
import org.starhope.appius.except.NonSufficientFundsException;
import org.starhope.appius.except.NonSufficientItemsException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.net.datagram.ADPMap;
import org.starhope.appius.net.datagram.ADPScore;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.CastsToJSON;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.util.LibMisc;

/**
 * <p>
 * An EventType is a type of event in which an user can participate. Examples might include playing a game or minigame,
 * or encountering a specific treasure in the game world. Any event can yield an item (see {@link InventoryItem}) or a
 * medal (see {@link MedalType}), as well as a certain amount of game currency (see {@link Currency}). When an user
 * participates in an event, they will have an {@link EventRecord} indicating when it began, ended, and the results
 * thereof.
 * </p>
 * <p>
 * XXX: currency support is mostly non-functional.
 * </p>
 *
 * <pre>
 * ALTER TABLE eventTypes ADD COLUMN frequencyLimit DECIMAL(2,0) UNSIGNED NOT NULL DEFAULT 99;
 * ALTER TABLE eventTypes ADD COLUMN frequencyPeriod DECIMAL(6,0) UNSIGNED NOT NULL DEFAULT 1;
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
public class EventType extends SimpleDataRecord <EventType> implements CastsToJSON {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (EventType.class);
	
	/**
	 * Java serialization unique ID
	 */
	private static final long serialVersionUID = 3264040852839164213L;
	
	/**
	 * get the ID for a given event type moniker. Doesn't do any fancy
	 * shortcut work: justs grabs the {@link #getID()} method after
	 * using {@link Nomenclator#getDataRecord(Class, String)}
	 *
	 * @param moniker the moniker of the Event Type
	 * @return the ID for the moniker
	 * @throws NotFoundException if the moniker doesn't yield an event
	 *             type
	 */
	public static int getIDForMoniker (final String moniker) throws NotFoundException {
		return Nomenclator.getDataRecord (EventType.class, moniker).getID ();
	}
	
	/**
	 * the user-visible description of the event type
	 */
	private String description = "";
	
	/**
	 * the script engine for client-side processing of the event or
	 * minigame
	 */
	private String engine = "";
	
	/**
	 * the filename for client-side processing of a minigame
	 */
	private String filename = "";
	/**
	 * Optional width for a flash file
	 */
	private Integer fileWidth = null;
	/**
	 * Optional height for a flash file
	 */
	private Integer fileHeight = null;
	
	/**
	 * The loader to use for the game, if any
	 */
	private String loader = "";
	
	/**
	 * how frequently the event type can be conducted
	 */
	private int frequencyLimit = 1;
	
	/**
	 * hot long before the {@link #frequencyLimit} is reset
	 */
	private long frequencyPeriod = 1000;
	/**
	 * Whether or not this event generates high scores
	 */
	private boolean hasHighScores = false;
	/**
	 * List of all current high scores
	 */
	private final SortedSet <EventScore> highScores = new TreeSet <EventScore> ();
	
	/**
	 * the database ID of the event type
	 */
	private int id;
	
	/**
	 * the moniker of the event type
	 */
	private String moniker;
	
	/**
	 * the number of players for a minigame
	 */
	private int numberOfPlayers = 1;
	
	/**
	 * outcomes of events
	 */
	private EventOutcome outcome = null;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param eventTypeLoader loader
	 */
	EventType (final RecordLoader <EventType> eventTypeLoader) {
		super (eventTypeLoader);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param user WRITEME 
	 * @return WRITEME 
	 */
	public boolean allowedToHave (final AbstractUser user) {
		boolean result = false;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st =
				con.prepareStatement ("SELECT COUNT(*) FROM events WHERE creatorID=? AND creationTimestamp > NOW() - INTERVAL ? SECOND AND eventTypeID=?");
			st.setInt (1, user.getUserID ());
			st.setLong (2, getFrequencyPeriod ());
			st.setInt (3, getID ());
			rs = st.executeQuery ();
			while (rs.next ()) {
				final long count = rs.getLong (1);
				result = count < getFrequencyLimit ();
			}
		} catch (final SQLException e) {
			EventType.log.error ("Exception", e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		
		return result;
	}
	
	/**
	 * Clears the list of high scores
	 */
	public void clearHighScores () {
		highScores.clear ();
	}
	
	/**
	 * Considers the score for inclusion as a high score.
	 *
	 * @param score WRITEME 
	 */
	public void considerForHighscore (final EventScore score) {
		if (hasHighScores) {
			synchronized (highScores) {
				highScores.add (score);
				// Trim high scores to 24
				while (highScores.size () > 24) {
					highScores.remove (highScores.first ());
				}
			}
		}
	}
	
	/**
	 * Perform an event for the user, of this type. Should throw
	 * exceptions if the event can't be started for some reason, e.g.
	 * frequency period enforcement
	 *
	 * @param prototype Prototype information for filling out the event
	 * @param user The user starting the event
	 * @return the event record created
	 * @throws NotReadyException
	 * @throws NonSufficientFundsException
	 * @throws NonSufficientItemsException
	 * @throws MembershipException
	 */
	public EventRecord doEvent (final EventPrototypeInfo prototype, final AbstractUser user) throws NotReadyException,
	NonSufficientFundsException, NonSufficientItemsException, MembershipException {
		// Check frequency
		final long now = System.currentTimeMillis ();
		if ( !allowedToHave (user)) { throw new NotReadyException ("Not enough time has passed since last use"); }
		// Check required currency
		for (Entry <Currency, Long> currencyEntry : prototype.getRequiredCurrencies ().entrySet ()) {
			final long amountWanted = currencyEntry.getValue ().longValue ();
			final long amountUserHas = user.getWallet ().get (currencyEntry.getKey ());
			if (amountWanted > amountUserHas) { throw new NonSufficientFundsException (amountWanted, amountUserHas); }
		}
		// Check required items
		for (Entry <RealItem, Integer> itemEntry : prototype.getRequiredItems ().entrySet ()) {
			final int amountWanted = itemEntry.getValue ().intValue ();
			final int amountUserHas = user.getInventory ().getCount (itemEntry.getKey ());
			if (amountWanted > amountUserHas) { throw new NonSufficientItemsException (
					itemEntry.getKey ().getItemID (), amountWanted, amountUserHas); }
		}
		// Check requires paid/free
		if (prototype.getPaidOnly () != null && ! (prototype.getPaidOnly ().booleanValue () ^ !user.isPaidMember ())) { throw new MembershipException (
				prototype.getPaidOnly ().booleanValue ()); }
		
		final EventRecord ev = new EventRecord ();
		ev.setRecordLoader (AppiusConfig.getRecordLoaderForClass (EventRecord.class));
		ev.setEventTypeID (id);
		ev.setCreator (user);
		
		// Add in earned items
		for (Entry <RealItem, Integer> itemEntry : prototype.getEarnedItems ().entrySet ()) {
			ev.addItemEarned (itemEntry.getKey (), itemEntry.getValue ().intValue ());
		}
		
		// Add in earned currency
		for (Entry <Currency, Long> currencyEntry : prototype.getEarnedCurrencies ().entrySet ()) {
			ev.addCurrencyEarned (currencyEntry.getKey (), currencyEntry.getValue ().longValue ());
		}
		
		ev.setCreationTimestamp (now);
		ev.end (prototype.getPoints ());
		ev.markAsLoaded ();
		ev.save ();
		return ev;
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
		if ( ! (obj instanceof EventType)) {
			return false;
		}
		EventType other = (EventType) obj;
		if (id != other.id) {
			return false;
		}
		return true;
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
	public String getCacheableIdent () throws NotFoundException {
		return moniker;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public String getDescription () {
		return description;
		
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public String getEngine () {
		return engine;
	}
	
	/**
	 * @return the fileHeight
	 */
	public Integer getFileHeight () {
		return fileHeight;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public String getFilename () {
		return filename;
	}
	
	/**
	 * @return the fileWidth
	 */
	public Integer getFileWidth () {
		return fileWidth;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public long getFrequencyLimit () {
		return frequencyLimit;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public long getFrequencyPeriod () {
		return frequencyPeriod;
		
	}
	
	/**
	 * Returns the rank of the event in the high scores list. Returns 0
	 * if the event is not in the list.
	 *
	 * @param eventID WRITEME 
	 * @return WRITEME 
	 */
	public int getHighScoreRank (final int eventID) {
		int rank = 0;
		synchronized (highScores) {
			for (EventScore score : highScores) {
				if (score.getEventID () == eventID) {
					break;
				}
				rank++ ;
			}
		}
		return rank;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @return WRITEME 
	 */
	public EventScore [] getHighScores () {
		synchronized (highScores) {
			return hasHighScores ? highScores.toArray (new EventScore [] {}) : null;
		}
	}
	
	/**
	 * Gets a datagram with the current high scores for this type
	 *
	 * @param s WRITEME 
	 * @return WRITEME 
	 */
	public ADPMap <ADPScore> getHighScoresDatagram (final ChannelListener s) {
		final EventScore [] scores = getHighScores ();
		final ADPMap <ADPScore> result = new ADPMap <ADPScore> ("highScores", s);
		for (int i = 0; i < scores.length; i++ ) {
			result.add (Integer.toString (i), scores [i].getDatagram (s, false));
		}
		return result;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public int getID () {
		return id;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @return WRITEME 
	 */
	public String getLoader () {
		return loader;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return moniker
	 */
	public String getMoniker () {
		return moniker;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public int getNumberOfPlayers () {
		return numberOfPlayers;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return outcome
	 */
	public EventOutcome getOutcome () {
		return outcome;
	}
	
	/**
	 * XXX: contains SQL
	 *
	 * @param user the user/player in question
	 * @param periodStart the time after which we want knowledge of
	 *            events of this type
	 * @return all events of this type between the period start and the
	 *         present (or future)
	 */
	public List <EventRecord> getPriorForPlayer (final AbstractUser user, final long periodStart) {
		final long interval = (System.currentTimeMillis () - periodStart) / 1000;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		final List <EventRecord> results = new LinkedList <EventRecord> ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st =
				con.prepareStatement ("SELECT ID FROM events WHERE creatorID=? AND creationTimestamp > NOW() - INTERVAL ? SECOND AND eventTypeID=?");
			st.setInt (1, user.getUserID ());
			st.setLong (2, interval);
			st.setInt (3, getID ());
			rs = st.executeQuery ();
			while (rs.next ()) {
				try {
					results.add (Nomenclator.getDataRecord (EventRecord.class, rs.getInt ("ID")));
				} catch (final NotFoundException e) {
					EventType.log.error ("Exception", e);
				}
			}
		} catch (final SQLException e) {
			EventType.log.error ("Exception", e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return results;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return moniker
	 * @deprecated use #getMoniker()
	 */
	@Deprecated
	public String getString () {
		return getMoniker ();
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4607 $";
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
	 * @return whether to track high scores for this event type
	 */
	public boolean hasHighScores () {
		return hasHighScores;
	}
	
	/**
	 * set the description field for this event type
	 *
	 * @param newDescription new description
	 */
	public void setDescription (final String newDescription) {
		description = newDescription;
		changed ();
	}
	
	/**
	 * set the engine for client-side processing of the event
	 *
	 * @param newEngine new engine code
	 */
	public void setEngine (final String newEngine) {
		engine = newEngine;
		changed ();
		
	}
	
	/**
	 * @param fileHeight the fileHeight to set
	 */
	public void setFileHeight (final Integer fileHeight) {
		this.fileHeight = fileHeight;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param filename2 new filename
	 */
	public void setFilename (final String filename2) {
		filename = filename2;
		changed ();
		
	}
	
	/**
	 * @param fileWidth the fileWidth to set
	 */
	public void setFileWidth (final Integer fileWidth) {
		this.fileWidth = fileWidth;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param l new frequency limit
	 */
	public void setFrequencyLimit (final int l) {
		frequencyLimit = l;
		changed ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param period WRITEME
	 */
	public void setFrequencyPeriod (final long period) {
		frequencyPeriod = period;
	}
	
	/**
	 * Sets the high score boolean for this event type. If false, high
	 * scores will not be computed/returned on event ends.
	 *
	 * @param whether whether to return high scores, or not
	 */
	public void setHighScores (final boolean whether) {
		hasHighScores = whether;
	}
	
	/**
	 * set the ID
	 *
	 * @param newID the new ID
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param string WRITEME 
	 */
	public void setLoader (final String string) {
		loader = string;
		changed ();
	}
	
	/**
	 * @param newMoniker new moniker
	 */
	public void setMoniker (final String newMoniker) {
		moniker = newMoniker;
		changed ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param int1 new number of players
	 */
	public void setNumberOfPlayers (final int int1) {
		numberOfPlayers = int1;
		changed ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param newOutcome the new outcome for this event type
	 */
	public void setOutcome (final EventOutcome newOutcome) {
		outcome = newOutcome;
		changed ();
	}
	
	/**
	 * @see org.starhope.appius.util.CastsToJSON#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject o = new JSONObject ();
		try {
			o.put ("description", getDescription ());
			o.put ("engine", getEngine ());
			o.put ("filename", getFilename ());
			o.put ("id", getID ());
			o.put ("moniker", getString ());
			o.put ("numPlayers", getNumberOfPlayers ());
		} catch (final JSONException e) {
			EventType.log.error ("Caught a JSONException in EventType.toJSON ", e);
		}
		return o;
	}
	
}
