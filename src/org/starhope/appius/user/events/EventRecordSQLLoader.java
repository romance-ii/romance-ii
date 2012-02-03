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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.Collection;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.util.LibMisc;

/**
 * load an event record from the database
 * 
 * <pre>
 * ALTER TABLE events CHANGE COLUMN ID ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
 * </pre>
 * 
 * @author brpocock@star-hope.org
 */
public class EventRecordSQLLoader extends EventRecordLoader {

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
		return "$Rev: 2188 $";
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#initializeStorage(java.lang.String)
	 */
	@Override
	public void initializeStorage (final String storageURL)
			throws NotReadyException {
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
	public EventRecord loadRecord (final int id)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT * FROM events WHERE ID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			rs.next ();
			final EventRecord rec = new EventRecord ();
			final Timestamp completionTime = rs
					.getTimestamp ("completionTimestamp");
			if (rs.wasNull ()) {
				rec.setCompletionTimestamp ( -1);
			} else {
				rec.setCompletionTimestamp (completionTime);
			}
			rec.setCreationTimestamp (rs
					.getTimestamp ("creationTimestamp"));
			rec.setCreatorID (rs.getInt ("creatorID"));
			// TODO Tootsville™ specific
			final BigDecimal peanuts = rs.getBigDecimal ("peanuts");
			if (rs.wasNull ()) {
				rec.setCurrencyEarned (null, null);
			} else {
				rec.setCurrencyEarned ("x-TvPn", peanuts);
			}
			rec.setEventTypeID (rs.getInt ("eventTypeID"));
			rec.setID (rs.getInt ("ID"));
			final int itemEarned = rs.getInt ("itemGained");
			rec.setItemEarned (itemEarned);
			final long points = rs.getLong ("points");
			if (rs.wasNull ()) {
				rec.setPoints ( -1);
			} else {
				rec.setPoints (points);
			}
			rec.setRecordLoader (this);
			rec.markAsLoaded ();
			return rec;
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a SQLException in EventRecordSQLLoader.loadRecord ",
							e);
		}
		throw new NotFoundException ("Can't load " + id);
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public EventRecord loadRecord (final String identifier)
			throws NotFoundException {
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
		AppiusClaudiusCaecus
				.reportBug ("unimplemented RecordLoader<EventRecord>::removeRecord (brpocock@star-hope.org, Jul 22, 2010)");

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final EventRecord record) {
		if (record.getEventTypeID () < 0) {
			AppiusClaudiusCaecus
					.reportBug ("Negative ID for event type?");
			return;
		}

		Connection con = null;
		PreparedStatement st = null;
		ResultSet keys = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement (
							"INSERT INTO events (ID, creatorID, creationTimestamp, eventTypeID, completionTimestamp, "
									+ "points, peanuts, medalType, itemGained) VALUES (?,?,?,?,?,?,?,?,?) "
									+ "ON DUPLICATE KEY UPDATE "
									+ "ID=LAST_INSERT_ID(ID),creatorID=Values(creatorID),creationTimestamp=Values(creationTimestamp),"
									+ "eventTypeID=Values(eventTypeID),completionTimestamp=Values(completionTimestamp),"
									+ "points=Values(points),peanuts=Values(peanuts),medalType=Values(medalType),"
									+ "itemGained=Values(itemGained)",
							Statement.RETURN_GENERATED_KEYS);
			final int id = record.getID ();
			if (1 > id) {
				st.setNull (1, Types.INTEGER);
			} else {
				st.setInt (1, id);
			}
			st.setInt (2, record.getCreatorID ());
			st.setTimestamp (3, new Timestamp (record
					.getCreationTimestamp ()));
			st.setInt (4, record.getEventTypeID ());
			if (record.getCompletionTimestamp () < record
					.getCreationTimestamp ()) {
				st.setNull (5, Types.TIMESTAMP);
			} else {
				st.setTimestamp (5, new Timestamp (record
						.getCompletionTimestamp ()));
			}
			st.setBigDecimal (6, new BigDecimal (record.getPoints ()));
			// XXX if (record.getCurrencyEarned ().equals
			// (Currency.getPeanuts ()))
			st.setBigDecimal (7, record.getCurrencyAmountEarned ());
			final Collection <MedalType> medalsEarned = record
					.getMedalsEarned ();
			if (medalsEarned.size () == 0) {
				st.setNull (8, Types.INTEGER);
			} else {
				st
						.setInt (8, medalsEarned.iterator ().next ()
								.getID ());
			}
			if (record.getItemEarned () < 1) {
				st.setNull (9, Types.INTEGER);
			} else {
				st.setInt (9, record.getItemEarned ());
			}
			st.execute ();
			if (1 > id) {
				keys = st.getGeneratedKeys ();
				keys.next ();
				record.setID (keys.getInt (1));
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a SQLException in EventRecordSQLLoader.saveRecord; itemEarned = "
									+ record.getItemEarned (), e);
		} finally {
			LibMisc.closeAll (keys, st, con);
		}
	}

}
