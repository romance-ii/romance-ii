/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.net.datagram;

import java.util.EnumSet;

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.game.inventory.RealItem.DatagramFormat;
import org.starhope.appius.user.AbstractUser;
import org.starhope.util.HasSubversionRevision;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ADPInventory extends ADPJSON implements
		HasSubversionRevision {
	/**
	 * The default format for items
	 */
	private final static EnumSet <DatagramFormat> itemFormat = EnumSet
			.of (DatagramFormat.RealID, DatagramFormat.ItemID,
					DatagramFormat.InventoryItemType,
					DatagramFormat.Rarity, DatagramFormat.Title,
					DatagramFormat.Count);
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final ADPArray <ADPItem> items;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private AbstractUser user;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param s WRITEME 
	 */
	public ADPInventory (final ChannelListener s) {
		super ("inv", s);
		items = new ADPArray <ADPItem> (s);
		include ("items", items);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param item WRITEME 
	 * @param count WRITEME 
	 */
	public void addItem (final RealItem item, final Integer count) {
		final ADPItem adpItem = item.getDatagram (source,
				ADPInventory.itemFormat);
		adpItem.setCount (count);
		items.put (adpItem);
	}
	
	/**
	 * @return the user
	 */
	public AbstractUser getUser () {
		return user;
	}
	
	/**
	 * @param user the user to set
	 */
	public void setUser (final AbstractUser user) {
		this.user = user;
		setJSON ("who", user.getAvatarLabel ());
	}
}
