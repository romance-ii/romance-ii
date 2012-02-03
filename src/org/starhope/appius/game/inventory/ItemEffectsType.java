/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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
package org.starhope.appius.game.inventory;

import java.util.WeakHashMap;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 */
public class ItemEffectsType extends SimpleDataRecord <ItemEffectsType> {

	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 493203430706748669L;

	/**
	 * Caché of instantiated item effects for various items, set up such
	 * that they should expire when the items are unloaded from core by
	 * virtue of their weak references.
	 */
	private final WeakHashMap <InventoryItem, ItemEffects> fxLib = new java.util.WeakHashMap <InventoryItem, ItemEffects> ();

	/**
	 * The database ID for this effects type
	 */
	private int id;

	/**
	 * The class name for this type of effects
	 */
	private String klass;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 */
	public ItemEffectsType () {
		super (ItemEffectsType.class);
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param loader WRITEME
	 */
	public ItemEffectsType (
			final RecordLoader <ItemEffectsType> loader) {
		super (loader);
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return getID ();
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return klass;
	}

	/**
	 * @return the klass
	 */
	public String getHandlerClass () {
		return klass;
	}

	/**
	 * @return the id
	 */
	public int getID () {
		return id; /* TODO brpocock@star-hope.org */
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param item WRITEME
	 * @return WRITEME
	 */
	private synchronized ItemEffects getInstanceFor (
			final InventoryItem item) {
		return fxLib.get (item);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param item WRITEME
	 * @return WRITEME
	 * @throws NotFoundException WRITEME
	 */
	public ItemEffects getItemEffectsInstance (final InventoryItem item)
	throws NotFoundException {
		ItemEffects o = getInstanceFor (item);
		if (null == o) {
			try {
				o = (ItemEffects) Class.forName (getHandlerClass ())
						.getConstructor (InventoryItem.class)
				.newInstance (item);
			} catch (final Exception e) {
				throw new NotFoundException (e);
			}
		}
		return o;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}

	/**
	 * @param newClassName the klass to set
	 */
	public void setHandlerClass (final String newClassName) {
		klass = newClassName; changed();
	}
	
	/**
	 * @param newID the id to set
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param item WRITEME
	 * @param fx WRITEME
	 * @return WRITEME
	 */
	public synchronized ItemEffects setInstanceFor (
			final InventoryItem item, final ItemEffects fx) {
		fxLib.put (item, fx);
		return fx;
	}

}
