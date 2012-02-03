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
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.ConcurrentSkipListSet;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotImplementedException;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.events.EventType;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * A (possibly partial) collection of items that an user has collected;
 * c.v. ItemCollectionSet
 * 
 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
 */
public class UserItemCollection extends
SimpleDataRecord <UserItemCollection> implements
Collection <InventoryItem> {

    /**
     * Java serialization unique ID
     */
    private static final long serialVersionUID = -2212742414142718801L;
	
	/**
     * the items that this user has collected which are a part of this set
     */
    private final Set<InventoryItem> items = new ConcurrentSkipListSet <InventoryItem> ();

    /**
     * the owner of this collection
     */
    private AbstractUser owner = null;

    /**
     * the title of this set
     */
    private String title;

    /**
     * WRITEME: Document this brpocock@star-hope.org
     */
    private EventType rewardEvent;

    /**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param loader WRITEME
	 */
	public UserItemCollection (final RecordLoader <UserItemCollection> loader) {
		super (loader);
	}


    /**
     * @see java.util.Collection#add(java.lang.Object)
     */
    @Override
    public boolean add (final InventoryItem e) {
        final boolean change = items.add(e);
        if (change) {
            changed();
        }
        return change;
    }


    /**
     * @see java.util.Collection#addAll(java.util.Collection)
     */
    @Override
    public boolean addAll (final Collection <? extends InventoryItem> c) {
        final boolean change = items.addAll(c);
        if (change) {
            changed();
        }
        return change;
    }

    /**
     * @see java.util.Collection#clear()
     */
    @Override
    public void clear () {
        items.clear()
        ;changed();
    }

    /**
     * @see java.util.Collection#contains(java.lang.Object)
     */
    @Override
    public boolean contains (final Object o) {
        return items.contains(o);
    }

    /**
     * @see java.util.Collection#containsAll(java.util.Collection)
     */
    @Override
    public boolean containsAll (final Collection <?> c) {
        return items.containsAll(c);
    }
    /**
     * @see org.starhope.appius.util.DataRecord#getCacheableID()
     */
    @Override
    public int getCacheableID () throws NotFoundException {
        throw new NotFoundException (getCacheableIdent ());
    }

    /**
     * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
     */
    @Override
    public String getCacheableIdent () throws NotFoundException {
        return owner.getUserID () + "/" + title;
    }


    /**
     * @return the set of Items in this collection. Should return a
     *         HashSet.
     */
    public Collection <InventoryItem> getItems () {
        final HashSet <InventoryItem> returnSet = new HashSet <InventoryItem> ();
        returnSet.addAll (items);
        return returnSet;
    }




    /**
     * @return the owner of this collection
     */
    public AbstractUser getOwner () {
        return owner;
    }




    /**
     * @return the reward event for completing this collection
     */
    public EventType getRewardEvent () {
        return rewardEvent;
    }




    /**
     * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
     */
    @Override
    public String getSubversionRevision () {
        return "$Rev: 2188 $";
    }




    /**
     * @return the name of this collection
     */
    public String getTitle () {
        return title;
    }




    /**
     * @see java.util.Collection#isEmpty()
     */
    @Override
    public boolean isEmpty () {
        return items.isEmpty ();
    }




    /**
     * @see java.util.Collection#iterator()
     */
    @Override
    public Iterator <InventoryItem> iterator () {
        return items.iterator ();
    }




    /**
     * <pre>
     * twheys@gmail.com Mar 9, 2010
     * </pre>
     *
     * TO redeemCollectionForUser WRITEME...
     *
     * @param user WRITEME
     */
    public void redeemCollectionForUser (final AbstractUser user) {
        throw new RuntimeException(new NotImplementedException ());
    }




    /**
     * @see java.util.Collection#remove(java.lang.Object)
     */
    @Override
    public boolean remove (final Object o) {
        final boolean change = items.remove (o);
        if (change) {
            changed ();
        }
        return change;
    }




    /**
     * @see java.util.Collection#removeAll(java.util.Collection)
     */
    @Override
    public boolean removeAll (final Collection <?> c) {
        final boolean change = items.removeAll (c);
        if (change) {
            changed ();
        }
        return change;
    }




    /**
     * @see java.util.Collection#retainAll(java.util.Collection)
     */
    @Override
    public boolean retainAll (final Collection <?> c) {
        final boolean change = items.retainAll (c);
        if (change) {
            changed ();
        }
        return change;
    }




    /**
     * @param newOwner the owner to set
     */
    public void setOwner (final AbstractUser newOwner) {
        owner = newOwner; changed();
    }




    /**
     * @param newRewardEvent the rewardEvent to set
     */
    public void setRewardEvent (final EventType newRewardEvent) {
        rewardEvent = newRewardEvent;changed();
    }




    /**
     * @param newTitle the title to set
     */
    public void setTitle (final String newTitle) {
        title = newTitle; changed();
    }

    /**
     * @see java.util.Collection#size()
     */
    @Override
    public int size () {
        return items.size ();
    }

    /**
     * @see java.util.Collection#toArray()
     */
    @Override
    public Object [] toArray () {
        return items.toArray ();
    }

    /**
     * @see java.util.Collection#toArray(T[])
     */
    @Override
    public <T> T [] toArray (final T [] a) {
        return items.toArray (a);
    }





}
