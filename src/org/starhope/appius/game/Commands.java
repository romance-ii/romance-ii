/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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
 * License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game;

import java.security.NoSuchAlgorithmException;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.MembershipException;
import org.starhope.appius.except.NonSufficientFundsException;
import org.starhope.appius.except.NonSufficientItemsException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.inventory.GenericItemReference;
import org.starhope.appius.game.inventory.InventoryItemType;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.net.BatchProcessor;
import org.starhope.appius.net.NetIOThread;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.net.UserAgentInfo;
import org.starhope.appius.net.datagram.ADPClick;
import org.starhope.appius.net.datagram.ADPError;
import org.starhope.appius.net.datagram.ADPError.Codes;
import org.starhope.appius.net.datagram.ADPGameStart;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.services.Clodia;
import org.starhope.appius.sys.admin.Security;
import org.starhope.appius.sys.admin.SecurityCapability;
import org.starhope.appius.sys.op.FilterResult;
import org.starhope.appius.sys.op.OpCommands;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.User;
import org.starhope.appius.user.UserList;
import org.starhope.appius.user.UserPreferenceRecord;
import org.starhope.appius.user.events.EventType;
import org.starhope.appius.user.notifications.Notification;
import org.starhope.appius.user.notifications.NotificationReplyVerb;
import org.starhope.appius.user.notifications.NotificationReplyVerbSet;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * <h1>Command processor for Appius Game Server (JSON Commands)</h1>
 * <p>
 * This is the command interpreter library for JSON command received
 * from the game client. The server will search for commands in the
 * general library (using Java reflection to examine this class), as
 * well as a configuration-specified local “library” class for
 * extensions specific to a given game.
 * </p>
 * <p>
 * This command processor is scanned for a method name matching the
 * command name specified in the RPC call (JSON call) from the client.
 * These commands can be invoked by any client.
 * </p>
 * <p>
 * Command names must start with <tt>do_</tt>, followed by the
 * (typically javaCamelCased) command verb. The method signature must be
 * exactly <tt> public static void do_</tt> <i>verb</i>
 * <tt> (Zone, JSONObject, User, Integer) </tt>.
 * </p>
 * <p>
 * Security is generally <em>voluntary</em> and must be enforced by
 * individual methods.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Commands {
	
	/**
	 * Stick some useful debugging info about the user calling a method
	 * into a StringBuilder. Used by
	 * {@link #do_feedback(JSONObject, AbstractUser, Room)} and
	 * {@link #do_reportBug(JSONObject, AbstractUser, Room)}
	 * 
	 * @param u the user calling
	 * @param channel the user's room
	 * @param message the StringBuilder to which we'll append some nice
	 *             information
	 */
	private static void appendUsefulDebugInfo (final AbstractUser u,
			final Channel channel, final StringBuilder message) {
		message.append ("\n\n");
		message.append ("Sent by user ");
		message.append (u.getDebugName ());
		message.append (" who is in room ");
		if (null == u.getRoom ()) {
			message.append (" — whoa, actually, no room yet. Weird!");
		} else {
			message.append (u.getRoom ().getDebugName ());
		}
		message.append (" who is in channel ");
		if (null == channel) {
			message.append (" - whoa dude, where's my channel?");
		} else {
			message.append (channel.getMoniker ());
		}
		message.append (" from within thread ");
		message.append (Thread.currentThread ().toString ());
		message.append (" on ");
		message.append (AppiusClaudiusCaecus.getServerHostname ());
		message.append (" in the cluster led by ");
		message.append (AppiusClaudiusCaecus.getClusterLeader ());
		message.append (" on ");
		message.append (new java.util.Date ().toString ());
		message.append (".\n\n");
		final ServerThread t = u.getServerThread ();
		if (null == t) {
			message.append ("User does not have an active ServerThread.\n\n");
		} else {
			message.append ("Server Thread: ");
			message.append (t.toString ());
			message.append ("\nUser agent info:\n");
			message.append (t.getUserAgentInfo ().toString ());
		}
	}
	
	/**
	 * add a user to a buddy list or ignore list using the traditional
	 * (online-only, no notification engine) mechanism (using out of
	 * band methods). Compare vs. #do_requestBuddy
	 * 
	 * @param jso { buddy: (name) } or { ignore: (name) } or { buddy:
	 *             (name), confirm: (boolean), sign: (signature) }
	 * @param u The user calling this method
	 * @param channel The channel in which this user is in
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 */
	public static void do_addToList (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		if (jso.has ("buddy")) {
			final AbstractUser bud = Nomenclator.getUserByLogin (jso
					.getString ("buddy"));
			if (null == bud) {
				return;
			}
			if (jso.has ("confirm")) {
				if (jso.getBoolean ("confirm")) {
					// confirm a signed buddy request
					if (jso.getString ("sign").equals (
							Commands.getBuddySignature (bud, u))) {
						if (u instanceof GeneralUser) {
							Commands.log
									.debug ("Buddy signature confirmed for {}",
											u.getAvatarLabel ());
						}
					} else {
						if (u instanceof User) {
							Commands.log
									.debug ("Buddy signature for {} failed; proceeding regardless",
											u.getAvatarLabel ());
							final StringBuilder bugReport = new StringBuilder ();
							bugReport.append ("Possible security issue?\n\nBuddy signature failed from ");
							bugReport.append (u.getDebugName ());
							bugReport.append (" for ");
							bugReport.append (bud
									.getDebugName ());
							bugReport.append (" but permitted anyways");
							Commands.log.error (bugReport
									.toString ());
						}
					}
					
					u.addBuddy (bud);
					bud.addBuddy (u);
					final List <String> uBuddy = new LinkedList <String> ();
					final List <String> budBuddy = new LinkedList <String> ();
					uBuddy.add (bud.getAvatarLabel ());
					budBuddy.add (u.getAvatarLabel ());
					
					u.sendBuddyList ("$buddy", uBuddy);
					bud.sendBuddyList ("$buddy", budBuddy);
					
					jso.put ("buddy", u.getAvatarLabel ());
					jso.put ("isApproved", true);
					
					bud.acceptSuccessReply ("addToList", jso,
							u.getRoom ());
					return;
				}
				// anti-confirmation does not get acknowledged
				return;
			}
			// new request
			jso.put ("sign", Commands.getBuddySignature (u, bud));
			jso.remove ("buddy");
			jso.put ("sender", u.getAvatarLabel ());
			bud.acceptSuccessReply ("buddyRequest", jso,
					bud.getRoom ());
			return;
		}
		// ignore
		u.ignore (Nomenclator.getUserByLogin (jso
				.getString ("ignore")));
		u.acceptSuccessReply ("addToList", jso, u.getRoom ());
		
	}
	
	/**
	 * Sends a datagram to the command channel
	 * 
	 * @param jso WRITEME 
	 * @param u WRITEME 
	 * @param channel WRITEME 
	 * @throws JSONException
	 */
	public static void do_channel (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final String from = jso.getString ("c");
		try {
			final CommandDictionary cd = Nomenclator.getDataRecord (
					CommandDictionary.class, from);
			final AbstractDatagram datagram = cd
					.getDatagram (jso, u);
			datagram.echoClient (false);
			channel.broadcast (datagram);
		} catch (final NotFoundException e) {
			u.acceptErrorReply ("channel", "channel.commandError."
					+ from, null, u.getRoom ());
		}
	}
	
	/**
	 * Requests to join a channel
	 * 
	 * @param jso JSON object
	 * @param u User that's trying to join the channel
	 * @param channel the channel in which the method is being called
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 */
	public static void do_channelJoin (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		if (jso.has ("channel")) {
			final Channel joinChannel = u.getZone ().getChannel (
					jso.optString ("channel"));
			if (joinChannel == null) {
				u.acceptErrorReply ("channelJoin",
						"channelJoin.NoSuchChannel", null,
						u.getRoom ());
			} else if ( !joinChannel.join (u)) {
				u.acceptErrorReply ("channelJoin",
						"channelJoin.UnableToJoin", null,
						u.getRoom ());
			}
		} else {
			u.acceptErrorReply ("channelJoin",
					"channelJoin.ChannelMissing", null,
					u.getRoom ());
			return;
		}
	}
	
	/**
	 * Requests to join a channel
	 * 
	 * @param jso JSON object
	 * @param u User that's trying to join the channel
	 * @param channel the channel in which the method is being called
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 */
	public static void do_channelPart (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		if (jso.has ("channel")) {
			final Channel joinChannel = u.getZone ().getChannel (
					jso.optString ("channel"));
			if ( !joinChannel.part (u)) {
				u.acceptErrorReply ("channelPart",
						"channelPart.UnableToPart", null,
						u.getRoom ());
			}
		} else {
			u.acceptErrorReply ("channelPart",
					"channelPart.NoSuchChannel", null,
					u.getRoom ());
			return;
		}
	}
	
	/**
	 * <p>
	 * Used by the client to report a mouse click. There are a couple
	 * of different cases that this would be called.
	 * </p>
	 * <p>
	 * First: if the user clicks on a placed-item in a room, this
	 * method should be called with the following syntax:
	 * </p>
	 * <p>
	 * {"c":"click", "d":{ "on": <i>itemID</i>, "x": <i>x</i>, "y":
	 * <i>y</i>, "with": <i>mods</i> } }
	 * </p>
	 * <p>
	 * Note that the <i>(x,y)</i> values passed are <strong>relative to
	 * the origin point of the item</strong>; thus, if an item is
	 * placed at (200,200) and is clicked at (210,210), the coördinates
	 * reported should be (10,10).
	 * </p>
	 * <p>
	 * Alternatively, if the user clicks
	 * <em>anywhere on the screen</em> , and has one of the modifier
	 * keys held down (e.g. Shift, Meta, Control/Command) (but not
	 * Control on MacOS, as that represents a button-3-click), then
	 * send a click event like this:
	 * </p>
	 * <p>
	 * { "c":"click", "d":{ "x": <i>x</i>, "y":<i>y</i>,
	 * "with":<i>mods</i> } }
	 * </p>
	 * <p>
	 * Note the absence of the "on" attribute in the second form.
	 * </p>
	 * <hr>
	 * <p>
	 * The <i>mods</i> string can contain any of the following symbols
	 * in any order, representing modifier keys that were held down
	 * when the user clicked on the item:
	 * </p>
	 * <dl>
	 * <dt><b>^</b></dt>
	 * <dd>Caret represents the CONTROL key on Linux/Unix/Windows
	 * systems, or the COMMAND key on MacOS.</dd>
	 * <dt><b>S</b></dt>
	 * <dd>Ess represents the SHIFT key on any platform</dd>
	 * <dt><b>C</b></dt>
	 * <dd>Ci represents the CAPS LOCK state being enabled.</dd>
	 * <dt><b>N</b></dt>
	 * <dd>En represents the NUM LOCK state being enabled</dd>
	 * <dt><b>M</b></dt>
	 * <dd>Em represents the META key on Linux/Unix, ALT on
	 * Linux/Unix/Windows, or OPTION on MacOS</dd>
	 * <dt><b>L</b></dt>
	 * <dd>Ell represents the SCROLL LOCK state being enabled.</dd>
	 * <dt><b>A</b></dt>
	 * <dd>Ay represents the ALT-GR key on any platform (if supported)</dd>
	 * <dt><b>*</b></dt>
	 * <dd>Asterisk represents the SUPER key on Linux or WINDOWS-LOGO
	 * key on Windows.</dd>
	 * <dt><b>1</b>, <b>2</b>, <b>3</b></dt>
	 * <dd>One through three represent mouse buttons: 1 for left, 2 for
	 * middle, 3 for right. 1 would also be used for touchscreen tap,
	 * tablet tap, and so forth.</dd>
	 * <dt><b>0</b></dt>
	 * <dd>Zero represents the default, clickball, or OK button on a
	 * handset (usually located in the center of, or beside, a
	 * navigation directional pad, clickwheel, or trackball. The
	 * difference between mapping to “1” or “0” is that it's assumed
	 * “0” will be somehow aimed at a general area, where “1” has a
	 * precise target.</dd>
	 * <dt><b>+</b>, <b>-</b></dt>
	 * <dd>Plus represents rolling a scroll wheel down; Minus to scroll
	 * up</dd>
	 * <dt><b>&lt;</b>, <b>&gt;</b></dt>
	 * <dd>Less-than represents rolling a scroll knob left;
	 * greater-than, right.</dd>
	 * </dl>
	 * <h3>Flash details</h3>
	 * <p>
	 * In the Flash MouseEvent object, you can create the "mods" with
	 * the following:
	 * </p>
	 * <code>
	 * var mods:String = "";
	 * if (ev.altKey) mods += "M";
	 * if (ev.commandKey || ev.ctrlKey) mods += "^";
	 * if (ev.shiftKey) mods += "S";
	 * 
	 * if (ev.type == ev.CLICK) mods += "1";
	 * if (ev.type == ev.MIDDLE_CLICK) mods += "2";
	 * if (ev.type == ev.RIGHT_CLICK) mods += "3";
	 * if (ev.type == ev.MOUSE_WHEEL) {
	 * 		if (ev.delta < 0) mods += "-";
	 * 		if (ev.delta > 0) mods += "+";
	 * }
	 * 
	 * if (Keyboard.numLock) mods += "N";
	 * if (Keyboard.capsLock) mods += "C";
	 * </code>
	 * 
	 * @param jso See above. Must contain x, y, and mods. "mods" may be
	 *             a null string. May contain "on" with an ItemID (e.g.
	 *             "item99"), in which case, x,y are relative to the
	 *             item's origin.
	 * @param u The user clicking
	 * @param channel The channel the user is in
	 * @throws JSONException JSON data malformed
	 * @throws NotFoundException if the user can't have an inventory
	 *              ItemManager for some reason
	 */
	public static void do_click (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException, NotFoundException {
		final String with = jso.optString ("with");
		final Coord2D target = jso.has ("x") && jso.has ("y") ? new Coord2D (
				jso) : null;
		final Room r = u.getRoom ();
		final String clickedOn = jso.optString ("on");
		
		if (channel instanceof RoomChannel) {
			if (u.getInventory ().triggerClick (clickedOn, target,
					with.contains ("S"), with.contains ("^"),
					with.contains ("A"))) {
				r.triggerClick (u, clickedOn, target,
						with.contains ("S"), with.contains ("^"),
						with.contains ("A"));
			}
		} else {
			final ADPClick adpClick = new ADPClick (u);
			adpClick.setOn (clickedOn);
			adpClick.setWith (with);
			if (target != null) {
				adpClick.setX (target.getX ());
				adpClick.setY (target.getY ());
			}
			adpClick.echoClient (false);
			channel.broadcast (adpClick);
		}
	}
	
	/**
	 * Requests into for a specific currency
	 * 
	 * @param jso WRITEME 
	 * @param u WRITEME 
	 * @param channel WRITEME 
	 */
	public static void do_currencyInfo (final JSONObject jso,
			final AbstractUser u, final Channel channel) {
		if (jso.has ("code")) {
			try {
				final Currency currency = Nomenclator
						.getDataRecord (Currency.class,
								jso.getString ("code"));
				u.acceptDatagram (currency.toDatagram (u));
			} catch (final NotFoundException e) {
				u.acceptDatagram (new ADPError (u, "currencyInfo",
						"Could not find currency code specified",
						Codes.NOTFOUND));
			} catch (final JSONException e) {
				u.acceptDatagram (new ADPError (u, "currencyInfo",
						"code not specified in JSON packet",
						Codes.JSONERROR));
			}
		} else {
			u.acceptDatagram (new ADPError (u, "currencyInfo",
					"No currency code specified", Codes.NOTFOUND));
		}
	}
	
	/**
	 * <p>
	 * Echoes back the supplied JSON (or ActionScript) object to the
	 * client. This method exists solely for testing purposes.
	 * </p>
	 * <p>
	 * Sends response which is just the contents of your own “d”
	 * variable.
	 * </p>
	 * 
	 * @param jso Any JSON object, the contents of which will be
	 *             returned to the caller.
	 * @param u The user calling (to whom the response is sent)
	 * @param channel The channel in which the user calls us (ignored)
	 * @throws PrivilegeRequiredException requires staff level
	 *              privilege
	 */
	public static void do_echo (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException {
		u.assertStaffLevel (1);
		try {
			final ServerThread thread = u.getServerThread ();
			if (null != thread) {
				thread.sendResponse (jso, u.getRoom ().getID (),
						true);
			}
		} catch (final UserDeadException e) {
			Commands.log.error ("Client Bug", e);
		}
	}
	
	/**
	 * Equips an item for the user and sends out notifications
	 * 
	 * @param jso WRITEME 
	 * @param u WRITEME 
	 * @param channel WRITEME 
	 */
	public static void do_equip (final JSONObject jso,
			final AbstractUser u, final Channel channel) {
		try {
			final RealItem realItem = Nomenclator.getDataRecord (
					RealItem.class, jso.getInt ("realID"));
			if (u.getInventory ().equip (realItem)) {
				if (u.getRoom () != null) {
					u.getRoom ()
							.getRoomChannel ()
							.broadcast (
									u.getDatagram (u
											.getRoom ()), u);
				}
				u.acceptDatagram (u.getDatagram (u));
			} else {
				if (u.getRoom () != null) {
					u.getRoom ()
							.getRoomChannel ()
							.broadcast (
									u.getInventory ()
											.getEquipmentDatagram (
													u.getRoom ()),
									u);
				}
				u.acceptDatagram (u.getInventory ()
						.getEquipmentDatagram (u));
			}
		} catch (final NotFoundException e) {
			u.acceptDatagram (new ADPError (u, "equip",
					"Item not found", Codes.NOTFOUND));
		} catch (final JSONException e) {
			u.acceptDatagram (new ADPError (u, "equip",
					"Invalid JSON data", Codes.JSONERROR));
		} catch (final NonSufficientItemsException e) {
			u.acceptDatagram (new ADPError (u, "equip",
					"Not enough of those items to equip",
					Codes.NSI));
		}
	}
	
	/**
	 * Handles the case where the client was unable to start a game
	 * 
	 * @param jso WRITEME 
	 * @param u WRITEME 
	 * @param channel WRITEME 
	 */
	public static void do_error (final JSONObject jso,
			final AbstractUser u, final Channel channel) {
		// Empty stub
	}
	
	/**
	 * Accept a user comment, complaint, or whatever. This is a
	 * general-purpose method that just dispatches the user's input via
	 * the bug-reporting mechanism to the configured “feedback”
	 * address.
	 * 
	 * @param jso any contents of this will be interpreted as
	 *             string-string pairs and included in the message.
	 *             Recommended usage is to have an element named
	 *             “Message” for the user's feedback, entered vida a
	 *             form.
	 * @param u The invoking user
	 * @param channel The invoking user's current channel.
	 */
	@SuppressWarnings ("unchecked")
	public static void do_feedback (final JSONObject jso,
			final AbstractUser u, final Channel channel) {
		final StringBuilder message = new StringBuilder ();
		final Iterator <String> keys = jso.keys ();
		while (keys.hasNext ()) {
			final String key = keys.next ();
			message.append (key);
			message.append (":\n");
			try {
				message.append (jso.get (key));
			} catch (final JSONException e) {
				message.append ("(ERROR: ");
				message.append (e.toString ());
				message.append (')');
			}
			Commands.appendUsefulDebugInfo (u, channel, message);
		}
		
		Commands.feedbackLog.info (message.toString ());
	}
	
	/**
	 * <p>
	 * Get public info for a list of (other) users.
	 * </p>
	 * <p>
	 * Reply format:
	 * </p>
	 * 
	 * <pre>
	 *  { from: avatars, status: true, avatars: { 0: { USER-INFO … }, … }
	 * </pre>
	 * <p>
	 * User public information is in the format of
	 * {@link AbstractUser#getPublicInfo()}
	 * </p>
	 * 
	 * @param jso JSON object, with (ignored) keys tied to values which
	 *             must be the names of users.
	 * @param u The calling user. The calling user's avatar data will
	 *             <em>not</em> be returned.
	 * @param channel the (ignored) room in which the method is being
	 *             called
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 */
	@SuppressWarnings ("unchecked")
	public static void do_finger (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final Iterator <String> keys = jso.keys ();
		final JSONObject list = new JSONObject ();
		while (keys.hasNext ()) {
			final String key = keys.next ();
			try {
				final String fellowsName = jso.getString (key);
				if ( !fellowsName.equals (u.getAvatarLabel ())) {
					final AbstractUser fellow = Nomenclator
							.getUserByLogin (fellowsName);
					if (null != fellow) {
						list.put (fellowsName, fellow
								.getDatagram (u).toString ());
					}
				}
			} catch (final JSONException e) {
				Commands.log.error ("Exception", e);
				// continue on to next key, however.
			}
		}
		final JSONObject result = new JSONObject ();
		try {
			result.put ("avatars", list);
		} catch (final JSONException e) {
			Commands.log.error ("Exception", e);
		}
		u.acceptSuccessReply ("avatars", result, u.getRoom ());
	}
	
	/**
	 * Attempts to alter the furnishings of a room
	 * 
	 * @param jso WRITEME 
	 * @param u WRITEME 
	 * @param channel WRITEME 
	 * @throws JSONException
	 * @throws NotFoundException
	 */
	public static void do_furnish (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException, NotFoundException {
		
		final String roomName = jso.optString ("room");
		final Room room = !"".equals (roomName) ? u.getRoom ()
				.getZone ().getRoom (roomName, u) : u.getRoom ();
		if (room.getOwner () != u) {
			u.acceptDatagram (new ADPError (
					u,
					"furnish",
					"Cannot change furnishings in rooms you do not own",
					Codes.NSP));
			return;
		}
		
		final String itemCode = jso.optString ("item");
		final JSONArray locArray = jso.has ("loc") ? jso
				.getJSONArray ("loc") : null;
		final Coord2D location = (locArray != null)
				&& (locArray.length () == 2) ? new Coord2D (
				locArray.getDouble (0), locArray.getDouble (1))
				: null;
		final RealItem realItem = jso.has ("realID") ? Nomenclator
				.getDataRecord (RealItem.class,
						jso.getInt ("realID")) : null;
		final String facing = jso.has ("facing") ? jso
				.getString ("facing") : null;
		final List <InventoryItemType> types = new LinkedList <InventoryItemType> ();
		if (jso.has ("type")) {
			final JSONArray typeArray = jso.getJSONArray ("type");
			for (int i = 0; i < typeArray.length (); i++ ) {
				try {
					types.add (Nomenclator.getDataRecord (
							InventoryItemType.class,
							typeArray.getString (i)));
				} catch (final NotFoundException e) {
					Commands.log.error ("Exception", e);
				}
			}
		}
		
		try {
			if ("".equals (itemCode) && (location != null)
					&& (realItem != null)) {
				// Add item to room
				room.addItemPlace (u, realItem, location, facing);
				// u.acceptDatagram (u.getInventory
				// ().getInventoryDatagram (u, types.toArray (new
				// InventoryItemType [] {})));
			} else if (itemCode.startsWith ("item")
					&& (location == null)) {
				// Remove item from room
				room.removeItemPlace (u, itemCode);
				// u.acceptDatagram (u.getInventory
				// ().getInventoryDatagram (u, types.toArray (new
				// InventoryItemType [] {})));
			} else if (itemCode.startsWith ("item")
					&& (locArray != null)) {
				// Move item in room
				room.moveItemPlace (u, itemCode, location, facing);
			} else if (realItem != null) {
				if (u.getInventory ().getCount (realItem) > 0) {
					// Setting an individual room var (wall, floor,
					// ceiling, etc)
					try {
						final int oldItemID = Integer.valueOf (
								room.getVariable (itemCode))
								.intValue ();
						final RealItem oldItem = Nomenclator
								.getDataRecord (RealItem.class,
										oldItemID);
						u.getInventory ().addItem (oldItem, 1);
					} catch (final NumberFormatException e) {
						// Don't care
					} catch (final NotFoundException e) {
						Commands.log.error ("Exception", e);
					}
					u.getInventory ().addItem (realItem, -1);
					room.setVariable (itemCode, Integer
							.toString (realItem.getRealID ()),
							true);
					// u.acceptDatagram (u.getInventory
					// ().getInventoryDatagram (u, types.toArray
					// (new InventoryItemType []
					// {})));
				} else {
					u.acceptDatagram (new ADPError (u, "furnish",
							"Insufficient items", Codes.NSI));
				}
			} else {
				// Uh oh, couldn't figure out what to do
				u.acceptDatagram (new ADPError (
						u,
						"furnish",
						"Could not accomplish furnish command with parameters given",
						Codes.JSONERROR));
			}
		} catch (final PrivilegeRequiredException e) {
			Commands.log.error ("Exception", e);
		}
		
	}
	
	/**
	 * <p>
	 * WRITEME — basically similar to an
	 * {@link #do_sendOutOfBandMessage(JSONObject, AbstractUser, Room)}
	 * but specifically something to do with a game
	 * </p>
	 * <p>
	 * Can broadcast to a particular channel; if omitted, uses the
	 * room's default channel (TODO!)
	 * </p>
	 * 
	 * @param jso { "action": (verb), [ "channel": (moniker) ], (other
	 *             params...) }
	 * @param u The user calling this method
	 * @param channel The room in which this user is in
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 */
	public static void do_gameAction (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		
		if (channel instanceof RoomChannel) {
			((RoomChannel) channel).broadcastAcceptGameAction (u,
					jso);
		} else {
			u.getRoom ().getRoomChannel ()
					.broadcastAcceptGameAction (u, jso);
		}
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param jso WRITEME 
	 * @param u WRITEME 
	 * @param channel WRITEME 
	 * @throws JSONException
	 */
	public static void do_gameEnd (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final String moniker = jso.getString ("moniker");
		
		final long score = jso.has ("score") ? jso.getLong ("score")
				: 0L;
		
		try {
			final GameEvent gameEvent = Nomenclator.getDataRecord (
					GameEvent.class, moniker);
			final EventType type = gameEvent.getEndEvent ();
			if ( (null != type) && type.allowedToHave (u)) {
				final EventPrototypeInfo info = new EventPrototypeInfo ();
				info.setPoints (score);
				type.doEvent (info, u);
			}
		} catch (final NotFoundException e) {
			Commands.log.error ("Exception", e);
		} catch (final NotReadyException e) {
			Commands.log.error ("Exception", e);
		} catch (final NonSufficientFundsException e) {
			Commands.log.error ("Exception", e);
		} catch (final NonSufficientItemsException e) {
			Commands.log.error ("Exception", e);
		} catch (final MembershipException e) {
			Commands.log.error ("Exception", e);
		}
	}
	
	/**
	 * Sends a request to start a game for a user
	 * 
	 * @param jso WRITEME 
	 * @param u WRITEME 
	 * @param channel WRITEME 
	 * @throws JSONException
	 */
	public static void do_gameStart (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final String moniker = jso.getString ("moniker");
		
		GameEvent gameEvent = null;
		try {
			gameEvent = Nomenclator.getDataRecord (GameEvent.class,
					moniker);
		} catch (final NotFoundException e) {
			u.acceptDatagram (new ADPError (u, "gameStart",
					"Not Found", Codes.NOTFOUND));
			return;
		}
		if ("Event".equals (gameEvent.getLoader ())) {
			final EventType type = gameEvent.getEndEvent ();
			if ( (null != type) && type.allowedToHave (u)) {
				try {
					final EventPrototypeInfo info = new EventPrototypeInfo ();
					info.setPoints (0L);
					type.doEvent (info, u);
				} catch (final NotReadyException e) {
					Commands.log.error ("Exception", e);
				} catch (final NonSufficientFundsException e) {
					Commands.log.error ("Exception", e);
				} catch (final NonSufficientItemsException e) {
					Commands.log.error ("Exception", e);
				} catch (final MembershipException e) {
					Commands.log.error ("Exception", e);
				}
			}
		} else {
			final ADPGameStart response = new ADPGameStart (u);
			response.setMoniker (gameEvent.getMoniker ());
			response.setFilename (gameEvent.getFilePath ());
			response.setLoader (gameEvent.getLoader ());
			response.setWidth (gameEvent.getFileWidth ());
			response.setHeight (gameEvent.getFileHeight ());
			u.acceptDatagram (response);
		}
	}
	
	/**
	 * Get avatar data for a list of (other) users.
	 * 
	 * @param jso JSON object, with (ignored) keys tied to values which
	 *             must be the names of users. e.g. { 0: "someUser", 1:
	 *             "otherUser" }
	 * @param u The calling user. The calling user's avatar data will
	 *             <em>not</em> be returned.
	 * @param channel the (ignored) channel in which the method is
	 *             being called
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 */
	public static void do_getAvatars (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		Commands.do_finger (jso, u, channel);
	}
	
	/**
	 * <p>
	 * get all inventory for an user — both active and inactive
	 * </p>
	 * <p>
	 * Returns a set of items as inv: { 0: { id: 123, isActive: boolean
	 * }, ... } — furniture with placement data will also have x, y,
	 * and facing vars. Other attributes are "from":"inventory",
	 * "type": matching the type of the question
	 * </p>
	 * 
	 * @param jso { }
	 * @param u The user whose inventory to be searched
	 * @param channel The channel in which the user is in
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 */
	public static void do_getInventory (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final AbstractUser targetUser = jso.has ("who") ? Nomenclator
				.getUserByLogin (jso.getString ("who")) : u;
		final List <InventoryItemType> types = new LinkedList <InventoryItemType> ();
		if (jso.has ("type")) {
			final JSONArray typeArray = jso.getJSONArray ("type");
			for (int i = 0; i < typeArray.length (); i++ ) {
				try {
					types.add (Nomenclator.getDataRecord (
							InventoryItemType.class,
							typeArray.getString (i)));
				} catch (final NotFoundException e) {
					Commands.log.error ("Exception", e);
				}
			}
		}
		u.acceptDatagram (targetUser
				.getInventory ()
				.getInventoryDatagram (
						u,
						types.toArray (new InventoryItemType [] {})));
	}
	
	/**
	 * Get a list of users in a Zone, or in a Room. This is an
	 * administrative function, only available to staff members.
	 * 
	 * @param jso The JSON data provided by the caller. If this
	 *             contains an attribute of "inRoom" with a room
	 *             moniker, we'll only return the users in that room.
	 *             Otherwise, all users in the Zone will be returned.
	 * @param u The caller's ID. Must have staff privileges.
	 * @param channel The channel from which the caller is making the
	 *             extension call: ignored.
	 * @throws JSONException if the JSON data can't be processed, in or
	 *              out.
	 * @throws PrivilegeRequiredException if the user doesn't have
	 *              STAFF_LEVEL_STAFF_MEMBER
	 * @throws NotFoundException if the room requested doesn't exist
	 */
	public static void do_getOnlineUsers (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException, PrivilegeRequiredException,
			NotFoundException {
		
		Security.hasCapability (u, new SecurityCapability (
				SecurityCapability.CAP_SYSOP_COMMANDS));
		
		final JSONObject response = new JSONObject ();
		final JSONObject userList = new JSONObject ();
		final Room room = u.getRoom ();
		
		if (jso.has ("inRoom")) {
			final String roomName = jso.getString ("inRoom");
			response.put ("inRoom", roomName);
			for (final AbstractUser user : room.getZone ()
					.getRoom (roomName, null).getAllUsers ()) {
				userList.put (String.valueOf (user.getUserID ()),
						user.getAvatarLabel ());
			}
		} else {
			final JSONObject roomsJSO = new JSONObject ();
			final Iterator <Room> roomIter = room.getZone ()
					.getRoomList ().iterator ();
			while (roomIter.hasNext ()) {
				final Room thatRoom = roomIter.next ();
				final String roomName = thatRoom.getName ();
				final JSONObject roomObj = new JSONObject ();
				for (final AbstractUser user : room.getZone ()
						.getRoom (roomName, null).getAllUsers ()) {
					roomObj.put (
							String.valueOf (user.getUserID ()),
							user.getAvatarLabel ());
				}
				roomsJSO.put (roomName, roomObj);
			}
			response.put ("rooms", roomsJSO);
			final Iterator <AbstractUser> users = room.getZone ()
					.getAllUsersInZone ().iterator ();
			while (users.hasNext ()) {
				final String userName = users.next ()
						.getAvatarLabel ();
				userList.put (userName, userName);
			}
		}
		
		response.put ("userList", userList);
		
		u.acceptSuccessReply ("getUserList", response, room);
	}
	
	/**
	 * Get a list of all “well known” Rooms currently active/visible.
	 * 
	 * @param jso Ignored
	 * @param u The user requesting the data.
	 * @param channel Ignored
	 * @throws JSONException If something untoward happens
	 */
	public static void do_getRoomList (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final JSONObject result = new JSONObject ();
		result.put ("from", "roomList");
		result.put ("status", true);
		result.put ("roomList", u.getZone ().getRoomList_JSON ());
		try {
			final NetIOThread thread = u.getServerThread ();
			if (null != thread) {
				thread.sendResponse (result);
			}
		} catch (final UserDeadException e) {
			Commands.log
					.error ("Caught a UserDeadException in do_getRoomList",
							e);
		}
	}
	
	/**
	 * <p>
	 * Send the server time to the client requesting it (for
	 * synchronization purposes)
	 * </p>
	 * <p>
	 * Sends a JSON object with a single property, serverTime, with the
	 * current time in milliseconds (give or take transit time)
	 * </p>
	 * 
	 * @param jso ignored
	 * @param u The user requesting the time
	 * @param channel The channel in which the user is in
	 * @throws JSONException If the JSON data can't be written out
	 */
	public static void do_getServerTime (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final JSONObject time = new JSONObject ();
		time.put ("serverTime", System.currentTimeMillis ());
		final Room thatRoom = u.getRoom ();
		if (null != thatRoom) {
			final Collection <GameRoom> games = thatRoom
					.getGameEvents ();
			for (final GameRoom game : games) {
				final long gameTime = game.getTimer ();
				if (gameTime > 0) {
					time.put ("gameTime", gameTime);
					time.put ("gameTime/" + game.getGameCode (),
							gameTime);
				}
			}
		}
		u.acceptSuccessReply ("serverTime", time, thatRoom);
	}
	
	/**
	 * Initialise a session key for batch mode operations
	 * 
	 * @param jso ignored
	 * @param who unused
	 * @param channel unused
	 * @return Replies with { from: initSession, key: (OPAQUE-STRING) }
	 * @throws JSONException if the reply can't be encoded in JSON form
	 *              for some reason...
	 */
	public static JSONObject do_getSessionApple (final JSONObject jso,
			final AbstractUser who, final Channel channel)
			throws JSONException {
		final JSONObject session = new JSONObject ();
		session.put ("from", "apple");
		session.put ("status", false);
		session.put ("err", "op.batchOnly");
		final ServerThread myself = who.getServerThread ();
		if (null == myself) {
			return session;
		}
		if ( ! (myself instanceof BatchProcessor)) {
			return session;
		}
		session.put ("status", true);
		session.put ("apple",
				((BatchProcessor) myself).initSession ());
		return session;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param jso JavaScript array-style object where the key names are
	 *             ignored, but the values are item ID's
	 * @param u WRITEME
	 * @param r WRITEME
	 * @return WRITEME
	 * @throws JSONException if things go very wrongly.
	 */
	@SuppressWarnings ({ "cast", "unchecked" })
	public static JSONObject do_getStoreItemInfo (
			final JSONObject jso, final AbstractUser u,
			final Channel channel) throws JSONException {
		final Iterator <String> keys = (Iterator <String>) jso
				.keys ();
		final JSONObject infos = new JSONObject ();
		while (keys.hasNext ()) {
			final String key = keys.next ();
			GenericItemReference item;
			try {
				item = Nomenclator.getDataRecord (
						GenericItemReference.class,
						jso.getInt (key));
				infos.put (key, item.toJSON ());
			} catch (final NotFoundException e) {
				final JSONObject err = new JSONObject ();
				err.put ("err", "notFound");
				
				infos.put (key, err);
			}
		}
		final JSONObject reply = new JSONObject ();
		reply.put ("items", infos);
		reply.put ("status", true);
		reply.put ("from", "getStoreItemInfo");
		return reply;
	}
	
	/**
	 * Get the user's buddy list and ignore list.
	 * <p>
	 * { buddyList: { … } , ignoreList: { … } }
	 * </p>
	 * 
	 * @param jso no parameters needed
	 * @param u The user whose buddy and ignore lists will be fetched
	 * @param channel The user's current channel (ignored)
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 */
	public static void do_getUserLists (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		if (u instanceof GeneralUser) {
			final Clodia clodia = new Clodia ((GeneralUser) u,
					Thread.currentThread ());
			clodia.start ();
		} else {
			Commands.log
					.error ("Unimplemented: getUserLists for non-Clōdia");
			u.acceptErrorReply ("getUserLists", "unimplemented",
					null, u.getRoom ());
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param jso WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 * @throws JSONException WRITEME
	 */
	public static void do_getWallet (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		AbstractUser target = u;
		if (jso.has ("who")) {
			final String forUser = jso.getString ("who");
			target = Nomenclator.getUserByLogin (forUser);
		}
		final AbstractDatagram response = target == null ? new ADPError (
				u, "getWallet", "User not found", Codes.NOTFOUND)
				: target.getWallet ().toDatagram (u);
		u.acceptDatagram (response);
	}
	
	/**
	 * Get a list of all Zones currently active/visible. (Empty and
	 * retired Zones are culled. See {@link Zone#getZoneList_JSON} )
	 * 
	 * @param jso Ignored
	 * @param u The user requesting the data.
	 * @param channel Ignored
	 * @throws JSONException If something untoward happens
	 */
	public static void do_getZoneList (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final JSONObject response = new JSONObject ();
		response.put ("from", "zoneList");
		response.put ("status", true);
		response.put ("zoneList", u.getZone ().getZoneList_JSON (u));
		try {
			final NetIOThread thread = u.getServerThread ();
			if (null != thread) {
				thread.sendResponse (response);
			}
		} catch (final UserDeadException e) {
			// Default catch action, report bug
			// (brpocock@star-hope.org,
			// Dec 30, 2009)
			Commands.log
					.error ("Caught a UserDeadException in do_getZoneList",
							e);
		}
	}
	
	/**
	 * Give an item to another user
	 * <p>
	 * XXX: notify the recipient using notifications (currently using a
	 * Message Box popup message)
	 * </p>
	 * 
	 * @param jso { slot: SLOT-NUMBER, to: USER-LOGIN }
	 * @param u giver
	 * @param channel room of gift being given
	 * @throws JSONException if the JSON data is malformed
	 * @throws AlreadyExistsException if the event can't be started for
	 *              some reason
	 */
	public static void do_give (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException, AlreadyExistsException {
		final AbstractUser recipient = Nomenclator
				.getUserByLogin (jso.getString ("to"));
		if (null == recipient) {
			u.acceptDatagram (new ADPError (u, "give",
					"Unable to find recipient", Codes.NOTFOUND));
			return;
		}
		
		RealItem invItem = null;
		try {
			invItem = Nomenclator.getDataRecord (RealItem.class,
					jso.getInt ("id"));
			if (u.getInventory ().isEquipped (invItem)) {
				u.getInventory ().unequip (invItem);
			}
		} catch (final NotFoundException e) {
			u.acceptDatagram (new ADPError (u, "give",
					"Unable to find item", Codes.NOTFOUND));
			return;
		}
		final GenericItemReference item = invItem.getItemReference ();
		
		if ( !recipient.isPaidMember ()) {
			u.acceptMessage (
					"Gift",
					"Gift",
					"Sorry, you can't give " + item.getTitle ()
							+ " (" + item.getDescription ()
							+ ") to "
							+ recipient.getAvatarLabel ()
							+ " because "
							+ recipient.getAvatarLabel ()
							+ " is not a V.I.T.");
			recipient.acceptMessage (
					"Gift",
					"Gift",
					u.getAvatarLabel () + " wanted to give you "
							+ item.getTitle () + " ("
							+ item.getDescription ()
							+ "), if you were a V.I.T.");
			return;
		}
		if ( !item.canTrade ()) {
			u.acceptMessage (
					"Gift",
					"Gift",
					"Sorry, you can't give away "
							+ item.getTitle () + " ("
							+ item.getDescription () + ")");
			return;
		}
		
		try {
			final EventType type = Nomenclator.getDataRecord (
					EventType.class, "gift");
			final EventPrototypeInfo giveEvent = new EventPrototypeInfo ();
			giveEvent.require (invItem, 1);
			giveEvent.earn (invItem, -1);
			type.doEvent (giveEvent, u);
			final EventPrototypeInfo receiveEvent = new EventPrototypeInfo ();
			receiveEvent.earn (invItem, 1);
			type.doEvent (receiveEvent, recipient);
			u.acceptDatagram (u.getDatagram (u));
			u.acceptDatagram (recipient.getDatagram (recipient));
		} catch (final NotFoundException e) {
			Commands.log.error ("Exception", e);
		} catch (final NotReadyException e) {
			Commands.log.error ("Exception", e);
		} catch (final NonSufficientFundsException e) {
			u.acceptDatagram (new ADPError (u, "give",
					"Insufficient funds", Codes.NSF));
			// Should never happen, so log it
			Commands.log.error ("Exception", e);
		} catch (final NonSufficientItemsException e) {
			u.acceptDatagram (new ADPError (u, "give",
					"Insufficient items", Codes.NSI));
		} catch (final MembershipException e) {
			Commands.log.error ("Exception", e);
		}
		
	}
	
	/**
	 * go to a place and/or perform a gesture
	 * 
	 * @param jso { do: VERB <i>(required)</i> <br />
	 *             x: DEST, y: DEST, z: DEST <i>(each optional, but if
	 *             x or y is given, both must be; z can be omitted)
	 *             </i> <br />
	 *             facing: FACING <i>(optional)</i> <br />
	 *             }
	 * @param u the user doing something
	 * @param channel the room in which the user is standing
	 * @throws JSONException if the packet can't be decoded somehow
	 */
	public static void do_go (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final Coord3D loc = u.getLocation ();
		final Room room = u.getRoom ();
		final double destX = jso.has ("x") && !jso.isNull ("x") ? jso
				.getDouble ("x") : loc.getX ();
		final double destY = jso.has ("y") && !jso.isNull ("y") ? jso
				.getDouble ("y") : loc.getY ();
		final double destZ = jso.has ("z") && !jso.isNull ("z") ? jso
				.getDouble ("z") : loc.getZ ();
		final String verb = jso.getString ("do");
		final String facing = jso.has ("facing") ? jso
				.getString ("facing") : null;
		final boolean itWorked = room.goTo_locked (u, new Coord3D (
				destX, destY, destZ), facing, verb, loc);
		
		if (itWorked) {
			room.areaEffects (u, u.getTarget ());
		} else {
			u.acceptErrorReply ("go", "walk.space", null, room);
		}
	}
	
	/**
	 * Join a room. On success, sends back the set of room join events;
	 * but on failure, replies with { from: roomJoin, status: false,
	 * err: ...}
	 * <p>
	 * <dl>
	 * <dt>zone.notFound</dt>
	 * <dd>The user is not in a Zone</dd>
	 * <dt>room.noMoniker</dt>
	 * <dd>No room moniker was given to be joined</dd>
	 * <dt>room.notFound</dt>
	 * <dd>The room moniker does not refer to an actual room in this
	 * Zone</dd>
	 * <dt>room.full</dt>
	 * <dd>The room is too full (too many users)</dd>
	 * </dl>
	 * 
	 * @param jso { room: MONIKER } or { room: MONIKER, from: MONIKER }
	 * @param u the user joining the room
	 * @param channel the user's prior room
	 * @throws JSONException if the packet can't be produced
	 */
	public static void do_join (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final Zone zone = u.getZone ();
		if (null == zone) {
			u.acceptDatagram (new ADPError (u, "join",
					"Room not found", Codes.NOTFOUND));
			return;
		}
		
		String moniker = jso.getString ("room");
		String outplace = "";
		if (moniker.contains ("/")) {
			final String [] arr = moniker.split ("/");
			moniker = arr [0];
			outplace = arr [1];
		}
		final AbstractUser user = jso.has ("whose") ? Nomenclator
				.getUserByLogin (jso.getString ("whose")) : null;
		
		final Room newRoom = zone.getRoom (moniker, user);
		
		if (newRoom == null) {
			u.acceptDatagram (new ADPError (u, "join",
					"Room not found", Codes.NOTFOUND));
		} else {
			newRoom.join (u, outplace);
		}
	}
	
	/**
	 * <p>
	 * Log out of this game session (or zone)
	 * </p>
	 * <p>
	 * There's a bug in the Persephone client that causes it to explode
	 * if we log it out before it receives & processes the logout
	 * message. So, we wait for the expected lag time to expire and
	 * then throw 2 full seconds of wasted wait time after it, which
	 * had ought to be enough time
	 * </p>
	 * <p>
	 * <strong>Note:</strong> in the future, this will be configured to
	 * be <em>off by
	 * default</em>. Tootsville™ servers will need to incorporate the
	 * configuration key value if Persephone 2 hasn't been fixed by
	 * that time.
	 * </p>
	 * 
	 * @param jso no data
	 * @param u The user logging out
	 * @param channel The room in which the user was in
	 */
	public static void do_logout (final JSONObject jso,
			final AbstractUser u, final Channel channel) {
		final ServerThread serverThread = u.getServerThread ();
		if (null != serverThread) {
			u.acceptSuccessReply ("logout", null, u.getRoom ());
			if (AppiusConfig
					.getConfigBoolOrTrue ("com.tootsville.bugs.logoutSleep")) {
				try {
					Thread.sleep (200);
					// Thread.sleep (2000 + u.getLag ());
				} catch (final InterruptedException e) {
					// ignore it, it's not all that important, is
					// it?
				} // FIXME FUCKING HATE THIS
			}
			serverThread.logout ();
		}
	}
	
	/**
	 * send an eMail to customer service (feedback)
	 * 
	 * @param jso { subject: STRING, body: STRING }
	 * @param u the user sending the feedback
	 * @param channel the room in which the user is in
	 */
	public static void do_mailCustomerService (final JSONObject jso,
			final AbstractUser u, final Channel channel) {
		// Mail.sendTemplateMail (Nomenclator.getSystemUser (),
		// "mailCustomerService", false, )
		// TODOD
	}
	
	/**
	 * Leave a channel
	 * 
	 * @param jso channel: MONIKER
	 * @param u user departing
	 * @param channel unused
	 * @throws JSONException bad JSON
	 */
	public static void do_part (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final Zone zone = u.getZone ();
		if (null == zone) {
			u.acceptErrorReply ("part", "zone.notFound", null,
					u.getRoom ());
			return;
		}
		
	}
	
	/**
	 * Send a “ping” to the server to get back a “pong.” This also
	 * updates the user's last-active timestamp, to prevent them from
	 * being idled offline.
	 * 
	 * @param jso No parameters
	 * @param u The user sending the “ping”
	 * @param channel The room in which the user is in
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 */
	public static void do_ping (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		u.setLastActive ();
		u.acceptSuccessReply ("pong", null, u.getRoom ());
	}
	
	/**
	 * <p>
	 * Server initiates prompt with:
	 * </p>
	 * 
	 * <pre>
	 * 
	 * 
	 * { "from" : "prompt",
	 *   "id" : $ID,
	 *   "label" : $LABEL,
	 *   "label_en_US" : $LABEL,
	 *   "title" : $TITLE,
	 *   [ "attachUser" : $AVATAR_LABEL || "attachItem" : $ITEM_ID ] ,
	 *   "msg" : $TEXT,
	 *   "replies" :
	 *    {  $TOKEN :
	 *        { "label" : $BUTTON_LABEL,
	 *          "label_en_US" : $BUTTON_LABEL,
	 *          "type" : $BUTTON_TYPE },
	 *      [ … ]
	 *    }
	 * }
	 * </pre>
	 * <p>
	 * Where:
	 * </p>
	 * <ul>
	 * <li>$ID = arbitrary string with no \0 representing this question
	 * uniquely. This is not an user-visible string.</li>
	 * <li>$LABEL = concatenated to the window title, but can be used
	 * to special-case / theme dialogs in future for certain purposes</li>
	 * <li>$TITLE = dialog title</li>
	 * <li><em>Only one</em> of either “attachUser” <em>or</em>
	 * “attachItem” will be included. $AVATAR_LABEL is the full avatar
	 * label of the user/avatar to which the prompt should be attached
	 * — including “$” and instance ID, if necessary — where $ITEM_ID
	 * is the room variable item ID for a placed item in the room.</li>
	 * <li>$TEXT = message text, may have \n, will often need
	 * word-wrapping, and ideally might make use of scroll bars</li>
	 * </ul>
	 * <p>
	 * The "replies" assoc-array is of arbitrary length ≥ 2, where the
	 * key to each item is a $TOKEN, again an arbitrary string without
	 * \0 to represent this response uniquely. This is not an
	 * user-visible string.
	 * </p>
	 * <p>
	 * $BUTTON_LABEL = the text to display. In future, the client may
	 * want to special-case specific text to use icons or something:
	 * e.g. "OK" will always be sent as precisely "OK" in English
	 * locale.
	 * </p>
	 * <p>
	 * $BUTTON_TYPE = the type of the button for theming purposes only.
	 * This is from the enumerated set [ "aff" | "neg" | "neu" ];
	 * <ul>
	 * <li>aff = affirmative button, e.g. green button</li>
	 * <li>neg = negative button, e.g. red button</li>
	 * <li>neu = neutral button, e.g. purple button</li>
	 * </ul>
	 * </p>
	 * <p>
	 * To simplify future i18n/l10n efforts, the $LABEL and
	 * $BUTTON_LABEL will always be sent twice. The user's current
	 * language version will be in the "label" properties. The versions
	 * of those strings in the "en_US" locale will always be in the
	 * "label_en_US" properties. For purposes of theming and such, the
	 * label_en_US properties should be considered; the "label"
	 * properties, however, should always be used in presentation to
	 * the end-user.
	 * </p>
	 * <p>
	 * Example:
	 * </p>
	 * 
	 * <pre>
	 * { "from": "prompt", "status": "true",
	 *    "id": "fountain/tootSquare/þ=?/x'deadbeef'",
	 *   "label": "Fountain", "label_en_US": "Fountain",
	 *   "title": "Make a Wish?", "msg": "Do you want to make a wish on the Toot Square fountain?",
	 *   "replies":
	 *    { "yes": { "label": "Make a Wish!", "label_en_US": "Make a Wish!", "type": "aff" },
	 *      "no": { "label": "Not now", "label_en_US": "Not now", "type": "neg" }
	 *    }
	 * }
	 * </pre>
	 * <p>
	 * The client's response is a bit simpler:
	 * </p>
	 * 
	 * <pre>
	 * { "c": "promptReply", "d": { "id": $ID, "reply": $TOKEN } }
	 * </pre>
	 * <p>
	 * e.g.
	 * </p>
	 * 
	 * <pre>
	 * { "c":"promptReply", "d": { "id":  "fountain/tootSquare/þ=?/x'deadbeef'", "reply": "yes" } }
	 * </pre>
	 * <p>
	 * As a special-case, for the reply only, the special $TOKEN of
	 * "close" should be sent if the user dismissed the dialog box with
	 * the close button.
	 * </p>
	 * <p>
	 * I'd suggest that the GUI attach anonymous functions with the
	 * reply packets already constructed to the various dialog box
	 * controls at creation time, rather than trying to manage some
	 * queue of pending prompts.
	 * </p>
	 * <p>
	 * To handle user expectations, it would be best to display the
	 * button in a "down" state until receiving the server's
	 * acknowledgement of the "promptReply" and disallow
	 * multiple-clicking in the window.
	 * </p>
	 * <p>
	 * The server will respond with
	 * </p>
	 * 
	 * <pre>
	 * { "from": "promptReply", "status": "true", "id": $ID }
	 * </pre>
	 * <p>
	 * For debugging purposes, the server may reply with
	 * </p>
	 * 
	 * <pre>
	 * { "from": "promptReply", "status": "false", "err": $ERR }
	 * </pre>
	 * <p>
	 * Where $ERR will be a brief description of the problem. e.g. $ERR
	 * = "reply.notFound" might represent a reply button that was not a
	 * valid $TOKEN from the "prompt" command nor the special case
	 * "close". $ERR = "id.notFound" might represent a reply to a
	 * prompt that was not (recently) asked.
	 * </p>
	 * <p>
	 * A prompt ID is not valid across sessions; pending prompts should
	 * be auto-closed on logout. Prompts can, however, remain active
	 * indefinitely, even across room joins.
	 * </p>
	 * <p>
	 * Optional implementation: the server may cancel an outstanding
	 * prompt request by sending a packet with the following
	 * properties:
	 * </p>
	 * <ul>
	 * <li>from: prompt</li>
	 * <li>status: true</li>
	 * <li>cancel: $ID</li>
	 * </ul>
	 * <p>
	 * Client applications may choose to dismiss the prompt
	 * automatically upon receiving such a packet. Failure to do so is
	 * not an error, however, later attempting to reply to a canceled
	 * prompt will return status: false, err: id.notFound. Clients must
	 * accept a cancelation packet silently if they do not process it.
	 * </p>
	 * 
	 * @param jso in the form { id: $ID, reply: $TOKEN }, as detailed
	 *             above
	 * @param u the user replying to a prompt
	 * @param channel the room in which the user is standing
	 *             (unimportant)
	 * @throws JSONException for really bad syntax errors
	 */
	public static void do_promptReply (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		// work-around for a typo:
		final Room room = u.getRoom ();
		if ( !jso.has ("reply") && jso.has ("replay")) {
			jso.put ("reply", jso.get ("replay"));
		}
		if ( ! (jso.has ("id") && jso.has ("reply"))) {
			u.acceptErrorReply ("promptReply", "syntax", null, room);
			return;
		}
	}
	
	/**
	 * <p>
	 * Execute a purchase of an item by an user. Deducts peanuts,
	 * registers (and ends) an event, and adds the appropriate item to
	 * the user's inventory.
	 * </p>
	 * <p>
	 * Returns a success reply to the caller with "bought": (itemID) ,
	 * "title": (item title), and "totalPeanuts": (the user's new
	 * personal balance of peanuts to spend, with this transaction
	 * already deducted) (status:true, from:purchase)
	 * </p>
	 * <p>
	 * Error reply of err="nsf" = not-sufficient-funds, or err="dupe" =
	 * duplicate item
	 * </p>
	 * 
	 * @param jso <code>{ "itemID": itemID }</code>
	 * @param u The buyer
	 * @param channel The buyer's channel
	 * @throws JSONException if the data can't be put in or out of
	 *              JSON-land.
	 * @throws NotFoundException if the item was bought and didn't
	 *              exist
	 */
	public static void do_purchase (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException, NotFoundException {
		final int itemID = jso.getInt ("itemID");
		Commands.purchase (u, channel, itemID);
	}
	
	/**
	 * Remove someone from a buddy list or ignore list.
	 * 
	 * @param jso To remove a buddy: { buddy: (name) }; or to attend to
	 *             someone who had previously been ignored: { ignore:
	 *             (name) }
	 * @param u The user whose buddy list or ignore list will be
	 *             updated
	 * @param channel The channel in which the user is standing
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 */
	public static void do_removeFromList (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		if (jso.has ("buddy")) {
			u.removeBuddy (Nomenclator.getUserByLogin (jso
					.getString ("buddy")));
		} else {
			u.attend (Nomenclator.getUserByLogin (jso
					.getString ("ignore")));
		}
		u.acceptSuccessReply ("removeFromList", jso, u.getRoom ());
	}
	
	/**
	 * This method allows the client to “phone home” to report a bug.
	 * The bug report itself is just a giant string embedded in the
	 * “bug” element, but a “cause” element will be treated as the
	 * subject. Note that the bug report — like all JSON input — will
	 * be cut off at a certain limit (typically 4KiB), so it's most
	 * helpful to keep it short & sweet: Typically, this should be
	 * something like a single stack backtrace (with as much detail as
	 * possible), rather than a complete log trace or something.
	 * <p>
	 * <strong>The suggested usage</strong> is to include the exception
	 * itself as “cause,” the backtrace up to a maximum of 1KiB, a log
	 * backtrace up to its last 1KiB as “bug,” and as much
	 * machine-formatted system information as possible in the “info”
	 * object.
	 * </p>
	 * <h3>Fields of “info”</h3>
	 * <p>
	 * As many fields as possible, limit the contents to a reasonable
	 * length though…
	 * </p>
	 * <p>
	 * Note that the keys listed are <em>strings</em>, so e.g.:
	 * </p>
	 * 
	 * <pre>
	 * info [&quot;navigator.language&quot;] = navigator.language;
	 * info [&quot;navigator.product&quot;] = navigator.product;
	 * </pre>
	 * <p>
	 * ActionScript example: — BUT wait: This does <em>not</em> seem to
	 * work; there's a far more verbose example, down below, which is
	 * closer to accurately functional.
	 * </p>
	 * 
	 * <pre>
	 * var info:Object = {
	 *    "flash.sys.ime": flash.system.System.ime,
	 *    "flash.sys.totalMemory": flash.system.System.totalMemory,
	 *    "flash.sys.useCodePage": flash.system.System.useCodePage
	 * };
	 *    // imperfect but close
	 * for ( var key in flash.system.Capabilities ) {
	 * 	info["flash.sysCap." + key] = flash.system.Capabilities[key];
	 * }
	 * </pre>
	 * <dl>
	 * <dt>navigator.language</dt>
	 * <dd>JavaScript: navigator.language</dd>
	 * <dt>navigator.product</dt>
	 * <dd>JavaScript: navigator.product</dd>
	 * <dt>navigator.appVersion</dt>
	 * <dd>JavaScript: navigator.appVersion</dd>
	 * <dt>navigator.platform</dt>
	 * <dd>JavaScript: navigator.platform</dd>
	 * <dt>navigator.vendor</dt>
	 * <dd>JavaScript: navigator.vendor</dd>
	 * <dt>navigator.appCodeName</dt>
	 * <dd>JavaScript: navigator.appCodeName</dd>
	 * <dt>navigator.cookieEnabled</dt>
	 * <dd>JavaScript: navigator.cookieEnabled</dd>
	 * <dt>navigator.appName</dt>
	 * <dd>JavaScript: navigator.appName</dd>
	 * <dt>navigator.productSub</dt>
	 * <dd>JavaScript: navigator.productSub</dd>
	 * <dt>navigator.userAgent</dt>
	 * <dd>JavaScript: navigator.userAgent</dd>
	 * <dt>navigator.vendorSub</dt>
	 * <dd>JavaScript: navigator.vendorSub</dd>
	 * <dt>screen.height</dt>
	 * <dd>JavaScript: screen.height; ActionScript:
	 * flash.system.Capabilities.screenResolutionX</dd>
	 * <dt>screen.width</dt>
	 * <dd>JavaScript: screen.width; ActionScript:
	 * flash.system.Capabilities.screenResolutionY</dd>
	 * <dt>screen.availHeight</dt>
	 * <dd>JavaScript: screen.availHeight; ActionScript:
	 * flash.display.Stage.fullScreenHeight</dd>
	 * <dt>screen.availWidth</dt>
	 * <dd>JavaScript: screen.availWidth; ActionScript:
	 * flash.display.Stage.fullScreenWidth</dd>
	 * <dt>window.outerHeight</dt>
	 * <dd>JavaScript: window.outerheight <em>note case</em></dd>
	 * <dt>window.outerWidth</dt>
	 * <dd>JavaScript: window.outerwidth <em>note case</em></dd>
	 * <dt>window.innerHeight</dt>
	 * <dd>JavaScript: window.innerheight <em>note case</em></dd>
	 * <dt>window.innerWidth</dt>
	 * <dd>JavaScript: window.innerwidth <em>note case</em></dd>
	 * <dt>window.windowName</dt>
	 * <dd>JavaScript: the window.name property of the highest parent
	 * of this window (frame); e.g.
	 * 
	 * <pre>
	 * var topWindow = window.parent;
	 * for (; topWindow.parent != topWindow; topWindow = topWindow.parent)
	 * 	;
	 * info [&quot;window.windowName&quot;] = topWindow.name;
	 * </pre>
	 * 
	 * <dt>flash.sys.totalMemory</dt>
	 * <dd>ActionScript: flash.system.System.totalMemory</dd>
	 * <dt>flash.sys.ime</dt>
	 * <dd>ActionScript: flash.system.System.ime</dd>
	 * <dt>flash.sys.useCodePage</dt>
	 * <dd>ActionScript: flash.system.System.useCodePage</dd>
	 * <dt>flash.sysCap.avHardwareDisable</dt>
	 * <dd>ActionScript: flash.system.Capabilities.avHardwareDisable</dd>
	 * <dt>flash.sysCap.hasAccessibility</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasAccessibility</dd>
	 * <dt>flash.sysCap.hasAudio</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasAudio</dd>
	 * <dt>flash.sysCap.hasAudioEncoder</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasAudioEncoder</dd>
	 * <dt>flash.sysCap.hasEmbeddedVideo</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasEmbeddedVideo</dd>
	 * <dt>flash.sysCap.hasIME</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasIME</dd>
	 * <dt>flash.sysCap.hasMP3</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasMP3</dd>
	 * <dt>flash.sysCap.hasPrinting</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasPrinting</dd>
	 * <dt>flash.sysCap.hasScreenBroadcast</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasScreenBroadcast</dd>
	 * <dt>flash.sysCap.hasScreenPlayback</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasScreenPlayback</dd>
	 * <dt>flash.sysCap.hasStreamingAudio</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasStreamingAudio</dd>
	 * <dt>flash.sysCap.hasStreamingVideo</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasStreamingVideo</dd>
	 * <dt>flash.sysCap.hasTLS</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasTLS</dd>
	 * <dt>flash.sysCap.hasVideoEncoder</dt>
	 * <dd>ActionScript: flash.system.Capabilities.hasVideoEncoder</dd>
	 * <dt>flash.sysCap.isDebugger</dt>
	 * <dd>ActionScript: flash.system.Capabilities.isDebugger</dd>
	 * <dt>flash.sysCap.isEmbeddedInAcrobat</dt>
	 * <dd>ActionScript: flash.system.Capabilities.isEmbeddedInAcrobat</dd>
	 * <dt>flash.sysCap.language</dt>
	 * <dd>ActionScript: flash.system.Capabilities.language</dd>
	 * <dt>flash.sysCap.localFileReadDisable</dt>
	 * <dd>ActionScript: flash.system.Capabilities.localFileReadDisable
	 * </dd>
	 * <dt>flash.sysCap.manufacturer</dt>
	 * <dd>ActionScript: flash.system.Capabilities.manufacturer</dd>
	 * <dt>flash.sysCap.os</dt>
	 * <dd>ActionScript: flash.system.Capabilities.os</dd>
	 * <dt>flash.sysCap.pixelAspectRatio</dt>
	 * <dd>ActionScript: flash.system.Capabilities.pixelAspectRatio</dd>
	 * <dt>flash.sysCap.playerType</dt>
	 * <dd>ActionScript: flash.system.Capabilities.playerType</dd>
	 * <dt>flash.sysCap.screenColor</dt>
	 * <dd>ActionScript: flash.system.Capabilities.screenColor</dd>
	 * <dt>flash.sysCap.screenDPI</dt>
	 * <dd>ActionScript: flash.system.Capabilities.screenDPI</dd>
	 * <dt>flash.sysCap.version</dt>
	 * <dd>ActionScript: flash.system.Capabilities.version</dd>
	 * <dt>flash.displayState</dt>
	 * <dd>ActionScript: if flash.display.Stage.displayState ==
	 * FULL_SCREEN_INTERACTIVE, then "fullScreen"; for NORMAL, return
	 * "window".</dd>
	 * <dt>flash.frameRate</dt>
	 * <dd>ActionScript: flash.display.Stage.frameRate</dd>
	 * <dt>flash.quality</dt>
	 * <dd>ActionScript: flash.display.Stage.quality</dd>
	 * <dt>flash.scaleMode</dt>
	 * <dd>ActionScript: flash.display.Stage.scaleMode</dd>
	 * </dl>
	 * 
	 * <pre>
	 * // ActionScript example
	 * function systemReport:Object () {
	 *  return {
	 *   "screen": {
	 *    "height": flash.system.Capabilities.screenResolutionX,
	 *    "width": flash.system.Capabilities.screenResolutionY,
	 *    "availHeight": flash.display.Stage.fullScreenHeight,
	 *    "availWidth": flash.display.Stage.fullScreenWidth,
	 *   },
	 *   "flash": {
	 *    "sys": {
	 *     "totalMemory": flash.system.System.totalMemory,
	 *     "ime": flash.system.System.ime,
	 *     "useCodePage": flash.system.System.useCodePage,
	 *    },
	 *    "sysCap": {
	 *     "avHardwareDisable": flash.system.Capabilities.avHardwareDisable,
	 *     "hasAccessibility": flash.system.Capabilities.hasAccessibility,
	 *     "hasAudio": flash.system.Capabilities.hasAudio,
	 *     "hasAudioEncoder": flash.system.Capabilities.hasAudioEncoder,
	 *     "hasEmbeddedVideo": flash.system.Capabilities.hasEmbeddedVideo,
	 *     "hasIME": flash.system.Capabilities.hasIME,
	 *     "hasMP3": flash.system.Capabilities.hasMP3,
	 *     "hasPrinting": flash.system.Capabilities.hasPrinting,
	 *     "hasScreenBroadcast": flash.system.Capabilities.hasScreenBroadcast,
	 *     "hasScreenPlayback": flash.system.Capabilities.hasScreenPlayback,
	 *     "hasStreamingAudio": flash.system.Capabilities.hasStreamingAudio,
	 *     "hasStreamingVideo": flash.system.Capabilities.hasStreamingVideo,
	 *     "hasTLS": flash.system.Capabilities.hasTLS,
	 *     "hasVideoEncoder": flash.system.Capabilities.hasVideoEncoder,
	 *     "isDebugger": flash.system.Capabilities.isDebugger,
	 *     "isEmbeddedInAcrobat": flash.system.Capabilities.isEmbeddedInAcrobat,
	 *     "language": flash.system.Capabilities.language,
	 *     "localFileReadDisable": flash.system.Capabilities.localFileReadDisable,
	 *     "manufacturer": flash.system.Capabilities.manufacturer,
	 *     "os": flash.system.Capabilities.os,
	 *     "pixelAspectRatio": flash.system.Capabilities.pixelAspectRatio,
	 *     "playerType": flash.system.Capabilities.playerType,
	 *     "screenColor": flash.system.Capabilities.screenColor,
	 *     "screenDPI": flash.system.Capabilities.screenDPI,
	 *     "version": flash.system.Capabilities.version
	 *    },
	 *    "displayState": ( flash.display.Stage.displayState == FULL_SCREEN_INTERACTIVE ? "fullScreen" : "window" ),
	 *    "frameRate": flash.display.Stage.frameRate,
	 *    "quality": flash.display.Stage.quality,
	 *    "scaleMode": flash.display.Stage.scaleMode
	 *   }
	 *  };
	 * }
	 * 
	 * </pre>
	 * 
	 * @param jso Must contain a single string attribute named “bug.”
	 *             Should contain an attribute named “info” with system
	 *             information key-value pairs (see above). May also
	 *             have a subject of “cause” as a string.
	 * @param u The user reporting the bug.
	 * @param channel The user's current channel.
	 * @throws JSONException JSON encoding error
	 */
	@SuppressWarnings ("unchecked")
	public static void do_reportBug (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final StringBuilder bugReport = new StringBuilder ();
		bugReport.append ("\n\nThe user agent has reported this bug: \n");
		bugReport.append (jso.getString ("bug"));
		if (jso.has ("cause")) {
			bugReport.append ("\n\nThis may have been caused by ");
			bugReport.append (jso.getString ("cause"));
			bugReport.append ('\n');
		}
		if (jso.has ("info")) {
			bugReport.append ("\n\n----------\nSystem Info:\n");
			final JSONObject info = jso.getJSONObject ("info");
			final Iterator <String> keymaster = info.keys ();
			while (keymaster.hasNext ()) {
				final String key = keymaster.next ();
				final Object value = info.get (key);
				bugReport.append (key);
				bugReport.append (": ");
				bugReport.append (value);
				bugReport.append ('\n');
			}
		}
		Commands.appendUsefulDebugInfo (u, channel, bugReport);
		// BugReporter.getReporter ("client").reportBug
		// (bugReport.toString ());
		
		final JSONObject result = new JSONObject ();
		result.put ("status", true);
		result.put ("from", "reportBug");
		
		try {
			final NetIOThread thread = u.getServerThread ();
			if (null != thread) {
				thread.sendResponse (result);
			}
		} catch (final UserDeadException e) {
			// Don't ask; don't care
		}
	}
	
	/**
	 * Report an user to the moderator(s) on duty for breaking a rule
	 * 
	 * @param jso { userName = user to be reported }
	 * @param u The user who is reporting the other user
	 * @param channel The channel in which the reporting user is
	 *             standing
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 */
	public static void do_reportUser (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final String reportedUser = jso.getString ("userName");
		
		final AbstractUser victim = Nomenclator
				.getUserByLogin (reportedUser);
		if (null == victim) {
			return;
		}
		victim.reportedToModeratorBy (u);
		
		u.acceptMessage ("Reported", "Lifeguard", String.format (
				LibMisc.getText ("reportedUser"), reportedUser));
	}
	
	/**
	 * Request adding a user to your buddy list (mutual-add) using the
	 * new notification-based system
	 * 
	 * @param jso { buddy: LOGIN }
	 * @param u user who is requesting the addition
	 * @param channel unused
	 * @throws JSONException if the data can't be interpreted
	 */
	public static void do_requestBuddy (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final AbstractUser wannaBeBuddy = Nomenclator
				.getUserByLogin (jso.getString ("buddy"));
		final Notification request = new Notification (u,
				"buddy.request", wannaBeBuddy);
		
		final NotificationReplyVerbSet verbs = new NotificationReplyVerbSet ();
		final NotificationReplyVerb accept = new NotificationReplyVerb (
				"buddy.request.accept");
		try {
			accept.setPayload (UserList.getBuddyApprovalCookie (u,
					wannaBeBuddy));
		} catch (final NoSuchAlgorithmException e) {
			Commands.log.error ("Exception", e);
		}
		verbs.add (accept);
		verbs.add (new NotificationReplyVerb ("buddy.request.decline"));
		
		request.getReplyVerbs ().addAll (verbs);
		request.send ();
	}
	
	/**
	 * <p>
	 * Send an arbitrary JSON packet to another user, or all of the
	 * users in a room, out of the band of communications. This is
	 * neither a public nor a private message in the chat context: just
	 * some additional data that is being provided.
	 * </p>
	 * <code>
	 *  { sender:
	 * sender, from: outOfBand, status: true, body: {JSON} }
	 * </code>
	 * <p>
	 * Adds "roomTitle" to body if body contains "room" and title can
	 * be determined
	 * </p>
	 * <p>
	 * Add “"sendRoomList": "true"” to give the user an updated room
	 * list as well. (Necessary for invitations to new rooms.)
	 * </p>
	 * <h3>Inviting to houses …</h3>
	 * <ol>
	 * <li>initUserRoom { room: 0, autoJoin: false }
	 * <ul>
	 * <li>{ from: initUserRoom, status: true, moniker: ROOM-MONIKER }
	 * ** OK</li>
	 * <li>=> { from: initUserRoom, status: false, err: exists,
	 * moniker: ROOM-MONIKER } ** OK</li>
	 * <li>=> { from: initUserRoom, status: false, err: showFirstRun }
	 * ** ERR (player does not have that room)</li>
	 * </ul>
	 * </li>
	 * <li>sendOutOfBandMessage { to: USER-LOGIN, body: { locType:
	 * "house", type: "invite", room: MONIKER } } <br />
	 * { from: outOfBand, sender: YOUR-LOGIN, status: true, body: {
	 * locType: "house", type: "invite", room: MONIKER, roomTitle:
	 * USER-VISIBLE-NAME } }</li>
	 * </ol>
	 * <p>
	 * for user houses, roomTitle will be like "BlackDaddyNerd's House"
	 * </p>
	 * 
	 * @param jso To send to one user:
	 *             <code>{ to: userName, body: {JSON} }</code>, or to
	 *             broadcast to the entire room:
	 *             <code> { toRoom: true, body:
	 *            {JSON} } </code>
	 * @param u The sender of the out-of-band-message
	 * @param channel The room in which the sender is standing.
	 *             Necessary for the <tt>toRoom</tt> version of this
	 *             method.
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 */
	public static void do_sendOutOfBandMessage (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		
		final AbstractUser to = Nomenclator.getUserByLogin (jso
				.getString ("to"));
		if (null == to) {// user does not exist
			u.acceptMessage (
					"Say Who?",
					"Catullus",
					"I don't see anyone named “"
							+ jso.getString ("to") + "”");
			return;
		}
		
		final JSONObject body = jso.getJSONObject ("body");
		if (body.has ("room")) {
			final String roomName = body.getString ("room");
			if (roomName.startsWith ("user~")) {
				final String [] roomNameParts = roomName
						.split ("~");
				body.put ("roomTitle", roomNameParts [1]
						+ "’s House");
				body.remove ("room");
				body.put ("room", "user~" + roomNameParts [1] + "~"
						+ roomNameParts [2]);
			} else {
				final Room theRoom = u.getZone ().getRoom (
						roomName, null);
				if (theRoom == null) {
					body.put ("roomTitle", roomName);
				} else {
					body.put ("roomTitle", theRoom.getTitle ());
				}
			}
		}
		
		if (jso.has ("sendRoomList")) {
			{
				final ServerThread userThread = to
						.getServerThread ();
				if (null != userThread) {
					try {
						userThread.sendRoomList ();
					} catch (final UserDeadException e) {
						// nah, nah, boo, boo
					}
				}
			}
		}
		
		if (jso.has ("toRoom")) {
			u.getRoom ().getRoomChannel ()
					.broadcastAcceptOutOfBandMessage (u, body);
			return;
		}
		
		final JSONObject reply = new JSONObject ();
		reply.put ("body", body);
		reply.put ("sender", u.getAvatarLabel ());
		to.acceptSuccessReply ("outOfBand", reply, u.getRoom ());
		
	}
	
	/**
	 * Accept the client's notification of a server-time adjustment.
	 * This is used to compute the client's round-trip lag time.
	 * 
	 * @param jso { serverTime: LONG milliseconds since epoch }
	 * @param u The user responding
	 * @param channel The channel in which the user is in
	 * @throws JSONException if the packet is malformed
	 */
	public static void do_serverTime (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		if (u instanceof User) {
			((User) u).setRoundTripLag (System.currentTimeMillis ()
					- jso.getLong ("serverTime"));
		}
	}
	
	/**
	 * <p>
	 * Set user variable(s)
	 * </p>
	 * Input: { key : value } (one or more)
	 * 
	 * @param jso user variable(s) to set
	 * @param u the user setting them
	 * @param channel the channel in which the user is in
	 * @throws JSONException if the JSO can't be decoded
	 */
	@SuppressWarnings ("unchecked")
	public static void do_setUserVar (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final Map <String, String> map = new HashMap <String, String> ();
		final Iterator <String> keys = jso.keys ();
		while (keys.hasNext ()) {
			final String key = keys.next ();
			map.put (key, jso.getString (key));
		}
		u.setVariables (map);
	}
	
	/**
	 * <p>
	 * Handle speech by the user. XXX This <em>should</em> be calling
	 * {@link User#speak(Room, String)} to do the dirty work: but, in
	 * fact, the reverse is currently true.
	 * </p>
	 * <p>
	 * Speech is public to all users in a room.
	 * </p>
	 * <p>
	 * Emotes are simply speech beginning with "/". A few are
	 * special-cased. WRITEME: which
	 * </p>
	 * <p>
	 * Commands are speech beginning with "#"
	 * </p>
	 * 
	 * @param jso { "speech": TEXT-TO-BE-SPOKEN }
	 * @param u The user speaking
	 * @param channel The channel in which the speech occurs.
	 * @throws JSONException Thrown if the data cannot be interpreted
	 *              from the JSON objects passed in, or conversely, if
	 *              we can't encode a response into a JSON form
	 * @throws NotFoundException WRITEME
	 */
	public static void do_speak (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException, NotFoundException {
		
		// final String filterStatus = "";
		String speech = jso.getString ("speech");
		
		if (speech.contains (",dumpthreads,")) {
			OpCommands.op_dumpthreads (new String [] {}, u, channel);
			return;
		}
		if (speech.contains (",credits,")) {
			OpCommands.z$z (u);
			return;
		}
		
		if ( !u.canTalk () && !speech.startsWith ("/")) {
			u.sendOops ();
			return;
		}
		
		if (speech.length () < 1) {
			return;
		}
		
		switch (speech.charAt (0)) {
		case '#':
			OpCommands.exec (channel, u, speech);
			return;
		case '@':
			Commands.speak_atMessage (u, channel, speech);
			return;
		case '$':
			OpCommands.hook (channel, u, speech);
			return;
		case '~':
			// no op… should have been handled by the client
			return;
		case '!':
		case '%':
		case '^':
		case '&':
		case '*':
			// no op… reserved for future purposes
			return;
		}
		
		speech = Commands.handleDice (speech);
		
		speech = Commands.nonObnoxious (speech);
		
		if ( !u.hasStaffLevel (1)) {
			final int maxLength = AppiusConfig.getIntOrDefault (
					"org.starhope.appius.speak.maxLength", 75);
			if (speech.length () > maxLength) {
				speech = speech.substring (0, maxLength);
			}
		}
		
		final Channel targetChannel = channel == null ? u.getRoom ()
				.getRoomChannel () : channel;
		u.speak (targetChannel, speech);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param jso WRITEME 
	 * @param u WRITEME 
	 * @param channel WRITEME 
	 */
	public static void do_unequip (final JSONObject jso,
			final AbstractUser u, final Channel channel) {
		try {
			final RealItem realItem = Nomenclator.getDataRecord (
					RealItem.class, jso.getInt ("realID"));
			if (u.getInventory ().unequip (realItem)) {
				if (u.getRoom () != null) {
					u.getRoom ()
							.getRoomChannel ()
							.broadcast (
									u.getDatagram (u
											.getRoom ()), u);
				}
				u.acceptDatagram (u.getDatagram (u));
			} else {
				if (u.getRoom () != null) {
					u.getRoom ()
							.getRoomChannel ()
							.broadcast (
									u.getInventory ()
											.getEquipmentDatagram (
													u.getRoom ()),
									u);
				}
				u.acceptDatagram (u.getInventory ()
						.getEquipmentDatagram (u));
			}
		} catch (final NotFoundException e) {
			u.acceptDatagram (new ADPError (u, "equip",
					"Item not found", Codes.NOTFOUND));
		} catch (final JSONException e) {
			u.acceptDatagram (new ADPError (u, "equip",
					"Invalid JSON data", Codes.JSONERROR));
		}
	}
	
	/**
	 * Create a fancy signature thing to validate buddy list requests
	 * 
	 * @param u The user calling this method
	 * @param u2 The user with whom they want to be buddies
	 * @return a fancy signature thing to validate buddy list requests
	 */
	private static String getBuddySignature (final AbstractUser u,
			final AbstractUser u2) {
		try {
			return UserList.getBuddyApprovalCookie (u, u2);
		} catch (final NoSuchAlgorithmException e) {
			Commands.log.error ("Exception", e);
		}
		return null;
	}
	
	/**
	 * Get the current Subversion level of this file
	 * 
	 * @return the current Subversion revision level of this file
	 */
	public static String getRev () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param typeString WRITEME
	 * @return WRITEME
	 */
	private static Collection <InventoryItemType> getTypeSetFromString (
			final String typeString) {
		final Collection <InventoryItemType> typeSet = new HashSet <InventoryItemType> ();
		final List <String> typeIDs;
		if (typeString.charAt (0) == '#') {
			typeIDs = new LinkedList <String> ();
			for (final String id : typeString.substring (1).split (
					Pattern.quote (":"))) {
				typeIDs.add (id);
			}
		} else if (typeString.charAt (0) == '$') {
			typeIDs = new LinkedList <String> ();
			for (final String ident : typeString.substring (1)
					.split (Pattern.quote (":"))) {
				try {
					typeIDs.add (String.valueOf (Nomenclator
							.getDataRecord (
									InventoryItemType.class,
									ident).getID ()));
				} catch (final NotFoundException e) {
					Commands.log
							.error ("Caught a NotFoundException in Commands.getTypeSetFromString ",
									e);
				}
			}
		} else {
			typeIDs = AppiusConfig
					.getList ("org.starhope.appius.inventory.types."
							+ typeString);
		}
		for (final String typeID : typeIDs) {
			try {
				try {
					typeSet.add (Nomenclator.getDataRecord (
							InventoryItemType.class,
							Integer.parseInt (typeID)));
				} catch (final NotFoundException e) {
					Commands.log
							.error ("Caught a NotFoundException in Commands.getTypeSetFromString ",
									e);
				}
			} catch (final NumberFormatException e) {
				Commands.log
						.error ("Types list org.starhope.appius.inventory.types."
								+ typeString
								+ " contains bad key " + typeID);
			}
		}
		return typeSet;
	}
	
	/**
	 * Handle die rolls, coin tosses, and magic Rock-Paper-Scissors
	 * picker
	 * 
	 * @param inSpeech Speech before filtering
	 * @return Speech after filtering
	 */
	static String handleDice (final String inSpeech) {
		String speech = inSpeech;
		if ("/coin".equals (speech)) {
			// filterStatus = "cointoss";
			if (Math.random () > 0.5) {
				speech = "/coinheads";
			} else {
				speech = "/cointails";
			}
		} else if ("/rps".equals (speech)) {
			// filterStatus = "rockpaperscissors";
			if (Math.random () > (1 / 3)) {
				speech = "/rock";
			} else if (Math.random () > (1 / 2)) {
				speech = "/paper";
			} else {
				speech = "/scissors";
			}
		} else if ("/dice".equals (speech)) {
			// filterStatus = "die rolled";
			final int rolled = (int) ( (Math.random () * 6) + 1);
			switch (rolled) {
			case 1:
				speech = "/diceone";
				break;
			case 2:
				speech = "/dicetwo";
				break;
			case 3:
				speech = "/dicethree";
				break;
			case 4:
				speech = "/dicefour";
				break;
			case 5:
				speech = "/dicefive";
				break;
			case 6:
				speech = "/dicesix";
				break;
			default:
				Commands.log.error ("Die landed on a corner.");
			}
		}
		return speech;
	}
	
	/**
	 * remove some of the more obnoxious punctuation abuses from a
	 * string
	 * 
	 * @param speech a string to be edited
	 * @return the same string with some obnoxious punctuation faux pas
	 *         removed
	 */
	private static String nonObnoxious (final String speech) {
		return speech.replace ("!!", "!").replace (",,", ",")
				.replace ("....", "...").replace ("??", "?");
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param buyer the buyer
	 * @param channel where the buyer is
	 * @param itemID the item to be purchased
	 * @throws JSONException if communications encoding fails
	 * @throws NotFoundException if the item doesn't exist
	 */
	public static void purchase (final AbstractUser buyer,
			final Channel channel, final int itemID)
			throws JSONException, NotFoundException {
		try {
			final RealItem realItem = Nomenclator.getDataRecord (
					RealItem.class, itemID);
			final long price = realItem.getItemReference ()
					.getPrice ();
			if (price < 0) {
				buyer.acceptDatagram (new ADPError (buyer,
						"purchase", "Invalid", Codes.INVALID));
				Commands.log
						.error ("POSSIBLE HACKING ATTEMPT DETECTED.  User "
								+ buyer.getUserID ()
								+ "("
								+ buyer.getAvatarLabel ()
								+ ") attempted to purchase "
								+ realItem.getItemReference ()
										.getItemID ()
								+ " for " + price);
				return;
			}
			if ( (price > 0)
					|| (buyer.getInventory ().getCount (realItem) == 0)) {
				final EventType type = Nomenclator.getDataRecord (
						EventType.class, "purchase");
				final EventPrototypeInfo info = new EventPrototypeInfo ();
				info.require (Currency.getPeanuts (), price);
				info.earn (Currency.getPeanuts (), -price);
				info.earn (realItem, 1);
				type.doEvent (info, buyer);
			} else {
				buyer.acceptDatagram (new ADPError (buyer,
						"purchase", "Invalid", Codes.INVALID));
			}
		} catch (final NonSufficientFundsException e) {
			buyer.acceptDatagram (new ADPError (buyer, "purchase",
					"NSF", Codes.NSF));
		} catch (final NotReadyException e) {
			// Means this has been happening too quickly. Just eat
			// it.
		} catch (final NonSufficientItemsException e) {
			buyer.acceptDatagram (new ADPError (buyer, "purchase",
					"NSI", Codes.NSI));
		} catch (final MembershipException e) {
			if (e.isPaidOnly ()) {
				buyer.acceptDatagram (new ADPError (buyer,
						"purachse", "Paid member only",
						Codes.PAIDONLY));
			}
		}
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Mar 11,
	 * 2010)
	 * 
	 * @param u WRITEME
	 * @param channel WRITEME
	 * @param speech WRITEME
	 */
	private static void speak_atMessage (final AbstractUser u,
			final Channel channel, final String speech) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final String kidsName = speech.substring (1).substring (0,
				speech.indexOf (' ') - 1);
		final AbstractUser kid = Nomenclator
				.getUserByLogin (kidsName);
		if (null != kid) {
			final String phrase = speech.substring (speech
					.indexOf (' '));
			if (kid.hasStaffLevel (u.getStaffLevel ())) {
				kid.acceptMessage ("", u.getAvatarLabel (), phrase);
				u.acceptMessage ("(sent)\n", u.getAvatarLabel (),
						speech);
			} else {
				kid.acceptMessage (
						"",
						u.hasStaffLevel (User.STAFF_LEVEL_DEVELOPER) ? "Lifeguard"
								: "Tourguide", phrase);
				u.acceptMessage ("(sent) @" + kidsName,
						"Lifeguard", phrase);
			}
		} else {
			u.acceptMessage ("@message", "Lifeguard",
					"Can't find a kid named " + kidsName);
		}
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Mar 11,
	 * 2010)
	 * 
	 * @param u WRITEME
	 * @param carlSays WRITEME
	 * @return WRITEME
	 */
	@SuppressWarnings ("unused")
	private static String speak_filterResultToString (
			final AbstractUser u, final FilterResult carlSays) {
		final String filterStatus;
		switch (carlSays.status) {
		case Ok:
			filterStatus = "said";
			break;
		case Black:
			u.sendOops ();
			filterStatus = "Oops";
			break;
		case Red:
			if (AppiusConfig.confDontKickStaff ()
					&& (u.getStaffLevel () > User.STAFF_LEVEL_PUBLIC)) {
				u.acceptMessage (
						"Redlisted word hit",
						"God",
						LibMisc.getText ("kickLang")
								+ "\n\n(Protected bt Staff Of Protection)");
			} else {
				try {
					u.kick (Nomenclator.getUserByID (1), "obs", 15);
				} catch (final PrivilegeRequiredException e) {
					Commands.log.error ("Exception", e);
				}
			}
			filterStatus = "REDLIST";
			break;
		default:
			filterStatus = "¿que?";
		}
		return filterStatus;
	}
	
	/**
	 * Get a configuration key from the server's config.properties
	 * file, based upon a key name beginning with "client." — note that
	 * clients cannot read arbitrary server config file values for
	 * security purposes; e.g. the config file probably has a database
	 * password or similar in it.
	 * 
	 * @param jso WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 * @throws JSONException WRITEME
	 */
	public void do_getConfig (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		final JSONObject reply = new JSONObject ();
		final String key = jso.getString ("key");
		reply.put ("k", key);
		String s;
		try {
			s = AppiusConfig.getConfig ("client." + key);
		} catch (final NotFoundException e) {
			if (jso.has ("default")) {
				s = jso.getString ("default");
			} else {
				u.acceptErrorReply ("getConfig", "err.notFound",
						reply, u.getRoom ());
				return;
			}
		}
		reply.put ("v", s);
		u.acceptSuccessReply ("getConfig", reply, u.getRoom ());
	}
	
	/**
	 * Obtain user preferences formerly saved using
	 * {@link #do_savePrefs(JSONObject, AbstractUser, Room)}
	 * 
	 * @param jso ignored
	 * @param u the user whose preferences are to be reloaded
	 * @param channel the user's current channel
	 */
	public void do_getPrefs (final JSONObject jso,
			final AbstractUser u, final Channel channel) {
		try {
			final UserPreferenceRecord prefs = Nomenclator
					.getDataRecord (UserPreferenceRecord.class,
							u.getUserID ());
			u.acceptSuccessReply ("getPrefs", prefs.toJSON (),
					u.getRoom ());
		} catch (final NotFoundException e) {
			u.acceptErrorReply ("getPrefs", "err.notFound", null,
					u.getRoom ());
		}
		
	}
	
	/**
	 * Get a text string from the server's message catalogue
	 * 
	 * @param jso { for : KEY } or { for: KEY, default: FALLBACK-STRING
	 *             }
	 * @param u the user (whose language will be considered)
	 * @param channel the room in which the user is standing
	 *             (unimportant)
	 * @throws JSONException if the input or output won't JSON
	 *              encode/decode cleanly
	 */
	public void do_getText (final JSONObject jso,
			final AbstractUser u, final Channel channel)
			throws JSONException {
		String s;
		if (jso.has ("default")) {
			s = LibMisc.getTextOrDefault (jso.getString ("for"),
					u.getLanguage (), u.getDialect (),
					jso.getString ("default"));
		} else {
			s = LibMisc.getText (jso.getString ("for"),
					u.getLanguage (), u.getDialect ());
		}
		final JSONObject gotText = new JSONObject ();
		gotText.put ("for", jso.getString ("for"));
		gotText.put ("text", s);
		u.acceptSuccessReply ("getText", gotText, u.getRoom ());
	}
	
	/**
	 * <p>
	 * Set persistent user preferences on the server, to be maintained
	 * between sessions. Changes to preferences are reflected to the
	 * user at login, and any time they're changed.
	 * </p>
	 * <p>
	 * Preferences are stored in hierarchical form as string values.
	 * However, the full “dotted notation” of any preference key must
	 * not extend beyond 100 characters in length.
	 * </p>
	 * <p>
	 * At present, all preferences are echoed to all clients using an
	 * user account. There is no filter.
	 * </p>
	 * <p>
	 * Preference keys cannot be deleted; the closest equivalent is to
	 * set their values to "". Each savePrefs call will only
	 * <em>overwrite</em> prior calls with identical keys; keys not
	 * replaced will be left alone.
	 * </p>
	 * 
	 * @param jso The preference keys to be saved.
	 * @param u The user whose preferences are being saved
	 * @param channel The user's current channel
	 */
	public void do_savePrefs (final JSONObject jso,
			final AbstractUser u, final Channel channel) {
		try {
			Nomenclator.getDataRecord (UserPreferenceRecord.class,
					u.getUserID ()).save (jso);
		} catch (final NotFoundException e) {
			try {
				new UserPreferenceRecord (u).save (jso);
			} catch (final AlreadyExistsException e1) {
				Commands.log
						.error ("Caught a AlreadyExistsException in Commands.do_savePrefs ",
								e1);
			}
		}
	}
	
	/**
	 * Report some “required” information about the user-agent. The
	 * name of this call is a reference to the Unix “uname” command,
	 * which generally mean “Unix name,” but here we're pretending we
	 * meant “User agent name,” instead.
	 * 
	 * @param jso Contains the structure described above
	 * @param u The user calling this method
	 * @param channel The channel in which the user is located, if any
	 *             (ignored)
	 * @throws JSONException WRITEME
	 */
	@SuppressWarnings ("unchecked")
	public void do_uname (final JSONObject jso, final AbstractUser u,
			final Channel channel) throws JSONException {
		final UserAgentInfo ua = u.getServerThread ()
				.getUserAgentInfo ();
		ua.setAcceptsNotifications (jso.has ("feature.notifications")
				&& jso.getBoolean ("feature.notifications"));
		ua.setAppName (jso.getString ("appName"));
		ua.setCanClick (jso.getBoolean ("canClick"));
		ua.setHardware (jso.getString ("hardware"));
		ua.setHasDirections (jso.getBoolean ("hasDirections"));
		ua.setHasKeyboard (jso.getBoolean ("hasKeyboard"));
		ua.setHasModClick (jso.getBoolean ("hasModClick"));
		ua.setInfinityModeMinLevel (jso.getInt ("min"));
		ua.setInfinityModeMaxLevel (jso.getInt ("max"));
		ua.setKernelVersion (jso.getString ("kernel"));
		ua.setOS (jso.getString ("OS"));
		ua.setVersion (jso.getString ("appVersion"));
		ua.setWindowSize (new Coord2D (jso.getInt ("windowX"), jso
				.getInt ("windowY")));
		final Iterator <String> capsKeys = jso.getJSONObject ("caps")
				.keys ();
		while (capsKeys.hasNext ()) {
			final String key = capsKeys.next ();
			ua.setCap (key,
					jso.getJSONObject ("caps").getString (key));
		}
	}
	
}
