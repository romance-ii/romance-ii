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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.game;

import java.io.IOException;
import java.io.ObjectInput;
import java.lang.reflect.Constructor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Queue;
import java.util.Random;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;
import java.util.concurrent.CopyOnWriteArrayList;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.geometry.Polygon;
import org.starhope.appius.messaging.AbstractCensor;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.sys.admin.TheZones;
import org.starhope.appius.types.FilterType;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.User;
import org.starhope.appius.user.events.Action;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;
import org.starhope.util.types.Pair;

/**
 * @author brpocock@star-hope.org
 */
public class Zone implements Comparable <Zone> {

	/**
	 * <p>
	 * The password for $Eaves is the medieval Tuscan interpretation of
	 * the inscription upon the Black Gates, as read by Virgil to Dante
	 * Alligheri in The Divine Comedy.
	 * </p>
	 * <p>
	 * Perhaps the best English translation thereof is:
	 * </p>
	 * <div>Lay down all hope, you that go in by me.</div> -- Dorothy L.
	 * Sayers
	 */
	// private static final String EAVESDROP_PASSWORD =
	// "Lasciate ogne speranza, voi ch-intrate";
	/**
	 *
	 */
	static long lastCheckedZonesForSpawn = 0;

	/**
	 * Time between updates for NPC's
	 */
	private static int NPC_TICK_INTERVAL = Integer
	.parseInt (AppiusConfig.getConfigOrDefault (
			"org.starhope.appius.npc.tickSeconds", "30"));

	/**
	 * keep the random source around for fun.
	 */
	private static Random randomSource = new Random ();

	/**
	 * Set of retired zones
	 */
	static Set <Zone> retiredZones = new ConcurrentSkipListSet <Zone> ();

	/**
	 * linkages between rooms
	 */
	public final static Map <Zone, Map <String, List <String>>> roomMaps = new ConcurrentHashMap <Zone, Map <String, List <String>>> ();

	/**
	 * Java Serialization unique ID
	 */
	private static final long serialVersionUID = -2338918747157284836L;

	/**
	 * remove unused user rooms
	 */
	protected static void cullAllUserRooms () {
		for (final Zone z : AppiusClaudiusCaecus.getAllZones ()) {
			z.cullUserRooms ();
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param zoneName WRITEME
	 * @return WRITEME
	 * @deprecated ask {@link AppiusClaudiusCaecus#getZone}
	 */
	@Deprecated
	public static Zone getByName (final String zoneName) {
		return AppiusClaudiusCaecus.getZone (zoneName);
	}

	/**
	 * <p>
	 * Get the GameEvents configured for default inclusion in all zones
	 * </p>
	 * <p>
	 * XXX: contains SQL
	 * </p>
	 *
	 * @return the class names of all default game events from the
	 *         database
	 */
	private static Vector <String> getDefaultGameEvents () {
		final Vector <String> classes = new Vector <String> ();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT klass,autostart FROM gameEventClasses");
			if (st.execute () && null != (rs = st.getResultSet ())) {
				while (rs.next ()) {
					if (rs.getString ("autostart").equals ("Y"))
						classes.add (rs.getString ("klass"));
				}
			}
		} catch (final SQLException e) {
			// Default catch action, report bug (brpocock@star-hope.org,
			// Feb 25, 2010)
			AppiusClaudiusCaecus.reportBug (
					"Caught a SQLException in getDefaultGameEvents", e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return classes;
	}

	/**
	 * @return Seconds between NPC updates
	 */
	public static int getNPCTickInterval () {
		return Zone.NPC_TICK_INTERVAL;
	}

	/**
	 * @return get the Subversion revision of this file
	 */
	public static String getRev () {
		return "$Rev: 2234 $";
	}

	/**
	 * Badges are icons placed upon the map to indicate something
	 * special about a room
	 */
	private transient final Map <String, Room> badges = new ConcurrentHashMap <String, Room> ();

	/**
	 * Censorship object
	 */
	private final AbstractCensor censor;

	/**
	 * Set of communication channels for this zone
	 */
	private final Map <String, Channel> channels = new ConcurrentHashMap <String, Channel> ();

	/**
	 * Rooms to be culled
	 */
	protected transient final Set <String> cullRooms = new ConcurrentSkipListSet <String> ();

	/**
	 * Default channel for the zone
	 */
	private Channel defaultChannel;

	/**
	 * All GameEvents which have been added to this Zone already
	 */
	private final Set <GameEvent> gameEvents = new HashSet <GameEvent> ();

	/**
	 * Lobby rooms into which users are dropped at login, if they don't
	 * specify an initial room to join on their own
	 */
	private transient final List <Room> lobbies = new CopyOnWriteArrayList <Room> ();

	/**
	 * Names of empty zones
	 */
	protected transient final Set <String> myEmptyZones = new ConcurrentSkipListSet <String> ();

	/**
	 * The name of this zone
	 */
	private final String myName;

	/**
	 * The hostname of the server on which this Zone is running
	 */
	private String myServer;

	/**
	 * The room numbers for dynamic rooms begin here
	 */
	private int nextDynamicRoomNumber = 0x100;

	/**
	 * All rooms in the Zone: sorted by ID.
	 *
	 * @see #roomsByMoniker
	 */
	private final ConcurrentHashMap <Integer, Room> roomsByID = new ConcurrentHashMap <Integer, Room> ();

	/**
	 * All rooms in the Zone: sorted by moniker.
	 *
	 * @see #roomsByID
	 */
	private final ConcurrentHashMap <String, Room> roomsByMoniker = new ConcurrentHashMap <String, Room> ();

	/**
	 * A flag set once the server has indicated that it's ready to go,
	 * to avoid issues with events firing off too soon (e.g. NPC's)
	 */
	protected boolean serverReady;

	/**
	 * The set of all users in the zone.
	 */
	private final ConcurrentSkipListSet <AbstractUser> zoneUsers = new ConcurrentSkipListSet <AbstractUser> ();

	/**
	 * <p>
	 * XXX the zone's censor is initialised to
	 * {@link FilterType#KID_CHAT}. To enable
	 * {@link FilterType#ADULT_CHAT} you'll have to overrule that on a
	 * zone-by-zone basis right now: there is no configuration option
	 * for that in the default SQL table layout.
	 * </p>
	 *
	 * @param zoneName The name for the new Zone. <h4>Note</h4>
	 */
	public Zone (final String zoneName) {
		censor = AppiusConfig.getFilter (FilterType.KID_CHAT); // XXX
		myServer = AppiusClaudiusCaecus.getServerHostname ();
		myName = zoneName;
		defaultChannel = new Channel ("", this); // Sets default channel
													// for the zone
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.Zone#activate()
	 */
	public void activate () {
		if (AppiusClaudiusCaecus.isZoneActive (getName ())) {
			return;
		}
		AppiusClaudiusCaecus.add (this);
		Quaestor.getDefault ().action (
				new Action ("zone.activated", getName ()));
		Class <? extends RunCommands> rc;
		try {
			rc = AppiusClaudiusCaecus.getRCClass ();
		} catch (final NotFoundException e1) {
			rc = null;
		}
		if (null != rc) {
			try {
				final RunCommands rcRC = rc.newInstance ();
				if (null != rcRC) {
					rcRC.newZone (this);
				}
			} catch (final Exception e) {
				AppiusClaudiusCaecus.reportBug (
						"Can't run RC for new zone", e);
			}
		}
		PhysicsScheduler.start (); // Tries to start the physics
									// scheduler
		AppiusClaudiusCaecus.wallops (Nomenclator.getSystemUser (),
				"Activating new Zone: “" + getName () + "”");
	}

	/**
	 * @param user the user entering the zone
	 */
	public void add (final AbstractUser user) {
		zoneUsers.add (user);
		user.setZone (this);
		defaultChannel.join (user);
		sendBadges (user);
		PhysicsScheduler.addPersonOfInterest (user);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @param room The room being added to the zone
	 * @see org.starhope.appius.game.Zone#add(Room)
	 */
	public void add (final Room room) {
		final Integer id = Integer.valueOf (room.getID ());
		final String moniker = room.getMoniker ();

		if (roomsByID.containsKey (id) && null != roomsByID.get (id)) {
			final String errStr = "Attempting to replace "
				+ room.getName ();
			AppiusClaudiusCaecus.reportBug (errStr);
			return;
		}
		if (roomsByMoniker.containsKey (moniker)
				&& null != roomsByMoniker.get (moniker)) {
			final String errStr = "Attempting to replace (moniker match) "
				+ room.getName ();
			// OpCommands.op_wallops (new String [] {
			// errStr }, User
			// .getByID (1), room.getID (),
			// this);
			if ('$' != room.getName ().charAt (0)) {
				AppiusClaudiusCaecus.reportBug (errStr);
			}
			return;
		}

		trace ("Adding room " + moniker + " (#" + id + ")");

		roomsByID.put (id, room);
		roomsByMoniker.put (moniker, room);
		buildRoomMap ();
	}

	/**
	 * add a GameEvent by instantiating it into this Zone, based upon
	 * its class name.
	 *
	 * @param className the GameEvent class name to be loaded
	 */
	@SuppressWarnings ("unchecked")
	public void addGameEventByClass (final String className) {
		for (final GameEvent ev : gameEvents) {
			if (ev.getClass ().getCanonicalName ().equals (className)) {
				trace ("Already loaded " + className);
				return;
			}
		}
		try {
			final Class <? extends GameEvent> klass = (Class <? extends GameEvent>) Class
			.forName (className);
			if (null == klass) {
				throw new NotFoundException ("no Class found");
			}
			trace ("Instantiating " + className);
			final Constructor <? extends GameEvent> ctr = klass
			.getConstructor (Zone.class);
			if (null == ctr) {
				throw new NotFoundException ("no Zone constructor");
			}
			final Object o = ctr.newInstance (this);
			if ( ! (o instanceof GameEvent)) {
				throw new NotFoundException (className
						+ " is not a GameEvent");
			}
			final GameEvent gameEvent = (GameEvent) o;
			trace ("Created " + gameEvent.getName () + " GameEvent");
			// trace ("Ticking " + gameEvent.getName ());
			// gameEvent.tick (System.currentTimeMillis (),
			// System.currentTimeMillis ());
			gameEvents.add (gameEvent);
		} catch (final Throwable e) {
			AppiusClaudiusCaecus.reportBug (
					"Exception connecting to class " + className, e);
		}
	}

	/**
	 * Assert that the given user must have a given level of staff
	 * privileges
	 *
	 * @param u The Smart Fox user object
	 * @param staffLevelRequired The staff level required to perform the
	 *            action
	 * @throws PrivilegeRequiredException if the user
	 */
	public void assertStaffLevel (final GeneralUser u,
			final int staffLevelRequired)
	throws PrivilegeRequiredException {
		if (u.getStaffLevel () < staffLevelRequired) {
			throw new PrivilegeRequiredException (staffLevelRequired);
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param string WRITEME
	 * @return WRITEME
	 */
	private Room autoVivifyUserRoom (final String string) {
		final String userName = string.substring (1,
				string
				.indexOf ('/'));
		final String roomNumber = string.substring (string
				.indexOf ('/') + 1);
		final String userRoomMoniker = "user~" + userName + "~"
		+ roomNumber;
		final Room r = roomsByMoniker.get (userRoomMoniker);
		if (null != r) {
			return r;
		}
		final AbstractUser u = Nomenclator.getUserByLogin (userName);
		try {
			final Room newRoom = Room.initUserRoom (u, Integer
					.parseInt (roomNumber));
			newRoom.setZone (u.getZone ());
		} catch (final NumberFormatException e) {
			AppiusClaudiusCaecus
			.reportBug (
					"Caught a NumberFormatException in Zone.autoVivifyUserRoom ",
					e);
		} catch (final NotReadyException e) {
			AppiusClaudiusCaecus
			.reportBug (
					"Caught a NotReadyException in Zone.autoVivifyUserRoom ",
					e);
		}
		return roomsByMoniker.get (userRoomMoniker);
	}

	/**
	 * Notify everyone in the zone that the badges have been changed
	 */
	private void badgesChanged () {
		final JSONObject notify = getAllBadges_JSON ();
		for (final AbstractUser u : getAllUsersInZone ()) {
			u.acceptSuccessReply ("badgeUpdate", notify, u.getRoom ());
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	protected  synchronized void buildRoomMap () {
		final Queue <String> toExplore = new LinkedList <String> ();
		toExplore.addAll (AppiusConfig.getList ("org.starhope.appius.npc.startRooms"));
		if (toExplore.size () == 0) {
			// Tootsville defaults…
			toExplore.add("artStudio");
			toExplore.add ("bigTootoona");
			toExplore.add ("bigTopCircus");
			toExplore.add ("bigTree");
			toExplore.add ("comicWorld");
			toExplore.add ("dinoLand");
			toExplore.add ("enchantedForest");
			toExplore.add ("moonbaseTLandingSite");
			toExplore.add ("piratesCove" );
			toExplore.add ("tootCastle");
			toExplore.add ("tootlantis");
			toExplore.add ("tootSquare");
			toExplore.add ("tootSafari");
			toExplore.add ("tootsIdol");
		}

		final List <String> explored = new LinkedList <String> ();

		final Map <String, List <String>> map =
			getRoomMap ();
		map.clear ();

		BUILD_LOOP:
			while (toExplore.size () > 0) {
				final String aRoom = toExplore.remove ();
				final List <String> exitList = new LinkedList <String> ();
				Room room;
				try {
					room = getRoomByName (aRoom);
				} catch (final NotFoundException e) {
					// ignore missing rooms.
					continue BUILD_LOOP;
				}
				final Map <String, Pair <String, Polygon>> exits = room
				.getExits ();
				for (final Pair <String, Polygon> exit : exits.values ()) {
					final String to = exit.head ();
					exitList.add (to);
					if ( !explored.contains (to)) {
						toExplore.add (to);
					}
				}
				map.put (aRoom, exitList);
				explored.add (aRoom);
			}

	}

	/**
	 * @see org.starhope.appius.game.Zone#clearAllBadges()
	 */
	public void clearAllBadges () {
		badges.clear ();
		badgesChanged ();
	}

	/**
	 * clear all badges on one room
	 *
	 * @param room the room upon which all badges are to be cleared
	 */
	public void clearAllBadges (final Room room) {
		for (final Entry <String, Room> badge : badges.entrySet ()) {
			if (badge.getValue ().equals (room)) {
				badges.remove (badge.getKey ());
			}
		}
		badgesChanged ();
	}

	/**
	 * clear the given badge name off of any room to which it might be
	 * applied
	 *
	 * @param string the badge name
	 * @throws GameLogicException if the given badge wasn't set on the
	 *             room already
	 */

	public void clearBadge (final String string)
	throws GameLogicException {
		badges.remove (string);
		badgesChanged ();
	}

	/**
	 * @param other the other zone
	 * @return the relative ordering of the zones, in Unicode order by
	 *         name
	 */

	@Override
	public int compareTo (final Zone other) {
		if (null == other) {
			return -1;
		}
		return getName ().compareTo (other.getName ());
	}

	/*
	 * Drop the user's house from the Zone
	 * @param user the user whose house is to be dropped /* private void
	 * dropUser (final User user) { cullRooms.add (user.getName ()); }
	 */

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	protected void cullUserRooms () {
		for (final Room room : roomsByMoniker.values ()) {
			final String ownerName = room.getVariable ("homeOwner");
			if (null != ownerName && !"".equals (ownerName)) {
				final AbstractUser roomOwner = Nomenclator
				.getUserByLogin (ownerName);
				if (null != roomOwner) {
					if ( !roomOwner.isOnline ()
							&& room.getAllUsers ().size () == 0) {
						destroyRoom (room);
					}
				}
			}
		}
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.Zone#destroy()
	 */

	public void destroy () {
		AppiusClaudiusCaecus.wallops (Nomenclator.getSystemUser (),
				"Destroying Zone: “" + getName () + "”");
		trace ("And there was great weeping, and gnashing of teeth.");
		for (final Room room : roomsByID.values ()) {
			destroyRoom (room);
		}
		for (final GameEvent ev : gameEvents) {
			ev.destroySelf ();
		}
		for (final Channel channel : channels.values ()) {
			channel.destroy ();
		}
		channels.clear ();
		defaultChannel = null;
		TheZones.local ().remove (this);
		trace ("And the destruction was complete.");
		AppiusClaudiusCaecus.getZoneSpawner ().freeInDB (myName);
	}
	
	/**
	 * @param room room to be destroyed
	 */
	public void destroyRoom (final Room room) {
		if ( !room.getZone ().equals (this)) {
			throw AppiusClaudiusCaecus
			.fatalBug ("Destroying other peoples' rooms is not nice:"
					+ room.toString ());
		}
		final Integer roomID = Integer.valueOf (room.getID ());
		final String roomMoniker = room.getMoniker ();
		room.destroySelf ();
		roomsByID.remove (roomID);
		roomsByMoniker.remove (roomMoniker);
		buildRoomMap ();
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (obj instanceof Zone) {
			return equals ((Zone) obj);
		}
		return false;
	}

	/**
	 * determine whether two Zone pointers are the same object
	 *
	 * @param z another Zone
	 * @return true, if the two objects are the same Zone
	 */
	public boolean equals (final Zone z) {
		if (null == z) {
			return false;
		}
		return getURL ().equals (z.getURL ());
	}

	/**
	 * Determines the existence of a channel with the given moniker in
	 * this zone
	 *
	 * @param moniker Channel name
	 * @return True if it exists, false otherwise
	 */
	public boolean existsChannel (final String moniker) {
		return channels.containsKey (moniker);
	}
	
	/**
	 * Determines the existence of a room with the given ID in this zone
	 * 
	 * @param id Room id
	 * @return True if it exists, false otherwise
	 */
	public boolean existsRoom (final Integer id) {
		return roomsByID.containsKey (id);
	}
	
	/**
	 * Determines the existence of a room with the given moniker in this
	 * 
	 * @param moniker Room name
	 * @return True if it exists, false otherwise
	 */
	public boolean existsRoom (final String moniker) {
		return roomsByMoniker.containsKey (moniker);
	}

	/**
	 * Get all (public) badges in this Zone (and to which rooms they are
	 * applied)
	 * 
	 * @return a map of badges and room monikers
	 */
	public Map <String, String> getAllBadges () {
		final HashMap <String, String> all = new HashMap <String, String> ();
		for (final Entry <String, Room> badge : badges.entrySet ()) {
			if (null != badge && null != badge.getKey ()
					&& null != badge.getValue ()) {
				all.put (badge.getKey (), badge.getValue ()
						.getMoniker ());
			}
		}
		return all;
	}

	/**
	 * get all badges on the Zone in JSON form
	 *
	 * @return the JSON set describing all active badges
	 */
	private JSONObject getAllBadges_JSON () {
		final JSONObject notify = new JSONObject ();
		final JSONObject badgeSet = new JSONObject ();
		for (final Entry <String, String> badge : getAllBadges ()
				.entrySet ()) {
			try {
				badgeSet.put (badge.getKey (), badge.getValue ());
			} catch (final JSONException e) {
				AppiusClaudiusCaecus.reportBug (
						"Caught a JSONException in badgesChanged", e);
			}
		}
		try {
			notify.put ("badges", badgeSet);
		} catch (final JSONException e1) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a JSONException in badgesChanged", e1);
		}
		return notify;
	}

	/**
	 * get the user ID's of all users active in the Zone
	 *
	 * @return the set of all users in the Zone
	 */

	public Set <Integer> getAllUsersIDsInZone () {
		validateUserList ();
		final HashSet <Integer> zoneUserIDs = new HashSet <Integer> ();
		for (final AbstractUser u : zoneUsers) {
			zoneUserIDs.add (Integer.valueOf (u.getUserID ()));
		}
		return zoneUserIDs;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.Zone#getAllUsersInZone()
	 */

	public Collection <AbstractUser> getAllUsersInZone () {
		validateUserList ();
		return new HashSet <AbstractUser> (zoneUsers);
	}

	/**
	 * Get the background image used to identify this Zone in the zone
	 * browser
	 *
	 * @return an image moniker
	 */
	private String getBackgroundImage () {
		// Room eaves;
		// try {
		// eaves = getRoomByName ("$Eaves");
		// } catch (NotFoundException e) {
		return "default";
		// }
		// final String background = eaves.getVariable ("zoneImage");
		// return background;
	}

	/**
	 * Get any badges assigned to a room
	 *
	 * @param room the room in question
	 * @return the set of badge strings
	 */
	public Set <String> getBadgesForRoom (final Room room) {
		final HashSet <String> set = new HashSet <String> ();
		for (final Entry <String, Room> badge : badges.entrySet ()) {
			if (badge.getValue ().equals (room)) {
				set.add (badge.getKey ());
			}
		}
		return set;
	}

	/**
	 * Discover how many of the user's buddies are online in a given
	 * zone
	 *
	 * @param user the user in question
	 * @return the number of buddies of that user in this Zone
	 */
	private int getBuddiesForUser (final AbstractUser user) {
		int buddies = 0;
		for (final String buddy : user.getBuddyListNames ()) {
			final AbstractUser bud = Nomenclator
			.getOnlineUserByLogin (buddy);
			if (null != bud && null != bud.getZone ()
					&& bud.getZone ().getName ().equals (getName ())) {
				++buddies;
			}
		}
		return buddies;
	}

	/**
	 * @see org.starhope.appius.game.Zone#getCensor()
	 */

	public AbstractCensor getCensor () {
		return censor;
	}

	/**
	 * Gets a channel from this zone based on the moniker
	 * 
	 * @param moniker
	 * @return
	 */
	public Channel getChannel (final String moniker) {
		return channels.get (moniker);
	}

	/**
	 * @return get the next room number to be used for a dynamic room
	 */
	public int getDynamicRoomNumber () {
		return nextDynamicRoomNumber++ ;
	}

	/**
	 * get all game events tied to this Zone
	 *
	 * @return WRITEME
	 */
	public Set <GameEvent> getGameEvents () {
		final HashSet <GameEvent> events = new HashSet <GameEvent> ();
		for (final Room r : roomsByID.values ()) {
			for (final GameEvent ev : r.getGameEvents ()) {
				events.add (ev);
			}
		}
		return events;
	}

	/**
	 * Get the host on which this zone's server is running
	 *
	 * @return the host on which this Zone's server is running
	 */

	public String getHost () {
		return AppiusClaudiusCaecus.getServerHostname ();
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.Zone#getMaxUsers()
	 * @deprecated use {@link ZoneSpawner#getZoneMaxUsers()} if you
	 *             really care
	 */

	@Deprecated
	public int getMaxUsers () {
		return ZoneSpawner.getZoneMaxUsers ();
	}

	/**
	 * @return {@link #myServer}
	 */
	public String getMyServer () {
		return myServer;
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.Zone#getName()
	 */

	public String getName () {
		return myName;
	}

	/**
	 * <p>
	 * Get the next room which will accept an inbound user as the next
	 * lobby.
	 * </p>
	 * <p>
	 * XXX: This contains Tootsville-specific code. There should instead
	 * be a room variable to indicate that a room is a lobby.
	 * </p>
	 * <p>
	 * XXX: This code isn't used in Tootsville any more, anyways.
	 * Tootsville users get the map screen after logging in.
	 * </p>
	 * <p>
	 * XXX: this throws out nulls anyways. BAD.
	 * </p>
	 *
	 * @return The name of the room into which the user should join
	 */

	public Room getNextLobby () {
		final int numLobbies = lobbies.size ();
		if (numLobbies > 0) {
			return lobbies.get (AppiusConfig.getRandomInt (0,
					numLobbies - 1));
		}

		// XXX bad fallback to hard-coded Tootsville defaults
		if (AppiusConfig
				.getConfigBoolOrTrue ("com.tootsville.disperseLogins")) {
			Room square;
			try {
				square = getRoomByName ("tootSquare");
				if (square.getUserCount () < AppiusConfig
						.getIntOrDefault (
								"com.tootsville.tootSquareBusy", 20)) {
					try {
						return getRoomByName ("tootSquare");
					} catch (final NotFoundException e) {
						AppiusClaudiusCaecus
						.reportDesignBug ("Not found: tootSquare");

					}
				}
			} catch (final NotFoundException e) {
				AppiusClaudiusCaecus
				.reportDesignBug ("Not found: tootSquare");
			}
			if (Zone.randomSource.nextBoolean ()) {
				try {
					return getRoomByName ("tootSquareWest");
				} catch (final NotFoundException e) {
					AppiusClaudiusCaecus.reportBug (
							"Not found: tootSquareWest", e);
				}
			}
			try {
				return getRoomByName ("tootUniversity");
			} catch (final NotFoundException e) {
				AppiusClaudiusCaecus.reportBug (
						"Not found; tootUniversity", e);
			}
		}
		try {
			return getRoomByName ("tootSquare");
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus.reportBug ("Not found: tootSquare", e);
		}
		return roomsByID.values ().iterator ().next ();
	}

	/**
	 * @param room a room ID number
	 * @return the room with that ID
	 */
	public Room getRoom (final Integer room) {
		return roomsByID.get (room);
	}

	/**
	 * @param moniker the room moniker
	 * @return the room with that moniker
	 * @throws NotFoundException if the room doesn't exist (and isn't set
	 *             for autovivification)
	 */
	public Room getRoom (final String moniker)
	throws NotFoundException {
		// if ('$' == moniker.charAt (0)) {
		// if ( !roomsByMoniker.contains (moniker)) {
		// final Room autovivified = Room.createPublicRoom (
		// moniker, this);
		// autovivified.setMoniker (moniker);
		// autovivified.setTitle (moniker + "*");
		// add (autovivified);
		// }
		// }
		if ('!' == moniker.charAt (0)) {
			return autoVivifyUserRoom (moniker);
		}
		final Room room = roomsByMoniker.get (moniker);
		if (null == room) {
			throw new NotFoundException (moniker);
		}
		return room;
	}

	/**
	 * @param moniker the room's moniker
	 * @return the room with that moniker
	 * @throws NotFoundException if the moniker is not found
	 * @deprecated for {@link #getRoom(String)}
	 */
	@Deprecated
	public Room getRoomByName(final String moniker) throws NotFoundException {
		return getRoom(moniker);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.Zone#getRoomList()
	 */

	public Collection <Room> getRoomList () {
		final Collection <Room> ret = new HashSet <Room> ();
		ret.addAll (roomsByID.values ());
		return ret;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.Zone#getRoomList_JSON()
	 */

	public JSONObject getRoomList_JSON () {
		final JSONObject list = new JSONObject ();
		for (final Room room : roomsByID.values ()) {
			final JSONObject r = new JSONObject ();
			try {
				r.put ("users", room.getUserCount ());
				r.put ("max", room.getMaxUsers ());
				r.put ("moniker", room.getMoniker ());
				r.put ("name", room.getName ());
				list.put (String.valueOf (room.getID ()), r);
			} catch (final JSONException e) {
				// Default catch action, report bug
				// (brpocock@star-hope.org, Mar 11,
				// 2010)
				AppiusClaudiusCaecus
				.fatalBug (
						"Caught a JSONException in getRoomList_JSON",
						e);
			}
		}
		return list;
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.Zone#getRoomListSFSXML()
	 */

	public String getRoomListSFSXML () {
		final StringBuilder sb = new StringBuilder ();
		sb.append ("<msg t='sys'><body action='rmList' r='0'><rmList>");
		trace (" Getting room list for " + myName + " with "
				+ roomsByID.size () + " rooms ");
		for (final Room room : roomsByID.values ()) {
			sb.append ("<rm id='");
			sb.append (room.getID ());
			sb.append ("' priv='0' temp='0' game='0' ucnt='");
			sb.append (room.getUserCount ());
			sb.append ("' maxu='");
			sb.append (room.getMaxUsers ());
			sb.append ("' maxs='0'><n><![CDATA[");
			sb.append (room.getMoniker ());
			sb.append ("]]></n></rm>");
		}
		sb.append ("</rmList></body></msg>");
		return sb.toString ();
	}

	/**
	 * @return the room map
	 */
	public synchronized  Map <String, List <String>> getRoomMap () {
		Map<String,List<String>> map = Zone.roomMaps.get(this);
		if (null == map){
			map = new ConcurrentHashMap <String, List<String>> ();
			Zone.roomMaps.put(this, map);
		}
		return map;
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.Zone#getRoomMaxUsers()
	 */

	public int getRoomMaxUsers () {
		return getMaxUsers ();
	}

	/**
	 * Get the Appius URL for this Zone
	 *
	 * @return an URL for this Zone
	 */

	public String getURL () {
		return "appius://" + getMyServer () + "/" + getName ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.Zone#getUserByName(java.lang.String)
	 */

	public AbstractUser getUserByName (final String buddy) {
		final AbstractUser u = Nomenclator.getUserByLogin (buddy);
		if ( !zoneUsers.contains (u)) {
			return null;
		}
		return u;
	}

	/**
	 * @see org.starhope.appius.game.Zone#getUserCount()
	 */

	public int getUserCount () {
		int c = 0;
		for (final AbstractUser u : zoneUsers) {
			if (null != u.getServerThread ()) {
				++c;
			}
		}
		return c;
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.Zone#getUserRoom(AbstractUser)
	 * @deprecated use {@link AbstractUser#getRoom()}
	 */

	@Deprecated
	public Room getUserRoom (final AbstractUser user) {
		return user.getRoom ();
	}

	/**
	 * Gets the Zone data. The user passed in will be used to compute
	 * the “buddies” counter for the zone
	 *
	 * @param user the user from whose perspective we're collecting the
	 *            zone information
	 * @return JSON data <br />
	 *         { name: <i>zone name</i>, <br />
	 *         &nbsp; host: <i>server hostname or IP address</i>, <br />
	 *         &nbsp; usersOn: <i>total number of active users</i>, <br />
	 *         &nbsp; maxUsers: <i>maximum number of users allowed</i>, <br />
	 *         &nbsp; bg: <i>zone icon background image</i>, <br />
	 *         &nbsp; assetPath: <i>path to resolve assets; default is
	 *         ""</i>, <br />
	 *         &nbsp; buddies: <i>number of online buddies for the
	 *         selected user</i> <br />
	 * @throws JSONException if something can't be encoded in JSON
	 */

	public JSONObject getZoneData_JSON (final AbstractUser user)
	throws JSONException {
		final String zoneName = getName ();
		final JSONObject zoneData = new JSONObject ();
		zoneData.put ("name", zoneName);
		zoneData.put ("host", myServer);
		zoneData.put ("usersOn", String.valueOf (getAllUsersInZone ()
				.size ()));
		zoneData.put ("maxUsers", String.valueOf (getMaxUsers ()));
		zoneData.put ("bg", getBackgroundImage ());
		zoneData.put ("assetPath", "");
		zoneData
		.put (
				"buddies",
				AppiusConfig
				.getConfigBoolOrTrue ("org.starhope.appius.zone.showBuddies") ? String
						.valueOf (getBuddiesForUser (user))
						: "0");
		return zoneData;
	}

	/**
	 * Get the set of all zones active (and not hidden nor retired) in
	 * JSON form. Hidden zones begin with a “$”
	 *
	 * @param user the user whose buddy list will be used to get the
	 *            buddy counts on each zone
	 * @return a zoneList object to be passed to the client
	 */

	public JSONObject getZoneList_JSON (final AbstractUser user) {
		/*
		 * Generate the zone list
		 */
		final JSONObject zoneList = new JSONObject ();
		final LinkedList <Zone> zones = AppiusClaudiusCaecus
		.getAllZones ();
		final Iterator <Zone> zoneIterator = zones.iterator ();

		int i = 0;
		while (zoneIterator.hasNext ()) {
			final Zone z = zoneIterator.next ();

			final String zoneName = z.getName ();
			if (zoneName.charAt (0) != '$'
					&& !myEmptyZones.contains (zoneName)) {
				try {
					zoneList.put (String.valueOf (i++ ), z
							.getZoneData_JSON (user));
				} catch (final JSONException e) {
					AppiusClaudiusCaecus.reportBug (e);
				}
			}

		}
		return zoneList;
	}

	/**
	 * Once the server indicates its readiness, begin spawning
	 * auto-spawning Zones
	 * <p>
	 * XXX: contains SQL
	 * </p>
	 */
	synchronized void handleServerReady () {
		if (myName.length () == 0) {
			trace ("Unnamed zone already reports readiness");
		}
		trace ("Now ready in zone " + myName);
		trace ("(re-)loading censorship for " + myName);

		try {
			censor.loadLists (AppiusConfig.getDatabaseConnection ());
		} catch (final SQLException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		}

		serverReady = true;
		if ("$Eden".equals (myName)) {
			trace ("In the beginning, the Zones were void (¿or was it null or undef?).");
		}

	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.lang.Object#hashCode()
	 */

	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getURL ());
	}

	/**
	 * Determine whether the Zone contains a room with the given moniker.
	 * @param moniker The moniker for which to check
	 * @return true, if such a room exists.
	 */
	public boolean hasRoom (final String moniker) {
		return roomsByMoniker.contains (moniker);
	}

	/**
	 * This is an overriding method.
	 * <p>
	 * XXX: contains SQL
	 * </p>
	 * 
	 * @see org.starhope.appius.game.Zone#init()
	 */

	public void init () {
		trace ("(" + this.getClass ().toString () + " in " + myName
				+ ")");

		if ("$Eden".equals (myName)) {
			trace ("Since this is the login zone, clear all zone ownerships…");
			Connection con = null;
			PreparedStatement st = null;
			try {
				con = AppiusConfig.getZonesDatabaseConnection ();
				st = con
				.prepareStatement ("UPDATE zones SET priority=2, serverName=? WHERE priority=-2");
				st.setString (1, AppiusClaudiusCaecus
						.getServerHostname ());
				st.executeUpdate ();
			} catch (final SQLException e1) {
				BugReporter.getReporter ("srv").reportBug (e1);
				return;
			} finally {
				LibMisc.closeAll (st, con);
			}
			trace ("Login zone initialized");
		}
	}

	/**
	 * Check over Zone spawn
	 *
	 * @return WRITEME
	 */
	boolean isItGood () {
		final Room initialLobby = getNextLobby ();
		if (null == initialLobby) {
			throw AppiusClaudiusCaecus
			.fatalBug ("lobby has gone away ");
		}
		AppiusClaudiusCaecus.blather ("lobby vars count = "
				+ initialLobby.getVariables ().size ());
		if ("".equals (initialLobby.getVariable ("s"))) {
			throw AppiusClaudiusCaecus.fatalBug ("lobby has no sky");
		}
		// if ("".equals (initialLobby.getVariable ("w"))) {
		// throw AppiusClaudiusCaecus
		// .fatalBug ("lobby has no weather");
		// }
		if ("".equals (initialLobby.getVariable ("f"))) {
			throw AppiusClaudiusCaecus.fatalBug ("lobby has no floor");
		}

		if ( !User.isItGood ()) {
			return false;
		}

		trace ("And root spoke over the waters, and said: let there be "
				+ getName () + ", and it was good.");
		return true;
	}

	/**
	 * Load game events specified in the database
	 */
	void loadGameEvents () {
		for (final String className : Zone.getDefaultGameEvents ()) {
			addGameEventByClass (className);
		}
	}

	/**
	 * @param in object input stream
	 * @throws IOException if something bad happens
	 * @throws ClassNotFoundException yeah. maybe.
	 */
	@SuppressWarnings ("unchecked")
	public void readExternal (final ObjectInput in) throws IOException,
	ClassNotFoundException {
		badges.clear ();
		lobbies.clear ();
		try {
			final JSONObject badgesIn = new JSONObject (in.readUTF ());
			final Iterator <String> badgeKeys = badgesIn.keys ();
			while (badgeKeys.hasNext ()) {
				final String key = badgeKeys.next ();
				badges.put (key, Room.getByMoniker (badgesIn
						.getString (key), this));
			}
			final JSONObject lobbiesIn = new JSONObject (in.readUTF ());
			final Iterator <String> lobbyKeys = lobbiesIn.keys ();
			while (lobbyKeys.hasNext ()) {
				final String key = lobbyKeys.next ();
				lobbies.add (Room.getByMoniker (lobbiesIn
						.getString (key), this));
			}
		} catch (final JSONException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a JSONException in readExternal", e);
		}
		cullRooms.clear ();
		myEmptyZones.clear ();
	}

	/**
	 * Registers a channel with this zone
	 * 
	 * @param channel
	 */
	public void registerChannel (final Channel channel) {
		channels.put (channel.getMoniker (), channel);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @param thing
	 * @see org.starhope.appius.game.Zone#remove(AbstractUser)
	 */

	public void remove (final AbstractUser thing) {
		PhysicsScheduler.removePersonOfInterest (thing);
		if ( ! (thing instanceof GeneralUser)) {
			throw AppiusClaudiusCaecus
			.fatalBug ("Non-local user leaving local Zone? "
					+ thing.toString ());
		}
		final GeneralUser user = (GeneralUser) thing;
		if (null != user.getRoom ()) {
			user.getRoom ().part (user);
		}
		for (Channel channel : channels.values ()) {
			channel.part (user);
		}
		zoneUsers.remove (user);
		user.setZone (null);
	}

	/**
	 * Remove an event from this Zone
	 *
	 * @param ev event
	 */
	public void remove (final GameEvent ev) {
		ev.destroySelf ();
		gameEvents.remove (ev);
	}

	/**
	 * Stop accepting new users
	 */

	public void retire () {
		AppiusClaudiusCaecus.wallops (Nomenclator.getSystemUser (),
				"Retiring Zone: “" + getName () + "”");
		Zone.retiredZones.add (this);
		// for (final AbstractUser u : zoneUsers) {
		// try {
		// Zone zone = TheZones.findLightZone ();
		// if (null != zone)
		// u.sendMigrate (zone);
		// } catch (final UserDeadException e) {
		// AppiusClaudiusCaecus
		// .reportBug (
		// "Caught a UserDeadException in Zone.retire ",
		// e);
		// }
		// }
		TheZones.local ().remove (this);
		try {
			Thread.sleep (AppiusConfig.getIntOrDefault (
					"org.starhope.appius.zone.retireTimeout", 300));
		} catch (final InterruptedException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a InterruptedException in Zone.retire ", e);
		}
		for (final AbstractUser u : zoneUsers) {
			if (u.isOnline ()) {
				final ServerThread serverThread = u.getServerThread ();
				if (null != serverThread) {
					serverThread.close ();
				}
			}
		}
	}

	/**
	 * send badges to an given user in this zone
	 *
	 * @param user the user to whom to send badges
	 */
	private void sendBadges (final AbstractUser user) {
		final JSONObject notify = getAllBadges_JSON ();
		sendSuccessReply ("badgeUpdate", notify, user, user
				.getRoomNumber ());

	}

	/**
	 * <p>
	 * Send the user a notification that their password was incorrect
	 * </p>
	 *
	 * @param nick nick
	 * @param channel server thread
	 * @param user user
	 * @param zoneName my name
	 * @param password password sha1
	 * @deprecated Use
	 *             {@link ServerThread#sendBadPassword(Zone, User, String)}
	 */
	@Deprecated
	protected void sendBadPassword (final String nick,
			final ServerThread channel, final User user,
			final String zoneName, final String password) {
		channel.sendBadPassword (this, user, password);
	}

	/**
	 * <p>
	 * Sends a buddy notice message to the client
	 * </p>
	 * <code>
		{ from: buddyNotice, status: true,
		  notice: { buddy: name, online: boolean,
		            room: moniker, roomName: title } }
		</code>
	 * <p>
	 * XXX doesn't belong here
	 * </p>
	 *
	 * @param buddyName WRITEME
	 * @param isOnline WRITEME
	 * @param roomMoniker WRITEME
	 * @param roomTitle WRITEME
	 * @param u WRITEME
	 * @param room WRITEME
	 * @throws JSONException WRITEME
	 */
	protected void sendBuddyNotice (final String buddyName,
			final boolean isOnline, final String roomMoniker,
			final String roomTitle, final GeneralUser u, final int room)
	throws JSONException {
		final JSONObject notice = new JSONObject ();
		notice.put ("buddy", buddyName);
		notice.put ("online", isOnline);
		notice.put ("roomMoniker", roomMoniker);
		notice.put ("roomTitle", roomTitle);
		final JSONObject reply = new JSONObject ();
		reply.put ("notice", notice);
		u.acceptSuccessReply ("buddyNotice", reply, roomsByID
				.get (Integer.valueOf (room)));
	}

	/**
	 * <p>
	 * send an error packet to the client.
	 * </p>
	 *
	 * @param source The method returning the error message
	 * @param error The error message
	 * @param result The payload, if any. May be altered.
	 * @param u The user to whom to send the success reply
	 * @param room The room in which the user is standing
	 * @throws JSONException WRITEME
	 * @deprecated use
	 *             {@link ServerThread#sendErrorReply(String, String, JSONObject, User, int)}
	 */
	@Deprecated
	public void sendErrorReply (final String source,
			final String error, final JSONObject result, final User u,
			final int room) throws JSONException {
		try {
			u.getServerThread ().sendErrorReply (source, error, result,
					u, room);
		} catch (final UserDeadException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a UserDeadException in sendErrorReply", e);
		}
	}

	/**
	 * <p>
	 * Sends an (anonymous) moderator message to the user
	 * </p>
	 *
	 * @param room The room the user is in
	 * @param user The user to whom to send the message
	 * @param message The moderator message to be sent
	 */
	public void sendModMessage (final Room room,
			final GeneralUser user, final String message) {
		if (null == user) {
			return;
		}
		try {
			user.getServerThread ().sendAdminMessage (message, "",
					"MODERATOR", false);
		} catch (final UserDeadException e) {
			// Mod message, oops.
		}
	}

	/**
	 * Tell the user to bugger off, because they don't exist
	 *
	 * @param recipients WRITEME
	 * @param nick WRITEME
	 * @param zoneName WRITEME
	 * @param password WRITEME
	 * @deprecated use
	 *             {@link ServerThread#sendNoSuchUser(String,String,String)}
	 */
	@Deprecated
	protected void sendNoSuchUser (
			final LinkedList <ServerThread> recipients,
			final String nick, final String zoneName,
			final String password) {
		for (final ServerThread thread : recipients) {
			thread.sendNoSuchUser (nick, zoneName, password);
		}
	}

	/**
	 * Sends the user the private message /00p$
	 *
	 * @param u the user to whom we want to send the Oops message
	 * @deprecated use {@link AbstractUser#sendOops()}
	 */
	@Deprecated
	public void sendOops (final GeneralUser u) {
		u.sendOops ();
	}

	/**
	 * Send a reply with a success indicator to a list of recipients.
	 *
	 * @param source The method returning the success message
	 * @param resultIn The payload, if any. May be altered.
	 * @param u The user to whom to send the success reply
	 * @param room The room in which the user is standing
	 * @deprecated Call
	 *             {@link AbstractUser#acceptSuccessReply(String, JSONObject, Room)}
	 *             directly
	 */
	@Deprecated
	public void sendSuccessReply (final String source,
			final JSONObject resultIn, final AbstractUser u,
			final int room) {
		u.acceptSuccessReply (source, resultIn, roomsByID.get (Integer
				.valueOf (room)));
	}

	/**
	 * @see ServerThread#sendSuccessReply
	 * @param source WRITEME
	 * @param resultIn WRITEME
	 * @param u WRITEME
	 * @param room WRITEME
	 * @param recipient WRITEME
	 * @throws JSONException WRITEME
	 * @deprecated Use
	 *             {@link ServerThread#sendSuccessReply(String,JSONObject,AbstractUser,int)}
	 *             instead
	 */
	@Deprecated
	public void sendSuccessReply (final String source,
			final JSONObject resultIn, final AbstractUser u,
			final int room, final ServerThread recipient)
	throws JSONException {
		recipient.sendSuccessReply (source, resultIn, u, room);
	}

	/**
	 * Send a "from:wardrobe" message to the user
	 *
	 * @param user WRITEME
	 * @param ignored Ignored parameter. Null is a good answer.
	 * @param room WRITEME
	 * @throws JSONException WRITEME
	 */
	void sendWardrobe (final AbstractUser user, final Object ignored,
			final int room) throws JSONException {
		user.sendWardrobe ();
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.Zone#setAutoJoinRoom(int)
	 */

	public void setAutoJoinRoom (final int id) {
		lobbies.add (getRoom (Integer.valueOf (id)));
	}

	/**
	 * set a badge upon a room
	 *
	 * @param badge the badge to be set
	 * @param room the room upon which the badge is to be set
	 */

	public void setBadge (final String badge, final Room room) {
		badges.put (badge.toLowerCase (Locale.ENGLISH), room);
		badgesChanged ();
	}

	/**
	 * @param server {@link #myServer}
	 */
	public void setMyServer (final String server) {
		myServer = server;
	}

	/**
	 * @see java.lang.Object#toString()
	 */

	@Override
	public String toString () {
		return "Zone “" + getName () + "”";
	}

	/**
	 * Record an entry to the system logs as a zone-wide event. XXX:
	 * eventually, migrate to
	 * {@link AppiusClaudiusCaecus#blather(String, String, String, String, boolean)}
	 * 
	 * @param string a trace string to emit
	 */
	public void trace (final String string) {
		System.err.println (new java.util.Date ().toString () + " ["
				+ "Zone “" + myName + "”] " + string);
	}

	/**
	 * Unregisters a channel with this zone
	 * 
	 * @param channel a channel
	 */
	public void unregisterChannel (final Channel channel) {
		channels.remove (channel.getMoniker ());
	}
	
	/**
	 * check whether the users who we think are in this Zone, are in
	 * fact, in this Zone.
	 */
	private void validateUserList () {
		for (final AbstractUser user : zoneUsers) {
			if ( !user.isOnline ()) {
				zoneUsers.remove (user);
			} else if (user.getZone () != this) {
				zoneUsers.remove (user);
			}
		}
	}

}
