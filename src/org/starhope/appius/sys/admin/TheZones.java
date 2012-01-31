/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, brpocock@star-hope.org
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
package org.starhope.appius.sys.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Zone;
import org.starhope.appius.game.ZoneSpawner;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * WRITEME: The documentation for this type (TheZones) is incomplete.
 * (brpocock@star-hope.org, Feb 25, 2010)
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class TheZones implements Collection <Zone> {
	
	/**
	 * The hostname of the cluster leader
	 */
	public static String clusterLeader = null;
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Feb 25,
	 * 2010) dude (TheZones)
	 */
	private final static TheZones dude = new TheZones ();
	
	/**
	 * Users logging in are directed first the this landing zone, and
	 * then choose a Zone server to which they wish to connect (if
	 * multiple Zones have been established).
	 */
	public static Zone loginZone;
	
	/**
	 * <p>
	 * mark a zone as being active in the database, and running on this
	 * host
	 * </p>
	 * <p>
	 * XXX: contains SQL
	 * </p>
	 * 
	 * @param zoneName the new zone's name
	 * @return true, if successful.
	 */
	public static boolean activateInDB (final String zoneName) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getZonesDatabaseConnection ();
			st = con.prepareStatement ("UPDATE zones SET  priority=-2 WHERE serverName=? AND zoneName=? AND priority > 0");
			st.setString (1, ZoneSpawner.myServer);
			st.setString (2, zoneName);
			return 0 < st.executeUpdate ();
		} catch (final SQLException e1) {
			BugReporter.getReporter ("srv").reportBug (e1);
			return false;
		} finally {
			LibMisc.closeAll (st, con);
		}
	}
	
	/**
	 * mark a zone as being claimed in the database, and running on
	 * this host
	 * <p>
	 * XXX: contains SQL
	 * </p>
	 * 
	 * @param zoneName the new zone's name
	 * @return true, if successful.
	 */
	public static boolean claimInDB (final String zoneName) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getZonesDatabaseConnection ();
			st = con.prepareStatement ("UPDATE zones SET serverName=?, priority=2 WHERE zoneName=? AND priority > 0");
			st.setString (1, ZoneSpawner.myServer);
			st.setString (2, zoneName);
			st.executeUpdate ();
		} catch (final SQLException e1) {
			BugReporter.getReporter ("srv").reportBug (e1);
			return false;
		} finally {
			LibMisc.closeAll (st, con);
		}
		return true;
	}
	
	/**
	 * Find a zone name that has been claimed
	 * <p>
	 * XXX: contains SQL
	 * </p>
	 * 
	 * @return a claimed Zone name
	 */
	public static String findClaimedZoneName () {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet zones = null;
		String zoneName = "";
		try {
			con = AppiusConfig.getZonesDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM zones WHERE serverName=? AND priority=2 ORDER BY RAND() LIMIT 1");
			st.setString (1, ZoneSpawner.myServer);
			if (st.execute ()) {
				zones = st.getResultSet ();
				if (zones.next ()) {
					zoneName = zones.getString ("zoneName");
					// spawnZone (zoneName, zones.getString
					// ("image"));
				} else {
					AppiusClaudiusCaecus.blather ("No zones free");
				}
			}
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").fatalBug (e);
		} finally {
			LibMisc.closeAll (zones, st, con);
		}
		return zoneName;
	}
	
	/**
	 * Returns a zone rated as being “light” traffic. If there are no
	 * light traffic zones, attempt to spawn one. If that fails, then
	 * resort to finding the least-busy zone of all zones visible.
	 * 
	 * @return a zone with relatively light traffic.
	 */
	public static Zone findLightZone () {
		Zone zone = null;
		int minUsers = Integer.MAX_VALUE;
		for (final Zone z : AppiusClaudiusCaecus.getAllZones ()) {
			if (z.getUserCount () < minUsers) {
				minUsers = z.getUserCount ();
				zone = z;
			}
		}
		return zone;
	}
	
	/**
	 * find a zone name that isn't claimed by any zone server
	 * <p>
	 * XXX: contains SQL
	 * </p>
	 * 
	 * @return an unclaimed zone name or a null string if all zone
	 *         names are claimed
	 */
	public static String findUnclaimedZoneName () {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet zones = null;
		String zoneName = "";
		try {
			con = AppiusConfig.getZonesDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM zones WHERE serverName=? AND priority=1 ORDER BY RAND() LIMIT 1");
			st.setString (1, ZoneSpawner.myServer);
			if (st.execute ()) {
				zones = st.getResultSet ();
				if (zones.next ()) {
					zoneName = zones.getString ("zoneName");
					if (TheZones.claimInDB (zoneName)) {
						// ("image"));
						return zoneName;
					}
				}
			}
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").fatalBug (e);
		} finally {
			LibMisc.closeAll (zones, st, con);
		}
		return genZoneName ();
	}
	
	/**
	 * WRITEME: Document this method brpocock
	 * 
	 * @return WRITEME  brpocock 
	 */
	private static String genZoneName () {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method genZoneName in TheZones, added Jan 31, 2012 by brpocock. TODO.");
		return null;
	}
	
	/**
	 * Get the TheZones object referring to the local cluster
	 * 
	 * @return the local cluster instance
	 */
	public static TheZones local () {
		return TheZones.dude;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param zoneName WRITEME
	 * @return WRITEME
	 */
	public static boolean releaseZoneInDB (final String zoneName) {
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getZonesDatabaseConnection ();
			st = con.prepareStatement ("UPDATE zones SET priority=1 WHERE serverName=? AND zoneName=? AND priority =2");
			st.setString (1, ZoneSpawner.myServer);
			st.setString (2, zoneName);
			st.executeUpdate ();
		} catch (final SQLException e1) {
			BugReporter.getReporter ("srv").reportBug (e1);
			return false;
		} finally {
			LibMisc.closeAll (st, con);
		}
		return true;
		
	}
	
	/**
	 * all zones active around here, known to exist to the cluster
	 */
	private final HashSet <Zone> theZones = new HashSet <Zone> ();
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#add(java.lang.Object)
	 */
	@Override
	public boolean add (final Zone arg0) {
		return theZones.add (arg0);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#addAll(java.util.Collection)
	 */
	@Override
	public boolean addAll (final Collection <? extends Zone> arg0) {
		return theZones.addAll (arg0);
	}
	
	/**
	 * @return all zones known to exist
	 */
	public Collection <Zone> all () {
		final List <Zone> list = new LinkedList <Zone> ();
		list.addAll (theZones);
		return list;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#clear()
	 */
	@Override
	public void clear () {
		theZones.clear ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#contains(java.lang.Object)
	 */
	@Override
	public boolean contains (final Object arg0) {
		return theZones.contains (arg0);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#containsAll(java.util.Collection)
	 */
	@Override
	public boolean containsAll (final Collection <?> arg0) {
		return theZones.containsAll (arg0);
	}
	
	/**
	 * get a zone by its name
	 * 
	 * @param zoneName the name of the zone
	 * @return the zone
	 * @throws NotFoundException if the zone is not in this cluster
	 */
	public Zone get (final String zoneName) throws NotFoundException {
		for (final Zone z : theZones) {
			if (z.getName ().equals (zoneName)) {
				return z;
			}
			if (z.getName ().equals (zoneName.replace ('_', ' '))) {
				return z;
			}
		}
		throw new NotFoundException (zoneName);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Feb 25,
	 * 2010)
	 * 
	 * @return WRITEME
	 */
	public TheZones getInstance () {
		return TheZones.dude;
	}
	
	/**
	 * Get all zones found on a given server
	 * 
	 * @param serverHostname the server's host name
	 * @return the set of any/all zones for that server
	 */
	public Collection <Zone> getZonesOn (final String serverHostname) {
		
		final Collection <Zone> results = new HashSet <Zone> ();
		
		for (final Zone z : theZones) {
			if (serverHostname.equals (z.getHost ())) {
				results.add (z);
			}
		}
		
		return results;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#isEmpty()
	 */
	@Override
	public boolean isEmpty () {
		return theZones.isEmpty ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#iterator()
	 */
	@Override
	public Iterator <Zone> iterator () {
		return theZones.iterator ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#remove(java.lang.Object)
	 */
	@Override
	public boolean remove (final Object arg0) {
		return theZones.remove (arg0);
	}
	
	/**
	 * Remove a zone from the server
	 * 
	 * @param whichZone The zone to be removed
	 * @return true, if it was found and removed
	 */
	public boolean remove (final Zone whichZone) {
		return theZones.remove (whichZone);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#removeAll(java.util.Collection)
	 */
	@Override
	public boolean removeAll (final Collection <?> arg0) {
		return theZones.removeAll (arg0);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#retainAll(java.util.Collection)
	 */
	@Override
	public boolean retainAll (final Collection <?> arg0) {
		return theZones.retainAll (arg0);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#size()
	 */
	@Override
	public int size () {
		return theZones.size ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#toArray()
	 */
	@Override
	public Object [] toArray () {
		return theZones.toArray ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Collection#toArray(T[])
	 */
	@Override
	public <T> T [] toArray (final T [] arg0) {
		return theZones.toArray (arg0);
	}
	
}
