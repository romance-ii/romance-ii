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

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.user.AbstractUser;

/**
 * A simple melée weapon that effects damage within a limited distance
 * of the user.
 * 
 * @author brpocock@star-hope.org
 */
public class SimpleMeleeWeapon extends SimpleAbstractWeapon {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -5360319341169604821L;

	/**
	 * @param theItem the item being treated as a melée weapon.
	 */
	public SimpleMeleeWeapon (final InventoryItem theItem) {
		super (theItem);
	}

	/**
	 * @see org.starhope.appius.game.inventory.ItemEffects#use(java.lang.String,
	 *      org.starhope.appius.geometry.Coord3D)
	 */
	@Override
	public void use (final AbstractUser user, final String targetName,
			final Coord3D targetCoords) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented SimpleMeleeWeapon::use (brpocock@star-hope.org, Sep 27, 2010)");
		super.use (user, targetName, targetCoords);
	}

}
