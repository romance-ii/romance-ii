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
package org.starhope.appius.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.inventory.GenericItemReference;
import org.starhope.appius.types.Colour;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * Load avatar class data from an SQL database backing store
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class AvatarClassSQLLoader implements RecordLoader <AvatarClass> {
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final AvatarClass changedRecord) {
		DataRecordFlushManager.update (this, changedRecord);
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
	public AvatarClass loadRecord (final int id)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement select = null;
		java.sql.ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			select = con
					.prepareStatement ("SELECT * FROM avatarClasses WHERE ID=?");
			select.setInt (1, id);
			rs = select.executeQuery ();
			return loadRecord (rs);
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a SQLException in AvatarClassSQLLoader.loadRecord ",
							e);
		} finally {
			LibMisc.closeAll (rs, select, con);
		}
		throw new NotFoundException (String.valueOf (id));
	}
	
	/**
	 * load a record (common routine shared by {@link #loadRecord(int)}
	 * , {@link #loadRecord(String)}, and {@link #refresh(AvatarClass)}
	 * 
	 * @param rs record set
	 * @return record loaded
	 * @throws SQLException if we fuck up
	 */
	private AvatarClass loadRecord (final java.sql.ResultSet rs)
			throws SQLException {
		final AvatarClass r = new AvatarClass (this);
		rs.next ();
		r.setName (rs.getString ("title"));
		r.setFilename (rs.getString ("filename"));
		r.setForFree ("Y".equals (rs.getString ("forFree")));
		r.setForPaid ("Y".equals (rs.getString ("forVIT")));
		r.setDefaultBaseColour (new Colour (rs
				.getInt ("defaultBaseColor")));
		r.setDefaultExtraColour (new Colour (rs
				.getInt ("defaultExtraColor")));
		r.setDefaultPatternColour (new Colour (rs
				.getInt ("defaultPatternColor")));
		final int patternID = rs.getInt ("defaultPatternID");
		r.setCollisionBounds (rs.getString ("collisionBounds"));
		if (rs.wasNull () || (patternID < 1)) {
			r.setDefaultPattern (null);
		} else {
			try {
				r.setDefaultPattern (Nomenclator.getDataRecord (
						GenericItemReference.class, patternID));
			} catch (final NotFoundException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a NotFoundException in AvatarClassSQLLoader.loadRecord ",
								e);
				r.setDefaultPattern (null);
			}
		}
		r.setCanColor ("Y".equals (rs.getString ("canColor")));
		final int id = rs.getInt ("ID");
		r.setID (id);
		r.setHeight (rs.getInt ("defaultHeight"));
		r.setBaseSpeed (rs.getInt ("baseSpeed"));
		try {
			r.setBodyFormat (Nomenclator.getDataRecord (
					AvatarBodyFormat.class,
					rs.getInt ("bodyFormat")));
		} catch (final NotFoundException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a NotFoundException in AvatarClassSQLLoader.loadRecord looking for Biped body format",
							e);
		}
		r.markAsLoaded ();
		return r;
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public AvatarClass loadRecord (final String identifier)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement select = null;
		java.sql.ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			select = con
					.prepareStatement ("SELECT * FROM avatarClasses WHERE title=?");
			select.setString (1, identifier);
			rs = select.executeQuery ();
			return loadRecord (rs);
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a SQLException in AvatarClassSQLLoader.loadRecord ",
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
	public void refresh (final AvatarClass record) {
		// no op
		
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final AvatarClass record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"unimplemented RecordLoader<AvatarClass>::removeRecord (brpocock@star-hope.org, Jul 22, 2010)");
	}
	
	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final AvatarClass avatarClass) {
		Connection con = null;
		PreparedStatement update = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			update = con
					.prepareStatement ("INSERT INTO avatarClasses (title,filename,forFree,forVIT,defaultBaseColor,defaultExtraColor,defaultPattern,defaultPatternColor,canColor,ID,collisionBounds) "
							+ "ON DUPLICATE KEY UPDATE avatarClasses SET title=Values(title), filename=Values(filename), "
							+ "forFree=Values(forFree), forVIT=Values(forVIT), "
							+ "defaultBaseColor=Values(defaultBaseColor), defaultExtraColor=Values(defaultExtraColor), "
							+ "defaultPattern=Values(defaultPattern), defaultPatternColor=Values(defaultPatternColor), canColor=Values(canColor) "
							+ ", ID=Values(ID), collisionBounds=Values(collisionBounds)");
			update.setString (1, avatarClass.getName ());
			update.setString (2, avatarClass.getFilename ());
			update.setString (3, avatarClass.isForFree () ? "Y"
					: "N");
			update.setString (4, avatarClass.isForPaid () ? "Y"
					: "N");
			update.setLong (5, avatarClass.getDefaultBaseColor ()
					.toLong ());
			update.setLong (6, avatarClass.getDefaultExtraColor ()
					.toLong ());
			update.setString (7, avatarClass.getDefaultPattern ()
					.toString ());
			update.setLong (8, avatarClass.getDefaultPatternColor ()
					.toLong ());
			update.setString (9, avatarClass.canColor () ? "Y" : "N");
			update.setInt (10, avatarClass.getID ());
			update.setString (11,
					avatarClass.getCollisionBounds_string ());
			update.executeUpdate ();
		} catch (final SQLException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		} finally {
			LibMisc.closeAll (update, con);
		}
	}
	
}
