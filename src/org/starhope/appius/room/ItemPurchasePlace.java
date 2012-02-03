/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
package org.starhope.appius.room;

import java.awt.geom.GeneralPath;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class ItemPurchasePlace extends RoomPlace {

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param placeName
	 * @param placeShape
	 * @param placeAttributes
	 */
	public ItemPurchasePlace (
			final String placeName, final GeneralPath placeShape,
			final String [] placeAttributes) {
		super (RoomPlaceType.evt_item_, placeName, placeShape,
				placeAttributes);
		// TODO Auto-generated constructor stub brpocock@star-hope.org
	}

}
