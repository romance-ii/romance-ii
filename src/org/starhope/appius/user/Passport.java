/**
 * <p>
 * Passport.java
 * </p>
 * <p>
 * (org.starhope.appius.user)
 * </p>
 * <p>
 * Project: Romance
 * </p>
 * <p>
 * Copyright © 2010-2012, Bruce-Robert Pocock
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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * </p>
 * <p>
 * See the GNU Affero General Public License for more details. You
 * should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.user;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.ConcurrentSkipListSet;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Passport extends SimpleDataRecord <Passport> {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -138554407026506110L;
	
	/**
	 * The user ID of the owner of this passport
	 */
	private int userID;
	
	/**
	 * the set of room monikers which the user has visited
	 */
	private final Set <String> visitedRooms = new ConcurrentSkipListSet <String> ();
	
	/**
	 * nil constructor
	 */
	public Passport () {
		super (Passport.class);
		userID = -1;
	}
	
	/**
	 * @param user the owner
	 */
	public Passport (final GeneralUser user) {
		super (Passport.class);
		userID = user.getUserID ();
		changed ();
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof Passport)) {
			return false;
		}
		final Passport other = (Passport) obj;
		if (userID != other.userID) {
			return false;
		}
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return userID;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return Nomenclator.getLoginForID (userID);
	}
	
	/**
	 * @return the user ID of the owner of this passport
	 */
	public int getOwnerID () {
		return userID;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * @return the set of all rooms that the user has visited
	 */
	public Collection <String> getVisitedRooms () {
		return new HashSet <String> (visitedRooms);
		
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result) + userID;
		return result;
	}
	
	/**
	 * @param moniker of a room
	 * @return true, if the user has ever been there
	 */
	public boolean hasVisited (final String moniker) {
		return visitedRooms.contains (moniker);
	}
	
	/**
	 * @param userIDForLogin to be set
	 */
	public void setOwnerID (final int userIDForLogin) {
		userID = userIDForLogin;
		changed ();
	}
	
	/**
	 * @return the list of visited rooms in JSON form
	 */
	public JSONObject toJSON () {
		final JSONObject jso = new JSONObject ();
		int i = 0;
		for (final String moniker : visitedRooms) {
			try {
				jso.put (String.valueOf (i++ ), moniker);
			} catch (final JSONException e) {
				BugReporter.getReporter ("srv").reportBug (e);
			}
		}
		return jso;
	}
	
	/**
	 * @param moniker the room that the user has now visited
	 */
	public void visited (final String moniker) {
		visitedRooms.add (moniker);
		changed ();
	}
	
}
