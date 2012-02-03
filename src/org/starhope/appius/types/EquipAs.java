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

package org.starhope.appius.types;

/**
 * 
 * This is basically a super-Enum which contains the types of equipment
 * that are hard-coded in the database, and can tell us a few things
 * about them.
 * 
 * @author brpocock@star-hope.org
 * 
 */
public class EquipAs {
	/**
	 * This is the real, nested enum. We basically "fake it" by
	 * implementing the Enum view wrapped around this to provide some
	 * enhanced functionality.
	 * 
	 * @author brpocock@star-hope.org
	 * 
	 */
	public enum Values {
		/**
		 * Backpack or similar
		 */
		BACK,
		/**
		 * the ceiling of a decorated room
		 */
		CEILING,
		/**
		 * ear coverings, earrings, earmuffs, &c.
		 */
		EARS,
		/**
		 * eyewear, eyeglasses, &c.
		 */
		EYES,
		/**
		 * the floor of a decorated room
		 */
		FLOOR,
		/**
		 * something that follows around the player like a puppy
		 */
		FOLLOW,
		/**
		 * gloves or similar
		 */
		GLOVES,
		/**
		 * hat, helmet, head covering
		 */
		HAT,
		/**
		 * Not equipped. Used for inventory, not valid for items
		 * themselves.
		 */
		INVENTORY,
		/**
		 * invisibly equips. Item equips, but isn't seen to be equipped.
		 * Magic spells might do this, don't know what else
		 */
		INVIS,
		/**
		 * Neckwear, e.g. tie, bolo, &c.
		 */
		NECK,
		/**
		 * one-handed carry item, e.g. flashlight
		 */
		ONE_HAND,
		/**
		 * thing orbiting around the character, primarily Orbitz for
		 * Tootsville
		 */
		ORBITAL,
		/**
		 * thing hovering over one's head: primarily Pivitz for
		 * Tootsville
		 */
		OVERHEAD,
		/**
		 * Pants
		 */
		PANTS,
		/**
		 * Shirt
		 */

		SHIRT,
		/**
		 * shoes, footwear, &c
		 */
		SHOES,
		/**
		 * full-body suit, this is also where we'll stick tattoos and
		 * Toots Patterns
		 */
		SUIT,
		/**
		 * something that decorates a character's tail (for e.g. Toots
		 * or dragons) or butt region in general
		 */
		TAIL,
		/**
		 * two-handed carry item, e.g. broom
		 */
		TWO_HAND,
		/**
		 * the wall of a decorated room
		 */
		WALL
	}

	/**
	 * The value that makes this act like a super-Enum
	 */
	private final Values value;

	/**
	 * Instantiates based upon a string, e.g. from JSON or database
	 * 
	 * @param value1 The string in question
	 */
	public EquipAs (final String value1) {
		if ("1HAND".equals (value1)) {
			value = Values.ONE_HAND;
			return;
		} else if ("2HAND".equals (value1)) {
			value = Values.TWO_HAND;
			return;
		}
		value = Enum.valueOf (Values.class, value1);
	}

	/**
	 * @param value1 The value of this super-enum
	 */
	public EquipAs (final Values value1) {
		value = value1;
	}

	/**
	 * @return whether the item is something that can be equipped by /
	 *         applied to an avatar. If not, it must apply to decorated
	 *         rooms.
	 */
	public boolean avatarCanEquip () {
		switch (value) {
		case SHIRT:
		case PANTS:
		case BACK:
		case EARS:
		case EYES:
		case FOLLOW:
		case GLOVES:
		case HAT:
		case INVIS:
		case NECK:
		case ONE_HAND:
		case ORBITAL:
		case OVERHEAD:
		case SHOES:
		case SUIT:
		case TAIL:
		case TWO_HAND:
			return true;
		case WALL:
		case CEILING:
		case FLOOR:
			return false;
		case INVENTORY:
			throw new Error (
			"This isn't an EquipAs value appropriate to the question. Whence did you get your values?");
		}
		throw new RuntimeException ("Enum out of range");
	}

	/**
	 * @return the value
	 */
	public Values getValue () {
		return value;
	}

	/**
	 * @return true if this is something that applies to decorated
	 *         rooms, and not avatars.
	 */
	public boolean roomCanEquip () {
		return !avatarCanEquip ();
	}

	/**
	 * Special note: we use ONE_HAND and TWO_HAND internally (Java
	 * identifier rules) but export 1HAND and 2HAND to SQL/JSON
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		if (value == Values.ONE_HAND)
			return "1HAND";
		if (value == Values.TWO_HAND)
			return "2HAND";
		return value.toString ();
	}

}
