/**
 * Copyright © 2010, Res Interactive, LLC. All Rights Reserved.
 */
package org.starhope.vergil.net.smartFaux;

import org.json.JSONObject;
import org.starhope.vergil.game.PubliusVergiliusMaro;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class SmartFauxEvent {

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
	public static final String onLogin = "net.login";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onRoomListUpdate = "room.list";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onJoinRoom = "room.join";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onRandomKey = "net.login.apple";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onExtensionResponse = "reply";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onJoinRoomError = "room.join.fail";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onPublicMessage = "msg.public";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onModeratorMessage = "msg.moderator";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onAdminMessage = "msg.admin";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	public static final String onPrivateMessage = "msg.private";
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
		PubliusVergiliusMaro.reportBug("unimplemented SmartFauxEvent::fromVergil (brpocock@star-hope.org, Jul 23, 2010)");
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
