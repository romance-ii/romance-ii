/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 * License along with this program. If not, see <a
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
package org.starhope.appius.game.inventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * Default SQL RecordLoader for InventoryItemType
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
public class InventoryItemTypeSQLLoader implements
		RecordLoader <InventoryItemType> {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (InventoryItemTypeSQLLoader.class);
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final InventoryItemType changedRecord) {
		// Not used
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
	public InventoryItemType loadRecord (final int id)
			throws NotFoundException {
		return loadRecord (id, new InventoryItemType (this));
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param record WRITEME 
	 * @return WRITEME 
	 */
	private InventoryItemType loadRecord (final int id,
			final InventoryItemType record) {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		record.markForReload ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM itemTypes WHERE id=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			if (rs.next ()) {
				set (record, rs);
			}
			st = con.prepareStatement ("SELECT * FROM itemTypeSlots WHERE itemTypeID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			setSlots (record, rs);
			record.markAsLoaded ();
		} catch (final SQLException e) {
			InventoryItemTypeSQLLoader.log.error ("Exception", e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return record;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public InventoryItemType loadRecord (final String identifier)
			throws NotFoundException {
		java.sql.Connection con = null;
		java.sql.PreparedStatement st = null;
		java.sql.ResultSet rs = null;
		final InventoryItemType record = new InventoryItemType (this);
		record.markForReload ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM itemTypes WHERE name=?");
			st.setString (1, identifier);
			rs = st.executeQuery ();
			if (rs.next ()) {
				set (record, rs);
			}
			st = con.prepareStatement ("SELECT * FROM itemTypeSlots WHERE itemTypeID=?");
			st.setInt (1, record.getID ());
			rs = st.executeQuery ();
			setSlots (record, rs);
			record.markAsLoaded ();
		} catch (final SQLException e) {
			throw new NotFoundException (e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return record;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final InventoryItemType record) {
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final InventoryItemType record) {
		// Not used
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final InventoryItemType record) {
		// Not used
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param record WRITEME 
	 * @param rs WRITEME 
	 * @throws SQLException
	 */
	private void set (final InventoryItemType record,
			final ResultSet rs) throws SQLException {
		record.setID (rs.getInt ("id"));
		record.setName (rs.getString ("name"));
	}
	
	/**
	 * Sets the slots for the item type
	 * 
	 * @param record WRITEME 
	 * @param rs WRITEME 
	 * @throws SQLException
	 */
	private void setSlots (final InventoryItemType record,
			final ResultSet rs) throws SQLException {
		final LinkedList <ClothingSlot> list = new LinkedList <ClothingSlot> ();
		while (rs.next ()) {
			try {
				list.add (Nomenclator.getDataRecord (
						ClothingSlot.class, rs.getInt ("slotID")));
			} catch (final NotFoundException e) {
				InventoryItemTypeSQLLoader.log.error ("Exception",
						e);
			} catch (final SQLException e) {
				InventoryItemTypeSQLLoader.log.error ("Exception",
						e);
			}
		}
		record.setSlots (list.toArray (new ClothingSlot [] {}));
	}
	
}
