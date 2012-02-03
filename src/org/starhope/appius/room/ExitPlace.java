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
 * An exit to another room
 * 
 * @author brpocock@star-hope.org
 * 
 */
public class ExitPlace extends RoomPlace {

	/**
	 * The “from moniker” (entrance moniker) to choose in the target
	 * room as a spawn point (optional)
	 */
	private String fromRoomMoniker;
	/**
	 * The room to which this is an exit
	 */
	private String toRoomMoniker;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param placeName name of the Place
	 * @param placeShape shape of the Place
	 * @param placeAttributes attributes; the first is the target room
	 *            moniker, the second is the “from moniker” (entrance)
	 *            to choose in the target room as a spawn point
	 *            (optional)
	 */
	public ExitPlace (final String placeName,
			final GeneralPath placeShape,
			final String [] placeAttributes) {
		super (RoomPlaceType.rom_, placeName, placeShape,
				placeAttributes);
		setToRoomMoniker (placeAttributes [0]);
		setFromRoomMoniker (placeAttributes.length > 1 ? placeAttributes [1]
		                                                                  : null);
	}

	/**
	 * @return the fromRoomMoniker
	 */
	public String getFromRoomMoniker () {
		return fromRoomMoniker; /* TODO brpocock@star-hope.org */
	}

	/**
	 * @return the toRoomMoniker
	 */
	public String getToRoomMoniker () {
		return toRoomMoniker; /* TODO brpocock@star-hope.org */
	}

	/**
	 * @param fromRoomMoniker the fromRoomMoniker to set
	 */
	public void setFromRoomMoniker (final String fromRoomMoniker) {
		this.fromRoomMoniker = fromRoomMoniker; /* TODO brpocock@star-hope.org */
	}

	/**
	 * @param toRoomMoniker the toRoomMoniker to set
	 */
	public void setToRoomMoniker (final String toRoomMoniker) {
		this.toRoomMoniker = toRoomMoniker; /* TODO brpocock@star-hope.org */
	}

}
