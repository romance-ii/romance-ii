/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.game;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 * 
 * @author brpocock@star-hope.org
 * @param <T> the data record class
 * @param <L> the child class
 */
public abstract class SimpleDataEnumSQLLoader <T extends SimpleDataEnum <?>, L extends SimpleDataEnumSQLLoader <T, ?>>
		implements RecordLoader <T> {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final String tableName;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final String idColumn;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final String nameColumn;

	/**
	 * Constructor to be used by child classes
	 * 
	 * @param theTableName SQL table name
	 * @param theIDColumnName integer ID column name
	 * @param theNameColumnName the enumerated value's column name
	 */
	protected SimpleDataEnumSQLLoader (final String theTableName,
			final String theIDColumnName, final String theNameColumnName) {
		this.tableName = theTableName;
		this.idColumn = theIDColumnName;
		this.nameColumn = theNameColumnName;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final T changedRecord) {
		DataRecordFlushManager.update (this, changedRecord);
	}

	/**
	 * @return the klass
	 */
	protected abstract Class <T> getRecordClass () ;

	/**
	 * @return the child
	 */
	protected abstract Class <L> getRecordLoaderImplClass ();

	/**
	 * @return a new instance of the record type
	 * @throws NotFoundException if the class can't be loaded or doesn't
	 *             have
	 */
	private T getRecordObject () throws NotFoundException {
		T o;
		try {
			o = getRecordClass ().getConstructor (RecordLoader.class)
					.newInstance (this);
		} catch (Exception e) {
			AppiusClaudiusCaecus.reportBug (
					"Can't instantiate record ("
							+ getRecordClass ().getCanonicalName ()
							+ " for RecordLoader.class, which will be "
							+ getRecordLoaderImplClass ()
									.getCanonicalName () + ")", e);
			throw new NotFoundException (e);
		}
		return o;
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
		// No op
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
	public T loadRecord (final int id) throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM " + tableName
					+ " WHERE " + idColumn + " = ?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			T o = getRecordObject ();
			loadRecord (o, rs);
			return o;
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
	public T loadRecord (final String identifier)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM " + tableName + " WHERE " + nameColumn +" = ?");
			st.setString (1, identifier);
			rs = st.executeQuery ();
			T o = getRecordObject ();
			loadRecord (o, rs);
			return o;
	} catch (SQLException e) {
			throw new NotFoundException (e);
		}		finally { LibMisc.closeAll (rs,st,con); }
	}

	/**
	 * @param o the record object to be loaded into
	 * @param rs result set from a query
	 * @throws SQLException if there is a database record format error
	 */
	private void loadRecord (final T o, final ResultSet rs) throws SQLException {
		rs.next ();
		o.setID (rs.getInt (idColumn));
		o.setName (rs.getString (nameColumn));
		o.markAsLoaded ();
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final T record) {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM " + tableName
					+ " WHERE " + idColumn + " = ?");
			st.setInt (1, record.getID ());
			rs = st.executeQuery ();
			record.markForReload ();
			loadRecord (record, rs);
		} catch (SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a SQLException in SimpleDataEnumSQLLoader.refresh ",
							e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final T record) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("DELETE FROM " + tableName
					+ " WHERE " + idColumn + " = ?");
			st.setInt (1, record.getID ());
			st.executeUpdate ();
		} catch (SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a SQLException in SimpleDataEnumSQLLoader.refresh ",
							e);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final T record) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("DELETE FROM " + tableName
					+ " WHERE " + idColumn + " = ?");
			st.setInt (1, record.getID ());
			st.executeUpdate ();
		} catch (SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a SQLException in SimpleDataEnumSQLLoader.refresh ",
							e);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}

}
