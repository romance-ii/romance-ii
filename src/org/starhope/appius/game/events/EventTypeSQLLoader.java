/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
import java.sql.Types;



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

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
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class EventTypeSQLLoader implements RecordLoader <EventType> {

	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (EventTypeSQLLoader.class);

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final EventType changedRecord) {
		// Types are not to be saved
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#initializeStorage(java.lang.String)
	 */
	@Override
	public void initializeStorage (final String storageURL) throws NotReadyException {
		// no op
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#isRealtime()
	 */
	@Override
	public boolean isRealtime () {
		return false;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
	 */
	@Override
	public EventType loadRecord (final int id) throws NotFoundException {
		return loadRecord (id, new EventType (this));
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param id WRITEME 
	 * @param record WRITEME 
	 * @return WRITEME 
	 * @throws NotFoundException
	 */
	private EventType loadRecord (final int id, final EventType record) throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		record.markForReload ();

		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM eventTypes WHERE ID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			rs.next ();
			set (record, rs);
			if (record.hasHighScores ()) {
				st =
						con.prepareStatement ("SELECT events.ID AS ID, points, userName FROM events LEFT JOIN users ON users.ID = events.creatorID WHERE eventTypeID = ? AND completionTimestamp > DATE(NOW() - INTERVAL 1 MONTH) ORDER BY points DESC,completionTimestamp DESC LIMIT 24");
				st.setInt (1, id);
				rs = st.executeQuery ();
				setHighScores (record, rs);
			}
		} catch (SQLException e) {
			EventTypeSQLLoader.log.error ("Caught a SQLException in EventTypeSQLLoader.loadRecord " + id, e);
			throw new NotFoundException (String.valueOf (id));
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		record.markAsLoaded ();
		return record;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public EventType loadRecord (final String identifier) throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;

		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM eventTypes WHERE name=?");
			st.setString (1, identifier);
			rs = st.executeQuery ();
			if ( !rs.next ()) {
				throw new NotFoundException (identifier + " is not a valid event type");
			}
			final EventType record = set (new EventType (this), rs);
			record.markForReload ();
			if (record.hasHighScores ()) {
				st =
						con.prepareStatement ("SELECT events.ID AS ID, points, userName FROM events LEFT JOIN users ON users.ID = events.creatorID WHERE eventTypeID = ? AND completionTimestamp > DATE(NOW() - INTERVAL 1 MONTH) ORDER BY points DESC,completionTimestamp DESC LIMIT 24");
				st.setInt (1, record.getID ());
				rs = st.executeQuery ();
				setHighScores (record, rs);
			}
			record.markAsLoaded ();
			return record;
		} catch (SQLException e) {
			EventTypeSQLLoader.log.error ("Caught a SQLException in EventTypeSQLLoader.loadRecord  " + identifier, e);
			throw new NotFoundException (String.valueOf (identifier));
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param record WRITEME 
	 */
	@Override
	public void refresh (final EventType record) {
		try {
			loadRecord (record.getID (), record);
		} catch (NotFoundException e) {
			EventTypeSQLLoader.log.error ("Exception",e);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final EventType record) {
		// No op
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final EventType record) {
		PreparedStatement update = null;
		try {
			update =
					AppiusConfig.getDatabaseConnection ().prepareStatement (
							"UPDATE eventTypes SET name=?, filename=?, " + "outcome=?, ASVersion=?, "
									+ "numberPlayers=?, description=?, " + "frequencyLimit=?, frequencyPeriod=? "
									+ "WHERE id=?");
			update.setString (1, record.getMoniker ());
			final String filename = record.getFilename ();
			if (null == filename) {
				update.setNull (2, Types.VARCHAR);
			} else {
				update.setString (2, filename);
			}
			update.setInt (3, record.getOutcome ().getID ());
			update.setString (4, record.getEngine ());
			update.setInt (5, record.getNumberOfPlayers ());
			update.setString (6, record.getDescription ());
			final long frequencyLimit = record.getFrequencyLimit ();
			if ( -1 == frequencyLimit) {
				update.setNull (7, Types.INTEGER);
			} else {
				update.setLong (7, frequencyLimit);
			}
			final long frequencyPeriod = record.getFrequencyPeriod ();
			if ( -1 == frequencyPeriod) {
				update.setNull (8, Types.INTEGER);
			} else {
				update.setLong (8, frequencyPeriod);
			}
			update.setInt (9, record.getID ());
			update.executeUpdate ();
		} catch (final SQLException e) {
			EventTypeSQLLoader.log.error ("Exception", e);
		} finally {
			if (null != update) {
				try {
					update.close ();
				} catch (final SQLException e) {
					EventTypeSQLLoader.log.error ("Exception", e);
				}
			}
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param eventType WRITEME 
	 * @param set WRITEME
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 */
	private EventType set (final EventType eventType, final ResultSet set) throws SQLException {
		eventType.setID (set.getInt ("ID"));
		eventType.setMoniker (set.getString ("name"));
		String filename = set.getString ("filename");
		if (set.wasNull ()) {
			filename = "";
		}
		eventType.setFilename (filename);

		eventType.setEngine (set.getString ("ASVersion"));
		eventType.setLoader (set.getString ("loader"));

		final int outcomeID = set.getInt ("outcome");
		try {
			eventType.setOutcome (Nomenclator.getDataRecord (EventOutcome.class, outcomeID));
		} catch (final NotFoundException e) {
			EventTypeSQLLoader.log.error ("Caught a NotFoundException in EventTypeSQLLoader for outcome #"
					+ outcomeID, e);
		}
		eventType.setNumberOfPlayers (set.getInt ("numberPlayers"));
		String description = set.getString ("description");
		if (set.wasNull ()) {
			description = "" + filename;
		}
		eventType.setDescription (description);

		final int frequencyLimit = set.getInt ("frequencyLimit");
		if (set.wasNull ()) {
			eventType.setFrequencyLimit ( -1);
		} else {
			eventType.setFrequencyLimit (frequencyLimit);
		}
		final long frequencyPeriod = set.getLong ("frequencyPeriod");
		if (set.wasNull ()) {
			eventType.setFrequencyPeriod ( ( -1L));
		} else {
			eventType.setFrequencyPeriod (frequencyPeriod);
		}
		eventType.setHighScores ("Y".equals (set.getString ("highScores")));
		int fileWidth = set.getInt ("fileWidth");
		eventType.setFileWidth (set.wasNull () ? null : fileWidth);
		int fileHeight = set.getInt ("fileHeight");
		eventType.setFileHeight (set.wasNull () ? null : fileHeight);
		eventType.markAsLoaded ();
		return eventType;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param eventType WRITEME 
	 * @param set WRITEME
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 */
	private EventType setHighScores (final EventType eventType, final ResultSet set) throws SQLException {
		eventType.clearHighScores ();
		while (set.next ()) {
			final EventScore score =
					new EventScore (set.getInt ("ID"), set.getLong ("points"), set.getString ("userName"));
			eventType.considerForHighscore (score);
		}
		return eventType;
	}

}
