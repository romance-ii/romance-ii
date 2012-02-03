/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.sys.op;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.ref.WeakReference;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.SQLException;
import java.sql.Time;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Channel;
import org.starhope.appius.game.Commands;
import org.starhope.appius.game.GameEvent;
import org.starhope.appius.game.PhysicsScheduler;
import org.starhope.appius.game.PreLoginCommands;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.RunCommands;
import org.starhope.appius.game.Zone;
import org.starhope.appius.game.ZoneSpawner;
import org.starhope.appius.game.inventory.GenericItemReference;
import org.starhope.appius.game.inventory.Inventory;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.game.js.JavaScriptRunnerThread;
import org.starhope.appius.game.npc.Ejecta;
import org.starhope.appius.game.npc.plebeian.Plebeian;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.mb.Messages;
import org.starhope.appius.net.NetIOThread;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.sql.SQLPeerEnum;
import org.starhope.appius.sys.admin.Security;
import org.starhope.appius.sys.admin.SecurityCapability;
import org.starhope.appius.types.AgeBracket;
import org.starhope.appius.types.Colour;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.Parent;
import org.starhope.appius.user.User;
import org.starhope.appius.user.UserRecord;
import org.starhope.appius.user.UserTransients;
import org.starhope.appius.user.events.Action;
import org.starhope.appius.user.events.EventRecord;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.util.LibMisc;
import org.starhope.util.types.CommandExecutorThread;

import com.whirlycott.cache.CacheException;
/**
 * <p>
 * This class contains operator commands that act upon the game world.
 * These are usually accessed by typing a '#' plus the command name into
 * a public message.
 * </p>
 * <p>
 * The command name required is the (all-lower-case) method name without
 * the leading op_ prefix. For example, the method named op_mem is
 * actually typed as "#mem".
 * </p>
 *
 * @author brpocock@star-hope.org
 */
public class OpCommands {

	/**
	 * assert that a warning (kick, ban) reason code is valid
	 *
	 * @param warnReason the supplied warning reason code
	 * @param u the user providing the code (who may get an error
	 *            response)
	 * @return the reason code, if valid
	 * @throws NotFoundException if the code is not valid
	 */
	private static String assertValidWarnReason (
			final String warnReason, final AbstractUser u)
			throws NotFoundException {
		final String reason = warnReason.toLowerCase (Locale.ENGLISH);
		if (LibMisc.getText ("rule." + reason) == null) {
			u.acceptMessage ("Invalid Warning Reason Code", "Catullus",
					"“" + warnReason + "” is not a reason code");
			throw new NotFoundException (warnReason);
		}
		return reason;
	}
	
	/**
	 * Execute a staff command found with a leading # on it.
	 * 
	 * @param channel the room in which the operator command should be
	 *            executed
	 * @param u the user executing said command
	 * @param commandString the command to be executed, beginning with
	 *            '#'
	 */
	public static void exec (final Channel channel,
			final AbstractUser u,
			final String commandString) {
		if ( !Security.hasCapability (u,
				SecurityCapability.CAP_SYSOP_COMMANDS)) {
			// fall back to old security model for now.
			try {
				u.assertStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER);
			} catch (final PrivilegeRequiredException e) {
				u.sendOops ();
				return;
			}
		}

		final String [] words = commandString.split (" ");

		// REFLEXION

		words [0] = words [0].toLowerCase (Locale.ENGLISH);

		Method opCommandHandler = null;
		final String cmd = words [0].substring (1);
		try {
			opCommandHandler = OpCommands.class.getMethod ("op_" + cmd,
					String [].class, AbstractUser.class, Channel.class);
		} catch (final SecurityException e) {
			final NetIOThread thread = u.getServerThread ();
			if (null != thread) {
				thread.sendError_RAW (cmd, e.toString ());
			}
			AppiusClaudiusCaecus.reportBug (e);
			return;
		} catch (final NoSuchMethodException e) {
			try {
				opCommandHandler = LibMisc.loadExtension (
						OpCommands.class)
						.getMethod ("op_" + cmd, String [].class,
 AbstractUser.class,
						Channel.class);
			} catch (final SecurityException e1) {
				final NetIOThread thread = u.getServerThread ();
				if (null != thread) {
					thread.sendError_RAW (cmd, e1.toString ());
				}
				AppiusClaudiusCaecus.reportBug (
						"Caught a SecurityException in exec", e1);
				return;
			} catch (final NoSuchMethodException e1) {
				final NetIOThread thread = u.getServerThread ();
				if (null != thread) {
					thread
							.sendError_RAW ("*", "No such method: "
									+ cmd);
				}
				return;
			} catch (final ArrayIndexOutOfBoundsException e2) {
				// In case invalid syntax is given
				final NetIOThread thread = u.getServerThread ();
				if (null != thread) {
					thread.sendError_RAW ("*",
							"Invalid syntax!  Please check the syntax on "
									+ cmd);
				}
				return;
			}
		}
		try {
			final String [] subcommand;
			if (words.length > 1) {
				subcommand = Arrays
						.copyOfRange (words, 1, words.length);
			} else {
				subcommand = new String [0];
			}
			AppiusClaudiusCaecus.blather (u.getAvatarLabel (),
					u.getRoom ().getName (), u.getIPAddress (),
					"Invoking operator command " + cmd, false);
			opCommandHandler.invoke (null, subcommand, u, channel);
			return;
		} catch (final IllegalArgumentException e) {
			AppiusClaudiusCaecus.reportBug (e);
			final NetIOThread thread = u.getServerThread ();
			if (null != thread) {
				thread.sendError_RAW (cmd, e.toString ());
			}
			u.sendOops ();
			return;
		} catch (final IllegalAccessException e) {
			AppiusClaudiusCaecus.reportBug (e);
			final NetIOThread thread = u.getServerThread ();
			if (null != thread) {
				thread.sendError_RAW (cmd, e.toString ());
			}
			u.sendOops ();
			return;
		} catch (final InvocationTargetException e) {
			AppiusClaudiusCaecus.reportBug (
					"Exception while handling xtn command " + cmd, e
							.getCause ());
			OpCommands.sendUserErrorMessage (u, cmd, e.getCause ());
			final NetIOThread thread = u.getServerThread ();
			if (null != thread) {
				thread.sendError_RAW (cmd, e.getCause ().toString ());
			}
			u.sendOops ();
			return;
		} catch (final Exception e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Generic (unhandled) exception inside request handler",
							e);
			u.acceptMessage ("$$@", "Java", e.getMessage ());
			u.sendOops ();
			return;
		}
	}

	/**
	 * get “finger” information about any user
	 *
	 * @param u who's asking
	 * @param pasivo who's being fingered
	 * @return a string describing some operator-useful info about that
	 *         user
	 */
	public static String fingerInfo (final AbstractUser u,
			final AbstractUser pasivo) {
		final StringBuilder finger = new StringBuilder ("User name ");
		finger.append (pasivo.getAvatarLabel ());
		finger.append ("\n#");
		finger.append (pasivo.getUserID ());
		finger.append ('\t');
		finger.append (pasivo.getDebugName ());

		finger.append ("\navatar ");
		finger.append (pasivo.getAvatarClass ().getFilename ());

		finger.append ('\n');
		finger.append (pasivo.getLocation ().toString ());

		finger.append ("\nonline ");
		final boolean online = pasivo.isOnline ();
		finger.append (online);
		if (online) {
			finger.append ("\nlag = ");
			finger.append (pasivo.getLag ());
			finger.append ("ms");
		}
		finger.append ('\n');
		finger.append (pasivo.isPaidMember () ? "Paid" : "Free");
		if (u.getStaffLevel () >= User.STAFF_LEVEL_ACCOUNT_SERVICE) {
			finger.append ("\nResp. mail:\t");
			finger.append (pasivo.getResponsibleMail ());
		}

		// if (pasivo instanceof Toot) {
		// finger.append ("\nPeanuts\t");
		// finger.append ( ((Toot) pasivo).getPeanuts ()
		// .toPlainString ());
		// }
		switch (pasivo.getStaffLevel ()) {
		case User.STAFF_LEVEL_PUBLIC:
			// No op.
			break;
		case User.STAFF_LEVEL_ACCOUNT_SERVICE:
			finger.append ("\n\tAccount Service");
			break;
		case User.STAFF_LEVEL_DESIGNER:
			finger.append ("\n\tDesigner");
			break;
		case User.STAFF_LEVEL_DEVELOPER:
			finger.append ("\n\tDeveloper");
			break;
		case User.STAFF_LEVEL_MODERATOR:
			finger.append ("\n\tModerator");
			break;
		case User.STAFF_LEVEL_STAFF_MEMBER:
			finger.append ("\n\tStaff Member");
			break;
		default:
			finger.append ("\n\tSTAFF_LEVEL_");
			finger.append (pasivo.getStaffLevel ());
			break;
		}
		finger.append ("\nage ");
		finger.append (pasivo.getAge ());
		finger.append ("\navatar ");
		finger.append (pasivo.getAvatarClass ().getFilename ());
		if (online) {
			finger.append ("\nIP addx ");
			finger.append (pasivo.getIPAddress ());
		}
		if (pasivo.isKicked () || pasivo.isBanned ()) {
			finger.append ('\n');
			finger.append (pasivo.getKickedMessage ());
			finger.append ("\n\tby ");
			finger.append (Nomenclator.getLoginForID (pasivo
					.getKickedByUserID ()));
			finger.append ("\tuntil ");
			finger.append (pasivo.getKickedUntil ());
		}
		finger.append ("\ntalk?\t");
		finger.append (pasivo.canTalk () ? "Talk" : "Mute");
		finger.append ('\n');
		finger.append (pasivo.getRegisteredDateString ());
		finger.append ('\n');
		finger.append (pasivo.getApprovedDateString ());
		return finger.toString ();
	}

	/**
	 * <p>
	 * Convert the user-provided configuration key string into a real
	 * key string found in the configuration Properties. The only
	 * purpose of this right now is to provide for the ~a shorthand for
	 * org.starhope.appius. Thus, for example, the user can type
	 * <tt>#setvar ~a.debug true</tt> and this will translate into
	 * <tt>#setvar org.starhope.appius.debug true</tt> instead.
	 * </p>
	 * <p>
	 * This also now has ~t for com.tootsville and ~e for
	 * com.empiresoftheair for shorthand.
	 * </p>
	 *
	 * @param string a configuration key string
	 * @return the real configuration key string
	 */
	private static String getConfKey (final String string) {
		if (2 < string.length ()) {
			if ('~' == string.charAt (0)) {
				switch (string.charAt (1)) {
				case 'a':
					return "org.starhope.appius" + string.substring (2);
				case 't':
					return "com.tootsville" + string.substring (2);
				case 'e':
					return "com.empiresoftheair" + string.substring (2);
				}
			}
		}
		return string;
	}

	/**
	 * Get a diamond surrounding a pixel in the polygon format for
	 * setting up place zones in the client
	 *
	 * @param x the centre point's x ordinate
	 * @param y the centre point's y ordinate
	 * @param delta the radius of the diamond from the centre
	 * @return the polygon string
	 */
	private static String getDiamond (final int x, final int y,
			final int delta) {
		return String.valueOf ( (x - delta)) + ',' + y + '~' + x + ','
				+ (y - delta) + '~' + (x + delta) + ',' + y + '~' + x
				+ ',' + (y + delta);
	}

	/**
	 * Find a character-specific operator command for a specific user.
	 *
	 * @param u the user in question
	 * @param command the command or macro name
	 * @return a method implementing that command
	 */
	public static Method getHook (final AbstractUser u,
			final String command) {
		String userClassName = null;
		try {
			userClassName = AppiusConfig.getConfig ("xtn.sys.op."
					+ u.getAvatarLabel ());
		} catch (final NotFoundException e) {
			return null;
		}
		Class <?> klass = null;
		try {
			klass = Class.forName (userClassName);
		} catch (final ClassNotFoundException e) {
			return null;
		}
		try {
			return klass.getMethod ("op_" + u.getAvatarLabel () + "$"
					+ command, AbstractUser.class, String [].class);
		} catch (final SecurityException e) {
			return null;
		} catch (final NoSuchMethodException e) {
			return null;
		}
	}
	
	/**
	 * Give an item to everyone in a given room. Invoked via
	 * {@link #givehead_toRoom(AbstractUser, Room, String, int)} using @
	 * ROOM-MONIKER notation.
	 * 
	 * @param u WRITEME
	 * @param channel WRITEME
	 * @param taker WRITEME
	 * @param itemNumberInt WRITEME
	 */
	private static void givehead_toRoom (final AbstractUser u,
			final Channel channel, final String taker,
			final int itemNumberInt) {
		Room r;
		try {
			r = u.getZone ().getRoom (taker.substring (1));
		} catch (NotFoundException e) {
			u.acceptMessage ("#givehead", "Catullus",
					"Room not found: " + taker.substring (2));
			return;
		}
		int gave = 0;
		for (final AbstractUser pasivo : r.getAllUsers ()) {
			EventRecord ev;
			try {
				ev = Quaestor.startEvent (pasivo, "free");
			} catch (AlreadyExistsException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a AlreadyExistsException in OpCommands.givehead_toRoom ",
								e);
				continue;
			} catch (NotFoundException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a NotFoundException in OpCommands.givehead_toRoom ",
								e);
				continue;
			}
			ev.setItemEarned (itemNumberInt);
			ev.end (BigInteger.ZERO);
			// final Inventory pasivoInventory = pasivo.getInventory ();
			// InventoryItem item = pasivoInventory
			// .add (itemNumberInt);
			// pasivo.sendEarnings (pasivo.getRoom (), item);
			++gave;
		}
		u.acceptMessage ("Gifts Given", "Catullus", String.format (
				"Gave item #%d to %d users", Integer
						.valueOf (itemNumberInt), Integer
						.valueOf (gave)));
		return;
	}
	
	/**
	 * Perform the #headcount #all subcommand, givng a headcount of
	 * users in all zones.
	 * 
	 * @param u The user requesting this headcount
	 * @param channel The channel in which that user is in.
	 * @throws JSONException if the JSON data can't be encoded or
	 *             decoded
	 * @throws NumberFormatException if some data can't be interpreted
	 */
	@SuppressWarnings ("unchecked")
	private static void headcount_all (final AbstractUser u,
			final Channel channel) throws JSONException,
			NumberFormatException {
		final JSONObject zoneList = u.getZone ()
				.getZoneList_JSON (u);
		final StringBuilder headcount = new StringBuilder (
				"\tHeadcount\n");
		final Iterator <String> numbers = zoneList.keys (); // unchecked
		int sum = 0;
		while (numbers.hasNext ()) {
			final JSONObject zone = (JSONObject) zoneList.get (numbers
					.next ());
			final String usersOn = zone.getString ("usersOn");
			headcount.append (zone.getString ("name"));
			headcount.append ("\t#");
			headcount.append (usersOn);
			headcount.append ('\n');
			sum += Integer.parseInt (usersOn);
		}
		headcount.append ("\nSum:\t#");
		headcount.append (sum);
		u.acceptMessage ("Headcount", "Census", headcount.toString ());
	}
	
	/**
	 * perform the #headcount #highwater subcommand, providing the
	 * high-water mark of logins for the server since boot
	 * 
	 * @param u the user requesting the headcount
	 * @param channel the room in which that user is standing
	 */
	private static void headcount_highwater (final AbstractUser u,
			final Channel channel) {
		final StringBuilder headcount = new StringBuilder (
				"Server's High Water Mark:\t#");
		headcount.append (AppiusClaudiusCaecus.getHighWaterUsers ());
		u.acceptMessage ("Headcount", "Census", headcount.toString ());
	}
	
	/**
	 * Get a headcount of the number of users online in a given zone,
	 * broken down into free, paid, and staff users. From among the
	 * non-staff members, give a total of public users, and the ratio of
	 * paid vs. free members.
	 * 
	 * @param u The user requesting this headcount
	 * @param channel The room in which that user is standing.
	 */
	private static void headcount_members (final AbstractUser u,
			final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		int free = 0;
		int staff = 0;
		int paid = 0;
		int total = 0;
		for (final Integer theirID : u.getZone ()
				.getAllUsersIDsInZone ()) {
			final AbstractUser them = Nomenclator.getUserByID (theirID
					.intValue ());
			if (them.getStaffLevel () > User.STAFF_LEVEL_PUBLIC) {
				++staff;
			} else if (them.isPaidMember ()) {
				++paid;
			} else {
				++free;
			}
			++total;
		}
		u.acceptMessage ("Headcount of Members", "Census", "Free:\t"
				+ free + "\nPaid:\t" + paid + "\nStaff:\t" + staff
				+ "\nTotal Public:\t" + (free + paid)
				+ "\nPaid Ratio:\t"
				+ (int) ((double) paid / (free + paid) * 1000) / 10
				+ "%\nTotal:\t" + total);
		return;
	}
	
	/**
	 * broken-out handler for <tt>#headcount #rooms</tt>; see
	 * {@link #op_headcount(String[], AbstractUser, Room)} Get a
	 * headcount of the number of users online in a given zone, broken
	 * down into by room population.
	 * 
	 * @param u The user requesting this headcount
	 * @param channel The room in which that user is standing.
	 * @throws JSONException WRITEME
	 */
	@SuppressWarnings ("unchecked")
	private static void headcount_rooms (final AbstractUser u,
			final Channel channel) throws JSONException {
		final JSONObject zoneList = u.getZone ()
				.getZoneList_JSON (u);
		final StringBuilder headcount = new StringBuilder (
				" Headcount\n\n");
		final Iterator <String> numbers = zoneList.keys (); // unchecked
		int grandTotal = 0;
		while (numbers.hasNext ()) {
			final JSONObject zoneJSON = (JSONObject) zoneList
					.get (numbers.next ());
			headcount.append ("\n> ");
			headcount.append (zoneJSON.getString ("name"));
			headcount.append (" \t#");
			headcount.append (zoneJSON.getString ("usersOn"));
			headcount.append ("\n");
			final HashMap <String, Integer> rooms = new HashMap <String, Integer> ();
			for (final AbstractUser userInZone : AppiusClaudiusCaecus
					.getZone (zoneJSON.getString ("name"))
					.getAllUsersInZone ()) {
				final Room userRoomObj = userInZone.getRoom ();
				final String userCurrentRoom = null == userRoomObj ? "(lost)"
						: userRoomObj.getName ();
				Integer knew = rooms.get (userCurrentRoom);
				if (null == knew) {
					knew = Integer.valueOf (0);
				}
				rooms.put (userCurrentRoom, Integer.valueOf (1 + knew
						.intValue ()));
				++grandTotal;
			}
			for (final Entry <String, Integer> r : rooms.entrySet ()) {
				headcount.append ("  ");
				headcount.append (r.getKey ());
				headcount.append (" #");
				headcount.append (r.getValue ());
			}
		}
		headcount.append ("\n\nTotal #");
		headcount.append (grandTotal);
		headcount.append ("\n\n");
		u.acceptMessage ("Headcount for all Rooms", "Census", headcount
				.toString ());
	}
	
	/**
	 * call the operator script hook for a particular character
	 * 
	 * @param channel the room in which the user is standing
	 * @param u the user's name
	 * @param speech the command sequence
	 */
	public static void hook (final Channel channel,
			final AbstractUser u,
			final String speech) {
		final String command = speech.substring (1, speech
				.indexOf (' ') - 1);
		final Method m = OpCommands.getHook (u, command);
		if (null == m) {
			u.acceptMessage ("$?", "Catullus",
					"$command not found for " + u.getAvatarLabel ()
							+ "$" + command);
			return;
		}
		try {
			final String [] words = speech.substring (
					speech.indexOf (' ') + 1).split (" ");
			m.invoke (null, u, channel, words);
		} catch (final Throwable e) {
			u.acceptMessage ("$@ $" + command, "Catullus", LibMisc
					.stringify (e));
		}
	}
	
	/**
	 * <p>
	 * Execute a command script
	 * </p>
	 * <p>
	 * Usage:
	 * </p>
	 * <tt> #$ SCRIPT </tt>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is standing (as a room
	 *            number). This can be -1 under certain circumstances.
	 * @throws IOException if the script can't be loaded
	 */
	public static void op_$ (final String [] words,
			final AbstractUser u, final Channel channel) throws IOException {
		if ( !Security.hasCapability (u,
				SecurityCapability.CAP_RUN_JAVASCRIPT)) {
			u
					.acceptMessage (
							"JavaScript Security",
							"Rhino",
							"You do not have permission to run JavaScript on the server (CAP_RUN_JAVASCRIPT)");
		}
		for (final String script : words) {
			new JavaScriptRunnerThread (script, u).start ();
		}
	}
	
	/**
	 * Add a GameEvent to a Zone
	 * <p>
	 * Add a GameEvent to a Zone. Must have staff level 4 (DESIGNER) to
	 * use this command.
	 * </p>
	 * <p>
	 * Syntax for use: <code>#addevent [EVENTNAME]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#addevent LaserTagGame</code><br/>
	 * <code>#addevent PropsWeather</code><br/>
	 * <code>#addevent ShaddowFalls</code><br/>
	 * <code>#addevent Tootlympics</code>
	 * <p>
	 * 
	 * @see OpCommands#op_clearevent(String[], AbstractUser, Room)
	 * @see OpCommands#op_getevents(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is standing (as a room
	 *            number). This can be -1 under certain circumstances.
	 */
	public static void op_addevent (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		u.getZone ().addGameEventByClass (words [0]);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 */
	public static void op_agent (final String [] words,
			final AbstractUser u, final Channel channel) {
		u.acceptMessage ("#agent", "Catullus", "Agent "
				+ LibMisc.listToDisplay (words, "en", "US"));
		final AbstractUser bot = Nomenclator.getUserByLogin (words [0]);
		if (null == bot) {
			u.acceptMessage ("Nobody there", "Catullus",
					"Nobody named " + words [0]);
			return;
		}
		if ( !bot.isNPC ()) {
			u.acceptMessage ("Not a bot", "Catullus", bot
					.getAvatarLabel ()
					+ " is not a bot");
			return;
		}
		final Inventory botInventory = bot.getInventory ();
		for (final InventoryItem i : botInventory.getActiveClothing ()) {
			botInventory.doff (i);
		}
		for (final InventoryItem i : u.getInventory ()
				.getActiveClothing ()) {
			final InventoryItem newItem = botInventory
					.addDefaultFreeItem (i.getGenericItem ()
							.getItemID (), true);
			final List <Colour> itemColours = i.getColours ();
			if (itemColours.size () > 0) {
				newItem.setColour (itemColours);
			}
		}
		bot.setBaseColor (u.getBaseColor ());
		bot.setExtraColor (u.getExtraColor ());
		bot.sendWardrobe ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org test prompt
	 * command
	 * 
	 * @param words WRITEME
	 * @param user WRITEME
	 * @param channel WRITEME
	 * @throws JSONException WRITEME
	 */
	public static void op_askme (final String [] words,
			final AbstractUser user, final Channel channel)
			throws JSONException {
		JSONObject prompt = new JSONObject ();
		prompt.put ("title", "Title Here");
		prompt.put ("label", "example");
		prompt.put ("label_en_US", "example");
		prompt.put ("attachUser", user.getAvatarLabel ());
		prompt.put ("id", "example/2134§þ=?/x'<>'\",:/blah");
		prompt
				.put (
						"msg",
						"Because it's really important to me that you are able to hear this question and give me an informed answer, I want to know: “Can you hear me now?”");
		JSONObject replySet = new JSONObject ();
		JSONObject replyYes = new JSONObject ();
		replyYes.put ("label", "Yes");
		replyYes.put ("type", "aff");
		replyYes.put ("label_en_US", "YES");
		replySet.put ("sí", replyYes);
		JSONObject replyNo = new JSONObject ();
		replyNo.put ("label", "No");
		replyNo.put ("type", "neg");
		replyNo.put ("label_en_US", "NO");
		replySet.put ("no", replyNo);
		JSONObject replyMebbe = new JSONObject ();
		replyMebbe
				.put (
						"label",
						"Maybe. I'm not really sure. This one is mostly just in here to be a really long answer.");
		replyMebbe.put ("type", "neu");
		replyMebbe.put ("label_en_US", "MEBBE");
		replySet.put ("maybe", replyMebbe);
		prompt.put ("replies", replySet);

		user.acceptSuccessReply ("prompt", prompt, user.getRoom ());
	}
	
	/**
	 * <p>
	 * Ban a user permanently. Must have staff level 2 (MODERATOR) to
	 * use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#ban [REASONCODE] [LOGIN]</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#ban obs.rude pil</code>
	 * </p>
	 * 
	 * @see #op_kick(String[], AbstractUser, Room)
	 * @see #op_warn(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 * @throws NotFoundException if the reason code given is invalid
	 * @throws PrivilegeRequiredException if the user lacks privileges
	 */
	public static void op_ban (final String [] words,
			final AbstractUser u, final Channel channel)
			throws NotFoundException, PrivilegeRequiredException {
		final String banReason = OpCommands.assertValidWarnReason (
				words [0], u);
		final String bratLogin = words [1];
		final AbstractUser brat = Nomenclator
				.getUserByLogin (bratLogin);
		u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);

		if (null == brat) {
			u.acceptMessage ("#ban", "Catullus", "Can't find user: “"
					+ bratLogin + "”");
			return;
		}
		if ( !u.hasStaffLevel (brat.getStaffLevel () + 1)) {
			u.acceptMessage ("#ban", "Catullus", "You can not ban: “"
					+ bratLogin + "” because they are a staff member.");
			return;
		}

		brat.ban (u, banReason);
		u.acceptMessage ("#ban", "Catullus", "Banned user "
				+ brat.getAvatarLabel () + ": "
				+ brat.getKickedMessage ());

		return;
	}
	
	/**
	 * <p>
	 * Ban an IP address from connecting.
	 * </p>
	 * <p>
	 * Bans can be listed using #banhammer #list
	 * </p>
	 * <p>
	 * Bans can be lifted using #banhammer #-ip IP-ADDRESS (or hostname)
	 * </p>
	 * <p>
	 * A ban can be placed with #banhammer #+ip IP-ADDRESS or #banhammer
	 * #+ip HOSTNAME or #banhammer #user USERNAME. In the latter case,
	 * the user's connected IP address is used. This is expected to be
	 * the most common usage.
	 * </p>
	 * 
	 * @param words the first word is a subcommand; one of #+ip, #-ip,
	 *            #user, or #list. For #+ip, #-ip, or #user, an
	 *            additional parameter is needed.
	 * @param u the user issuing the ban
	 * @param channel the channel in which the operator is found
	 * @throws UnknownHostException if the IP address or hostname
	 *             specified can't be identified
	 */
	public static void op_banhammer (final String [] words,
			final AbstractUser u, final Channel channel)
			throws UnknownHostException {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_ACCOUNT_SERVICE);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		InetAddress address = null;
		final String targetType = words [0];

		if ("#list".equals (targetType)) {
			final StringBuilder list = new StringBuilder ();
			for (final String addx : AppiusClaudiusCaecus
					.getQuenchedAddresses ()) {
				list.append (addx);
				list.append ('\n');
			}
			u.acceptMessage ("#banhammer #list", "DJBlakkat", list
					.toString ());
		}

		final String target = words [1];

		if ("#-ip".equals (targetType)) {
			address = InetAddress.getByName (target);
			AppiusClaudiusCaecus.unquench (address);
			return;
		} else if ("#+ip".equals (targetType)) {
			address = InetAddress.getByName (target);
		} else if ("#user".equals (targetType)) {
			final AbstractUser brat = Nomenclator
					.getUserByLogin (target);
			if (null == brat) {
				u.acceptMessage ("#banhammer", "DJBlakkat",
						"Can't find user: “" + target + "”");
				return;
			}
			address = InetAddress.getByName (brat.getIPAddress ());
		} else {
			u
					.acceptMessage ("#banhammer", "DJBlakkat",
							"Usage: #banhammer #[+ip|-ip|user|list] {identifier}");
		}

		AppiusClaudiusCaecus.quenchConnectionsFrom (address);
		return;
	}
	
	/**
	 * <p>
	 * Beam yourself to a different room.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#beam [ROOM]</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#beam tootSquare</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is standing (as a room
	 *            number). This can be -1 under certain circumstances.
	 * @throws JSONException if the data can't be formatted for some
	 *             reason
	 * @throws PrivilegeRequiredException if so
	 */
	public static void op_beam (final String [] words,
			final AbstractUser u, final Channel channel)
			throws JSONException, PrivilegeRequiredException {
		String [] clone = new String [words.length + 1];
		int i = 1;
		clone [0] = u.getAvatarLabel ();
		for (String word : words) {
			clone [i++ ] = word;
		}
		OpCommands.op_scotty (clone, u, channel);
	}
	
	/**
	 * <p>
	 * Create a new room in the current zone. Must have staff level 8
	 * (DEVELOPER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#spawnroom [MONIKER] [TITLE] [SWF]</code><br/>
	 * <code>#spawnroom [MONIKER] [TITLE]</code>
	 * </p>
	 * <p>
	 * <i>NOTE: Uses tootCastleJoust.swf as default. This can be set
	 * after the room has been created by setting the 'f' room
	 * variable.</i>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#spawnroom tootCastleJoust2 Joust2 tootCastleJoust.swf</code>
	 * <br/>
	 * <code>#spawnroom tootCastleJoust2 Joust2</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_build (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		if (0 == words.length) {
			u.sendOops ();
			return;
		}

		final Room newRoom = Room.createPublicRoom (words [0],
				u
				.getZone ());
		newRoom.setTitle (words.length > 1 ? words [1] : words [0]);
		u.getZone ().add (newRoom);

		newRoom.setVariable ("f", "");
		newRoom.setVariable ("s", "");
		newRoom.setVariable ("m", "");
		newRoom.setVariable ("w", "");
	}
	
	/**
	 * Simply reference a range of users, for testing purposes. Takes an
	 * optional low and high point, or runs 0…250000. (250,000) This
	 * will assert free or paid member status, restore default free
	 * items, and seriously strain the caché and database subsystems.
	 * 
	 * @param words optional low and high points of the range to be
	 *            referenced.
	 * @param u God
	 * @param channel God's channel
	 * @throws PrivilegeRequiredException if someone other than God
	 *             tries to call this routine
	 */
	public static void op_census (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException {
		int low = 0;
		int high = 250000;
		if (words.length > 0) {
			low = Integer.parseInt (words [0]);
		}
		if (words.length > 1) {
			high = Integer.parseInt (words [1]);
		}
		u.assertStaffLevel (9);
		for (int i = high; i > low; i-- ) {
			final AbstractUser someone = Nomenclator.getUserByID (i);
			if (i % 10000 == 0) {
				u.acceptMessage ("Census", "Census",
						"Census has reached " + i / 1000 + " thousand");
			}
			if (null != someone) {
				someone.acceptMessage ("Welcome", "Welcome", "Welcome");
			}
		}
	}
	
	/**
	 * <p>
	 * Clear badges off of the map interface. Must have staff level 4
	 * (DESIGNER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#clearbadge [LOGIN] [ROOM]</code>.
	 * </p>
	 * <strong>Login</strong>
	 * <ul>
	 * <li>username of a character</li>
	 * <li>#me for the character you are logged in as</li>
	 * </ul>
	 * <strong>Room</strong>
	 * <ul>
	 * <li>room moniker of a room</li>
	 * <li>#here for the room you are currently in</li>
	 * <li>#all for every room</li>
	 * </ul>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#clearbadge snowcone tootSquare</code> <br/>
	 * <code>#clearbadge snowcone #all</code> <br/>
	 * <code>#clearbadge snowcone #here</code> <br/>
	 * <code>#clearbadge #me #all</code> <br/>
	 * <code>#clearbadge #me #here</code> <br/>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_clearbadge (final String [] words,
			final AbstractUser u, final Channel channel) {
		String badgeName = words [0];
		if (words.length == 0 || "#me".equals (badgeName)) {
			badgeName = u.getAvatarLabel ();
		}
		if ( !u.getAvatarLabel ().equals (badgeName)) {
			try {
				u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
			} catch (final PrivilegeRequiredException e) {
				u.sendOops ();
				return;
			}
		}
		try {
			final String badgeRoom = words [1];
			if (words.length < 2 || "#here".equals (badgeRoom)) {
				if ("#all".equals (badgeName)) {
					u.getZone ().clearAllBadges ();
				} else {
					u.getZone ().clearBadge (badgeName);
				}
			} else if ("#all".equals (badgeName)) {
				try {
					u.getZone ().clearAllBadges (
							u.getZone ().getRoom (badgeRoom));
				} catch (NotFoundException e) {
					AppiusClaudiusCaecus
							.reportBug (
									"Caught a NotFoundException in OpCommands.op_clearbadge ",
									e);
				}
			} else {
				u.getZone ().clearBadge (badgeName);
			}
		} catch (final GameLogicException e) {
			u.acceptMessage ("Badge", "Catullus", "Badge " + badgeName
					+ " not set on room");
		}
	}
	
	/**
	 * Forcibly clear all cachés
	 * 
	 * @param words none
	 * @param u operator
	 * @param channel channel operator is in
	 * @throws CacheException if the caché subsystem throws an exception
	 * @throws PrivilegeRequiredException if (u) is not a developer
	 */
	public static void op_clearcache (final String [] words,
			final AbstractUser u, final Channel channel)
			throws CacheException,
			PrivilegeRequiredException {
		u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		Nomenclator.clearCaches ();
	}
	
	/**
	 * <p>
	 * Clear a GameEvent from a Zone. Must have staff level 4 (DESIGNER)
	 * to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#clearevent [EVENTNAME]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#clearevent LaserTagGame</code><br/>
	 * <code>#clearevent PropsWeather</code><br/>
	 * <code>#clearevent ShaddowFalls</code><br/>
	 * <code>#clearevent Tootlympics</code>
	 * <p>
	 * 
	 * @see OpCommands#op_addevent(String[], AbstractUser, Room)
	 * @see OpCommands#op_getevents(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_clearevent (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final Zone z = u.getZone ();
		for (final GameEvent ev : z.getGameEvents ()) {
			if (ev.getClass ().getCanonicalName ().equals (words [0])) {
				z.remove (ev);
			}
		}
	}
	
	/**
	 * Clears a room variable
	 * 
	 * @param words
	 * @param u
	 * @param channel
	 */
	public static void op_clearvar (final String [] words,
			final AbstractUser u, final Channel channel) {
		OpCommands.op_clearvar (words, u, u.getRoom ());
	}
	
	/**
	 * <p>
	 * Clear a room variable. Must have staff level 4 (DESIGNER) to use
	 * this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#clearvar @[ROOM] [VARIABLE] [VALUE]</code><br/>
	 * <code>#clearvar [VARIABLE] [VALUE]</code>
	 * <p>
	 * <p>
	 * See {@link #op_setvar(String[], AbstractUser, Room)} to set a
	 * variable.
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#clearvar @tootsSquareWest anim~ropes 2</code><br/>
	 * <code>#clearvar anim~ropes 2</code>
	 * <p>
	 * 
	 * @see OpCommands#op_setvar(String[], AbstractUser, Room)
	 * @see OpCommands#op_getvar(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	private static void op_clearvar (final String [] words,
			final AbstractUser u, final Room room) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		if (words [0].startsWith ("@")) {
			Room thatRoom;
			try {
				thatRoom = u.getZone ().getRoom (
						words [0].substring (1));
				final String [] subWords = Arrays.copyOfRange (words,
						1, words.length);
				OpCommands.op_setvar (subWords, u, thatRoom);
				return;
			} catch (NotFoundException e) {
				u.acceptMessage ("#clearvar", "Catullus",
						"Can't find room " + words [0]);
			}
		}
		if (words.length < 1) {
			return;
		}
		final String varName = words [0];
		room.setVariable (varName, "");
	}

	/**
	 * clone a room
	 * 
	 * @param words moniker of the new room
	 * @param u user cloning the room
	 * @param channel
	 * @throws PrivilegeRequiredException if the user doesn't have
	 *             Designer level privileges, at least
	 */
	public static void op_cloneroom (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException {
		u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		final Room clone = Room.createPublicRoom (words [0], u
				.getZone ());
		clone.setVariables (u.getRoom ().getVariables ());
	}
	
	/**
	 * WRITEME: Document this metho WRITEMEd brpocock@star-hope.org
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 * @throws NotReadyException WRITEME
	 */
	public static void op_createroom (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException, NotReadyException {
		u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		Room r = Nomenclator.make (Room.class);
		r.setMoniker (words [0]);
	}
	
	/**
	 * <p>
	 * Get DBCP information. Must have staff level 8 (DEVELOPER) to use
	 * this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#dbcpinfo</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#dbcpinfo</code>
	 * <p>
	 * 
	 * @param words ignored
	 * @param u user requesting the info
	 * @param channel the room in which the user is in
	 * @throws PrivilegeRequiredException WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws SQLException WRITEME
	 */
	public static void op_dbcpinfo (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException, NotFoundException,
			SQLException {
		u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		u.acceptMessage ("DBCP", "DBCP", AppiusConfig.getDBCPInfo ());
	}
	
	/**
	 * <p>
	 * Force a character to wear a specific clothing item. Must have
	 * staff level 4 (DESIGNER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#dress [LOGIN] [ITEM] [optional: COLOUR]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#dress flappyperry 1337</code>
	 * <p>
	 * 
	 * @param words login name, item ID, and optional colour string (see
	 *            {@link Colour#Colour(String)})
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is in
	 * @throws DataException if the colour is bad
	 * @throws NumberFormatException if the colour is bad
	 */
	public static void op_dress (final String [] words,
			final AbstractUser u, final Channel channel)
			throws NumberFormatException, DataException {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final GeneralUser user = (GeneralUser) Nomenclator
				.getUserByLogin (words [0]);
		if (null == user) {
			u.acceptMessage ("#dress", "Catullus",
					"Can't find a user named “" + words [0] + "”");
			return;
		}
		if (words.length < 2) {
			u.acceptMessage ("#dress", "Catullus",
							"Usage: #dress WHO WHAT (COLOUR)\nor: #dress WHO -WHAT (negative item ID to undress)");
			return;
		}
		final int itemID = Integer.parseInt (words [1]);
		final Inventory inventory = user.getInventory ();
		if (itemID < 0) {
			InventoryItem item = inventory.findItem ( -itemID);
			inventory.doff (item);
			user.sendWardrobe ();
			return;
		}
		InventoryItem item = inventory.findItem (itemID);
		if (null == item) {
			item = inventory.addDefaultFreeItem (itemID,
					true);
		}
		final Colour colour = words.length > 2 ? new Colour (words [2])
				: null;
		inventory.don (item, colour);
		user.sendWardrobe ();
	}
	
	/**
	 * find an item in your inventory based upon the item ID # and
	 * destroy (drop) it
	 * 
	 * @param words the item# to be destroyed
	 * @param u the user dropping the item
	 * @param channel the room in which the user is in
	 */
	public static void op_drop (final String [] words,
			final AbstractUser u, final Channel channel) {
		AbstractUser user = u;
		if (words.length > 1) {
			user = Nomenclator.getUserByLogin (words [1]);
		}
		while (true) {
			final InventoryItem item = user.getInventory ().findItem (
					Integer.parseInt (words [0]));
			if (null == item) {
				break;
			}
			user.getInventory ().remove (item);
			item.destroy ();
		}
		user.sendWardrobe ();
		u.acceptMessage ("#drop", "Catullus",
				"Dropped (destroyed) item# " + words [0]);
	}
	
	/**
	 * <p>
	 * Silently remove the named user from the game by disconnection.
	 * Must have staff level 4 (DESIGNER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#dropkick [LOGIN]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#dropkick flappyperry</code>
	 * <p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is in
	 */
	public static void op_dropkick (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e1) {
			u.sendOops ();
			return;
		}
		final String bratLogin = words [0];
		final AbstractUser brat = Nomenclator
				.getUserByLogin (bratLogin);
		if (null == brat) {
			u.acceptMessage ("#dropkick", "Catullus",
					"Can't find user: “" + bratLogin + "”");
			return;
		}
		for (int i = 0; i < 3; ++i) {
			final ServerThread thread = brat.getServerThread ();
			AppiusClaudiusCaecus.blather ("dropkick");
			if (null == thread) {
				u.acceptMessage ("dropkick", "Catullus", brat
						.getAvatarLabel ()
						+ " in " + i + " tries");
				return;
			}
			thread.close ();
			try {
				brat.sendOops ();
			} catch (final Throwable t) {
				/* No op */
			}
		}
		u.acceptMessage ("dropkick", "Catullus", brat.getAvatarLabel ()
				+ " failed");
	}
	
	/**
	 * <p>
	 * Dump debugging information including all running threads to a
	 * server-side file. Must have staff level 1 (STAFF) to use this
	 * command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#dumpthreads</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#dumpthreads</code>
	 * <p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_dumpthreads (final String [] words,
			final AbstractUser u, final Channel channel) {

		final File runDir = new File (AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.runDir", "/opt/appius/run/"));
		final File dump;
		FileOutputStream out = null;
		try {
			dump = File.createTempFile ("threads", "dump", runDir);
			out = new FileOutputStream (dump);
			out.write ("#dumpthreads called\nUser: ".getBytes ());
			out.write (u.getAvatarLabel ().getBytes ());
			out.write ("\nStamp: ".getBytes ());
			out.write (String.valueOf (System.currentTimeMillis ())
					.getBytes ());
			out.write ('\n');
			out.write ('\n');
			out.flush ();
			for (final Zone zone : AppiusClaudiusCaecus
					.getAllZones ()) {
				out.write (" **** Zone ".getBytes ());
				out.write (zone.getName ().getBytes ());
				out.write ('\n');
				out.write ('\n');
				for (final Room aRoom : zone.getRoomList ()) {
					out.write (" ---- Room ".getBytes ());
					out.write (aRoom.getMoniker ().getBytes ());
					out.write ('\n');
					for (final Entry <String, String> var : aRoom
							.getVariables ().entrySet ()) {
						out.write ("“".getBytes ());
						out.write (var.getKey ().getBytes ());
						out.write ("” = “".getBytes ());
						out.write (var.getValue ().getBytes ());
						out.write ("”\n".getBytes ());
					}
					out.write ('\n');
				}
				out.write ('\n');
				out.write ('\n');
				for (final AbstractUser user : zone
						.getAllUsersInZone ()) {
					out.write (" ---- User ".getBytes ());
					out.write (user.getAvatarLabel ().getBytes ());
					out.write ('\n');
					out.write (user.toJSON ().toString ().getBytes ());
					out.write ('\n');
					for (final Entry <String, String> var : user
							.getUserVariables ().entrySet ()) {
						out.write (var.getKey ().getBytes ());
						out.write (':');
						out.write (var.getValue ().getBytes ());
						out.write ('\n');
					}
					out.write ('\n');
				}
				out.write ("\n\n ---------- ---------- \n\n"
						.getBytes ());
			}
			for (final Entry <Thread, StackTraceElement []> trace : Thread
					.getAllStackTraces ().entrySet ()) {
				out.write (trace.getKey ().toString ().getBytes ());
				out.write ('\n');
				out.write (LibMisc.stringify (trace.getValue ())
						.getBytes ());
				out.write ("\n----------\n\n".getBytes ());
				out.flush ();
			}
			try {
				out.write (Nomenclator.getAllCacheInfo ().getBytes ());
			} catch (final CacheException e) {
				out.write ("Caché information unavailable ("
						.getBytes ());
				out.write (LibMisc.stringify (e).getBytes ());
				out.write (')');
				out.write ('\n');
			}
			out.write ("\n\n ---> Command execution profiling:\n\n"
					.getBytes ());
			out.write (CommandExecutorThread.dumpTimes ().toString ()
					.getBytes ());
			out.write ("\nEND\n".getBytes ());
		} catch (final IOException e) {
			u.acceptMessage ("#dumpthreads", "Catullus",
					"Can't #dumpthreads:\n" + LibMisc.stringify (e));
			return;
		} finally {
			try {
				if (null != out) {
					out.close ();
				}
			} catch (final IOException e) {
				// No op.
			}
		}
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER);
		} catch (final PrivilegeRequiredException e1) {
			u
					.acceptMessage (
							"#dumpthreads",
							"Catullus",
							"Your user information and the current state of the server have been recorded. Since you were probably asked to type this code by a staff member, you should contact them and give them this time code: The current server time is "
									+ new Date ().toString ());
			return;
		}
		u
				.acceptMessage (
						"#dumpthreads",
						"Catullus",
						"File written out with debugging information about the server's current state. Call or SMS (text) 321-396-2625 to report the time and reason for this report, or mail BRPocock@Star-Hope.org");
		return;
	}
	
	/**
	 * <p>
	 * Send back the JSON data provided, for client tests.
	 * </p>
	 * <p>
	 * Warning: will squash spaces
	 * </p>
	 * 
	 * @param words JSON packet
	 * @param u user requesting the echo
	 * @param channel room in which user is standing
	 * @throws JSONException if the packet can't be interpreted
	 * @throws PrivilegeRequiredException if the user isn't staff
	 */
	public static void op_echojson (final String [] words,
			final AbstractUser u, final Channel channel) throws JSONException, PrivilegeRequiredException {
		u.assertStaffLevel (1);
		StringBuilder s = new StringBuilder ();
		for (String word : words){
			s.append(word);
			s.append(' ');
		}
		JSONObject jso = new JSONObject (s.toString ()
				);
		try {
			final ServerThread thread = u.getServerThread ();
			if (null != thread) {
				thread.sendResponse (jso, u.getRoom ().getID (), true);
			}
		} catch (final UserDeadException e) {
			BugReporter.getReporter ("client").reportBug (e);
		}
	}
	
	/**
	 * Temporary test routine for testing pathfinders on users
	 * 
	 * @param words true or false
	 * @param u who
	 * @param channel where
	 */
	public static void op_enablepathfinder (final String [] words,
			final AbstractUser u, final Channel channel) {
		((User) u).enablePathFinder (Boolean.parseBoolean (words [0]));
		return;
	}
	
	/**
	 * <p>
	 * Evacuate all users from your current Zone into another Zone. Will
	 * error if the Zone specified does not exist. Must have staff level
	 * 8 (DEVELOPER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#evacuate [ZONE]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#evacuate dottie</code>
	 * <p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_evacuate (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		final Zone refugeeZone = AppiusClaudiusCaecus
				.getZone (words [0]);
		if (null == refugeeZone) {
			u.acceptMessage ("Evacuation", "Centurion",
					"Can't evacuate to unknown Zone (or Zone with spaces in its name?): "
							+ words [0]);
			return;
		}

		int sum = 0;
		for (final AbstractUser user : u.getZone ()
				.getAllUsersInZone ()) {
			if ( !user.equals (u)) {
				try {
					user.sendMigrate (refugeeZone);
					++sum;
				} catch (final UserDeadException e) {
					// Oh, well, should have left already, huh?
				}
			}
		}
		u.acceptMessage ("Evacuation", "Centurion", "Evacuating " + sum
				+ " users to " + refugeeZone.getName ()
				+ " (but not you)");

	}

	/**
	 * @see #op_testcensor(String[], AbstractUser, Channel)
	 * @param words see
	 *            {@link #op_testcensor(String[], AbstractUser, Channel)}
	 * @param u see
	 *            {@link #op_testcensor(String[], AbstractUser, Channel)}
	 * @param channel see
	 *            {@link #op_testcensor(String[], AbstractUser, Channel)}
	 */
	public static void op_filter (final String [] words,
			final AbstractUser u, final Channel channel) {
		OpCommands.op_testcensor (words, u, channel);
	}
	
	/**
	 * <p>
	 * Finger a user account. Return interesting details in an
	 * administrative message. Must have staff level 1 (STAFF) to use
	 * this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#finger [LOGIN]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#finger mouser</code>
	 * <p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_finger (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final String receiver = words [0];
		final AbstractUser pasivo = Nomenclator
				.getUserByLogin (receiver);
		if (null == pasivo) {
			u.acceptMessage ("#finger", "Catullus",
					"Can't find user: “" + receiver + "”");
			return;
		}
		u.acceptMessage (pasivo.getAvatarLabel (), "Finger", OpCommands
				.fingerInfo (u, pasivo));
		return;
	}
	
	/**
	 * Attempt to flush the pending database records to the database (if
	 * any). Reports back how many remain pending after the sweep. Does
	 * not affect the ongoing background sweep process, which will
	 * continue to run normally.
	 * 
	 * @param words optionally, a single integer defining how many
	 *            records to attempt to flush. Defaults to 100.
	 * @param u operator
	 * @param channel ignored
	 */
	public static void op_flush (final String [] words,
			final AbstractUser u, final Channel channel) {
		Security.hasCapability (u,
				SecurityCapability.CAP_SYSADM_COMMANDS);
		int left = DataRecordFlushManager
				.flush (words.length > 0 ? Integer.parseInt (words [0])
						: 100);
		u.acceptMessage ("Flush", "DataRecordFlushManager",
				"Flushed some records. " + left + " remain pending.");
	}
	
	/**
	 * <p>
	 * Send a command into the operator command interpreter for a
	 * running game (if that game provides one)
	 * </p>
	 * <p>
	 * Usage: <tt>#game</tt> <i>gameClass</i> <i>(strings...)</i>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is standing. The
	 *            GameEvent must be attached thereunto.
	 */
	public static void op_game (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		if (words.length < 2) {
			u.sendOops ();
			return;
		}
		final String [] command = Arrays.copyOfRange (words, 2,
				words.length);
		u.getRoom ().getGameEvent (words [0])
				.acceptCommand (u, u.getRoom (), command);
		return;
	}
	
	/**
	 * <p>
	 * Get a Appius configuration variable. Must have staff level 8
	 * (DEVELOPER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#getconfig [PROPERTY]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#getconfig org.starhope.appius.requireBeta</code>
	 * <p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_getconfig (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final String confKey = OpCommands.getConfKey (words [0]);
		try {
			u.acceptMessage ("Configuration: " + confKey, "Catullus",
					AppiusConfig.getConfig (confKey));
		} catch (final NotFoundException e) {
			u.acceptMessage ("Configuration: " + confKey, "Catullus",
					"(not set)");
		}
		return;
	}
	
	/**
	 * <p>
	 * List GameEvents in your current Zone. Must have staff level 4
	 * (DESIGNER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#getevents</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#getevents</code>
	 * <p>
	 * 
	 * @see OpCommands#op_addevent(String[], AbstractUser, Room)
	 * @see OpCommands#op_getevents(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_getevents (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final StringBuilder list = new StringBuilder ();
		for (final GameEvent ev : u.getZone ().getGameEvents ()) {
			list.append (ev.getGameInstanceMoniker());
			list.append (':');
			list.append (ev.getGameShortName ());
			list.append ("\n\t");
			list.append (ev.getClass ().getCanonicalName ());
			list.append ('\t');
			list.append (ev.toString ());
			list.append ("\n\n");
		}
		u.acceptMessage ("#getevents", "Catullus", list.toString ());
	}
	
	/**
	 * Retrieve the current Message Of The Day as a server message
	 * 
	 * @param words ignored
	 * @param u user placing request
	 * @param channel channel in which the user is in
	 */
	public static void op_getmotd (final String [] words,
			final AbstractUser u, final Channel channel) {
		u.acceptMessage ("MOTD", "Appius Claudius Caecus",
				AppiusClaudiusCaecus.getMOTD ());
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 */
	public static void op_getschedule (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException {
		u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		Map <Long, Runnable> schedule = AppiusClaudiusCaecus
				.getKalendor ().getSchedule ();
		StringBuilder s = new StringBuilder ("Global schedule\n");
		if (schedule.size () == 0) {
			s.append ("(no scheduled activities)");
		} else {
			for (Map.Entry <Long, Runnable> activity : schedule
					.entrySet ()) {
				s.append ('\n');
				s.append (activity.getValue ().toString ());
				s.append (" at ");
				s.append (activity.getKey ().toString ());
			}
		}
		u.acceptMessage ("Global Schedule", "Kalendor", s.toString ());
	}
	
	/**
	 * Get scheduled events for a particular class (scheduled by that
	 * class)
	 * 
	 * @param words Specify the class's full, canonical name
	 * @param u the user invoking
	 * @param channel the channel in which the user is in
	 * @throws PrivilegeRequiredException if the user doesn't have at
	 *             least moderator privilege level
	 * @throws ClassNotFoundException is the class requested can't be
	 *             found (probably a typo)
	 */
	public static void op_getschedulefor (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException, ClassNotFoundException {
		u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		Map <Long, Runnable> schedule = AppiusClaudiusCaecus
				.getKalendor ().getScheduleFor (
						Class.forName (words [0]));
		StringBuilder s = new StringBuilder (words [0]);
		if (schedule.size () == 0) {
			s.append ("(no scheduled activities)");
		} else {
			for (Map.Entry <Long, Runnable> activity : schedule
					.entrySet ()) {
				s.append ('\n');
				s.append (activity.getValue ().toString ());
				s.append (" at ");
				s.append (activity.getKey ().toString ());
			}
		}
		u.acceptMessage ("Schedule for " + words [0], "Kalendor", s
				.toString ());
	}
	
	/**
	 * <p>
	 * Get a user variable. Must have staff level 4 (DESIGNER) to use
	 * this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#getuvar [LOGIN] [VARIABLE]</code>
	 * </p>
	 * <strong>User Name</strong>
	 * <ul>
	 * <li>user name of a character</li>
	 * <li>#me for the user you are logged in as</li>
	 * </ul>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#getuvar mouser d</code> <br/>
	 * <code>#getuvar #me d</code> <br/>
	 * <p>
	 * 
	 * @see OpCommands#op_setuvar(String[], AbstractUser, Room)
	 * @see OpCommands#op_getuvars(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_getuvar (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		String userName = words [0];
		if (words.length == 0 || "#me".equals (userName)) {
			userName = u.getAvatarLabel ();
		}
		final AbstractUser whom = Nomenclator.getUserByLogin (userName);
		if (null == whom) {
			u.acceptMessage ("#getuvars", "Catullus",
					"Can't find an user named “" + userName + "”");
			return;
		}
		if ( !whom.isOnline ()) {
			u.acceptMessage ("#getuvars", "Catullus", "User “"
					+ userName + "” is offline");
			return;
		}
		final String variable = words [1];
		final String uvar = whom.getUserVariables ().get (variable);

		final StringBuilder gotVars = new StringBuilder (whom
				.getAvatarLabel ());
		gotVars.append ("\n\n");
		gotVars.append ('“');
		gotVars.append (variable);
		gotVars.append ("” = “");
		gotVars.append (uvar);
		gotVars.append ("”\n");

		u.acceptMessage ("Variables for “" + userName + "”",
				"Catullus", gotVars.toString ());

	}
	
	/**
	 * <p>
	 * Get all user variables for a given user. Must have staff level 4
	 * (DESIGNER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#getuvars [LOGIN]</code>.
	 * </p>
	 * <strong>User Name</strong>
	 * <ul>
	 * <li>user name of a character</li>
	 * <li>#me for the user you are logged in as</li>
	 * </ul>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#getuvars mouser</code> <br/>
	 * <code>#getuvars #me</code> <br/>
	 * <p>
	 * 
	 * @see OpCommands#op_setuvar(String[], AbstractUser, Room)
	 * @see OpCommands#op_getuvar(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_getuvars (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		String userName = words [0];
		if (words.length == 0 || "#me".equals (userName)) {
			userName = u.getAvatarLabel ();
		}
		final AbstractUser whom = Nomenclator.getUserByLogin (userName);
		if (null == whom) {
			u.acceptMessage ("#getuvars", "Catullus",
					"Can't find an user named “" + userName + "”");
			return;
		}
		if ( !whom.isOnline ()) {
			u.acceptMessage ("#getuvars", "Catullus", "User “"
					+ userName + "” is offline");
			return;
		}
		final StringBuilder gotVars = new StringBuilder (whom
				.getAvatarLabel ());
		gotVars.append ("\n\n");
		for (final Entry <String, String> var : whom
				.getUserVariables ().entrySet ()) {
			gotVars.append ('“');
			gotVars.append (var.getKey ());
			gotVars.append ("” = “");
			gotVars.append (var.getValue ());
			gotVars.append ("”\n");
		}
		u.acceptMessage ("Variables for “" + userName + "”",
				"Catullus", gotVars.toString ());
	}
	
	/**
	 * Gets a room variable
	 * 
	 * @param words
	 * @param u
	 * @param channel
	 */
	public static void op_getvar (final String [] words,
			final AbstractUser u, final Channel channel) {
		OpCommands.op_getvar (words, u, u.getRoom ());
	}
	
	/**
	 * <p>
	 * Get a room variable. Must have staff level 4 (DESIGNER) to use
	 * this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#getvar @[ROOM] [VARIABLE]</code><br/>
	 * <code>#getvar [VARIABLE]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#getvar @tootsSquareWest anim~ropes</code><br/>
	 * <code>#getvar anim~ropes</code>
	 * <p>
	 * 
	 * @see OpCommands#op_setvar(String[], AbstractUser, Room)
	 * @see OpCommands#op_clearvar(String[], AbstractUser, Room)
	 * @see OpCommands#op_getvars(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is in
	 */
	private static void op_getvar (final String [] words,
			final AbstractUser u, final Room room) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		if (words.length < 1) {
			return;
		}
		if (words [0].startsWith ("@")) {
			Room thatRoom;
			try {
				thatRoom = u.getZone ().getRoom (
						words [0].substring (1));
				if (null != thatRoom) {
					final String [] subWords = Arrays.copyOfRange (
							words, 1, words.length);
					OpCommands.op_getvar (subWords, u, thatRoom);
					return;
				}
			} catch (NotFoundException e) {
				u.acceptMessage (words [0], "Catullus", "No room “"
						+ words [0] + "” in this zone");
			}
		}

		final String varName = words [0];
		u.acceptMessage ("@" + room.getMoniker (), "Catullus", "“"
				+ varName + "” = “" + room.getVariable (varName) + "”");
	}

	/**
	 * Gets all room variables
	 * 
	 * @param words
	 * @param u
	 * @param channel
	 */
	public static void op_getvars (final String [] words,
			final AbstractUser u, final Channel channel) {
		OpCommands.op_getvars (words, u, u.getRoom ());
	}
	
	/**
	 * <p>
	 * Get all room variables. Must have staff level 4 (DESIGNER) to use
	 * this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#getvars [ROOM]</code><br/>
	 * <code>#getvars</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#getvars tootsSquare</code><br/>
	 * <code>#getvars</code>
	 * <p>
	 * 
	 * @see OpCommands#op_setvar(String[], AbstractUser, Room)
	 * @see OpCommands#op_clearvar(String[], AbstractUser, Room)
	 * @see OpCommands#op_getvar(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is standing (as a room
	 *            number). This can be -1 under certain circumstances.
	 */
	private static void op_getvars (final String [] words,
			final AbstractUser u, final Room room) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		if (words.length > 0) {
			Room where;
			try {
				where = room.getZone ().getRoom (
						words [0].charAt (0) == '@' ? words [0]
								.substring (1) : words [0]);
			} catch (NotFoundException e) {
				u.acceptMessage ("#getvars", "Catullus",
						"Can't find a room named “" + words [0] + "”");
				return;
			}
			OpCommands.op_getvars (new String [] {}, u, where);
			return;
		}
		if (null == room) {
			return;
		}
		final StringBuilder gotVars = new StringBuilder ();
		for (final Entry <String, String> var : room.getVariables ()
				.entrySet ()) {
			gotVars.append ('“');
			gotVars.append (var.getKey ());
			gotVars.append ("” = “");
			gotVars.append (var.getValue ());
			gotVars.append ("”\n");
		}
		u.acceptMessage (room.getTitle (), "Catullus", gotVars
				.toString ());
	}
	
	/**
	 * give a gift
	 * <p>
	 * usage: #give ITEM# USER
	 * </p>
	 * WRITEME
	 * 
	 * @param words item# to be given, and recipient
	 * @param u the giver
	 * @param channel channel in which the giver is in
	 * @throws NumberFormatException if the item# given is not a number
	 * @throws JSONException WRITEME
	 * @throws AlreadyExistsException WRITEME
	 */
	public static void op_give (final String [] words,
			final AbstractUser u, final Channel channel)
			throws NumberFormatException, JSONException,
			AlreadyExistsException {
		if (words.length != 2) {
			u.acceptMessage ("Gift", "Catullus",
					"Usage: #give ITEM# USERLOGIN");
			return;
		}
		final JSONObject request = new JSONObject ();
		request.put ("slot", u.getInventory ().findItem (
				Integer.parseInt (words [0])).getSlotNumber ());
		request.put ("to", words [1]);
		Commands.do_give (request, u, channel);
	}
	
	/**
	 * <p>
	 * Give an inventory item to a user. Must have staff level 1 (STAFF)
	 * to use this command.
	 * </p>
	 * <p>
	 * <i>NOTE: #grant and #givehead are identical.</i>
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#givehead [ITEM] [LOGIN]</code><br/>
	 * <code>#grant [ITEM] [LOGIN]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#givehead 1337 louis</code><br/>
	 * <code>#grant 1337 louis</code>
	 * <p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is in
	 * @throws PrivilegeRequiredException requires staff level
	 *             permissions
	 */
	public static void op_givehead (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException {
		u.assertStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER);
		final String itemNumber = words [0];
		final String taker = words [1];

		final int itemNumberInt = Integer.parseInt (itemNumber);

		if ('@' == taker.charAt (0)) {
			OpCommands.givehead_toRoom (u, channel, taker,
					itemNumberInt);
			return;
		}

		final AbstractUser pasivo = Nomenclator.getUserByLogin (taker);
		if (null == pasivo) {
			OpCommands.sendAdminMessage (channel, u,
					"Can't find user: “"
					+ taker + "”");
			return;
		}
		final Inventory pasivoInventory = pasivo.getInventory ();
		InventoryItem newItem = pasivoInventory.add (itemNumberInt);
		final StringBuilder message = new StringBuilder ();
		message.append ("Gave item #");
		message.append (itemNumber);
		message.append (" to ");
		message.append (taker);
		u
				.acceptMessage ("Gift given", "Lifeguard", message
						.toString ());
		pasivo.sendEarnings (pasivo.getRoom (), newItem);
		return;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 */
	public static void op_goto (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException {
		u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		final AbstractUser who = Nomenclator
				.getOnlineUserByLogin (words [0]);
		final Coord3D pos = Coord3D.fromString (words [1]);
		if (words.length > 2) {
			Room r;
			try {
				r = u.getZone ().getRoom (words [2]);
			} catch (NotFoundException e) {
				u.acceptMessage ("#goto", "Catullus",
						"Can't find room " + words [2]);
				return;
			}
			r.join (who);
			who.setRoom (r);
		}
		who.getRoom ().goTo (who, pos, null, "Walk");
	}
	
	/**
	 * Grant an item to a user. See
	 * {@link #op_givehead(String[], AbstractUser, Room)}
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is standing (as a room
	 *            number). This can be -1 under certain circumstances.
	 * @throws PrivilegeRequiredException if the user doesn't have
	 *             sufficient privileges
	 */
	public static void op_grant (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException {
		OpCommands.op_givehead (words, u, channel);
	}
	
	/**
	 * <p>
	 * Get headcount information about the running system. Must have
	 * staff level 1 (STAFF) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#headcount #all</code><br/>
	 * <code>#headcount #members</code><br/>
	 * <code>#headcount #room</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#headcount #all</code><br/>
	 * <code>#headcount #members</code><br/>
	 * <code>#headcount #room</code>
	 * <p>
	 * 
	 * @see #headcount_all(AbstractUser, Room)
	 * @see #headcount_highwater(AbstractUser, Room)
	 * @see #headcount_rooms(AbstractUser, Room)
	 * @see #headcount_members(AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_headcount (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		if (words.length < 1) {
			OpCommands.op_headcount (new String [] { "#all" }, u,
					channel);
			return;
		}
		final String subcommand = words [0];
		if ("#members".equals (subcommand)) {
			OpCommands.headcount_members (u, channel);
			return;
		}
		if ("#highwater".equals (subcommand)) {
			OpCommands.headcount_highwater (u, channel);
			return;
		}
		if ("#rooms".equals (subcommand)) {
			try {
				u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
			} catch (final PrivilegeRequiredException e) {
				u.sendOops ();
				return;
			}
			try {
				OpCommands.headcount_rooms (u, channel);
			} catch (final JSONException e) {
				AppiusClaudiusCaecus.reportBug (e);
				u.sendOops ();
			}
			return;
		}
		if ( !"#all".equals (subcommand)) {
			u.sendOops ();
			return;
		}
		try {
			OpCommands.headcount_all (u, channel);
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (e);
			u.sendOops ();
		}
		return;
	}
	
	/**
	 * <p>
	 * Get inventory items for a particular user. By default, this will
	 * bring up only the active items — e.g. clothing being worn, and so
	 * forth.
	 * </p>
	 * <p>
	 * To get all active inventory for an user: <tt>#inv </tt>
	 * <i>LOGIN</i>
	 * </p>
	 * <p>
	 * To get <em>all</em> inventory for an user, active or inactive
	 * (this may be <em>very</em> long!): <tt>#inv </tt><i>LOGIN</i>
	 * <tt> #all</tt>
	 * </p>
	 * <p>
	 * To get inventory of a particular type, active or inactive:
	 * <tt>#inv </tt><i>LOGIN</i><tt> #type </tt><i>TYPE</i>
	 * </p>
	 * <p>
	 * The type strings accepted are those accepted by
	 * {@link Commands#do_getInventoryByType(JSONObject, AbstractUser, Room)}
	 * ; this means that both the <tt>$</tt><i>SPECIFIC-TYPE</i> and
	 * <i>TYPE-SET-NAME</i> forms are accepted. The list of specific
	 * types might include e.g. <tt>$Hair</tt>, and a type-set-name
	 * might be something like <tt>clothing</tt>. The set of available
	 * type-set-names is specified in the configuration file.
	 * 
	 * @param words User name, and optional tag #all to show all items
	 *            instead of just active, or optional tag #type and a
	 *            type string for items of a specific type. For item
	 *            types, refer to
	 *            {@link Commands#do_getInventoryByType(JSONObject, AbstractUser, Room)}
	 *            — note that this supports only a single item type (or
	 *            type-set)
	 * @param u user calling this command
	 * @param channel the room in which that user is standing
	 * @throws PrivilegeRequiredException if the user lacks staff
	 *             privileges to invoke this command
	 */
	public static void op_inv (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException {
		u.assertStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER);
		boolean allItems = false;
		if (words.length > 1) {
			if (words [1].equals ("#all")) {
				allItems = true;
			}
		}
		StringBuilder invMsg = new StringBuilder ();
		AbstractUser who = Nomenclator.getUserByLogin (words [0]);
		Iterator <InventoryItem> i = who.getInventory ().iterator ();
		while (i.hasNext ()) {
			InventoryItem item = i.next ();
			if (item.isActive ()) {
				invMsg.append (" <*>");
			} else if ( !allItems) {
				continue;
			}

			invMsg.append ("Slot #");
			invMsg.append (item.getSlotNumber ());
			invMsg.append (" = item #");
			final GenericItemReference itemInfo = item
					.getGenericItem ();
			invMsg.append (itemInfo.getItemID ());
			invMsg.append (" (“");
			String name = itemInfo.getTitle ();
			if (name.length () > 12) {
				invMsg.append (name.substring (0, 12));
				invMsg.append ('…');
			} else {
				invMsg.append (name);
			}
			invMsg.append ("”)");
			invMsg.append ('\n');
		}
		u.acceptMessage ("Inventory of " + who.getDebugName (),
				"Catullus", invMsg.toString ());
	}
	
	/**
	 * Kick a user offline for a certain reason
	 * <p>
	 * Kick a user offline for a certain reason. Must have staff level 2
	 * (MODERATOR) to use this command.
	 * </p>
	 * <p>
	 * Syntax for use: <code>#kick [REASONCODE] [LOGIN]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#kick obs.rude pil</code>
	 * <p>
	 * <strong>Reason Codes:</strong>
	 * <ul>
	 * <li>PER.MAIL = Don't share personal information like eMail
	 * addresses!</li>
	 * <li>PER.NAME = Don't share personal information like your real
	 * name!</li>
	 * <li>PER.PASS = Don't share personal information like passwords!</li>
	 * <li>PER.CHAT = Don't share personal information like chat and
	 * instant messaging \ information!</li>
	 * <li>PER.LOCA = Don't share personal information like your
	 * location!</li>
	 * <li>PER.AGES = Don't share personal information like your age!</li>
	 * <li>PER.BDAY = Don't share personal information like your birth
	 * date!</li>
	 * <li>BUL.MEAN = Don't be mean!</li>
	 * <li>OBS.RUDE = Don't be rude!</li>
	 * <li>OBS.FOUL = Don't use foul words!</li>
	 * <li>NET.CHTR = No cheating!</li>
	 * <li>APP.PARN = You need your parent's permission in order to chat
	 * in Tootsville.</li>
	 * <li>APP.MAIL = You need to confirm your eMail address in order to
	 * chat in Tootsville.</li>
	 * <li>APP.AGES = Lying about your birth date is against the law!</li>
	 * </ul>
	 * 
	 * @see #op_warn(String[], AbstractUser, Room)
	 * @see #op_ban(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 * @throws NotFoundException if the warning reason code is not valid
	 */
	public static void op_kick (final String [] words,
			final AbstractUser u, final Channel channel)
			throws NotFoundException {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		final String kickReason = OpCommands.assertValidWarnReason (
				words [0], u);
		final String bratLogin = words [1];
		final int duration = words.length > 2 ? Integer
				.parseInt (words [2]) : 15;

		final AbstractUser brat = Nomenclator
				.getUserByLogin (bratLogin);
		if (null == brat) {
			u.acceptMessage ("#kick", "Catullus", "Can't find user: “"
					+ bratLogin + "”");
			return;
		}
		try {
			brat.kick (u, kickReason, duration);
		} catch (final PrivilegeRequiredException e1) {
			u.sendOops ();
			return;
		}
		Quaestor.getDefault ().action (
				new Action (brat.getRoom (), u, "kick", brat,
						kickReason));
		return;
	}
	
	/**
	 * <p>
	 * Apply a gift membership to an user. Must have staff level 4
	 * (DESIGNER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#king [DAYS] [LOGIN]</code><br/>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#king 2 flappyperry</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 * @throws JSONException if something can't be cast into a JSON
	 *             packet underlying
	 */
	public static void op_king (final String [] words,
			final AbstractUser u, final Channel channel) throws JSONException {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		if (words.length < 2) {
			return;
		}

		final int days = Integer.parseInt (words [0]);
		final AbstractUser user = Nomenclator
				.getUserByLogin (words [1]);
		if (null == user) {
			return;
		}
		if (0 == days) {
			return;
		}
		if (days > Math.pow (2, u.getStaffLevel ())) {
			u.sendOops ();
		}

		user.addGiftSubscription (0, days);

		final String kingForNDays = LibMisc
				.getTextOrDefault (
						"kingForNDays",
						"Log out and back in to take advantage of your %d days as a VIT member!");
		user.acceptMessage ("Gift Subscription", "Lifeguard", String
				.format (kingForNDays, Integer.valueOf (days)));
		u.acceptMessage ("Gave King For n Days", "Catullus",
				"Just told " + user.getAvatarLabel () + " to "
						+ kingForNDays);
		user.sendEarnings (user.getRoom (), "You earned " + days
				+ " days as a VIT!");
	}
	
	/**
	 * <p>
	 * Lift the ban upon a user. Must have staff level 2 (MODERATOR) to
	 * use this command.
	 * </p>
	 * <p>
	 * <i> NOTE: In order to un-ban a user, you must key in the literal
	 * word “yes” as the third parameter, and supply the ban reason as
	 * the first. This is to avoid accidentally lifting a ban. </i>
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#liftban [BANREASON] [USER] yes</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#liftban app.mail flappyperry yes</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 * @throws PrivilegeRequiredException if the user lacks
	 *             PrivilegeRequiredException
	 * @throws NotFoundException if the warning reason code is not valid
	 */
	public static void op_liftban (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException, NotFoundException {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		final String banReason = OpCommands.assertValidWarnReason (
				words [0], u);
		final String bratLogin = words [1];
		final AbstractUser brat = Nomenclator
				.getUserByLogin (bratLogin);
		if ( !"yes".equals (words [2])) {
			u.sendOops ();
			return;
		}

		if (null == brat) {
			u.acceptMessage ("#liftban", u.getAvatarLabel (),
					"Can't find user: “" + bratLogin + "”");
			return;
		}

		if ( !brat.getKickedReasonCode ().equals (banReason)) {
			u.sendOops ();
			return;
		}

		brat.liftBan (u);
	}
	
	/**
	 * <p>
	 * Reload the censorship lists. Must have staff level 8 (DEVELOPER)
	 * to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#loadlists</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#loadlists</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is inu
	 */
	public static void op_loadlists (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		u.getZone ().trace (
				"(re-)loading censorship for "
						+ u.getZone ().getName ());
		try {
			u.getZone ()
					.getCensor ()
					.reloadLists (
					AppiusConfig.getDatabaseConnection ());
		} catch (final SQLException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		}
		OpCommands.sendAdminMessage (channel, u, "Reloaded lists");
		return;
	}
	
	/**
	 * <p>
	 * Display some memory usage and other debugging type information as
	 * an pop-up message. Must have Designer privileges to use this
	 * command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#mem</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#mem</code>
	 * </p>
	 * 
	 * @param words command parameters (not used)
	 * @param u invoking user
	 * @param channel The channel in which the user is in
	 */
	public static void op_mem (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final StringBuilder mem = new StringBuilder ();
		mem.append ("Memory\n\tTotal\t");
		final Runtime r = Runtime.getRuntime ();
		mem.append (LibMisc.formatMemory (r.totalMemory ()));
		mem.append ("\n\tFree\t\t");
		mem.append (LibMisc.formatMemory (r.freeMemory ()));
		mem.append ("\n\tMax\t\t");
		mem.append (LibMisc.formatMemory (r.maxMemory ()));
		mem.append ("\nProcessors\t");
		mem.append (r.availableProcessors ());
		mem.append ("\n\nGame Server\n\tZones\t");
		mem.append (AppiusClaudiusCaecus.getAllZones ().size ());
		mem.append ("\n\tServer Threads\t");
		mem.append (AppiusClaudiusCaecus.getThreadCount ());
		mem.append ("\n\tTotal Threads\t");
		mem.append (Thread.getAllStackTraces ().size ());
		mem.append ("\n\tServer started at ");
		mem.append (new java.sql.Timestamp (AppiusClaudiusCaecus
				.getBootTime ()).toString ());
		mem.append ("\n\t(");
		mem.append (LibMisc.formatPastDate (new Date (
				AppiusClaudiusCaecus.getBootTime ())));
		mem.append (')');
		u.acceptMessage ("#mem", "Catullus", mem.toString ());
		return;
	}
	
	/**
	 * <p>
	 * Display information about or micromanage the metronome. Must have
	 * staff level 8 (DEVELOPER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#metronome [OPTION]</code>
	 * <p>
	 * <p>
	 * <strong>Options</strong>
	 * <ul>
	 * <li>#rate - Displays a message indicating the rate that the
	 * metronome ticks in milliseconds.</li>
	 * <li>#last - Displays a message indicating the time in
	 * milliseconds when the last metronome tick occured.</li>
	 * <li>#start - Starts the metronome.</li>
	 * <li>#stop - Stops the metronome.</li>
	 * <li>#restart - Restarts the metronome.</li>
	 * <li>#tick - Forces the metronome to tick.</li>
	 * </ul>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#metronome #rate</code><br/>
	 * <code>#metronome #last</code><br/>
	 * <code>#metronome #start</code><br/>
	 * <code>#metronome #stop</code><br/>
	 * <code>#metronome #restart</code><br/>
	 * <code>#metronome #tick</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is standing (as a room
	 *            number). This can be -1 under certain circumstances.
	 */
	public static void op_metronome (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final String subcommand = words [0];
		if ("#rate".equals (subcommand)) {
			OpCommands.sendAdminMessage (
					channel,
					u,
					"Metronome rate is "
					+ AppiusConfig.getMetronomeTime ());
			return;
		}
		if ("#last".equals (subcommand)) {
			final long lastMetronomeTick = AppiusClaudiusCaecus
					.getLastMetronomeTick ();
			OpCommands
					.sendAdminMessage (
							channel,
							u,
							"Last metronome tick was at "
									+ lastMetronomeTick
									+ ", "
									+ (System.currentTimeMillis () - lastMetronomeTick)
									+ "ms ago");
			return;
		}
		if ("#stop".equals (subcommand)) {
			AppiusClaudiusCaecus.stopMetronome ();
			OpCommands.sendAdminMessage (channel, u,
					"Stopped metronome");
			return;
		}
		if ("#tick".equals (subcommand)) {
			AppiusClaudiusCaecus.tick ();
			OpCommands.sendAdminMessage (channel, u,
					"Metronome ticked once");
			return;
		}
		if ("#restart".equals (subcommand)) {
			AppiusClaudiusCaecus.restartMetronome ();
			OpCommands.sendAdminMessage (channel, u,
					"Metronome restarted.");
			return;
		}
		if ("#start".equals (subcommand)) {
			AppiusClaudiusCaecus.startMetronome ();
			OpCommands.sendAdminMessage (channel, u,
					"Metronome started.");
			return;
		}
	}
	
	/**
	 * <p>
	 * Set the message of the day. Must have staff level 4 (DESIGNER) to
	 * use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#motd [MESSAGE...]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#motd I am setting the message of the day</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_motd (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		final StringBuilder joined = new StringBuilder ();
		for (final String word : words) {
			joined.append (word);
			joined.append (' ');
		}
		AppiusClaudiusCaecus.setMOTD (joined.toString ());
	}

	/**
	 * @see OpCommands#op_stfu(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_mute (final String [] words,
			final AbstractUser u, final Channel channel) {
		OpCommands.op_stfu (words, u, channel);
	}
	
	/**
	 * Forcibly disconnect everyone in a room.
	 * 
	 * @param words the name of the room to be nuked
	 * @param u The user (operator) executing this instruction
	 * @param channel The channel
	 * @throws PrivilegeRequiredException WRITEME
	 */
	public static void op_nuke (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException {
		u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		Room hiroshima;
		try {
			hiroshima = u.getZone ().getRoom (words [0]);
		} catch (NotFoundException e) {
			u.acceptMessage ("Target acquisition failed", "Enola Gay",
					"Sir, we can't identify the target “" + words [0]
							+ "”");
			return;
		}
		for (final AbstractUser victim : hiroshima.getAllUsers ()) {
			final ServerThread thread = victim
					.getServerThread ();
			if (null != thread) {
				final String disconnection = LibMisc
						.getTextOrDefault (
								"nuke",
								"A problem with the game caused you to be disconnected. We're sorry for the inconvenience, and a system operator is already aware of the situation. You can sign back in immediately.");
				thread.sendAdminDisconnect (disconnection,
						"Disconnected", "Star-Hope", "nuke");
			}
			if (victim instanceof Ejecta) {
				((Ejecta) victim).destroy ();
			}
			hiroshima.part (victim);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 * @throws GameLogicException WRITEME
	 * @throws ForbiddenUserException WRITEME
	 * @throws AlreadyExistsException WRITEME
	 * @throws NotReadyException WRITEME
	 */
	public static void op_parentapproves (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException, GameLogicException,
			ForbiddenUserException, AlreadyExistsException,
			NotReadyException {
		u.assertStaffLevel (User.STAFF_LEVEL_ACCOUNT_SERVICE);
		if (words.length < 2) {
			u
					.acceptMessage ("#parentapproves", "Catullus",
							"Usage: #parentapproves <KID-ACCOUNT> <PARENT-EMAIL>");
			return;
		}
		final String login = words [0];
		AbstractUser kid = Nomenclator.getUserByLogin (login);
		if (null == kid) {
			u.acceptMessage ("#parentapproves", "Catullus",
					"No user registered as " + login);
			return;
		}
		if ( ! (kid instanceof User)) {
			u.acceptMessage ("#parentapproves", "Catullus", "User “"
					+ login + "” is not human.");
			return;
		}
		User realKid = (User) kid;
		if (realKid.canApproveSelf ()) {
			u.acceptMessage ("#parentapproves", "Catullus", "User “"
					+ login + "” can approve themself.");
			return;
		}
		if (realKid.getAgeGroup () != AgeBracket.Kid) {
			u
					.acceptMessage (
							"#parentapproves",
							"Catullus",
							"User “"
									+ login
									+ "” is not a kid. (No parent approval required.) Not sure why they can't approve themself. Contact systems programming.");
			return;
		}
		final String parentMail = words [1];
		Parent parent = Nomenclator.getParentByMail (parentMail);
		final Parent kidsParent = realKid.getParent ();
		if (null == parent) {
			if (kidsParent == null) {
				if (words.length > 2 && words [2].equals ("#create")) {
					parent = Nomenclator
							.make (Parent.class, parentMail);
					realKid.setParent (parent);
					realKid.parentApprovedName (true);
					realKid.parentApprovedAccount (true);
					u
							.acceptMessage ("#parentapproves",
									"Catullus", "Added new parent “"
											+ parentMail
											+ "” and approved “"
											+ login + "”.");
					return;
				}
				u
						.acceptMessage (
								"#parentapproves",
								"Catullus",
								"User “"
										+ login
										+ "” does not have a parent registered, and there is no parent account associated with “"
										+ parentMail
										+ "”… to force creation of the parent account and approval, use #parentapproves "
										+ login + " " + parentMail
										+ " #create");
				return;
			}
			// FIXME …!
			u
					.acceptMessage (
							"#parentapproves",
							"Catullus",
							"Kid has current parent “"
									+ kidsParent.getMail ()
									+ "”. Use #force option to change parent and set approval.");
			return;
		}
		if (kidsParent.equals (parent)) {
			realKid.parentApprovedName (true);
			realKid.parentApprovedAccount (true);
			u.acceptMessage ("#parentapproves", "Catullus",
					"Parent approval set.");
			return;
		}
		if (words.length > 2 && words [2].equals ("#force")) {
			realKid.setParent (parent);
			realKid.parentApprovedAccount (true);
			realKid.parentApprovedName (true);
			u.acceptMessage ("#parentapproves", "Catullus",
					"Reset kid's parent from “" + kidsParent.getMail ()
							+ "” to “" + parentMail
							+ "” and approved account.");
			return;
		}
		u
				.acceptMessage (
						"#parentapproves",
						"Catullus",
						"Kid has current parent “"
								+ kidsParent.getMail ()
								+ "”. Use #force option to change parent and set approval.");
		return;
	}
	
	/**
	 * <p>
	 * Ping the server, to force a neutral administrative message reply.
	 * Must have staff level 1 (STAFF) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#ping</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#ping</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_ping (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		u.acceptMessage ("Ping", "Catullus", "Pong!");
	}

	/**
	 * <p>
	 * Set the badge on a room. Usage: <tt>#setbadge</tt> <i>who</i>
	 * <i>where</i>
	 * </p>
	 * <ul>
	 * <li>“who” can be the name of the badge — typically a character
	 * name — or can also be the special value of “<tt>#me</tt>” if you
	 * are signed in as the avatar in question.</li>
	 * <li>“where” can be the moniker of a room, or the special value of
	 * “<tt>#here</tt>” to mean the room in which you are currently
	 * located.</li>
	 * </ul>
	 */
	
	/**
	 * <p>
	 * Add a Place to a room. This command supports the basic types of
	 * event Places, and adds them to the room in the given WHERE place.
	 * WHERE can be a diamond-shaped area around the operator issuing
	 * the command (using #here, #here-tiny, or #here-big), or can be an
	 * explicitly-issued polygon string. The event region ID will be
	 * automatically assigned.
	 * </p>
	 * 
	 * <pre>
	 * Usage:
	 * #place WHERE #item ITEM-NUMBER
	 * #place WHERE #room MONIKER
	 * #place WHERE #vitem PAID-ITEM-NUMBER
	 * #place WHERE #item2 ITEM-NUMBER PAID-ITEM-NUMBER
	 * #place WHERE #exit MONIKER
	 * #place WHERE #mini MINIGAME-MONIKER
	 * #place WHERE #walk
	 * WHERE := #here | #here-tiny | #here-big | x,y~x,y~x,y~x,y polygon list
	 * </pre>
	 * 
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 */
	public static void op_place (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException {
		u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		final Room room = u.getRoom ();
		if (words.length < 1) {
			u
					.acceptMessage (
							"#place",
							"Catullus",
							"Usage:\n#place WHERE #item ITEM-NUMBER\n#place WHERE #room MONIKER\n)#place WHERE #vitem PAID-ITEM-NUMBER\n#place WHERE #item2 ITEM-NUMBER PAID-ITEM-NUMBER\n#place WHERE #exit MONIKER\n#place WHERE #mini MINIGAME-MONIKER\n#place WHERE #walk\n\nWHERE := #here | #here-tiny | #here-large | x,y~x,y~x,y~x,y polygon list");
			return;
		}
		if (words.length < 3) {
			u.sendOops ();
			return;
		}

		String where = words [0];
		final Coord3D location = u.getLocation ();
		if ("#here".equals (where)) {
			where = OpCommands.getDiamond ( ((int) location.getX ()),
					((int) location.getY ()), 20);
		} else if ("#here-tiny".equals (where)) {
			where = OpCommands.getDiamond ( ((int) location.getX ()),
					((int) location.getY ()), 10);
		} else if ("#here-big".equals (where)) {
			where = OpCommands.getDiamond ( ((int) location.getX ()),
					((int) location.getY ()), 50);
		}

		final String what = words [1];
		final String placeZone = room.getPlaceZoneNumber ();
		if ("#item".equals (what)) {
			room.setVariable (placeZone, "evt_item_" + words [2] + ":"
					+ where);
			return;
		}
		if ("#item2".equals (what)) {
			room.setVariable (placeZone, "evt_itm2_" + words [2] + "_"
					+ words [3] + ":" + where);
			return;
		}
		if ("#item2".equals (what)) {
			room.setVariable (placeZone, "evt_itm2_" + words [2] + "_"
					+ words [3] + ":" + where);
			return;
		}
		if ("#vitem".equals (what)) {
			room.setVariable (placeZone, "evt_vitm_" + words [2] + ":"
					+ where);
			return;
		}
		if ("#room".equals (what)) {
			room.setVariable (placeZone, "rom_" + words [2] + ":"
					+ where);
			return;
		}
		if ("#exit".equals (what)) {
			room.setVariable (placeZone, "out_" + words [2] + ":"
					+ where);
			return;
		}
		if ("#mini".equals (what)) {
			room.setVariable (placeZone, "gam_" + words [2] + ":"
					+ where);
			return;
		}
		if ("#walk".equals (what)) {
			room.setVariable (placeZone, "walk:" + where);
			return;
		}
		u.sendOops ();
		return;
	}
	
	/**
	 * Send a Plebeian some redirection commands.
	 * 
	 * @param words Login or instance name, then commands. Subcommands
	 *            are #init, #reload, #clear, or new Plebeian script
	 *            contents to add
	 * @param u user invoking command
	 * @param channel WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws GameLogicException WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 */
	public static void op_pleb (final String [] words,
			final AbstractUser u, final Channel channel) throws NotFoundException, GameLogicException, PrivilegeRequiredException {
		if (!Security.hasCapability (u, SecurityCapability.CAP_NPC)) {
			throw new PrivilegeRequiredException (SQLPeerEnum.get (SecurityCapability.class, SecurityCapability.CAP_NPC.intValue ()));
		}
		final String subcommand = words[1];
		final String name = words[0]
		                          ;
		if ("#init".equals (subcommand)) {
			new Plebeian (u.getZone (), name);
		} else if ("#reload".equals(subcommand))
		{
			AbstractUser who = Nomenclator.getUserByLogin (name);
			if (who instanceof Plebeian) {
				Plebeian pleb = (Plebeian) who;
				pleb.getScriptRunner ().clearScript();
				pleb.getScriptRunner ().load (pleb.getUserName ());
				pleb.getScriptRunner ().doNextToDoItem ();
			} else {
				throw new GameLogicException ("Not a Plebeian", who, name);
			}
		} else if ("#state".equals (subcommand)) {
			AbstractUser who = Nomenclator.getUserByLogin (name);
			if (who instanceof Plebeian) {
				Plebeian pleb = (Plebeian) who;
				pleb.getScriptRunner ().setLogicalState (words [2]);
				pleb.getScriptRunner ().doNextToDoItem ();
			} else {
				throw new GameLogicException ("Not a Plebeian", who,
						name);
			}
		} else if ("#clear".equals(subcommand)) {
			AbstractUser who = Nomenclator.getUserByLogin (name);
			if (who instanceof Plebeian) {
				Plebeian pleb = (Plebeian) who;
				pleb.getScriptRunner ().clearScript();
			} else {
				throw new GameLogicException ("Not a Plebeian", who, name);
			}
		} else {
			StringBuilder s =new StringBuilder ();
			for (int i = 1; i < words.length;++i
			) {
				s.append (words[i]);s.append(' ');
			}
			AbstractUser who = Nomenclator.getUserByLogin (name);
			if (who instanceof Plebeian) {
				Plebeian pleb = (Plebeian) who;
				pleb.getScriptRunner ().compileScript (s.toString ());
				pleb.getScriptRunner ().doNextToDoItem ();
			}
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 */
	public static void op_purgephysics (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException {
		u.assertStaffLevel (8);
		PhysicsScheduler.purgeFutures ();
	}
	
	/**
	 * WRITEME
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 */
	public static void op_push (final String [] words,
			final AbstractUser u, final Channel channel) {
		if ('@' == words [0].charAt (0)) {
			Room r;
			try {
				r = u.getZone ().getRoom (
						words [0].substring (2));
			} catch (NotFoundException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a NotFoundException in OpCommands.op_push ",
								e);
				return;
			}
			OpCommands.op_push (Arrays.copyOfRange (words, 2,
 words.length), u,
					r.getRoomChannel ());
			return;
		}
		if ("#all".equals (words [0])) {
			u.getRoom ().pushToAllZones ();
			return;
		}
		u.getRoom ().pushToZone (AppiusClaudiusCaecus.getZone (words [0]));
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 */
	public static void op_put (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException {
		u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		final AbstractUser who = Nomenclator.getUserByLogin (words [0]);
		if (null == who) {
			u.acceptMessage ("#put", "Catullus", "I don't see “"
					+ words [0] + "” around here.");
			return;
		}
		final Coord3D place = Coord3D.fromString (words [1]);
		who.getRoom ().putHere (who, place);
		Quaestor.getDefault ().action (
						new Action (u.getRoom (), u, "op.put", who,
								null, place));
	}
	
	/**
	 * Run an RC (RunCommands) script. Both the “system run commands”
	 * (“run”) method and the “new zone run commands” (“newZone”) method
	 * will be executed; the
	 * 
	 * @param words class name
	 * @param u user
	 * @param channel channel
	 * @throws PrivilegeRequiredException user must be dev level
	 * @throws InstantiationException class can't instantiate
	 * @throws IllegalAccessException class can't instantiate
	 * @throws ClassNotFoundException probably a typo on class name
	 */
	public static void op_rc (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException, InstantiationException,
			IllegalAccessException, ClassNotFoundException {
		u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		((RunCommands) Class.forName (words [0]).newInstance ()).run ();
		((RunCommands) Class.forName (words [0]).newInstance ())
				.newZone (u.getZone ());
	}
	
	/**
	 * <p>
	 * Forces appius to restart. Must have staff level 8 (DEVELOPER) to
	 * use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#reboot</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#reboot</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_reboot (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		AppiusClaudiusCaecus.restart ();
	}
	
	/**
	 * <p>
	 * Reloads configuration properties. Must have staff level 8
	 * (DEVELOPER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#reloadconfig</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#reloadconfig</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_reloadconfig (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		AppiusConfig.loadConfig ();
		u.acceptMessage ("#reloadconfig", "Catullus",
				"Reloaded configuration");
		return;
	}
	
	/**
	 * <p>
	 * Forces a zone to retire. This will disconnect anyone currently in
	 * the zone. Use #evacuate to move users to another zone. Must have
	 * staff level 8 (DEVELOPER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#retire [ZONE]</code><br/>
	 * <code>#retire</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#retire dottie</code><br/>
	 * <code>#retire</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_retire (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		if (words.length > 0) {
			if ("#all".equals (words [0])) {
				for (final Zone z : AppiusClaudiusCaecus
						.getAllZones ()) {
					if (0 == z.getAllUsersIDsInZone ().size ()
							&& z.getName ().charAt (0) != '$') {
						z.retire ();
					}
				}
				return;
			}

			final String zoneName = words [0];
			final Zone zone = AppiusClaudiusCaecus.getZone (zoneName);
			if (null == zone) {
				u.acceptMessage ("#retire", "Catullus",
						"Can't find a zone named “" + words [0] + "”");
				return;
			}
			zone.retire ();
			return;
		}

		u.getZone ().retire ();
	}
	
	/**
	 * Run an arbitrary Java routine through an uploaded Runnable or
	 * RunCommands class
	 * 
	 * @param words WRITEME
	 * @param who WRITEME
	 * @param channel WRITEME
	 * @throws ClassNotFoundException WRITEME
	 * @throws InstantiationException WRITEME
	 * @throws IllegalAccessException WRITEME
	 */
	public static void op_run (final String [] words,
			final AbstractUser who, final Channel channel)
			throws ClassNotFoundException, InstantiationException,
			IllegalAccessException {
		Security.hasCapability (who, new SecurityCapability (
				SecurityCapability.CAP_SYSADM_COMMANDS));
		final Object o = Class.forName (words [0]).newInstance ();
		if (o instanceof Runnable) {
			((Runnable) o).run ();
		} else if (o instanceof RunCommands) {
			((RunCommands) o).run ();
			for (final Zone zone : AppiusClaudiusCaecus
					.getAllZones ()) {
				((RunCommands) o).newZone (zone);
			}
		} else {
			who.acceptMessage ("#run", "Catullus", words [0]
					+ " isn't a Runnable or RunCommands class");
		}
	}

	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param words
	 * @param u
	 * @param channel
	 */
	public static void op_saveroomvars (final String [] words,
			final AbstractUser u, final Channel channel) {
		OpCommands.op_saveroomvars (words, u, u.getRoom ());
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 */
	private static void op_saveroomvars (final String [] words,
			final AbstractUser u, final Room room) {
		if ('@' == words [0].charAt (0)) {
			Room r;
			try {
				r = u.getZone ().getRoom (words [0].substring (1));
			} catch (NotFoundException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a NotFoundException in OpCommands.op_saveroomvars ",
								e);
				return;
			}
			if (words.length > 1) {
				OpCommands.op_saveroomvars (Arrays.copyOfRange (words, 2,
						words.length), u, room);
			}
			u.acceptMessage ("#saveroomvars", "Catullus",
					"Saved room variables for " + r.getDebugName ());
			return;
		}
		if ("#here".equals (words [0])) {
			OpCommands.op_saveroomvars (new String [] { "@"
					+ room
					.getMoniker () }, u, room);
			room.saveRoomVars ();
			return;
		}
		u
				.acceptMessage ("#saveroomvars", "Catullus",
						"Usage: #saveroomvars #here, or #saveroomvars @moniker");
	}
	
	/**
	 * <p>
	 * Forces a user into another room. Must have staff level 8
	 * (DEVELOPER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#scotty [LOGIN] [ROOM]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#scotty mouser tootSquareWest</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is in
	 * @throws JSONException if something can't be done
	 * @throws PrivilegeRequiredException if so
	 */
	public static void op_scotty (final String [] words,
			final AbstractUser u, final Channel channel)
			throws JSONException, PrivilegeRequiredException {
		u.assertStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER);
		final AbstractUser kirk = Nomenclator
				.getUserByLogin (words [0]);
		if (null == kirk) {
			u.acceptMessage ("Transporter Room", "Scotty",
					"Cap'n, who is this “" + words [0]
							+ "” you're asking about?");
			return;
		}
		if (kirk != u) {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		}
		final String greenBabesHouse = words [1];
		if ('*' == greenBabesHouse.charAt (0)) {
			OpCommands.scottyZoneTeleport (u, greenBabesHouse);
			return;
		}
		Room house = null;
		try {
			house = u.getZone ().getRoom (greenBabesHouse);
		} catch (NotFoundException e) {
			u
					.acceptMessage (
							"Transporter Room",
							"Scotty",
							"Cap'n, I can't find a room named “"
									+ greenBabesHouse
									+ ".” Are you sure that's where the Orion girl is hiding?");
			return;
		}
		if (words.length == 3) {
			if ("*".equals (words [2])) {
				house.join (kirk);
			} else {
				house.join (kirk, words [2]);
			}
			kirk.setRoom (house);
			return;
		}
		final JSONObject greenBabe = new JSONObject ();
		greenBabe.put ("room", greenBabesHouse);
		kirk.doTransport ();
		kirk.acceptSuccessReply ("beam", greenBabe, u.getRoom ());
	}
	
	/**
	 * <p>
	 * Sets the base an extra color of a user's avatar. Colors should be
	 * passed in HTML format (see below). Must have staff level 4
	 * (DESIGNER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#setavatarcolors [LOGIN] [BASE] [EXTRA]</code>
	 * <p>
	 * <p>
	 * Instantiate a Colour object based upon the CSS, HTML, or JSON
	 * style of colour string.
	 * <ul>
	 * <li>The "CSS style" uses a decimal triplet in the form rgb(R,G,B)
	 * (the literal string "rgb(" identifies it).</li>
	 * <li>The "HTML style" uses a # sign followed by either 3 or 6 hex
	 * characters, in the form #RGB or #RRGGBB.</li>
	 * </ul>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#setavatarcolors mouser #000000 #ffffff</code><br/>
	 * <code>#setavatarcolors mouser rgb(0,0,0) rgb(255,255,255)</code>
	 * </p>
	 * 
	 * @see Colour#Colour(String)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 * @throws DataException if the colour is bad
	 * @throws NumberFormatException if the colour is bad
	 */
	public static void op_setavatarcolors (final String [] words,
			final AbstractUser u, final Channel channel)
			throws NumberFormatException, DataException {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		if ("#speech".equals (words [0])) {
			if (words.length != 4) {
				u.acceptMessage ("#setavatarcolors", "Catullus",
						"#speech who background text");
				return;
			}
			UserRecord user;
			try {
				user = Nomenclator.getDataRecord (UserRecord.class,
						words [1]);
			} catch (NotFoundException e) {
				u.acceptMessage ("#setavatarcolors", "Catullus",
						"Can't find a user named “" + words [1] + "”");
				return;
			}
			user.setChatBG (new Colour (words [2]));
			user.setChatFG (new Colour (words [3]));
			return;
		}

		if (words.length != 3) {
			u.acceptMessage ("#setavatarcolors", "Catullus",
					"who, base, extra; or #speech who, back, text");
			return;
		}
		final AbstractUser user = Nomenclator
				.getUserByLogin (words [0]);
		if (null == user) {
			u.acceptMessage ("#setavatarcolors", "Catullus",
					"Can't find a user named “" + words [0] + "”");
			return;
		}
		user.setBaseColor (new Colour (words [1]));
		user.setExtraColor (new Colour (words [2]));
	}
	
	/**
	 * <p>
	 * Set the badge on a room. Must have staff level 4 (DESIGNER) to
	 * use this command on another character. Staff level 2 (MODERATOR)
	 * can use the command with the #me parameter.
	 * </p>
	 * <p>
	 * <i>NOTE: Rooms that don't directly appear on the map will not
	 * have visible badges, but the badges can still be set.</i>
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#setbadge [LOGIN] [ROOM]</code> <code>#setbadge</code>
	 * </p>
	 * <strong>Login</strong>
	 * <ul>
	 * <li>User name of a character</li>
	 * <li>#me for the character you are logged in as</li>
	 * </ul>
	 * <strong>Room</strong>
	 * <ul>
	 * <li>Room moniker of a room</li>
	 * <li>#here for the room you are currently in</li>
	 * </ul>
	 * <p>
	 * <i>NOTE: Using #setbadge with no parameters will assume default
	 * values which are identical to typing</i>
	 * <code>#setbadge #me #here</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#setbadge snowcone tootSquareWest</code><br/>
	 * <code>#setbadge #me tootSquare</code><br/>
	 * <code>#setbadge snowcone #here</code><br/>
	 * <code>#setbadge #me #here</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_setbadge (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		if (words.length == 0 || "#me".equals (words [0])) {
			words [0] = u.getAvatarLabel ();
		} else {
			try {
				u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
			} catch (final PrivilegeRequiredException e) {
				u.sendOops ();
				return;
			}
		}

		if (words.length == 1 || "#here".equals (words [1])) {
			u.getZone ().setBadge (words [0], u.getRoom ());
		} else {
			try {
				u.getZone ().setBadge (words [0],
						u.getZone ().getRoom (words [1]));
			} catch (NotFoundException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a NotFoundException in OpCommands.op_setbadge ",
								e);
			}
		}
	}
	
	/**
	 * <p>
	 * Set a config property. Must have staff level 8 (DEVELOPER) to use
	 * this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#setconfing [PROPERTY] [VALUE]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#setconfig org.starhope.appius.requireBeta true</code>
	 * </p>
	 * 
	 * @see OpCommands#op_getconfig(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_setconfig (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final String confKey = OpCommands.getConfKey (words [0]);
		final String confValue = words [1];
		AppiusConfig.setConfig (confKey, confValue);
		u.acceptMessage (confKey, "Catullus", "Set config: "
				+ confKey
				+ " is now “"
				+ AppiusConfig
						.getConfigOrDefault (confKey, "—Not Set—")
				+ "”");
		AppiusConfig.configChanged ();

		return;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 */
	public static void op_sethealth (final String [] words,
			final AbstractUser u, final Channel channel) {
		Nomenclator.getUserByLogin (words [0]).getInventory ()
				.findItem (Integer.parseInt (words [1])).setHealth (
						new BigDecimal (words [2]));
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 * @throws GameLogicException WRITEME
	 */
	public static void op_setstafflevel (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException, GameLogicException {
		final int newLevel;
		if (words [0].charAt (0) == '#') {
			if ("#account-service".equals (words [0])) {
				newLevel = User.STAFF_LEVEL_ACCOUNT_SERVICE;
			} else if ("#designer".equals (words [0])) {
				newLevel = User.STAFF_LEVEL_DESIGNER;
			} else if ("#developer".equals (words [0])) {
				newLevel = User.STAFF_LEVEL_DEVELOPER;
			} else if ("#moderator".equals (words [0])) {
				newLevel = User.STAFF_LEVEL_MODERATOR;
			} else if ("#public".equals (words [0])) {
				newLevel = User.STAFF_LEVEL_PUBLIC;
			} else if ("#staff-member".equals (words [0])) {
				newLevel = User.STAFF_LEVEL_STAFF_MEMBER;
			} else {
				throw new GameLogicException ("#setstafflevel", "?",
						words [0]);
			}
		} else {
			newLevel = Integer.parseInt (words [0]);
		}
		u.assertStaffLevel (newLevel + 1);
		final AbstractUser guy = Nomenclator.getUserByLogin (words [1]);
		((User) guy).setStaffLevel (newLevel);
	}
	
	/**
	 * <p>
	 * Set a user variable. Must have staff level 4 (DESIGNER) to use
	 * this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#setuvar @[LOGIN] [VARIABLE] [VALUE...]</code>
	 * <code>#setuvar [VARIABLE] [VALUE...]</code>
	 * <code>#setbadge</code>
	 * <p>
	 * <p>
	 * <i>NOTE: Using #setconfig without an @[LOGIN] parameter will
	 * apply the changes to the user issuing the command.<i>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#setuvar @mouser d = 254~376~254~376~SE~1267735566759</code>
	 * <br/>
	 * <code>#setuvar d = 254~376~254~376~SE~1267735566759</code>
	 * </p>
	 * 
	 * @see #op_getuvar(String[], AbstractUser, Room)
	 * @see #op_getuvars(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_setuvar (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		if (words [0].startsWith ("@")) {
			final AbstractUser other = Nomenclator
					.getUserByLogin (words [0].substring (1));
			if (null != other) {
				final String [] subWords = Arrays.copyOfRange (words,
						1, words.length);
				OpCommands
						.op_setvar (subWords, other, other.getRoom ());
				return;
			}
		}
		if (words.length < 2) {
			return;
		}
		final String varName = words [0];
		final StringBuilder val = new StringBuilder ();
		for (int i = 1; i < words.length; ++i) {
			val.append (words [i]);
			val.append (' ');
		}
		final String varValue = val.toString ().substring (0,
				val.length () - 1);
		u.setVariable (varName, varValue);
	}
	
	/**
	 * <p>
	 * Set a room variable. Must have staff level 4 (DESIGNER) to use
	 * this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#setvar #replace [VARIABLE] [FIND] [REPLACE]</code><br/>
	 * <code>#setvar @[ROOM] [VARIABLE] [VALUE...]</code><br/>
	 * <code>#setvar [VARIABLE] [VALUE...]</code>
	 * </p>
	 * <p>
	 * <strong style="color: red;">WARNING: SETTING ROOM VARIABLES TO
	 * INVALID VALUES CAN CAUSE UNEXPECTED RESULTS. DOUBLE CHECK ALL
	 * VALUES BEING SET FOR CORRECTNESS.</strong>
	 * </p>
	 * <p>
	 * Use #replace to change a room variable from one value to another.
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#setvar @tootsSquareWest anim~ropes 2</code><br/>
	 * <code>#setvar anim~ropes 2</code>
	 * </p>
	 * 
	 * @see OpCommands#op_clearvar(String[], AbstractUser, Room)
	 * @see OpCommands#op_getvar(String[], AbstractUser, Room)
	 * @see Room#setVariable(String, String)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_setvar (final String [] words,
			final AbstractUser u, final Channel channel) {
		OpCommands.op_setvar (words, u, u.getRoom ());
	}
	
	/**
	 * Sets a room variable
	 * 
	 * @param words
	 * @param u
	 * @param channel
	 */
	private static void op_setvar (final String [] words,
			final AbstractUser u, final Room room) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		if ("#replace".equals (words [0])) {
			OpCommands.setvar_replace (words, u, room);
			return;
		}
		if ("#default".equals (words [0])) {
			if (words.length != 2) {
				u.acceptMessage ("#setvar #default", "Catullus",
						"@<moniker>, #all, or #here required");
				return;
			}
			if (words [1].startsWith ("@")) {
				try {
					room.getZone ().getRoom (
							words [0].substring (1)).setRoomVars ();
				} catch (NotFoundException e) {
					AppiusClaudiusCaecus
							.reportBug (
									"Caught a NotFoundException in OpCommands.op_setvar ",
									e);
				}
			} else if ("#all".equals (words [1])) {
				for (final Room r : room.getZone ().getRoomList ()) {
					r.setRoomVars ();
				}
			} else {
				room.setRoomVars ();
			}
			return;
		}
		if (words [0].startsWith ("@")) {
			try {
				Room other = room.getZone ().getRoom (
						words [0].substring (1));
				final String [] subWords = Arrays.copyOfRange (words,
						1, words.length);
				OpCommands.op_setvar (subWords, u, other);
				return;
			} catch (NotFoundException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a NotFoundException in OpCommands.op_setvar ",
								e);
			}

		}
		if (words.length < 2) {
			return;
		}
		final String varName = words [0];
		final StringBuilder val = new StringBuilder ();
		for (int i = 1; i < words.length; ++i) {
			val.append (words [i]);
			val.append (' ');
		}
		final String varValue = val.toString ().substring (0,
				val.length () - 1);
		room.setVariable (varName, varValue);
	}
	
	/**
	 * Force a client into a different room and zone
	 * 
	 * @param words space-delimited: USER ZONE ROOM
	 * @param u the user doing the Shanghai:ing
	 * @param channel the channel where the kidnapper is
	 * @throws JSONException if something can't work in JSON
	 */
	public static void op_shanghai (final String [] words,
			final AbstractUser u, final Channel channel) throws JSONException {
		if (words.length < 3) {
			u.acceptMessage ("#shanghai", "Catullus",
					"#shanghai USER ZONE ROOM");
			return;
		}
		final AbstractUser user = Nomenclator
				.getOnlineUserByLogin (words [0]);
		user.doTransport ();
		final Zone zone = AppiusClaudiusCaecus.getZone (words [1]);
		user.getZone ().remove (user);
		user.getServerThread ().enterZone (zone);
		zone.add (user);
		Room newRoom;
		try {
			newRoom = zone.getRoom (words [2]);
		} catch (NotFoundException e) {
			u.acceptMessage ("#shanghai", "Catullus",
					"No such moniker: " + words [2]);
			return;
		}
		user.setRoom (newRoom);
		final JSONObject china = new JSONObject ();
		china.put ("room", newRoom.getMoniker ());
		user.acceptSuccessReply ("beam", china, newRoom);
	}
	
	/**
	 * <p>
	 * Speak in another zone. This is intended for using operator
	 * commands in a remote zone, not normal chat messages. Must have
	 * staff level 2 (MODERATOR) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#shout [ZONE] [ROOM] [COMMAND...]</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#shout dottie tootSquareWest #wall Hello Everyone</code><br/>
	 * <code>#shout dottie tootSquare #retire</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_shout (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		if (words.length < 3) {
			u.sendOops ();
			return;
		}
		final String foreignZoneName = words [0];
		final String foreignRoomName = words [1];
		final Zone otherZone = AppiusClaudiusCaecus
				.getZone (foreignZoneName);
		if (null == otherZone) {
			u.acceptMessage ("#shout", "Catullus", "Can't find zone: "
					+ foreignZoneName);
			return;
		}
		final Room foreignRoom;
		if ("#any".equals (foreignRoomName)) {
			foreignRoom = otherZone.getNextLobby ();
		} else {
			try {
				foreignRoom = otherZone.getRoom (foreignRoomName);
			} catch (NotFoundException e) {
				u.acceptMessage ("#shout", "Catullus",
						"Can't find room " + foreignRoomName
								+ " in zone " + foreignZoneName);
				return;
			}
		}
		final String [] shoutParts = Arrays.copyOfRange (words, 2,
				words.length);
		final StringBuilder shouted = new StringBuilder ();
		for (final String part : shoutParts) {
			shouted.append (part);
			shouted.append (' ');
		}
		u.speak (foreignRoom, shouted.toString ());
		return;
	}
	
	/**
	 * <p>
	 * Create a new zone. Must have staff level 8 (DEVELOPER) to use
	 * this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#spawnzone [ZONE]</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#spawnzone Cupcake</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_spawnzone (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		if (words.length > 0) {
			ZoneSpawner.spawnZone (words [0]);
			u.acceptMessage ("#spawnzone", "Catullus",
					"Requested spawning Zone " + words [0]);
			return;
		}

		u.acceptMessage ("#spawnzone", "Catullus",
				"Requested spawning another Zone. Got: "
						+ ZoneSpawner.spawnNewZone ());
		return;
	}
	
	/**
	 * <p>
	 * Allows a user to speak. Must have staff level 2 (MODERATOR) to
	 * use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#speak [LOGIN]</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#speak flappyperry</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_speak (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final String bratLogin = words [0];
		final AbstractUser brat = Nomenclator
				.getUserByLogin (bratLogin);

		if (null == brat) {
			u.acceptMessage ("#speak", "Catullus", "Can't find user: “"
					+ bratLogin + "”");
			return;
		}

		brat.setCanTalk (true);
		brat.acceptMessage ("", "Lifeguard", LibMisc.getTextOrDefault (
				"chat.enabled",
				"You have been granted permission to chat."));
		u.acceptMessage ("", u.getAvatarLabel (), bratLogin
				+ " is now allowed to speak in Tootsville.");
	}
	
	/**
	 * <p>
	 * Silences a user. Must have staff level 2 (MODERATOR) to use this
	 * command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#stfu [LOGIN]</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#stfu flappyperry</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in
	 */
	public static void op_stfu (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final String bratLogin = words [0];
		final AbstractUser brat = Nomenclator
				.getUserByLogin (bratLogin);

		if (null == brat) {
			u.acceptMessage ("#stfu", "Catullus", "Can't find user: “"
					+ bratLogin + "”");
			return;
		}

		brat.setCanTalk (false);
		brat.acceptMessage ("", "Lifeguard", LibMisc.getTextOrDefault (
				"chat.disable", "You are no longer allowed to chat."));
		u.acceptMessage ("", u.getAvatarLabel (), bratLogin
				+ " is no longer allowed to speak in Tootsville.");
	}
	
	/**
	 * <p>
	 * Test a message with the censor, displays the filter result.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#testcensor [MESSAGE]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#testcensor This message will be filtered and the result will be displayed.</code>
	 * <p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The room in which the user is in.
	 */
	public static void op_testcensor (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		final StringBuilder messageBuilder = new StringBuilder ();
		for (final String word : words) {
			messageBuilder.append (word);
			messageBuilder.append (' ');
		}

		final String message = messageBuilder.toString ();

		final FilterResult result = u.getZone ().getCensor ()
				.filterMessage (message);
		u.acceptMessage ("#testcensor", "Catullus", String.format (
				"Censor Result:%nMessage: %s%nStatus: %s%nReason: %s",
				message, result.status, result.reason));
		return;
	}
	
	/**
	 * <p>
	 * Displays a message with the current time in Eastern Standard
	 * Time. Must have staff level 1 (STAFF) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#time</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#time</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_time (final String [] words,
			final AbstractUser u, final Channel channel) {
		final Time now = new Time (System.currentTimeMillis ());
		final java.sql.Date today = new java.sql.Date (System
				.currentTimeMillis ());
		u.acceptMessage ("#time", "Catullus", "The time is now: "
				+ System.currentTimeMillis () + " or "
				+ Messages.prettyDate (today) + " at "
				+ now.toString ());
		return;
	}
	
	/**
	 * <p>
	 * Destroys a room. Must have staff level 8 (DEVELOPER) to use this
	 * command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#unbuild [ROOM]</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#unbuild tootUniversity</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 * @throws NotFoundException if the room doesn't exist
	 */
	public static void op_unbuild (final String [] words,
			final AbstractUser u, final Channel channel)
			throws NotFoundException {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		final Zone currentZone = u.getZone ();
		currentZone.destroyRoom (currentZone.getRoom (words [0]));
	}
	
	/**
	 * <p>
	 * Forces a user to say a message. Must have staff level 4
	 * (DESIGNER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#v [LOGIN] [MESSAGE...]</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#v flappyperry I like to cause trouble in tootsville</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 * @throws JSONException if the speech can't be represented in JSON
	 *             somehow
	 * @throws NotFoundException WRITEME
	 * @see Commands#do_speak(JSONObject, AbstractUser, Channel)
	 */
	public static void op_v (final String [] words,
			final AbstractUser u, final Channel channel)
			throws JSONException, NotFoundException {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final StringBuilder talky = new StringBuilder ();
		final Room puppetRoom;
		AbstractUser [] puppets;
		final String atParam = words [0];
		if ('@' == atParam.charAt (0)) {
			final String roomName = atParam.substring (1);
			puppetRoom = u.getZone ().getRoom (roomName);
			if (null == puppetRoom) {
				u.acceptMessage ("Ventriloquism", "Ron Lucas",
						"No room exists by the name " + roomName);
				return;
			}
			puppets = puppetRoom.getAllUsers ().toArray (
					new AbstractUser [] {});
		} else {
			final AbstractUser puppet = Nomenclator
					.getUserByLogin (atParam);
			if (null == puppet) {
				u.acceptMessage ("Ventriloquism", "Ron Lucas",
						"Where's that puppet?");
				return;
			}
			puppetRoom = puppet.getRoom ();
			puppets = new AbstractUser [] { puppet };
		}

		final String [] vParts = Arrays.copyOfRange (words, 1,
				words.length);
		for (final String word : vParts) {
			talky.append (word);
			talky.append (' ');
		}
		final String talkString = talky.toString ();

		for (final AbstractUser puppet : puppets) {
			Quaestor.getDefault ().action (
					new Action (u.getRoom (), u, "ventriloquism",
							puppet,
							talkString));
			puppet.speak (puppetRoom, talkString);
		}
	}

	/**
	 * Set verbose bug backtrace reporting on or off
	 *
	 * @param words single word "true" or "false"
	 * @param u the user affected
	 * @param r the room in which the user is standing
	 */
	public static void op_verbosebugs (final String [] words,
			final AbstractUser u, final Room r) {
		final ServerThread thread = u.getServerThread ();
		if (null != thread) {
			((NetIOThread) thread).setVerboseBugReplies (Boolean
					.parseBoolean (words [0]));
			u.acceptMessage ("#verbosebugs", "Catullus",
					"Verbose exception reporting from server is now in mode: "
							+ ((NetIOThread) thread)
									.getVerboseBugReplies ());
		}
	}
	
	/**
	 * <p>
	 * Sends an pop-up message to everyone in the zone. Must have staff
	 * level 4 (DESIGNER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#wall [MESSAGE...]</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#wall This message will go to everyone in the zone I am in.</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_wall (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final StringBuilder speech = new StringBuilder ();
		for (final String word : words) {
			speech.append (' ');
			speech.append (word);
		}
		final String speechString = speech.toString ();
		Quaestor.getDefault ().action (
						new Action (u.getRoom (), u, "write.all",
								speechString));
		for (final AbstractUser anybody : u.getZone ()
				.getAllUsersInZone ()) {
			anybody.acceptMessage ("Important Message", anybody
					.hasStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER) ? u
					.getAvatarLabel () : "ADMIN", speechString);
		}
		return;
	}
	
	/**
	 * <p>
	 * Sends an pop-up message to all staff members in the zone. Must
	 * have staff level 2 (MODERATOR) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#wallops [MESSAGE...]</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#wallops This message will go to all other staff members in this zone.</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_wallops (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final StringBuilder speech = new StringBuilder ();
		for (final String word : words) {
			speech.append (word);
			speech.append (' ');
		}
		AppiusClaudiusCaecus.wallops (u, speech.toString ());
		return;
	}
	
	/**
	 * <p>
	 * Sends an pop-up message to all everyone in every zone. Must have
	 * staff level 8 (DEVELOPER) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#wallzones [MESSAGE...]</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#wallzones This message will go to everyone in every zone.</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_wallzones (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DEVELOPER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final StringBuilder speech = new StringBuilder ();
		for (final String word : words) {
			speech.append (word);
			speech.append (" ");
		}
		for (final AbstractUser anybody : AppiusClaudiusCaecus
				.getAllUsers ()) {
			if (anybody.getStaffLevel () >= u.getStaffLevel ()) {
				anybody.acceptMessage ("Write to All in all Zones", u
						.getAvatarLabel (), speech.toString ());
			} else {
				anybody.acceptMessage ("Important Announcement",
						"ADMIN", speech.toString ());
			}
		}
		return;
	}
	
	/**
	 * <p>
	 * Warn a user about breaking a rule. Must have staff level 2
	 * (MODERATOR) to use this command.
	 * </p>
	 * <p>
	 * Syntax for use: <code>#warn [REASONCODE] [LOGIN]</code>
	 * <p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#warn obs.rude pil</code>
	 * <p>
	 * <strong>Reason Codes:</strong>
	 * <ul>
	 * <li>PER.MAIL = Don't share personal information like eMail
	 * addresses!</li>
	 * <li>PER.NAME = Don't share personal information like your real
	 * name!</li>
	 * <li>PER.PASS = Don't share personal information like passwords!</li>
	 * <li>PER.CHAT = Don't share personal information like chat and
	 * instant messaging \ information!</li>
	 * <li>PER.LOCA = Don't share personal information like your
	 * location!</li>
	 * <li>PER.AGES = Don't share personal information like your age!</li>
	 * <li>PER.BDAY = Don't share personal information like your birth
	 * date!</li>
	 * <li>BUL.MEAN = Don't be mean!</li>
	 * <li>OBS.RUDE = Don't be rude!</li>
	 * <li>OBS.FOUL = Don't use foul words!</li>
	 * <li>NET.CHTR = No cheating!</li>
	 * <li>APP.PARN = You need your parent's permission in order to chat
	 * in Tootsville.</li>
	 * <li>APP.MAIL = You need to confirm your eMail address in order to
	 * chat in Tootsville.</li>
	 * <li>APP.AGES = Lying about your birth date is against the law!</li>
	 * </ul>
	 * 
	 * @see #op_kick(String[], AbstractUser, Room)
	 * @see #op_ban(String[], AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 * @throws NotFoundException if the warning reason code is not valid
	 */
	public static void op_warn (final String [] words,
			final AbstractUser u, final Channel channel)
			throws NotFoundException {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final String warnReason = OpCommands.assertValidWarnReason (
				words [0], u);
		final String bratLogin = words [1];
		final AbstractUser brat = Nomenclator
				.getUserByLogin (bratLogin);

		if (null == brat) {
			u.acceptMessage ("#warn", "Catullus", "Can't find user: “"
					+ bratLogin + "”");
			return;
		}
		final String warning = String.format (LibMisc.getText ("rule."
				+ warnReason), brat.getAvatarLabel ());
		if (brat.isOnline ()) {
			brat.acceptMessage ("Warning", (brat.hasStaffLevel (u
					.getStaffLevel ()) ? u.getAvatarLabel ()
					: "Lifeguard"), warning);
		}
		Quaestor.getDefault ().action (
				new Action (brat.getRoom (), u, "warn", brat,
						warnReason));
		u.acceptMessage ("@" + brat.getAvatarLabel (), u
				.getAvatarLabel (), warning);
	}
	
	/**
	 * <p>
	 * Displays information about an item. Must have staff level 1
	 * (STAFF) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#whatis [ITEM]</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#whatis 1337</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 * @throws NotFoundException WRITEME
	 * @throws NumberFormatException WRITEME
	 */
	public static void op_whatis (final String [] words,
			final AbstractUser u, final Channel channel)
			throws NumberFormatException, NotFoundException {
		final StringBuilder what = new StringBuilder ();
		final GenericItemReference item = Nomenclator.getDataRecord (
				GenericItemReference.class, Integer
						.parseInt (words [0]));
		what.append ("Item #");
		what.append (item.getItemID ());
		what.append ("\n Title: ");
		what.append (item.getTitle ());
		what.append ("\n Class:");
		what.append (item.getClass ().getCanonicalName ());
		what.append ("\n Price:");
		what.append (item.getPrice ().toPlainString ());
		what.append ("\n Description:\n");
		what.append (item.getDescription ());
		u.acceptMessage ("What is it?", "Catullus", what.toString ());
		return;
	}
	
	/**
	 * <p>
	 * Return an administrative message with the name of the Zone in
	 * which the player is currently standing. Must have staff level 1
	 * (STAFF) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#whereami</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#whereami</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_whereami (final String [] words,
			final AbstractUser u, final Channel channel) {
		OpCommands.sendAdminMessage (channel, u, "You are in "
				+ u.getRoom ().getDebugName ());
		return;
	}
	
	/**
	 * <p>
	 * Find out in what what room a character is standing, if s/he is
	 * logged in at the moment. Must have staff level 2 (MODERATOR) to
	 * use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#whereis [LOGIN]</code>
	 * </p>
	 * <strong>Login</strong>
	 * <ul>
	 * <li>User Name of a specific user</li>
	 * <li>#everyone for a the location of every user in the zone.</li>
	 * <li>@[ROOM] for the location of every user in the specified room.
	 * </li>
	 * </ul>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#whereis snowcone</code><br/>
	 * <code>#whereis #everyone</code><br/>
	 * <code>#whereis @tootSquare</code>
	 * </p>
	 * 
	 * @see #whereis_atRoom(AbstractUser, Room, String)
	 * @see #whereis_everyone(AbstractUser, Room)
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_whereis (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final String whoWeWant = words [0];
		if ("#everyone".equals (whoWeWant)) {
			OpCommands.whereis_everyone (u, channel);
			return;
		}
		if (whoWeWant.charAt (0) == '@') {
			OpCommands
.whereis_atRoom (u, channel,
					whoWeWant.substring (1));
			return;
		}
		final AbstractUser them = Nomenclator
				.getUserByLogin (whoWeWant);
		if (null == them) {
			u.acceptMessage (whoWeWant, "Catullus", "No user named “"
					+ whoWeWant + "”");
			return;
		}
		final Room place = them.getRoom ();
		if (null == place) {
			if (them.isNPC ()) {
				try {
					UserRecord rec = Nomenclator.getDataRecord (
							UserRecord.class, whoWeWant);
					Set <WeakReference <AbstractUser>> npcs = Nomenclator
							.getOnlineNPCs (rec.getLogin ()
									.toLowerCase (Locale.ENGLISH));
					StringBuilder s = new StringBuilder ();
					for (WeakReference <AbstractUser> npc : npcs) {
						AbstractUser n = npc.get ();
						if (null == n) {
							s.append ("disconnected\n");
						} else {
							s.append (n.getAvatarLabel ());
							s.append (" is: ");
							s.append (n.getDebugName ());
							Room r = n.getRoom ();
							if (null == r) {
								s.append (" (lost)\n\n");
							} else {
								s.append (" in ");
								s.append (r.getDebugName ());
								s.append ("\n\n");
							}
						}
					}
					u.acceptMessage (whoWeWant, "Catullus",
							"User is an NPC:\n\n" + s.toString ());
				} catch (NotFoundException e) {
					u.acceptMessage (whoWeWant, "Catullus",
							"User is non-findable NPC? "
									+ e.toString ());
				}

			} else {
				u.acceptMessage (whoWeWant, "Catullus", "User is offline");
			}
		} else {
			final StringBuilder report = new StringBuilder ();
			report.append (them.getAvatarLabel ());
			report.append (" is at ");
			report.append (them.getLocation ().toString ());
			report.append (" in room “");
			report.append (place.getTitle ());
			report.append ("” in zone “");
			report.append (place.getZone ().getName ());
			report.append ("”");
			u.acceptMessage (whoWeWant, "Catullus", report.toString ());
		}
		return;
	}
	
	/**
	 * <p>
	 * Displays a list of everyone currently in a room. Must have staff
	 * level 2 (MODERATOR) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#who [ROOM]</code><br/>
	 * <code>#who</code>
	 * </p>
	 * <p>
	 * <i>NOTE: Leaving off the ROOM parameter will default to
	 * displaying for the room the command was initialized in.</i>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#who tootSquare</code><br/>
	 * <code>#whereis</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 * @throws PrivilegeRequiredException if the user calling isn't a
	 *             staff member
	 * @throws NotFoundException if the chosen room does not exist
	 */
	public static void op_who (final String [] words,
			final AbstractUser u, final Channel channel)
			throws PrivilegeRequiredException, NotFoundException {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}

		u.assertStaffLevel (User.STAFF_LEVEL_STAFF_MEMBER);
		Room theRoom;
		if (words.length >= 1) {
			theRoom = u.getZone ().getRoom (words [0]);
		} else {
			theRoom = u.getRoom ();
		}
		final StringBuilder roster = new StringBuilder ();
		for (final AbstractUser whomever : theRoom.getAllUsers ()) {
			roster.append (whomever.getAvatarLabel ());
			roster.append ('\n');
		}
		u.acceptMessage (theRoom.getName (), "Catullus", roster
				.toString ());
	}
	
	/**
	 * <p>
	 * Cause the character to speak his/her name in the current room.
	 * Appears as dialogue in the form: “Hello, my name is NAME”. Must
	 * have staff level 1 (STAFF) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#whoami</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#whoami</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_whoami (final String [] words,
			final AbstractUser u, final Channel channel) {

		u.speak (channel, "Hello, my name is " + u.getAvatarLabel ());
		return;
	}
	
	/**
	 * <p>
	 * Ask the server who it is. This command should return version
	 * information on some of the critical classes used in the game
	 * server. Must have staff level 2 (MODERATOR) to use this command.
	 * </p>
	 * <p>
	 * <strong>Syntax for use</strong><br/>
	 * <code>#whoareyou</code>
	 * </p>
	 * <p>
	 * <strong>Examples</strong><br/>
	 * <code>#whoareyou</code>
	 * </p>
	 * 
	 * @param words The command parameters (whitespace-delimited list)
	 *            provided after the # command name
	 * @param u The user invoking the operator command
	 * @param channel The channel in which the user is in.
	 */
	public static void op_whoareyou (final String [] words,
			final AbstractUser u, final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_MODERATOR);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		StringBuilder s = new StringBuilder ();
		s.append (AppiusClaudiusCaecus.getServerHostname ());
		s.append ("\nAppius\t");
		s.append (AppiusClaudiusCaecus.getRev ());
		s.append ("\nZone\t");
		s.append (Zone.getRev ());
		s.append ("\nUser  \t");
		s.append (User.getRev ());
		s.append ("\nOpCommands\t$Rev: 2225 $");
		s.append ("\nCommands\t");
		s.append (Commands.getRev ());
		s.append ("\nPreLoginCommands\t");
		s.append (PreLoginCommands.getRev ());

		u.acceptMessage ("Hello!", "Claudius", s.toString ());

		return;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 */
	public static void op_zoom (final String [] words,
			final AbstractUser u, final Channel channel) {
		AbstractUser user = u;
		if (words.length == 2) {
			user = Nomenclator.getUserByLogin (words [1]);
		}
		UserTransients.getEffects (user).heightScalar = Double
				.parseDouble (words [0]);
		user.sendWardrobe ();
		return;
	}

	/**
	 * @param u who is going
	 * @param greenBabesHouse the Zone to which to go
	 */
	private static void scottyZoneTeleport (final AbstractUser u,
			final String greenBabesHouse) {
		final Zone z = AppiusClaudiusCaecus.getZone (greenBabesHouse
				.substring (1));
		if (null == z) {
			u
					.acceptMessage (
							"Transporter Room",
							"Scotty",
							"Cap'n, there's no zone named “"
									+ greenBabesHouse
									+ "” at all. Are you from the mirror universe or something?");
			return;
		}
		try {
			u.sendMigrate (z);
		} catch (final UserDeadException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a UserDeadException in OpCommands.op_scotty ",
							e);
		}
		return;
	}

	/**
	 * Send an administrative message to a user. See
	 * {@link User#acceptMessage(String, String, String)} for the
	 * preferred version.
	 *
	 * @deprecated Use
	 *             {@link AbstractUser#acceptMessage(String, String, String)}
	 *             instead.
	 * @param channel The channel in which the user is in
	 * @param anybody The user to receive the administrative message
	 * @param string The administrative message to be sent
	 */
	@Deprecated
	public static void sendAdminMessage (final Channel channel,
			final AbstractUser anybody, final String string) {
		anybody.acceptMessage ("", "ADMIN", string);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param u user invoking error
	 * @param cmd command
	 * @param throwable exception
	 */
	private static void sendUserErrorMessage (final AbstractUser u,
			final String cmd, final Throwable throwable) {
		final Thread userThread = u.getServerThread ();
		if (null != userThread
				&& ((NetIOThread) userThread).getVerboseBugReplies ()) {
			u.acceptMessage ("$@", "Java", LibMisc
					.stringify (throwable));
			return;
		}
		u.acceptMessage ("$@", "Java", throwable.toString ());
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Mar 5,
	 * 2010)
	 * 
	 * @param words WRITEME
	 * @param u WRITEME
	 * @param channel WRITEME
	 */
	private static void setvar_replace (final String [] words,
			final AbstractUser u, final Room room) {
		if (words.length != 4) {
			u.sendOops ();
			return;
		}
		final String varName = words [1];
		final String find = words [2];
		final String replace = words [3];

		final List <String> changed = new LinkedList <String> ();
		for (final Room aRoom : room.getZone ().getRoomList ()) {
			if (aRoom.getVariable (varName).equals (find)) {
				aRoom.setVariable (varName, replace);
				changed.add (aRoom.getName ());
			}
		}
		final StringBuilder msg = new StringBuilder ("Changed ");
		msg.append (changed.size ());
		msg.append (" rooms (s,");
		msg.append (find);
		msg.append (',');
		msg.append (replace);
		msg.append (",g in ");
		msg.append (varName);
		msg.append (')');
		if (changed.size () > 0) {
			msg.append (": ");
			msg.append (LibMisc.listToDisplay (changed, u
					.getLanguage (), u.getDialect ()));
		}
		u.acceptMessage ("#setvar #replace", "Catullus", msg
				.toString ());
		return;
	}
	
	/**
	 * Get the list of users in a room. Implementation of
	 * <tt>#whereis @</tt><i>roomMoniker</i>
	 * 
	 * @param u the user issuing the request
	 * @param channel the channel in which the user is in
	 * @param roomMoniker Moniker the moniker of the room for which the
	 *            user wants the list of users
	 */
	private static void whereis_atRoom (final AbstractUser u,
			final Channel channel, final String roomMoniker) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final StringBuilder report = new StringBuilder (roomMoniker);
		report.append ('\n');
		try {
			for (final AbstractUser them : u.getZone ()
					.getRoom (roomMoniker).getAllUsers ()) {
				report.append (them.getAvatarLabel ());
				report.append ('\t');
				report.append (them.getLocation ().toString ());
				report.append ('\n');
			}
		} catch (NotFoundException e) {
			u.acceptMessage ("? @" + roomMoniker, "Catullus",
					"Can't locate room " + roomMoniker);
			return;
		}
		u.acceptMessage ("Who's in " + roomMoniker, "Catullus",
				report.toString ());
		return;
	}
	
	/**
	 * Get the list of users in the current zone. Implementation of
	 * <tt>#whereis #everyone</tt>
	 * 
	 * @param u the user issuing the request
	 * @param channel the channel in which that user is in
	 */
	private static void whereis_everyone (final AbstractUser u,
			final Channel channel) {
		try {
			u.assertStaffLevel (User.STAFF_LEVEL_DESIGNER);
		} catch (final PrivilegeRequiredException e) {
			u.sendOops ();
			return;
		}
		final StringBuilder report = new StringBuilder ();
		for (final Integer theirID : u.getZone ()
				.getAllUsersIDsInZone ()) {
			final AbstractUser them = Nomenclator.getUserByID (theirID
					.intValue ());
			report.append (them.getAvatarLabel ());
			final Room place = them.getRoom ();
			if (null == place) {
				report.append (" is offline\n");
			} else {
				report.append (" at ");
				report.append (them.getLocation ().toString ());
				report.append (" in “");
				report.append (place.getTitle ());
				report.append ("” in zone “");
				report.append (place.getZone ().getName ());
				report.append ("”\n");
				final Room roomIpse = Nomenclator.getUserByID (
						them.getUserID ()).getRoom ();
				if (null == roomIpse) {
					report
							.append ("Nomenclator's user thinks room is null, but zone's copy of user thinks it's "
									+ place.getTitle () + "\n");
				} else if ( !roomIpse.getMoniker ().equals (
						place.getMoniker ())) {
					report.append (" !mismatch: zone's user is in "
							+ place.getTitle ()
							+ " but Nomenclator version is in "
							+ roomIpse.getMoniker () + "\n");
				}
			}
		}
		u.acceptMessage ("Where is everyone?", "Catullus", report
				.toString ());
		return;
	}

	/**
	 * @param u user
	 */
	public static void z$z (final AbstractUser u) {
		u
				.acceptMessage (
						"By...",
						"Star-Hope",
						LibMisc
								.rot13 ("Nccvhf Pynhqvhf Pæphf, Tnvhf Inyrevhf Pnghyyhf, Pybqvn Zrgryyv Chypure, Choyvhf Iretvyvhf Zneb, naq eryngrq grpuabybtvrf hfrq va gur perngvba bs guvf tnzr ner Pbclevtug © 1998-2010, Oehpr-Eboreg Cbpbpx, naq ner yvprafrq haqre gur grezf bs gur TAH Trareny Choyvp Yvprafr (TCY) I3. uggc://jjj.Fgne-Ubcr.Bet/"));
		try {
			for (final String msg : (String []) AppiusConfig
					.getUserClass ().getMethod ("getZ$Z").invoke (null,
							(Object []) null)) {
				u.acceptMessage ("By...", "Catullus", LibMisc
						.rot13 (msg));
			}
		} catch (final Throwable t) {
			/* No Op */
		}
	}

}
