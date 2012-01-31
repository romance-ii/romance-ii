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
 * General Public License for more details.
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
 */
package org.starhope.appius.game.inventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * Default SQL RecordLoader for InventoryItemType
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class InventoryItemTypeSQLLoader implements
		RecordLoader <InventoryItemType> {
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final InventoryItemType changedRecord) {
		DataRecordFlushManager.update (this, changedRecord);
	}
	
	/**
	 * common code for {@link #loadRecord(int)} and
	 * {@link #loadRecord(String)}
	 * 
	 * @param rs the result set
	 * @return the item type described by it
	 * @throws SQLException if the record can't be parsed
	 */
	private InventoryItemType get (final java.sql.ResultSet rs)
			throws SQLException {
		rs.next ();
		InventoryItemType type = new InventoryItemType (this);
		type.setID (rs.getInt ("id"));
		type.setName (rs.getString ("name"));
		type.markAsLoaded ();
		return type;
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
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT id, name FROM itemTypes WHERE id=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			return get (rs);
		} catch (SQLException e) {
			throw new NotFoundException (e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
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
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT id, name FROM itemTypes WHERE name=?");
			st.setString (1, identifier);
			rs = st.executeQuery ();
			return get (rs);
		} catch (SQLException e) {
			throw new NotFoundException (e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final InventoryItemType record) {
		java.sql.Connection con = null;
		java.sql.PreparedStatement st = null;
		java.sql.ResultSet rs = null;
		record.markForReload ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT id, name FROM itemTypes WHERE id=?");
			st.setInt (1, record.getID ());
			rs = st.executeQuery ();
			InventoryItemType clone = get (rs);
			record.setName (clone.getName ());
		} catch (SQLException e) {
			AppiusClaudiusCaecus.fatalBug (e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final InventoryItemType record) {
		java.sql.Connection con = null;
		java.sql.PreparedStatement st = null;
		java.sql.ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("DELETE FROM itemTypes WHERE id=?");
			st.setInt (1, record.getID ());
			st.executeUpdate ();
		} catch (SQLException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final InventoryItemType record) {
		// AppiusClaudiusCaecus
		// .reportBug
		// ("unimplemented InventoryItemTypeSQLLoader::saveRecord (brpocock@star-hope.org, Sep 16, 2010)");
		System.err.println ("Not saving InventoryItemType record change");
	}
	
}
