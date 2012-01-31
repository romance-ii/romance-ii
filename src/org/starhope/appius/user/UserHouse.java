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
package org.starhope.appius.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Room;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.util.LibMisc;

/**
 * <p>
 * The User House object contains the rooms of the user's own house.
 * Each user gets only one house, although we could maybe do some scary
 * linkage things where rooms are discontinuous. There is a hard-coded
 * assertion that room 0 is the main, lobby, entrance room of the user's
 * house, and room 1 is the external front yard.
 * </p>
 * 
 * <pre>
 * CREATE TABLE userHouseRooms (userID INT NOT NULL, roomID DECIMAL(1,0) UNSIGNED NOT NULL, PRIMARY KEY (userID, roomID), CONSTRAINT FOREIGN KEY (userID) REFERENCES users (ID)) ENGINE=InnoDB;
 * </pre>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class UserHouse extends SimpleDataRecord <UserHouse> implements
		Map <Integer, Room> {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -3893501929561618415L;
	
	/**
	 * Whether a room has been instantiated or not
	 */
	private final ConcurrentHashMap <Integer, Boolean> hasRooms = new ConcurrentHashMap <Integer, Boolean> ();
	
	/**
	 * The internal representation of the set of Rooms in the user's
	 * house
	 */
	private final ConcurrentHashMap <Integer, Room> houseRooms = new ConcurrentHashMap <Integer, Room> ();
	
	/**
	 * The view of the house from outside is hacked in like this for
	 * now XXX
	 */
	private int houseTypeID = -1;
	
	/**
	 * The type of lot for the outside is hacked in like this for now
	 * XXX
	 */
	private int lotID = -1;
	
	/**
	 * The owner of this house
	 */
	private final AbstractUser owner;
	
	/**
	 * Instantiate the house of the given user
	 * 
	 * @param newOwner the owner of the house
	 */
	public UserHouse (final AbstractUser newOwner) {
		super (UserHouse.class);
		owner = newOwner;
		
		hasRooms.put (Integer.valueOf (0), Boolean.FALSE);
		hasRooms.put (Integer.valueOf (1), Boolean.FALSE);
		
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT roomID FROM userRooms WHERE userID=?");
			st.setInt (1, newOwner.getUserID ());
			if (st.execute () && (null != (rs = st.getResultSet ()))) {
				while (rs.next ()) {
					final int i = rs.getInt (1);
					hasRooms.put (Integer.valueOf (i),
							Boolean.TRUE);
				}
			}
			
		} catch (final SQLException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a SQLException in UserHouse constructor",
							e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}
	
	/**
	 * WRITEME
	 * 
	 * @param id index
	 */
	public void addRoom (final int id) {
		final Integer [] set = { Integer.valueOf (id) };
		addRooms (set);
	}
	
	/**
	 * Add rooms of the given numbers for the owner
	 * 
	 * @param integers the room numbers
	 */
	private void addRooms (final Integer [] integers) {
		Connection con = null;
		PreparedStatement st = null;
		final ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("INSERT IGNORE INTO userRooms (userID, roomID) VALUES (?,?)");
			st.setInt (1, owner.getUserID ());
			for (final Integer i : integers) {
				st.setInt (2, i.intValue ());
				st.executeUpdate ();
			}
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").reportBug (
					"Caught a SQLException in addRoom", e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Map#clear()
	 */
	@Override
	public void clear () {
		hasRooms.clear ();
		houseRooms.clear ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Map#containsKey(java.lang.Object)
	 */
	@Override
	public boolean containsKey (final Object key) {
		return hasRooms.containsKey (key);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Map#containsValue(java.lang.Object)
	 */
	@Override
	public boolean containsValue (final Object value) {
		return houseRooms.containsValue (value);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Map#entrySet()
	 */
	@Override
	public Set <java.util.Map.Entry <Integer, Room>> entrySet () {
		for (final Integer key : hasRooms.keySet ()) {
			if (Boolean.FALSE.equals (hasRooms.get (key))) {
				instantiateRoom (key);
			}
		}
		return houseRooms.entrySet ();
	}
	
	// /**
	// * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	// 2009)
	// */
	// private void flush() {
	// if (getLotID () > -1) {
	// Connection con = null;
	// PreparedStatement delOld = null;
	// PreparedStatement updateLot = null;
	// try {
	// con = AppiusConfig.getDatabaseConnection ();
	// delOld = con
	// .prepareStatement ("DELETE FROM userHouses WHERE userID=?");
	// delOld.setInt (1, owner.getUserID ());
	// delOld.execute ();
	// } catch (final SQLException e) {
	// if (null != delOld) {
	// try {
	// delOld.close ();
	// delOld = null;
	// } catch (final SQLException e1) { /* No Op */
	// }
	// }
	// if (null != con) {
	// try {
	// con.close ();
	// } catch (final SQLException e1) { /* No Op */
	// }
	// }
	// BugReporter.getReporter("srv").reportBug (
	// "Caught a SQLException in flush_userHouse", e);
	// } finally {
	// LibMisc.closeAll (delOld);
	// }
	// try {
	// if (null == con) {
	// con = AppiusConfig.getDatabaseConnection ();
	// }
	// updateLot = con
	// .prepareStatement
	// ("INSERT INTO userHouses (userID, lotID, houseID) VALUES (?,?,?)");
	// updateLot.setInt (1, owner.getUserID());
	// updateLot.setInt (2, getLotID ());
	// updateLot.setInt (3, getHouseTypeID ());
	// assert updateLot.execute ();
	// } catch (final SQLException e) {
	// BugReporter.getReporter("srv").reportBug (e);
	// } finally {
	// LibMisc.closeAll (updateLot, con);
	// }
	// }
	// }
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Map#get(java.lang.Object)
	 */
	@Override
	public Room get (final Object key) {
		if ( ! (key instanceof Integer)) {
			return null;
		}
		if (Boolean.FALSE.equals (hasRooms.get (key))) {
			instantiateRoom ((Integer) key);
		}
		return houseRooms.get (key);
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return owner.getUserID ();
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () {
		return owner.getAvatarLabel ();
	}
	
	/**
	 * @return the houseType
	 */
	public int getHouseTypeID () {
		return houseTypeID;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Feb 19,
	 * 2010)
	 * 
	 * @return WRITEME
	 */
	public int getLotID () {
		return lotID;
	}
	
	/**
	 * @return the owner
	 */
	public AbstractUser getOwner () {
		return owner;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}
	
	/**
	 * instantiate the given room if it's called-for
	 * 
	 * @param key room number
	 */
	private void instantiateRoom (final Integer key) {
		if (Boolean.FALSE.equals (hasRooms.get (key))) {
			try {
				houseRooms.put (key, Room.initUserRoom (owner,
						key.intValue ()));
			} catch (final NotReadyException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a NotReadyException in UserHouse.instantiateRoom ",
								e);
			}
			hasRooms.put (key, Boolean.TRUE);
		}
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Map#isEmpty()
	 */
	@Override
	public boolean isEmpty () {
		return hasRooms.isEmpty ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Map#keySet()
	 */
	@Override
	public Set <Integer> keySet () {
		return houseRooms.keySet ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Map#put(java.lang.Object, java.lang.Object)
	 */
	@Override
	public Room put (final Integer key, final Room value) {
		if ( !houseRooms.containsKey (key)) {
			addRooms (new Integer [] { key });
		}
		return houseRooms.put (key, value);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Map#putAll(java.util.Map)
	 */
	@Override
	public void putAll (final Map <? extends Integer, ? extends Room> m) {
		final Object [] nn = m.keySet ().toArray ();
		/*
		 * instanceof will always return false, since a Object[] can't
		 * be a Integer[]
		 */
		if ( ! (nn instanceof Integer [])) {
			BugReporter.getReporter ("srv").reportBug ("odd");
			return;
		}
		addRooms ((Integer []) nn);
		houseRooms.putAll (m);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Map#remove(java.lang.Object)
	 */
	@Override
	public Room remove (final Object key) {
		return houseRooms.remove (key);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Feb 19,
	 * 2010)
	 * 
	 * @param houseTypeID1 WRITEME
	 */
	public void setHouseTypeID (final int houseTypeID1) {
		houseTypeID = houseTypeID1;
		changed ();
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Feb 19,
	 * 2010)
	 * 
	 * @param lotID1 WRITEME
	 */
	public void setLotID (final int lotID1) {
		lotID = lotID1;
		changed ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Map#size()
	 */
	@Override
	public int size () {
		return houseRooms.size ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.util.Map#values()
	 */
	@Override
	public Collection <Room> values () {
		return houseRooms.values ();
	}
	
}
