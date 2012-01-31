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
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.starhope.appius.except.NonSufficientItemsException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
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
public class UserInventorySQLLoader implements
		RecordLoader <UserInventory> {
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final UserInventory changedRecord) {
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
	public UserInventory loadRecord (final int id)
			throws NotFoundException {
		return loadRecord (id, new UserInventory (this));
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param id WRITEME 
	 * @param record WRITEME 
	 * @return WRITEME 
	 * @throws NotFoundException
	 */
	private UserInventory loadRecord (final int id,
			final UserInventory record) throws NotFoundException {
		Connection con = null;
		PreparedStatement getItem = null;
		ResultSet rs = null;
		record.markForReload ();
		if (record.getUserID () < 0) {
			record.setUserID (id);
		}
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getItem = con
					.prepareStatement ("SELECT * FROM userInventory WHERE userID=?");
			getItem.setInt (1, id);
			rs = getItem.executeQuery ();
			set (record, rs);
			getItem = con
					.prepareStatement ("SELECT * FROM userEquippedInv WHERE userID=?");
			getItem.setInt (1, id);
			rs = getItem.executeQuery ();
			setEquipped (record, rs);
		} catch (final SQLException e) {
			throw new NotFoundException ("UserInventory " + id
					+ " not found");
		} finally {
			LibMisc.closeAll (rs, getItem, con);
		}
		record.markAsLoaded ();
		return record;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public UserInventory loadRecord (final String identifier)
			throws NotFoundException {
		try {
			return loadRecord (Integer.valueOf (identifier)
					.intValue ());
		} catch (final NumberFormatException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
			throw new NotFoundException (
					"Cannot find user inventory with string identifier of "
							+ identifier);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final UserInventory record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final UserInventory record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final UserInventory record) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("INSERT INTO userInventory (userID, realItemID, count) VALUES (?,?,?) ON DUPLICATE KEY UPDATE count=Values(count)");
			st.setInt (1, record.getUserID ());
			final Map <RealItem, Integer> changedItems = record
					.getAndClearModifiedItems ();
			for (final Entry <RealItem, Integer> entry : changedItems
					.entrySet ()) {
				st.setInt (2, entry.getKey ().getRealID ());
				st.setInt (3, entry.getValue ().intValue ());
				st.execute ();
			}
			st = con.prepareStatement ("delete from userEquippedInv where userID=? and realItemID=?");
			st.setInt (1, record.getUserID ());
			final Set <RealItem> unequippedItems = record
					.getAndClearUnequippedItems ();
			for (final RealItem realItem : unequippedItems) {
				st.setInt (2, realItem.getRealID ());
				st.execute ();
			}
			st = con.prepareStatement ("INSERT IGNORE INTO userEquippedInv (userID, realItemID) VALUES (?,?)");
			st.setInt (1, record.getUserID ());
			final Set <RealItem> equippedItems = record
					.getEquippedItems ();
			for (final RealItem realItem : equippedItems) {
				st.setInt (2, realItem.getRealID ());
				st.execute ();
			}
			
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		} finally {
			LibMisc.closeAll (st, con);
		}
		record.markAsSaved ();
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param record WRITEME 
	 * @param rs WRITEME 
	 * @throws SQLException
	 */
	private void set (final UserInventory record, final ResultSet rs)
			throws SQLException {
		while (rs.next ()) {
			try {
				record.setItem (
						Nomenclator.getDataRecord (
								RealItem.class,
								rs.getInt ("realItemID")), rs
								.getInt ("count"));
			} catch (final NotFoundException e) {
				BugReporter.getReporter ("srv").reportBug (
						"Exception", e);
			}
		}
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param record WRITEME 
	 * @param rs WRITEME 
	 * @throws SQLException
	 */
	private void setEquipped (final UserInventory record,
			final ResultSet rs) throws SQLException {
		while (rs.next ()) {
			try {
				record.equip (Nomenclator.getDataRecord (
						RealItem.class, rs.getInt ("realItemID")));
			} catch (final NonSufficientItemsException e) {
				BugReporter.getReporter ("srv").reportBug (
						"Exception", e);
			} catch (final NotFoundException e) {
				BugReporter.getReporter ("srv").reportBug (
						"Exception", e);
			}
		}
	}
	
}
