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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.sys.admin.TheZones;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AcceptsMetronomeTicks;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.GetsConfigReload;
import org.starhope.util.LibMisc;

/**
 * Thread to manage automated zone spawn/retirement
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class ZoneSpawner implements AcceptsMetronomeTicks,
		Comparable <AcceptsMetronomeTicks>, GetsConfigReload {
	
	/**
	 * a lock for zone spawning
	 */
	private static Lock lock = new ReentrantLock ();
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (ZoneSpawner.class);
	
	/**
	 * the server to which this Zone Spawner belongs
	 */
	public static String myServer;
	
	/**
	 * Zones which have been Retired may still be in play (there are
	 * probably users in them), but new users cannot see them or join
	 * them. They have been retired pending destruction, once all
	 * current players have signed off.
	 */
	private final static Set <Zone> retiredZones = new HashSet <Zone> ();
	
	/**
	 * Max users allowed into one room of an user's house at a time
	 */
	private static int USER_ROOM_MAX_USERS = Integer
			.parseInt (AppiusConfig.getConfigOrDefault (
					"org.starhope.appius.userRoom.maxUsers", "10"));
	
	/**
	 * Get the percentage of "full" at which we consider a zone to be
	 * full enough to warrant spawning new ones.
	 */
	private static double ZONE_FULL_RATIO = Double
			.parseDouble (AppiusConfig.getConfigOrDefault (
					"org.starhope.appius.zones.fullRatio", "0.8"));
	
	/**
	 * Get the percentage of "full" at which we consider a zone to be
	 * light enough that it's almost empty
	 */
	static double ZONE_LIGHT_RATIO = Double
			.parseDouble (AppiusConfig.getConfigOrDefault (
					"org.starhope.appius.zones.lightRatio", "0.2"));
	
	/**
	 * The max. users per Zone (And per every room in every real zone)
	 */
	private static int ZONE_MAX_USERS = Integer.parseInt (AppiusConfig
			.getConfigOrDefault (
					"org.starhope.appius.zones.maxUsers", "500"));
	
	/**
	 * Time (in seconds) between spawning new zones
	 */
	private static int ZONE_SPAWN_SECONDS = Integer
			.parseInt (AppiusConfig
					.getConfigOrDefault (
							"org.starhope.appius.zones.spawnSeconds",
							"30"));
	
	/**
	 * See if enough zones are full to warrant spawning a new one; or,
	 * if zones are empty and can be deallocated.
	 */
	public static void checkZonesForSpawn () {
		
		ZoneSpawner.lock.lock ();
		try {
			
			final long now = System.currentTimeMillis ();
			if (Zone.lastCheckedZonesForSpawn > (now - (ZoneSpawner
					.getZoneSpawnSeconds () * 1000L))) {
				return;
			}
			
			Zone.lastCheckedZonesForSpawn = now;
			
			Zone.cullAllUserRooms ();
			
			final ConcurrentLinkedQueue <Zone> zones = new ConcurrentLinkedQueue <Zone> ();
			zones.addAll (AppiusClaudiusCaecus.getAllZones ());
			
			if (zones.size () < 2) {
				ZoneSpawner.log
						.debug ("It is always dark in the beginning.");
				ZoneSpawner.spawnNewZone ();
				return;
			}
			
			// Get number of zones needed
			// Also populates the empty zone set
			int needZones = ZoneSpawner
					.getNumberOfZonesNeeded (zones);
			
			// create zones
			if (needZones > 0) {
				final int maxZones = AppiusConfig.getIntOrDefault (
						"org.starhope.appius.zones.maxZones", 5);
				if ( (zones.size () + needZones) > maxZones) {
					ZoneSpawner.log.error ("Reached maxZones of "
							+ maxZones + ", but wanted "
							+ needZones + " on top of the "
							+ zones.size () + " already up");
					needZones = Math.min (
							maxZones - zones.size (), 0);
				}
				if (needZones > 0) {
					ZoneSpawner.spawnNeededZones (needZones);
				}
			} else if (needZones == 0) {
				ZoneSpawner.log
						.debug ("The number of zones is just right.");
			} else {
				ZoneSpawner.retireUnneededZones (zones, -needZones);
			}
			
			final Iterator <Zone> retZones = Zone.retiredZones
					.iterator ();
			while (retZones.hasNext ()) {
				final Zone rz = retZones.next ();
				if (rz.getUserCount () == 0) {
					ZoneSpawner.log
							.debug ("Destroying empty zone "
									+ rz.getName ());
					rz.destroy ();
					retZones.remove ();
				}
			}
			
		} finally {
			ZoneSpawner.lock.unlock ();
		}
	}
	
	/**
	 * Returns a zone rated as being “light” traffic. If there are no
	 * light traffic zones, attempt to spawn one. If that fails, then
	 * resort to finding the least-busy zone of all zones visible.
	 * 
	 * @return a zone with relatively light traffic.
	 * @deprecated Use {@link TheZones#findLightZone()} instead
	 */
	@Deprecated
	static Zone findLightZone () {
		return TheZones.findLightZone ();
	}
	
	/**
	 * This is a breakout from {@link #checkZonesForSpawn()} to
	 * determine the number of zones that need to be spawned or removed
	 * ignoring hidden zones
	 * 
	 * @param zones The set of all Zones in the multiverse
	 * @return the (signed) number of zones to be created (positive) or
	 *         removed (negative)
	 */
	private static int getNumberOfZonesNeeded (
			final ConcurrentLinkedQueue <Zone> zones) {
		final double zoneFullRatio = ZoneSpawner.getZoneFullRatio ();
		final Iterator <Zone> zoneIterator = zones.iterator ();
		int zoneCount = 0;
		int totalUsers = 0;
		int totalMax = 0;
		
		while (zoneIterator.hasNext ()) {
			final Zone z = zoneIterator.next ();
			if ( ('$' == z.getName ().charAt (0))
					|| ZoneSpawner.retiredZones.contains (z)) {
				zones.remove (z);
			} else {
				final int numUsers = z.getUserCount ();
				zoneCount++ ;
				totalUsers += numUsers;
				totalMax += ZoneSpawner.ZONE_MAX_USERS;
			}
		}
		
		final double fullNess = totalMax != 0 ? (double) totalUsers
				/ (double) totalMax : 0;
		final double lessFull = (zoneCount - 1) > 0 ? (fullNess * zoneCount)
				/ (zoneCount - 1)
				: Double.MAX_VALUE;
		
		ZoneSpawner.log
				.debug (totalUsers
						+ " users online out of a potential maximum of "
						+ totalMax
						+ " users; fullness="
						+ String.format ("%9.2f",
								Double.valueOf (fullNess)));
		
		return fullNess > zoneFullRatio ? 1
				: lessFull < zoneFullRatio ? -1 : 0;
	}
	
	/**
	 * @return get the max number of users allowed in an user's
	 *         house/rooms
	 */
	public static int getUserRoomMaxUsers () {
		return ZoneSpawner.USER_ROOM_MAX_USERS;
	}
	
	/**
	 * @return the ratio of its capacity at which we declare that a
	 *         zone is “full,” and do not allow it to accept more
	 *         users. Each lightly-filled or empty zone counteracts a
	 *         full zone when deciding whether to spawn additional
	 *         zones.
	 */
	private static double getZoneFullRatio () {
		return ZoneSpawner.ZONE_FULL_RATIO;
	}
	
	/**
	 * @return the ratio of its capacity at which we declare that a
	 *         zone is “lightly used,” and assume that it can absorb
	 *         more users. Each lightly-filled or empty zone
	 *         counteracts a full zone when deciding whether to spawn
	 *         additional zones.
	 */
	public static double getZoneLightRatio () {
		return ZoneSpawner.ZONE_LIGHT_RATIO;
	}
	
	/**
	 * @return get the maximum number of users allowed in a zone
	 */
	public static int getZoneMaxUsers () {
		return ZoneSpawner.ZONE_MAX_USERS;
	}
	
	/**
	 * Get the number of seconds between checking for zone spawning
	 * 
	 * @return The interval between checks for spawning zones
	 */
	public static int getZoneSpawnSeconds () {
		return ZoneSpawner.ZONE_SPAWN_SECONDS;
	}
	
	/**
	 * retire any zones which are unneeded, due to population drop
	 * 
	 * @param zones the set of zones to be considered for retirement
	 * @param numZonesToRemove the number of zones to be removed
	 */
	private static void retireUnneededZones (
			final ConcurrentLinkedQueue <Zone> zones,
			final int numZonesToRemove) {
		ZoneSpawner.log.debug ("There are about " + numZonesToRemove
				+ " too many zones.");
		
		// Retiring unneeded zones
		ZoneSpawner.log.debug ("Retiring " + numZonesToRemove
				+ " zones");
		for (int i = 0; i < numZonesToRemove; i++ ) {
			
			Zone leastPopulated = null;
			int leastPopulation = ZoneSpawner.ZONE_MAX_USERS;
			
			for (final Zone currZone : zones) {
				final int currPop = currZone.getUserCount ();
				if ('$' == currZone.getName ().charAt (0)) {
					zones.remove (currZone);
				} else if (currPop < leastPopulation) {
					leastPopulation = currPop;
					leastPopulated = currZone;
				}
			}
			
			if ( (null != leastPopulated) && (zones.size () > 1)) {
				ZoneSpawner.log.debug ("Retiring zone "
						+ leastPopulated.getName ());
				leastPopulated.retire ();
				zones.remove (leastPopulated);
			}
		}
	}
	
	/**
	 * spawn the number of zones needed (in parallel)
	 * 
	 * @param needZones the number of new zones to be spawned
	 */
	private static void spawnNeededZones (final int needZones) {
		ZoneSpawner.log.debug ("I need to spawn " + needZones
				+ " zones.");
		final Set <Thread> spawners = new HashSet <Thread> ();
		for (int i = 0; i < needZones; ++i) {
			ZoneSpawner.log.debug ("Enqueuing spawning a zone...");
			final Thread t = new Thread () {
				@Override
				public void run () {
					ZoneSpawner.spawnNewZone ();
				}
			};
			t.start ();
			spawners.add (t);
		}
		for (final Thread t : spawners) {
			try {
				t.join ();
			} catch (final InterruptedException e) {
				ZoneSpawner.log
						.error ("Caught a InterruptedException in Zone.checkZonesForSpawn ",
								e);
			}
		}
	}
	
	/**
	 * @return spawn a single new zone, and return its name
	 */
	public static String spawnNewZone () {
		final Zone newZone = ZoneSpawner.spawnZone ();
		return null == newZone ? null : newZone.getName ();
	}
	
	/**
	 * spawn a single new zone, and return that Zone
	 * 
	 * @return the newly-spawned Zone (or null, if zone spawn failed)
	 */
	public static Zone spawnZone () {
		ZoneSpawner.log
				.debug ("And it came to pass in those days, that the elephants had increased greatly in numbers, and exceeded the Zones allotted to them. And so a new Zone was called for, from the rolls of Zones that might have been.");
		String zoneName = TheZones.findClaimedZoneName ();
		if ("".equals (zoneName)) {
			zoneName = TheZones.findUnclaimedZoneName ();
			if ("".equals (zoneName)) {
				ZoneSpawner.log
						.debug ("No Zone names remained on the rolls for "
								+ ZoneSpawner.myServer);
				AppiusClaudiusCaecus
						.wallops (Nomenclator.getSystemUser (),
								"All Zone names are in use. Cannot spawn additional zones. Server overload condition. Contact Systems Programmer to expand the Zone list or reduce load by hiring poachers to shoot elephants for their valuable ivory tusks.");
				new AppiusClaudiusCaecus ();
				// + ", so an alternate name was created");
				// if ("".equals (zoneName)) {
				// return spawnZone (genZoneName ());
				// }
			}
		}
		return ZoneSpawner.spawnZone (zoneName);
	}
	
	/**
	 * Create a new, empty zone, and attach the default properties to
	 * it. The zone's image will be “hearts.” FIXME
	 * 
	 * @param zoneName the name of the new zone
	 * @return the zone spawned
	 */
	public static Zone spawnZone (final String zoneName) {
		// final LinkedList <Zone> allZones =
		// AppiusClaudiusCaecus
		// .getAllZones ();
		final String zoneNugget = "hearts";
		// allZones.get (
		// AppiusConfig.getRandomInt (0, allZones.size () - 1))
		// .getRoomByName ("$Eaves").getVariable ("zoneImage");
		return ZoneSpawner.spawnZone (zoneName, zoneNugget);
	}
	
	/**
	 * Create a new, empty zone, and attach the default properties to
	 * it.
	 * 
	 * @param zoneName the name of the new zone
	 * @param image the background nugget icon
	 * @return the new zone spawned (or null, if zone spawn failed)
	 */
	public static Zone spawnZone (final String zoneName,
			final String image) {
		ZoneSpawner.log
				.debug ("...so the Systems Programmer waved his hand across the face of the keyboard, and said: “Let there be "
						+ zoneName + "”");
		final Zone zone = new Zone (zoneName);
		
		if ( !TheZones.activateInDB (zoneName)) {
			zone.destroy ();
			return null;
		}
		
		try {
			ZoneSpawner.spawnZone_addRooms (zone);
			
			// final Room eaves = Room.createPublicRoom ("$Eaves",
			// zone);
			// eaves.setVariable ("zoneImage", image);
			final Room nowhere = zone.getRoom ("nowhere", null);
			nowhere.setLimbo (true);
			
			if ('$' != zoneName.charAt (0)) {
				zone.loadGameEvents ();
			}
			
			if (zone.isItGood ()) {
				zone.activate ();
				
				return zone;
			}
		} catch (final Throwable e) {
			ZoneSpawner.log.error ("Zone spawn failed", e);
			TheZones.releaseZoneInDB (zoneName);
		}
		return null;
	}
	
	/**
	 * While spawning a new zone, add rooms to it. Set the room
	 * variables from the defaults in the database. If the room has a
	 * variable named "lobby," mark it as a lobby. (XXX: scan for
	 * lobbies in real time, not just at zone creation.)
	 * 
	 * @param zone the Zone to which rooms should be added
	 */
	private static void spawnZone_addRooms (final Zone zone) {
		for (final Room theoreticalRoom : org.starhope.appius.game.Room
				.getAllRooms ()) {
			if ( !theoreticalRoom.isAutoCreate ()) {
				continue;
			}
			Room actualRoom;
			try {
				actualRoom = Room.create (
						theoreticalRoom.getFullMoniker (), zone,
						null, 0);
				
				if ("true".equals (actualRoom.getVariable ("lobby"))) {
					zone.setAutoJoinRoom (actualRoom.getID ());
				}
			} catch (final NotFoundException e) {
				ZoneSpawner.log.error ("Exception", e);
			}
		}
	}
	
	/**
	 * Time to next check zones for spawning
	 */
	private long nextCheck = 0;
	
	/**
	 * create a ZoneSpawner object for a given server
	 * 
	 * @param server the hostname of the server
	 */
	public ZoneSpawner (final String server) {
		ZoneSpawner.myServer = server;
		AppiusConfig.wantConfigReload (this);
	}
	
	/**
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final AcceptsMetronomeTicks o) {
		return o.getName ().compareTo (getName ());
	}
	
	/**
	 * When the configuration is updated, update some “constants” used
	 * by the Zone Spawn system from the values in the configuration
	 * file (or in-core configuration overrides)
	 */
	@Override
	public void configUpdated () {
		
		ZoneSpawner.USER_ROOM_MAX_USERS = AppiusConfig
				.getIntOrDefault (
						"org.starhope.appius.userRoom.maxUsers",
						10);
		ZoneSpawner.ZONE_FULL_RATIO = Double
				.parseDouble (AppiusConfig.getConfigOrDefault (
						"org.starhope.appius.zones.fullRatio",
						"0.8"));
		ZoneSpawner.ZONE_LIGHT_RATIO = Double
				.parseDouble (AppiusConfig.getConfigOrDefault (
						"org.starhope.appius.zones.lightRatio",
						"0.8"));
		ZoneSpawner.ZONE_MAX_USERS = Integer.parseInt (AppiusConfig
				.getConfigOrDefault (
						"org.starhope.appius.zones.maxUsers",
						"500"));
		ZoneSpawner.ZONE_SPAWN_SECONDS = Integer
				.parseInt (AppiusConfig.getConfigOrDefault (
						"org.starhope.appius.zones.spawnSeconds",
						"30"));
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if ( ! (obj instanceof ZoneSpawner)) {
			return false;
		}
		return 0 == compareTo ((AcceptsMetronomeTicks) obj);
	}
	
	/**
	 * mark a zone as being free in the database
	 * <p>
	 * XXX: contains SQL
	 * </p>
	 * 
	 * @param zoneName the new zone's name
	 * @return true, if successful.
	 */
	boolean freeInDB (final String zoneName) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getZonesDatabaseConnection ();
			st = con.prepareStatement ("UPDATE zones SET priority=1 WHERE zoneName=? AND serverName=?");
			st.setString (1, ZoneSpawner.myServer);
			st.setString (2, zoneName);
		} catch (final SQLException e1) {
			ZoneSpawner.log.error ("SQLException", e1);
			return false;
		} finally {
			LibMisc.closeAll (st, con);
		}
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.HasName#getName()
	 */
	@Override
	public String getName () {
		return "ZoneSpawner";
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getName ());
	}
	
	/**
	 * @see org.starhope.appius.util.AcceptsMetronomeTicks#tick(long,
	 *      long)
	 */
	@Override
	public void tick (final long currentTime, final long deltaTime)
			throws UserDeadException {
		if (currentTime < nextCheck) {
			return;
		}
		
		ZoneSpawner.checkZonesForSpawn ();
		nextCheck = currentTime
				+ AppiusConfig.getIntOrDefault (
						"org.starhope.appius.zone.spawnTime",
						30000);
		return;
		
	}
}
