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
package org.starhope.appius.room;

import java.awt.geom.GeneralPath;

/**
 * An obstacle space defines an obstruction in the walkspace of a room
 * 
 * @author brpocock@star-hope.org
 * 
 */
public class ObstacleSpace extends RoomPlace {

	/**
	 * @param placeName the name of this obstacle
	 * @param placeShape the shape to be removed from the walkspace
	 * @param placeAttributes unused
	 */
	public ObstacleSpace (final String placeName,
			final GeneralPath placeShape,
			final String [] placeAttributes) {
		super (RoomPlaceType.obs_, placeName, placeShape,
				placeAttributes);
	}

}
