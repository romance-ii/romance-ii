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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.vergil.net;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.Commands;
import org.starhope.appius.game.PreLoginCommands;
import org.starhope.appius.user.AbstractUser;
import org.starhope.vergil.game.PubliusVergiliusMaro;

/**
 * <p>
 * The Appius Claudius Caecus game server sends “response” or “command”
 * packets to the client (whether Publius Vergilius Maro or another
 * client application) in a fairly simple JSON (see
 * http://www.json.org/) format.
 * </p>
 * <p>
 * Each packet contains a few basic conditions: There will always be a
 * “from” and “status” property on the top-level object. The boolean
 * “status” indicates “success” or “normal” condition, while the “from”
 * key identifies the command being dispatched, the instruction to the
 * client, &c. If the status is false, there will also always be an
 * “err” property giving a machine-readable description of the error
 * condition. There may also be a “msg” property giving an human-legible
 * explanation of the error.
 * </p>
 * <p>
 * This class accepts the already-parsed JavaScript Object (as
 * {@link JSONObject}) and dispatches it accordingly.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
public abstract class ServerCommands {
	/**
	 *Dispatch a server-provided JSON packet
	 * 
	 * @param jso any JSON packet received from the server
	 * @throws JSONException if the packet is malformed
	 */
	public static void acceptServerResponse (final JSONObject jso)
			throws JSONException {
		if ( ! (jso.has ("from") && jso.has ("status"))) {
			PubliusVergiliusMaro
					.reportBug ("Server sent unrecognized JSON data: "
							+ jso.toString ());
			return;
		}
		boolean success = jso.getBoolean ("status");
		String source = jso.getString ("from");
		if (success) {
			ServerCommands.dispatchSuccess (source, jso);
		} else {
			ServerCommands.dispatchError (source,
					jso.getString ("err"), jso.optString ("msg"), jso);
		}
	}
	
	/**
	 * Accept an error response from the server and dispatch it through
	 * the methods (which should have been implemented by the child
	 * class) enumerated in this class.
	 * 
	 * @param source the server source of the error (the “from” code)
	 * @param string the error message code string
	 * @param optString the optional user-visible message string
	 * @param jso the complete JSON packet returned by the server
	 */
	private static void dispatchError (final String source,
			final String string, final String optString,
			final JSONObject jso) {
		PubliusVergiliusMaro.reportBug ("TODO"); // TODO
	}
	
	/**
	 * Accept a response from the server and dispatch it through the
	 * methods (which should have been implemented by the child class)
	 * enumerated in this class.
	 * 
	 * @param source The server source of the error (the “from” code)
	 * @param jso the complete JSON packet returned by the server
	 */
	private static void dispatchSuccess (final String source,
			final JSONObject jso) {
		PubliusVergiliusMaro.reportBug ("TODO"); // TODO
	}

	/**
	 * <p>
	 * The user had requested adding another user to an user list, but
	 * the request was refused, either due to an error in the request,
	 * or the other user denying permission.
	 * </p>
	 * 
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_addToList_err (final JSONObject jso);
	
	/**
	 * <p>
	 * An user has been added to an user list (e.g. buddy list, ignore
	 * list, or other list). This is usually a response to an user
	 * request.
	 * </p>
	 * 
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_addToList_ok (final JSONObject jso);
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_admin_err (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_admin_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_avatars_err (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_avatars_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_ayt_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_ayt_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_badgeUpdate_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_badgeUpdate_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_beam_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_beam_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_bots_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_bots_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_buddyList_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_buddyList_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_buddyRequest_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_buddyRequest_ok (final JSONObject jso) ;

	/**
	 * <p>
	 * This message is sent to deny the user's request to delete a mail
	 * message
	 * </p>
	 * 
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_deleteMailMessage_err (final JSONObject jso) ;

	/**
	 * <p>
	 * This message is sent to confirm that a mail message has been
	 * deleted, usually by user request.
	 * </p>
	 * 
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_deleteMailMessage_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_earning_err (final JSONObject jso) ;
	
	/**
	 * <p>
	 * Notify the player that s/he has earned an item, stats change, or
	 * currency. This does not report changes in item health.
	 * </p>
	 * <p>
	 * The usual implementation is a particle effect of some kind,
	 * although Tootsville had been using a “thought bubble.” The visual
	 * display is irrelevant to the server.
	 * </p>
	 * 
	 * @param jso One of the following formats: { from: earnings,
	 *            currency: { CURRENCY-OBJECT }, amount: NUMBER }, or, {
	 *            from: earnings, item: ITEM-ID-NUMBER }, or, { from:
	 *            earnings, stat: STAT-NAME, change: CHANGE-AMOUNT }
	 */
	public abstract void from_earning_ok (final JSONObject jso) ;

	/**
	 *
	 * WRITEME: Document this method brpocock@star-hope.org
	 * @param jso WRITEME
	 */
	public abstract void from_echo_err (final JSONObject jso);

	/**
	 *
	 * WRITEME: Document this method brpocock@star-hope.org
	 * @param jso WRITEME
	 */
	public abstract void from_echo_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_endEvent_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_endEvent_ok (final JSONObject jso) ;

	/**
	 * <p> This message is sent whenever the user's equipment changes. Equipment is defined
	 * as items which are active (equipped, donned), which have either an ACTIVE or PASSIVE effect.
	 * This is sent as an unordered list (using a JSON array-type list) of all items which meet
	 * these criteria. </p>
	 * <p> Note that receiving this message could mean either an item has been equipped or
	 * de-equipped, or that an item has changed; e.g. a change to its health or colour. </p>
	 * @param jso the new equipment list as JSON array-type list object
	 */
	public abstract void from_equip_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_finger_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_finger_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_forceMove_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_forceMove_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_gameAction_err (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_gameAction_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getApple_err (final JSONObject jso);

	/**
	 * <p>
	 * The “apple” is the cookie used to perform password
	 * authentication. After you have requested the apple from the
	 * server, you will receive it back, here.
	 * </p>
	 * <p>
	 * To proceed with your login request, perform the one-way hash of
	 * the password and submit the desired login packet to the server.
	 * See the server commands
	 * {@link PreLoginCommands#do_login(JSONObject, AbstractUser, org.starhope.appius.game.Room)}
	 * and
	 * {@link PreLoginCommands#do_getApple(JSONObject, AbstractUser, org.starhope.appius.game.Room)}
	 * for details.
	 * </p>
	 * <p>
	 * This message will only be sent during prelogin mode.
	 * </p>
	 * <p>
	 * Conforming clients must ignore this message after sending their
	 * login request.
	 * </p>
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getApple_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getAvailableHouses_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getAvailableHouses_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getAwardRankings_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getAwardRankings_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getColorPalettes_err (final JSONObject jso) ;
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getColorPalettes_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getInventoryItems_err (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getInventoryItems_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getMailInBox_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getMailInBox_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getMailMessage_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getMailMessage_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getShopItems_err (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getShopItems_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getStoreItems_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getStoreItems_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getUserLists_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_getUserLists_ok (final JSONObject jso) ;

	/**
	 *
	 * WRITEME: Document this method brpocock@star-hope.org
	 * @param jso WRITEME
	 */
	public abstract void from_getWallet_err (final JSONObject jso);

	/**
	 * WRITEME
	 *
	 * @param jso  from: getWallet, walletOwner: YOURNAME, currency: { "x-TvPn": 500.00 }
	 */
	public abstract void from_getWallet_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_go_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_go_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_gunList_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_gunList_ok (final JSONObject jso) ;

	/**
	 * @see Commands#do_initUserRoom(JSONObject,
	 *      org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.Room)
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_initUserRoom_err (final JSONObject jso) ;

	/**
	 * @see Commands#do_initUserRoom(JSONObject,
	 *      org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.Room)
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_initUserRoom_ok (final JSONObject jso) ;

	/**
	 * @see Commands#do_getInventory(JSONObject, AbstractUser,
	 *      org.starhope.appius.game.Room)
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_inventory_err (final JSONObject jso) ;

	/**
	 * @see Commands#do_getInventory(JSONObject, AbstractUser,
	 *      org.starhope.appius.game.Room)
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_inventory_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_join_err (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_join_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_migrate_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_migrate_ok (final JSONObject jso) ;

	/**
	 * @see Commands#do_sendOutOfBandMessage(JSONObject,
	 *      org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.Room)
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_outOfBand_err (final JSONObject jso) ;

	/**
	 * @see Commands#do_sendOutOfBandMessage(JSONObject,
	 *      org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.Room)
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_outOfBand_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_pan_err (final JSONObject jso) ;

	/**
	 * <p>
	 * Pan the view to a given area. The new viewing region is
	 * determined by the coördinates given. Until a pan command is
	 * given, the default panning is { top: 0, left: 0, right: 799,
	 * bottom: 599 } (800×600). All further coördinates given are
	 * relative to this view-space, which the client must scale
	 * appropriately to their display.
	 * </p>
	 * 
	 * @param jso { top: INT, left: INT, right: INT, bottom: INT }
	 */
	public abstract void from_pan_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_part_err (final JSONObject jso) ;

	/**
	 * <p>
	 * Sent when any user (avatar) leaves the room. You should only
	 * receive this message for the room that you are in, however, you
	 * must accept (and ignore) part messages for other rooms. (This
	 * might typically occur when you are just moving from one room to
	 * another, and messages are received out of sequence.)
	 * </p>
	 * <p>
	 * Remove the user from the room if the room ID number is your
	 * current room and the user is known to you.
	 * </p>
	 * <p>
	 * <b> Change in 1.1: </b> the userName field was previously labeled
	 * as “user”
	 * </p>
	 *
	 * @param jso <dl>
	 *            <dt>from</dt>
	 *            <dd>"part"</dd>
	 *            <dt>status</dt>
	 *            <dd>"true"</dd>
	 *            <dt>u</dt>
	 *            <dd>User ID number</dd>
	 *            <dt>userName</dt>
	 *            <dd>Avatar label</dd>
	 *            <dt>r</dt>
	 *            <dd>Room ID number</dd>
	 *            </dl>
	 */
	public abstract void from_part_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_passport_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_passport_ok (final JSONObject jso) ;

	/**
	 * Play a sound effect on the client
	 * @param jso { sound: SOUND-IDENTIFIER-STRING } or { url: SOUND-URL }
	 */
	public abstract void from_playSound_ok (final JSONObject jso)

	;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_postman_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_postman_ok (final JSONObject jso) ;

	/**
	 * @see Commands#do_savePrefs(JSONObject, org.starhope.appius.user.AbstractUser, org.starhope.appius.game.Room)
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_prefs_err (final JSONObject jso) ;

	/**
	 * @see Commands#do_savePrefs(JSONObject, org.starhope.appius.user.AbstractUser, org.starhope.appius.game.Room)
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_prefs_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_purchase_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_purchase_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_reportBug_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_reportBug_ok (final JSONObject jso) ;

	/**
	 *
	 * WRITEME: Document this method brpocock@star-hope.org
	 * @param jso WRITEME
	 */
	public abstract void from_roomJoin_err (final JSONObject jso);


	/**
	 * @param jso attributes: from: "roomJoin", status: "true",
	 *            roomNumber: (room ID #), moniker: (room moniker),
	 *            limbo: (true/false), users: (user-list, see
	 *            {@link #from_wardrobe_ok(JSONObject)}), bots: (see
	 *            {@link #from_bots_ok(JSONObject)}), vars:
	 *            (room-variables), maxUsers: (number)
	 */
	public abstract void from_roomJoin_ok (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_rv_err (final JSONObject jso);

	/**
	 * <p>
	 * Accept a room variable update.
	 * </p>
	 *
	 * @param jso JSON object from the server containing the key:value
	 */
	public abstract void from_rv_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_scoreUpdate_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_scoreUpdate_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_sendMailMessage_err (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_sendMailMessage_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_serverTime_err (final JSONObject jso) ;

	/**
	 * @see Commands#do_serverTime(JSONObject,
	 *      org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.Room)
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_serverTime_ok (final JSONObject jso) ;

	/**
	 * Display a particular client-side interface element
	 * @param jso { interface: INTERFACE-IDENTIFIER-STRING }
	 */
	public abstract void from_showInterface_ok (final JSONObject jso);

	/**
	 * @see Commands#do_serverTime(JSONObject,
	 *      org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.Room)
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_startEvent_err (final JSONObject jso) ;

	/**
	 * WRITEME
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_startEvent_ok (final JSONObject jso) ;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_uv_err (final JSONObject jso);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_uv_ok (final JSONObject jso);

	/**
	 * @see AbstractUser#getPublicInfo()
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_wardrobe_err (final JSONObject jso) ;

	/**
	 * @see AbstractUser#getPublicInfo()
	 * @param jso JSON object from the server WRITEME
	 */
	public abstract void from_wardrobe_ok (final JSONObject jso) ;


}
