/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, twheys@gmail.com
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
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 */
package org.starhope.rahab.util;

/**
 * WRITEME: Document this type. twheys@gmail.com Dec 30, 2009
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys Timothy W. Heys
 */
public class Zone {
	
	/**
	 *
	 */
	private int numberOfUsers = 0;
	/**
	 *
	 */
	private String zoneHost = "";
	
	/**
	 *
	 */
	private String zoneName = "";
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * A Zone WRITEME...
	 * 
	 * @param newZone WRITEME
	 * @param newZoneHost WRITEME
	 * @param newZoneUsers WRITEME
	 */
	public Zone (final String newZone, final String newZoneHost,
			final int newZoneUsers) {
		zoneName = newZone;
		zoneHost = newZoneHost;
		numberOfUsers = newZoneUsers;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO getNumberOfUsers WRITEME...
	 * 
	 * @return WRITEME
	 */
	public int getNumberOfUsers () {
		// default getter (twheys@gmail.com, Aug 19, 2009)
		return numberOfUsers;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO getZoneHost WRITEME...
	 * 
	 * @return WRITEME
	 */
	public String getZoneHost () {
		// default getter (twheys@gmail.com, Aug 19, 2009)
		return zoneHost;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO getZoneName WRITEME...
	 * 
	 * @return WRITEME
	 */
	public String getZoneName () {
		// default getter (twheys@gmail.com, Aug 19, 2009)
		return zoneName;
	}
	
	/**
	 * aram numberOfUsers1 WRITEME
	 * 
	 * @param numberOfUsers1 WRITEME
	 */
	public void setNumberOfUsers (final int numberOfUsers1) {
		// default setter (twheys@gmail.com, Aug 19, 2009)
		numberOfUsers = numberOfUsers1;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO setZoneHost WRITEME...
	 * 
	 * @param zoneHost1 WRITEME
	 */
	public void setZoneHost (final String zoneHost1) {
		// default setter (twheys@gmail.com, Aug 19, 2009)
		zoneHost = zoneHost1;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO setZoneName WRITEME...
	 * 
	 * @param zoneName1 WRITEME
	 */
	public void setZoneName (final String zoneName1) {
		// default setter (twheys@gmail.com, Aug 19, 2009)
		zoneName = zoneName1;
	}
}
