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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.user.events;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.CastsToJSON;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.util.LibMisc;

/**
 * <p>
 * An EventType is a type of event in which an user can participate.
 * Examples might include playing a game or minigame, or encountering a
 * specific treasure in the game world. Any event can yield an item (see
 * {@link InventoryItem}) or a medal (see {@link MedalType}), as well as
 * a certain amount of game currency (see {@link Currency}). When an
 * user participates in an event, they will have an {@link EventRecord}
 * indicating when it began, ended, and the results thereof.
 * </p>
 * <p>
 * XXX: currency support is mostly non-functional.
 * </p>
 * 
 *<pre>
 * ALTER TABLE eventTypes ADD COLUMN frequencyLimit DECIMAL(2,0) UNSIGNED NOT NULL DEFAULT 99;
 * ALTER TABLE eventTypes ADD COLUMN frequencyPeriod DECIMAL(6,0) UNSIGNED NOT NULL DEFAULT 1;
 *</pre>
 * 
 * @author brpocock@star-hope.org
 */
public class EventType extends SimpleDataRecord <EventType> implements
CastsToJSON {

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
	public static int getIDForMoniker (final String moniker)
	throws NotFoundException {
		return Nomenclator.getDataRecord (EventType.class, moniker)
		.getID ();
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
	 * how frequently the event type can be conducted
	 */
	private long frequencyLimit = 1;
	/**
	 * hot long before the {@link #frequencyLimit} is reset
	 */
	private long frequencyPeriod = 1000;

    /**
     * Whether or not this event generates high scores
     */
    private boolean highScores = false;

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
	private EventOutcomeRecord outcome = null;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param eventTypeLoader loader
	 */
	EventType (final RecordLoader <EventType> eventTypeLoader) {
		super (eventTypeLoader);
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
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public String getFilename () {
		return filename;
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
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public int getID () {
		return id;
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
	public EventOutcomeRecord getOutcome () {
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
	private List <EventRecord> getPriorForPlayer (
			final AbstractUser user, final long periodStart) {
		final long interval = (System.currentTimeMillis () - periodStart) / 60000;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		final List <EventRecord> results = new LinkedList <EventRecord> ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement ("SELECT ID FROM events WHERE creatorID=? AND creationTimestamp > NOW() - INTERVAL ? MINUTE AND eventTypeID=?");
			st.setInt (1, user.getUserID ());
			st.setLong (2, interval);
			st.setInt (3, getID ());
			rs = st.executeQuery ();
			while (rs.next ()) {
				try {
					results.add (Nomenclator.getDataRecord (
							EventRecord.class, rs.getInt ("ID")));
				} catch (final NotFoundException e) {
					AppiusClaudiusCaecus.reportBug (e);
				}
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (e);
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
		return "$Rev: 2188 $";
	}

	/**
	 * @return whether to track high scores for this event type
	 */
	public boolean hasHighScores () {
        return highScores;
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
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param filename2 new filename
	 */
	public void setFilename (final String filename2) {
		filename = filename2;
		changed ();

	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param l new frequency limit
	 */
	public void setFrequencyLimit (final long l) {
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
		highScores = whether;
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
	public void setOutcome (final EventOutcomeRecord newOutcome) {
		outcome = newOutcome;
		changed ();
	}
	
	/**
	 * Start an event for the user, of this type. Should throw
	 * exceptions if the event can't be started for some reason, e.g.
	 * frequency period enforcement
	 * 
	 * @param user The user starting the event
	 * @return the event record created
	 * @throws AlreadyExistsException if the event has been performed
	 *             already at (or more than) the limit for a given time
	 *             period. The general response to the user should
	 *             reflect something to the effect of “this event cannot
	 *             be performed again, now” or suppress notification of
	 *             the event altogether.
	 */
	@SuppressWarnings ("unchecked")
	public EventRecord startEvent (final AbstractUser user)
	throws AlreadyExistsException {
		final long now = System.currentTimeMillis ();
		final List <EventRecord> prior = getPriorForPlayer (user, now
				- getFrequencyPeriod () * 60000);
		if (prior.size () >= getFrequencyLimit ()) {
			throw new AlreadyExistsException ("freq");
		}
		final EventRecord ev = new EventRecord ();
		ev.setRecordLoader (AppiusConfig
				.getRecordLoaderForClass (EventRecord.class));
		ev.setEventTypeID (id);
		ev.setCreator (user);
		ev.markAsLoaded ();
		ev.setCreationTimestamp (now);
		((RecordLoader <EventRecord>) ev.getRecordLoader ())
		.saveRecord (ev);
		Quaestor.getDefault ().action (
				new Action (user.getRoom (), user, "event.start",
						(AbstractUser) null,
						getString (), ev));
		return ev;
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
			AppiusClaudiusCaecus.reportBug (
					"Caught a JSONException in EventType.toJSON ", e);
		}
		return o;
	}

}
