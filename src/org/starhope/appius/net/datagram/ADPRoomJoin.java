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
package org.starhope.appius.net.datagram;

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.game.Room;
import org.starhope.appius.user.AbstractUser;

/**
 * <p>
 * WRITEME: This type has been undocumented by brpocock@star-hope.org
 * since Nov 22, 2010.
 * </p>
 * <p>
 * ADPRoomJoin represents … WRITEME brpocock@star-hope.org
 * </p>
 * <p>
 * ADPRoomJoin should be used for … WRITEME brpocock@star-hope.org
 * </p>
 * <p>
 * ADPRoomJoin should not be used for … WRITEME brpocock@star-hope.org
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class ADPRoomJoin extends ADPJSON {
	
	/**
	 * WRITEME: Document this field brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -4914008514062853120L;
	/**
	 * WRITEME: Document this field brpocock@star-hope.org
	 */
	private final Room roomJoined;
	/**
	 * WRITEME: Document this field brpocock@star-hope.org
	 */
	private AbstractUser userJoining;
	
	/**
	 * Notification that an user has joined a room.
	 * 
	 * @param s WRITEME  brpocock 
	 * @param room the room that has been joined by an user
	 * @param joiner the user joining the room
	 */
	public ADPRoomJoin (final ChannelListener s, final Room room,
			final AbstractUser joiner) {
		super ("join", s);
		roomJoined = room;
		userJoining = joiner;
		setJSON ("r", roomJoined.getFullMoniker ());
		include (userJoining.getDatagram (s));
	}
	
	/**
	 * @return the roomJoined
	 */
	public Room getRoomJoined () {
		return roomJoined;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2262 $";
	}
	
	/**
	 * @return the userJoining
	 */
	public AbstractUser getUserJoining () {
		return userJoining;
	}
	
	/**
	 * @param user WRITEME  brpocock 
	 */
	public void setUserJoining (final AbstractUser user) {
		userJoining = user;
	}
	
}
