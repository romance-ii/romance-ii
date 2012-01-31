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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.net.datagram;

import org.starhope.appius.game.ChannelListener;

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
public class ADPScore extends ADPJSON {
	
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
	 * @param s WRITEME 
	 */
	public ADPScore (final ChannelListener s) {
		super ("score", s);
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
		setJSON ("eventID", eventID);
	}
	
	/**
	 * @param score2 the score to set
	 */
	public void setScore (final long score) {
		this.score = score;
		setJSON ("points", score);
	}
	
	/**
	 * @param username the username to set
	 */
	public void setUsername (final String username) {
		this.username = username;
		setJSON ("userName", username);
	}
}
