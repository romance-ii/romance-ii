/**
 * <p>
 * Copyright © 2010, brpocock@star-hope.org
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
 * @author twheys@gmail.com
 */
package org.starhope.appius.game.inventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.ConcurrentSkipListSet;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.types.Colour;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.UserTransientEffects;
import org.starhope.appius.user.UserTransients;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecordSet;
import org.starhope.util.LibMisc;

/**
 * <p>
 * The Inventory represent an SQL-backed set of {@link InventoryItem}
 * objects owned by a given user.
 * </p>
 *
 * @author brpocock@star-hope.org
 * @author twheys@gmail.com
 */
public class Inventory extends
SimpleDataRecordSet <InventoryItem, Inventory> {

    /**
     * WRITEME: Document this brpocock@star-hope.org
     */
    private static final long serialVersionUID = 3303661907168440573L;

    /**
     * The internal cache of the user's inventory is kept in this set
     */
    ConcurrentSkipListSet <InventoryItem> items = new ConcurrentSkipListSet <InventoryItem> ();

    // /**
    // * instantiate the inventory for a given user
    // *
    // * @param newOwner the user (owner) whose inventory is being
    // loaded
    // */
    // protected Inventory (final AbstractUser newOwner) {
    // super(Inventory.class, newOwner.getUserID ());
    // ownerID = newOwner.getUserID ();
    // fetch ();
    // }

    // /**
    // * instantiate the inventory for the user with the given ID
    // *
    // * @param userID owner id
    // */
    // public Inventory (final int userID) {
    // ownerID = userID;
    // fetch ();
    // }

    // /**
    // * instantiate the inventory for the given user record
    // *
    // * @param userRecord the user whose inventory is to be
    // instantiated
    // */
    // public Inventory (final UserRecord userRecord) {
    // ownerID = userRecord.getUserID ();
    // fetch ();
    // }

	/**
     * The user whose inventory is represented by this object
     */
private AbstractUser owner;

	/**
     * Create an empty inventory for the given user. You'd better be damnsure that this is actually
     * a new user, and really, this should only be called from within the UserRecord constructor for
     * new users, or people will lose things.
     *
     * @param newOwner The owner, who had better be in the process of instantiation himself.
     */
	// public Inventory (final UserRecord newOwner){
	// super (Inventory.class);
	// owner=Nomenclator.getUserByID (newOwner.getUserID ()
	// );
	// }

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param loader WRITEME
	 */
	public Inventory (
			final RecordLoader <SimpleDataRecordSet <InventoryItem, Inventory>> loader) {
		super (loader);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param example WRITEME
	 */
    public void add (final GenericItemReference example) {
        add (example.getItemID ());
    }

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param itemID the ID of a new item to be added
	 * @return the item created and added
	 */
    public InventoryItem add (final int itemID) {
        final InventoryItem newItem = InventoryItem.getByID (itemID);
        add (newItem);
        return newItem;
    }

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#add(java.lang.Object)
	 */
    @Override
    public boolean add (final InventoryItem item) {
        if (item.getSlotNumber () < 1) {
            flush (item);
        }

        final boolean b = items.add (item);

		if (null != owner
				&& (null == item.getOwner () || !item.getOwner ()
						.equals (getOwner ()))) {
            item.setOwner (item.getOwner());
			if (b) {
				flush (item);
			}
        }

        return b;
    }

    /**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#addAll(java.util.Collection)
	 */
    @Override
    public boolean addAll (final Collection <? extends InventoryItem> c) {
		final AbstractUser myOwner = getOwner ();
		if (null == c || c.contains (null)) {
            try {
                // Trace stack
                throw new Exception (
                        "Someone tried to add a null item to inventory of "
								+ myOwner.getDebugName ());
            } catch (final Exception e) {
                AppiusClaudiusCaecus.reportBug (e);
                return false;
            }
        }

        final boolean b = items.addAll (c);

        for (final InventoryItem i : c) {
			if (null == i.getOwner ()
					|| !i.getOwner ().equals (myOwner)) {
				i.setOwner (myOwner);
            }
            flush (i);
        }

        return b;
    }

	/**
     * @see #addDefaultFreeItem(int, boolean)
     * @param i item ID
     * @return the item added
     */
    public InventoryItem addDefaultFreeItem (final int i) {
        return addDefaultFreeItem (i, false);
    }

	/**
	 * Add an item which every user gets for free to the user's
	 * inventory, if it does not already exist. This method is used to
	 * enforce a minimum inventory upon users. Examples of default free
	 * items include the Basic 8 Toots patterns, and the default
	 * TootBook theme.
	 *
	 * @param id the item ID
	 * @param forceActive if true, force the item to be active upon
	 *            adding it to the user's inventory
	 * @return an item of that kind; either one that was already in
	 *         inventory and found, or a new one that was placed there.
	 */
    public InventoryItem addDefaultFreeItem (final int id,
            final boolean forceActive) {
        final InventoryItem oldItem = findItem (id);
        if (null != oldItem) {
            if (forceActive) {
                try {
                    final InventoryItem currItem = getActiveItemByType (oldItem
                            .getType ());
                    doff (currItem);
                } catch (NotFoundException e) { // Do nothing
                }
                don (oldItem, null);
            }
            return oldItem;
        }
        final InventoryItem newItem = InventoryItem.getByID (id);
        add (newItem);
        if (forceActive) {
            don (newItem, null);
        }
        if (newItem.getOwnerID () != getOwnerID ()) {
            newItem.destroy ();
            AppiusClaudiusCaecus.reportBug ("Greedy");
        }
        return newItem;

    }

	/**
	 * This is an overriding method. XXX: contains SQL
	 *
	 * @see java.util.Collection#clear()
	 */
    @Override
    public void clear () {
        for (final InventoryItem item : items) {
            item.destroy ();
        }
        items.clear ();
        Connection con = null;
        PreparedStatement st = null;
        try {
            con = AppiusConfig.getDatabaseConnection ();
            st = con
					.prepareStatement ("DELETE FROM inventory WHERE userID=?");
            st.setInt (1, getOwner ().getUserID ());
            st.execute ();
        } catch (final SQLException e) {
            AppiusClaudiusCaecus.reportBug (
                    "Caught a SQLException in clear", e);
        } finally {
            LibMisc.closeAll (st, con);
        }
    }

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#contains(java.lang.Object)
	 */
    @Override
    public boolean contains (final Object o) {
        if (null == o) {
            return false;
        }
        // TO DO Fix this so that it handles 'store' items
        if (o instanceof Integer) {
            return hasItem ( ((Integer) o).intValue ());
        }
        if ( ! (o instanceof InventoryItem)) {
            return false;
        }
        for (final InventoryItem i : items) {
            if (i.equals (o)) {
                return true;
            }
        }
        return false;
    }

	/**
	 * This is an overriding method.
	 *
	 * @see java.util.Collection#containsAll(java.util.Collection)
	 */
    @Override
    public boolean containsAll (final Collection <?> c) {
        for (final Object o : c) {
            if ( !contains (o)) {
                return false;
            }
        }
        return true;
    }

	/**
	 * Doff a wearable item
	 *
	 * @see Inventory#don(InventoryItem,Colour)
	 * @param item the item to be removed
	 */
    public void doff (final InventoryItem item) {
		try {
			if (ItemManager.get (getOwner ()).noteDeEquip (item)) {
				item.setActive (false);
				try {
					item.getItemEffects ().onDeEquip ();
				} catch (final NotFoundException e) {
					// no op
				}
			}
		} catch (NotFoundException e) {
			// no effects if no ItemManager; so no op
		}
    }

	/**
	 * Un-equip all items of a type
	 *
	 * @param type the item type, of which all items are to be
	 *            deactivated
	 */
    public void doff (final InventoryItemType type) {
        for (final InventoryItem i : items) {
            if (i.getType ().equals (type)) {
                doff (i);
            }
        }
    }

	/**
	 * Put on a wearable item, to include Pivitz as well as clothing and
	 * so forth.
	 *
	 * @param item The item to be worn
	 * @param colour The color to set for the item. If the colour is not
	 *            being overridden, set this to null.
	 */
    public void don (final InventoryItem item, final Colour colour) {
        InventoryItemType patternType;
        try {
            patternType = Nomenclator.getDataRecord (
                    InventoryItemType.class, "Pattern");
            if (item.getGenericItem ().getItemType ().equals (patternType)) {
                final Collection <InventoryItem> patterns = getActiveItemsByType (patternType);
				if (patterns.size () == 1
						&& patterns.toArray () [0].equals (item)) {
						// ignore.
					item.setColour (0, colour);
						return;
				}
                if (patterns.size () > 0) {
                    BugReporter
                    .getReporter ("srv")
                    .reportBug (
                            "Have "
                            + patterns.size ()
                            + " pattern(s) active, and activating additional pattern here.");
                }
            }
        } catch (final NotFoundException e) {
            // No op. There are no patterns here, so it must not be a
            // problem.
        }
		try {
			if (ItemManager.get (getOwner ()).noteEquip (item)) {
				item.setActive (true);
				try {
					item.getItemEffects ().onEquip ();
				} catch (final NotFoundException e) {
					// no op
				}
			}
		} catch (NotFoundException e) {
			// no effects if no ItemManager, so no-op
		}
        if (null != colour) {
            item.setColour (0, colour);
        }
    }

	/**
	 * Checks if an item with the ID of parameter id is contained in the
	 * set, and if so, returns it.
	 *
	 * @param id the item ID of the item being checked
	 * @return an instance of the given item ID, if any is in inventory.
	 */
    public InventoryItem findItem (final int id) {
        final Iterator <InventoryItem> i = items.iterator ();
        while (i.hasNext ()) {
            final InventoryItem item = i.next ();
            if (item.getID () == id) {
                return item;
            }
        }
        return null;
    }

	/**
	 * Update an individual item in the database if necessary. Handles
	 * some typecasting badness required to make everyone happy.
	 *
	 * @param o an object that's probably an InventoryItem
	 */
    @SuppressWarnings ("unchecked")
    private void flush (final Object o) {
		if (null == owner) {
			// AppiusClaudiusCaecus
			// .reportBug
			// ("I haven't gotten an owner, myself. How can I share it?");
			return;
		}
        if ( ! (o instanceof InventoryItem)) {
            return;
        }
        final InventoryItem item = (InventoryItem) o;
        if (items.contains (o)) {
            item.setOwner (getOwner ());
        } else {
            final AbstractUser itemOwner = item.getOwner ();
			if (null == itemOwner) {
                item.destroy ();
            }
        }
        if (item.getSlotNumber () < 1) {
			RecordLoader <InventoryItem> loader = (RecordLoader <InventoryItem>) item
					.getRecordLoader ();
			if (null != loader) {
				loader .saveRecord (item);
			}
        }
    }

	/**
	 * Get all active clothing items in a collection. Clothing item
	 * types are defined in the configuration file as
	 * <code>org.starhope.appius.game.inventory.clothingTypes</code>;
	 * this routine, in turn, uses
	 * {@link #getActiveItemsByType(Collection)}.
	 *
	 * @return The collection of all active inventory items of any type
	 *         identified in the clothingTypes list
	 */
    public Collection <InventoryItem> getActiveClothing () {
        final Set <InventoryItemType> clothingTypes = new HashSet <InventoryItemType> ();
        for (final String clothingType : AppiusConfig
                .getList ("org.starhope.appius.inventory.clothingTypes")) {
            try {
                clothingTypes.add (Nomenclator.getDataRecord (
                        InventoryItemType.class, Integer
                        .parseInt (clothingType)));
            } catch (final Exception e) {
                BugReporter.getReporter ("srv").reportBug (e);
            }
        }
        return getActiveItemsByType (clothingTypes);
    }

    /**
	 * Get the set of all clothing being worn (as a JSON object). This
	 * uses {@link #getActiveClothing()} to identify clothes, and
	 * creates a JSON array-type map
	 *
	 * @return all clothing items that are active (being worn)
	 */
    public JSONObject getActiveClothing_JSON () {
        final JSONObject clothes = new JSONObject ();
        int n = 0;
        for (final InventoryItem item : getActiveClothing ()) {
            try {
                clothes.put (String.valueOf (n++ ), item.toJSON ());
            } catch (final JSONException e) {
                AppiusClaudiusCaecus.reportBug (e);
            }
        }
        return clothes;
    }

    /**
     * Find a singular active item of a type. This call will guarantee
     * that some item will be active, and only one; other active items
     * of the type will be ignored, but if no item is active, one will
     * be forced to become active.
     *
     * @param inventoryItemType a type
     * @return a single active item
     * @throws NotFoundException if the user has no items of the given
     *             type
     */
    public InventoryItem getActiveItemByType (
            final InventoryItemType inventoryItemType)
    throws NotFoundException {
        final Collection <InventoryItem> set = getActiveItemsByType (inventoryItemType);
        if (set.size () == 0) {
            final Collection <InventoryItem> all = getItemsByType (inventoryItemType);
            if (all.size () == 0) {
                throw new NotFoundException (inventoryItemType
                        .toString ());
            }
            final InventoryItem first = all.iterator ().next ();
            don (first, null);
            return first;
        }
        return set.iterator ().next ();
    }

    /**
     * @param types a set of types of items to be searched
     * @return all items of any of the types which are active
     */
    public Collection <InventoryItem> getActiveItemsByType (
            final Collection <InventoryItemType> types) {
        final UserTransientEffects fx = UserTransients
        .getEffects (getOwner ());
        final HashSet <InventoryItem> results = new HashSet <InventoryItem> ();
        results.addAll (fx.addItems);
        for (final InventoryItem i : getItemsByType (types)) {
            if (i.isActive () && !fx.removeItems.contains (i)) {
                results.add (i);
                // XXX Works, but probably shouldn't have this here to
                // just take care of the case of activating items on
                // login
                try {
                    i.getItemEffects ().onEquip ();
                } catch (NotFoundException e) {
					// no op
                }
            }
        }
        return results;
    }

    /**
     * @param t the item type in question
     * @return all active items of that type
     */
    public Collection <InventoryItem> getActiveItemsByType (
            final InventoryItemType t) {
        final HashSet <InventoryItemType> types = new HashSet <InventoryItemType> ();
        types.add (t);
        return getActiveItemsByType (types);
    }

    /**
     * @see org.starhope.appius.util.DataRecord#getCacheableID()
     */
    @Override
    public int getCacheableID () throws NotFoundException {
		if (null == owner) {
			throw new NotFoundException ("No owner yet");
		}
		return owner.getUserID ();
    }

    /**
     * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
     */
    @Override
    public String getCacheableIdent () throws NotFoundException {
        throw new NotFoundException ("no string ID");
    }
	
	/**
	 * Returns a count of the given item in the inventory by id
	 * 
	 * @param itemID ID of the item
	 * @return How many items with that ID are in the inventory
	 */
	public int getCount (final int itemID) {
		int result = 0;
		for (InventoryItem item : items) {
			if (item.getItemID () == itemID)
				result++ ;
		}
		return result;
	}
	
	/**
	 * Get the set of equipped items which are either ACTIVE or PASSIVE.
	 * 
	 * @param includePassive whether to include PASSIVE equipped items,
	 *            as well.
	 * @return the set of all equipped ACTIVE items and possibly all
	 *         PASSIVE items as well
	 */
    public Collection <InventoryItem> getEquippedItems (
            final boolean includePassive) {
        final Collection <InventoryItem> allEquipped = new HashSet <InventoryItem> ();
        for (final InventoryItem i : items) {
            if ( !i.isActive ()) {
                continue;
            }
            final EquipType equipType = i.getGenericItem ().getEquipType ();
            switch (equipType) {
            case ACTIVE:
                allEquipped.add (i);
                break;
            case PASSIVE:
                if (includePassive) {
                    allEquipped.add (i);
                }
                break;
            case SILENT:
            default:
                // no op
                break;
            }
        }
        return allEquipped;
    }

	/**
     * @see #getEquippedItems(boolean)
     * @return the output as a JSON list
     */
    public JSONObject getEquippedItems_JSON () {
        final Collection <InventoryItem> equipped = getEquippedItems (true);
        final JSONObject o = new JSONObject ();
        int i = 0;
        for (final InventoryItem item : equipped) {
            try {
                o.put (String.valueOf (i++ ), item.toJSON ());
            } catch (final JSONException e) {
                AppiusClaudiusCaecus.reportBug (
                        "Caught a JSONException in Inventory.getEquippedItems_JSON "
                        + item.toString (), e);
            }
        }
        return o;
    }

	/**
	 * Get a home décor (furniture or structure) item from this user's
	 * inventory by its slot number. NOTE also works for any other type
	 * of item, now
	 *
	 * @param slotNumber the slot number for the user's inventory
	 * @return the home décor item in the given inventory slot; or null,
	 *         if none is found
	 * @throws NotFoundException if the item is not found.
	 */
    public InventoryItem getFurnitureBySlot (final int slotNumber)
    throws NotFoundException {
        for (final InventoryItem i : items) {
            if (i.getSlotNumber () == slotNumber) {
                return i;
            }
        }
        throw new NotFoundException (String.valueOf (slotNumber));
    }

	/**
	 * get all items of given types
	 *
	 * @param types the types
	 * @return all items of the given types
	 */
    public Collection <InventoryItem> getItemsByType (
            final Collection <InventoryItemType> types) {
        final Collection <InventoryItem> set = new HashSet <InventoryItem> ();
        for (final InventoryItem i : items) {
            if (types.contains (i.getType ())) {
                set.add (i);
            }
        }
        return set;
    }

    /**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param inventoryItemType WRITEME
	 * @return WRITEME
	 */
    public Collection <InventoryItem> getItemsByType (
            final InventoryItemType inventoryItemType) {
        final HashSet <InventoryItemType> types = new HashSet <InventoryItemType> ();
        types.add (inventoryItemType);
        return getItemsByType (types);
    }


    /**
     * @return the owner of this inventory
     */
    public AbstractUser getOwner () {
        return owner;
    }

	/**
	 * @return the owner's user ID
	 */
    public int getOwnerID () {
		if (null == owner) {
			return -1;
		}
		return owner.getUserID ();
    }

    /**
     * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
     */
    @Override
    public String getSubversionRevision () {
        return "$Rev: 2234 $";
    }

    /**
     * @param itemID the type of item being searched-for
     * @return true, if the user has such an item equipped (active)
     */
    public boolean hasEquipped (final int itemID) {
        for (final InventoryItem item : items) {
            if (item.active && item.itemID == itemID) {
                return true;
            }
        }
        return false;
    }
	
	/**
	 * Checks if an item with the ID of parameter id is contained in the
	 * set.
	 * 
	 * @param id the item ID of the item being checked
	 * @return true if the item is in the set, false if the item is not
	 *         in the set
	 */
    public boolean hasItem (final int id) {
        final Iterator <InventoryItem> i = items.iterator ();
        while (i.hasNext ()) {
            final InventoryItem item = i.next ();
            if (item.getID () == id) {
                return true;
            }
        }
        return false;
    }
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#isEmpty()
	 */
    @Override
    public boolean isEmpty () {
        return items.isEmpty ();
    }
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#iterator()
	 */
    @Override
    public Iterator <InventoryItem> iterator () {
        return items.iterator ();
    }

    /**
     * Notify the owner of a change to equipped items
     */
    public void notifyEquipChange () {
		final AbstractUser myOwner = getOwner ();
		myOwner.acceptSuccessReply ("equip", getEquippedItems_JSON (),
				myOwner.getRoom ());
    }

    /**
     * This is an overriding method.
     *
     * @see java.util.Collection#remove(java.lang.Object)
     */
    @Override
    public boolean remove (final Object o) {
        if ( ! (o instanceof InventoryItem)) {
            return false;
        }
		if ( ((InventoryItem) o).isActive ()) {
			doff ((InventoryItem) o);
		}
		final boolean b = items.remove (o);
		if (b) {
			changed ();
		}
		return b;
    }

    /**
     * This is an overriding method.
     *
     * @see java.util.Collection#removeAll(java.util.Collection)
     */
    @Override
    public boolean removeAll (final Collection <?> c) {
        final boolean b = items.removeAll (c);
        for (final Object o : c) {
            flush (o);
        }
        return b;
    }

    /**
     * This is an overriding method.
     *
     * @see java.util.Collection#retainAll(java.util.Collection)
     */
    @Override
    public boolean retainAll (final Collection <?> c) {
        final HashSet <InventoryItem> copyItems = new HashSet <InventoryItem> (
                items);
        final boolean b = items.retainAll (c);
        for (final InventoryItem i : copyItems) {
            flush (i);
        }
        return b;
    }

    /**
	 * Set the owner of this inventory
	 * @param newOwner the new owner
	 */
	private void setOwner (final AbstractUser newOwner) {
		owner =  newOwner;
		changed();
	}

    /**
     * WRITEME: Document this method brpocock@star-hope.org
     *
     * @param userID WRITEME
     */
    public void setOwnerID (final int userID) {
		if (1 > userID) {
			setOwner (null);
		} else {
			setOwner (Nomenclator.getUserByID (userID)
					);
		}
    }

	/**
	 * Activate one structural element in lieu of any others that occupy
	 * the same slot.
	 * 
	 * @param item the structural item
	 */
    public void setStructure (final InventoryItem item) {
        for (final InventoryItem each : items) {
            if (each.getTypeID () == item.getTypeID ()) {
                doff (each);
            }
        }
		item.setOwner (getOwner ());
        don (item, null);
    }

    /**
     * This is an overriding method.
     *
     * @see java.util.Collection#size()
     */
    @Override
    public int size () {
        return items.size ();
    }

    /**
     * This is an overriding method.
     *
     * @see java.util.Collection#toArray()
     */
    @Override
    public Object [] toArray () {
        return items.toArray ();
    }

    /**
     * This is an overriding method.
     *
     * @see java.util.Collection#toArray(T[])
     */
    @Override
    public <T> T [] toArray (final T [] a) {
        return items.toArray (a);
    }

    /**
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString () {
        final StringBuilder s = new StringBuilder ();
        s.append ('[');
        for (final InventoryItem i : items) {
            s.append ('(');
            s.append (i.toString ());
            s.append (')');
        }
        s.append (']');
        return s.toString ();
    }
}
