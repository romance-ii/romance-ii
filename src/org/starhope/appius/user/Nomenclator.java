/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.appius.user;

import java.io.IOException;
import java.lang.ref.WeakReference;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.WeakHashMap;
import java.util.concurrent.ConcurrentSkipListSet;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.sql.SQLPeerDatum;
import org.starhope.appius.sys.op.FilterResult;
import org.starhope.appius.sys.op.FilterStatus;
import org.starhope.appius.types.FilterType;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecord;
import org.starhope.appius.util.RecordLoader;
import org.starhope.catullus.Gens;
import org.starhope.util.LibMisc;

import biz.source_code.base64Coder.Base64Coder;

import com.whirlycott.cache.Cache;
import com.whirlycott.cache.CacheConfiguration;
import com.whirlycott.cache.CacheDecorator;
import com.whirlycott.cache.CacheException;
import com.whirlycott.cache.CacheManager;

/**
 * The Nomenclator is the universal factory and caché mechanism for all
 * game objects derived from {@link DataRecord}, and provides facilities
 * for caching of arbitrary objects as well. The most common way to
 * obtain any game object is to call {@link #getDataRecord(Class, int)}
 * or {@link #getDataRecord(Class, String)}, which will check caché for
 * an existing reference, or instantiate one from a data store (e.g.
 * database) automatically.
 *
 * @author brpocock@star-hope.org
 */
public class Nomenclator {

	/**
	 * Stash for instance NPC's
	 */
	private final static Map <String, Set <WeakReference <AbstractUser>>> npcMap = new WeakHashMap <String, Set <WeakReference <AbstractUser>>> ();

	/**
	 * an index of all cachés
	 */
	private static ConcurrentSkipListSet <String> allCaches = new ConcurrentSkipListSet <String> ();

	/**
	 * <p>
	 * Make the assertion that the user name supplied is available to be
	 * requested or assigned to this user.
	 * </p>
	 * <p>
	 * Note that having another user request the name, which has not
	 * been either permitted or denied, will still throw an
	 * AlreadyUsedException.
	 * </p>
	 * <p>
	 * This routine returns void, because it throws exceptions if the
	 * name is forbidden or already used. For a boolean version, see
	 * {@link #isLoginAvailable (String)}
	 * </p>
	 *
	 * @param userNameRequested The name which is being requested
	 * @throws AlreadyUsedException if the user name has been requested
	 *             or accepted already
	 * @throws ForbiddenUserException if the user name is forbidden from
	 *             use (obscene, gives away personal information, or so
	 *             forth). See {@link #isLoginForbidden (String)}
	 */
	public static void assertLoginAvailable (
			final String userNameRequested)
			throws AlreadyUsedException, ForbiddenUserException {

		if (null == userNameRequested || "".equals (userNameRequested)) {
			throw new ForbiddenUserException (userNameRequested);
		}

		if ( !userNameRequested.startsWith ("$loadclient.")
				&& Nomenclator.isLoginForbidden (userNameRequested)) {
			throw new ForbiddenUserException (userNameRequested);
		}

		final AbstractUser gotItFirst = Nomenclator
				.getUserByLogin (userNameRequested);
		if (null != gotItFirst) {
			throw new AlreadyUsedException (userNameRequested,
					gotItFirst.getNameApprovedAt ());
		}

		return;
	}

	/**
	 * Store an object into a caché in which the object is identified by
	 * a DataRecord instance object. For this method to function, the
	 * object must implement the {@link DataRecordBacked} interface. The
	 * representative class of the object must also be specified,
	 * allowing “comparable” implementations of a common base class to
	 * be stored in the same caché.
	 *
	 * @param <RecordClass> The DataRecord identifying this object must
	 *            be a member of a class which extends DataRecord, of
	 *            course.
	 * @param <StorageBaseClass> The base class of which the object
	 *            being stored is either a member of, or a member of an
	 *            extending/implementing class thereof.
	 * @param <InstanceClass> The class of which the object is actually
	 *            an instance, which extends StorageBaseClass (or is
	 *            StorageBaseClass)
	 * @param klass The class identifier of the caché in which the
	 *            object is to be stored.
	 * @param obj The object to be stored in the caché
	 * @param rec The DataRecord uniquely identifying the object. The
	 *            identifiers of this DataRecord will be used as keys to
	 *            the caché.
	 */
	public static <RecordClass extends DataRecord, StorageBaseClass extends DataRecordBacked <RecordClass>, InstanceClass extends StorageBaseClass> void cache (
			final Class <StorageBaseClass> klass,
			final InstanceClass obj, final RecordClass rec) {
		if (AppiusConfig.disableCache ()) {
			return;
		}
		// System.err.println ("Caching " + klass.getCanonicalName ()
		// + " object as "
		// + Nomenclator.getRecIDForBackedObject (rec));
		final long cacheTime = AppiusConfig.getIntOrDefault (klass
				.getCanonicalName ()
				+ ".cacheTime", 5 * 60000 /* 5' in msec */);
		Nomenclator.getRecordBackedCache (klass).store (
				Nomenclator.getRecIDForBackedObject (rec), obj,
				cacheTime);
	}

	/**
	 * Store an item into a caché, for which we've already extracted the
	 * object's identification string and integer values.
	 *
	 * @param <T> The class of object (descended of {@link DataRecord})
	 * @param klassGiven The class of object (descended of
	 *            {@link DataRecord} )
	 * @param id The numeric ID under which to caché the reference
	 * @param ident The string ID under which to caché the reference
	 * @param o The object to be cached
	 */
	public static <T extends DataRecord> void cache (
			final Class <T> klassGiven, final int id,
			final String ident, final T o) {
		if (AppiusConfig.disableCache ()) {
			return;
		}
		final Class <T> klass = Nomenclator
				.getNomenGentile (klassGiven);
		// if (id < 1) {
		// final StringBuilder err = new StringBuilder ();
		// err.append ("Attempting to cache ");
		// err.append (klass.getCanonicalName ());
		// err.append (" ident=“");
		// err.append (ident);
		// err.append ("” & id=");
		// err.append (id);
		// AppiusClaudiusCaecus.reportBug (err.toString ());
		// }
		if (null == o.getRecordLoader ()) {
			AppiusClaudiusCaecus
					.traceThis (" Warning: caching record with no loader: "
							+ o.toString ());
		}

		final long cacheTime = AppiusConfig.getIntOrDefault (klass
				.getCanonicalName ()
				+ ".cacheTime", 5 * 60000 /* 5' in msec */);

		final Cache <String, T> identCache = Nomenclator
				.getIdentCache (klass);

		if (null != identCache && null != ident && !"".equals (ident)) {
			final String lident = ident.toLowerCase (Locale.ENGLISH);
			identCache.store (lident, o, cacheTime);
		}

		final Cache <Integer, T> idCache = Nomenclator
				.getIDCache (klass);
		if (null != idCache && id != 0) {
			idCache.store (Integer.valueOf (id), o, cacheTime);
		}
	}

	/**
	 * Store a DataRecord into the caché based upon its identifying
	 * string and integers.
	 *
	 * @param <T> the class of the record to be stored in the caché
	 * @param <S> the class of the record to be stored in the caché
	 * @param record the record to be stored in the caché
	 */
	@SuppressWarnings ("unchecked")
	public static <T extends DataRecord, S extends T> void cache (
			final T record) {
		if (AppiusConfig.disableCache ()) {
			return;
		}
		Class <? extends DataRecord> klass = record.getClass ();
		if (klass.isAnnotationPresent (Gens.class)) {
			klass = (Class <S>) klass.asSubclass ((Class <?>) klass
					.getAnnotation (Gens.class).nomen ());
		}
		int cacheableID;
		try {
			cacheableID = record.getCacheableID ();
		} catch (final NotFoundException e2) {
			cacheableID = 0;
		}
		String cacheableIdent;
		try {
			cacheableIdent = record.getCacheableIdent ();
		} catch (final NotFoundException e) {
			cacheableIdent = "";
		}
		Nomenclator.cache ((Class <T>) klass, cacheableID,
				cacheableIdent, record);
	}

	/**
	 * Store an arbitrary object in a caché. Note that this is
	 * <em>not</em> recommended for any class that is either a
	 * {@link DataRecord} nor an implementation of
	 * {@link DataRecordBacked}.
	 *
	 * @param <T> The class of the arbitrary object
	 * @param o An arbitrary object to be stored in the caché.
	 * @param ident A globally unique identifier, which should include
	 *            enough information to uniquely identify it among all
	 *            objects which might be stored.
	 */
	@SuppressWarnings ("unchecked")
	public static <T extends Object> void cache (final T o,
			final String ident) {
		if (AppiusConfig.disableCache ()) {
			return;
		}
		Cache <String, Object> cache;
		try {
			cache = CacheManager.getInstance ().getCache ();
		} catch (final CacheException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a CacheException in Nomenclator.cache ", e);
			return;
		}
		cache.store (ident, o);
	}

	/**
	 * put out caché info in string form
	 *
	 * @param cache the caché to be interrogated
	 * @return a string telling useful things about it
	 * @throws CacheException if something goes awry
	 */
	private static String cacheInfoToString (
			final CacheDecorator <?, ?> cache) throws CacheException {
		final StringBuilder s = new StringBuilder ();
		s.append ("\n\tAdaptive Ratio:\t");
		s.append (cache.getAdaptiveRatio ());
		s.append ("\n\tEfficiency Report:\t");
		s.append (cache.getEfficiencyReport ());
		s.append ("\n\tQueries per Second:\t");
		s.append (cache.getQueriesPerSecond ());
		s.append ("\n\tSize:\t");
		s.append (cache.getSize ());
		s.append ("\n\tTotal Hit Rate:\t");
		s.append (cache.getTotalHitrate ());
		s.append ("\n** End \n\n");
		return s.toString ();
	}

	/**
	 * clear all cachés (possibly causing severe consistency problems)
	 *
	 * @throws CacheException if something goes wrong
	 */
	public static void clearCaches () throws CacheException {
		((com.whirlycott.cache.CacheDecorator <?, ?>) CacheManager
				.getInstance ().getCache ()).clear ();
		for (final String cacheName : Nomenclator.allCaches) {
			((CacheDecorator <?, ?>) (com.whirlycott.cache.CacheDecorator <?, ?>) CacheManager
					.getInstance ().getCache (cacheName)).clear ();
		}
	}

	/**
	 * Create a new user account
	 * 
	 * @param date User's date of birth
	 * @param characterClass Character class or type designator
	 * @param login User's requested nickname
	 * @return the new user object
	 * @throws AlreadyUsedException if the nickname is not available
	 * @throws ForbiddenUserException if the user account is not
	 *             permitted to be created, e.g. for having an obscene
	 *             user ID
	 */
	public static AbstractUser create (final Date date,
			final String characterClass, final String login)
			throws AlreadyUsedException, ForbiddenUserException {
		try {
			return AppiusConfig.getUserClass ().getConstructor (
					Date.class, String.class, String.class)
					.newInstance (date, characterClass, login);
		} catch (final IllegalArgumentException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a IllegalArgumentException in create", e);
		} catch (final SecurityException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a SecurityException in create", e);
		} catch (final InstantiationException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a InstantiationException in create", e);
		} catch (final IllegalAccessException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a IllegalAccessException in create", e);
		} catch (final InvocationTargetException e) {
			final Throwable cause = e.getCause ();
			if (cause instanceof AlreadyUsedException) {
				throw (AlreadyUsedException) cause;
			}
			if (cause instanceof ForbiddenUserException) {
				throw (ForbiddenUserException) cause;
			}
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a InvocationTargetException in create", e);
		} catch (final NoSuchMethodException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a NoSuchMethodException in create", e);
		}
	}

	/**
	 * Find an object in the caché, given its class and identifying
	 * integer.
	 *
	 * @param <T> The class of object being returned
	 * @param klass The class of object to be returned, descended from
	 *            {@link DataRecord}
	 * @param id The numeric ID under which to locate the object
	 * @return The object, if found. This routine will never return
	 *         null.
	 * @throws NotFoundException If the object is not found in the
	 *             caché.
	 */
	public static <T extends DataRecord> T findInCache (
			final Class <T> klass, final int id)
			throws NotFoundException {
		if (AppiusConfig.disableCache ()) {
			throw new NotFoundException ("No Caché");
		}
		final Cache <Integer, T> cache = Nomenclator.getIDCache (klass);
		T o = null;
		final Integer integerID = Integer.valueOf (id);
		try {
			o = cache.retrieve (integerID);
			if (null != o) {
				o.checkStale ();
			}
		} catch (final ClassCastException e) {
			AppiusClaudiusCaecus.reportBug (
					"Incorrect type stored in cache", e);
			o = null;
		}
		if (null == o) {
			throw new NotFoundException (String.format ("%08x",
					integerID));
		}
		return o;
	}

	/**
	 * Find an object in the caché, given its base storage class and a
	 * {@link DataRecord} which uniquely identifies it. Note that the
	 * object itself will be guaranteed only to be a member of the
	 * specified class <em>or</em> an extension or implementor thereof.
	 *
	 * @param <S> The class of which the data record is an isstance or
	 *            an instance of a subclass thereof
	 * @param <T> The class of the object in the caché, which is backed
	 *            by and identified by the data record
	 * @param klass The class of which the data record is an instance or
	 *            instance of a subclass thereof
	 * @param rec The data record to be used to identify the object
	 *            cached
	 * @return The object found in the caché. This method will
	 *         <em>never</em> return null.
	 * @throws NotFoundException If no such object can be found in the
	 *             caché.
	 */
	public static <S extends DataRecord, T extends DataRecordBacked <S>> T findInCache (
			final Class <T> klass, final S rec)
			throws NotFoundException {
		if (AppiusConfig.disableCache ()) {
			throw new NotFoundException ("No Caché");
		}
		final String recIDForBackedObject = Nomenclator
				.getRecIDForBackedObject (rec);
		// System.err.println ("Checking cache for "
		// + klass.getCanonicalName () + " for "
		// + recIDForBackedObject);
		final Cache <String, T> cache = Nomenclator
				.getRecordBackedCache (klass);
		try {
			final T o = cache.retrieve (recIDForBackedObject);
			if (null != o) {
				o.setBackingRecord (rec);
				return o;
			}
		} catch (final ClassCastException e) {
			AppiusClaudiusCaecus.reportBug (
					"Incorrect type stored in cache", e);
		}
		throw new NotFoundException (recIDForBackedObject);
	}

	/**
	 * Find an object in the caché based upon a class and a string
	 * identifier.
	 *
	 * @param <T> The class of objects to be searched
	 * @param klass The class of objects to be searched
	 * @param ident The string identifier for the object to be found (or
	 *            not)
	 * @return The object (if found); will not return null (throws
	 *         {@link NotFoundException})
	 * @throws NotFoundException if the object was not found in the
	 *             caché
	 */
	public static <T extends DataRecord> T findInCache (
			final Class <T> klass, final String ident)
			throws NotFoundException {
		if (AppiusConfig.disableCache ()) {
			throw new NotFoundException ("No Caché");
		}
		final Cache <String, T> cache = Nomenclator
				.getIdentCache (klass);
		T o = null;
		try {
			o = cache.retrieve (ident.toLowerCase (Locale.ENGLISH));
			if (null != o) {
				o.checkStale ();
			}
		} catch (final ClassCastException e) {
			AppiusClaudiusCaecus.reportBug (
					"Incorrect type stored in cache", e);
			o = null;
		}
		if (null == o) {
			throw new NotFoundException (ident);
		}
		return o;
	}

	/**
	 * Find a generic object in a caché, without regards for the
	 * object's type. Note that the objects stored in the generic
	 * (default) caché share a single namespace, so it's possible to
	 * have objects of a totally incorrect class returned as a result of
	 * a search if the identifier is not globally unique. This method
	 * provides a minimum guarantee of correctness by catching class
	 * cast exceptions and throwing a somewhat more useful/informative
	 * {@link NotFoundException} rather than forcing the caller to
	 * perform a blind cast and try to catch runtime exceptions.
	 *
	 * @param <T> The class of object expected to be found
	 * @param klass The class of object expected to be found
	 * @param ident The (globally unique) identifier of the object
	 * @return The object, if found. Will not return null; throws a
	 *         {@link NotFoundException} instead
	 * @throws NotFoundException If the object is not in the caché; or,
	 *             if there is an object in the caché identified by
	 *             (parameter) “ident” which is not of the class “klass”
	 *             or a subclass or implementor thereof.
	 */
	@SuppressWarnings ("unchecked")
	public static <T extends Object> T findInGenericCache (
			final Class <T> klass, final String ident)
			throws NotFoundException {
		if (AppiusConfig.disableCache ()) {
			throw new NotFoundException ("No Caché");
		}
		Cache <String, Object> cache;
		try {
			cache = CacheManager.getInstance ().getCache ();
		} catch (final CacheException e1) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a CacheException in Nomenclator.findInCache ",
							e1);
			throw new NotFoundException (LibMisc.stringify (e1));
		}
		T o = null;
		try {
			o = (T) cache.retrieve (ident);
		} catch (final ClassCastException e) {
			o = null;
		}
		if (null == o) {
			throw new NotFoundException (ident);
		}
		return o;
	}

	/**
	 * Pick up a user from a JSON object containing either the ID or
	 * login (user name) string.
	 *
	 * @param object A JSON object with either an { id: userID } or {
	 *            login: userName }
	 * @return the User thusly fetched, or null if not found.
	 */
	public static AbstractUser get (final JSONObject object) {
		if (object.has ("id")) {
			try {
				return Nomenclator.getUserByID (object.getInt ("id"));
			} catch (final JSONException e) {
				// No op
			}
		}
		if (object.has ("login")) {
			try {
				return Nomenclator.getUserByLogin (object
						.getString ("login"));
			} catch (final JSONException e) {
				// No op
			}
		}
		return null;
	}

	/**
	 * get information about all cachés
	 *
	 * @return a string explaining things
	 * @throws CacheException if something goes awry
	 */
	public static String getAllCacheInfo () throws CacheException {
		final StringBuilder s = new StringBuilder ();
		s.append ("\n ** Caché Information: (General)");
		s
				.append (Nomenclator
						.cacheInfoToString ( ((com.whirlycott.cache.CacheDecorator <?, ?>) CacheManager
								.getInstance ().getCache ())));
		for (final String cacheName : Nomenclator.allCaches) {
			s.append ("\n ** Caché Information: " + cacheName);
			s
					.append (Nomenclator
							.cacheInfoToString ( ((com.whirlycott.cache.CacheDecorator <?, ?>) CacheManager
									.getInstance ()
									.getCache (cacheName))));
		}
		return s.toString ();
	}

	/**
	 * <p>
	 * Obtain a data record (implementing {@link DataRecord}) of the
	 * given class, based upon its unique numeric identifier.
	 * </p>
	 * <p>
	 * This method will attempt to locate a copy of the object in an
	 * in-core caché prior to resorting to other factory methods, e.g.
	 * {@link RecordLoader} or so forth.
	 * </p>
	 * <p>
	 * The ID value given is expected to be globally unique for all data
	 * records of the given class. Note that this is most often an
	 * SQL-backed {@link DataRecord}, and the ID is generally an SQL row
	 * identification. Also, typically, these ID's are expected to be
	 * positive numbers. However, this method will cheerfully accept
	 * negative ID's and attempt to locate the records.
	 * </p>
	 *
	 * @param <T> The class of which the data record is an instance (or
	 *            a subclass thereof)
	 * @param klassGiven The class of which the data record is an
	 *            instance (or a subclass thereof)
	 * @param id The unique identifier for the data record in question
	 * @return The object of class “klass” identified by “id.” Will not
	 *         return null; throws {@link NotFoundException}.
	 * @throws NotFoundException If the various factory methods
	 *             available cannot produce the data record requested
	 */
	public static <T extends DataRecord> T getDataRecord (
			final Class <T> klassGiven, final int id)
			throws NotFoundException {
		final Class <T> klass = Nomenclator
				.getNomenGentile (klassGiven);
		try {
			return Nomenclator.findInCache (klass, id);
		} catch (final NotFoundException e) {
			final T rec = AppiusConfig.getRecordLoaderForClass (klass)
					.loadRecord (id);
			if (null == rec) {
				throw new NotFoundException (Integer.toString (id));
			}
			Nomenclator.cache (rec);
			return rec;
		}
	}

	/**
	 * Get a data record by either searching the caché or loading it.
	 * See {@link #getDataRecord(Class, int)} for contractual details.
	 *
	 * @param <T> the class of the record (as per klass)
	 * @param klassGiven the class of the record to be loaded
	 * @param identifier the name or something that uniquely identifies
	 *            the record to be found
	 * @return The data record of class “klass” identified by
	 *         “identifier.” Will not return null; throws a
	 *         {@link NotFoundException}
	 * @throws NotFoundException If the record in question cannot be
	 *             found
	 */
	public static <T extends DataRecord> T getDataRecord (
			final Class <T> klassGiven, final String identifier)
			throws NotFoundException {
		final Class <T> klass = Nomenclator
				.getNomenGentile (klassGiven);
		try {
			return Nomenclator.findInCache (klass, identifier);
		} catch (final NotFoundException e) {
			final RecordLoader <T> loader = AppiusConfig
					.getRecordLoaderForClass (klassGiven);
			final T rec = loader.loadRecord (identifier);
			if (null == rec) {
				throw new NotFoundException (identifier);
			}
			Nomenclator.cache (rec);
			return rec;
		}
	}

	/**
	 * get a data record given a string class name and an ID
	 *
	 * @param <T> the resultant class represented by “klass”
	 * @param klass string class name
	 * @param id integer ID
	 * @return the object in question
	 * @throws NotFoundException if the object is not found
	 * @throws ClassNotFoundException if the class is not found
	 */
	@SuppressWarnings ("unchecked")
	public static <T extends DataRecord> T getDataRecord (
			final String klass, final int id) throws NotFoundException,
			ClassNotFoundException {
		final Class <T> theClass = (Class <T>) Class.forName (klass);
		return Nomenclator.getDataRecord (theClass, id);
	}

	/**
	 * get a data record given a specific class name string and
	 * identifier string
	 *
	 * @param <T> class thing to make compiler happy
	 * @param klass class name string
	 * @param ident identifier string
	 * @return object described thereby
	 * @throws NotFoundException if the object can't be found
	 * @throws ClassNotFoundException if the class name isn't found
	 */
	@SuppressWarnings ("unchecked")
	public static <T extends DataRecord> T getDataRecord (
			final String klass, final String ident)
			throws NotFoundException, ClassNotFoundException {
		return Nomenclator.getDataRecord ((Class <T>) Class
				.forName (klass), ident);
	}

	/**
	 * get a data record iterator
	 *
	 * @param <T> the class of iterator to be summoned
	 * @param klass the class of iterator to be summoned
	 * @param constructorArgs arguments to be passed to the constructor
	 *            (which must accept the nomen gentile of the parameter
	 *            classes)
	 * @return the required iterator
	 */
	@SuppressWarnings ("unchecked")
	public static <T extends Iterator <? extends DataRecord>> T getDataRecordIterator (
			final Class <T> klass, final Object... constructorArgs) {
		final Class <?> [] argTypes = new Class <?> [constructorArgs.length];
		for (int i = 0; i < constructorArgs.length; ++i) {
			argTypes [i] = Nomenclator
					.getNomenGentile (constructorArgs [i].getClass ());
		}

		try {
			return (T) Class.forName (
					AppiusConfig.getConfigOrDefault ("xtn."
							+ klass.getCanonicalName () + ".factory",
							klass.getCanonicalName ()
									+ "DefaultFactory")).getMethod (
					"iterator", argTypes)
					.invoke (null, constructorArgs);
		} catch (final IllegalArgumentException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a IllegalArgumentException in Nomenclator.getDataRecordIterator ",
							e);
		} catch (final SecurityException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a SecurityException in Nomenclator.getDataRecordIterator ",
							e);
		} catch (final IllegalAccessException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a IllegalAccessException in Nomenclator.getDataRecordIterator ",
							e);
		} catch (final InvocationTargetException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a InvocationTargetException in Nomenclator.getDataRecordIterator ",
							e);
		} catch (final NoSuchMethodException e) {
			final StringBuilder typeBuilder = new StringBuilder ();
			for (final Class <?> c : argTypes) {
				typeBuilder.append (c.getCanonicalName ());
				typeBuilder.append (' ');
			}
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a NoSuchMethodException in Nomenclator.getDataRecordIterator (ctor for "
									+ typeBuilder.toString (), e);
		} catch (final ClassNotFoundException e) {
			throw AppiusClaudiusCaecus
					.fatalBug (
							"Caught a ClassNotFoundException in Nomenclator.getDataRecordIterator ",
							e);
		}
	}

	/**
	 * get the caché for ID (integer) records of a given class (or gens)
	 *
	 * @param <T> class (or gens)
	 * @param klassGiven class
	 * @return the ID cache for class “klassGiven”
	 */
	private static <T> Cache <Integer, T> getIDCache (
			final Class <T> klassGiven) {
		return Nomenclator.getSomeCache (klassGiven, "/id",
				Integer.class);
	}

	/**
	 * get the caché for objects of some kind based on their string
	 * identifier
	 *
	 * @param <T> the class or gens
	 * @param klassGiven the class
	 * @return the caché
	 */
	private static <T> Cache <String, T> getIdentCache (
			final Class <T> klassGiven) {
		return Nomenclator.getSomeCache (klassGiven, "/ident",
				String.class);
	}

	/**
	 * Find the user name for a user who is currently signed on.
	 *
	 * @param name User name to look up
	 * @return The user ID number, if the user is online; else -1
	 */
	public static int getIDForLiveUserName (final String name) {
		try {
			return Nomenclator.findInCache (
					AbstractUser.class,
					Nomenclator.findInGenericCache (UserRecord.class,
							name)).getUserID ();
		} catch (final NotFoundException e) {
			return -1;
		}
	}

	/**
	 * Find a cached NPC
	 *
	 * @param instanceName Name with login$instanceID
	 * @return the NPC, if found
	 * @throws NotFoundException if not found
	 */
	private static AbstractUser getInstanceNPCByName (
			final String instanceName) throws NotFoundException {
		final int midDollar = instanceName.indexOf ('$', 1);
		if (midDollar > 1) {
			String instanceOf = instanceName.substring (0, midDollar)
					.toLowerCase (Locale.ENGLISH);
			// System.err.println (" Looking for NPC for " +
			// instanceOf);
			try {
				Integer.parseInt (instanceName
						.substring (midDollar + 1));
			} catch (final NumberFormatException e) {
				AppiusClaudiusCaecus
						.reportBug ("Instanced NPC format error “"
								+ instanceName + "”");
				return null;
			}

			for (WeakReference <AbstractUser> possible : Nomenclator
					.getOnlineNPCs (instanceOf)) {
				final String wantLabel = instanceName
						.toLowerCase (Locale.ENGLISH);
				AbstractUser u = possible.get ();
				if (null != u) {
					// System.err.println ("** looking at "
					// + u.getAvatarLabel ());
					final String label = u.getAvatarLabel ()
							.toLowerCase (Locale.ENGLISH);
					if (label.equals (wantLabel)) {
						return u;
					}
				}
			}
		}
		throw new NotFoundException (instanceName);
	}

	/**
	 * @param id The user ID value
	 * @return The user's login name
	 */
	public static String getLoginForID (final int id) {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT userName FROM users WHERE ID=?");

			st.setInt (1, id);
			if (st.execute ()) {
				rs = st.getResultSet ();
				rs.next ();
				final String userName = rs.getString ("userName");

				return userName;
			}
		} catch (final SQLException e) {
			/* no op */
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return "#" + id;
	}

	/**
	 * Get the nomen gentile of the class provided
	 *
	 * @param <T> type parameter to try to quiesce the compiler a bit
	 * @param klassGiven the specific class
	 * @return the class of the gens
	 */
	/*
	 * The “unchecked cast” is actually a legitimate warning, but it
	 * really belongs upon the specific class upon which the Gens
	 * annotation is placed. If that class manages to identify a parent
	 * class which is not, in point of fact, its ancestor, it's fucked.
	 */
	@SuppressWarnings ("unchecked")
	private static <T> Class <T> getNomenGentile (
			final Class <? extends T> klassGiven) {
		Class <? extends T> klass = klassGiven;
		if (klass.isAnnotationPresent (Gens.class)) {
			klass = (Class <T>) klass
					.asSubclass ((Class <? extends DataRecord>) klass
							.getAnnotation (Gens.class).nomen ());
		}
		if (AbstractUser.class.isAssignableFrom (klass)) {
			return (Class <T>) AbstractUser.class;
		}
		return (Class <T>) klass;
	}
	
	/**
	 * Instanced NPC:s are … WRITEME
	 * 
	 * @param name The name of the NPC
	 * @return A set of what potentially might be NPC:s
	 * @throws NotFoundException if there are no NPC:s based off that
	 *             user name
	 */
	public static Set <WeakReference <AbstractUser>> getOnlineNPCs (
			final String name) throws NotFoundException {
		// System.err.println ("NPC;s who might be " + who.getLogin ());
		// for (Set <WeakReference <AbstractUser>> npcs :
		// Nomenclator.npcMap
		// .values ()) {
		// for (WeakReference <AbstractUser> npc : npcs) {
		// AbstractUser u = npc.get ();
		// // System.err.println (null == u ? "null" : u
		// // .getDebugName ()
		// // + " = " + u.getAvatarLabel ());
		// }
		// }
		Set <WeakReference <AbstractUser>> npcs = Nomenclator.npcMap
				.get (name.toLowerCase (Locale.ENGLISH));
		if (null == npcs) {
			throw new NotFoundException (name
					.toLowerCase (Locale.ENGLISH));
		}
		return npcs;
	}

	/**
	 * get a user by their login, but *only* if they are currently
	 * online; pull only from live user sources, and not from the
	 * database.
	 *
	 * @param login user's login
	 * @return the user object, if the user exists, and is online; else
	 *         null.
	 */
	public static AbstractUser getOnlineUserByLogin (final String login) {
		if (0 == login.length ()) {
			return null;
		}

		if (login.indexOf ('$') >= 0) {
			try {
				return Nomenclator.getInstanceNPCByName (login);
			} catch (NotFoundException e) {
				// fall through
			}
		}

		UserRecord who = null;
		if ('#' == login.charAt (0)) {
			try {
				who = Nomenclator.findInCache (UserRecord.class,
						Integer.parseInt (login.substring (1)));
			} catch (final NotFoundException e1) {
				// no op
			}
			if (null == who) {
				return null;
			}
			return Nomenclator.instantiateUser (who);
		}

		try {
			who = Nomenclator.findInCache (UserRecord.class, login
					.toLowerCase (Locale.ENGLISH));
		} catch (final NotFoundException e1) {
			// no op
		}
		if (null == who) {
			return null;
		}
		return Nomenclator.instantiateUser (who);
	}

	/**
	 * @param cookie the approval cookie uniquely identifying the
	 *            desired Parent
	 * @return the Parent uniquely identified by the given approval
	 *         cookie
	 * @throws NotFoundException if the cookie does not uniquely
	 *             identify any Parent
	 * @throws IOException if the contents of the approval cookie can't
	 *             be decoded
	 */
	public static Parent getParentByApprovalCookie (final String cookie)
			throws NotFoundException, IOException {
		final String info = Base64Coder.decodeString (cookie);
		final String [] infos = info.split ("/");
		if (infos.length < 2) {
			throw new NotFoundException (cookie);
		}
		Parent tryThis = Nomenclator.getParentByID (Integer
				.parseInt (infos [0]));
		if (null == tryThis) {
			tryThis = Nomenclator.getParentByMail (infos [1]);
		}
		if (null == tryThis) {
			throw new NotFoundException (cookie);
		}
		return tryThis;
	}

	/**
	 * @param id database ID number
	 * @return the relevant Parent record (if it exists)
	 */
	public static Parent getParentByID (final int id) {
		try {
			return Nomenclator.getDataRecord (Parent.class, id);
		} catch (final NotFoundException e) {
			return null;
		}
	}

	/**
	 * @param mail The parent's eMail address
	 * @return the relevant Parent record
	 */
	public static Parent getParentByMail (final String mail) {
		try {
			return Nomenclator.getDataRecord (Parent.class, mail);
		} catch (final NotFoundException e) {
			return null;
		}
	}

	/**
	 * get a record ID for something that is in turn backed by some kind
	 * of data record
	 *
	 * @param rec the record whose ID is to be extracted
	 * @param <S> type of the record
	 * @return a string that can be used to identify the record
	 */
	private static <S extends DataRecord> String getRecIDForBackedObject (
			final S rec) {
		try {
			return Integer.toString (rec.getCacheableID (), 36);
		} catch (final NotFoundException e1) {
			try {
				return rec.getCacheableIdent ();
			} catch (final NotFoundException e) {
				throw AppiusClaudiusCaecus.fatalBug (
						"record has neither ID nor ident string "
								+ rec.toString (), e);
			}
		}
	}

	/**
	 * Get a caché backed by a type of record
	 *
	 * @param <T> the record type contained in the caché
	 * @param klass the record type contained in the caché
	 * @return the caché containing such records
	 */
	private static <T> Cache <String, T> getRecordBackedCache (
			final Class <T> klass) {
		return Nomenclator.getSomeCache (klass, "/rec", String.class);
	}

	/**
	 * get a caché containing records of a given type, with keys of
	 * another given type, using a given suffix code
	 *
	 * @param <T> the type contained within the caché
	 * @param <S> the type of keys
	 * @param tClass the type contained within the caché
	 * @param s the suffix code appended to <T>'s class name
	 * @param sClass the type of keys
	 * @return the caché (new or existing) used to contain <T> objects
	 *         keyed on <S>
	 */
	@SuppressWarnings ("unchecked")
	private static <T, S> Cache <S, T> getSomeCache (
			final Class <T> tClass, final String s,
			final Class <S> sClass) {
		Cache <S, T> someCache = null;
		final Class <T> klass = Nomenclator.getNomenGentile (tClass);
		try {
			someCache = CacheManager.getInstance ().getCache (
					klass.getCanonicalName () + s);
		} catch (final CacheException e) {
			if (e.getMessage ().contains (klass.getCanonicalName ())) {
				someCache = Nomenclator.initializeClassCache (sClass,
						klass, s);
			} else {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a CacheException in Nomenclator.getSomeCache ",
								e);
				return null;
			}
		}
		return someCache;
	}

	/**
	 * Get the System user object (the user which represents the system
	 * program itself). In particular, the System object's eMail address
	 * and givenName are used to address mail to users.
	 *
	 * @return the System user object
	 */
	public static AbstractUser getSystemUser () {
		// final AbstractUser god = Nomenclator.getUserByID (1);
		// god.setEphemeral (true);
		// return god;
		return Nomenclator.getUserByID (1);
	}

	/**
	 * Instantiate a user object from an existing user account ID
	 *
	 * @param id The user ID to instantiate
	 * @return the instantiated user record, or null if the user ID
	 *         doesn't represent a user record (too high, or the record
	 *         was destroyed somehow) — not returned for deleted or
	 *         banned accounts, though.
	 */
	public static AbstractUser getUserByID (final int id) {
		try {
			return Nomenclator.instantiateUser (Nomenclator
					.getDataRecord (UserRecord.class, id));
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a NotFoundException in Nomenclator.getUserByID ",
							e);
			return null;
		}
	}

	/**
	 * @param login the user login name
	 * @return the User record, or null if no user <em>currently</em>
	 *         has that login name
	 */
	public static AbstractUser getUserByLogin (final String login) {
		final AbstractUser u = Nomenclator.getOnlineUserByLogin (login);
		if (null != u) {
			return u;
		}
		try {
			UserRecord rec = null;
			if ('#' == login.charAt (0)) {
				rec = Nomenclator.getDataRecord (UserRecord.class,
						Integer.valueOf (login.substring (1))
								.intValue ());
			} else {
				rec = Nomenclator.getDataRecord (UserRecord.class,
						login.toLowerCase (Locale.ENGLISH));
			}
			return Nomenclator.instantiateUser (rec);
		} catch (final NotFoundException e) {
			return null;
		}
	}

	/**
	 * Get the user who has requested a certain name, if any.
	 *
	 * @param userNameRequested the user name for which we're searching
	 * @return null, if no user has requested the name; otherwise, the
	 *         user who requested it. (Note that the name might have
	 *         been approved, or might not have been.)
	 */
	public static AbstractUser getUserByRequestedName (
			final String userNameRequested) {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT ID FROM users WHERE requestedName=?");

			st.setString (1, userNameRequested);
			if (st.execute ()) {
				rs = st.getResultSet ();
				if (rs.next ()) {
					return Nomenclator.getUserByID (rs.getInt (1));
				}
				return null;
			}
		} catch (final SQLException e) {
			/* No op */
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return null;
	}

	/**
	 * Fetch the user ID number for a user name
	 *
	 * @param name The user name (login)
	 * @return the user ID
	 */
	public static int getUserIDForLogin (final String name) {
		if ('#' == name.charAt (0)) {
			return Integer.parseInt (name.substring (1));
		}
		final int liveID = Nomenclator.getIDForLiveUserName (name);
		if (liveID > 0) {
			return liveID;
		}
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT ID FROM users WHERE userName=?");

			st.setString (1, name);
			if (st.execute ()) {
				rs = st.getResultSet ();
				rs.next ();
				final int theirID = rs.getInt ("ID");
				return theirID;
			}
		} catch (final SQLException e) {
			// no op
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return 0;
	}

	/**
	 * Returns an array of all users associated with a given eMail
	 * address. This includes all users who report it as being their own
	 * eMail address, as well as the children of any parents using it.
	 *
	 * @param mail The eMail address for which we are searching
	 * @return An array of any/all such users. If the array consists
	 *         only of one element, which is the value "null," then
	 *         there are too many results and special effort is required
	 *         to recall the list.
	 */
	public static AbstractUser [] getUsersByMail (final String mail) {
		final AbstractUser [] them = {};
		Connection con = null;
		PreparedStatement getUsers = null;
		PreparedStatement getParents = null;
		ResultSet usersSet = null;
		ResultSet parentsSet = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getUsers = con
					.prepareStatement ("SELECT * FROM users WHERE mail = ?");
			getUsers.setString (1, mail);
			if (getUsers.execute ()) {
				usersSet = getUsers.getResultSet ();
				while (usersSet.next ()) {
					them [them.length] = Nomenclator
							.getUserByLogin (usersSet
									.getString ("userName"));
				}
			}

			getParents = con
					.prepareStatement ("SELECT * FROM users LEFT JOIN parents WHERE users.parentID = parents.id AND parents.mail = ?");
			getParents.setString (1, mail);
			if (getParents.execute ()) {
				parentsSet = getParents.getResultSet ();
				while (parentsSet.next ()) {
					them [them.length] = Nomenclator
							.getUserByLogin (parentsSet
									.getString ("userName"));
				}
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (e);
		} finally {
			LibMisc.closeAll (usersSet, getUsers, parentsSet,
					getParents, con);
		}
		return them;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param <S> class of ID
	 * @param <T> WRITEME
	 * @param idClass class of ID
	 * @param klass WRITEME
	 * @param ext WRITEME
	 * @return WRITEME
	 */
	@SuppressWarnings ( { "cast", "unchecked" })
	private static <S, T> Cache <S, T> initializeClassCache (
			final Class <S> idClass, final Class <T> klass,
			final String ext) {
		final CacheConfiguration config = new CacheConfiguration ();
		final String className = klass.getCanonicalName ();
		final String cacheName = className + ext;
		config.setName (cacheName);
		Nomenclator.allCaches.add (cacheName);
		config.setMaxSize (AppiusConfig.getIntOrDefault (className
				+ ".cache.maxSize", 1000));
		config.setPolicy (AppiusConfig.getConfigOrDefault (className
				+ ".cache.policy",
				"com.whirlycott.cache.policy.LFUMaintenancePolicy"));
		config.setBackend (AppiusConfig.getConfigOrDefault (className
				+ ".cache.backend",
				"com.whirlycott.cache.impl.ConcurrentHashMapImpl"));
		config.setTunerSleepTime (AppiusConfig.getIntOrDefault (
				className + ".cache.tunerSleepTime", 4000));
		try {
			return (Cache <S, T>) CacheManager.getInstance ()
					.createCache (config);
		} catch (final CacheException e1) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a CacheException in cache creation ", e1);
		}
	}

	/**
	 * Instantiate an instance of an object which wraps a data record
	 *
	 * @param <T> the type of object which is backed by the given
	 *            record. An object of this type, or possible an
	 *            extension subclass specified in the configuration
	 *            file, will be returned.
	 * @param <S> the type of data record which is passed in
	 * @param klass The class of T, to be instantiated
	 * @param record The record to be used to instantiate the new object
	 * @return the object of type T
	 */
	@SuppressWarnings ("unchecked")
	public static <T extends DataRecordBacked <S>, S extends DataRecord> T instantiate (
			final Class <T> klass, final S record) {

		// System.err.println ("Instantiating "
		// + klass.getCanonicalName () + " for "
		// + Nomenclator.getRecIDForBackedObject (record));

		Class <T> subclass = null;
		final String klassName = klass.getCanonicalName ();
		final String xtnClassKey = "xtn." + klassName;
		String xtnClassName = "<unknown class name>";

		/* ---------- */

		try {
			xtnClassName = AppiusConfig.getConfig (xtnClassKey);
			subclass = (Class <T>) Class.forName (xtnClassName);
		} catch (final NotFoundException e) {
			subclass = klass;
		} catch (final ClassCastException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Extension class mismatch, cannot use "
							+ xtnClassName + " for " + klassName, e);
		} catch (final ClassNotFoundException e) {
			AppiusClaudiusCaecus.reportBug (
					"ClassNotFoundException trying to get "
							+ xtnClassName + " for " + klassName, e);
		}

		/* ---------- */

		if (null == subclass) {
			subclass = klass;
		}
		Constructor <? extends T> constructor = null;

		/* ---------- */

		try {
			constructor = subclass.getConstructor (record.getClass ());
		} catch (final SecurityException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a SecurityException in finding constructor of "
							+ xtnClassName + " for " + klassName, e);
		} catch (final NoSuchMethodException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a NoSuchMethodException in finding constructor of "
							+ xtnClassName + " for " + klassName, e);
		}
		if (null == constructor) {
			throw AppiusClaudiusCaecus
					.fatalBug ("Can't find <init>("
							+ record.getClass ().getCanonicalName ()
							+ ") ctor in " + xtnClassName + " for "
							+ klassName);
		}

		/* ---------- */

		T newInstance;
		try {
			newInstance = constructor.newInstance (record);
		} catch (final IllegalArgumentException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a IllegalArgumentException in construction of "
							+ xtnClassName + " for " + klassName, e);
		} catch (final InstantiationException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a InstantiationException in construction of "
							+ xtnClassName + " for " + klassName, e);
		} catch (final IllegalAccessException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a IllegalAccessException in construction of "
							+ xtnClassName + " for " + klassName, e);
		} catch (final InvocationTargetException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a InvocationTargetException in construction of "
							+ xtnClassName + " for " + klassName, e);
		}

		Nomenclator.cache (record);
		if (User.class.equals (klass)) {
			Nomenclator.cache (AbstractUser.class,
					(AbstractUser) newInstance, (UserRecord) record);
		} else {
			Nomenclator.cache (klass, newInstance, record);
		}

		return newInstance;
	}

	/**
	 * Instantiate a User (using the selected subclass) from the result
	 * set garnered from a SELECT *
	 *
	 * @param rec The given database record
	 * @return The User (subclass) representing that database record
	 */
	static synchronized AbstractUser instantiateUser (
			final UserRecord rec) {
		try {
			return Nomenclator.findInCache (AbstractUser.class, rec);
		} catch (final NotFoundException e) {
			// System.err.println ("Didn't find user " + rec.getUserID
			// ()
			// + " in cache, instantiating");
			final User u = Nomenclator.instantiate (User.class, rec);
			if (rec.isPaidMember ()) {
				u.affirmPaidMember ();
			} else {
				u.affirmFreeMember ();
			}
			return u;
		}
	}

	/**
	 * Determine whether the given name is potentially available for
	 * use. Returns false if the name has already been forbidden (by
	 * virtue of matching a negative filter rule, or having been
	 * previously denied to another user), or if the name is currently
	 * either in use or requested by another user.
	 *
	 * @param name The user name being checked
	 * @return true, if the name can potentially be tried.
	 */
	public static boolean isLoginAvailable (final String name) {
		try {
			Nomenclator.assertLoginAvailable (name);
		} catch (final AlreadyUsedException e) {
			return false;
		} catch (final ForbiddenUserException e) {
			return false;
		}
		return true;
	}

	/**
	 * Determine whether a name is forbidden
	 * <p>
	 * ... A user name is “forbidden” if it matches a negative filter
	 * (if it contains forbidden word(s) or phrase(s)), or if it has
	 * previously been banned for some reason
	 * </p>
	 *
	 * @param userNameRequested The name to be checked
	 * @return True, if the requested name is forbidden
	 */
	public static boolean isLoginForbidden (
			final String userNameRequested) {

		if ( !User.isNameValid (userNameRequested)) {
			AppiusClaudiusCaecus.blather ("Name is invalid "
					+ userNameRequested);
			return true;
		}

		AppiusConfig.getFilter (FilterType.USER_LOGIN);

		String userNameNoNum = "";
		final Pattern noNums = Pattern.compile ("[0-9]");
		final Matcher m = noNums.matcher (userNameRequested);
		userNameNoNum = m.replaceAll ("");

		if (1 < userNameNoNum.length ()) {
			final FilterResult carlSays = AppiusConfig.getFilter (
					FilterType.USER_LOGIN)
					.filterMessage (userNameNoNum);

			if (carlSays.status == FilterStatus.Black
					|| carlSays.status == FilterStatus.Red) {
				if (AppiusConfig
						.getConfigBoolOrFalse ("com.tootsville.showNameFilter")) {
					AppiusClaudiusCaecus.blather (new Date (System
							.currentTimeMillis ())
							+ " ---- "
							+ userNameRequested
							+ "("
							+ userNameNoNum
							+ ") is forbidded.  Reason: "
							+ carlSays.toString ());
				}
				return true;
			}
		}

		return false;
	}

	/**
	 * <p>
	 * Remove an arbitrary object from a caché.
	 * </p>
	 * <p>
	 * FIXME: Does not work!
	 * </p>
	 *
	 * @param <S> WRITEME
	 * @param <T> The class of the arbitrary object
	 * @param klass WRITEME
	 * @param o An arbitrary object to be stored in the caché.
	 */
	public static <S extends DataRecord, T extends S> void killCache (
			final Class <S> klass, final T o) {
		if (AppiusConfig.disableCache ()) {
			return;
		}
		String ident = null;
		try {
			ident = o.getCacheableIdent ();
			final Cache <String, S> cache = Nomenclator
					.getIdentCache (klass);
			cache.remove (ident);
		} catch (final NotFoundException e1) {
			Integer id;
			try {
				id = Integer.valueOf (o.getCacheableID ());
			} catch (final NotFoundException e) {
				AppiusClaudiusCaecus.reportBug (
						"Unhandled NotFoundException in killCache", e);
				return;
			}
			final Cache <Integer, S> cache = Nomenclator
					.getIDCache (klass);
			cache.remove (id);
		}
	}

	/**
	 * Make a new DataRecord of the specified class, passing arbitrary
	 * values to its constructor.
	 * 
	 * @param <T> The class (or nomen gentile) of the new object
	 * @param klass The class (or nomen gentile) of the new object
	 * @param more whatever parameters the constructor takes
	 * @return the newly-constructed object
	 * @throws NotReadyException if the construction can't be acheieved
	 */
	public static <T extends DataRecord> T make (final Class <T> klass,
			final Object... more) throws NotReadyException {
		try {
			return klass.getConstructor (RecordLoader.class,
					Object [].class).newInstance (
					AppiusConfig.getRecordLoaderForClass (klass), more);
		} catch (final NoSuchMethodException e) {
			final Class <?> parmTypes[] = new Class <?> [more.length];
			for (int i = 0; i < more.length; i++ ) {
				parmTypes [i] = more [i].getClass ();
			}
			try {
				return klass.getConstructor (parmTypes).newInstance (
						more);
			} catch (final Exception e1) {
				AppiusClaudiusCaecus.reportBug (
						"in Nomenclator.make (NoSuchMethod/sub) …", e1);
				throw new NotReadyException (e1);
			}
		} catch (final Exception e) {
			AppiusClaudiusCaecus.reportBug ("in Nomenclator.make…", e);
			throw new NotReadyException (e);
		}
	}
	
	/**
	 * Parallel method to {@link #make(Class, Object...)} for
	 * deprecated/legacy SQLPeerDatum instances, to ease migration
	 * 
	 * @see #make(Class, Object...)
	 * @deprecated convert {@link SQLPeerDatum} classes remaining to
	 *             {@link DataRecord} and then use
	 *             {@link #make(Class, Object...)} instead of this
	 */
	@Deprecated
	public static <T extends SQLPeerDatum> T makeSQLPeer (
			final Class <T> klass, final Object... more)
			throws NotReadyException {
		AppiusClaudiusCaecus
				.blather ("WARNING: Using deprecated makeSQLPeer for "
						+ klass.getCanonicalName ()
						+ "; update to DataRecord, please!");
		try {
			return klass.getConstructor (Object [].class).newInstance (
					more);
		} catch (final NoSuchMethodException e) {
			final Class <?> parmTypes[] = new Class <?> [more.length];
			for (int i = 0; i < more.length; i++ ) {
				parmTypes [i] = more [i].getClass ();
			}
			try {
				return klass.getConstructor (parmTypes).newInstance (
						more);
			} catch (final Exception e1) {
				AppiusClaudiusCaecus.reportBug (
						"in Nomenclator.make (NoSuchMethod/sub) …", e1);
				throw new NotReadyException (e1);
			}
		} catch (final Exception e) {
			AppiusClaudiusCaecus.reportBug ("in Nomenclator.make…", e);
			throw new NotReadyException (e);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param whom WRITEME
	 * @param userRecord WRITEME
	 * @return WRITEME
	 */
	public static synchronized AbstractUser noteNPC (
			final AbstractUser whom, final UserRecord userRecord) {
		WeakReference <AbstractUser> ref = new WeakReference <AbstractUser> (
				whom);
		Set <WeakReference <AbstractUser>> npcs = Nomenclator.npcMap
				.get (userRecord.getLogin ().toLowerCase (
						Locale.ENGLISH));
		if (null == npcs) {
			npcs = new CopyOnWriteArraySet <WeakReference <AbstractUser>> ();
		}
		npcs.add (ref);
		Nomenclator.npcMap.put (userRecord.getLogin ().toLowerCase (
				Locale.ENGLISH), npcs);
		return whom;
	}

	/**
	 * Remove an instanced NPC from the caché on its destruction. Only
	 * should be called by {@link AbstractNonPlayerCharacter#destroy()}
	 *
	 * @param npc the character to be destroyed
	 */
	public static void removeInstanceNPC (final GeneralUser npc) {
			Set <WeakReference <AbstractUser>> set = Nomenclator.npcMap
				.get (AbstractNonPlayerCharacter
						.getNameStripped (npc.getAvatarLabel ()
								.toLowerCase (Locale.ENGLISH)));
			if (null != set) {
			for (WeakReference <AbstractUser> ref : set) {
				AbstractUser who = ref.get ();
				if (who.equals (npc)) {
					set.remove (ref);
				}
			}
			}
	}

}
