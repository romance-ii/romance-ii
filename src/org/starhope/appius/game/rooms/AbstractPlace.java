/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public
 * License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License along with this program. If not, see
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
package org.starhope.appius.game.rooms;

import org.json.JSONException;
import org.json.JSONObject;
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
abstract class AbstractPlace implements HasSubversionRevision {

	/**
	 * Figures out what kind of place the input parameters want, creates it and returns it
	 *
	 * @param name Name of the place
	 * @param roomVarString RoomVariables for the place
	 * @param room The room this place is in
	 * @return The newly created place or null if no type can be determined or there was
	 *         an error with place creation
	 * @throws JSONException
	 */
	static AbstractPlace Create (final String name, final String roomVarString, final Room room) throws JSONException {
		AbstractPlace result = null;

		final JSONObject jsonObject = new JSONObject (roomVarString);

		if (jsonObject.has ("type")) {
			final String typeString = jsonObject.getString ("type");
			if (typeString.equals ("event")) {
				result = new EventPlace (name, jsonObject, room);
			} else if (typeString.equals ("item")) {
				result = new ItemPlace (name, jsonObject, room);
			} else if (typeString.equals ("point")) {
				result = new PointPlace (name, jsonObject, room);
			}
		}

		return result;
	}

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String name;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final JSONObject roomVar;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	protected boolean forBroadcast = false;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final Room room;

	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 *
	 * @param name WRITEME 
	 * @param jsonObject WRITEME 
	 * @throws JSONException
	 */
	public AbstractPlace (final String name, final JSONObject jsonObject, final Room room) throws JSONException {
		this.name = name;
		roomVar = jsonObject;
		this.room = room;
	}

	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof AbstractPlace)) {
			return false;
		}
		AbstractPlace other = (AbstractPlace) obj;
		if (name == null) {
			if (other.name != null) {
				return false;
			}
		} else if ( !name.equals (other.name)) {
			return false;
		}
		if (room == null) {
			if (other.room != null) {
				return false;
			}
		} else if ( !room.equals (other.room)) {
			return false;
		}
		return true;
	}

	/**
	 * @return the name
	 */
	public String getName () {
		return name;
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @return WRITEME 
	 */
	public Room getRoom () {
		return room;
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @return WRITEME 
	 */
	JSONObject getRoomVar() {
		return roomVar;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = prime * result + ( name == null ? 0 : name.hashCode ());
		result = prime * result + ( room == null ? 0 : room.hashCode ());
		return result;
	}

	/**
	 * @return the forBroadcast
	 */
	public boolean isForBroadcast () {
		return forBroadcast;
	}

	/**
	 * @param forBroadcast the forBroadcast to set
	 */
	public void setForBroadcast (final boolean forBroadcast) {
		this.forBroadcast = forBroadcast;
	}

	/**
	 * @param name the name to set
	 */
	public void setName (final String name) {
		this.name = name;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return name + "=" + roomVar.toString ();
	}

}
