/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2009-2010, Res Interactive, LLC
 * </p>
 * <p>
 * Based upon public domain sample code provided by Authorize.net
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 */

package org.starhope.appius.test;

import java.sql.Array;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.NClob;
import java.sql.PreparedStatement;
import java.sql.SQLClientInfoException;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.sql.SQLXML;
import java.sql.Savepoint;
import java.sql.Statement;
import java.sql.Struct;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.starhope.appius.util.AppiusConfig;

/**
 * WRITEME: Document this type. twheys@gmail.com Jan 4, 2010
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys Timothy W. Heys
 */
public class ConnectionDebug implements Connection {
	
	/**
	 *
	 */
	private static int connectionCounter = 0;
	
	/**
	 *
	 */
	private static int openConnectionCounter = 0;
	
	/**
	 *
	 */
	private static Map <Integer, String> openConnections = new HashMap <Integer, String> ();
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 4, 2010
	 * </pre>
	 * 
	 * TO dumpOpenConnections WRITEME...
	 */
	public static void dumpOpenConnections () {
		if ( (null == ConnectionDebug.openConnections)
				|| !AppiusConfig
						.getConfigBoolOrFalse ("org.starhope.appius.test.ConnectionDebug")) {
			return;
		}
		if (ConnectionDebug.openConnections.isEmpty ()) {
			log.debug ("ConnectionDebug: no open connections");
			return;
		}
		log.debug ("ConnectionDebug:/");
		for (final String value : ConnectionDebug.openConnections
				.values ()) {
			log.debug ("ConnectionDebug::" + value);
		}
		log.debug ("ConnectionDebug:\\");
	}
	
	/**
	 *
	 */
	String caller;
	
	/**
	 *
	 */
	private final Connection realConnection;
	
	/**
	 *
	 */
	private final int serial;
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 4, 2010
	 * </pre>
	 * 
	 * A ConnectionDebug WRITEME...
	 * 
	 * @param con WRITEME
	 */
	public ConnectionDebug (final Connection con) {
		ConnectionDebug.openConnectionCounter++ ;
		serial = ConnectionDebug.connectionCounter++ ;
		caller = getCallerFromTrace ();
		ConnectionDebug.openConnections.put (
				Integer.valueOf (serial), caller);
		realConnection = con;
	}
	
	/**
	 * @see java.sql.Connection#clearWarnings()
	 */
	@Override
	public void clearWarnings () throws SQLException {
		realConnection.clearWarnings ();
	}
	
	/**
	 * @see java.sql.Connection#close()
	 */
	@Override
	public void close () throws SQLException {
		ConnectionDebug.openConnectionCounter-- ;
		ConnectionDebug.openConnections.remove (Integer
				.valueOf (serial));
		realConnection.close ();
	}
	
	/**
	 * @see java.sql.Connection#commit()
	 */
	@Override
	public void commit () throws SQLException {
		realConnection.commit ();
	}
	
	/**
	 * @see java.sql.Connection#createArrayOf(java.lang.String,
	 *      java.lang.Object[])
	 */
	@Override
	public Array createArrayOf (final String typeName,
			final Object [] elements) throws SQLException {
		return realConnection.createArrayOf (typeName, elements);
	}
	
	/**
	 * @see java.sql.Connection#createBlob()
	 */
	@Override
	public Blob createBlob () throws SQLException {
		return realConnection.createBlob ();
	}
	
	/**
	 * @see java.sql.Connection#createClob()
	 */
	@Override
	public Clob createClob () throws SQLException {
		return realConnection.createClob ();
	}
	
	/**
	 * @see java.sql.Connection#createNClob()
	 */
	@Override
	public NClob createNClob () throws SQLException {
		return realConnection.createNClob ();
	}
	
	/**
	 * @see java.sql.Connection#createSQLXML()
	 */
	@Override
	public SQLXML createSQLXML () throws SQLException {
		return realConnection.createSQLXML ();
	}
	
	/**
	 * @see java.sql.Connection#createStatement()
	 */
	@Override
	public Statement createStatement () throws SQLException {
		return realConnection.createStatement ();
		
	}
	
	/**
	 * @see java.sql.Connection#createStatement(int, int)
	 */
	@Override
	public Statement createStatement (final int resultSetType,
			final int resultSetConcurrency) throws SQLException {
		return realConnection.createStatement (resultSetType,
				resultSetConcurrency);
	}
	
	/**
	 * @see java.sql.Connection#createStatement(int, int, int)
	 */
	@Override
	public Statement createStatement (final int resultSetType,
			final int resultSetConcurrency,
			final int resultSetHoldability) throws SQLException {
		return realConnection.createStatement ();
	}
	
	/**
	 * @see java.sql.Connection#createStruct(java.lang.String,
	 *      java.lang.Object[])
	 */
	@Override
	public Struct createStruct (final String typeName,
			final Object [] attributes) throws SQLException {
		return realConnection.createStruct (typeName, attributes);
	}
	
	/**
	 * @see java.sql.Connection#getAutoCommit()
	 */
	@Override
	public boolean getAutoCommit () throws SQLException {
		return realConnection.getAutoCommit ();
		
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 4, 2010
	 * </pre>
	 * 
	 * TO getCallerFromTrace WRITEME...
	 * 
	 * @return WRITEME
	 */
	private String getCallerFromTrace () {
		StackTraceElement [] stack; // = null;
		try {
			throw new Exception ();
		} catch (final Exception e) {
			stack = e.getStackTrace ();
		}
		// if (null == stack)
		// return null;
		
		final StringBuilder trace = new StringBuilder ();
		trace.append ("\n*******************************\n  ");
		trace.append (stack [3].toString ());
		trace.append ("\n*******************************\n");
		return trace.toString ();
	}
	
	/**
	 * @see java.sql.Connection#getCatalog()
	 */
	@Override
	public String getCatalog () throws SQLException {
		return realConnection.getCatalog ();
		
	}
	
	/**
	 * @see java.sql.Connection#getClientInfo()
	 */
	@Override
	public Properties getClientInfo () throws SQLException {
		return realConnection.getClientInfo ();
		
	}
	
	/**
	 * @see java.sql.Connection#getClientInfo(java.lang.String)
	 */
	@Override
	public String getClientInfo (final String name)
			throws SQLException {
		return realConnection.getClientInfo (name);
	}
	
	/**
	 * @see java.sql.Connection#getHoldability()
	 */
	@Override
	public int getHoldability () throws SQLException {
		return realConnection.getHoldability ();
		
	}
	
	/**
	 * @see java.sql.Connection#getMetaData()
	 */
	@Override
	public DatabaseMetaData getMetaData () throws SQLException {
		return realConnection.getMetaData ();
	}
	
	/**
	 * @see java.sql.Connection#getTransactionIsolation()
	 */
	@Override
	public int getTransactionIsolation () throws SQLException {
		return realConnection.getTransactionIsolation ();
	}
	
	/**
	 * @see java.sql.Connection#getTypeMap()
	 */
	@Override
	public Map <String, Class <?>> getTypeMap () throws SQLException {
		return realConnection.getTypeMap ();
	}
	
	/**
	 * @see java.sql.Connection#getWarnings()
	 */
	@Override
	public SQLWarning getWarnings () throws SQLException {
		return realConnection.getWarnings ();
	}
	
	/**
	 * @see java.sql.Connection#isClosed()
	 */
	@Override
	public boolean isClosed () throws SQLException {
		return realConnection.isClosed ();
	}
	
	/**
	 * @see java.sql.Connection#isReadOnly()
	 */
	@Override
	public boolean isReadOnly () throws SQLException {
		return realConnection.isReadOnly ();
	}
	
	/**
	 * @see java.sql.Connection#isValid(int)
	 */
	@Override
	public boolean isValid (final int timeout) throws SQLException {
		return realConnection.isValid (timeout);
	}
	
	/**
	 * @see java.sql.Wrapper#isWrapperFor(java.lang.Class)
	 */
	@Override
	public boolean isWrapperFor (final Class <?> iface)
			throws SQLException {
		return realConnection.isWrapperFor (iface);
	}
	
	/**
	 * @see java.sql.Connection#nativeSQL(java.lang.String)
	 */
	@Override
	public String nativeSQL (final String sql) throws SQLException {
		return realConnection.nativeSQL (sql);
	}
	
	/**
	 * @see java.sql.Connection#prepareCall(java.lang.String)
	 */
	@Override
	public CallableStatement prepareCall (final String sql)
			throws SQLException {
		return realConnection.prepareCall (sql);
		
	}
	
	/**
	 * @see java.sql.Connection#prepareCall(java.lang.String, int, int)
	 */
	@Override
	public CallableStatement prepareCall (final String sql,
			final int resultSetType, final int resultSetConcurrency)
			throws SQLException {
		return realConnection.prepareCall (sql, resultSetType,
				resultSetConcurrency);
	}
	
	/**
	 * @see java.sql.Connection#prepareCall(java.lang.String, int, int,
	 *      int)
	 */
	@Override
	public CallableStatement prepareCall (final String sql,
			final int resultSetType, final int resultSetConcurrency,
			final int resultSetHoldability) throws SQLException {
		return realConnection.prepareCall (sql, resultSetType,
				resultSetConcurrency, resultSetHoldability);
	}
	
	/**
	 * @see java.sql.Connection#prepareStatement(java.lang.String)
	 */
	@Override
	public PreparedStatement prepareStatement (final String sql)
			throws SQLException {
		return realConnection.prepareStatement (sql);
	}
	
	/**
	 * @see java.sql.Connection#prepareStatement(java.lang.String, int)
	 */
	@Override
	public PreparedStatement prepareStatement (final String sql,
			final int autoGeneratedKeys) throws SQLException {
		return realConnection.prepareStatement (sql,
				autoGeneratedKeys);
	}
	
	/**
	 * @see java.sql.Connection#prepareStatement(java.lang.String, int,
	 *      int)
	 */
	@Override
	public PreparedStatement prepareStatement (final String sql,
			final int resultSetType, final int resultSetConcurrency)
			throws SQLException {
		return realConnection.prepareStatement (sql, resultSetType,
				resultSetConcurrency);
	}
	
	/**
	 * @see java.sql.Connection#prepareStatement(java.lang.String, int,
	 *      int, int)
	 */
	@Override
	public PreparedStatement prepareStatement (final String sql,
			final int resultSetType, final int resultSetConcurrency,
			final int resultSetHoldability) throws SQLException {
		return realConnection.prepareStatement (sql, resultSetType,
				resultSetConcurrency, resultSetHoldability);
	}
	
	/**
	 * @see java.sql.Connection#prepareStatement(java.lang.String,
	 *      int[])
	 */
	@Override
	public PreparedStatement prepareStatement (final String sql,
			final int [] columnIndexes) throws SQLException {
		return realConnection.prepareStatement (sql, columnIndexes);
	}
	
	/**
	 * @see java.sql.Connection#prepareStatement(java.lang.String,
	 *      java.lang.String[])
	 */
	@Override
	public PreparedStatement prepareStatement (final String sql,
			final String [] columnNames) throws SQLException {
		return realConnection.prepareStatement (sql, columnNames);
	}
	
	/**
	 * @see java.sql.Connection#releaseSavepoint(java.sql.Savepoint)
	 */
	@Override
	public void releaseSavepoint (final Savepoint savepoint)
			throws SQLException {
		realConnection.releaseSavepoint (savepoint);
	}
	
	/**
	 * @see java.sql.Connection#rollback()
	 */
	@Override
	public void rollback () throws SQLException {
		realConnection.rollback ();
	}
	
	/**
	 * @see java.sql.Connection#rollback(java.sql.Savepoint)
	 */
	@Override
	public void rollback (final Savepoint savepoint)
			throws SQLException {
		realConnection.rollback ();
	}
	
	/**
	 * @see java.sql.Connection#setAutoCommit(boolean)
	 */
	@Override
	public void setAutoCommit (final boolean autoCommit)
			throws SQLException {
		realConnection.setAutoCommit (autoCommit);
	}
	
	/**
	 * @see java.sql.Connection#setCatalog(java.lang.String)
	 */
	@Override
	public void setCatalog (final String catalog) throws SQLException {
		realConnection.setCatalog (catalog);
	}
	
	/**
	 * @see java.sql.Connection#setClientInfo(java.util.Properties)
	 */
	@Override
	public void setClientInfo (final Properties properties)
			throws SQLClientInfoException {
		realConnection.setClientInfo (properties);
	}
	
	/**
	 * @see java.sql.Connection#setClientInfo(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public void setClientInfo (final String name, final String value)
			throws SQLClientInfoException {
		realConnection.setClientInfo (name, value);
	}
	
	/**
	 * @see java.sql.Connection#setHoldability(int)
	 */
	@Override
	public void setHoldability (final int holdability)
			throws SQLException {
		realConnection.setHoldability (holdability);
	}
	
	/**
	 * @see java.sql.Connection#setReadOnly(boolean)
	 */
	@Override
	public void setReadOnly (final boolean readOnly)
			throws SQLException {
		realConnection.setReadOnly (readOnly);
	}
	
	/**
	 * @see java.sql.Connection#setSavepoint()
	 */
	@Override
	public Savepoint setSavepoint () throws SQLException {
		return realConnection.setSavepoint ();
	}
	
	/**
	 * @see java.sql.Connection#setSavepoint(java.lang.String)
	 */
	@Override
	public Savepoint setSavepoint (final String name)
			throws SQLException {
		return realConnection.setSavepoint (name);
	}
	
	/**
	 * @see java.sql.Connection#setTransactionIsolation(int)
	 */
	@Override
	public void setTransactionIsolation (final int level)
			throws SQLException {
		realConnection.setTransactionIsolation (level);
	}
	
	/**
	 * @see java.sql.Connection#setTypeMap(java.util.Map)
	 */
	@Override
	public void setTypeMap (final Map <String, Class <?>> map)
			throws SQLException {
		realConnection.setTypeMap (map);
	}
	
	/**
	 * @see java.sql.Wrapper#unwrap(java.lang.Class)
	 */
	@Override
	public <T> T unwrap (final Class <T> iface) throws SQLException {
		return realConnection.unwrap (iface);
	}
}
