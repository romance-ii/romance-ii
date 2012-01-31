/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
package org.starhope.appius.game.actions;

import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.WeakHashMap;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @param <E>
 * @param <T>
 */
public class ActionListenerSet <E extends ActionHandler <T>, T extends ActionObject <?>>
		implements Set <E> {
	
	/**
	 * Dummy object used for the value since we're only interested in
	 * the key side of the hashmap
	 */
	private final static Object dummy = new Object ();
	
	/**
	 * Internal list of the action handler
	 */
	private final Map <E, Object> map = Collections
			.synchronizedMap (new WeakHashMap <E, Object> ());
	
	/**
	 * @see java.util.Set#add(java.lang.Object)
	 */
	@Override
	public boolean add (final E arg0) {
		return map.put (arg0, ActionListenerSet.dummy) == null;
	}
	
	/**
	 * @see java.util.Set#addAll(java.util.Collection)
	 */
	@Override
	public boolean addAll (final Collection <? extends E> arg0) {
		boolean result = false;
		for (final E e : arg0) {
			result |= map.put (e, ActionListenerSet.dummy) == null;
		}
		return result;
	}
	
	/**
	 * @see java.util.Set#clear()
	 */
	@Override
	public void clear () {
		map.clear ();
	}
	
	/**
	 * @see java.util.Set#contains(java.lang.Object)
	 */
	@Override
	public boolean contains (final Object arg0) {
		return map.containsKey (arg0);
	}
	
	/**
	 * @see java.util.Set#containsAll(java.util.Collection)
	 */
	@Override
	public boolean containsAll (final Collection <?> arg0) {
		boolean result = true;
		
		synchronized (map) {
			for (final Object e : arg0) {
				result &= map.containsKey (e);
				if ( !result) {
					break;
				}
			}
		}
		
		return result;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param action WRITEME 
	 */
	public void fire (final T action) {
		Set <E> temp;
		synchronized (map) {
			temp = new HashSet <E> (map.keySet ());
		}
		
		for (final E e : temp) {
			e.invoke (action);
		}
	}
	
	/**
	 * @see java.util.Set#isEmpty()
	 */
	@Override
	public boolean isEmpty () {
		return map.isEmpty ();
	}
	
	/**
	 * @see java.util.Set#iterator()
	 */
	@Override
	public Iterator <E> iterator () {
		synchronized (map) {
			return new HashSet <E> (map.keySet ()).iterator ();
		}
	}
	
	/**
	 * @see java.util.Set#remove(java.lang.Object)
	 */
	@Override
	public boolean remove (final Object arg0) {
		return map.remove (arg0) != null;
	}
	
	/**
	 * @see java.util.Set#removeAll(java.util.Collection)
	 */
	@Override
	public boolean removeAll (final Collection <?> arg0) {
		boolean result = false;
		
		for (final Object e : arg0) {
			result = map.remove (e) != null;
		}
		
		return result;
	}
	
	/**
	 * @see java.util.Set#retainAll(java.util.Collection)
	 */
	@Override
	public boolean retainAll (final Collection <?> arg0) {
		boolean result = false;
		
		synchronized (map) {
			for (final Object e : arg0) {
				if (map.containsKey (e)) {
					result = map.remove (e) != null;
				}
			}
		}
		
		return result;
	}
	
	/**
	 * @see java.util.Set#size()
	 */
	@Override
	public int size () {
		return map.size ();
	}
	
	/**
	 * @see java.util.Set#toArray()
	 */
	@Override
	public Object [] toArray () {
		synchronized (map) {
			return map.keySet ().toArray ();
		}
	}
	
	/**
	 * @see java.util.Set#toArray(SomeType[])
	 */
	@Override
	public <SomeType> SomeType [] toArray (final SomeType [] arg0) {
		synchronized (map) {
			return map.keySet ().toArray (arg0);
		}
	}
	
}
