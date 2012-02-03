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
 * A Place which the client should interpret for some purpose or other.
 * 
 * @author brpocock@star-hope.org
 * 
 */
public class ClientEventPlace extends RoomPlace {

	/**
	 * 
	 * 
	 * @param placeName name / unique ID
	 * @param placeShape shape in room
	 * @param placeAttributes associated attributes; interpreted
	 *            entirely by the client
	 */
	public ClientEventPlace (final String placeName,
			final GeneralPath placeShape,
			final String [] placeAttributes) {
		super (RoomPlaceType.evt__, placeName, placeShape,
				placeAttributes);

	}

}
