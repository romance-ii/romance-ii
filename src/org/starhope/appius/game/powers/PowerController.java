/**
 * <p> Copyright © 2012, Bruce-Robert Pocock</p>
 *
 * <p> Copyright © 2011 Res Interactive, LLC </p>
 *
 * <p> This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version.  </p>
 *
 * <p> This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.  </p>
 *
 * <p> You should have received a copy of the GNU Affero General
 * Public License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.  </p>
 *
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game.powers;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 *
 */
@Deprecated
public interface PowerController {

	/**
	 * Adds the requested real item to the user's inventory.  Use negative numbers to decrease quantities.
	 *
	 * @param realItemID WRITEME 
	 * @param count WRITEME 
	 * @return WRITEME 
	 */
	void addInventory (int realItemID, int count);

	/**
	 * Fires a projectile using the given avatar class towards the given coordinates
	 *
	 * @param destX The target X coordinate
	 * @param destY The target Y coordinate
	 * @return WRITEME 
	 */
	boolean fireProjectile (double destX, double destY);

	/**
	 * Gets a count of the requested item in the user's inventory
	 *
	 * @param realItemID WRITEME 
	 * @return WRITEME 
	 */
	int getCount (int realItemID);

	/**
	 * Gets the name of the owner of the power controller
	 *
	 * @return WRITEME 
	 */
	String getOwnerName ();

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param varName WRITEME 
	 * @return WRITEME 
	 */
	String getOwnerUserVar (String varName);
}
