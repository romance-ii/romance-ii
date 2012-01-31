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

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * load an event record from the database
 *
 * <pre>
 * ALTER TABLE events CHANGE COLUMN ID ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
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
public class EventRecordSQLLoader implements RecordLoader <EventRecord> {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (EventRecordSQLLoader.class);

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final EventRecord changedRecord) {
		DataRecordFlushManager.update (this, changedRecord);
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
		// No op.
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#isRealtime()
	 */
	@Override
	public boolean isRealtime () {
		return true; // for now … FIXME … shouldn't need to be!
		// return false;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
	 */
	@Override
	public EventRecord loadRecord (final int id) throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM events WHERE ID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			rs.next ();
			final EventRecord rec = new EventRecord ();
			rec.setCreationTimestamp (rs.getTimestamp ("creationTimestamp"));
			rec.setCreatorID (rs.getInt ("creatorID"));
			rec.setEventTypeID (rs.getInt ("eventTypeID"));
			rec.setID (rs.getInt ("ID"));
			final long points = rs.getLong ("points");
			if (rs.wasNull ()) {
				rec.setPoints (0L);
			} else {
				rec.setPoints (points);
			}
			rec.setRecordLoader (this);
			rec.markAsLoaded ();
			return rec;
		} catch (final SQLException e) {
			EventRecordSQLLoader.log.error ("Caught a SQLException in EventRecordSQLLoader.loadRecord ", e);
		}
		throw new NotFoundException ("Can't load " + id);
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public EventRecord loadRecord (final String identifier) throws NotFoundException {
		return loadRecord (Integer.parseInt (identifier));
	}

	@Override
	public void refresh (final EventRecord record) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final EventRecord record) {
		// TODO Auto-generated method stub brpocock@star-hope.org

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final EventRecord record) {
		if (record.getEventTypeID () < 0) {
			EventRecordSQLLoader.log.error ("Negative ID for event type?");
			return;
		}

		Connection con = null;
		PreparedStatement st = null;
		ResultSet keys = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st =
					con.prepareStatement (
							"INSERT INTO events (ID, creatorID, creationTimestamp, eventTypeID, "
									+ "points) VALUES (?,?,?,?,?) "
									+ "ON DUPLICATE KEY UPDATE "
									+ "ID=LAST_INSERT_ID(ID),creatorID=Values(creatorID),creationTimestamp=Values(creationTimestamp),"
									+ "eventTypeID=Values(eventTypeID),"
									+ "points=Values(points),medalType=Values(medalType),"
									+ "itemGained=Values(itemGained)", Statement.RETURN_GENERATED_KEYS);
			final int id = record.getID ();
			if (1 > id) {
				st.setNull (1, Types.INTEGER);
			} else {
				st.setInt (1, id);
			}
			st.setInt (2, record.getCreatorID ());
			st.setTimestamp (3, new Timestamp (record.getCreationTimestamp ()));
			st.setInt (4, record.getEventTypeID ());
			st.setBigDecimal (5, new BigDecimal (record.getPoints ()));
			st.execute ();
			if (1 > id) {
				keys = st.getGeneratedKeys ();
				keys.next ();
				record.setID (keys.getInt (1));
			}
			record.markAsSaved ();
		} catch (final SQLException e) {
			EventRecordSQLLoader.log.error ("Caught a SQLException in EventRecordSQLLoader.saveRecord", e);
		} finally {
			LibMisc.closeAll (keys, st, con);
		}
	}

}
