/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 */
package org.starhope.appius.room;

import java.awt.geom.GeneralPath;

/**
 * An entrance into a room (“out place”)
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class EntrancePlace extends RoomPlace {
	
	/**
	 * The moniker of the place from which the user is entering
	 */
	private String from;
	
	/**
	 * @param placeName the name of this place (unique ID)
	 * @param placeShape the shape of this place
	 * @param placeAttributes various string attributes of the Place.
	 *             The first attribute of an {@link EntrancePlace} is
	 *             the “from” moniker
	 */
	public EntrancePlace (final String placeName,
			final GeneralPath placeShape,
			final String [] placeAttributes) {
		super (RoomPlaceType.out_, placeName, placeShape,
				placeAttributes);
		setFrom (placeAttributes [0]);
	}
	
	/**
	 * @return the from
	 */
	public String getFrom () {
		return from;
	}
	
	/**
	 * @param fromMoniker the from to set
	 * @return the moniker set (for chaining)
	 */
	public String setFrom (final String fromMoniker) {
		from = fromMoniker;
		return from;
	}
	
}
