/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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

package org.starhope.appius.sql;

import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecord;
import org.starhope.util.LibMisc;

/**
 * <p>
 * This is a class for infrequently-changed objects that are enumerated
 * types referenced by integer ID columns. Things like the set of
 * available avatar classes fall into this category.
 * </p>
 * <p>
 * Note to Self: XXX On some future revision, it should be possible to
 * (by contractual enforcement, since I don't think I can enforce this
 * through Java inheritance, but I can put a runtime exception check on
 * it) require implementors to register their class for reload events
 * through a static initialiser and introduce a no-argument constructor.
 * </p>
 * <p>
 * e.g. ...
 * </p>
 * 
 * <pre>
 * protected SQLPeerEnum () {
 * 	if ( !hasRegisteredClass (this.getClass ())) {
 * 		throw new RuntimeExceptionAgainstBadImplementation (
 * 				this.getClass ());
 * 	} // ...
 * }
 * </pre>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
@Deprecated
public abstract class SQLPeerEnum extends SQLPeerDatum {
	
	/**
	 * enumeration of all possible values
	 */
	protected final static ConcurrentHashMap <Class <? extends SQLPeerEnum>, ConcurrentHashMap <Integer, String>> enumeration = new ConcurrentHashMap <Class <? extends SQLPeerEnum>, ConcurrentHashMap <Integer, String>> ();
	
	/**
	 * Index of which classes have been cached already. A value of -1
	 * means that the class is being cached presently; zero or more
	 * represents some state of completion, no longer requiring
	 * precaching.
	 */
	private static final ConcurrentHashMap <Class <? extends SQLPeerEnum>, Integer> hasCached = new ConcurrentHashMap <Class <? extends SQLPeerEnum>, Integer> ();
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Dec 11,
	 * 2009) knownChildren (SQLPeerEnum)
	 */
	private final static HashSet <Class <? extends SQLPeerEnum>> knownChildren = new HashSet <Class <? extends SQLPeerEnum>> ();
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Oct 13,
	 * 2009) serialVersionUID (long)
	 */
	private static final long serialVersionUID = 8901251122444872319L;
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 11,
	 * 2009)
	 */
	public synchronized static void doRealCacheResetStatic () {
		SQLPeerEnum.enumeration.clear ();
		SQLPeerEnum.hasCached.clear ();
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param <T> WRITEME
	 * @param klass WRITEME
	 * @param id WRITEME
	 * @return WRITEME
	 */
	public static <T extends SQLPeerEnum> T get (
			final Class <T> klass, final int id) {
		SQLPeerEnum o = null;
		try {
			o = klass.newInstance ();
		} catch (final InstantiationException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		} catch (final IllegalAccessException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		}
		o.set (id);
		return klass.cast (o);
	}
	
	/**
	 * Get an instance of an enumerated type
	 * 
	 * @param <T> the enumerated type to get
	 * @param klass the enumerated type's class, passed in as a
	 *             parameter
	 * @param str the identifying string for that type
	 * @return an enumerated type representing the provided string
	 */
	public static <T extends SQLPeerEnum> T get (
			final Class <T> klass, final String str) {
		SQLPeerEnum o = null;
		try {
			o = klass.newInstance ();
		} catch (final InstantiationException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		} catch (final IllegalAccessException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		}
		o.set (str);
		return klass.cast (o);
	}
	
	/**
	 * Deprecated from birth: backward-compatibility routine for
	 * objects that have been migrated from SQLPeerEnum to DataRecord
	 * 
	 * @param <T> class
	 * @param klass class
	 * @param id ID
	 * @return object
	 * @deprecated use {@link Nomenclator#getDataRecord(Class,int)}
	 */
	@Deprecated
	public static <T extends DataRecord> T Get (final Class <T> klass,
			final int id) {
		try {
			return Nomenclator.getDataRecord (klass, id);
		} catch (final NotFoundException e) {
			return null;
		}
	}
	
	/**
	 * Deprecated from birth: backward-compatibility routine for
	 * objects that have been migrated from SQLPeerEnum to DataRecord
	 * 
	 * @param <T> class
	 * @param klass class
	 * @param ident ID
	 * @return object
	 * @deprecated use {@link Nomenclator#getDataRecord(Class,String)}
	 */
	@Deprecated
	public static <T extends DataRecord> T Get (final Class <T> klass,
			final String ident) {
		try {
			return Nomenclator.getDataRecord (klass, ident);
		} catch (final NotFoundException e) {
			return null;
		}
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 11,
	 * 2009)
	 */
	public static void invalidateCache () {
		SQLPeerEnum.doRealCacheResetStatic ();
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 11,
	 * 2009)
	 */
	public static void invalidateCaches () {
		for (final Class <? extends SQLPeerEnum> klass : SQLPeerEnum.knownChildren) {
			try {
				klass.getMethod ("invalidateCache",
						(Class <?> []) null).invoke (
						(Class <?>) null, (Object) null);
			} catch (final IllegalArgumentException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a IllegalArgumentException in invalidateCaches",
								e);
			} catch (final SecurityException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a SecurityException in invalidateCaches",
								e);
			} catch (final IllegalAccessException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a IllegalAccessException in invalidateCaches",
								e);
			} catch (final InvocationTargetException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a InvocationTargetException in invalidateCaches",
								e);
			} catch (final NoSuchMethodException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a NoSuchMethodException in invalidateCaches",
								e);
			}
		}
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 11,
	 * 2009)
	 * 
	 * @param klass WRITEME
	 */
	private static void registerClass (
			final Class <? extends SQLPeerEnum> klass) {
		SQLPeerEnum.knownChildren.add (klass);
	}
	
	/**
	 * instance ID
	 */
	protected int instance;
	
	/**
	 * WRITEME
	 * 
	 * @param klass WRITEME
	 */
	public SQLPeerEnum (final Class <? extends SQLPeerEnum> klass) {
		super ();
		prepCache ();
		SQLPeerEnum.registerClass (klass);
		instance = -1;
	}
	
	/**
	 * WRITEME
	 * 
	 * @param klass WRITEME
	 * @param id the specific ID
	 */
	protected SQLPeerEnum (final Class <? extends SQLPeerEnum> klass,
			final int id) {
		super ();
		prepCache ();
		SQLPeerEnum.registerClass (klass);
		instance = id;
	}
	
	/**
	 * This method caches into the internal "enumeration" hashmap the
	 * results of an SQL query specific to this SQLPeerEnum class of
	 * object. The ResultSet must have a long (probably INT UNSIGNED)
	 * in the first column of the results, and the string value for it
	 * in column 1.
	 * 
	 * @param set The ResultSet from the SQL query
	 * @throws SQLException if anything goes wrong from the query
	 */
	protected void cache (final ResultSet set) throws SQLException {
		while (set.next ()) {
			getEnumeration ().put (Integer.valueOf (set.getInt (1)),
					set.getString (2));
		}
	}
	
	/**
	 * Actually flush the cache for all SQLPeerEnums
	 */
	private synchronized void doRealCacheReset () {
		SQLPeerEnum.doRealCacheResetStatic ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object o) {
		if (o instanceof SQLPeerEnum) {
			return equals ((SQLPeerEnum) o);
		}
		return false;
	}
	
	/**
	 * @see Object#equals(Object)
	 * @param o The other type
	 * @return true if the two types are equal
	 */
	public boolean equals (final SQLPeerEnum o) {
		return getCacheUniqueID ().equals (o.getCacheUniqueID ());
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerDatum#getCacheUniqueID()
	 */
	@Override
	protected String getCacheUniqueID () {
		return this.getClass ().getCanonicalName () + "#"
				+ String.valueOf (instance);
	}
	
	/**
	 * @return the enumeration
	 */
	protected ConcurrentHashMap <Integer, String> getEnumeration () {
		if ( !SQLPeerEnum.enumeration.containsKey (this.getClass ())) {
			SQLPeerEnum.enumeration.put (this.getClass (),
					new ConcurrentHashMap <Integer, String> ());
		}
		return SQLPeerEnum.enumeration.get (this.getClass ());
		
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Aug 14,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public int getID () {
		return instance;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jul 8,
	 * 2009)
	 * 
	 * @param s the string value for which to search
	 * @return the ID (number) of the string value, or -1 if it's not
	 *         found
	 */
	public int getID (final String s) {
		for (final Entry <Integer, String> e : getEnumeration ()
				.entrySet ()) {
			if (e.getValue () == s) {
				return e.getKey ().intValue ();
			}
		}
		return -1;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Aug 14,
	 * 2009)
	 * 
	 * @param connection WRITEME
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 */
	protected abstract PreparedStatement getStatement (
			Connection connection) throws SQLException;
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public String getString () {
		return getEnumeration ().get (Integer.valueOf (instance));
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jul 8,
	 * 2009)
	 * 
	 * @param id The value
	 * @return the string related to that value
	 */
	public String getString (final int id) {
		return SQLPeerEnum.enumeration.get (this.getClass ()).get (
				Integer.valueOf (id));
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getCacheUniqueID ());
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 */
	protected synchronized void prepCache () {
		// log.debug ("[prepCache]");
		
		int cacheLevel = -2;
		if (SQLPeerEnum.hasCached.containsKey (this.getClass ())) {
			cacheLevel = SQLPeerEnum.hasCached
					.get (this.getClass ()).intValue ();
		}
		
		if (cacheLevel >= 0) {
			return;
		}
		Connection con = null;
		PreparedStatement st = null;
		try {
			try {
				con = AppiusConfig.getDatabaseConnection ();
				st = getStatement (con);
			} catch (final SQLException e) {
				BugReporter.getReporter ("srv").reportBug (e);
			}
			try {
				if (st.execute ()) {
					cache (st.getResultSet ());
				} else {
					throw new RuntimeException (
							"Can't get enumerated type "
									+ this.getClass ()
											.getCanonicalName ()
									+ " from database");
				}
			} catch (final SQLException e) {
				BugReporter.getReporter ("srv").reportBug (e);
			}
		} finally {
			LibMisc.closeAll (st, con);
		}
		
		SQLPeerEnum.hasCached.put (this.getClass (),
				Integer.valueOf (1));
		
		// log.debug ("[/prepCache]");
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 */
	public synchronized void resetCache () {
		doRealCacheReset ();
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param id WRITEME
	 */
	public void set (final int id) {
		instance = id;
	}
	
	/**
	 * Set the contents of the string value of the instance of the
	 * enumeration
	 * 
	 * @param str the new value for this enumerated instance
	 */
	public void set (final String str) {
		if (SQLPeerEnum.enumeration.size () == 0) {
			prepCache ();
		}
		for (final Entry <Integer, String> tuple : getEnumeration ()
				.entrySet ()) {
			if (tuple.getValue ().equals (str)) {
				instance = tuple.getKey ().intValue ();
				return;
			}
		}
		BugReporter.getReporter ("srv").reportBug (
				"Key not found: "
						+ this.getClass ().getCanonicalName ()
						+ ": “" + str + "”");
		instance = -1;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerDatum#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject self = new JSONObject ();
		try {
			self.put ("id", instance);
			self.put ("s", getString ());
		} catch (final JSONException e) {
			// Default catch action, report bug
			// (brpocock@star-hope.org,
			// Aug 17, 2009)
			BugReporter.getReporter ("srv").reportBug (e);
		}
		return self;
	}
	
	/**
	 * Create a stringified version of this enumeration. Usually the
	 * integer ID, a colon, and the string name, but might be
	 * overridden in a child class.
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return String.valueOf (instance) + ":" + getString ();
	}
}
