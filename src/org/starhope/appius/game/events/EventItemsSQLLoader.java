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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map.Entry;



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.HasSubversionRevision;
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class EventItemsSQLLoader implements HasSubversionRevision, RecordLoader <EventItems> {
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (EventItemsSQLLoader.class);

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final EventItems changedRecord) {
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
		// TODO Auto-generated method stub
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
	public EventItems loadRecord (final int id) throws NotFoundException {
		final EventItems record = new EventItems (this);
		record.setEventID (id);
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		record.markForReload ();

		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM eventItems WHERE eventID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			set (record, rs);
		} catch (SQLException e) {
			EventItemsSQLLoader.log.error ("Caught a SQLException in EventTypeSQLLoader.loadRecord " + id, e);
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
	public EventItems loadRecord (final String identifier) throws NotFoundException {
		throw new NotFoundException ("Event Items are not able to be loaded by moniker");
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final EventItems record) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final EventItems record) {
		// TODO Auto-generated method stub

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final EventItems record) {
		if (record.getEventID () < 0) {
			record.markAsSaved ();
			return;
		}
		Connection con = null;
		PreparedStatement st = null;
		ResultSet keys = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st =
					con.prepareStatement ("INSERT INTO eventItems (eventID, realItemID, count) VALUES (?,?,?) "
							+ "ON DUPLICATE KEY UPDATE count=Values(count)");
			for (Entry <RealItem, Integer> entry : record.getItems ().entrySet ()) {
				st.setInt (1, record.getEventID ());
				st.setInt (2, entry.getKey ().getRealID ());
				st.setInt (3, entry.getValue ().intValue ());
				st.execute ();
			}
			record.markAsSaved ();
		} catch (final SQLException e) {
			EventItemsSQLLoader.log.error ("Caught a SQLException in EventRecordSQLLoader.saveRecord", e);
		} finally {
			LibMisc.closeAll (keys, st, con);
		}
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param record WRITEME 
	 * @param rs WRITEME 
	 * @throws SQLException
	 */
	private void set (final EventItems record, final ResultSet rs) throws SQLException {
		while (rs.next ()) {
			try {
				final RealItem item = Nomenclator.getDataRecord (RealItem.class, rs.getInt ("realItemID"));
				record.addItem (item, rs.getInt ("count"));
			} catch (SQLException e) {
				EventItemsSQLLoader.log.error ("Exception", e);
			} catch (NotFoundException e) {
				EventItemsSQLLoader.log.error ("Exception", e);
			}
		}
	}

}
