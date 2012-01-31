/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public
 * License along with this program. If not, see
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
package org.starhope.appius.game.inventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.BugReporter;
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ClothingSlotSQLLoader implements
		RecordLoader <ClothingSlot> {
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final ClothingSlot changedRecord) {
		// TODO Auto-generated method stub
		
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
	public void initializeStorage (final String storageURL)
			throws NotReadyException {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#isRealtime()
	 */
	@Override
	public boolean isRealtime () {
		// TODO Auto-generated method stub
		return false;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
	 */
	@Override
	public ClothingSlot loadRecord (final int id)
			throws NotFoundException {
		return loadRecord (id, new ClothingSlot (this));
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param id WRITEME 
	 * @param record WRITEME 
	 * @return WRITEME 
	 * @throws NotFoundException
	 */
	private ClothingSlot loadRecord (final int id,
			final ClothingSlot record) throws NotFoundException {
		Connection con = null;
		PreparedStatement getItem = null;
		ResultSet rs = null;
		record.markForReload ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getItem = con
					.prepareStatement ("SELECT * FROM clothingSlots WHERE slotID=?");
			getItem.setInt (1, id);
			rs = getItem.executeQuery ();
			if (rs.next ()) {
				set (record, rs);
			}
			record.markAsLoaded ();
		} catch (final SQLException e) {
			throw new NotFoundException ("SlotID " + id
					+ " not found");
		} catch (final Throwable e) {
			BugReporter.getReporter ("srv").reportBug (
					"ClothingSlot load error", e);
		} finally {
			LibMisc.closeAll (rs, getItem, con);
		}
		return record;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public ClothingSlot loadRecord (final String identifier)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement getItem = null;
		ResultSet rs = null;
		final ClothingSlot record = new ClothingSlot (this);
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getItem = con
					.prepareStatement ("SELECT * FROM clothingSlots WHERE name=?");
			getItem.setString (1, identifier);
			rs = getItem.executeQuery ();
			if (rs.next ()) {
				set (record, rs);
			}
		} catch (final SQLException e) {
			throw new NotFoundException ("Slot " + identifier
					+ " not found");
		} catch (final Throwable e) {
			BugReporter.getReporter ("srv").reportBug (
					"ClothingSlot load error", e);
		} finally {
			LibMisc.closeAll (rs, getItem, con);
		}
		return record;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final ClothingSlot record) {
		try {
			loadRecord (record.getSlotID (), record);
		} catch (final NotFoundException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final ClothingSlot record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final ClothingSlot record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param record WRITEME
	 * @param rs WRITEME
	 * @throws SQLException WRITEME
	 */
	private void set (final ClothingSlot record, final ResultSet rs)
			throws SQLException {
		record.setSlotID (rs.getInt ("slotID"));
		record.setName (rs.getString ("name"));
		record.setMaxEquipable (rs.getInt ("maxEquipable"));
	}
	
}
