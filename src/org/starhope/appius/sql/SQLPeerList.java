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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.sql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Iterator;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.AppiusConfig;

import com.whirlycott.cache.Cache;
import com.whirlycott.cache.CacheConfiguration;
import com.whirlycott.cache.CacheException;
import com.whirlycott.cache.CacheManager;

/**
 * WRITEME: The documentation for this type (SQLPeerList) is incomplete.
 * (brpocock@star-hope.org, Jan 12, 2010)
 *
 * @author brpocock@star-hope.org
 * @param <T> the type (implementing SQLPeerListElement) of the contents
 *        of this list
 */
public abstract class SQLPeerList <T extends SQLPeerListElement>
implements Collection <T> {
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Jan 12, 2010) cache
	 * (SQLPeerList)
	 */
	private final Cache <Long, T> cache;

	/**
	 * WRITEME
	 *
	 * @param cacheSize WRITEME
	 * @param cacheName WRITEME
	 */
	@SuppressWarnings ({ "unchecked", "cast" })
	protected SQLPeerList (final int cacheSize, final String cacheName) {
		final CacheManager cacheManager = CacheManager.getInstance ();
		final CacheConfiguration cacheConfig = new CacheConfiguration ();
		cacheConfig.setMaxSize (cacheSize);
		cacheConfig.setName (cacheName);
		try {
			cache = (Cache<Long,T>) cacheManager.createCache (cacheConfig);
		} catch (final CacheException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a CacheException in SQLPeerList", e);
		}
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#add(java.lang.Object)
	 */
	@Override
	public boolean add (final T element) {
		cache.store (Long.valueOf (element.getSQLPeerID ()), element);
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = sqlInsertStatment (con);
			st.setLong (1, element.getSQLPeerID ());
			if (st.execute ()) {
				return true;
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a SQLException in add", e);
		} finally {
			if (null != st) {
				try {
					st.close ();
				} catch (final SQLException e) { /* No op */
				}
			}
			if (null != con) {
				try {
					con.close ();
				} catch (final SQLException e) { /* No op */
				}
			}
		}
		return false;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#addAll(java.util.Collection)
	 */
	@Override
	public boolean addAll (final Collection <? extends T> set) {
		boolean allGood = false;
		for (final T element : set) {
			if (allGood && !add (element)) {
				allGood = false;
			} else {
				allGood = true;
			}
		}
		return allGood;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#clear()
	 */
	@Override
	public void clear () {
		cache.clear (); // XXX is this right?

	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 12, 2010)
	 */
	public void clearCache () {
		cache.clear ();
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#contains(java.lang.Object)
	 */
	@SuppressWarnings ("unchecked")
	@Override
	public boolean contains (final Object o) {
		if (null == o) {
			return false;
		}
		try {
			final T element = (T) o;
			T found = cache.retrieve (Long.valueOf(element.getSQLPeerID ()));
			if (null != found) {
				found = fetch (element);
				return null != found;
			}
		} catch (final ClassCastException e) {
			/* No op */
		}
		return false;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#containsAll(java.util.Collection)
	 */
	@Override
	public boolean containsAll (final Collection <?> arg0) {
		for (final Object o : arg0) {
			if ( !contains (o)) {
				return false;
			}
		}
		return true;
	}

	/**
	 * Pull an element from the database, if it is on this list
	 *
	 * @param element WRITEME
	 * @return WRITEME
	 */
	private T fetch (final T element) {
		// TODO
		return null;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#isEmpty()
	 */
	@Override
	public boolean isEmpty () {
		return cache.size () == 0;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#iterator()
	 */
	@Override
	public Iterator <T> iterator () {
		// TODO Auto-generated method stub (brpocock@star-hope.org, Jan 12, 2010)
		return null;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#remove(java.lang.Object)
	 */
	@Override
	public boolean remove (final Object arg0) {
		// TODO Auto-generated method stub (brpocock@star-hope.org, Jan 12, 2010)
		return false;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#removeAll(java.util.Collection)
	 */
	@Override
	public boolean removeAll (final Collection <?> arg0) {
		// TODO Auto-generated method stub (brpocock@star-hope.org, Jan 12, 2010)
		return false;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#retainAll(java.util.Collection)
	 */
	@Override
	public boolean retainAll (final Collection <?> arg0) {
		// TODO Auto-generated method stub (brpocock@star-hope.org, Jan 12, 2010)
		return false;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#size()
	 */
	@Override
	public int size () {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = sqlSelectCount (con);
			if (st.execute ()) {
				final ResultSet rs = st.getResultSet ();
				if (rs.next ()) {
					return rs.getInt (1);
				}
			}
		} catch (final SQLException e) {
			/* No op */
		} finally {
			if (null != st) {
				try {
					st.close ();
				} catch (final SQLException e) { /* No op */
				}
			}
			if (null != con) {
				try {
					con.close ();
				} catch (final SQLException e) { /* No op */
				}
			}
		}
		return 0;
	}

	/**
	 *  @param con a database connection
	 * @return a prepared statement to insert a given item into the list. The item will be added to the
	 * statement by setting its ID as the first parameter.
	 */
	protected abstract PreparedStatement sqlInsertStatment (
			Connection con);

	/**
	 * @param con a database connection
	 * @return a string containing a query of the type SELECT COUNT(*)
	 *         FROM [table] to get the size of this list
	 */
	protected abstract PreparedStatement sqlSelectCount (Connection con);

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#toArray()
	 */
	@Override
	public T [] toArray () {
		// TODO Auto-generated method stub (brpocock@star-hope.org, Jan 12, 2010)
		return null;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#toArray(S[])
	 */
	@Override
	public <S> S [] toArray (final S [] arg0) {
		// TODO Auto-generated method stub (brpocock@star-hope.org, Jan 12, 2010)
		return null;
	}
}
