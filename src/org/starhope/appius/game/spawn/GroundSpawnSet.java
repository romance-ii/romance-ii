/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public
 * License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.game.spawn;

import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Zone;
import org.starhope.appius.game.actions.ActionEventAreaEnter;
import org.starhope.appius.game.actions.ActionEventAreaEnterHandler;
import org.starhope.appius.game.rooms.ItemPlace;
import org.starhope.appius.game.rooms.PointPlace;
import org.starhope.appius.game.Room;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.appius.util.WeakRecord;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class GroundSpawnSet extends SimpleDataRecord <GroundSpawnSet> {

	/**
	 * WRITEME: Document this type.
	 *
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
	 */
	private class SpawnInfo {

		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		final private int hashcode;

		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		int max;

		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		int min;

		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		WeakRecord <GroundSpawn> spawn;

		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		int weight;

		/**
		 * WRITEME: Document this constructor ewinkelman@resinteractive.com
		 *
		 * @param spawnSetID WRITEME 
		 * @param min WRITEME 
		 * @param max WRITEME 
		 * @param weight WRITEME 
		 */
		public SpawnInfo (final int spawnSetID, final int min, final int max, final int weight) {
			spawn = new WeakRecord <GroundSpawn> (GroundSpawn.class, spawnSetID);
			hashcode = spawnSetID;
			this.min = min;
			this.max = max;
			this.weight = weight;
		}

		/**
		 * WRITEME: Document this method ewinkelman@resinteractive.com
		 *
		 * @param point WRITEME 
		 * @param itemPrefix WRITEME 
		 * @param eventPrefix WRITEME 
		 */
		void clear (final PointPlace point, final String itemPrefix, final String eventPrefix) {
			point.getRoom ().setVariable (eventPrefix, null);
			point.getRoom ().setVariable ("mc~" + itemPrefix, "magicBox,depart");
			AppiusClaudiusCaecus.getKalendor ().schedule (System.currentTimeMillis () + 5000, new Runnable () {

				@Override
				public void run () {
					point.getRoom ().setVariable (itemPrefix, null);
					point.getRoom ().setVariable ("mc" + itemPrefix, null);
				}
			});}

		/**
		 * @see java.lang.Object#equals(java.lang.Object)
		 */
		@Override
		public boolean equals (final Object obj) {
			if (this == obj) { return true; }
			if (obj == null) { return false; }
			if ( ! (obj instanceof SpawnInfo)) { return false; }
			final SpawnInfo other = (SpawnInfo) obj;
			if (hashcode != other.hashcode) {
				return false;
			}
			return true;
		}

			/**
			 * @see java.lang.Object#hashCode()
			 */
			@Override
			public int hashCode () {
				return hashcode;
			}

		/**
		 * WRITEME: Document this method ewinkelman@resinteractive.com
		 *
		 * @param point WRITEME 
		 */
		public void place (final PointPlace point) {
			final int placeID = nextPlaceID.getAndIncrement ();
			final String itemPrefix = "gsi" + name + placeID;
			final String eventPrefix = "gse" + name + placeID;
			// Set item
			point.getRoom ().setVariable (itemPrefix,
					ItemPlace.createRoomVar (point.getLocation (), spawn.get ().getRealItem ().getRealID (), "S"));
			final int deflection = spawn.get ().getEventRadius ();
			final int left = (int) point.getLocation ().getX () - deflection;
			final int right = (int) point.getLocation ().getX () + deflection;
			final int top = (int) point.getLocation ().getY () - deflection;
			final int bottom = (int) point.getLocation ().getY () + deflection;
			point.getRoom ().setVariable (
					eventPrefix,
					"{\"type\":\"event\",\"area\":[[" + left + "," + top + "],[" + right + "," + top + "],[" + right
							+ "," + bottom + "],[" + left + "," + bottom
							+ "]],\"reqs\":{\"paid\":true},\"eventType\":\""
							+ spawn.get ().getEventType ().getMoniker () + "\"}");

			final ActionEventAreaEnterHandler handler = new ActionEventAreaEnterHandler () {

				@Override
				public void invoke (final ActionEventAreaEnter action) {
					if (action.getEventArea ().equals (eventPrefix)) {
						point.getRoom ().unsubscribe (this);
						clear (point, itemPrefix, eventPrefix);
					}
				}
			};
			point.getRoom ().subscribe (handler);
			if (maxLife > 0 && minLife > 0) {
				AppiusClaudiusCaecus.getKalendor ().schedule (
						AppiusConfig.getRandomLong (System.currentTimeMillis () + minLife, System.currentTimeMillis ()
								+ maxLife), new Runnable () {

							@Override
							public void run () {
								point.getRoom ().unsubscribe (handler);
								clear (point, itemPrefix, eventPrefix);
							}
						});
			}
		}
	}

	/**
	 * Next ID for the next generated room
	 */
	final AtomicInteger nextPlaceID = new AtomicInteger ();

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = 4488478582428187142L;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final Map <SpawnInfo, Integer> activeSpawns = Collections
			.synchronizedMap (new HashMap <SpawnInfo, Integer> ());

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final Set <SpawnInfo> availableSpawns = Collections.synchronizedSet (new HashSet <SpawnInfo> ());

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int hashcode;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int id;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	long maxLife;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int maxSpawnsPerRoom;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	long minLife;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String name;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String pointGroup;

	/**
	 * Set of rooms the loot will spawn inside
	 */
	private final HashSet <String> rooms = new HashSet <String> ();

	/**
	 * How many spawns this set will have at any given time
	 */
	private int spawns;

	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 *
	 * @param loader WRITEME 
	 */
	public GroundSpawnSet (final RecordLoader <GroundSpawnSet> loader) {
		super (loader);
	}

	/**
	 * Adds a room to the list of rooms that this set will spawn in
	 *
	 * @param roomMoniker WRITEME 
	 */
	public void addRoom (final String roomMoniker) {
		rooms.add (roomMoniker);
	}

	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 *
	 * @param groundSpawnID WRITEME 
	 * @param min WRITEME 
	 * @param max WRITEME 
	 * @param weight WRITEME 
	 */
	public void addSpawn (final int groundSpawnID, final int min, final int max, final int weight) {
		availableSpawns.add (new SpawnInfo (groundSpawnID, min, max, weight));
	}

	/**
	 * Clears out all spawns from the set
	 */
	public void clearSpawns () {
		availableSpawns.clear ();
	}

	/**
	 * Does the bulk of the work for spawning, despawning and otherwise managing spawns associated with this spawn set
	 *
	 * @param zone WRITEME 
	 */
	public void doSpawn (final Zone zone) {
		synchronized (activeSpawns) {
			if (activeSpawns.size () < spawns) {
				// find the next ground spawn to spawn
				final SpawnInfo newSpawn = findNextSpawn ();

				// Get a list of all eligible points
				final List <PointPlace> places = new LinkedList <PointPlace> ();
				for (final String roomMoniker : rooms) {
					final Room room = zone.getRoom (roomMoniker, null);
					places.addAll (room.getPoints (pointGroup));
				}

				// Pick our point (equal chances for all points)
				final PointPlace point = places.get (AppiusConfig.getRandomInt (0, places.size () - 1));

				// Places the new event area and spawns the appropriate stuff
				newSpawn.place (point);
			}
		}
	}

	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) { return true; }
		if (obj == null) { return false; }
		if ( ! (obj instanceof GroundSpawnSet)) { return false; }
		final GroundSpawnSet other = (GroundSpawnSet) obj;
		if (id != other.id) {
			return false;
		}
		return true;
	}

	/**
	 * Finds the next spawn that needs
	 *
	 * @return WRITEME 
	 */
	private SpawnInfo findNextSpawn () {
		int totalWeight = 0;

		// Total up weights while also scanning to see if any minimum spawn levels need to be taken care of
		for (final SpawnInfo info : availableSpawns) {
			totalWeight += info.weight;
			final int activeSpawnCount = activeSpawns.containsKey (info) ? activeSpawns.get (info).intValue () : 0;
			if (info.min > activeSpawnCount)
			 {
				return info; // Found a spawn that has a minimum level that needs to be
																// take care of
			}
		}

		int target = AppiusConfig.getRandomInt (0, totalWeight - 1);

		// Try to find a random spawn
		for (final SpawnInfo info : availableSpawns) {
			target -= info.weight;
			if (target < 0)
			 {
				return info; // Found a random spawn to add to the list
			}
		}

		return null;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return id;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return name;
	}

	/**
	 * @return the id
	 */
	public int getID () {
		return id;
	}

	/**
	 * @return the maxLife
	 */
	public long getMaxLife () {
		return maxLife;
	}

	/**
	 * @return the maxSpawnsPerRoom
	 */
	public int getMaxSpawnsPerRoom () {
		return maxSpawnsPerRoom;
	}

	/**
	 * @return the minLife
	 */
	public long getMinLife () {
		return minLife;
	}

	/**
	 * @return the name
	 */
	public String getName () {
		return name;
	}

	/**
	 * @return the pointGroup
	 */
	public String getPointGroup () {
		return pointGroup;
	}

	/**
	 * @return the spawns
	 */
	public int getSpawns () {
		return spawns;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return hashcode;
	}

	/**
	 * @param id the id to set
	 */
	public void setID (final int id) {
		this.id = id;
		final int prime = 31;
		final int result = 1;
		hashcode = prime * result + id;
	}

	/**
	 * @param maxLife the maxLife to set
	 */
	public void setMaxLife (final long maxLife) {
		this.maxLife = maxLife;
	}

	/**
	 * @param maxSpawnsPerRoom the maxSpawnsPerRoom to set
	 */
	public void setMaxSpawnsPerRoom (final int maxSpawnsPerRoom) {
		this.maxSpawnsPerRoom = maxSpawnsPerRoom;
	}

	/**
	 * @param minLife the minLife to set
	 */
	public void setMinLife (final long minLife) {
		this.minLife = minLife;
	}

	/**
	 * @param name the name to set
	 */
	public void setName (final String name) {
		this.name = name;
	}

	/**
	 * @param pointGroup the pointGroup to set
	 */
	public void setPointGroup (final String pointGroup) {
		this.pointGroup = pointGroup;
	}

	/**
	 * @param spawns the spawns to set
	 */
	public void setSpawns (final int spawns) {
		this.spawns = spawns;
	}

	/**
	 * Removes all active spawns from the world
	 */
	public void shutdown () {
		synchronized (activeSpawns) {}
	}

}
