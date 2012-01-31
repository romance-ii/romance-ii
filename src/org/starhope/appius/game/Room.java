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
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game;

import java.awt.Rectangle;
import java.awt.geom.GeneralPath;
import java.awt.geom.Line2D;
import java.awt.geom.Point2D;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.regex.Pattern;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


import org.starhope.appius.except.DataException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.game.GameBase;
import org.starhope.appius.game.GameRoom;
import org.starhope.appius.game.VehicleStyle;
import org.starhope.appius.game.Zone;
import org.starhope.appius.game.actions.ActionClick;
import org.starhope.appius.game.actions.ActionClickHandler;
import org.starhope.appius.game.actions.ActionEventAreaEnter;
import org.starhope.appius.game.actions.ActionEventAreaEnterHandler;
import org.starhope.appius.game.actions.ActionEventAreaExit;
import org.starhope.appius.game.actions.ActionEventAreaExitHandler;
import org.starhope.appius.game.actions.ActionListenerSet;
import org.starhope.appius.game.actions.ActionRoomJoin;
import org.starhope.appius.game.actions.ActionRoomJoinHandler;
import org.starhope.appius.game.actions.ActionRoomPart;
import org.starhope.appius.game.actions.ActionRoomPartHandler;
import org.starhope.appius.game.actions.AutomaticDoor;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.game.inventory.InventoryItemType;
import org.starhope.appius.game.inventory.ItemEffects;
import org.starhope.appius.game.npc.Ejecta;
import org.starhope.appius.game.npc.NullLoader;
import org.starhope.appius.game.npc.plebeian.Plebeian;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.geometry.Polygon;
import org.starhope.appius.geometry.Volume3D;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.net.datagram.ADPRoomVar;
import org.starhope.appius.net.datagram.ADPEquipment;
import org.starhope.appius.net.datagram.ADPError;
import org.starhope.appius.net.datagram.ADPError.Codes;
import org.starhope.appius.net.datagram.ADPOverlayWindow;
import org.starhope.appius.net.datagram.ADPRoomPart;
import org.starhope.appius.net.datagram.ADPRoomVar;
import org.starhope.appius.net.datagram.ADPUserAction;

import org.starhope.appius.net.datagram.ADPSpeak;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.physica.Geometry;
import org.starhope.appius.room.RoomPlace;
import org.starhope.appius.room.RoomPlaceType;
import org.starhope.appius.sys.op.FilterResult;
import org.starhope.appius.sys.op.FilterStatus;
import org.starhope.appius.types.Colour;
import org.starhope.appius.types.HasVariables;
import org.starhope.appius.user.AbstractNonPlayerCharacter;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.AvatarClass;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.User;
import org.starhope.appius.user.UserTransients;
import org.starhope.appius.user.events.Action;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.AcceptsMetronomeTicks;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.catullus.Copyable;
import org.starhope.util.LibMisc;
import org.starhope.util.types.Pair;

/**
 * A room located in the local zone <h1>Room Variables</h1>
 * <p>
 * The room variables structure is defined to reserve all lower-case
 * named variables for system purposes.
 * </p>
 * <p>
 * The following room variables are specially used:
 * </p>
 * <h2>Room Environment</h2>
 * <p>
 * These room variables define the general environment. They can contain
 * single filenames or a series of colon-delimited filenames, which will
 * be stacked from bottom to top. (The first name given is the lowest or
 * farthest level of stacking.)
 * </p>
 * <dl>
 * <dt>s</dt>
 * <dl>
 * The Sky, or background artwork.
 * </dl>
 * <dt>f</dt>
 * <dl>
 * The Floor, or foreground artwork.
 * </dl>
 * <dt>w</dt>
 * <dl>
 * The Weather, or overlay artwork.
 * </dl>
 * </dl> <h2>Room Objects</h2>
 * <ul>
 * <li>Placed items: key: “item” + Unique-ID = value: item-ID "~"
 * x-position "~" y-position "~" facing (facing can be a null string)</li>
 * <li>User-positioned items: key: “furn”
 * <li>Text items: key: "text" + unique-ID = value:
 * </ul>
 * <h2>Places</h2>
 * <p>
 * Places are regions of the room defined by polygonal outlines. These
 * are held in Room Variables with names of the form "zone" plus an
 * arbitrary identifier. The contents of the room variable are a
 * <em>key</em> followed by ":" and a series of coördinates.
 * </p>
 * <p>
 * Each coördinate pair is given as x,y in decimal, literally, like:
 * "100,200". They are separated with "~". To stop one polygon and start
 * on another, give "~~" with no coördinates between.
 * </p>
 * <p>
 * The key of a Place specifies its purpose. The keys understood by the
 * server include:
 * </p>
 * <ul>
 * <li>TODO — these are hidden in the Google Docs shared among some Res
 * staff right now; however, they should be appearing in the Room rework
 * branch, as this stuff is getting broken out better. I'm holding off
 * on rewriting this documentation for now, because that documentation
 * should fill most of the gaps.</li>
 * </ul>
 * <p>
 * XXX — there is support for denying vehicles in a room, but there's
 * not database integration.
 * </p>
 * <p>
 * XXX — there is a concept of swimming in the item effects system, but
 * the walkspace / swim space integration isn't handled at all. This is
 * not enabled at all for anyone to consume at the moment. This is part
 * of the new Room and movement code, so it will be done on that branch.
 * </p>
 * <p>
 * TODO: This class needs some internal cleanups. Based upon the
 * {@link HasVariables} interface, the internal data structures need to
 * be cleaned up, rather than constantly relying upon strings. That's in
 * a branch presently.
 * </p>
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
@Deprecated
public class Room extends SimpleDataRecord <Room> implements
		HasVariables, AcceptsMetronomeTicks, Copyable <Room>,
		ChannelListener {
	
	/**
	 * The default for the maximum number of users to permit in a room.
	 * XXX config
	 */
	public final static int DEFAULT_USER_LIMIT = 40;
	
	/**
	 * Semi-tunable: The minimum number of total x and y pixels of
	 * motion before the facing of the object/user will be affected
	 */
	private static final double FACING_MIN_EFFECT = 2;
	
	/**
	 * The width of one octant (demi-quadrant) of a circle, for facing
	 * computations
	 */
	public final static double octant = Math.PI / 4;
	
	/**
	 * the string values of facings in each of the eight octants of a
	 * circle (and a repeat of #1 for padding's sake)
	 */
	public final static String [] octantFacing = { "S", "SW", "W",
			"NW", "N", "NE", "E", "SE", "S" };
	
	/**
	 * Java serialization unique ID
	 */
	private static final long serialVersionUID = 777843822192305721L;
	
	
	/**
	 * the distance to an user
	 */
	private static final double USER_FIND_EPSILON = 25d;
	
	/**
	 * ID for the next generated room
	 */
	private static AtomicInteger nextID = new AtomicInteger ();

	/**
	 * Create a room from the database, or (if mustExist == false)
	 * create a new anonymous room. Rooms created from the database are
	 * persistent rooms that can have game-events and such dynamically
	 * applied
	 *
	 * @param moniker The database name for the base room
	 * @param zone the zone in which the room is to be created
	 * @param user The user that the room belongs to, if there is one
	 * @param instance The instance of the room (0,1,2,3, etc.)
	 * @return the created room
	 * @throws NotFoundException Room moniker not found
	 */
	public static Room create (final String moniker, final Zone zone, final AbstractUser user, final int instance)
			throws NotFoundException {
		final String newBaseMoniker = moniker + (user != null ? "$" + user.getAvatarLabel ().toLowerCase () : "");
		final String newFullMoniker = newBaseMoniker + "~" + instance;
		
		log.debug ("Room.create (" + newFullMoniker + "," + zone.getName () + ") *named room");
		final Room newRoom = Nomenclator.getDataRecord (Room.class, moniker);
		newRoom.templateVariables = Nomenclator.getDataRecord (RoomVar.class, moniker);
		newRoom.roomVariables = Nomenclator.getDataRecord (RoomVar.class, newBaseMoniker);
		newRoom.setRoomVars ();
		newRoom.setMoniker (newFullMoniker);
		newRoom.baseMoniker = newBaseMoniker;
		newRoom.setZone (zone);
		newRoom.setOwner (user);
		zone.add (newRoom);
		newRoom.channel = new RoomChannel (newFullMoniker, zone, newRoom);
		// Add in hooks to listeners for automatic doors/animations
		AutomaticDoor.registerListeners (newRoom);
		return newRoom;
	}
	/**
	 * Create a room from the database, or (if mustExist == false)
	 * create a new anonymous room. Rooms created from the database are
	 * persistent rooms that can have game-events and such dynamically
	 * applied
	 * 
	 * @param newMoniker The name of the room to create
	 * @param zone the zone in which the room is to be created
	 * @param mustExist If true, a named room from the database. If
	 *             false, an anonymous/temporary room.
	 * @return the created room
	 * @throws NotFoundException Room moniker not found
	 */
	public static Room create (final String newMoniker,
			final Zone zone, final boolean mustExist)
			throws NotFoundException {
		if ( !mustExist) {
			return Room.createPublicRoom (newMoniker, zone);
		}
		zone.trace ("Room.create (" + newMoniker + ","
				+ zone.getName () + ") *named room");
		final Room newRoom = Room.loadRoomFromDB (newMoniker, zone);
		newRoom.channel = new RoomChannel (newMoniker, zone, newRoom);
		return newRoom;
	}
	
	/**
	 * <p>
	 * Create a temporary/anonymous room without referring to the
	 * database.
	 * </p>
	 * 
	 * @param roomName the moniker of the room
	 * @param zone the zone in which the room is to be created
	 * @return the newly-created room
	 */
	public static Room createPublicRoom (final String roomName,
			final Zone zone) {
		zone.trace ("Room.create (" + roomName + ","
				+ zone.getName () + ") *anonymous room");
		Room newRoom = null;
		try {
			newRoom = Nomenclator.make (Room.class);
		} catch (final NotReadyException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a NotReadyException in Room.createPublicRoom ",
							e);
			return null; // TODO?
		}
		newRoom.setZone (zone);
		newRoom.setMoniker (roomName);
		newRoom.myID = Room.getNextID ();
		zone.add (newRoom);
		newRoom.channel = new RoomChannel (roomName, zone, newRoom);
		return newRoom;
	}
	
	/**
	 * @return an array of all rooms in the game
	 */
	public static Room [] getAllRooms () {
		final Collection <Room> everywhere = RoomSQLLoader
				.getRoomsInDB ();
		final Room [] everywhereArray = new Room [everywhere.size ()];
		final Iterator <Room> copier = everywhere.iterator ();
		int i = 0;
		while (copier.hasNext ()) {
			everywhereArray [i++ ] = copier.next ();
		}
		return everywhereArray;
	}
	
	/**
	 * @param moniker the moniker value for this room
	 * @param zone the zone containing this room
	 * @return the room object
	 */
	public static Room getByMoniker (final String moniker,
			final Zone zone) {
		Room r;
		try {
			r = zone.getRoom (moniker);
		} catch (final NotFoundException e1) {
			try {
				return Room.loadRoomFromDB (moniker, zone);
			} catch (final NotFoundException e) {
				return null;
			}
		}
		return r;
	}
	
	/**
	 * <p>
	 * Create an instance room.
	 * </p>
	 * <p>
	 * This is intended for (and used by) user houses' rooms (
	 * {@link #initUserRoom(Zone, AbstractUser, int) }), but can also be
	 * used for the purposes of a private channel being created for
	 * various purposes. For example, multiplayer minigames (via
	 * {@link GameEvent}) create an instanced room off of a “null” base
	 * room, then join that room to provide a private communications
	 * channel. For this purpose, see {@link #initInstanceRoom()}
	 * </p>
	 * 
	 * @param zone the Zone in which to create the instance room
	 * @param cloneThis the base room to be cloned
	 * @param baseMoniker the moniker upon which to base the new room's
	 *             moniker
	 * @param instance the instance ID #, which will both be appended
	 *             to the room's baseMoniker with a '~', and also be
	 *             set as the room's room index number (for
	 *             {@link #getRoomIndex()})
	 * @return the newly-instantiated room
	 */
	public static Room initInstanceRoom (final Zone zone,
			final Room cloneThis, final String baseMoniker,
			final int instance) {
		final Room newRoom = cloneThis.copyProtoype (cloneThis);
		newRoom.setMoniker (baseMoniker + "~"
				+ String.valueOf (instance));
		newRoom.setZone (zone);
		newRoom.setRoomIndex (instance);
		zone.add (newRoom);
		newRoom.channel = new RoomChannel (newRoom.getMoniker (),
				zone, newRoom);
		newRoom.markAsLoaded ();
		return newRoom;
	}
	
	/**
	 * Instantiate a room from an user's House in the current Zone that
	 * the user is logged in.
	 * 
	 * @param user the user owning the house
	 * @param roomNumber which room in the user's house
	 * @return the instance of that room in the user's current Zone
	 * @throws NotReadyException if the room can't be found or created,
	 *              typically because the user isn't signed in, so
	 *              their Zone can't be determined.
	 * @see #initUserRoom(Zone,AbstractUser,int)
	 * @deprecated use {@link #initUserRoom(Zone,AbstractUser,int)}
	 *             instead, please.
	 */
	@Deprecated
	public static Room initUserRoom (final AbstractUser user,
			final int roomNumber) throws NotReadyException {
		final Zone userZone = user.getZone ();
		if (null == userZone) {
			throw new NotReadyException ("user offline");
		}
		return Room.initUserRoom (userZone, user, roomNumber);
	}
	
	/**
	 * Instantiate a Room for a given user's house, for one of the
	 * rooms
	 * 
	 * @param zone the zone in which to instantiate the room
	 * @param user the owner of the house
	 * @param roomNumber the room number
	 * @return the newly-instanced user room
	 * @throws NotReadyException if the room can't be instantiated
	 */
	public static Room initUserRoom (final Zone zone,
			final AbstractUser user, final int roomNumber)
			throws NotReadyException {
		Room newRoom;
		final String monikerPrefix = "user~"
				+ user.getAvatarLabel ().toLowerCase (
						Locale.ENGLISH);
		try {
			newRoom = zone.getRoom (monikerPrefix + "~"
					+ String.valueOf (roomNumber));
			return newRoom;
		} catch (final NotFoundException e) {
			// expected: continue.
		}
		try {
			newRoom = Room.initInstanceRoom (
					zone,
					zone.getRoom ("userRoom"
							+ (roomNumber == 0 ? "" : "~"
									+ roomNumber)),
					monikerPrefix, roomNumber);
		} catch (final NotFoundException e) {
			throw new NotReadyException (e);
		}
		newRoom.setRoomIndex (roomNumber);
		newRoom.setOwner (user);
		newRoom.getActiveDecorations ();
		newRoom.setFilename (newRoom.getVariable ("fl"));
  	    /* FIXME: Persephone bug: should not have to set the filename and floor both. */
		return newRoom;
	}
	
	/**
	 * @param newRoomMoniker The moniker of the room to be instantiated
	 * @return the room being instantiated from the database
	 * @throws NotFoundException if there is no room in the database
	 *              with the given moniker
	 * @deprecated you can use
	 *             {@link Nomenclator#getDataRecord(Class, String)}
	 *             now.
	 */
	@Deprecated
	static Room loadRoomFromDB (final String newRoomMoniker)
			throws NotFoundException {
		return Nomenclator.getDataRecord (Room.class, newRoomMoniker);
	}
	
	/**
	 * Create a totally blank, default room, and connect it to a Zone.
	 *
	 * @param homeZone the zone in which the room is created.
	 * @return the new public room
	 */
	public static Room newPublicRoom (final Zone homeZone) {
		Room r;
		try {
			r = Nomenclator.make (Room.class);
		} catch (final NotReadyException e) {
			throw BugReporter.getReporter("srv")
					.fatalBug (
							"Caught a NotReadyException in Room.newPublicRoom ",
							e); // ?
		}
		r.setLimbo (false);
		r.setZone (homeZone);
		r.setRoomIndex ( -1);
		r.setOwner (Nomenclator.getSystemUser ());
		return r;
	}
	
	/**
	 * Indicates if this room should automatically be created with a new zone
	 */
	private boolean autoCreate = false;
	
	/**
	 * Communications channel for the room
	 */
	private RoomChannel channel;
	
	/**
	 * Listeners for click event for this room
	 */
	private final transient ActionListenerSet <ActionClickHandler, ActionClick> clickHandlers =
			new ActionListenerSet <ActionClickHandler, ActionClick> ();
	
	/**
	 * Listeners for the room part handlers
	 */
	private final transient ActionListenerSet <ActionRoomPartHandler, ActionRoomPart> partHandlers =
			new ActionListenerSet <ActionRoomPartHandler, ActionRoomPart> ();
	
	/**
	 * Listeners for the room part handlers
	 */
	private final transient ActionListenerSet <ActionRoomJoinHandler, ActionRoomJoin> joinHandlers =
			new ActionListenerSet <ActionRoomJoinHandler, ActionRoomJoin> ();
	
	/**
	 * Listeners for the enter event area handlers
	 */
	final transient ActionListenerSet <ActionEventAreaEnterHandler, ActionEventAreaEnter> eventAreaEnterHandlers =
			new ActionListenerSet <ActionEventAreaEnterHandler, ActionEventAreaEnter> ();
	
	/**
	 * Listeners for the enter event area handlers
	 */
	final transient ActionListenerSet <ActionEventAreaExitHandler, ActionEventAreaExit> eventAreaExitHandlers =
			new ActionListenerSet <ActionEventAreaExitHandler, ActionEventAreaExit> ();
	
	/**
	 * All spaces that can fire off some kind of event, just not out
	 * places
	 */
	private transient final Map <String, Pair <String, Collection <GeneralPath>>> oldEventPlaces =
			new ConcurrentHashMap <String, Pair <String, Collection <GeneralPath>>> ();
	
	/**
	 * Places through which one can exit this room into another room
	 */
	private transient final Map <String, Pair <String, Polygon>> exitPlaces =
			new ConcurrentHashMap <String, Pair <String, Polygon>> ();
	
	/**
	 * Set of all event areas
	 */
	private transient final Map <String, EventPlace> eventPlaces = Collections
			.synchronizedMap (new HashMap <String, EventPlace> ());
	
	/**
	 * Set of all item points
	 */
	private transient final Map <String, ItemPlace> itemPlaces = Collections
			.synchronizedMap (new HashMap <String, ItemPlace> ());
	
	/**
	 * Set of all information points
	 */
	private transient final Map <String, PointPlace> pointPlaces = Collections
			.synchronizedMap (new HashMap <String, PointPlace> ());
	
	/**
	 * GameEvents attached to this room
	 */
	private final HashSet <GameRoom> gameRooms = new HashSet <GameRoom> ();
	
	/**
	 * <p>
	 * The owner of a room; usually null for public rooms, or non-null
	 * for users' houses.
	 * </p>
	 * <p>
	 * The special room variable homeOwner reflects
	 * </p>
	 */
	private AbstractUser homeOwner = Nomenclator.getSystemUser ();
	
	/**
	 * Determine whether this room is a limbo room
	 *
	 * @see Room#isLimbo() discussion of Limbo on Room.isLimbo ()
	 */
	private boolean iAmInLimbo = false;
	
	/**
	 * Every Room in a Zone gets an unique ID. If this is below
	 * STATIC_ROOM_FENCEPOST, then it's also the database ID.
	 */
	private int id = 0;
	
	/**
	 * The time at which the local lag was last recomputed (sec >
	 * epoch)
	 */
	private long lastLagComputed = 0;
	
	/**
	 * The local average lag
	 */
	private long localLagMax = 10;
	
	/**
	 * The moniker / unique identifier for this room.
	 */
	private String moniker = "";
	
	/**
	 * The unique ID number for this room (room number)
	 */
	protected int myID = 0;
	
	/**
	 * Individual obstacle spaces
	 */
	private final Map <String, Collection <GeneralPath>> obstacles =
			new ConcurrentHashMap <String, Collection <GeneralPath>> ();
	
	/**
	 * Owners of a room are permitted to alter it (to a degree).
	 */
	private final Collection <AbstractUser> owners = new ConcurrentSkipListSet <AbstractUser> ();
	
	/**
	 * When the room is a part of an user's house, which room index
	 * number is it?
	 */
	private int roomIndex;
	
	/**
	 * The set of variables set upon the room
	 */
	private RoomVar roomVariables;
	
	/**
	 * The set of variables set upon the room
	 */
	private RoomVar templateVariables;
	
	/**
	 * Whether the sky is visible in this room.
	 */
	private boolean skyVisible;
/**
	 * <p>
	 * Sounds that might be triggered in the room
	 * </p>
	 * XXX not used yet
	 */
	private final Collection <SoundPlayback> sounds = new ConcurrentSkipListSet <SoundPlayback> ();
			
	/**
	 * Tracks users inside of server event spaces
	 */
	private transient final Map <String, Pair <Collection <GeneralPath>, ConcurrentSkipListSet <AbstractUser>>> serverEvents =
			new ConcurrentHashMap <String, Pair <Collection <GeneralPath>, ConcurrentSkipListSet <AbstractUser>>> ();
	
	/**
	 * Whether this room is subject to weather (e.g. rain)
	 * <p>
	 * TODO: save to database
	 * </p>
	 */
	private boolean subjectToWeather = false;
	
	/**
	 * The user-visible title of this room
	 */
	private String title;
	
	/**
	 * Number of users permitted into this room before it refuses entry
	 * as being a full room; includes robots, ejectæ, and such.
	 */
	private int userLimit = Room.DEFAULT_USER_LIMIT;
	
	/**
	 * The list of all users in this room. These should maybe be weak
	 * references or something fancy, in future.
	 */
	private final ConcurrentSkipListSet <AbstractUser> userList = new ConcurrentSkipListSet <AbstractUser> ();
	
	/**
	 * Type of vehicle permissions to apply
	 */
	protected VehicleStyle vehicleStyle = VehicleStyle.ANY;
	
	/**
	 * XXX define this on the fly
	 */
	private Volume3D volume = new Volume3D (0, 0, 0, 799, 599, 0);
	
	/**
	 * the area in which a player could walk
	 */
	private GeneralPath walkableSpace = new GeneralPath ();
	
	/**
	 * Individual walkable spaces
	 */
	private final Map <String, Collection <GeneralPath>> walkSpaces =
			new ConcurrentHashMap <String, Collection <GeneralPath>> ();
	
	/**
	 * Rooms can be part of a World. This is largely unimplemented. XXX
	 * This will eventually be an object reference to a World or
	 * possibly a different name (Region? Area? Arrondissement?) for the
	 * same general concept.
	 */
	private String world = "";
	
	/**
	 * Coördinates of this Room within its containing World. The units
	 * are arbitrary…
	 */
	private Coord3D worldCoords = null;
	
	/**
	 * The zone in which this room exists
	 */
	private Zone zone = null;
	
	/**
	 * The base moniker all isntances of this room use
	 */
	private String baseMoniker;
	
	/**
	 * general constructor
	 *
	 * @param loader loader
	 */
	public Room (final RecordLoader <Room> loader) {
		super (loader);
		id = Room.nextID.getAndIncrement ();
		AppiusClaudiusCaecus.add (this);
	}
	
	/**
	 * general constructor for
	 * {@link Nomenclator#make(Class, Object...)}; the same as
	 * {@link #Room(RecordLoader)}
	 * 
	 * @param loader loader
	 * @param nada ignored
	 */
	public Room (final RecordLoader <Room> loader,
			final Object... nada) {
		this (loader);
	}
	
	/**
	 * @see org.starhope.appius.game.ChannelListener#acceptDatagram(org.starhope.appius.net.datagram.AbstractDatagram)
	 */
	@Override
	public void acceptDatagram (final AbstractDatagram datagram) {
		// No op
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param newListener WRITEME
	 * @return WRITEME
	 */
	public boolean add (final ChannelListener newListener) {
		return channel.join (newListener);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param thing WRITEME
	 * @return WRITEME
	 */
	public boolean add (final ExistsInWorld thing) {
		return contents.add (thing);
	}
	
	/**
	 * WRITEME.
	 *
	 * @param game WRITEME
	 */
	public void add (final GameRoom game) {
		gameRooms.add (game);
		add ((RoomListener) game);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param newListener WRITEME
	 * @return WRITEME
	 * @deprecated Use add(ChannelListener)
	 */
	@Deprecated
	public boolean add (final RoomListener newListener) {
		return channel.join (newListener);
	}
	
	/**
	 * Attempts to take an item from the user's inventory and adds it to the room if the user is also
	 * the owner of the room and has at least one of the given item in his/her inventory.
	 *
	 * @param u The user
	 * @param realItem The item to be added to the room
	 * @param location The location to add the item
	 * @param facing The optional facing for the object
	 * @return True if the addition succeeds, false otherwise
	 * @throws PrivilegeRequiredException The user is not the owner of the room
	 */
	public boolean addItemPlace (final AbstractUser u, final RealItem realItem, final Coord2D location,
			final String facing) throws PrivilegeRequiredException {
		if (u != getOwner ()) { throw new PrivilegeRequiredException (); }
		boolean result = false;
		
		if (u != null && realItem != null && location != null && u.getInventory ().getCount (realItem) > 0) {
			u.getInventory ().addItem (realItem, -1);
			// Create room var based off of parameters
			String itemCode = getNextItemCode ();
			final JSONObject varJsonObject = new JSONObject ();
			try {
				varJsonObject.put ("realID", realItem.getRealID ());
				final JSONArray locArray = new JSONArray ();
				locArray.put (location.getX ());
				locArray.put (location.getY ());
				varJsonObject.put ("loc", locArray);
				if (facing != null) {
					varJsonObject.put ("facing", facing);
				}
				varJsonObject.put ("type", "item");
			} catch (JSONException e) {
				Room.log.error ("Exception",e);
			}
			setVariable (itemCode, varJsonObject.toString (), true);
			result = true;
		}
		
		return result;
	}	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param newPlace WRITEME
	 * @return WRITEME
	 */
	public boolean add (final RoomPlace newPlace) {
		final boolean changed = places.add (newPlace);
		if (changed) {
			changed ();
		}
		return changed;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param newSound WRITEME
	 * @return WRITEME
	 */
	public boolean add (final SoundPlayback newSound) {
		return sounds.add (newSound);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param newOwner WRITEME
	 * @return WRITEME
	 */
	public boolean addOwner (final AbstractUser newOwner) {
		return owners.add (newOwner);
	}
	
	/**
	 * @param user who is there
	 * @param position where they are
	 */
	void areaEffects (final AbstractUser user, final Coord3D position) {
		// No op
	}
	
	/**
	 * @param command the command to be broadcast "from"
	 * @param results the JSON data attached
	 */
	public void broadcast (final String command,
			final JSONObject results) {
		if (iAmInLimbo) {
			return;
		}
		
		for (final AbstractUser viewer : getAllUsers ()) {
			if ( (viewer instanceof GeneralUser)
					&& ((GeneralUser) viewer).isOnline ()) {
				viewer.acceptSuccessReply (command, results, this);
			}
		}
		
	}
	
	/**
	 * @param u WRITEME
	 * @param target WRITEME
	 * @return WRITEME
	 */
	public boolean canWalk (final AbstractUser u, final Coord3D target) {
		// Default True until debugged!
		if (AppiusConfig.getConfigBoolOrTrue ("org.starhope.appius.room.canWalkEverywhere")
				&& !u.getAvatarLabel ().startsWith ("Catullus")) { return true; }
		
		return canWalk (u.getLocation (), target);
	}
	
	/**
	 * @param p coördinates
	 * @return true, only if the point exists in a walkable space (and
	 *         not an obstacle space)
	 */
	public boolean canWalk (final Coord3D p) {
		return getWalkableSpace ().contains (
				new Point2D.Double (p.getX (), p.getY ()));
	}
	
	/**
	 * determine whether a line leaves the walkable space at any time
	 *
	 * @param from start point
	 * @param to end point
	 * @return whether the path can be walked without truncation
	 */
	public boolean canWalk (final Coord3D from, final Coord3D to) {
		
		final Line2D path = new Line2D.Double (from.getX (),
				from.getY (), to.getX (), to.getY ());
		final GeneralPath space = getWalkableSpace ();
		if (canWalk (from)) {
			
			try {
				Geometry.getExitPoint (path, space);
			} catch (final NotFoundException e) {
				return true;
			}
			
			return false;
			
			// final PathIterator pi = space.getPathIterator (null);
			// final float [] last = { 0f, 0f };
			// final float [] first = { -1f, -1f };
			// while ( !pi.isDone ()) {
			// pi.next ();
			// final float [] coords = { 0f, 0f };
			// final int n = pi.currentSegment (coords);
			// switch (n) {
			// case PathIterator.SEG_MOVETO:
			// first [0] = coords [0];
			// first [1] = coords [1];
			// break;
			// case PathIterator.SEG_LINETO:
			// final Line2D edge = new Line2D.Double (
			// last [0], last [1], coords [0],
			// coords [1]);
			// if (edge.intersectsLine (path)) {
			// return false;
			// }
			// break;
			// case PathIterator.SEG_CLOSE:
			// final Line2D closingEdge = new Line2D.Double (
			// first [0], first [1], coords [0],
			// coords [1]);
			// if (closingEdge.intersectsLine (path)) {
			// return false;
			// }
			// break;
			// default:
			// // ignore
			// }
			// last [0] = coords [0];
			// last [1] = coords [1];
			// }
			// return true;
		}
		
		final Collection <Line2D> testing = new HashSet <Line2D> ();
		testing.add (new Line2D.Double (from.getX (), from.getY (),
				to.getX (), to.getY ()));
		boolean doOver = false;
		int tries = 20;
		do {
			doOver = false;
			final GeneralPath walkSpace = getWalkableSpace ();
			{
				final Iterator <Line2D> iter = testing.iterator ();
				while (iter.hasNext ()) {
					final Line2D testLine = iter.next ();
					Point2D exit;
					try {
						exit = Geometry.getExitPoint (testLine,
								walkSpace);
					} catch (final NotFoundException e) {
						exit = null;
					}
					if ( (null == exit)
							|| new Point2D.Double (0, 0)
									.equals (exit)) {
						if (walkSpace
								.contains (testLine.getP1 ())
								&& walkSpace.contains (testLine
										.getP2 ())) {
							return true;
						}
					} else {
						testing.remove (testLine);
						Line2D otherHalf = null;
						if (walkSpace
								.contains (testLine.getP1 ())) {
							otherHalf = new Line2D.Double (exit,
									testLine.getP2 ());
						} else if (walkSpace.contains (testLine
								.getP2 ())) {
							otherHalf = new Line2D.Double (exit,
									testLine.getP2 ());
						}
						if ( (null != otherHalf)
								&& ( (Math.abs (otherHalf
										.getX2 ()
										- otherHalf.getX1 ()) + Math
											.abs (otherHalf
													.getY2 ()
													- otherHalf
															.getY1 ())) >= 2)) {
							testing.add (otherHalf);
							doOver = true;
						}
					}
				}
			}
		} while (doOver && (tries-- > 0));
		if (tries <= 0) {
			BugReporter.getReporter ("srv").reportBug (
					String.format (
							"maxTries exceeded for %s-%s in %s",
							from.toString (), to.toString (),
							moniker));
		}
		return testing.size () == 0;
		
	}
	
	/**
	 * WRITEME.
	 *
	 * @param thing WRITEME
	 * @return WRITEME
	 */
	public boolean contains (final AbstractUser thing) {
		if (thing instanceof GeneralUser) {
			return userList
					.contains (Integer
							.valueOf ( ((GeneralUser) thing)
									.getUserID ()));
		}
		return false;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param thing WRITEME
	 * @return WRITEME
	 */
	public boolean contains (final ExistsInWorld thing) {
		return contents.contains (thing);
	}
	
	/**
	 * @see org.starhope.catullus.Copyable#copyProtoype(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public Room copyProtoype (final Room p) {
		final Room r = new Room (new NullLoader <Room> (Room.class));
		r.markForReload ();
		for (final Map.Entry <String, String> var : p.getVariables ()
				.entrySet ()) {
			r.setVariable (var);
		}
		r.setFilename (p.getFilename ());
		r.setLimbo (p.isLimbo ());
		r.setMoniker (p.getMoniker ());
		r.setMusic (p.getMusic ());
		r.setOverlay (p.getOverlay ());
		r.baseMoniker = p.baseMoniker;
		r.setOwner (p.getOwner ());
		r.setRoomIndex (p.getRoomIndex ());
		r.setSky (p.getSky ());
		r.setSkyVisible (p.isSkyVisible ());
		r.setSubjectToWeather (p.isSubjectToWeather ());
		r.setTitle (p.getTitle ());
		r.setUserLimit (p.getUserLimit ());
		r.setVehicleRulesForRoom (p.getVehicleRulesForRoom ());
		r.setVolume (p.getVolume ());
		r.setZone (p.getZone ());
		for (final GameRoom ev : p.getGameEvents ()) {
			r.add (ev);
		}
		return r;
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#deleteVariable(java.lang.String)
	 */
	@Override
	public void deleteVariable (final String key) {
		deleteVariable (key, false);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param key WRITEME  ewinkelman 
	 * @param flushToDatabase WRITEME  ewinkelman 
	 */
	private void deleteVariable (final String key, final boolean flushToDatabase) {
		setVariable (key, "", flushToDatabase);
	}
	
	/**
	 * Destroy this room.
	 *
	 * @see org.starhope.appius.game.rooms.Room#destroySelf()
	 */
	public void destroySelf () {
		roomVariables.clear ();
		templateVariables.clear();
		gameRooms.clear ();
		homeOwner = null;
		iAmInLimbo = true;
		moniker = "";
		myID = -1;
		channel.destroy ();
		roomIndex = -1;
		skyVisible = false;
		title = "Destroyed Room";
		userList.clear ();
		zone = null;
		AutomaticDoor.unregisterListeners (this);
		AppiusClaudiusCaecus.remove (this);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private void detectSounds () {
		// final Set <String> sounds = new HashSet <String> ();
		for (final Entry <String, String> entry : roomVariables
				.entrySet ()) {
			final String value = entry.getValue ();
			if (value.indexOf (' ') > -1) {
				continue;
			}
			if (entry.getKey ().startsWith ("zone")
					&& value.startsWith ("evt_$door")
					&& value.contains ("/")) {
				sounds.add (new SoundPlayback (value.substring (
						value.indexOf ('/') + 1,
						value.indexOf (':'))));
			}
		}
		final StringBuilder soundsBuilder = new StringBuilder ();
		final Iterator <SoundPlayback> i = sounds.iterator ();
		while (i.hasNext ()) {
			soundsBuilder.append (i.next ().toString ());
			if (i.hasNext ()) {
				soundsBuilder.append (':');
			}
		}
		// strip off the final ':'
		// setVariable ("sounds", soundsBuilder.length () == 0 ? ""
		// : soundsBuilder.substring (0,
		// soundsBuilder.length () - 1));
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param user the user whose vehicles may need to be disabled
	 */
	private void disableVehiclesIfNecessary (final AbstractUser user) {
		Collection <InventoryItem> activeVehicles;
		try {
			activeVehicles = user.getInventory ()
					.getActiveItemsByType (
							Nomenclator.getDataRecord (
									InventoryItemType.class,
									"Vehicle"));
			for (final InventoryItem vehicle : activeVehicles) {
				boolean allow = true;
				ItemEffects itemEffects;
				try {
					itemEffects = vehicle.getItemEffects ();
					if (itemEffects.considerAsVehicle ()) {
						if (itemEffects.isWheeledVehicle ()
								&& !vehicleStyle
										.isPermitWheeled ()) {
							allow = false;
						}
						if (itemEffects.isMountedAnimal ()
								&& !vehicleStyle
										.isPermitMounts ()) {
							allow = false;
						}
						if (itemEffects.isFloatingVehicle ()
								&& !vehicleStyle
										.isPermitFloating ()) {
							allow = false;
						}
						if (allow) {
							UserTransients.getEffects (user).removeItems
									.remove (vehicle);
						} else {
							UserTransients.getEffects (user).removeItems
									.add (vehicle);
						}
					}
				} catch (final NotFoundException e) {
					// no ItemEffects, so item doesn't influence us
				}
				
			}
		} catch (final NotFoundException e1) {
			// Game does not support a vehicle slot, so we don't
			// care.
		}
	}
	
	/**
	 * WRITEME.
	 * 
	 * @see org.starhope.appius.game.Room#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) { return true; }
		if (obj == null) { return false; }
		if ( ! (obj instanceof Room)) { return false; }
		Room other = (Room) obj;
		if (id != other.id) { return false; }
		return true;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param space WRITEME
	 * @return WRITEME
	 */
	public Coord3D findPointWithin (final GeneralPath space) {
		if (iAmInLimbo) {
			return null;
		}
		final Rectangle bounds = space.getBounds ();
		for (int i = 0; i < 10; ++i) {
			final double x = AppiusConfig.getRandomInt (bounds.x,
					bounds.x + bounds.width);
			final double y = AppiusConfig.getRandomInt (bounds.y,
					bounds.y + bounds.height);
			if (space.contains (x, y)) {
				return new Coord3D (x, y, 0);
			}
		}
		if (space.contains (bounds.x + (bounds.width / 2), bounds.y
				+ (bounds.height / 2))) {
			return new Coord3D (bounds.x + (bounds.width / 2),
					bounds.y + (bounds.height / 2), 0);
		}
		BugReporter.getReporter ("srv").reportBug (
				"having a hard time finding someplace to spawn in "
						+ moniker);
		return null;
	}
	
	/**
	 * <p>
	 * Find a spawn (entry) point in this room for an user joining from
	 * the given old room. Will fall back to a default out Place or the
	 * entire walk space, if necessary.
	 * </p>
	 * <p>
	 * Now, also ensures that the point is within walkable space.
	 * </p>
	 * <p>
	 * XXX: handle edge-of-screen vertical/horizontal alignments better
	 * someday
	 * </p>
	 *
	 * @param oldRoom The room from which someone is joining
	 * @return the coördinates at which the user should initially
	 *         appear.
	 */
	private Coord3D findSpawnPointFrom (final String oldRoom) {
		final String oldMoniker = null == oldRoom ? "nowhere"
				: oldRoom;
		String fallback = "";
		for (final String field : getPlaceStrings ()) {
			if (field.startsWith ("out_")) {
				if (field.substring (4).startsWith (oldMoniker)) {
					final Coord3D p = findSpawnPointWithin (Geometry
							.stringToGeneralPathSet (field
									.split (Pattern
											.quote (":")) [1]));
					if (getWalkableSpace ().contains (p.getX (),
							p.getY ())) {
						return p;
					}
				} else if (':' == field.charAt (4)) {
					fallback = field.substring (5);
				}
			}
		}
		if (fallback.length () > 0) {
			final Coord3D p = findSpawnPointWithin (Geometry
					.stringToGeneralPathSet (fallback));
			if (getWalkableSpace ().contains (p.getX (), p.getY ())) {
				return p;
			}
		}
		// AppiusClaudiusCaecus.reportDesignBug ("No out place from "
		// + oldMoniker + " into " + moniker
		// + " and no default out place");
		return findSpawnPointWithin (getWalkableSpace ());
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param walkableSpaces2 WRITEME
	 * @return WRITMEE
	 */
	Coord3D findSpawnPointWithin (
			final Collection <GeneralPath> walkableSpaces2) {
		Coord3D trying = null;
		while (null == trying) {
			final Collection <GeneralPath> spaces = walkableSpaces2;
			if (spaces.size () == 0) {
				AppiusClaudiusCaecus
						.reportDesignBug ("No spaces in which I can spawn in "
								+ moniker);
				spaces.add (getWalkableSpace ());
			}
			int skip = AppiusConfig.getRandomInt (0,
					spaces.size () - 1);
			final Iterator <GeneralPath> picker = spaces.iterator ();
			while (skip-- > 0) {
				picker.next ();
			}
			trying = findSpawnPointWithin (picker.next ());
		}
		return trying;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param space WRITEME
	 * @return WRITEME
	 */
	Coord3D findSpawnPointWithin (final GeneralPath space) {
		final Coord3D point = findPointWithin (space);
		return point;
	}
	
	/**
	 * WRITEME.
	 *
	 * @return WRITEME
	 */
	public Collection <AbstractUser> getAllUsers () {
		final HashSet <AbstractUser> users = new HashSet <AbstractUser> ();
		users.addAll (userList);
		return users;
	}
	
	/**
	 * WRITEME.
	 *
	 * @return WRITEME
	 */
	public String getBaseMoniker () {
		return baseMoniker;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return getID ();
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () {
		if (null == moniker) {
			moniker = "#" + getID ();
		}
		return moniker + "@"
				+ (null == zone ? "null" : zone.getName ());
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public Collection <ExistsInWorld> getContents () {
		return new HashSet <ExistsInWorld> (contents);
	}
	
	/**
	 * WRITEME.
	 *
	 * @return a string giving the room moniker and zone name in
	 *         human-readable form
	 */
	public String getDebugName () {
		if (null == zone) {
			return "Abstract Room “" + getMoniker () + "”";
		}
		return "Room “" + getMoniker () + "” in Zone “"
				+ zone.getName () + "”";
	}
	
	/**
	 * @return all spaces that can cause an event to fire off
	 */
	public Map <String, Collection <GeneralPath>> getEventSpaces () {
		final Map <String, Collection <GeneralPath>> set = new HashMap <String, Collection <GeneralPath>> ();
		for (final Pair <String, Collection <GeneralPath>> spaces : eventPlaces
				.values ()) {
			set.put (spaces.head (), spaces.tail ());
		}
		return set;
	}
	
	/**
	 * Get all users in the room.
	 *
	 * @return All users in the room
	 */
	private Set <AbstractUser> getEverythingInRoom () {
		final HashSet <AbstractUser> stuff = new HashSet <AbstractUser> ();
		stuff.addAll (userList);
		return stuff;
	}
	
	/**
	 * @return all exits
	 */
	public Map <String, Pair <String, Polygon>> getExits () {
		return exitPlaces; // TODO: not the real one, a copy!
	}
	
	/**
	 * Find a place in the room which exits to a certain other room's
	 * moniker
	 *
	 * @param roomToward the room name
	 * @return the exit place going there
	 * @throws NotFoundException if there's no exit to that destination
	 */
	public Polygon getExitTo (final String roomToward)
			throws NotFoundException {
		for (final Pair <String, Polygon> exit : getExits ()
				.values ()) {
			if (exit.head ().equals (roomToward)) {
				return exit.tail ();
			}
		}
		throw new NotFoundException (roomToward);
	}
	
	/**
	 * WRITEME.
	 * 
	 * @return the floor/filename base graphic
	 */
	public String getFilename () {
		return getVariable ("f");
	}
	
	/**
	 * WRITEME: Document this method brpocock
	 * 
	 * @return WRITEME  ewinkelman 
	 */
	public String getFullMoniker () {
		return moniker;
	}
	
	/**
	 * @param string WRITEME
	 * @return WRITEME
	 */
	@SuppressWarnings ("unchecked")
	public GameBase getGameEvent (final String string) {
		try {
			final Class <? extends GameBase> klass = (Class <? extends GameBase>) Class.forName (string);
			for (final GameBase ev : gameRooms) {
				if (klass.isInstance (ev)) { return ev; }
			}
		} catch (final Throwable e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
		return null;
	}
	
	/**
	 * WRITEME.
	 *
	 * @return WRITEME
	 */
	public Collection <GameRoom> getGameEvents () {
		return new HashSet <GameRoom> (gameRooms);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return id
	 */
	
	public int getID () {
		return id;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public synchronized long getLag () {
		if (lastLagComputed < (System.currentTimeMillis () - AppiusConfig
				.getIntOrDefault (
						"org.starhope.appius.game.lagComputeInterval",
						10000))) {
			recomputeLag ();
		}
		return localLagMax;
	}
	
	/**
	 * WRITEME.
	 *
	 * @return WRITEME
	 */
	@Deprecated
	public Collection <RoomListener> getListeners () {
		return channel.getAllListeners ();
	}
	
	/**
	 * The maximum number of users permitted in a room is currently a
	 * per-Zone setting, see {@link Zone#getRoomMaxUsers()}, however it
	 * could be overridden for special-case rooms.
	 *
	 * @return the maximum number of users permitted in this room
	 */
	public int getMaxUsers () {
		return zone.getRoomMaxUsers ();
	}
	
	/**
	 * @return the max X
     * @deprecated, see #getVolume()
	 */ @Deprecated
	public int getMaxX () {
		return getVolume().getMaxX();
	}
	
	/**
	 * @return the max Y
     * @deprecated, see #getVolume()
	 */ @Deprecated
	public int getMaxY () {
		return getVolume().getMaxY();
	}
	
	/**
	 * @return the max Z
     * @deprecated, see #getVolume()
	 */ @Deprecated
	public int getMaxZ () {
		return getVolume().getMaxZ();
	}
	
	/**
	 * @return the min X
     * @deprecated, see #getVolume()
	 */ @Deprecated
	public int getMinX () {
		return getVolume().getMinX();
	}
	
	/**
	 * @return the min Y
     * @deprecated, see #getVolume()
	 */ @Deprecated
	public int getMinY () {
		return getVolume().getMinY();
	}
	
	/**
	 * @return the min Z
     * @deprecated, see #getVolume()
	 */ @Deprecated
	public int getMinZ () {
		return getVolume().getMinZ();
	}
	
	/**
	 * WRITEME.
	 * 
	 * @return WRITEME
	 */
	public String getMoniker () {
		return moniker;
	}
	
	/**
	 * WRITEME.
	 * 
	 * @return WRITEME
	 */
	public String getMusic () {
		return getVariable ("m");
	}
	
	/**
	 * WRITEME.
	 *
	 * @return WRITEME
	 */
	@Override
	public String getName () {
		return getFullMoniker ();
	}
	
	/**
	 * Gets the next item code available for this room
	 *
	 * @return WRITEME  ewinkelman 
	 */
	private String getNextItemCode () {
		int nextCodeNum = 0;
		
		for (String varName : getVariables ().keySet ()) {
			if ( !varName.startsWith ("item")) {
				continue;
			}
			final String itemPart = varName.length () > 4 ? varName.substring (4) : "";
			int num = nextCodeNum;
			try {
				num = Integer.valueOf (itemPart).intValue ();
			} catch (NumberFormatException e) {
				continue;
			}
			if (num > nextCodeNum) {
				nextCodeNum = num;
			}
		}
		
		return "item" + (nextCodeNum + 1);
	}
	
	/**
	 * WRITEME.
	 * 
	 * @return the overlay / weather — contents of the “w” room
	 *         variable
	 */
	
	public String getOverlay () {
		return getVariable ("w");
	}
	
	/**
	 * @return the owner of the room (if any; can be null, indicating a
	 *         public room)
	 */
	public AbstractUser getOwner () {
		return homeOwner;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return owners
	 */
	public Collection <AbstractUser> getOwners () {
		return new HashSet <AbstractUser> (owners);
	}
	
	/**
	 * @param name A Place name
	 * @return the Place in this room with that name
	 * @throws NotFoundException if no Place has that name
	 */
	public RoomPlace getPlace (final String name)
			throws NotFoundException {
		for (final RoomPlace place : places) {
			if (name.equals (place.getName ())) {
				return place;
			}
		}
		throw new NotFoundException (name);
	}
	
	/**
	 * @return an available item tag
	 */
	public String getPlaceItemNumber () {
		int i = 0x100;
		for (; roomVariables.exists ("item" + i) || templateVariables.exists ("item" + 1); ++i) {
			/* no op */
		}
		return "item" + i;
	}
	
	/**
	 * @param type any RoomPlaceType
	 * @return all Places of that type in this Room
	 */
	public Set <RoomPlace> getPlacesByType (final RoomPlaceType type) {
		// TODO
		BugReporter.getReporter ("srv").reportBug ("unimplemented");
		return new HashSet <RoomPlace> ();
	}
	
	/**
	 * @param type any RoomPlaceType
	 * @param point a point in the room
	 * @return all Places in the Room, of the given type, which contain
	 *         that point
	 */
	public Set <RoomPlace> getPlacesByTypeIncluding (
			final RoomPlaceType type, final Coord3D point) {
		// TODO
		BugReporter.getReporter ("srv").reportBug ("unimplemented");
		return new HashSet <RoomPlace> ();
	}
	
	/**
	 * @param type any RoomPlaceType
	 * @param shape a shape…
	 * @return all Places in the Room, of the given type, which
	 *         intersect that shape
	 */
	public Set <RoomPlace> getPlacesByTypeIncluding (
			final RoomPlaceType type, final Polygon shape) {
		// TODO
		BugReporter.getReporter ("srv").reportBug ("unimplemented");
		return new HashSet <RoomPlace> ();
	}
	
	/**
	 * @param point a point in the Room
	 * @return all Places in the Room which include that point
	 */
	public Set <RoomPlace> getPlacesIncluding (final Coord3D point) {
		// TODO
		BugReporter.getReporter ("srv").reportBug ("unimplemented");
		return new HashSet <RoomPlace> ();
	}
	
	/**
	 * @param shape any shape
	 * @return all Places in the Room which intersect that shape
	 */
	public Set <RoomPlace> getPlacesIncluding (final Polygon shape) {
		// TODO
		BugReporter.getReporter ("srv").reportBug ("unimplemented");
		return new HashSet <RoomPlace> ();
	}
	
	/**
	 * @param spaceName the name of a space, e.g. "evt_$field"
	 * @return the definition string of that space
	 */
	public String getPlaceStringByName (final String spaceName) {
		for (final String place : getPlaceStrings ()) {
			if (place.startsWith (spaceName + ":")) {
				return place.substring (spaceName.length () + 1);
			}
		}
		return "";
	}
	
	/**
	 * @return all Place strings in the Room
	 */
	public Collection <String> getPlaceStrings () {
		final Collection <String> results = new HashSet <String> ();
		for (final Entry <String, String> entry : getVariables ().entrySet ()) {
			if (entry.getKey ().startsWith ("zone")) {
				results.add (entry.getValue ());
			}
		}
		return results;
	}
	
	/**
	 * @return an available placement tag
	 */
	public String getPlaceZoneNumber () {
		int i = 0x100;
		for (; roomVariables.exists ("zone" + i) || templateVariables.exists ("zone" + i); ++i) {/* no op */
		}
		return "zone" + i;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param pointGroup WRITEME  ewinkelman 
	 */
	public List <PointPlace> getPoints (final String pointGroup) {
		final LinkedList <PointPlace> result = new LinkedList <PointPlace> ();
		
		for (PointPlace pointPlace : pointPlaces.values ()) {
			if (pointPlace.group.startsWith (pointGroup)) {
				result.add (pointPlace);
			}
		}
		
		return result;
	}
	
	/**
	 * Returns the channel for this room
	 *
	 * @return the room's default channel
	 */
	public RoomChannel getRoomChannel () {
		return channel;
	}
	
	/**
	 * <p>
	 * Room indices are unique within somewhat arbitrary contexts.
	 * </p>
	 * <p>
	 * Instanced rooms for minigames have unique indices within the set
	 * of all rooms for that minigame.
	 * </p>
	 * <p>
	 * Instanced rooms for an user's house have unique indices within
	 * one user's house.
	 * </p>
	 * <p>
	 * Public rooms drawn from the database have their database ID as
	 * their index.
	 * </p>
	 * 
	 * @return the index of the room within its containing context
	 * @see org.starhope.appius.game.Room#getRoomIndex()
	 */
	public int getRoomIndex () {
		return roomIndex;
	}
	
	/**
	 * get the JSON sequence to be passed to an user upon successfully
	 * joining a room (the “joinOK” message)
	 *
	 * @param user The user to whom the XML will be sent
	 * @return a string suitable for return to the user
	 */
	public JSONObject getRoomJoinJSON (final AbstractUser user) {
		final JSONObject reply = new JSONObject ();
		try {
			reply.put ("from", "roomJoin");
			reply.put ("status", "true");
			reply.put ("roomNumber", getID ());
			reply.put ("moniker", getMoniker ());
			reply.put ("limbo", isLimbo ());
			reply.put ("maxUsers", getMaxUsers ());
			
			
			final JSONObject users = new JSONObject ();
			if (isLimbo ()) {
				users.put (String.valueOf (user.getUserID ()),
						user.getPublicInfo ());
			} else {
				for (final AbstractUser who : getEverythingInRoom ()) {
					users.put (String.valueOf (who.getUserID ()),
							who.getPublicInfo ());
				}
			}
			reply.put ("users", users);
			
			final JSONObject vars = new JSONObject ();
			for (final Entry <String, String> var : getVariables ()
					.entrySet ()) {
				final String key = var.getKey ();
				final String value = var.getValue ();
				if ( ! (key.startsWith ("zone") && value
						.startsWith ("evt_$"))) {
					vars.put (key, value);
				}
			}
			if (homeOwner != null) {
				vars.put ("homeOwner", homeOwner.getAvatarLabel ());
			}
			reply.put ("vars", vars);
		} catch (final JSONException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a JSONException in getRoomJoinJSON",
							e);
		}
		
		return reply;
	}
	
	/**
	 * get the Smart Fox Server XML sequence to be passed to an user
	 * upon successfully joining a room (the “joinOK” message)
	 *
	 * @param user The user to whom the XML will be sent
	 * @return a string suitable for return to the user
	 */
	public String getRoomJoinSFSXML (final GeneralUser user) {
		final StringBuffer reply = new StringBuffer (
				"<msg t='sys'><body action='joinOK' r='" + getID ()
						+ "'><pid id='0'/>");
		
		if (isLimbo ()) {
			reply.append ("<vars></vars><uLs r='" + getID () + "'>");
			reply.append (user.toSFSXML ());
			reply.append ("</uLs>");
		} else {
			// Room Variables
			reply.append ("<vars>");
			for (final java.util.Map.Entry <String, String> var : getVariables ()
					.entrySet ()) {
				final String key = var.getKey ();
				final String value = var.getValue ();
				if ( ! (key.startsWith ("zone") && value
						.startsWith ("evt_$"))) {
					reply.append ("<var n='");
					reply.append (key);
					reply.append ("' t='s'><![CDATA[");
					reply.append (value);
					reply.append ("]]></var>");
				}
			}
			reply.append ("</vars>");
			
			// User List with user variables
			reply.append ("<uLs r='" + getID () + "'>");
			for (final AbstractUser u : getEverythingInRoom ()) {
				reply.append (u.toSFSXML ());
			}
			reply.append ("</uLs>");
			
		}
		
		reply.append ("</body></msg>");
		return reply.toString ();
	}
	
	/**
	 * @return the sky (ultimate background graphic layer, with no
	 *         parallax applied) for this room
	 * @see org.starhope.appius.game.Room#getSky()
	 */
	
	public String getSky () {
		return getVariable ("s");
	}
	
	/**
	 * @return all sounds which might be needed to play in this room
	 */
	public Collection <SoundPlayback> getSounds () {
		return new HashSet <SoundPlayback> (sounds);
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4663 $";
	}
	
	/**
	 * @return The user-visible title of this room
	 * @see org.starhope.appius.game.Room#getTitle()
	 */
	
	public String getTitle () {
		if ( (null == title) || (title.length () == 0)) {
			return "Someplace!";
		}
		return title;
	}
	
	/**
	 * get a packet describing the user's action state.
	 * 
	 * @param u the user
	 * @return JSON object describing user's action
	 */
	public JSONObject getUserAction_JSON (final AbstractUser u) {
		Geometry.updateUserPositioning (u);
		final JSONObject response = new JSONObject ();
		try {
			response.put ("who", u.getAvatarLabel ());
			response.put ("do", u.getCurrentAction ());
			final Coord3D location = u.getLocation ();
			response.put ("fX", (int) location.getX ());
			response.put ("fY", (int) location.getY ());
			response.put ("fZ", (int) location.getZ ());
			final Coord3D target = u.getTarget ();
			response.put ("tX", (int) target.getX ());
			response.put ("tY", (int) target.getY ());
			response.put ("tZ", (int) target.getZ ());
			response.put ("facing", u.getFacing ());
			response.put ("at", u.getTravelStart ());
			response.put ("rate", u.getTravelRate ());
			response.put ("from", "go");
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
		return response;
	}
	
	/**
	 * @return The number of users in this room. (Includes Ejectae!)
	 * @see org.starhope.appius.game.Room#getUserCount()
	 */
	
	public int getUserCount () {
		if (isLimbo ()) {
			return 1;
		}
		return userList.size ();
	}
	
	/**
	 * @return the roomUserLimit
	 */
	public int getUserLimit () {
		return userLimit;
	}
	
	/**
	 * WRITEME.
	 *
	 * @param string WRITEME.
	 * @return WRITEME.
	 * @see org.starhope.appius.game.Room#getVariable(java.lang.String)
	 */
	
	@Override
	public String getVariable (final String string) {
		final String var =
				roomVariables == null ? null : roomVariables.exists (string) ? roomVariables.getVariable (string)
						: templateVariables.getVariable (string);
				if (null == var) { return ""; }
				return var;
	}
	
	/**
	 * WRITEME.
	 *
	 * @return WRITEME.
	 * @see org.starhope.appius.game.Room#getVariables()
	 */
	
	@Override
	public HashMap <String, String> getVariables () {
		final HashMap <String, String> ret = new HashMap <String, String> ();
		ret.putAll (templateVariables.getVariables ());
		ret.putAll (roomVariables.getVariables ());
		return ret;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public JSONObject getVariables_JSON () {
		final JSONObject vars = new JSONObject ();
		for (final Map.Entry <String, String> entry : getVariables ().entrySet ()) {
			try {
				vars.put (entry.getKey (), entry.getValue ());
			} catch (final JSONException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a JSONException in Room.getVariables_JSON ",
								e);
			}
		}
		if (homeOwner != null) {
			try {
				vars.put ("homeOwner", homeOwner.getAvatarLabel ());
			} catch (JSONException e) {
				Room.log.error ("Exception",e);
			}
		}
		return vars;
	}
	
	/**
	 * @return the rules about allowing vehicles into the room
	 */
	public VehicleStyle getVehicleRulesForRoom () {
		return vehicleStyle;
	}
	
	/**
	 * @return the volume
	 */
	public Volume3D getVolume () {
		return volume;
	}
	
	/**
	 * @return all walkable space in the room
	 */
	public GeneralPath getWalkableSpace () {
		return walkableSpace;
	}
	
	/**
	 * Get the endpoint of a walk path from the source towards the
	 * target — clipped to the walkable space, if necessary.
	 *
	 * @param from source
	 * @param to target
	 * @return the last point to which one can walk along that line
	 * @throws NotFoundException if the source point isn't in a
	 *              walkable space, or something.
	 */
	public Coord3D getWalkLimit (final Coord3D from, final Coord3D to)
			throws NotFoundException {
		final Line2D path = new Line2D.Double (from.getX (),
				from.getY (), to.getX (), to.getY ());
		final GeneralPath space = getWalkableSpace ();
		if ( !canWalk (from)) {
			throw new NotFoundException ("Can't start from "
					+ from.toString ());
		}
		Point2D exit;
		try {
			exit = Geometry.getExitPoint (path, space);
		} catch (final NotFoundException e) {
			return to;
		}
		return new Coord3D (exit);
	}
	
	/**
	 * @return the world
	 */
	public String getWorld () {
		return world;
	}
	
	/**
	 * @return the worldCoords
	 */
	public Coord3D getWorldCoords () {
		return worldCoords;
	}
	
	/**
	 * WRITEME.
	 *
	 * @return the zone in which this room is found
	 */
	public Zone getZone () {
		return zone;
	}
	
	/**
	 * have a user walk (or dance, or whatever) to another location
	 * through walkable spaces
	 *
	 * @param u the user to move
	 * @param goal the target toward which to move
	 * @param facing force facing (or null to auto face)
	 * @param theVerb usually “Walk”
	 */
	public void goTo (final AbstractUser u, final Coord3D goal,
			final String facing, final String theVerb) {
		if (iAmInLimbo) {
			return;
		}
		
		final Coord3D currentPos = u.getLocation ();
		boolean itWorked = goTo_locked (u, goal, facing, theVerb, currentPos);
		if (itWorked) {
			areaEffects (u, u.getTarget ());
			notifyUserAction (u);
		} else {
			u.handleWalkFail (this, goal);
		}
		
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param u WRITEME
	 * @param tX WRITEME
	 * @param tY WRITEME
	 * @param tZ WRITEME
	 * @param facing WRITEME.
	 * @param verb WRITEME
	 */
	
	public void goTo (final AbstractUser u, final double tX, final double tY, final double tZ, final String facing,
			final String verb) {
		goTo (u, new Coord3D (tX, tY, tZ), facing, verb);
	}
	
	/**
	 * have a user walk (or something) toward a named region; typically
	 * for NPC:s
	 *
	 * @param u who
	 * @param placeName target place name
	 * @param verb means of locomotion, usually “Walk”
	 */
	public void goTo (final AbstractUser u, final String placeName,
			final String verb) {
		goTo (u,
				findPointWithin (Geometry
						.stringToGeneralPath (getPlaceStringByName (placeName))),
				null, verb);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param u WRITEME
	 * @param currentPos WRITEME
	 * @return WRITEME
	 */
	private Coord3D goTo_checkWalkSpace (final AbstractUser u,
			final Coord3D currentPos) {
		if ( !canWalk (u, currentPos)) {
			/* FIXME: Find out if we can “bump” the user a little to get
			 * them into the walkable space? */
			
			for (double th = 0; th < (2 * Math.PI); th += Math.PI / 4) {
				final Coord3D nudged = currentPos.add (
						Math.cos (th) * 5, Math.sin (th) * 5, 0);
				if (canWalk (nudged)) {
					u.setLocation (nudged);
					u.setTarget (nudged);
					return nudged;
				}
			}
			
			BugReporter
					.getReporter ("srv")
					.reportBug (
							String.format (
									"User coördinates not in nor near walkspace: %s in %s",
									currentPos.toString (),
									moniker));
			
			Coord3D spot = findSpawnPointWithin (getWalkableSpace ());
			if (null == spot) {
				spot = getVolume().getCenter();
				BugReporter.getReporter ("srv").reportBug (
						"Room placement fallback fucked in "
								+ moniker);
			}
			u.setLocation (spot);
			u.setTarget (spot);
			return spot;
		}
		return currentPos;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param u WRITEME
	 * @param to WRITEME
	 * @return WRITEME
	 */
	public Coord3D goTo_clipToWalkSpace (final AbstractUser u,
			final Coord3D to) {
		Point2D exit = null;
		try {
			exit = Geometry.getExitPoint (u, this, to.getX (),
					to.getY ());
		} catch (final GameLogicException e) {
			BugReporter.getReporter ("srv").reportBug (e);
			// u.unlockLocation ();
			// putHere (u, to);
			// return;
		}
		if (null == exit) {
			return null;
		}
		return new Coord3D (exit);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param u WRITEME
	 * @param facing WRITEME
	 * @param theVerb WRITEME
	 * @param to WRITEME
	 */
	private void goTo_core (final AbstractUser u, final String facing,
			final String theVerb, final Coord3D to) {
		final long when = getLag () + System.currentTimeMillis ();
		u.setTravelStart (when);
		u.setTarget (to);
		u.setStartT (when);
		if ( (null == facing) || "".equals (facing)) {
			setFacingFor (u);
		} else {
			u.setFacing (facing);
		}
		u.setCurrentAction (theVerb);
		final ADPUserAction adpUserAction = u.getUserActionDatagram (u);
		getRoomChannel ().broadcast (adpUserAction);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param u WRITEME
	 * @param goal WRITEME
	 * @param facing WRITEME
	 * @param theVerb WRITEME
	 * @param knownStartPos WRITEME
	 * @return true, on success; false, if the operation can't be
	 *         completed.
	 */
	boolean goTo_locked (final AbstractUser u, final Coord3D goal,
			final String facing, final String theVerb,
			final Coord3D knownStartPos) {
		Coord3D currentPos = new Coord3D (knownStartPos);
		if ( !goal.equals (currentPos)) {
			currentPos = goTo_checkWalkSpace (u, currentPos);
		}
		
		Coord3D to = new Coord3D (goal);
		if ( !canWalk (u, to)) {
			to = u.handleWalkFail (this, to);
			if (null == to) {
				final String noExit = String
						.format ("Can't find an exit from the current space towards %s",
								goal.toString ());
				BugReporter.getReporter ("srv").reportBug (noExit);
				return false;
			}
		}
		
		goTo_core (u, facing, theVerb, to);
		return true;
	}
	
	/**
	 * WRITEME.
	 * 
	 * @see org.starhope.appius.game.Room#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getCacheableIdent ());
	}
	
	/**
	 * <p>
	 * Instantiate a room based off a base room with an unique index
	 * (automatically generated) applied to the end of the moniker as a
	 * suffix.
	 * </p>
	 * <p>
	 * For purposes of multiplayer minigames, supply a base moniker for
	 * a boring (empty) room, supply the Zone in which the players are
	 * found, and then have the players join that new room. Minigame
	 * communications then continues as usual, using the
	 * {@link Commands#do_gameAction(JSONObject, AbstractUser, Room)}
	 * to echo the actions to the {@link GameEvent} monitoring the
	 * room.
	 * </p>
	 * <p>
	 * Note that this should be called <em>only</em> by the GameEvent
	 * populating the lobby room from which the instances are spawned!
	 * </p>
	 * 
	 * @return an instanced room off this base room
	 */
	public synchronized Room initInstanceRoom () {
		int instance = 0;
		while (zone.hasRoom (moniker + "~" + instance)) {
			++instance;
		}
		return Room.initInstanceRoom (zone, this, moniker, instance);
	}
	/**
	 * @return the autoCreate
	 */
	public boolean isAutoCreate () {
		return autoCreate;
	}
	
	/**
	 * WRITEME.
	 *
	 * @return WRITEME.
	 * @see org.starhope.appius.game.Room#isLimbo()
	 */
	public boolean isLimbo () {
		return iAmInLimbo;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param guy WRITEME
	 * @return WRITEME
	 */
	public boolean isOwner (final AbstractUser guy) {
		return owners.contains (guy);
	}
	
	/**
	 * WRITEME.
	 * 
	 * @return WRITEME
	 * @see org.starhope.appius.game.Room#isSkyVisible()
	 */
	
	public boolean isSkyVisible () {
		return skyVisible;
	}
	
	/**
	 * @return the subjectToWeather
	 */
	public boolean isSubjectToWeather () {
		return subjectToWeather;
	}
	
	/**
	 * @param thing WRITEME
	 * @see Room#join(RoomListener)
	 */
	
	public void join (final AbstractUser thing) {
		join (thing, "");
	}
	
	/**
	 * WRITEME.
	 * 
	 * @param thing who is joining the room
	 * @param from the prior room's moniker
	 */
	public void join (final AbstractUser user, final String from) {
		if (null == user) {
			return;
		}
		
		if ( ! (user instanceof Ejecta)) {
			validateUserList ();
			if (userList.size () > getMaxUsers ()) {
				int count = 0;
				for (final AbstractUser somebody : userList) {
					if ( ! (somebody instanceof Ejecta)) {
						++count;
					}
				}
				if (count > getMaxUsers ()) {
					user.acceptDatagram (new ADPError (user, "roomJoin", "Room Full", Codes.FULL));
					return;
				}
			}
			if (Boolean.parseBoolean (getVariable ("paidOnly")) && !user.isPaidMember ()) {
				user.acceptDatagram (new ADPError (user, "roomJoin", "Paid Only", Codes.PAIDONLY));
				return;
			}
			disableVehiclesIfNecessary (user);
		}
		/*
		 * Part old room
		 */
		final Room oldRoom = join_sendPartFromOldRoom (user);
		
		/*
		 * Effectively join new room … sort of
		 */
		user.setRoom (this);
		userList.add (user);
		channel.join (user, iAmInLimbo);
		
		if ( ! (user instanceof Ejecta)) {
			
			putHere (user, findSpawnPointFrom ( (null == from || "".equals (from)) && 
					null != oldRoom
					? oldRoom.baseMoniker
					: from));
			
			try {
				final ServerThread t = user.getServerThread ();
				if (null != t) {
					tellUserAboutRoom (user, t);
				}
			} catch (final UserDeadException e1) {
				// Nifty, he died. This is gonna go away quickly.
			}
		}
		
		userList.add (user);
		channel.join (user, iAmInLimbo);
		
		
		if (user instanceof User) {
			User u = (User) user;
			if (u.checkFirstTimeAndReset ()) {
	/* FIXME */
				channel.send (new ADPOverlayWindow (this, "nmTootTips_PU"), u);
			}
		}
		
		joinHandlers.fire (new ActionRoomJoin (this, user));
		
		final AbstractUser userForClosure = user;
		sendUserServerTime (userForClosure);
		Room.this.join_doWardrobeNotifications (userForClosure, oldRoom);
	}
	
	/**
	 * Do wardrobe notifications and position the player on room joins
	 * 
	 * @param user The user joining the room
	 * @param oldRoom The user's previous room (if given); if this is
	 *             supplied, use it to determine the “out_” place
	 */
	void join_doWardrobeNotifications (final AbstractUser user, final Room oldRoom) {
		if ( !iAmInLimbo) {
			if (null != user) {
				
				// real people (only) get wardrobe updates
				if ( !iAmInLimbo && null != user.getServerThread ()) {
					user.acceptDatagram (user.getDatagram (user));
				}
				
			}
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param user WRITEME
	 * @return WRITEME
	 */
	private Room join_sendPartFromOldRoom (final AbstractUser user) {
		Room oldRoom = null;
		if ( (null != user) && ! (user instanceof Ejecta)) {
			
			oldRoom = user.getRoom ();
			if (null != oldRoom) {
				oldRoom.part (user);
			}
		}
		return oldRoom;
	}
	
	/**
	 * Attempts to move an item in a room
	 *
	 * @param u The user
	 * @param itemCode The item to move
	 * @param location The location to add the item
	 * @param facing The optional facing for the object
	 * @return True if the move succeeds, false otherwise
	 * @throws PrivilegeRequiredException The user is not the owner of the room
	 */
	public boolean moveItemPlace (final AbstractUser u, final String itemCode, final Coord2D location,
			final String facing) throws PrivilegeRequiredException {
		boolean result = false;
		if (u != getOwner ()) { throw new PrivilegeRequiredException (); }
		
		if (itemCode != null && location != null) {
			final String value = getVariable (itemCode);
			if (value != null && value.startsWith ("{")) {
				try {
					final JSONObject valueJsonObject = new JSONObject (value);
					final JSONArray locArray = new JSONArray ();
					locArray.put (location.getX ());
					locArray.put (location.getY ());
					valueJsonObject.put ("loc", locArray);
					if (facing == null && valueJsonObject.has ("facing")) {
						valueJsonObject.remove ("facing");
					} else if (facing != null) {
						valueJsonObject.put ("facing", facing);
					}
					setVariable (itemCode, valueJsonObject.toString (), true);
				} catch (JSONException e) {
					Room.log.error ("Exception",e);
				}
			}
		}
		
		return result;
	}
	
	/**
	 * @param u the user of whose action everyone needs to be notified
	 */
	public void notifyUserAction (final AbstractUser u) {
		if (u.getLocation ().getZ () == Double.MAX_VALUE) {
			return;
		}
		channel.broadcastAcceptUserAction (u);
	}
	
	/**
	 * WRITEME.
	 *
	 * @param user WRITEME
	 * @see org.starhope.appius.game.rooms.Room#part(RoomListener)
	 */
	public void part (final AbstractUser user) {
		if (null == user) {
			BugReporter.getReporter ("srv").reportBug (
					"nobody leaving? then why call "
							+ getDebugName ());
		}
		if (null == zone) {
			BugReporter.getReporter ("srv").reportBug (
					"room " + getDebugName ()
							+ " is not in a zone?");
			return;
		}
		userList.remove (user);
	Quaestor.getDefault ().action (
				new Action (this, user, "part"));		user.setRoom (null);
		partHandlers.fire (new ActionRoomPart (this, user));
		if (channel != null && !iAmInLimbo) {
			channel.broadcast (new ADPRoomPart (user, this, user));
			channel.part (user);
		}
	}
	
	/**
	 * push this room to all zones
	 */
	
	public void pushToAllZones () {
		for (final Zone z : AppiusClaudiusCaecus.getAllZones ()) {
			pushToZone (z);
		}
	}
	
	/**
	 * <p>
	 * Copy the room's variable set to another room with an identical
	 * moniker in a different zone. If there is no existing room by the
	 * same moniker, then create one.
	 * </p>
	 * 
	 * @param z the zone targeted
	 */
	
	public void pushToZone (final Zone z) {
		if (zone.equals (z)) {
			return;
		}
		Room otherSelf;
		try {
			otherSelf = z.getRoom (getMoniker ());
		} catch (final NotFoundException e1) {
			try {
				otherSelf = Room.loadRoomFromDB (getMoniker (), z);
			} catch (final NotFoundException e) {
				otherSelf = Room
						.createPublicRoom (getMoniker (), z);
				otherSelf.setMoniker (getMoniker ());
				otherSelf.setLimbo (isLimbo ());
				otherSelf.setOwner (getOwner ());
				otherSelf.setSkyVisible (isSkyVisible ());
				otherSelf.setTitle (getTitle ());
				otherSelf.setRoomIndex (getRoomIndex ());
			}
		}
		otherSelf.resetVariables (roomVariables);
	}
	
	/**
	 * @param user the user to be put down
	 * @param position the place to be put at
	 */
	
	public void putHere (final AbstractUser user, final Coord3D position) {
		if (null == position) { return; }
		user.setLocation (position);
		user.setTarget (position);
		final long now = System.currentTimeMillis ();
		user.setTravelStart (now);
		user.setStartT (now);
		user.setCurrentAction ("idle");
		notifyUserAction (user);
		areaEffects (user, position);
	}
	
	/**
	 * Recompute the average local lag by taking all samples within the
	 * population distribution of the mean of all lag times for users
	 * in the room, and taking the highest lag time of that range
	 */
	synchronized void recomputeLag () {
		final Set <Long> lags = new HashSet <Long> ();
		long sum = 0;
		for (final AbstractUser who : getAllUsers ()) {
			final long whoLag = who.getLag ();
			if (whoLag < 500) { // cap max lag at .5 sec
				lags.add (Long.valueOf (whoLag));
				sum += whoLag;
			}
		}
		if (0 == sum) {
			localLagMax = 30;
			return;
		}
		final double mean = (double) sum / lags.size ();
		final double popDist = Math.sqrt (mean);
		long nextLagMax = 0;
		for (final Long lag : lags) {
			final long longLag = lag.longValue ();
			if ( (longLag < (mean + popDist))
					&& (longLag > localLagMax)) {
				nextLagMax = longLag;
			}
		}
		localLagMax = Math.min (nextLagMax, 30);
		lastLagComputed = System.currentTimeMillis ();
	}
	
	/**
	 * Reloads the room variables from the database
	 */
	public void reloadVars () {
		templateVariables.deleteAll ();
		templateVariables.refresh ();
		roomVariables.refresh ();
		setRoomVars ();
		if (channel != null) {
			ADPRoomVar adp = new ADPRoomVar (this, getID ());
			for (Entry <String, String> entry : getVariables ().entrySet ()) {
				adp.add (entry.getKey (), entry.getValue ());
			}
			adp.echoClient (true);
			channel.broadcast (adp);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param oldListener WRITEME
	 * @return WRITEME
	 */
	public boolean remove (final ChannelListener oldListener) {
		return channel.join (oldListener);
	}
	
	/**
	 * Remove a GameEvent from receiving events in this room.
	 *
	 * @param thatEvent the event to be removed
	 */
	public void remove (final GameRoom thatEvent) {
		gameRooms.remove (thatEvent);
		remove ((RoomListener) thatEvent);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param oldListener WRITEME
	 * @return WRITEME
	 * @deprecated Use remove(ChannelListener)
	 */
	@Deprecated
	public boolean remove (final RoomListener oldListener) {
		return channel.join (oldListener);
	}
	
	/**
	 * Removes an item from the room and places it back into the user's inventory assuming that the user is the owner of
	 * the room
	 *
	 * @param u The user performing the operation
	 * @param itemCode The item code for the item to be removed
	 * @return True if the item was removed, false otherwise
	 * @throws PrivilegeRequiredException
	 */
	public boolean removeItemPlace (final AbstractUser u, final String itemCode) throws PrivilegeRequiredException {
		if (u != getOwner ()) { throw new PrivilegeRequiredException (); }
		boolean result = false;
		
		if (u != null && itemCode.startsWith ("item")) {
			final String value = getVariable (itemCode);
			if (value.startsWith ("{")) {
				try {
					final JSONObject itemJsonObject = new JSONObject (value);
					final RealItem realItem =
							itemJsonObject.has ("realID") ? Nomenclator.getDataRecord (RealItem.class,
									itemJsonObject.getInt ("realID")) : null;
							u.getInventory ().addItem (realItem, 1);
							deleteVariable (itemCode, true);
				} catch (JSONException e) {
					Room.log.error ("Exception",e);
				} catch (NotFoundException e) {
					Room.log.error ("Exception",e);
				}
			}
		}
		
		return result;
	}	
	/**
	 * Remove a Place from the room
	 * 
	 * @param oldPlace the place to be removed
	 * @return whether the room changed as a result (if false, the
	 *         Place was already not in the Room )
	 */
	public boolean remove (final RoomPlace oldPlace) {
		final boolean changed = places.remove (oldPlace);
		if (changed) {
			changed ();
		}
		return changed;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param oldSound WRITEME
	 * @return WRITEME
	 */
	public boolean remove (final SoundPlayback oldSound) {
		return sounds.remove (oldSound);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public void removeDoneSounds () {
		for (final SoundPlayback sound : sounds) {
			if (sound.isDone ()) {
				sounds.remove (sound);
			}
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param exOwner WRITEME
	 * @return WRITEME
	 */
	public boolean removeOwner (final AbstractUser exOwner) {
		return owners.remove (exOwner);
	}
	
	/**
	 * remove a variable
	 * 
	 * @param varName the variable's name
	 */
	protected void removeVariable (final String varName) {
		roomVariables.remove (varName);
	}
	
	/**
	 * replace the current set of room variables with a different set
	 *
	 * @param vars a new set of variables
	 */
	
	@Override
	public synchronized void resetVariables (final Map <String, String> vars) {
		roomVariables.clear();
		if (iAmInLimbo) { return; }
		setVariables (vars);
	}
	
	/**
	 * @see org.starhope.appius.game.Room#saveRoomVars()
	 */
	
	public void saveRoomVars () {
		Connection con = null;
		PreparedStatement st = null;
		
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("INSERT INTO roomVars (room, keyName, value) VALUES (?,?,?) ON DUPLICATE KEY UPDATE value=?");
			st.setString (1, getMoniker ());
			for (final Entry <String, String> e : getVariables ()
					.entrySet ()) {
				st.setString (2, e.getKey ());
				final String value = e.getValue ();
				st.setString (3, value);
				st.setString (4, value);
				try {
					st.executeUpdate ();
				} catch (final SQLException e2) {
					BugReporter.getReporter ("srv").reportBug (
							"Caught a SQLException in Room.saveRoomVars on "
									+ e.getKey (), e2);
				}
			}
		} catch (final SQLException e1) {
			BugReporter.getReporter ("srv").reportBug (
					"Caught a SQLException in Room.saveRoomVars ",
					e1);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}
	
	/**
	 * WRITEME.
	 *
	 * @param from WRITEME
	 * @param data WRITEME
	 * @throws JSONException WRITEME
	 * @see org.starhope.appius.game.Room#sendGameAction(AbstractUser,
	 *      org.json.JSONObject)
	 */
	
	public void sendGameAction (final AbstractUser from,
			final JSONObject data) throws JSONException {
		data.put ("fromUser", data.getString ("from"));
		data.put ("from", "gameAction");
		channel.broadcastAcceptGameAction (from, data);
	}
	
	/**
	 * WRITEME.
	 *
	 * @param from WRITEME
	 * @param speech WRITEME
	 * @see org.starhope.appius.game.Room#sendPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	
	public void sendPublicMessage (final AbstractUser from,
			final String speech) {
		if (iAmInLimbo) {
			return;
		}
		
		for (final AbstractUser u : userList) {
			u.acceptPublicMessage (from, speech);
		}
		for (final GameRoom gameRoom : gameRooms) {
			gameRoom.acceptPublicMessage (from, speech);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param user WRITEME
	 */
	void sendUserServerTime (final AbstractUser user) {
		final JSONObject serverTime = new JSONObject ();
		if (user instanceof User) {
			try {
				serverTime.put ("serverTime",
						System.currentTimeMillis ());
				user.acceptSuccessReply ("serverTime", serverTime,
						this);
			} catch (final JSONException e) {
				BugReporter.getReporter ("srv").reportBug (e);
			}
		}
	}
	
	/**
	 * @param autoCreate the autoCreate to set
	 */
	public void setAutoCreate (final boolean autoCreate) {
		this.autoCreate = autoCreate;
	}
	
	/**
	 * Set the appropriate facing string based upon the user's relative
	 * motion. If the user's motion is negligible, then do not change
	 * their current facing.
	 *
	 * @param u the user
	 */
	void setFacingFor (final AbstractUser u) {
		
		final Coord3D target = u.getTarget ();
		final Coord3D pos = u.getLocation ();
		final double dX = target.getX () - pos.getX ();
		final double dY = target.getY () - pos.getY ();
		
		if ( (Math.abs (dX) + Math.abs (dY)) < Room.FACING_MIN_EFFECT) {
			return;
		}
		
		final double arctangent2 = Math.atan2 (dX, -dY) + Math.PI;
		final int facingOctant = (int) ( (arctangent2 + (Room.octant / 2)) / Room.octant);
		if ( (facingOctant < 0)
				|| (facingOctant >= Room.octantFacing.length)) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							String.format (
									"for delta (%s,%s) arctan2 value %s yields octant #%s, out of range of 0..7",
									String.valueOf (dX),
									String.valueOf (dY),
									String.valueOf (arctangent2),
									String.valueOf (facingOctant)));
			u.setFacing ("SE");
			return;
		}
		u.setFacing (Room.octantFacing [facingOctant]);
	}
	
	/**
	 * Set the filename for the floor/background of the room
	 * 
	 * @param filename1 the filename of the floor/background
	 */
	public void setFilename (final String filename1) {
		setVariable ("f", filename1);
	}
	
	/**
	 * set the room's unique ID (integer) — unique within a Zone
	 *
	 * @param newID the new ID to be set
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}
	
	/**
	 * Set whether the room is a Limbo room. In Limbo, noöne can hear
	 * you scream — or talk, or move, or anything else. There are no
	 * broadcast messages.
	 *
	 * @param b Whether or not this room is a Limbo room — true, means
	 *            to suppress all broadcast messages.
	 */
	public void setLimbo (final boolean b) {
		iAmInLimbo = b;
		changed ();
	}
	
	/**
	 * Set the room's unique (within a Zone) moniker. The moniker is
	 * the preferred way to refer to a room.
	 * 
	 * @param newMoniker the moniker to set
	 */
	public void setMoniker (final String newMoniker) {
		moniker = newMoniker;
		changed ();
	}
	
	/**
	 * Set the background music to be played in the room
	 * 
	 * @param music1 the background music to play in the room
	 */
	public void setMusic (final String music1) {
		setVariable ("m", music1);
	}
	
	/**
	 * WRITEME.
	 * 
	 * @param overlay1 WRITEME
	 * @see org.starhope.appius.game.Room#setOverlay(java.lang.String)
	 */
	public void setOverlay (final String overlay1) {
		setVariable ("w", overlay1);
	}
	
	/**
	 * @param newHomeOwner the new owner of the home containing this
	 *            room. <em>May be null</em>.
	 */
	
	public void setOwner (final AbstractUser newHomeOwner) {
		homeOwner = newHomeOwner;
		if (null == homeOwner) {
			deleteVariable ("homeOwner");
			homeOwner = Nomenclator.getSystemUser ();
		} else {
			setVariable ("homeOwner", newHomeOwner.getAvatarLabel ()
					.toLowerCase (Locale.ENGLISH));
		}
	}
	
	/**
	 * Set (create or change) a Place within the Room based upon a
	 * place code and a geometry string
	 * 
	 * @param placeCode the room variable name, naming this place
	 *            uniquely
	 * @param descriptor the description as to what it is, that this
	 *            place does.
	 * @return true, if the code might be broadcasted as a room
	 *         variable;
	 */
	public boolean setPlace (final String placeCode,
			final String descriptor) {
		final String [] descriptorBits = descriptor.split (Pattern
				.quote (":"));
		boolean walkChanged = false;
		
		if (0 == descriptorBits.length || 1 == descriptorBits.length && 0 == descriptorBits [0].length ()) {
			walkSpaces.remove (placeCode);
			obstacles.remove (placeCode);
			oldEventPlaces.remove (placeCode);
			serverEvents.remove (placeCode);
			exitPlaces.remove (placeCode);
			if (eventPlaces.containsKey (placeCode)) { return eventPlaces.remove (placeCode).isForBroadcast (); }
			if (itemPlaces.containsKey (placeCode)) { return itemPlaces.remove (placeCode).isForBroadcast (); }
			if (pointPlaces.containsKey (placeCode)) { return pointPlaces.remove (placeCode).isForBroadcast (); }
			return true;
		}
		
		// Check to see if room var is in "new" JSON format
		if (descriptor.startsWith ("{")) {
			try {
				AbstractPlace place = AbstractPlace.Create (placeCode, descriptor, this);
				if (place instanceof EventPlace) {
					eventPlaces.put (placeCode, (EventPlace) place);
				} else if (place instanceof ItemPlace) {
					itemPlaces.put (placeCode, (ItemPlace) place);
				} else if (place instanceof PointPlace) {
					// Since PointPlace is an ancestor of ItemPlace you want to do ItemPlace first
					pointPlaces.put (placeCode, (PointPlace) place);
				}
				return place != null ? place.isForBroadcast () : false;
			} catch (JSONException e) {
				Room.log.error ("Exception",e);
			}
		}
		
		final String [] keyBits = descriptorBits [0].split (Pattern.quote ("_"));
		
		if ("rom".equals (keyBits [0])) {
			if ( (keyBits.length > 1) && (descriptorBits.length > 1)) {
				exitPlaces.put (
						placeCode,
						new Pair <String, Polygon> (
								keyBits [1],
								Geometry.stringToNewPolygon (descriptorBits [1])));
			}
		} else if ( !"out".equals (keyBits [0])
				&& (keyBits.length >= 3)) {
			final char ch0 = keyBits [0].charAt (0);
			final char ch1 = keyBits [0].charAt (1);
			final char ch2 = keyBits [0].charAt (2);
			if (keyBits [0].length () == 3 && ch0 >= 'a' && ch0 <= 'z' && ch1 >= 'a' && ch1 <= 'z' && ch2 >= 'a'
					&& ch2 <= 'z') {
				oldEventPlaces.put (placeCode, new Pair <String, Collection <GeneralPath>> (descriptorBits [0],
						Geometry.stringToGeneralPathSet (descriptorBits [1])));
			}
			
		}
		
		if ("walk".equals (keyBits [0])) {
			walkChanged = true;
			walkSpaces.put (placeCode, Geometry
					.stringToGeneralPathSet (descriptorBits [1]));
		}
		if ("obs".equals (keyBits [0])) {
			walkChanged = true;
			obstacles.put (placeCode, Geometry
					.stringToGeneralPathSet (descriptorBits [1]));
		}
		
		if (walkChanged) {
			walkableSpace = Geometry.squash (
					LibMisc.condense (walkSpaces.values ()),
					LibMisc.condense (obstacles.values ()));
		}
		if ("evt".equals (keyBits [0]) && (keyBits.length == 1)) {
			final StringBuilder error = new StringBuilder ();
			error.append (getDebugName ());
			error.append (" has a malformed event Place named “");
			error.append (placeCode);
			error.append ("” with a descriptor of “");
			error.append (descriptor);
			error.append ("” — events beginning with evt_ should have a code following them. Refer to the Room Places documentation for formatting.");
			AppiusClaudiusCaecus.reportDesignBug (error.toString ());
			return false;
		}
		
		if ("rom".equals (keyBits [0]) && (keyBits.length == 1)) {
			final StringBuilder error = new StringBuilder ();
			error.append (getDebugName ());
			error.append (" has a malformed exit Place named “");
			error.append (placeCode);
			error.append ("” with a descriptor of “");
			error.append (descriptor);
			error.append ("” — exits beginning with rom_ should have a room moniker following them.");
			AppiusClaudiusCaecus.reportDesignBug (error.toString ());
			return false;
		}
		if (keyBits.length > 1 && "evt".equals (keyBits [0])) {
			oldEventPlaces.put (
					placeCode,
					new Pair <String, Collection <GeneralPath>> (descriptorBits [0], Geometry
							.stringToGeneralPathSet (descriptorBits [1])));
			if ('$' == keyBits [1].charAt (0)) {
				serverEvents
						.put (placeCode,
								new Pair <Collection <GeneralPath>, ConcurrentSkipListSet <AbstractUser>> (
										Geometry.stringToGeneralPathSet (descriptorBits [1]),
										new ConcurrentSkipListSet <AbstractUser> ()));
				return false;
			}
		}
		return true;
	}
	
	/**
	 * @param newRoomIndex the new room index within the user's house
	 */
	
	public void setRoomIndex (final int newRoomIndex) {
		roomIndex = newRoomIndex;
	}
	
	/**
	 * WRITEME.
	 * <p>
	 * XXX has Tootsville-specific stuff that can be removed
	 * </p>
	 * 
	 * @see org.starhope.appius.game.Room#setRoomVars()
	 */
	
	public void setRoomVars () {
		walkSpaces.clear ();
		obstacles.clear ();
		oldEventPlaces.clear ();
		serverEvents.clear ();
		exitPlaces.clear ();
		itemPlaces.clear ();
		eventPlaces.clear ();
		pointPlaces.clear ();
		for (final Entry <String, String> s : getVariables ().entrySet ()) {
			if (s.getKey ().startsWith ("zone") || s.getKey ().startsWith ("item")) {
				setPlace (s.getKey (), s.getValue ());
			}
		}
		
		for (final Entry <String, String> el : getArbitraryVars ()
				.entrySet ()) {
			setVariable (el.getKey (), el.getValue ());
		}
		
		getActiveDecorations ();
	}
	
	/**
	 * WRITEME.
	 * 
	 * @param newSky WRITEME
	 * @see org.starhope.appius.game.Room#setSky(java.lang.String)
	 */
	
	public void setSky (final String newSky) {
		setVariable ("s", newSky);
	}
	
	/**
	 * WRITEME.
	 * 
	 * @param whetherSkyIsVisible WRITEME
	 * @see org.starhope.appius.game.Room#setSkyVisible(boolean)
	 */
	public void setSkyVisible (final boolean whetherSkyIsVisible) {
		skyVisible = whetherSkyIsVisible;
	}
	
	/**
	 * @param whetherSubjectToWeather the subjectToWeather to set
	 */
	public void setSubjectToWeather (
			final boolean whetherSubjectToWeather) {
		subjectToWeather = whetherSubjectToWeather;
		changed ();
	}
	
	/**
	 * WRITEME.
	 * 
	 * @param newTitle WRITEME
	 * @see org.starhope.appius.game.Room#setTitle(java.lang.String)
	 */
	public void setTitle (final String newTitle) {
		title = newTitle;
		changed ();
	}
	
	/**
	 * @param roomUserLimit the roomUserLimit to set
	 */
	public void setUserLimit (final int roomUserLimit) {
		userLimit = roomUserLimit;
		changed ();
	}
	
	/**
	 * WRITEME.
	 * 
	 * @param var WRITEME
	 * @see org.starhope.appius.game.Room#setVariable(java.util.Map.Entry)
	 */
	@Override
	public void setVariable (final Entry <String, String> var) {
		final String key = var.getKey ();
		final String value = var.getValue ();
		setVariable (key, value);
	}
	
	/**
	 * WRITEME.
	 *
	 * @param varName WRITEME
	 * @param varValue WRITEME
	 * @see org.starhope.appius.game.Room#setVariable(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public void setVariable (final String varName, final String varValue) {
		setVariable (varName, varValue, false);
	}
	
	/**
	 * Sets a variable on the room. If flushToDatabase is set to true, then the variable is saved to the database,
	 * otherwise it is treated
	 * as a temporary variable and is not saved.
	 *
	 * @param varName WRITEME  ewinkelman 
	 * @param varValue WRITEME  ewinkelman 
	 * @param flushToDatabase WRITEME  ewinkelman 
	 */
	public void setVariable (final String varName, final String varValue, final boolean flushToDatabase) {
		if (iAmInLimbo) { return; }
		if (null == varName) {
			BugReporter.getReporter ("srv").reportBug (
					"Received a null in setVariable",
					new NullPointerException ("null=" + varValue));
			return;
		}
		final String varV = null == varValue ? "" : varValue;
		
		if (varV.equals (roomVariables.getVariable (varName)) || varV.equals (templateVariables.getVariable (varName))) { return; }
		
		if (varV.length () != 0) {
			roomVariables.setVariable (varName, varV, flushToDatabase);
		} else {
			roomVariables.deleteVariable (varName, flushToDatabase);
		}
		
		boolean toBroadcast = !isLimbo ();
		if (varName.startsWith ("zone") || varName.startsWith ("item") || varV.startsWith ("{")) {
			toBroadcast = setPlace (varName, varV) && toBroadcast;
			detectSounds ();
		}
		toBroadcast &= !varName.startsWith ("evt_$");
		
		if (channel != null) {
			final ADPRoomVar adp = new ADPRoomVar (this, getID ());
			adp.add (varName, varV);
			adp.echoClient (toBroadcast);
			channel.broadcast (adp);
		}
	}
	
	/**
	 * WRITEME.
	 *
	 * @param map WRITEME
	 * @see org.starhope.appius.game.Room#setVariables(java.util.Map)
	 */
	
	@Override
	public void setVariables (final Map <String, String> map) {
		for (final Entry <String, String> var : map.entrySet ()) {
			setVariable (var);
		}
	}
	
	/**
	 * @param newRules the new rules for vehicles in this room
	 */
	public void setVehicleRulesForRoom (final VehicleStyle newRules) {
		vehicleStyle = newRules;
		changed ();
	}
	
	/**
	 * @param newVolume the volume to set
	 */
	public void setVolume (final Volume3D newVolume) {
		volume = newVolume;
		changed ();
	}
	
	/**
	 * @param newWorld the world to set
	 */
	public void setWorld (final String newWorld) {
		world = newWorld;
		changed ();
	}
	
	/**
	 * @param newWorldCoords the worldCoords to set
	 */
	public void setWorldCoords (final Coord3D newWorldCoords) {
		worldCoords = newWorldCoords;
		changed ();
	}
	
	/**
	 * @param newZone the zone to set
	 */
	public void setZone (final Zone newZone) {
		zone = newZone;
		changed ();
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Mar 11,
	 * 2010)
	 * 
	 * @param u WRITEME
	 * @param speech WRITEME
	 * @param carlSays WRITEME
	 * @param chan TODO
	 */
	
	public void speak_actually (final AbstractUser u,
			final String speech, final FilterResult carlSays,
			final Channel chan) {
		
		final String filteredSpeech = FilterStatus.Ok == carlSays.status ? speech
				: "";
		
		switch (carlSays.status) {
		case Ok:
		default:
			if ( (null == chan) || (chan instanceof RoomChannel)) {
				sendPublicMessage (u, filteredSpeech);
			} else {
				chan.broadcast (new ADPSpeak (u, filteredSpeech));
			}
			Quaestor.getDefault ()
					.action (new Action (this, u, "said",
							(AbstractUser) null, filteredSpeech));
			break;
		case Black:
			u.acceptPrivateMessage (u, "/00p$");
			Quaestor.getDefault ()
					.action (new Action (this, u, "blackList",
							(AbstractUser) null, filteredSpeech));
			break;
		case Red:
			try {
				u.kick (Nomenclator.getSystemUser (), "obs", 15);
			} catch (final PrivilegeRequiredException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a PrivilegeRequiredException in Room.speak_actually ",
								e);
			}
			Quaestor.getDefault ()
					.action (new Action (this, u, "redList",
							(AbstractUser) null, filteredSpeech));
			break;
		}
		
	}
	/**
	 * Subscribe to the click handler action
	 *
	 * @param handler WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public boolean subscribe (final ActionClickHandler handler) {
		return clickHandlers.add (handler);
	}
	
	/**
	 * Subscribe to the event area enter handler action
	 *
	 * @param handler WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public boolean subscribe (final ActionEventAreaEnterHandler handler) {
		return eventAreaEnterHandlers.add (handler);
	}
	
	/**
	 * Subscribe to the event area exit handler action
	 *
	 * @param handler WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public boolean subscribe (final ActionEventAreaExitHandler handler) {
		return eventAreaExitHandlers.add (handler);
	}
	
	/**
	 * Subscribe to the room join handler action
	 *
	 * @param handler WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public boolean subscribe (final ActionRoomJoinHandler handler) {
		return joinHandlers.add (handler);
	}
	
	/**
	 * Subscribe to the room part handler action
	 *
	 * @param handler WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public boolean subscribe (final ActionRoomPartHandler handler) {
		return partHandlers.add (handler);
	}
	
	/**
	 * Update the user during a room join, giving them information about
	 * everyone in the room
	 *
	 * @param u the user joining the room
	 * @param t the user's server thread
	 * @throws UserDeadException if the user goes away
	 */
	void tellUserAboutRoom (final AbstractUser u, final ServerThread t)
			throws UserDeadException {
		t.sendUserJoin (this);
	}
	
	@Override
	public void tick (final long currentTime, final long deltaTime)
			throws UserDeadException {
		// Iterate through all server event areas
		if (zone == null) { return; }
		
		// Consider users for each event place
		final Set <AbstractUser> users = new HashSet <AbstractUser> (userList);
		synchronized (eventPlaces) {
			for (EventPlace eventPlace : eventPlaces.values ()) {
				eventPlace.consider (users);
			}
		}
		for (final String key : serverEvents.keySet ()) {
			final Collection <GeneralPath> evtAreas = serverEvents
					.get (key).head ();
			final ConcurrentSkipListSet <AbstractUser> evtUsers = serverEvents
					.get (key).tail ();
			// Check all users currently in the event area to see if
			// they have left
			for (final Iterator <AbstractUser> userIterator = evtUsers
					.iterator (); userIterator.hasNext ();) {
				final AbstractUser user = userIterator.next ();
				boolean found = false;
				if (userList.contains (user)) {
					final Coord3D p = user.getLocation ();
					for (final GeneralPath area : evtAreas) {
						if (area.contains (p.getX (), p.getY ())) {
							found = true;
						}
					}
				}
				if ( !found) {
					userIterator.remove ();
					Quaestor.getDefault ().action (
							new Action (this, user,
									"event.srv.exit",
									getVariable (key).split (
											":") [0]));
									eventAreaExitHandlers
					.fire (new ActionEventAreaExit (this, user, getVariable (key).split (":") [0]));
				}
			}
			// Iterate all users and check to see if they are in a
			// server event area
			for (final AbstractUser user : userList) {
				if (evtUsers.contains (user)) {
					continue; // Skip any users already in this
					// event
				}
				// area
				final Coord3D p = user.getLocation ();
				for (final GeneralPath area : evtAreas) {
					if (area.contains (p.getX (), p.getY ())) {
						evtUsers.add (user);
										eventAreaEnterHandlers.fire (new ActionEventAreaEnter (this, user, getVariable (key)
								.split (":") [0]));
		Quaestor.getDefault ()
								.action (new Action (
										this,
										user,
										"event.srv.enter",
										getVariable (key)
												.split (":") [0]));
					}
				}
			}
		}
	}
	
	/**
	 * WRITEME.
	 *
	 * @return WRITEME
	 * @see org.starhope.appius.game.Room#toJSON() <code>
	 *  {
	 *   "filename": room-filename,
	 *   "moniker": room-moniker,
	 *   "overlay": weather-overlay-filename,
	 *   "sky": sky-background-filename,
	 *   "skyVisible": ( "true" | "false" )
	 *   "vars": { … }
	 *  }
	 * </code>
	 */
	public JSONObject toJSON () {
		final JSONObject self = new JSONObject ();
		try {
			self.put ("filename", getFilename ());
			self.put ("moniker", moniker);
			self.put ("overlay", getOverlay ());
			self.put ("sky", getSky ());
			self.put ("skyVisible", skyVisible);
			self.put ("vars", getVariables_JSON ());
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
		return self;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	
	@Override
	public String toString () {
		if ( !"".equals (getTitle ())) {
			return "“" + getTitle () + "” " + getDebugName ();
		}
		return getDebugName ();
	}
		/**
	 * trace to the server log an event
	 * 
	 * @param text the message to output
	 */
	protected void trace (final String text) {
		getZone ().trace (getDebugName () + ": " + text);
	}
	
	/**
	 * Creates a click action in the room
	 *
	 * @param u User that caused the click action
	 * @param clickedOn What was clicked on (if anything)
	 * @param target The location of where the click occured in world coordinates
	 * @param shift If shift was held during the click
	 * @param ctrl If control was held during the click
	 * @param alt If alt was held during the click
	 */
	public void triggerClick (final AbstractUser u, final String clickedOn, final Coord2D target, final boolean shift,
			final boolean ctrl, final boolean alt) {
		clickHandlers.fire (new ActionClick (this, u, clickedOn, target, shift, ctrl, alt));
	}
	
	/**
	 * Unsubscribe to the click handler action
	 *
	 * @param handler WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public boolean unsubscribe (final ActionClickHandler handler) {
		return clickHandlers.remove (handler);
	}
	
	/**
	 * Unsubscribe to the event area enter handler action
	 *
	 * @param handler WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public boolean unsubscribe (final ActionEventAreaEnterHandler handler) {
		return eventAreaEnterHandlers.remove (handler);
	}
	
	/**
	 * Unsubscribe to the event area exit handler action
	 *
	 * @param handler WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public boolean unsubscribe (final ActionEventAreaExitHandler handler) {
		return eventAreaExitHandlers.remove (handler);
	}
	
	/**
	 * Unsubscribe to the room join handler action
	 *
	 * @param handler WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public boolean unsubscribe (final ActionRoomJoinHandler handler) {
		return joinHandlers.remove (handler);
	}
	
	/**
	 * Unsubscribe to the room part handler action
	 *
	 * @param handler WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public boolean unsubscribe (final ActionRoomPartHandler handler) {
		return partHandlers.remove (handler);
	}
	
	/**
	 * @param target WRITEME
	 * @return WRITEME
	 * @see org.starhope.appius.game.Room#userNearest(org.starhope.appius.geometry.Coord3D)
	 */
	public AbstractUser userNearest (final Coord3D target) {
		if (iAmInLimbo) {
			return null;
		}
		AbstractUser best = null;
		double distance = Double.MAX_VALUE;
		for (final AbstractUser who : userList) {
			final double hisDistance = who.getLocation ().distance (
					target);
			if ( (hisDistance < Room.USER_FIND_EPSILON)
					&& (hisDistance < distance)) {
				best = who;
				distance = hisDistance;
			}
		}
		return best;
	}
	
	/**
	 * Ensure that everyone who we think is in the room, is actually
	 * still here ... filter out dead users
	 */
	void validateUserList () {
		
		recomputeLag ();
		
		for (final AbstractUser u : userList) {
			if (null == u) {
				userList.remove (null);
			} else if ( !u.isOnline ()) {
				part (u);
			} else if (null == u.getRoom ()) {
				u.setRoom (this);
			} else if ( !u.getRoom ().equals (this)) {
				part (u);
			}
		}
	}
}
