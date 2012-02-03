/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
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
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.net.datagram;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Room;
import org.starhope.appius.net.UserAgentInfo;
import org.starhope.appius.user.AbstractUser;

/**
 * <p>
 * WRITEME: This type has been undocumented by brpocock@star-hope.org since Nov 22, 2010.
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
 * @author brpocock@star-hope.org
 *
 */
public class ADPRoomJoin extends AbstractDatagram {

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
	private final AbstractUser userJoining;

	/**
	 * <p>
	 * Notification that an user has joined a room.
	 * </p>
	 * <p>
	 * In Infinity mode א0 or א1, this packet looks like this:
	 * </p>
	 * 
	 * <pre>
	 * {"from":"join", "r":ROOM-MONIKER, "user": { {@link AbstractUser#getPublicInfo()}
	 * </pre>
	 * <p>
	 * In Infinity mode א2, there is actually just an
	 * {@link AbstractUser#getPublicInfo()} packet sent; the user agent
	 * is expected to detect the room from within that information.
	 * </p>
	 * <p>
	 * Note that א2 clients will need to ask for the user's public info…
	 * (huh? why?)
	 * </p>
	 * <p>
	 * In SmartFaux mode, this packet is XML, structured like this:
	 * </p>
	 * 
	 * <pre>
	 * &lt;msg t='sys'&gt;
	 *  &lt;body action='uER' r='ROOM-ID-NUMBER'&gt;
	 *   {@link AbstractUser#toSFSXML()}
	 *  &lt;/body&gt;
	 * &lt;/msg&gt;
	 * </pre>
	 * 
	 * @param room the room that has been joined by an user
	 * @param joiner the user joining the room
	 */
	public ADPRoomJoin (final Room room, final AbstractUser joiner) {
roomJoined = room;
userJoining = joiner;
	}



	/**
	 * @return the roomJoined
	 */
	public Room getRoomJoined() {
	return roomJoined;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2216 $";
	}



	/**
	 * @return the userJoining
	 */
	public AbstractUser getUserJoining() {
	return userJoining;
	}




	/**
	 * @see org.starhope.appius.net.datagram.AbstractDatagram#toString()
	 */
	@Override
	public String toString () {
		return userJoining.getDebugName () + " joining room " + roomJoined.getDebugName ();
	}

	/**
	 * @see org.starhope.appius.net.datagram.AbstractDatagram#toString(double,
	 *      org.starhope.appius.net.UserAgentInfo)
	 */
	@Override
	public String toString (final double protocolLanguage,
			final UserAgentInfo userAgent) {
		if (Double.POSITIVE_INFINITY == protocolLanguage) {
			if (userAgent.getInfinityModeMaxLevel () < 2) {
				final JSONObject result = new JSONObject ();
				try {
					result.put ("from", "join");
					result.put ("r", roomJoined.getMoniker ());
					result.put ("user", userJoining.getPublicInfo ());
				} catch (final JSONException e) {
					AppiusClaudiusCaecus.fatalBug (e);
				}
				return result.toString ();
			}
			return new ADPUserPublicInfo (userJoining).toString (
					protocolLanguage, userAgent);
		}

		return "<msg t='sys'><body action='uER' r='"
				+ roomJoined.getID () + "'>" + userJoining.toSFSXML ()
				+ "</body></msg>";
	}
}
