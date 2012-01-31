/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.game.events;

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.net.datagram.ADPScore;

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
 *
 */
public class EventScore implements Comparable <EventScore> {

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int eventID;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private long score;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String username;

	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 *
	 * @param id WRITEME 
	 * @param l WRITEME 
	 * @param user WRITEME 
	 */
	public EventScore (final int id, final long l, final String user) {
		eventID = id;
		score = l;
		username = user;
	}

	@Override
	public int compareTo (final EventScore o) {
		return score != o.score ? (int) (o.score - score) : o.eventID - eventID;
	}

	/**
	 * Gets a score datagram from this score
	 *
	 * @param source WRITEME 
	 * @param includeIDs WRITEME 
	 * @return WRITEME 
	 */
	public ADPScore getDatagram (final ChannelListener source, final boolean includeIDs) {
		final ADPScore result = new ADPScore (source);
		if (includeIDs) {
			result.setEventID (getEventID ());
		}
		result.setScore (score);
		result.setUsername (username);
		return result;
	}

	/**
	 * @return the eventID
	 */
	public int getEventID () {
		return eventID;
	}

	/**
	 * @return the score
	 */
	public long getScore () {
		return score;
	}

	/**
	 * @return the username
	 */
	public String getUsername () {
		return username;
	}

	/**
	 * @param eventID the eventID to set
	 */
	public void setEventID (final int eventID) {
		this.eventID = eventID;
	}

	/**
	 * @param score the score to set
	 */
	public void setScore (final long score) {
		this.score = score;
	}

	/**
	 * @param username the username to set
	 */
	public void setUsername (final String username) {
		this.username = username;
	}

}
