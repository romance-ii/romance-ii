/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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
 */
package org.starhope.appius.sql;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.SerialDataException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.CastsToJSON;
import org.starhope.appius.util.DataRecord;

import com.whirlycott.cache.Cache;

/**
 * This is the base class from which all classes that reflect data from
 * the SQL backing store are derived. It extends ManagedReferenceHolder
 * for Project Darkstar support, and as a result, also implements
 * Serializable.
 * 
 * @deprecated use {@link DataRecord}
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
@Deprecated
public abstract class SQLPeerDatum implements Serializable,
		Comparable <Object> {
	
	/**
	 * The serialization UID for this class. serialVersionUID (long)
	 */
	private static final long serialVersionUID = -653828477429404181L;
	
	/**
	 * Indicate that some of the contents of this datum have changed,
	 * and that the database and/or object caches may need to be
	 * updated.
	 */
	public void changed () {
		// XXX saveInCache ();
		flush ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final Object o) {
		if (null == o) {
			return -1;
		}
		if ( ! (o instanceof SQLPeerDatum)) {
			return getCacheUniqueID ().compareTo (o.toString ());
		}
		return getCacheUniqueID ().compareTo (
				((SQLPeerDatum) o).getCacheUniqueID ());
	}
	
	/**
	 * Find the object in the cache, if possible. If not, throws a
	 * NotFoundException.
	 * 
	 * @param <T> type
	 * @return the object, if already found
	 * @throws NotFoundException if it's not found
	 */
	@SuppressWarnings ("unchecked")
	protected <T extends SQLPeerDatum> SQLPeerDatum findInCache ()
			throws NotFoundException {
		final String className = this.getClass ().getCanonicalName ();
		final Cache cache = AppiusConfig.getCache (className
				.substring (className.lastIndexOf ('.') + 1));
		final Object o = cache.retrieve (getCacheGlobalID ());
		if (null == o) {
			throw new NotFoundException (getCacheUniqueID ());
		}
		return (T) o;
	}
	
	/**
	 *
	 */
	public abstract void flush ();
	
	/**
	 * Get the globally-unique ID for this object, including the
	 * canonical class name, for the cache.
	 * 
	 * @return the ID for the cache
	 */
	private String getCacheGlobalID () {
		return this.getClass ().getCanonicalName ()
				+ String.valueOf ((char) 19) + getCacheUniqueID ();
	}
	
	/**
	 * @return The local (Stringified) version of an unique ID; usually
	 *         the database ID column
	 */
	protected abstract String getCacheUniqueID ();
	
	/**
	 * Store the local object into the cache
	 */
	@SuppressWarnings ("unchecked")
	protected void saveInCache () {
		final String className = this.getClass ().getCanonicalName ();
		final Cache cache = AppiusConfig.getCache (className
				.substring (className.lastIndexOf ('.') + 1));
		cache.store (getCacheGlobalID (), this);
	}
	
	/**
	 * @param jso The JSON data to be used to set the value of this
	 *             object
	 */
	@SuppressWarnings ("unchecked")
	public void set (final JSONObject jso) {
		final String javaClass;
		try {
			javaClass = jso.getString ("javaClass");
		} catch (final JSONException e) {
			throw new SerialDataException (
					"JSON object doesn't report its Java class");
		}
		if (javaClass.equals (this.getClass ().getCanonicalName ())) {
			final Iterator <String> keys = jso.keys ();
			while (keys.hasNext ()) {
				final String key = keys.next ();
				if (key.charAt (0) == 'f') {
					final String fieldName = key.substring (1);
					// Method setter = this.getClass ().getMethod
					// ("set"
					// + fieldName, jso.get)
					BugReporter
							.getReporter ("srv")
							.reportBug (
									"I wanted to set field "
											+ fieldName
											+ " from JSON, but I can't yet.");
				}
			}
		} else {
			throw new SerialDataException (
					"JSON data does not match class configuration");
		}
	}
	
	/**
	 * @param rs The result of an SQL query, with the cursor already
	 *             pointed at the row describing this specific instance
	 *             of the object.
	 * @throws SQLException if the database fails somehow
	 */
	protected abstract void set (ResultSet rs) throws SQLException;
	
	/**
	 * This is the default SQLPeerDatum implementation of toJSON. This
	 * uses Java reflection and “bean-type” methods to extract the
	 * contents of an object and create a JSON field.
	 * 
	 * @return This object's data, serialized into JSON form.
	 */
	public JSONObject toJSON () {
		final JSONObject jso = new JSONObject ();
		
		final Class <? extends SQLPeerDatum> localClass = this
				.getClass ();
		for (final Method method : localClass.getMethods ()) {
			boolean canDump = true;
			final String methodName = method.getName ();
			String fieldName = null;
			/* Is this a getter method? */
			if (methodName.startsWith ("get")) {
				fieldName = methodName.substring (3);
			} else if (methodName.startsWith ("is")) {
				fieldName = methodName.substring (2);
			} else {
				canDump = false;
			}
			/* Is this a zero-arg getter? */
			if (method.getParameterTypes ().length != 0) {
				canDump = false;
			}
			/* Find the return type */
			final Class <?> returnType = method.getReturnType ();
			/* Is there a parallel setter? */
			try {
				localClass.getMethod ("set" + fieldName, returnType);
			} catch (final SecurityException e) {
				canDump = false;
			} catch (final NoSuchMethodException e) {
				canDump = false;
			}
			if (canDump) {
				if (returnType.isPrimitive ()) {
					try {
						jso.put ("f" + fieldName, returnType
								.cast (method.invoke (this)));
					} catch (final IllegalArgumentException e) {
						BugReporter.getReporter ("srv")
								.reportBug ("Exception", e);
					} catch (final JSONException e) {
						BugReporter.getReporter ("srv")
								.reportBug ("Exception", e);
					} catch (final IllegalAccessException e) {
						BugReporter.getReporter ("srv")
								.reportBug ("Exception", e);
					} catch (final InvocationTargetException e) {
						BugReporter.getReporter ("srv")
								.reportBug ("Exception", e);
					}
				} else {
					boolean castsToJSON = false;
					for (final Class <?> ix : returnType
							.getInterfaces ()) {
						if (ix.equals (CastsToJSON.class)) {
							castsToJSON = true;
							break;
						}
					}
					if (castsToJSON) {
						BugReporter
								.getReporter ("srv")
								.reportBug (
										"I wanted to dump field "
												+ fieldName
												+ " using toJSON(), but I didn't.");
					}
				}
			}
			
		}
		return jso;
		
	}
}
