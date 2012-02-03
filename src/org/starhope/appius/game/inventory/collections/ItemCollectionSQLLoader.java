/**
 * <p>
 * Copyright © 2010, Tim Heys
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
 * @author twheys@gmail.com
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.game.inventory.collections;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.inventory.GenericItemReference;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.events.EventType;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 *
 * <pre>
 * CREATE TABLE itemCollections (
 *   ID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 *   title VARCHAR(32) NOT NULL UNIQUE KEY,
 *   onBreak INT NULL,
 *   CONSTRAINT FOREIGN KEY (onBreak) REFERENCES eventTypes (ID),
 *   onComplete INT NULL,
 *   CONSTRAINT FOREIGN KEY (onComplete) REFERENCES eventTypes (ID)
 * ) ENGINE=InnoDB;
 * </pre>
 *
 * @author brpocock@star-hope.org
 */
public class ItemCollectionSQLLoader implements
		RecordLoader <ItemCollection> {

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final ItemCollection changedRecord) {
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
		// AppiusConfig does this; no-op.
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
	public ItemCollection loadRecord (final int id)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement headerSt = null;
		PreparedStatement listSt = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			headerSt = con
					.prepareStatement ("SELECT * FROM itemCollections WHERE ID=?");
			headerSt.setInt (1, id);
			listSt = con
					.prepareStatement ("SELECT itemID FROM itemCollectionItems WHERE collectionID=?");
			listSt.setInt (1, id);
			return set (headerSt, listSt);
		} catch (final SQLException e) {
			throw new NotFoundException (e.toString ());
		} finally {
			LibMisc.closeAll (listSt, headerSt, con);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public ItemCollection loadRecord (final String identifier)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement headerSt = null;
		PreparedStatement listSt = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			headerSt = con
					.prepareStatement ("SELECT * FROM itemCollections WHERE title=?");
			headerSt.setString (1, identifier);
			listSt = con
					.prepareStatement ("SELECT itemID FROM itemCollectionItems WHERE collectionID=(SELECT ID FROM itemCollections WHERE title=?)");
			listSt.setString (1, identifier);
			return set (headerSt, listSt);
		} catch (final SQLException e) {
			throw new NotFoundException (e.toString ());
		} finally {
			LibMisc.closeAll (listSt, headerSt, con);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final ItemCollection record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus.reportBug("unimplemented RecordLoader<ItemCollection>::removeRecord (brpocock@star-hope.org, Jul 22, 2010)");

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final ItemCollection record) {
		// TODO Auto-generated method stub brpocock@star-hope.org

	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param selectHeader WRITEME
	 * @param selectItems WRITEME
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 */
	public ItemCollection set (final PreparedStatement selectHeader,
			final PreparedStatement selectItems) throws SQLException {
		ResultSet header = null;
		ResultSet items = null;
		try {
			final ItemCollection r = new ItemCollection (this);
			header = selectHeader.executeQuery ();
			header.next ();
			r.setTitle (header.getString ("title"));
			r.setOnBreakEvent (Nomenclator.getDataRecord (EventType.class, header
					.getInt ("onBreak")));
			r.setOnCompleteEvent (Nomenclator.getDataRecord(EventType.class,
					header.getInt ("onComplete")));
			items = selectItems.executeQuery ();
			while (items.next ()) {
				try {
					r.add (Nomenclator.getDataRecord (GenericItemReference.class,
							items.getInt ("itemID")));
				} catch (final NotFoundException e) {
					AppiusClaudiusCaecus
							.reportBug (
									"Caught a NotFoundException in ItemCollectionSQLLoader.set ",
									e);
				}
			}
			return r;
		} catch (final SQLException e) {
			throw e;
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus.reportBug ("Caught a NotFoundException in ItemCollectionSQLLoader.set ", e);
		} finally {
			LibMisc.closeAll (header, items);
		}
		return null;
	}

    @Override
    public void refresh (ItemCollection record) {
        // TODO Auto-generated method stub
        
    }

}
