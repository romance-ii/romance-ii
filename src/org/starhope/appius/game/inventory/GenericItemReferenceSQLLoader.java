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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.game.inventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 */
public class GenericItemReferenceSQLLoader implements
		RecordLoader <GenericItemReference> {

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final GenericItemReference changedRecord) {
		synchronized (changedRecord) {
			DataRecordFlushManager.update (this, changedRecord);
		}
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
		// No-op, performed by AppiusConfig/JDBC
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
	public GenericItemReference loadRecord (final int id)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT * FROM items LEFT JOIN itemEffects ON items.ID=itemEffects.itemID WHERE ID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			if (rs.next ()) {
				return set (rs);
			}
		} catch (final SQLException e) {
			throw new NotFoundException (id + "/" + e.toString ());
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		throw new NotFoundException (String.valueOf (id));
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public GenericItemReference loadRecord (final String identifier)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT * FROM items LEFT JOIN itemEffects ON items.ID=itemEffects.itemID WHERE name=?");
			st.setString (1, identifier);
			rs = st.executeQuery ();
			if (rs.next ()) {
				return set (rs);
			}
		} catch (final SQLException e) {
			throw new NotFoundException (identifier + "/"
					+ e.toString ());
		} finally {
			LibMisc.closeAll (rs, st, con);
		}

		return null;
	}

	@Override
	public void refresh (final GenericItemReference record) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT * FROM items LEFT JOIN itemEffects ON items.ID=itemEffects.itemID WHERE ID=?");
			st.setInt (1, record.getItemID ());
			final ResultSet rs = st.executeQuery ();
			if (rs.next ()) {
				reload (rs, record);
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (
					"Database failed to find item ID="
							+ record.getItemID (), e);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}
	
	/**
	 * Loads the result set into the record
	 * 
	 * @param rs Result Set
	 * @param rec GenericItemReference record
	 * @return The GenericItemReference record
	 * @throws SQLException if the record can't be parsed
	 */
	private GenericItemReference reload (final ResultSet rs,
			final GenericItemReference rec) throws SQLException {
		synchronized (rec) {
		rec.markForReload ();
		rec.setItemID (rs.getInt ("ID"));
		try {
			rec.setItemType (Nomenclator.getDataRecord (
					InventoryItemType.class, rs.getInt ("itemTypeID")));
		} catch (NotFoundException e1) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a NotFoundException in GenericItemReferenceSQLLoader.reload (itemTypeID) ",
							e1);
		}
		rec.setTitle (rs.getString ("name"));
		rec.setDescription (rs.getString ("description"));
		try {
			rec.setRarity (Nomenclator.getDataRecord (
					RarityRating.class, rs.getInt ("itemRarity")));
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a NotFoundException in GenericItemReferenceSQLLoader.reload (rarity) ",
							e);
		}
		rec.setCanTrade ("Y".equals (rs.getString ("CanTrade")));
		rec.setPrice (Currency.getPeanuts (), rs.getInt ("value"));

		String equipSlotString = rs.getString ("equipSlot");
		if (equipSlotString.length () < 1) { equipSlotString = " "; }
		char equipSlot = equipSlotString.charAt (0);
		if (equipSlot < ' ' || equipSlot >= 0x7f && equipSlot <= 0xa0) {
			equipSlot = ' ';
		}
		rec.setEquipSlot (equipSlot);

        String healthTypeStr = rs.getString ("healthType");
        if (healthTypeStr.length () < 1) {
			healthTypeStr = " ";
		}
        char healthType = healthTypeStr.charAt (0);
        switch (healthType) {
        case 'C':
            rec.setHealthType (HealthType.CONTINUOUS);
            break;
        case 'D':
            rec.setHealthType (HealthType.DISCRETE);
            break;
        default:
            rec.setHealthType (HealthType.SILENT);
        }

		/*
		 * And now, check for a trailer record (for effects). Since it's
		 * created on a LEFT JOIN, this can be a null column.
		 */
		int effectsID = rs.getInt ("itemEffectsID");
		if (rs.wasNull ()) {
			effectsID = -1;
		}
		rec.setEffectsTypeID (effectsID);

		rec.markAsLoaded ();
		return rec;
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final GenericItemReference record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented RecordLoader<GenericItemReference>::removeRecord (brpocock@star-hope.org, Jul 22, 2010)");

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final GenericItemReference record) {
		Connection con = null;
		PreparedStatement st = null;
		PreparedStatement tr_st = null;
		PreparedStatement tr_rm = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("INSERT INTO items (itemTypeID, name, description, itemRarity, CanTrade, value, ID) VALUES (?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE ID=Values(ID), itemTypeID=Values(itemTypeID), name=Values(name), description=Values(description), itemRarity=Values(itemRarity), CanTrade=Values(CanTrade), value=Values(value)");
			st.setInt (1, record.getItemType ().getID ());
			st.setString (2, record.getTitle ());
			st.setString (3, record.getDescription ());
			st.setInt (4, record.getRarity ().getID ());
			st.setString (5, record.canTrade () ? "Y" : "N");
			st.setBigDecimal (6, record.getPrice ());
			st.setInt (7, record.getItemID ());
			if (st.executeUpdate () == 1) {
				record.markAsSaved ();
			}

			tr_rm = con
					.prepareStatement ("DELETE FROM itemEffects WHERE itemID=?");
			tr_rm.setInt (1, record.getItemID ());
			tr_rm.executeUpdate ();
			if (record.getEffectsTypeID () > 0) {
				tr_st = con
						.prepareStatement ("INSERT INTO itemEffects (itemID, itemEffectsID) VALUES (?,?)");
				tr_st.setInt (1, record.getItemID ());
				tr_st.setInt (2, record.getEffectsTypeID ());
				tr_st.executeUpdate ();
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (e);
		} finally {
			LibMisc.closeAll (tr_st, tr_rm, st, con);
		}

	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param rs result set
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 */
	private GenericItemReference set (final ResultSet rs)
			throws SQLException {
		final GenericItemReference itemReference = new GenericItemReference (
				this);
		return reload (rs, itemReference);
	}

}
