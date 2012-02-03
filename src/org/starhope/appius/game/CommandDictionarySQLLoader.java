/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
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
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author ewinkelman
 */
package org.starhope.appius.game;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman
 *
 */
public class CommandDictionarySQLLoader implements
		RecordLoader <CommandDictionary> {
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2212 $";
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (CommandDictionary changedRecord) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#initializeStorage(java.lang.String)
	 */
	@Override
	public void initializeStorage (String storageURL)
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
	public CommandDictionary loadRecord (int id)
			throws NotFoundException {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public CommandDictionary loadRecord (String identifier)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement select = null;
		java.sql.ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			select = con
					.prepareStatement ("SELECT * FROM commandDictionary WHERE command=?");
			select.setString (1, identifier);
			rs = select.executeQuery ();
			return loadRecord (rs);
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught an SQLException in CommandDictionarySQLLoader.loadRecord ",
							e);
		} finally {
			LibMisc.closeAll (rs, select, con);
		}
		throw new NotFoundException (identifier);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param rs
	 * @return
	 * @throws SQLException
	 */
	private CommandDictionary loadRecord (ResultSet rs)
			throws SQLException {
		CommandDictionary result = new CommandDictionary (this);
		
		rs.next ();
		result.setCommand (rs.getString ("command"));
		result.setKlass (rs.getString ("klass"));
		
		result.markAsLoaded ();
		return result;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (CommandDictionary record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (CommandDictionary record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (CommandDictionary record) {
		record.markAsSaved ();
	}
	
}
