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

import com.whirlycott.cache.Cacheable;

/**
 *
 * WRITEME: The documentation for this type (SQLPeerListElement) is incomplete. (brpocock@star-hope.org, Jan 12, 2010)
 *
 * @author brpocock@star-hope.org
 *
 */
public interface SQLPeerListElement extends Cacheable {

	/**
	 * @return the database ID (int or long) identifying this object
	 *         uniquely within its table.
	 */
	public long getSQLPeerID ();

	/**
	 * @return the unique name of the principal database table from
	 *         which this object comes
	 */
	public abstract String getSQLPeerTableName ();

	/**
	 * This is an overriding method.
	 * 
	 * @see com.whirlycott.cache.Cacheable#onRemove(java.lang.Object)
	 */
	@Override
	public void onRemove (Object arg0);

	/**
	 * This is an overriding method.
	 * 
	 * @see com.whirlycott.cache.Cacheable#onRetrieve(java.lang.Object)
	 */
	@Override
	public void onRetrieve (Object arg0);

	/**
	 * This is an overriding method.
	 *
	 * @see com.whirlycott.cache.Cacheable#onStore(java.lang.Object)
	 */
	@Override
	public void onStore (Object arg0);

}
