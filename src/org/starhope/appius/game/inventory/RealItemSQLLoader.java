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
import java.sql.Statement;
import java.sql.Types;
import java.util.Iterator;
import java.util.Map.Entry;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.BugReporter;
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
public class RealItemSQLLoader implements RecordLoader <RealItem> {
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final RealItem changedRecord) {
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
	public RealItem loadRecord (final int id) throws NotFoundException {
		final RealItem result = new RealItem (this);
		loadRecord (id, result);
		return result;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param id WRITEME 
	 * @param record WRITEME 
	 * @return WRITEME 
	 * @throws NotFoundException
	 */
	private RealItem loadRecord (final int id, final RealItem record)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement getItem = null;
		ResultSet rs = null;
		record.markForReload ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getItem = con
					.prepareStatement ("SELECT * FROM realItems WHERE realID=?");
			getItem.setInt (1, id);
			rs = getItem.executeQuery ();
			if (rs.next ()) {
				set (record, rs);
			}
			record.markAsLoaded ();
			return record;
		} catch (final SQLException e) {
			throw new NotFoundException ("RealID " + id
					+ " not found");
		} finally {
			LibMisc.closeAll (rs, getItem, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public RealItem loadRecord (final String identifier)
			throws NotFoundException {
		return loadRecord (Integer.valueOf (identifier).intValue ());
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final RealItem record) {
		try {
			loadRecord (record.getRealID (), record);
		} catch (final NotFoundException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final RealItem record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final RealItem record) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement (
					"INSERT INTO items (realID, itemID, attributes) VALUES (?,?,?) ON DUPLICATE KEY UPDATE itemID=Values(itemID), attributes=Values(attributes)",
					Statement.RETURN_GENERATED_KEYS);
			if (record.getRealID () == -1) {
				st.setNull (1, Types.INTEGER);
			} else {
				st.setInt (1, record.getRealID ());
			}
			st.setInt (2, record.getItemID ());
			final JSONObject jsonObject = new JSONObject ();
			for (final Entry <String, String> entry : record
					.getAttributes ().entrySet ()) {
				try {
					jsonObject.put (entry.getKey (),
							entry.getValue ());
				} catch (final JSONException e) {
					BugReporter.getReporter ("srv").reportBug (
							"Exception", e);
				}
			}
			st.setString (3, jsonObject.toString ());
			if (st.execute ()) {
				if (record.getRealID () < 0) {
					final ResultSet keys = st.getGeneratedKeys ();
					keys.next ();
					record.setRealID (keys.getInt (1));
				}
				record.markAsSaved ();
			}
			
		} catch (final SQLException e) {
			RealItemSQLLoader.log.error ("Exception", e);
		} finally {
			LibMisc.closeAll (st, con);
		}
		
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param record WRITEME 
	 * @param rs WRITEME 
	 * @throws SQLException
	 */
	private void set (final RealItem record, final ResultSet rs)
			throws SQLException {
		record.setItemID (rs.getInt ("itemID"));
		record.setRealID (rs.getInt ("realID"));
		try {
			final JSONObject attributes = new JSONObject (
					rs.getString ("attributes"));
			record.clearAttributes ();
			for (final Iterator <?> iterator = attributes.keys (); iterator
					.hasNext ();) {
				final String key = (String) iterator.next ();
				record.setAttribute (key,
						attributes.getString (key));
			}
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		}
		try {
			final String klassString = rs.getString ("powerClass");
			if (klassString != null) {
				final Object powerFactory = Class.forName (
						klassString).newInstance ();
				if (powerFactory instanceof Power.Factory) {
					record.setItemPowers ( ((Power.Factory) powerFactory)
							.create (new PowerItemInfoImpl (
									record)));
				}
			}
		} catch (final ClassNotFoundException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		} catch (final IllegalArgumentException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		} catch (final SecurityException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		} catch (final InstantiationException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		} catch (final IllegalAccessException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		}
		
	}
	
}
