/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.user;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.inventory.InventoryItemType;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * The Avatar Body Format is a description of the layout/structure of a
 * body of which a particular {@link AvatarClass} may subscribe. For
 * example, all avatars of a bipedal humanoid variety might share an
 * avatar body format, even if they represent humans, elves, bipedal
 * Toots, &c.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class AvatarBodyFormat extends
		SimpleDataRecord <AvatarBodyFormat> {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 3840223963034090764L;
	
	/**
	 * Numeric ID of the body format
	 */
	private int id;
	
	/**
	 * Name of the body format
	 */
	private String name;
	
	/**
	 * construct a new avatar body format
	 */
	public AvatarBodyFormat () {
		super (AvatarBodyFormat.class);
	}
	
	/**
	 * Default constructor for records being loaded from database
	 * 
	 * @param loader loader
	 */
	public AvatarBodyFormat (
			final RecordLoader <AvatarBodyFormat> loader) {
		super (loader);
	}
	
	/**
	 * Determine whether avatars using this body format are permitted
	 * to equip items of the given type. This is a veto authority, not
	 * an assertion of privilege: there could still be another reason
	 * why a particular user might not be permitted to equip the item.
	 * This, however, might e.g. prevent a dog from wearing human
	 * shoes.
	 * 
	 * @param type the {@link InventoryItemType} being
	 *             interrogated-against
	 * @return true, if avatars having this body format might
	 *         potentially equip an item of that type.
	 */
	public boolean canEquip (final InventoryItemType type) {
		return true; // FIXME
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof AvatarBodyFormat)) {
			return false;
		}
		final AvatarBodyFormat other = (AvatarBodyFormat) obj;
		if (id != other.id) {
			return false;
		}
		return true;
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
		return getName ();
	}
	
	/**
	 * @return the id
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
		return "$Rev: 2262 $";
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result) + id;
		return result;
	}
	
	/**
	 * @param newID the id to set
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
	
}
