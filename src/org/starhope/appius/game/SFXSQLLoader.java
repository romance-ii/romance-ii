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
 * General Public License for more details.
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
package org.starhope.appius.game;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
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
public class SFXSQLLoader implements RecordLoader <SFX> {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (SFXSQLLoader.class);
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final SFX changedRecord) {
		// Don't care
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
	public SFX loadRecord (final int id) throws NotFoundException {
		return loadRecord (id, new SFX (this));
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param id WRITEME 
	 * @param record WRITEME 
	 * @return WRITEME 
	 * @throws NotFoundException
	 */
	private SFX loadRecord (final int id, final SFX record)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement getItem = null;
		ResultSet rs = null;
		record.markForReload ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getItem = con
					.prepareStatement ("SELECT * FROM SFX WHERE ID=?");
			getItem.setInt (1, id);
			rs = getItem.executeQuery ();
			if (rs.next ()) {
				set (record, rs);
			}
			record.markAsLoaded ();
			return record;
		} catch (final SQLException e) {
			throw new NotFoundException ("SFX " + id + " not found");
		} finally {
			LibMisc.closeAll (rs, getItem, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public SFX loadRecord (final String identifier)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement getItem = null;
		ResultSet rs = null;
		final SFX record = new SFX (this);
		record.markForReload ();
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getItem = con
					.prepareStatement ("SELECT * FROM SFX WHERE name=?");
			getItem.setString (1, identifier);
			rs = getItem.executeQuery ();
			if (rs.next ()) {
				set (record, rs);
			}
			record.markAsLoaded ();
			return record;
		} catch (final SQLException e) {
			throw new NotFoundException ("SFX " + identifier
					+ " not found");
		} finally {
			LibMisc.closeAll (rs, getItem, con);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final SFX record) {
		try {
			loadRecord (record.getCacheableID (), record);
		} catch (final NotFoundException e) {
			SFXSQLLoader.log.error ("Exception", e);
		}
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final SFX record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final SFX record) {
		record.markAsSaved ();
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param record WRITEME 
	 * @param rs WRITEME 
	 * @throws SQLException
	 */
	private void set (final SFX record, final ResultSet rs)
			throws SQLException {
		record.setID (rs.getInt ("ID"));
		record.setMoniker (rs.getString ("name"));
		try {
			record.setFxInfo (new JSONObject (rs.getString ("info")));
		} catch (final JSONException e) {
			SFXSQLLoader.log.error ("Exception", e);
			record.setFxInfo (new JSONObject ());
		}
	}
	
}
