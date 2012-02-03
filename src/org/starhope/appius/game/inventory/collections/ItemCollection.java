/**
 * <p>
 * Copyright © 2010, Tim Heys
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
 * @author twheys@gmail.com
 */
package org.starhope.appius.game.inventory.collections;

import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.inventory.GenericItemReference;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.events.EventType;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * WRITEME: Document this type.
 *
 * @author twheys@gmail.com
 * @author brpocock@star-hope.org
 */
public class ItemCollection extends SimpleDataRecord <ItemCollection>
implements Collection <GenericItemReference>
{
    /**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 5869990447794687083L;
	/**
     * Internal implementation pass-through collection
     */
    private final List <GenericItemReference> set = new LinkedList <GenericItemReference> ();
    /**
     * Unique name of the collection
     */
    private String title;
    /**
     * Unique ID of the collection
     */
    private int collectionID;

    /**
     * event fired when the user completes the collection
     */
    private EventType onCompleteEvent = null;
    /**
     * event fired when a previously-complete collection is broken
     */
    private EventType onBreakEvent = null;

	/**
	 * constructor for collection being loaded
	 * 
	 * @param loader WRITEME
	 */
    ItemCollection (final RecordLoader <ItemCollection> loader) {
		super (loader);
    }

	/**
	 * constructor to create a new collection
	 * 
	 * @param newName WRITEME
	 * @throws AlreadyExistsException if the name is in use already
	 */
    ItemCollection (final String newName) throws AlreadyExistsException {
		super (ItemCollection.class);
        try {
            Nomenclator.getDataRecord (ItemCollection.class, newName);
            throw new AlreadyExistsException (newName);
        } catch (final NotFoundException e) {
            // good!
        }
        title = newName;
        collectionID = -1;
		markAsLoaded ();
    }

    /**
     * @see java.util.Collection#add(java.lang.Object)
     */
    @Override
    public boolean add (final GenericItemReference e) {
        final boolean b = set.add (e);
        if (b) {
            changed ();
        }
        return b;
    }

    /**
     * @see java.util.Collection#addAll(java.util.Collection)
     */
    @Override
    public boolean addAll (final Collection <? extends GenericItemReference> c) {
        final boolean b = set.addAll (c);
        if (b) {
            changed ();
        }
        return b;
    }

    /**
     * @see java.util.Collection#clear()
     */
    @Override
    public void clear () {
        set.clear ();
        changed ();
    }

    /**
     * @see java.util.Collection#contains(java.lang.Object)
     */
    @Override
    public boolean contains (final Object o) {
        return set.contains (o);
    }

    /**
     * @see java.util.Collection#containsAll(java.util.Collection)
     */
    @Override
    public boolean containsAll (final Collection <?> c) {
        return set.containsAll (c);
    }

    /**
     * Return an item from a specific position in the set
     * @param i index
     * @return the item at that position
     */
    public GenericItemReference get (final int i) {
        return set.get (i);
    }

    /**
     * @see org.starhope.appius.util.DataRecord#getCacheableID()
     */
    @Override
    public int getCacheableID () throws NotFoundException {
        return collectionID;
    }

    /**
     * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
     */
    @Override
    public String getCacheableIdent () throws NotFoundException {
        return title;
    }

    /**
     * @return the onBreakEvent
     */
    public EventType getOnBreakEvent () {
        return onBreakEvent;
    }


    /**
     * @return the onCompleteEvent
     */
    public EventType getOnCompleteEvent () {
        return onCompleteEvent;
    }

    /**
     * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
     */
    @Override
    public String getSubversionRevision () {
        return "$Rev: 2188 $";
    }

    /**
     * @see java.util.Collection#isEmpty()
     */
    @Override
    public boolean isEmpty () {
        return set.isEmpty ();
    }

    /**
     * @see java.util.Collection#iterator()
     */
    @Override
    public Iterator <GenericItemReference> iterator () {
        return set.iterator ();
    }

    /**
     * @see java.util.Collection#remove(java.lang.Object)
     */
    @Override
    public boolean remove (final Object o) {
        final boolean b = set.remove (o);
        if (b) {
            changed ();
        }
        return b;
    }

    /**
     * @see java.util.Collection#removeAll(java.util.Collection)
     */
    @Override
    public boolean removeAll (final Collection <?> c) {
        final boolean b = set.removeAll (c);
        if (b) {
            changed ();
        }
        return b;
    }

    /**
     * @see java.util.Collection#retainAll(java.util.Collection)
     */
    @Override
    public boolean retainAll (final Collection <?> c) {
        final boolean b = set.retainAll (c);
        if (b) {
            changed ();
        }
        return b;
    }

    /**
     * @param newID the ID for this collection
     */
    public void setID (final int newID) {
        collectionID = newID;
        changed ();
    }

    /**
     * @param newOnBreakEvent the onBreakEvent to set
     */
    public void setOnBreakEvent (final EventType newOnBreakEvent) {
        onBreakEvent = newOnBreakEvent;
        changed ();
    }

    /**
     * @param newOnCompleteEvent the onCompleteEvent to set
     */
    public void setOnCompleteEvent (final EventType newOnCompleteEvent) {
        onCompleteEvent = newOnCompleteEvent;
        changed ();
    }

    /**
     * @param newTitle the new title of the collection
     */
    public void setTitle (final String newTitle) {
        title = newTitle;
        changed ();
    }

    /**
     * @see java.util.Collection#size()
     */
    @Override
    public int size () {
        return set.size ();
    }

    /**
     * @see java.util.Collection#toArray()
     */
    @Override
    public Object [] toArray () {
        return set.toArray ();
    }

    /**
     * @see java.util.Collection#toArray(T[])
     */
    @Override
    public <T> T [] toArray (final T [] a) {
        return set.toArray (a);
    }

}
