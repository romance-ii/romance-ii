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
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecordSet;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class InventorySQLLoader implements
		RecordLoader <SimpleDataRecordSet <InventoryItem, Inventory>> {
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (
			final SimpleDataRecordSet <InventoryItem, Inventory> changedRecord) {
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
	 * <p>
	 * Load a player's inventory from the database in an awkward (but
	 * functional) manner.
	 * </p>
	 * <p>
	 * Note that inventories are auto-vivified if not found. This
	 * loader will <em>not</em> return a {@link NotFoundException}
	 * </p>
	 * 
	 * @return an inventory for the user
	 */
	@Override
	public Inventory loadRecord (final int userID) {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT slot FROM inventory WHERE userID=?");
			Inventory inventory;
			st.setInt (1, userID);
			rs = st.executeQuery ();
			inventory = new Inventory (this);
			inventory.setOwnerID (userID);
			final List <Integer> slots = new LinkedList <Integer> ();
			while (rs.next ()) {
				slots.add (Integer.valueOf (rs.getInt ("slot")));
			}
			for (final Integer slot : slots) {
				try {
					inventory.add (Nomenclator.getDataRecord (
							InventoryItem.class,
							slot.intValue ()));
				} catch (final NotFoundException e) {
					BugReporter
							.getReporter ("srv")
							.reportBug (
									"Caught a NotFoundException in InventorySQLLoader.loadRecord ",
									e);
				}
			}
			inventory.markAsLoaded ();
			return inventory;
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a SQLException in Inventory.fetch ",
							e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		final Inventory inventory = new Inventory (this);
		inventory.setOwnerID (userID);
		return inventory;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public SimpleDataRecordSet <InventoryItem, Inventory> loadRecord (
			final String identifier) throws NotFoundException {
		throw new NotFoundException (
				"Inventory items don't load using string identifiers");
	}
	
	@Override
	public void refresh (
			final SimpleDataRecordSet <InventoryItem, Inventory> record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (
			final SimpleDataRecordSet <InventoryItem, Inventory> record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented RecordLoader<SimpleDataRecordSet<InventoryItem,Inventory>>::removeRecord (brpocock@star-hope.org, Jul 26, 2010)");
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (
			final SimpleDataRecordSet <InventoryItem, Inventory> record) {
		int id;
		try {
			id = record.getCacheableID ();
		} catch (final NotFoundException e) {
			return;
		}
		final Iterator <InventoryItem> i = record.iterator ();
		while (i.hasNext ()) {
			i.next ().setOwnerID (id);
		}
	}
	
}
