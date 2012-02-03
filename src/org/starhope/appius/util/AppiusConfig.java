/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.util;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;
import java.util.logging.Logger;

import javax.mail.Address;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.commons.dbcp.DriverManagerConnectionFactory;
import org.apache.commons.dbcp.PoolableConnectionFactory;
import org.apache.commons.dbcp.PoolingDriver;
import org.apache.commons.pool.ObjectPool;
import org.apache.commons.pool.impl.GenericObjectPool;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.inventory.AbstractItem;
import org.starhope.appius.messaging.AbstractCensor;
import org.starhope.appius.test.ConnectionDebug;
import org.starhope.appius.types.FilterType;
import org.starhope.appius.types.GameWorldMessage;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.User;
import org.starhope.appius.user.events.Action;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.util.LibMisc;

import com.whirlycott.cache.Cache;
import com.whirlycott.cache.CacheException;
import com.whirlycott.cache.CacheManager;

/**
 * This static class is the singleton responsible for configuration,
 * factories, etc.
 *
 * @author brpocock@star-hope.org
 */
public final class AppiusConfig {

	/**
	 * The internal configuration database is really a Java Properties
	 * object. This whole class exists to disguise that implementation
	 * detail.
	 */
	private static final Properties config = new Properties ();

	/**
	 * Set of things that want to know if the configuration changes
	 */
	private static ConcurrentSkipListSet <GetsConfigReload> configLoaders = new ConcurrentSkipListSet <GetsConfigReload> ();

	/**
	 * If true, use database connection pooling
	 */
	private static boolean dbcpActive = false;

	/**
	 * This is the data source for SQL queries.
	 */
	private static final Map <String, Connection> dbh = new HashMap <String, Connection> ();

	/**
	 * JDBC data source
	 */
	private static final Map <String, DataSource> ds = new HashMap <String, DataSource> ();

	/**
	 * The library of instantiated filters for various purposes
	 */
	private static ConcurrentHashMap <FilterType, AbstractCensor> filters = new ConcurrentHashMap <FilterType, AbstractCensor> ();

	/**
	 * This is the container for the poolable connection factory, which
	 * is never directly read again, but is used to contain the DBCP
	 * pool.
	 */
	private static final Map <String, PoolableConnectionFactory> poolableConnectionFactory = new HashMap <String, PoolableConnectionFactory> ();

	/**
	 * A running random number holder
	 */
	public static final Random rnd = new Random (
			System.currentTimeMillis ());

	/**
	 * Flag: whether to use Tomcat's DBCP
	 */
	private static boolean tomcatDBCP = AppiusConfig
			.getConfigBoolOrFalse ("org.starhope.appius.jdbc.useTomcat");

	/**
	 * @return true, if all Data Record Loaders should be treated as
	 *         realtime
	 */
	public static boolean alwaysRealtime () {
		return AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.alwaysRealtime");
	}

	/**
	 * This is a negative assertion ... sorry. If true, then do NOT kick
	 * staff members (users with a staff level greater than PUBLIC) for
	 * hitting the word filters.
	 *
	 * @return true, if we do NOT kick staff members for bad language
	 */
	public static boolean confDontKickStaff () {
		try {
			return AppiusConfig
					.getConfigBool ("org.starhope.appius.chat.dontKickStaff");
		} catch (final NotFoundException e) {
			return true;
		}
	}

	/**
	 * Announce to all interested parties that the configuration has
	 * been changed in some way
	 */
	public static void configChanged () {
		if (null != AppiusConfig.ds) {
			AppiusConfig.ds.clear ();
		}
		if (null != AppiusConfig.dbh) {
			AppiusConfig.dbh.clear ();
		}
		if (null != AppiusConfig.poolableConnectionFactory) {
			AppiusConfig.poolableConnectionFactory.clear ();
		}

		AppiusConfig.dbcpActive = AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.jdbc.dbcpEnabled");
		AppiusConfig.tomcatDBCP = AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.jdbc.useTomcat");

		for (final GetsConfigReload guy : AppiusConfig.configLoaders) {
			guy.configUpdated ();
		}
		User.configUpdated ();
		Quaestor.getLocal ().action (new Action ("config", null));
	}

	/**
	 * @return True, to disable Nomenclator's internal object caché
	 */
	public static boolean disableCache () {
		return AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.disableObjectCache");
	}

	/**
	 * Get the port number on which to listen for administrative
	 * commands
	 *
	 * @return the port number
	 */
	public static int getAdminPort () {
		return AppiusConfig.getIntOrDefault (
				"org.starhope.appius.backdoor.port", 2772);
	}

	/**
	 * @return the size of the receive buffer for the backdoor
	 */
	public static int getBackdoorBufferSize () {
		return AppiusConfig.getIntOrDefault (
				"org.starhope.appius.backdoor.receiveBufferSize", 1024);
	}

	/**
	 * @param cacheID the name of the cache
	 * @return the Whirley Cache
	 */
	@SuppressWarnings ("unchecked")
	public static Cache <String, ?> getCache (final String cacheID) {
		if (AppiusConfig
				.getConfigBoolOrFalse ("com.whirlycott.cache.enable")) {
			try {
				return CacheManager.getInstance ().getCache (cacheID);
			} catch (final CacheException e) {
				throw AppiusClaudiusCaecus.fatalBug (e);
			}
		}
		return null;
	}

	/**
	 * @return The name (database filter title) of the filter to be used
	 *         for chat
	 */
	@Deprecated
	public static String getChatFilterName () {
		return AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.filter.chat", "AppiusChat");
	}

	/**
	 * This fetches up a configuration property in general.
	 *
	 * @param key The identifier of the configuration value to be
	 *            queried
	 * @return The configuration string
	 * @throws NotFoundException If the configuration string is not
	 *             found
	 */
	public static String getConfig (final String key)
			throws NotFoundException {
		if (AppiusConfig.config.containsKey (key)) {
			return (String) AppiusConfig.config.get (key);
		}
		throw new NotFoundException ("Config string not found: " + key);
	}

	/**
	 * @param string the configuration identifier string
	 * @return true or false, based on the configuration string
	 * @throws NotFoundException if the value can't be found or isn't a
	 *             boolean (literal "true" or "false" only)
	 */
	public static boolean getConfigBool (final String string)
			throws NotFoundException {
		if (AppiusConfig.getConfig (string).equals ("true")) {
			return true;
		} else if (AppiusConfig.getConfig (string).equals ("false")) {
			return false;
		} else {
			throw new NotFoundException (
					"Not found or not boolean (true|false): " + string);
		}
	}

	/**
	 * The same as {@link #getConfigBool(String)} but returns a “false”
	 * if the key is not found
	 *
	 * @param string the config identifier string
	 * @return false, if not found or not boolean, or configured as
	 *         false; true, only if configured as “true”
	 */
	public static boolean getConfigBoolOrFalse (final String string) {
		try {
			return AppiusConfig.getConfigBool (string);
		} catch (final NotFoundException e) {
			return false;
		}
	}

	/**
	 * The same as {@link #getConfigBool(String)} but returns a “true”
	 * if the key is not found
	 *
	 * @param string the config identifier string
	 * @return true, if not found or not boolean, or configured as true;
	 *         false, only if configured as “false”
	 */
	public static boolean getConfigBoolOrTrue (final String string) {
		try {
			return AppiusConfig.getConfigBool (string);
		} catch (final NotFoundException e) {
			return true;
		}
	}

	/**
	 * @param key configuration key
	 * @param defaultValue default value
	 * @return the configured value of the key, or if not found, the
	 *         default value given
	 */
	public static String getConfigOrDefault (final String key,
			final String defaultValue) {
		try {
			return AppiusConfig.getConfig (key);
		} catch (final NotFoundException e) {
			return defaultValue;
		}
	}

	/**
	 * This calls @see(#getConfig), but doesn't throw any exceptions, it
	 * just returns a null if the string isn't found in the
	 * configuration.
	 *
	 * @param string The identifier of the configuration being queries
	 * @return Either the config string, or (if it's not found) a null
	 */
	public static String getConfigOrNull (final String string) {
		try {
			return AppiusConfig.getConfig (string);
		} catch (final NotFoundException e) {
			return null;
		}
	}

	/**
	 * Obtain a connection to an arbitrary schema on the database server
	 *
	 * @param host Database server hostname
	 * @param schema Database schema name
	 * @param user database user account name
	 * @param password database user account password
	 * @return a live connection to the given database
	 */
	private static Connection getConnectionToArbitraryDatabase (
			final String host, final String schema, final String user,
			final String password) {
		/*
		 * If we're using Tomcat to obtain the DBCP pool, use JNDI to
		 * extract the connection data source. These data sources are
		 * created from Tomcat's configuration at Tomcat's startup time.
		 */
		if (AppiusConfig.tomcatDBCP) {
			if (null == AppiusConfig.ds.get (schema)) {
				try {
					AppiusConfig.ds
							.put (schema,
									(DataSource) ((Context) new InitialContext ()
											.lookup ("java:/comp/env"))
											.lookup ("jdbc/" + schema
													+ "DB"));
				} catch (final NamingException e) {
					throw AppiusClaudiusCaecus.fatalBug (e);
				}
			}
			Connection connection = null;
			int tries = AppiusConfig.getIntOrDefault (
					"com.mysql.retryPing", 5);
			try {
				final DataSource dataSourceForSchema = AppiusConfig.ds
						.get (schema);
				PreparedStatement st = null;
				while (null == connection && --tries > 0) {
					try {
						connection = dataSourceForSchema
								.getConnection ();
						st = connection.prepareStatement ("/* ping */");
						st.execute ();
					} catch (final com.mysql.jdbc.CommunicationsException e) {
						LibMisc.closeAll (st, connection);
						st = null;
						connection = null;
					} finally {
						LibMisc.closeAll (st);
					}
				}
				return connection;
			} catch (final SQLException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Can't get a database connection from Tomcat, continuing with next method",
								e);
				LibMisc.closeAll (connection);
			}
		}

		/*
		 * If we're using DBCP directly, prime the data source with a
		 * local poolable connection factory.
		 */
		if (AppiusConfig.dbcpActive) {
			if (null == AppiusConfig.poolableConnectionFactory
					.get (schema)) {
				AppiusConfig.initDBCP (host, user, password, schema);
			}
			try {
				// XXX do a ping test like Tomcat, above
				final Properties dbcpProperties = new Properties ();
				for (final Object pKey : AppiusConfig.config.keySet ()) {
					final String prefixString = "org.apache.commons.dbcp.";
					if (pKey.toString ().startsWith (prefixString)) {
						dbcpProperties.put (
								pKey.toString ().substring (
										prefixString.length ()),
								AppiusConfig.config.get (pKey));
					}
				}
				final Connection con = DriverManager.getConnection (
						"jdbc:apache:commons:dbcp:" + schema,
						dbcpProperties);
				return con;
			} catch (final SQLException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Can't get a database connection from DBCP, continuing with next method",
								e);
			}
		}

		/*
		 * If we already have a database handle, that hasn't been
		 * closed, just use it.
		 */
		if (null != AppiusConfig.dbh.get (schema)) {
			try {
				if ( !AppiusConfig.dbh.get (schema).isClosed ()) {
					return AppiusConfig.dbh.get (schema);
				}
			} catch (final SQLException e1) {
				AppiusClaudiusCaecus
						.reportBug (
								"Can't reuse database connection, continuing with next method",
								e1);
			}
			try {
				AppiusConfig.dbh.get (schema).close ();
			} catch (final SQLException e) {
				// fuck off.
			}
			AppiusConfig.dbh.put (schema, null);
		}

		/*
		 * Not using DBCP, and don't have an open connection, so try to
		 * grab something.
		 */
		if (AppiusConfig.dbh.get (schema) == null) {
			AppiusConfig.ds.put (schema, new BasicDataSource ());
			final BasicDataSource dataSource = (BasicDataSource) AppiusConfig.ds
					.get (schema);
			dataSource.setDriverClassName (AppiusConfig
					.getConfigOrDefault (
							"org.starhope.appius.jdbc.driver",
							"com.mysql.jdbc.Driver"));
			dataSource.setUsername (user);
			dataSource.setPassword (password);
			dataSource.setUrl ("jdbc:mysql://" + host + "/" + schema);

			try {
				AppiusConfig.dbh.put (schema,
						AppiusConfig.ds.get (schema).getConnection ());
				return AppiusConfig.dbh.get (schema);
			} catch (final SQLException e) {
				throw AppiusClaudiusCaecus
						.fatalBug (
								"Can't get a database connection directly, failing.",
								e);
			}
		}

		/*
		 * Hopefully, by now, we have a connection...?
		 */
		return AppiusConfig.dbh.get (schema);
	}

	/**
	 * @return Gets a connection to the database.
	 * @throws SQLException (bubbled up from underlying layers)
	 */
	public static Connection getDatabaseConnection ()
			throws SQLException {
		final String hostName = AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.jdbc.host", "sql");
		final String schemaName = AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.jdbc.schema", "AppiusGame");
		final String sqlUser = AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.jdbc.login", "root");
		final String sqlPass = AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.jdbc.password", "pole");
		final Connection con = AppiusConfig
				.getConnectionToArbitraryDatabase (hostName,
						schemaName, sqlUser, sqlPass);
		if (AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.test.ConnectionDebug")) {
			return new ConnectionDebug (con);
		}
		return con;
	}

	/**
	 * get status information from DBCP pools
	 *
	 * @return Status of all DBCP connection pools
	 * @throws NotFoundException If one of the schema keys can't be
	 *             found
	 * @throws SQLException if the driver can't be accessed
	 */
	public static String getDBCPInfo () throws NotFoundException,
			SQLException {
		final StringBuilder results = new StringBuilder ();
		final PoolingDriver driver = (PoolingDriver) DriverManager
				.getDriver ("jdbc:apache:commons:dbcp:");
		for (final String schema : new String [] {
				AppiusConfig
						.getConfig ("org.starhope.appius.jdbc.schema"),
				AppiusConfig
						.getConfig ("org.starhope.appius.jdbc.zoneSchema"),
				AppiusConfig
						.getConfig ("org.starhope.appius.jdbc.storeSchema"),
				AppiusConfig
						.getConfig ("org.starhope.appius.jdbc.journalSchema") }) {
			final ObjectPool connectionPool = driver
					.getConnectionPool (schema);
			results.append ("DBCP status: Schema ");
			results.append (schema);
			results.append ("\n\tactive:\t");
			results.append (connectionPool.getNumActive ());
			results.append ("\n\tidle:\t");
			results.append (connectionPool.getNumIdle ());
			results.append ("\n\n");
		}
		return results.toString ();
	}

	/**
	 * Get the byte values used for DBCP enumeration of
	 * whenExhaustedAction from the string forms used in the
	 * configuration. Valid string values are grow, fail, or block.
	 *
	 * @return a byte (enumeration) value used to configure DBCP
	 */
	private static byte getDBCPWhenExhaustedAction () {
		try {
			final String action = AppiusConfig
					.getConfig ("org.apache.commons.dbcp.whenExhaustedAction");
			if ("grow".equalsIgnoreCase (action)) {
				return GenericObjectPool.WHEN_EXHAUSTED_GROW;
			} else if ("fail".equalsIgnoreCase (action)) {
				return GenericObjectPool.WHEN_EXHAUSTED_FAIL;
			} else if ("block".equalsIgnoreCase (action)) {
				return GenericObjectPool.WHEN_EXHAUSTED_BLOCK;
			}
		} catch (final NotFoundException e) { // fall through
		}
		return GenericObjectPool.DEFAULT_WHEN_EXHAUSTED_ACTION;
	}

	/**
	 * This returns the DNS URL to be used in JNDI queries for DNS
	 * lookups.
	 *
	 * @return A "dns://" URL for the DNS server which is to be queried.
	 */
	public static String getDNS_JNDI () {
		return AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.jndi.dns", "dns://localhost:53");
	}

	/**
	 * Obtain a filter (censor) object suitable for filtering a certain
	 * type of data, e.g. user login names or in-game chat.
	 *
	 * @param filter_type the type of filter to obtain
	 * @return a filter for the given purpose
	 */
	@SuppressWarnings ("unchecked")
	public static AbstractCensor getFilter (final FilterType filter_type) {
		if (null == AppiusConfig.filters.get (filter_type)) {
			final String filterClassName = AppiusConfig
					.getConfigOrDefault ("org.starhope.appius.filter."
							+ filter_type.toString (),
							"com.tootsville.hangman.Censor");
			try {
				final Class <? extends AbstractCensor> filterClass = (Class <? extends AbstractCensor>) Class
						.forName (filterClassName);
				final AbstractCensor newFilter = filterClass
						.newInstance ();
				AppiusConfig.filters.put (filter_type, newFilter);
				filterClass.getMethod ("prime", Connection.class)
						.invoke (
								newFilter,
								new Object [] { AppiusConfig
										.getDatabaseConnection () });
			} catch (final ClassNotFoundException e) {
				// Default catch action, report bug
				// (brpocock@star-hope.org, Jan 5,
				// 2010)
				AppiusClaudiusCaecus.reportBug (
						"Caught a ClassNotFoundException in getFilter",
						e);
			} catch (final InstantiationException e) {
				// Default catch action, report bug
				// (brpocock@star-hope.org, Jan 5,
				// 2010)
				AppiusClaudiusCaecus.reportBug (
						"Caught a InstantiationException in getFilter",
						e);
			} catch (final IllegalAccessException e) {
				// Default catch action, report bug
				// (brpocock@star-hope.org, Jan 5,
				// 2010)
				AppiusClaudiusCaecus.reportBug (
						"Caught a IllegalAccessException in getFilter",
						e);
			} catch (final IllegalArgumentException e) {
				// Default catch action, report bug
				// (brpocock@star-hope.org, Jan 5,
				// 2010)
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a IllegalArgumentException in getFilter",
								e);
			} catch (final SecurityException e) {
				// Default catch action, report bug
				// (brpocock@star-hope.org, Jan 5,
				// 2010)
				AppiusClaudiusCaecus.reportBug (
						"Caught a SecurityException in getFilter", e);
			} catch (final InvocationTargetException e) {
				// Default catch action, report bug
				// (brpocock@star-hope.org, Jan 5,
				// 2010)
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a InvocationTargetException in getFilter",
								e);
			} catch (final NoSuchMethodException e) {
				// Default catch action, report bug
				// (brpocock@star-hope.org, Jan 5,
				// 2010)
				AppiusClaudiusCaecus.reportBug (
						"Caught a NoSuchMethodException in getFilter",
						e);
			} catch (final SQLException e) {
				// Default catch action, report bug
				// (brpocock@star-hope.org, Jan 5,
				// 2010)
				AppiusClaudiusCaecus.reportBug (
						"Caught a SQLException in getFilter", e);
			}
		}
		return AppiusConfig.filters.get (filter_type);
	}

	/**
	 * Get the number of deferred (future) datagrams permitted to be
	 * enqueued for a single user, before the user's connection is
	 * decided to be “too laggy” and dropped.
	 *
	 * @return the maximum number of future datagrams to be enqueued for
	 *         delivery to an user before they are disconnected
	 */
	public static int getFutureDatagramsMax () {
		return AppiusConfig.getIntOrDefault (
				"org.starhope.appius.futureDatagramsMax", 100);
	}

	/**
	 * @return the time for an user to sit idle before we kick them
	 *         offline
	 */
	public static long getIdleKickTime () {
		return AppiusConfig.getIntOrDefault (
				"org.starhope.appius.idleKickTime", 20 * 60 * 1000);
	}

	/**
	 * @return the time for an user to sit idle before we send a warning
	 */
	public static long getIdleWarnTime () {
		return AppiusConfig.getIntOrDefault (
				"org.starhope.appius.idleWarnTime", 15 * 60 * 1000);
	}

	/**
	 * @param string the configuration key
	 * @return the configured value as an integer
	 * @throws NotFoundException if the key isn't found in the
	 *             configuration
	 * @throws NumberFormatException if the key can't be parsed as an
	 *             integer
	 */
	public static int getInt (final String string)
			throws NumberFormatException, NotFoundException {
		return Integer.parseInt (AppiusConfig.getConfig (string));
	}

	/**
	 * Get an integer value from the configuration; or, return a given
	 * default value if the value is not set, or can't be parsed as an
	 * integer.
	 *
	 * @param string The configuration key
	 * @param defaultValue The default value to be returned if the value
	 *            isn't available
	 * @return The configuration string specified; or, if none is
	 *         specified in the active configuration (or is not an
	 *         integer), the default value provided
	 */
	public static int getIntOrDefault (final String string,
			final int defaultValue) {
		try {
			return AppiusConfig.getInt (string);
		} catch (final NotFoundException e) {
			return defaultValue;
		} catch (final NumberFormatException e) {
			return defaultValue;
		}
	}

	/**
	 * @param string the configuration key
	 * @return the configured value as an integer, or if the value is
	 *         not configured or not parseable as an integer, returns 0
	 *         as a ‘safety’ value instead.
	 */
	public static int getIntOrZero (final String string) {
		try {
			return AppiusConfig.getInt (string);
		} catch (final NotFoundException e) {
			return 0;
		} catch (final NumberFormatException e) {
			return 0;
		}
	}

	/**
	 * @param itemID The item whose template is being requested
	 * @return an {@link AbstractItem} for that item
	 */
	@SuppressWarnings ("unchecked")
	public static AbstractItem getItemCreationTemplate (final int itemID) {
		try {
			final Class <? extends AbstractItem> klass = (Class <? extends AbstractItem>) Class
					.forName (AppiusConfig
							.getConfigOrDefault (
									"org.starhope.appius.itemCreationTemplate.class",
									"com.tootsville.StoreItem"));
			return (AbstractItem) klass
					.getMethod ("getByID", int.class).invoke (null,
							Integer.valueOf (itemID));
		} catch (final ClassNotFoundException e) {
			// Default catch action, report bug (brpocock@star-hope.org,
			// Jan 5, 2010)
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a ClassNotFoundException in getItemCreationTemplate",
							e);
		} catch (final IllegalArgumentException e) {
			// Default catch action, report bug (brpocock@star-hope.org,
			// Jan 5, 2010)
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a IllegalArgumentException in getItemCreationTemplate",
							e);
		} catch (final SecurityException e) {
			// Default catch action, report bug (brpocock@star-hope.org,
			// Jan 5, 2010)
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a SecurityException in getItemCreationTemplate",
							e);
		} catch (final IllegalAccessException e) {
			// Default catch action, report bug (brpocock@star-hope.org,
			// Jan 5, 2010)
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a IllegalAccessException in getItemCreationTemplate",
							e);
		} catch (final InvocationTargetException e) {
			// Default catch action, report bug (brpocock@star-hope.org,
			// Jan 5, 2010)
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a InvocationTargetException in getItemCreationTemplate",
							e);
		} catch (final NoSuchMethodException e) {
			// Default catch action, report bug (brpocock@star-hope.org,
			// Jan 5, 2010)
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a NoSuchMethodException in getItemCreationTemplate",
							e);
		}
	}

	/**
	 * get a connection to the journal database
	 *
	 * @return journal DB connection
	 * @throws SQLException if the connection can't be made for some
	 *             reason
	 */
	public static Connection getJournalDatabaseConnection ()
			throws SQLException {
		return AppiusConfig.getConnectionToArbitraryDatabase (
				AppiusConfig.getConfigOrDefault (
						"org.starhope.appius.jdbc.host", "sql"),
				AppiusConfig.getConfigOrDefault (
						"org.starhope.appius.jdbc.journalSchema",
						"AppiusJournal"), AppiusConfig
						.getConfigOrDefault (
								"org.starhope.appius.jdbc.login",
								"root"), AppiusConfig
						.getConfigOrDefault (
								"org.starhope.appius.jdbc.password",
								"pole"));
	}

	/**
	 * Get a list of strings from a single configuration key, separated
	 * by whitespace
	 *
	 * @param configKey the configuration key containing the list
	 * @return The whitespace-split list; or, an empty list if the
	 *         configuration key was unset.
	 */
	public static List <String> getList (final String configKey) {
		final List <String> list = new LinkedList <String> ();
		try {
			for (final String s : AppiusConfig.getConfig (configKey)
					.split ("[ \n\r\t\f]")) {
				if (s.length () > 0) {
					list.add (s);
				}
			}
		} catch (final NotFoundException e) {
			// No op. Return the empty list.
		}
		return list;
	}

	/**
	 * @return logger (not used)
	 */
	public static Logger getLogger () {
		return java.util.logging.Logger.getLogger (AppiusConfig
				.getConfigOrDefault ("org.starhope.appius.loggerName",
						"Appius"));
	}

	/**
	 * @return The name (database filter title) of the filter to be used
	 *         for login name selections
	 */
	public static String getLoginFilterName () {
		return AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.filter.login", "AppiusChat");
	}

	/**
	 * Get a Java mail Address object for sending automated eMails. This
	 * is taken from the $system user's eMail address.
	 *
	 * @return The address from which automated mails come
	 */
	public static Address getMailSender () {
		try {
			return new InternetAddress (Nomenclator.getSystemUser ()
					.getMail ());
		} catch (final AddressException e) {
			AppiusClaudiusCaecus.reportBug (e);
			throw new Error ("The system's eMail address is not valid");
		}
	}

	/**
	 * Get the maximum allowed input size for one client
	 *
	 * @return the maximum input size allowed in one packet
	 */
	public static int getMaxInputSize () {
		return AppiusConfig.getIntOrDefault (
				"org.starhope.appius.maxInputSize", 4096);
	}

	/**
	 * Get the granularity of the global metronome. This is used to
	 * drive all NPC, nudge, and idle timeout events.
	 *
	 * @return the time between metronome ticks in milliseconds.
	 */
	public static long getMetronomeTime () {
		return AppiusConfig.getIntOrDefault (
				"org.starhope.appius.metronomeTime", 2000);

	}

	/**
	 * @return The time between user events before we nudge the user (in
	 *         milliseconds)
	 */
	public static long getNudgeTime () {
		return AppiusConfig.getIntOrDefault (
				"org.starhope.appius.nudgeTime", 10000);
	}

	/**
	 * @return a random boolean value
	 */
	public static boolean getRandomBool () {
		return AppiusConfig.rnd.nextBoolean ();
	}

	/**
	 * @param from lower limit
	 * @param to upper limit
	 * @return a random integer in the given range (inclusive)
	 */
	public static int getRandomInt (final int from, final int to) {
		return AppiusConfig.rnd.nextInt (to - from + 1) + from;
	}

	/**
	 * get the record loader type for handling records of a given class
	 *
	 * @param <T> the type for which a RecordLoader is being sought
	 * @param klass the class of the DataRecord type
	 * @return a RecordLoader<T extends DataRecord> implementation
	 */
	@SuppressWarnings ("unchecked")
	public static <T extends DataRecord> RecordLoader <T> getRecordLoaderForClass (
			final Class <T> klass) {
		String loaderName = null;
		RecordLoader <T> loader = null;
		// try {
		// loaderName = AppiusConfig
		// .getConfig ("org.starhope.appius.useViaLoader");
		// } catch (final NotFoundException e1) {
			try {
				loaderName = AppiusConfig.getConfig (klass
						.getCanonicalName () + ".dataLoader");
			} catch (final NotFoundException e) {

				loaderName = klass.getCanonicalName ()
						+ AppiusConfig
								.getConfigOrDefault (
										"org.starhope.appius.defaultLoaderSuffix",
										"SQLLoader");
			}
		// }
		Class <?> loaderClass;
		try {
			loaderClass = Class.forName (loaderName);
		} catch (final ClassNotFoundException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a ClassNotFoundException in AppiusConfig.getRecordLoaderForClass for "
									+ loaderName, e);
		}

		try {
			final Constructor <?> con = loaderClass
					.getConstructor (Class.class);
			loader = (RecordLoader <T>) con.newInstance (klass);
		} catch (final SecurityException e1) {
			// fall through
		} catch (final NoSuchMethodException e1) {
			// fall through
		} catch (final Exception e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught an exception in AppiusConfig.getRecordLoaderForClass ",
							e);
			// fall through
		}
		if (null == loader) {
			try {
				loader = ((Class <RecordLoader <T>>) loaderClass)
						.newInstance ();
			} catch (final Exception e) {
				throw AppiusClaudiusCaecus.fatalBug (
						"Caught a exception in AppiusConfig.getRecordLoaderForClass for "
								+ loaderName, e);
			}
		}

		try {
			loader.initializeStorage (null);
		} catch (final NotReadyException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a NotReadyException in AppiusConfig.getRecordLoaderForClass ",
							e);
		}

		return loader;
	}

	/**
	 * To have been used for loading DataRecordSet, but I (BRP) don't
	 * think we ever used an implementation of that class…?
	 * 
	 * @param klass WRITEME
	 * @return WRITEME
	 */
	@SuppressWarnings ("unchecked")
	public static RecordSetLoader <? extends DataRecordSet <?>> getRecordSetLoaderForClass (
			final Class <? extends DataRecordSet <?>> klass) {
		String loaderName = null;
		try {
			loaderName = AppiusConfig.getConfig (klass
					.getCanonicalName () + ".setLoader");
		} catch (final NotFoundException e) {
			loaderName = klass.getCanonicalName () + "SQLSetLoader";
		}
		try {
			return (RecordSetLoader <? extends DataRecordSet <?>>) Class
					.forName (loaderName).newInstance ();
		} catch (final ClassNotFoundException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a ClassNotFoundException in AppiusConfig.getRecordSetLoaderForClass for "
									+ loaderName, e);
		} catch (final ClassCastException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a ClassCastException in AppiusConfig.getRecordSetLoaderForClass for "
									+ loaderName, e);
		} catch (final InstantiationException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a InstantiationException in AppiusConfig.getRecordSetLoaderForClass ",
							e);
		} catch (final IllegalAccessException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a IllegalAccessException in AppiusConfig.getRecordSetLoaderForClass ",
							e);
		}
	}

	/**
	 * Get the name of the Smart Fox Server to which we connect in SFS
	 * mode. This is the string base name, for example, “whitney,” of
	 * the login server (containing $Eden)
	 *
	 * @return The string base hostname (without domain) of the login
	 *         server
	 */
	@Deprecated
	public static String getServerName () {
		return AppiusConfig.getConfigOrDefault ("com.tootsville.sfs",
				"whitney");
	}

	/**
	 * @return The IP address of the server (as a string) indicated by
	 *         {@link #getServerName()}
	 */
	@Deprecated
	public static String getSFSName () {
		return AppiusConfig.getConfigOrDefault ("it.gotoandplay.sfs",
				"209.34.236.26");
	}

	/**
	 * @return The SFS server port. Should almost always be 9339.
	 */
	@Deprecated
	public static int getSFSPort () {
		return Integer.parseInt (AppiusConfig.getConfigOrDefault (
				"it.gotoandplay.sfsPort", "9339"));
	}

	/**
	 * @return the SMTP hostname for outbound eMail
	 */
	public static String getSMTPHost () {
		return AppiusConfig.getConfigOrDefault ("mail.smtp.host",
				"localhost");
	}

	/**
	 * @return Gets a connection to the database.
	 * @throws SQLException (bubbled up from underlying layers)
	 */
	public static Connection getStoreDatabaseConnection ()
			throws SQLException {

		final Connection con = AppiusConfig
				.getConnectionToArbitraryDatabase (
						AppiusConfig.getConfigOrDefault (
								"org.starhope.appius.jdbc.host", "sql"),
						AppiusConfig.getConfigOrDefault (
								"org.starhope.appius.jdbc.storeSchema",
								"AppiusGame"),
						AppiusConfig.getConfigOrDefault (
								"org.starhope.appius.jdbc.login",
								"root"),
						AppiusConfig.getConfigOrDefault (
								"org.starhope.appius.jdbc.password",
								"pole"));
		if (AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.test.ConnectionDebug")) {
			return new ConnectionDebug (con);
		}
		return con;
	}

	/**
	 * Get the top-level domain name of the game server(s).
	 *
	 * @return the top-level domain name of the game server(s)
	 */
	public static String getTLD () {
		return AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.topLevelDomain", "star-hope.org");
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 30,
	 * 2009)
	 *
	 * @return the class for users
	 */
	@SuppressWarnings ("unchecked")
	public static Class <? extends User> getUserClass () {
		try {
			return (Class <? extends User>) Class.forName (AppiusConfig
					.getConfigOrDefault (
							"org.starhope.appius.user.userClass",
							"com.tootsville.user.Toot"));
		} catch (final ClassNotFoundException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a ClassNotFoundException in getUserClass",
					e);
		} catch (final ClassCastException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Specified user class does not extend User", e);
		}
	}

	/**
	 * Get a connection to the database containing the Zones table
	 *
	 * @return a connection that can be used to access the Zones table
	 * @throws SQLException if the connection can't be obtained
	 */
	public static Connection getZonesDatabaseConnection ()
			throws SQLException {
		final Connection con = AppiusConfig
				.getConnectionToArbitraryDatabase (
						AppiusConfig.getConfigOrDefault (
								"org.starhope.appius.jdbc.host", "sql"),
						AppiusConfig.getConfigOrDefault (
								"org.starhope.appius.jdbc.zoneSchema",
								"AppiusZones"),
						AppiusConfig.getConfigOrDefault (
								"org.starhope.appius.jdbc.login",
								"root"),
						AppiusConfig.getConfigOrDefault (
								"org.starhope.appius.jdbc.password",
								"pole"));
		if (AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.test.ConnectionDebug")) {
			return new ConnectionDebug (con);
		}
		return con;
	}

	/**
	 * Register a class through which we can obtain a database handle,
	 * somehow.
	 *
	 * @param osirisSFSExtension The Osiris SFS Extension.
	 */
	// public static void howToGetDBH (
	// final OsirisSFSExtension osirisSFSExtension) {
	// AppiusConfig.dbhGetter = osirisSFSExtension;
	// }
	/**
	 * Initialize the configuration system from the Properties system
	 * and any other relevant sources. This is normally performed once,
	 * at startup.
	 */
	public synchronized static void init () {
		if (AppiusConfig.config.size () > 0) {
			return;
		}
		AppiusConfig.loadConfig ();
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 16,
	 * 2009)
	 *
	 * @param host WRITEME
	 * @param user WRITEME
	 * @param password WRITEME
	 * @param schema WRITEME
	 */
	private static void initDBCP (final String host, final String user,
			final String password, final String schema) {
		// AppiusClaudiusCaecus.traceThis ("initDBCP(" + schema + ")");

		try {
			Class.forName (
					AppiusConfig.getConfigOrDefault (
							"org.starhope.appius.jdbc.driver",
							"com.mysql.jdbc.Driver")).newInstance ();
		} catch (final InstantiationException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a InstantiationException trying to register database driver",
							e);
			return;

		} catch (final IllegalAccessException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a IllegalAccessException trying to register database driver",
							e);
			return;

		} catch (final ClassNotFoundException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a ClassNotFoundException trying to register database driver",
							e);
			return;

		}
		final DriverManagerConnectionFactory connectionFactory = new DriverManagerConnectionFactory (
				"jdbc:mysql://" + host + "/" + schema, user, password);
		final GenericObjectPool connectionPool = new GenericObjectPool (
				null);
		connectionPool.setMaxActive (AppiusConfig.getIntOrDefault (
				"org.apache.commons.dbcp.maxActive", 12));
		connectionPool.setMaxIdle (AppiusConfig.getIntOrDefault (
				"org.apache.commons.dbcp.maxIdle", 10));
		connectionPool.setMaxWait (AppiusConfig.getIntOrDefault (
				"org.apache.commons.dbcp.maxWait", 50));
		connectionPool.setMinIdle (AppiusConfig.getIntOrDefault (
				"org.apache.commons.dbcp.minIdle", 2));
		connectionPool.setWhenExhaustedAction (AppiusConfig
				.getDBCPWhenExhaustedAction ());
		final PoolableConnectionFactory poolConFact = new PoolableConnectionFactory (
				connectionFactory, connectionPool, null,
				"SELECT ID FROM users WHERE ID=1", false, true);
		AppiusConfig.poolableConnectionFactory
				.put (schema, poolConFact);

		try {
			Class.forName ("org.apache.commons.dbcp.PoolingDriver")
					.newInstance ();
		} catch (final InstantiationException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a InstantiationException while enabling DBCP driver",
							e);
			return;
		} catch (final IllegalAccessException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a IllegalAccessException while enabling DBCP driver",
							e);
			return;
		} catch (final ClassNotFoundException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a ClassNotFoundException while enabling DBCP driver",
							e);
			return;
		}

		PoolingDriver driver;
		try {
			driver = (PoolingDriver) DriverManager
					.getDriver ("jdbc:apache:commons:dbcp:");
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a SQLException in getRawDatabaseConnection",
							e);
			return;
		}

		driver.registerPool (schema, connectionPool);

	}

	/**
	 * Determine whether the administrative backdoor should be open
	 *
	 * @return true, if the backdoor should be open
	 */
	public static boolean isBackdoorOpen () {
		return AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.backdoor.open");
	}

	/**
	 * Return true if the system is set to debugging mode
	 *
	 * @return true, if the game is in debugging mode
	 */
	public static boolean isDebug () {
		return AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.debug");
	}

	/**
	 * Load (or reload) the configuration from the configuration
	 * properties file (/etc/appius/config.properties), and notify other
	 * classes that can adjust their configuration of that fact.
	 */
	public synchronized static void loadConfig () {
		AppiusConfig.config.clear ();
		FileReader configFile = null;
		try {
			configFile = new FileReader (
					"/etc/appius/config.properties");
			AppiusConfig.config.load (configFile);
		} catch (final FileNotFoundException e) {
			AppiusClaudiusCaecus.fatalBug (e);
		} catch (final IOException e) {
			AppiusClaudiusCaecus.fatalBug (e);
		} finally {
			if (null != configFile) {
				try {
					configFile.close ();
				} catch (final IOException e) {
					AppiusClaudiusCaecus.reportBug (e);
				}
			}
		}

		AppiusConfig.configChanged ();

	}

	/**
	 * @return true, if bug reports should be eMailed
	 */
	public static boolean mailBugs () {
		return AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.mailBugs");
	}

	/**
	 * @return WRITEME
	 */
	public static GameWorldMessage newGameWorldMessage () {
		try {
			return (GameWorldMessage) Class
					.forName (
							AppiusConfig
									.getConfigOrDefault (
											"org.starhope.appius.message.class",
											"org.starhope.appius.messaging.MailMessage"))
					.newInstance ();
		} catch (final Exception e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		}
	}

	/**
	 * @param key The configuration value to be set
	 * @param value The new value
	 */
	public static void setConfig (final String key, final String value) {
		AppiusConfig.config.put (key, value);
	}

	/**
	 * Determine whether to mail out bug reports, or not.
	 *
	 * @param b Whether to mail bug reports
	 */
	public static void setMailBugs (final boolean b) {
		AppiusConfig.setConfig ("org.starhope.appius.mailBugs",
				String.valueOf (b));
	}

	/**
	 * Add something to the list of things that want configuration
	 * reload notifications
	 *
	 * @param thing The object wanting configuration change
	 *            notifications
	 */
	public static void wantConfigReload (final GetsConfigReload thing) {
		AppiusConfig.configLoaders.add (thing);
	}

}
