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
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.game.inventory.effects;

import org.starhope.appius.game.DamageTypeRanks;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.game.inventory.ItemEffects;

/**
 * A simple armour device which somehow alters the wearer's stats,
 * probably increasing their defense values
 * 
 * @author brpocock@star-hope.org
 */
public class SimpleArmour extends ItemEffects {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 7051363407749414962L;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected boolean attritionLinear = true;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected double attritionRate = 0.00;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected DamageTypeRanks defence = new DamageTypeRanks ();

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	protected double effectiveness = 1.0;

	/**
	 * @param theItem the item being used as armour
	 */
	public SimpleArmour (final InventoryItem theItem) {
		super (theItem);
	}

}
