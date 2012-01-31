/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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

import java.io.Serializable;

/**
 * What style(s) of vehicles are permitted in a room, and where. Note
 * that this relies upon vehicles being both equipped in the vehicle
 * slot, and also providing a passive effects system that can be
 * interrogated as to the nature of the vehicle.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class VehicleStyle implements Serializable {
	/**
	 * Any vehicles are allowed, anywhere, there are no limits; default
	 * for Tootsville™ and any room that does not express a preference.
	 */
	public static final VehicleStyle ANY = new VehicleStyle (true,
			true, true, false);
	/**
	 * All vehicles are only allowed, but only allowed in the $drive
	 * space in the room.
	 */
	public static final VehicleStyle DRIVE_ON_DRIVE = new VehicleStyle (
			true, true, true, true);
	/**
	 * No vehicles are permitted, at all. Note that there is an
	 * exceptional case available for specific vehicles that might
	 * occupy a vehicle slot, but not be considered as vehicles, e.g.
	 * in Tootsville the Lightfield is equipped as a vehicle.
	 * Wheelchairs or similar might likewise be exempted.
	 */
	public static final VehicleStyle NO_VEHICLES = new VehicleStyle (
			false, false, false, false);
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 4654869466762704564L;
	/**
	 * Limit vehicles to the driveable space defined as $drive
	 */
	private final boolean limitToDriveSpace;
	/**
	 * Whether floating (in the sense of flying) vehicles are permitted
	 */
	private final boolean permitFloating;
	/**
	 * Whether mounted vehicles (e.g. horses) are permitted
	 */
	private final boolean permitMounts;
	/**
	 * Whether wheeled or dragged (e.g. ski) vehicles are permitted.
	 */
	private final boolean permitWheeled;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param allowWheeled allow wheeled, dragged, and similar objects
	 * @param allowMounted allow mounts such as horses, dogs, dragons,
	 *             whatever
	 * @param allowFloating allow floating vehicles
	 * @param driveOnDrive limit vehicles to only the driveway
	 */
	public VehicleStyle (final boolean allowWheeled,
			final boolean allowMounted, final boolean allowFloating,
			final boolean driveOnDrive) {
		permitWheeled = allowWheeled;
		permitMounts = allowMounted;
		permitFloating = allowFloating;
		limitToDriveSpace = driveOnDrive;
	}
	
	/**
	 * @return the limitToDriveSpace
	 */
	public boolean isLimitToDriveSpace () {
		return limitToDriveSpace; /* TODO brpocock@star-hope.org */
	}
	
	/**
	 * @return the permitFloating
	 */
	public boolean isPermitFloating () {
		return permitFloating; /* TODO brpocock@star-hope.org */
	}
	
	/**
	 * @return the permitMounts
	 */
	public boolean isPermitMounts () {
		return permitMounts; /* TODO brpocock@star-hope.org */
	}
	
	/**
	 * @return the permitWheeled
	 */
	public boolean isPermitWheeled () {
		return permitWheeled; /* TODO brpocock@star-hope.org */
	}
	
}
