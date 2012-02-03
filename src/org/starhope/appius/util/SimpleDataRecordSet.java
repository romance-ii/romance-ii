/**
 * <h1>
 * SimpleDataRecordSet.java (org.starhope.appius.util)
 * </h1>
 * <h2>
 * Project: Romance
 * </h2>
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
 * </p><p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at
 * your option) any later version.
 * </p><p>
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * </p><p>
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see &lt;http://www.gnu.org/licenses/&gt;.
 * </p>
 */
package org.starhope.appius.util;

import java.util.Collection;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import org.starhope.appius.except.NotFoundException;

/**
 * <p>
 * This class represents a default implementation of
 * {@link DataRecordSet} which is hoped to be sufficient for most
 * purposes.
 * </p>
 * <p>
 * This type <em>cannot</em> handle a {@link DataRecord} implementation
 * which throws a {@link NotFoundException} from
 * {@link DataRecord#getCacheableID()} in any case; it will throw a
 * runtime exception of type {@link NumberFormatException} when this
 * occurs.
 * </p>
 * <p>
 * This type <em>cannot</em> accept null values into the collection.
 * </p>
 * 
 * @author brpocock@star-hope.org
 * @param <DataRecordClass> the type of records contained within the set
 * @param <DataRecordSetClass> the type of the subclass implementing
 *            this base class
 */
public abstract class SimpleDataRecordSet <DataRecordClass extends DataRecord, DataRecordSetClass extends SimpleDataRecordSet <DataRecordClass, DataRecordSetClass>>
		extends
		SimpleDataRecord <SimpleDataRecordSet <DataRecordClass, DataRecordSetClass>>
		implements DataRecordSet <DataRecordClass> {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -6121300446693891188L;
	/**
	 * The internal implementation of the set is a concurrent hash-map.
	 */
	private final Map <Integer, DataRecordClass> map = new ConcurrentHashMap <Integer, DataRecordClass> ();

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param klass WRITEME
	 */
	protected SimpleDataRecordSet (
			final Class <? extends SimpleDataRecordSet <DataRecordClass, DataRecordSetClass>> klass) {
		super (klass);
	}


	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param loader WRITEME
	 */
	public SimpleDataRecordSet (
			final RecordLoader <SimpleDataRecordSet <DataRecordClass, DataRecordSetClass>> loader) {
		super (loader);
	}

	/**
	 * @see java.util.Collection#add(java.lang.Object)
	 */
	@Override
	public boolean add (final DataRecordClass o) {
		DataRecordClass prior = null;
		try {
			prior = map.put (Integer.valueOf (o.getCacheableID ()), o);
		} catch (final NotFoundException e) {
			throw new NumberFormatException (o.getClass () + " returned NotFoundException, violating contract");
		}
		final boolean changed =  !o .equals (prior);
		if (changed) {
			changed();
		}
		return changed;
	}

	/**
	 * @see java.util.Collection#addAll(java.util.Collection)
	 */
	@Override
	public boolean addAll (
			final Collection <? extends DataRecordClass> c) {
		boolean anyChanged = false;
		for (final DataRecordClass o : c) {
			if (add (o)) {
				anyChanged = true;
			}
		}
		return anyChanged;
	}

	/**
	 * @see java.util.Collection#clear()
	 */
	@Override
	public void clear () {
		if (map.size () > 0) {
			map.clear ();
			changed ();
			return;
		}
		map.clear ();
	}

	/**
	 * @see java.util.Collection#contains(java.lang.Object)
	 */
	@Override
	public boolean contains (final Object o) {
		return map.containsValue (o);
	}

	/**
	 * @see java.util.Collection#containsAll(java.util.Collection)
	 */
	@Override
	public boolean containsAll (final Collection <?> c) {
		return map.values ().containsAll (c);
	}


	/**
	 * @see java.util.Collection#isEmpty()
	 */
	@Override
	public boolean isEmpty () {
		return map.isEmpty ();
	}

	/**
	 * @see java.util.Collection#iterator()
	 */
	@Override
	public Iterator <DataRecordClass> iterator () {
		return map.values ().iterator ();
	}



	/**
	 * @see java.util.Collection#remove(java.lang.Object) <p>
	 *      Note that the implementation of
	 *      {@link #removeAll(Collection)} (for efficiency) does not
	 *      call this method. Thus, any changes to this routine may need
	 *      to be mirrored there.
	 *      </p>
	 */
	@Override
	public boolean remove (final Object o) {
		if ( !map.containsValue (o)) {
			return false;
		}
		for (final Entry <Integer, DataRecordClass> e : map.entrySet ()) {
			if (e.getValue ().equals (o)) {
				map.remove (e.getKey ());
				changed ();
				return true;
			}
		}
		return false;
	}

	/**
	 * @see java.util.Collection#removeAll(java.util.Collection) <p>
	 *      Note that this implementation, for efficiency, does not call
	 *      {@link #remove(Object)}
	 *      </p>
	 */
	@Override
	public boolean removeAll (final Collection <?> c) {
		boolean foundAny = false;
		for (final Entry <Integer, DataRecordClass> e : map.entrySet ()) {
			if (c.contains (e.getValue ())) {
				map.remove (e.getKey ());
				changed ();
				foundAny = true;
			}
		}
		return foundAny;
	}

	/**
	 * @see java.util.Collection#retainAll(java.util.Collection)
	 */
	@Override
	public boolean retainAll (final Collection <?> c) {
		boolean foundAny = false;
		for (final Entry <Integer, DataRecordClass> e : map.entrySet ()) {
			if ( !c.contains (e.getValue ())) {
				map.remove (e.getKey ());
				changed ();
				foundAny = true;
			}
		}
		return foundAny;
	}


	/**
	 * @see java.util.Collection#size()
	 */
	@Override
	public int size () {
		return map.size ();
	}

	/**
	 * @see java.util.Collection#toArray()
	 */
	@Override
	public Object [] toArray () {
		return map.values ().toArray ();
	}

	/**
	 * @see java.util.Collection#toArray(R[])
	 */
	@Override
	public <R> R [] toArray (final R [] a) {
		return map.values ().toArray (a);
	}


}
