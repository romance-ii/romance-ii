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
 * General Public License for more details.
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

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.game.inventory.InventoryItemType;
import org.starhope.appius.game.inventory.RarityRating;

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
public class ADPItem extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Integer count;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String description;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Integer itemID;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private InventoryItemType itemType;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private RarityRating rarity;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Integer realID;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String title;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param s WRITEME 
	 */
	public ADPItem (final ChannelListener s) {
		super ("item", s);
	}
	
	/**
	 * Creates a copy
	 * 
	 * @return WRITEME 
	 */
	public ADPItem copy () {
		final ADPItem result = new ADPItem (source);
		result.setItemID (getItemID ());
		result.setInventoryItemType (getInventoryItemType ());
		result.setTitle (getTitle ());
		result.setRarity (getRarity ());
		result.setCount (getCount ());
		return result;
	}
	
	/**
	 * @return the count
	 */
	public Integer getCount () {
		return count;
	}
	
	/**
	 * @return the description
	 */
	public String getDescription () {
		return description;
	}
	
	/**
	 * @return the itemType
	 */
	public InventoryItemType getInventoryItemType () {
		return itemType;
	}
	
	/**
	 * @return the id
	 */
	public Integer getItemID () {
		return itemID;
	}
	
	/**
	 * @return the rarity
	 */
	public RarityRating getRarity () {
		return rarity;
	}
	
	/**
	 * @return the realID
	 */
	public Integer getRealID () {
		return realID;
	}
	
	/**
	 * @return the title
	 */
	public String getTitle () {
		return title;
	}
	
	/**
	 * @param count the count to set
	 */
	public void setCount (final Integer count) {
		this.count = count;
		setJSON ("count", count);
	}
	
	/**
	 * @param description the description to set
	 */
	public void setDescription (final String description) {
		this.description = description;
		setJSON ("desc", description);
	}
	
	/**
	 * @param itemType the itemType to set
	 */
	public void setInventoryItemType (final InventoryItemType itemType) {
		this.itemType = itemType;
		setJSON ("itemType", itemType.getName ());
	}
	
	/**
	 * @param id the id to set
	 */
	public void setItemID (final Integer id) {
		itemID = id;
		setJSON ("itemID", id);
	}
	
	/**
	 * @param rarity the rarity to set
	 */
	public void setRarity (final RarityRating rarity) {
		this.rarity = rarity;
		setJSON ("rarity", rarity.getID ());
	}
	
	/**
	 * @param realID the realID to set
	 */
	public void setRealID (final Integer realID) {
		this.realID = realID;
		setJSON ("realID", realID);
	}
	
	/**
	 * @param title the title to set
	 */
	public void setTitle (final String title) {
		this.title = title;
		setJSON ("title", title);
	}
	
}
