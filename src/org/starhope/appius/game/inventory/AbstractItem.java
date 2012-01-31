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
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */

package org.starhope.appius.game.inventory;

import org.json.JSONObject;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.util.DataRecord;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public interface AbstractItem extends DataRecord {
	
	/**
	 * @return the currency measuring the price
	 */
	public abstract Currency getCurrency ();
	
	/**
	 * Get the user-visible description of the item
	 * 
	 * @return the database description of the item
	 */
	public abstract String getDescription ();
	
	/**
	 * @return the itemID
	 */
	public abstract int getItemID ();
	
	/**
	 * @return the price
	 */
	public abstract long getPrice ();
	
	/**
	 * @return the rarity rating of this item
	 */
	public RarityRating getRarity ();
	
	/**
	 * @return the title
	 */
	public abstract String getTitle ();
	
	/**
	 * @param itemID1 the itemID to set
	 */
	public abstract void setItemID (final int itemID1);
	
	/**
	 * @param currency the currency units
	 * @param price the price to set
	 */
	public abstract void setPrice (final Currency currency,
			final long price);
	
	/**
	 * @param title1 the title to set
	 */
	public abstract void setTitle (final String title1);
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Aug 27,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public abstract JSONObject toJSON ();
	
}
