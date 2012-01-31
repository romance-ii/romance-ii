/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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
 * License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */

package org.starhope.appius.game.inventory;

import java.util.HashSet;
import java.util.Set;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.util.types.Pair;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys Timothy W. Heys
 */
public class InventoryItemType extends
		SimpleDataRecord <InventoryItemType> {
	
	/**
	 * Java serialization unique ID
	 */
	private static final long serialVersionUID = 8514877584411321981L;
	
	/**
	 * Get an item type by name.
	 * 
	 * @param string The name
	 * @return the item, or null, if it's not found
	 * @deprecated use {@link Nomenclator#getDataRecord(Class, String)}
	 *             and catch the potential NotFoundException
	 */
	@Deprecated
	public static InventoryItemType get (final String string) {
		try {
			return Nomenclator.getDataRecord (
					InventoryItemType.class, string);
		} catch (final NotFoundException e) {
			return null;
		}
	}
	
	/**
	 * Types that conflict (can't be equipped at the same time)
	 */
	private Set <Integer> conflicts;
	
	/**
	 * Boolean: whether to observe valence levels (or not)
	 */
	private boolean hasValences = false;
	
	/**
	 * Unique ID
	 */
	private int id;
	
	/**
	 * Unique name
	 */
	private String name;
	
	/**
	 * Valence levels. See {@link #getValences()} for discussion.
	 */
	private final Set <Pair <Integer, Integer>> valences = new HashSet <Pair <Integer, Integer>> ();
	
	/**
	 * Nil constructor
	 */
	public InventoryItemType () {
		super (InventoryItemType.class);
		valences.add (new Pair <Integer, Integer> (Integer
				.valueOf (0), Integer.valueOf (1)));
	}
	
	/**
	 * constructor to be used in the
	 * 
	 * @param loader the record loader
	 */
	public InventoryItemType (
			final RecordLoader <InventoryItemType> loader) {
		super (loader);
	}
	
	/**
	 * Add a conflict
	 * 
	 * @param typeID with which item type
	 */
	public void conflictWith (final int typeID) {
		conflicts.add (Integer.valueOf (typeID));
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return id;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return getName ();
	}
	
	/**
	 * @return the conflicts
	 */
	public Set <Integer> getConflicts () {
		final HashSet <Integer> set = new HashSet <Integer> ();
		set.addAll (conflicts);
		return set;
	}
	
	/**
	 * @return the unique ID for this item type
	 */
	public int getID () {
		return id;
	}
	
	/**
	 * @return the name
	 */
	public String getName () {
		return name;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}
	
	/**
	 * <p>
	 * Get the integral valence levels supported for this item type.
	 * Valences are specific sub-slots with a fixed ordering, typically
	 * numbered by 100's or 1000's (to allow for future expansion of
	 * additional valence levels), of items which otherwise appear
	 * basically similar. For example, the following are defined as the
	 * valence levels for <em>Li'l Vampies</em> for the <em>Shirt</em>
	 * slot:
	 * </p>
	 * <ul>
	 * <li>1000 — under-shirt (US) / vest (UK)</li>
	 * <li>2000 — T-shirt</li>
	 * <li>3000 — shirt</li>
	 * <li>4000 — vest (US) / waist-coat (UK)</li>
	 * <li>5000 — jacket</li>
	 * <li>6000 — coat (US) / over-coat (UK)</li>
	 * </ul>
	 * <p>
	 * Valences and slots provide the first part of the item-to-item
	 * conflicts system. There are three parts, altogether. See
	 * {@link ItemManager} for an explanation.
	 * 
	 * @return the valence levels supported for this item type, and the
	 *         quantity of items which can be inserted at each valence
	 *         level.
	 */
	public Set <Pair <Integer, Integer>> getValences () {
		if (false == hasValences) {
			valences.clear ();
			valences.add (new Pair <Integer, Integer> (Integer
					.valueOf (0), Integer
					.valueOf (Integer.MAX_VALUE)));
		}
		return valences;
	}
	
	/**
	 * Determine whether this slot permits a certain number of items to
	 * be mounted in non-conflicting valence levels, indicated by the Z
	 * depth of the items. An item type that only allows one instance
	 * per slot will have a single valence level (e.g. perhaps “hair”),
	 * while an item type that might have a couple of distinct levels
	 * which could conflict only within a valence level (e.g.
	 * under-shirt, shirt, vest, jacket, coat) would have multiples.
	 * 
	 * @return true, if this item type respects valence levels (limits
	 *         the number of items mounted to it). False indicates that
	 *         any number of items can be equipped in this slot,
	 *         without limits.
	 */
	public boolean hasValences () {
		return hasValences;
	}
	
	/**
	 * Do items of this type conflict with other items of this type?
	 * 
	 * @return whether having an item of this type equipped should
	 *         prevent equipping another item of this type
	 */
	public boolean isSiblingRival () {
		return conflicts.contains (Integer.valueOf (id));
	}
	
	/**
	 * Remove a conflict
	 * 
	 * @param typeID with which item type
	 */
	public void noConflictWith (final int typeID) {
		conflicts.remove (Integer.valueOf (typeID));
	}
	
	/**
	 * Remove valence effects from this type; set it to have a single
	 * valence level (at zero) permitting {@link Integer#MAX_VALUE}
	 * items
	 */
	public void removeValences () {
		hasValences = false;
		valences.clear ();
		valences.add (new Pair <Integer, Integer> (Integer
				.valueOf (0), Integer.valueOf (Integer.MAX_VALUE)));
	}
	
	/**
	 * @param newID set the ID
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}
	
	/**
	 * @param newName the name to set
	 */
	public void setName (final String newName) {
		name = newName;
		changed ();
	}
	
	/**
	 * Set this type to a singleton valence: one valence level (at
	 * zero) permitting only a single item.
	 */
	public void setSingularValence () {
		hasValences = true;
		valences.clear ();
		valences.add (new Pair <Integer, Integer> (Integer
				.valueOf (0), Integer.valueOf (1)));
	}
	
	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#toString()
	 */
	@Override
	public String toString () {
		return "#" + id + "=" + name;
	}
	
}
