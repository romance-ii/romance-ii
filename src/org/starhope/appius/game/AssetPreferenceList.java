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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.game;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class AssetPreferenceList implements Map<AssetFormat,Float>{

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	Map<AssetFormat,Float> map = new HashMap <AssetFormat,Float> ();
	
	/**
	 * @see java.util.Map#clear()
	 */
	@Override
	public void clear () {
		map.clear();
	}

	/**
	 * @see java.util.Map#containsKey(java.lang.Object)
	 */
	@Override
	public boolean containsKey (Object key) {
	return map.containsKey(key);
	}

	/**
	 * @see java.util.Map#containsValue(java.lang.Object)
	 */
	@Override
	public boolean containsValue (Object value) {
		return map.containsValue (value);
	}

	/**
	 * @see java.util.Map#entrySet()
	 */
	@Override
	public Set <java.util.Map.Entry <AssetFormat, Float>> entrySet () {
		return map.entrySet ();
	}

	/**
	 * @see java.util.Map#get(java.lang.Object)
	 */
	@Override
	public Float get (Object key) {
		return map.get(key);
	}

	/**
	 * @see java.util.Map#isEmpty()
	 */
	@Override
	public boolean isEmpty () {
		return map.isEmpty ()
		;
	}

	/**
	 * @see java.util.Map#keySet()
	 */
	@Override
	public Set <AssetFormat> keySet () {
		return map.keySet();
	}

	/**
	 * @see java.util.Map#put(java.lang.Object, java.lang.Object)
	 */
	@Override
	public Float put (AssetFormat key, Float value) {
		return map.put(key, value);
	}

	/**
	 * @see java.util.Map#putAll(java.util.Map)
	 */
	@Override
	public void putAll (Map <? extends AssetFormat, ? extends Float> m) {
		map.putAll (m);
	}

	/**
	 * @see java.util.Map#remove(java.lang.Object)
	 */
	@Override
	public Float remove (Object key) {
		return map.remove(key);
	}

	/**
	 * @see java.util.Map#size()
	 */
	@Override
	public int size () {
		return map.size();
	}

	/**
	 * @see java.util.Map#values()
	 */
	@Override
	public Collection <Float> values () {
		return map.values();
	}
	
}
