/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
package org.starhope.appius.game.inventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.types.Colour;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 */
public class InventoryItemSQLLoader implements
RecordLoader <InventoryItem> {
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public InventoryItemSQLLoader () {
		// no op
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final InventoryItem changedRecord) {
		saveRecord (changedRecord);
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
		// no op
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param record WRITEME
	 */
	private void insertSQL (final InventoryItem record) {
		if (null == record.owner || 1 > record.getOwnerID ()) return;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet newSlot = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement (
					"INSERT INTO inventory (userID, itemID, isActive, color, x, y, z, health, facing) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
					Statement.RETURN_GENERATED_KEYS);
			st.setInt (1, record.owner.getUserID ());
			st.setInt (2, record.getItemID ());
			st.setString (3, record.isActive () ? "Y" : "N");
			final Colour color = record.getColor ();
			if (null == color) {
				st.setNull (4, Types.INTEGER);
			} else {
				st.setInt (4, color.toInt ());
			}
			st.setInt (5, (int) record.getX ());
			st.setInt (6, (int) record.getY ());
			st.setInt (7, (int) record.getZ ());
			st.setBigDecimal (8, record.getHealth ());
			final String facing = record.getFacing ();
			if (null == facing) {
				st.setNull (9, Types.VARCHAR);
			} else {
				st.setString (9, facing);
			}
			st.execute ();
			newSlot = st.getGeneratedKeys ();
			if (newSlot.next ()) {
				record.setSlotNumber (newSlot.getInt (1));
				// if (record.getOwner () instanceof GeneralUser) {
				// ((User) record.getOwner ())
				// .blog (" new inventory slot # "
				// + record.getSlotNumber ());
				// }
			}
			record.markAsSaved ();
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (e);
		} finally {
			LibMisc.closeAll (newSlot, st, con);
		}
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
	public InventoryItem loadRecord (final int id)
	throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement ("SELECT * FROM inventory LEFT JOIN items ON items.ID=inventory.itemID WHERE slot=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			if ( !rs.next ()) throw new NotFoundException (String.valueOf (id));
			final InventoryItem record = new InventoryItem (this);
			record.setOwnerID (rs.getInt ("userID"));
			record.setItemID (rs.getInt ("itemID"));
			record.setSlotNumber (rs.getInt ("slot"));
			final int colour = rs.getInt ("color");
			if (rs.wasNull ()) {
				record.setColour (0, null);
			} else {
				record.setColour (0, new Colour (colour));
			}
			int x = rs.getInt ("x");
			if (rs.wasNull ()) {
				x = Integer.MIN_VALUE;
			}
			record.setX (x);
			int y = rs.getInt ("y");
			if (rs.wasNull ()) {
				y = Integer.MIN_VALUE;
				record.setZ (Integer.MIN_VALUE);
				record.setRoomNumber ( -1); // XXX
			} else {
				record.setZ (0);
				record.setRoomNumber (0);
			}
			record.setY (y);
			record.setTypeID (rs.getInt ("itemTypeID"));
			final String facing = rs.getString ("facing");
			if (rs.wasNull ()) {
				record.setFacing (null);
			} else {
				record.setFacing (facing);
			}

			record.setHealth (rs.getBigDecimal ("health"));

			record.markAsLoaded ();

			// THIS MUST BE LAST, because it may fire an event
			record.setActive ("Y".equals (rs.getString ("isActive")));
			return record;
		} catch (final SQLException e) {
			throw new NotFoundException (e.getMessage ());
		} catch (final GameLogicException e) {
			AppiusClaudiusCaecus
			.reportBug (
					"Caught a GameLogicException in InventoryItemSQLLoader.loadRecord ",
					e);
			throw new NotFoundException (e.getMessage ());
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public InventoryItem loadRecord (final String identifier)
	throws NotFoundException {
		try {
			return loadRecord (Integer.parseInt (identifier));
		} catch (final NumberFormatException e) {
			throw new NotFoundException (LibMisc.stringify (e));
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final InventoryItem record) {
		// TODO Auto-generated method stub
		AppiusClaudiusCaecus.blather ("Not reloading InventoryItem "
				+ record.toString ());
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final InventoryItem record) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement ("DELETE FROM inventory WHERE slot=?");
			st.setInt (1, record.getID ());
			st.executeUpdate ();
			record.markAsSaved ();
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (e);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final InventoryItem record) {
		if (null == record.owner || 1 > record.getOwnerID ()) throw AppiusClaudiusCaecus
		.fatalBug ("Can't store to inventory without knowing who the owner is, owner is "
				+ (null == record.owner ? "null!"
						: record.owner.getDebugName ()));
		if (record.getSlotNumber () > 0) {
			updateSQL (record);
		} else {
			insertSQL (record);
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param record WRITEME
	 */
	private void updateSQL (final InventoryItem record) {

		if (null == record.owner || 1 > record.owner.getUserID ()) {
			AppiusClaudiusCaecus
			.reportBug ("Can't update inventory item without an owner");
			return;
		}

		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
			.prepareStatement ("UPDATE inventory SET userID=?, itemID=?, isActive=?, color=?, x=?, y=?, facing=?, health=?, z=? WHERE slot=?");
			st.setInt (1, record.owner.getUserID ());
			st.setInt (2, record.getID ());
			st.setString (3, record.isActive () ? "Y" : "N");
			final Colour color = record.getColor ();
			if (null == color) {
				st.setNull (4, Types.INTEGER);
			} else {
				st.setInt (4, color.toInt ());
			}
			st.setInt (5, (int) record.getX ());
			st.setInt (6, (int) record.getY ());
			final String facing = record.getFacing ();
			if (null == facing) {
				st.setNull (7, Types.VARCHAR);
			} else {
				st.setString (7, facing);
			}
			st.setBigDecimal (8, record.getHealth ());
			st.setInt (9, (int) record.getZ ());
			st.setInt (10, record.getSlotNumber ());
			st.executeUpdate ();
			record.markAsSaved ();
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (e);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}

}
