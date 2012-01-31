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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
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
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class CommandDictionarySQLLoader implements
		RecordLoader <CommandDictionary> {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (CommandDictionarySQLLoader.class);
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final CommandDictionary changedRecord) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
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
	public CommandDictionary loadRecord (final int id)
			throws NotFoundException {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param rs WRITEME 
	 * @return WRITEME 
	 * @throws SQLException
	 */
	private CommandDictionary loadRecord (final ResultSet rs)
			throws SQLException {
		final CommandDictionary result = new CommandDictionary (this);
		
		rs.next ();
		result.setCommand (rs.getString ("command"));
		result.setKlass (rs.getString ("klass"));
		
		result.markAsLoaded ();
		return result;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public CommandDictionary loadRecord (final String identifier)
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
			CommandDictionarySQLLoader.log
					.error ("Caught an SQLException in CommandDictionarySQLLoader.loadRecord ",
							e);
		} finally {
			LibMisc.closeAll (rs, select, con);
		}
		throw new NotFoundException (identifier);
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final CommandDictionary record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final CommandDictionary record) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final CommandDictionary record) {
		record.markAsSaved ();
	}
	
}
