/**
 * <p> Copyright © 2012, Bruce-Robert Pocock</p>
 *
 * <p>Copyright © 2011 Res Interactive, LLC </p>
 *
 * <p> This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published
 * by the Free Software Foundation, either version 3 of the License, or (at
 * your option) any later version.  </p>
 *
 * <p> This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero
 * General Public License for more details.  </p>
 *
 * <p> You should have received a copy of the GNU Affero General Public
 * License along with this program.  If not, see
 * <http://www.gnu.org/licenses/>.  </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 */
package org.starhope.appius.game.inventory;


/**
 * WRITEME: Document this type.
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
@Deprecated
class PowerItemInfoImpl implements PowerItemInfo {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final RealItem realItem;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param item WRITEME 
	 */
	PowerItemInfoImpl (final RealItem item) {
		realItem = item;
	}
	
	/**
	 * @see org.starhope.appius.game.powers.PowerItemInfo#getAttribute(java.lang.String)
	 */
	@Override
	public String getAttribute (final String string) {
		return realItem.getAttribute (string);
	}
	
	/**
	 * @see org.starhope.appius.game.powers.PowerItemInfo#getItemID()
	 */
	@Override
	public int getItemID () {
		return realItem.getItemID ();
	}
	
	/**
	 * @see org.starhope.appius.game.powers.PowerItemInfo#getRealItemID()
	 */
	@Override
	public int getRealItemID () {
		return realItem.getRealID ();
	}
	
	/**
	 * @see org.starhope.appius.game.powers.PowerItemInfo#hasAttribute(java.lang.String)
	 */
	@Override
	public boolean hasAttribute (final String string) {
		return realItem.hasAttribute (string);
	}
	
}
