/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.net.datagram;

import java.util.HashMap;
import java.util.Map.Entry;
import java.util.Set;

import org.starhope.appius.game.ChannelListener;

/**
 * <p>
 * A generic hashmap container of datagram objects for ease of making
 * lists, arrays, etc. in JSON data
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @param <T>
 */
public class ADPMap <T extends ADPJSON> extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final HashMap <String, T> map = new HashMap <String, T> ();
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 */
	public ADPMap (final String mapname, final ChannelListener s) {
		super (mapname, s);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME 
	 * @param entry WRITEME 
	 */
	public void add (final String key, final T entry) {
		if ( !map.containsKey (key)) {
			map.put (key, entry);
			include (key, entry);
		}
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param entry WRITEME 
	 * @return WRITEME 
	 */
	public boolean contains (final T entry) {
		return map.containsValue (entry);
	}
	
	/**
	 * Gets an entry set for the map
	 * 
	 * @return WRITEME 
	 */
	public Set <Entry <String, T>> entrySet () {
		return map.entrySet ();
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME 
	 * @return WRITEME 
	 */
	public boolean exists (final String key) {
		return map.containsKey (key);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME 
	 * @return WRITEME 
	 */
	public T get (final String key) {
		return map.get (key);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME 
	 * @param entry WRITEME 
	 */
	public void remove (final String key, final T entry) {
		if (map.containsKey (key)) {
			map.remove (key);
			setJSON (key, null);
		}
	}
}
