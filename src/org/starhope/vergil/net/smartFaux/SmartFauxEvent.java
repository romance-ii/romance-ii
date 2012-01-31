/**
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Res Interactive, LLC. This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful,    but WITHOUT ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the   GNU Affero General Public License for more details.  You should have received a copy of the GNU Affero General Public License  along with this program.  If not, see <http://www.gnu.org/licenses/>..
 */
package org.starhope.vergil.net.smartFaux;

import org.json.JSONObject;
import org.starhope.vergil.game.PubliusVergiliusMaro;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class SmartFauxEvent {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onAdminMessage = "msg.admin";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onConnection = "net.connect";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onConnectionLost = "net.disconnect";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onExtensionResponse = "reply";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onJoinRoom = "room.join";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onJoinRoomError = "room.join.fail";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onLogin = "net.login";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onModeratorMessage = "msg.moderator";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onPrivateMessage = "msg.private";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onPublicMessage = "msg.public";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onRandomKey = "net.login.apple";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onRoomListUpdate = "room.list";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onUserEnterRoom = "room.user.join";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onUserLeaveRoom = "room.user.part";
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param identifier WRITEME
	 * @param details WRITEME
	 * @return WRITEME
	 */
	public static SmartFauxEvent fromVergil (final String identifier,
			final Object... details) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		PubliusVergiliusMaro
				.reportBug ("unimplemented SmartFauxEvent::fromVergil (brpocock@star-hope.org, Jul 23, 2010)");
		return null;
	}
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final String name;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final JSONObject params;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param newName WRITEME
	 * @param newParams WRITEME
	 */
	public SmartFauxEvent (final String newName,
			final JSONObject newParams) {
		name = newName;
		params = newParams;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public String getName () {
		return name;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public JSONObject getParams () {
		return params;
	}
	
}
