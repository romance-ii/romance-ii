/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 * Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public
 * License along with this program. If not, see
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
package org.starhope.appius.user;

import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.types.AcceptsVariableUpdates;
import org.starhope.appius.types.HasVariables;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

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
public class UserVar extends SimpleDataRecord <UserVar> implements
		HasVariables {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (UserVar.class);
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = -2420439802645673693L;
	
	/**
	 * List of vars that have changed since last save
	 */
	private final ConcurrentSkipListSet <String> changedVars = new ConcurrentSkipListSet <String> ();
	
	/**
	 * List of vars that have been deleted since last save
	 */
	private final ConcurrentSkipListSet <String> removedVars = new ConcurrentSkipListSet <String> ();
	
	/**
	 * User's ID
	 */
	private int userID;
	
	/**
	 * Map of all current variables for this room
	 */
	private final ConcurrentHashMap <String, String> variables = new ConcurrentHashMap <String, String> ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final Map <String, Set <AcceptsVariableUpdates>> varUpdateListeners = Collections
			.synchronizedMap (new HashMap <String, Set <AcceptsVariableUpdates>> ());
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param loader WRITEME 
	 */
	public UserVar (final RecordLoader <? super UserVar> loader) {
		super (loader);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param listener WRITEME 
	 * @param variable WRITEME 
	 */
	public void add (final AcceptsVariableUpdates listener,
			final String variable) {
		if ( !varUpdateListeners.containsKey (variable)) {
			varUpdateListeners.put (variable,
					new HashSet <AcceptsVariableUpdates> ());
		}
		varUpdateListeners.get (variable).add (listener);
		changed ();
	}
	
	@Override
	public void checkStale () {
		// Don't let user vars automatically refresh
	}
	
	/**
	 * Returns the number of room variables
	 * 
	 * @return WRITEME 
	 */
	public int count () {
		return variables.size ();
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#deleteVariable(java.lang.String)
	 */
	@Override
	public void deleteVariable (final String key) {
		variables.remove (key);
		removedVars.add (key);
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
		if ( ! (obj instanceof UserVar)) {
			return false;
		}
		final UserVar other = (UserVar) obj;
		if (userID != other.userID) {
			return false;
		}
		return true;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME 
	 * @return WRITEME 
	 */
	public boolean exists (final String key) {
		return variables.containsKey (key);
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
		return Integer.toString (userID);
	}
	
	/**
	 * Gets a list of all variables that have changed since last being
	 * called. Resets the list of changes.
	 * 
	 * @return WRITEME 
	 */
	public List <String> getChangedVars () {
		final List <String> result = new LinkedList <String> (
				changedVars);
		// Do it this way instead of clear() in case there's a
		// variable
		// being changed while we're fetching the set
		changedVars.removeAll (result);
		return result;
	}
	
	/**
	 * Gets a list of all variables that have been removed since last
	 * being called. Resets the list of deletions.
	 * 
	 * @return WRITEME 
	 */
	public List <String> getRemovedVars () {
		final List <String> result = new LinkedList <String> (
				removedVars);
		// Do it this way instead of clear() in case there's a
		// variable
		// being changed while we're fetching the set
		removedVars.removeAll (result);
		return result;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	public int getUserID () {
		return userID;
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#getVariable(java.lang.String)
	 */
	@Override
	public String getVariable (final String key) {
		// Delay if this record is being (re)loaded
		if (isBeingLoaded ()) {
			int i = 0;
			while (isBeingLoaded () && (i++ < 10)) {
				try {
					Thread.sleep (10);
				} catch (final InterruptedException e) {
					// Don't worry about it
				}
			}
		}
		return variables.get (key);
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#getVariables()
	 */
	@Override
	public Map <String, String> getVariables () {
		return new ConcurrentHashMap <String, String> (variables);
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
	 * Also clears status changes for the things that were just set on
	 * loading
	 * 
	 * @see org.starhope.appius.util.SimpleDataRecord#markAsLoaded()
	 */
	@Override
	public void markAsLoaded () {
		super.markAsLoaded ();
		changedVars.clear ();
		removedVars.clear ();
	}
	
	/**
	 * Refreshes the room vars from the database
	 */
	public void refresh () {
		myLoader.refresh (this);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param listener WRITEME 
	 * @param variable WRITEME 
	 */
	public void remove (final AcceptsVariableUpdates listener,
			final String variable) {
		if (varUpdateListeners.containsKey (variable)) {
			varUpdateListeners.get (variable).remove (listener);
		}
		changed ();
	}
	
	/**
	 * Replaces the current set of variables with a new set
	 * 
	 * @see org.starhope.appius.types.HasVariables#resetVariables(java.util.Map)
	 */
	@Override
	public void resetVariables (final Map <String, String> map) {
		removedVars.addAll (variables.keySet ());
		variables.clear ();
		setVariables (map);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param value WRITEME 
	 */
	public void setUserID (final int value) {
		userID = value;
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#setVariable(java.util.Map.Entry)
	 */
	@Override
	public void setVariable (final Entry <String, String> var) {
		setVariable (var.getKey (), var.getValue ());
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#setVariable(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public void setVariable (final String key, final String value) {
		if (null == key) {
			UserVar.log.error (
					"Received a null in UserVar::setVariable",
					new NullPointerException ("null=" + value));
			return;
		}
		final String varV = null == value ? "" : value;
		
		if (varV.equals (variables.get (key))) {
			return;
		}
		
		variables.put (key, value);
		if (isBeingLoaded ()) {
			Set <AcceptsVariableUpdates> copyListeners;
			synchronized (varUpdateListeners) {
				// Copy list so that changes to the list as we
				// iterate
				// don't crash it
				copyListeners = varUpdateListeners
						.containsKey (key) ? new HashSet <AcceptsVariableUpdates> (
						varUpdateListeners.get (key))
						: new HashSet <AcceptsVariableUpdates> ();
			}
			for (final AcceptsVariableUpdates listener : copyListeners) {
				listener.acceptVariableUpdate (key, value);
			}
		}
		changedVars.add (key);
		changed ();
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#setVariables(java.util.Map)
	 */
	@Override
	public void setVariables (final Map <String, String> map) {
		for (final Entry <String, String> var : map.entrySet ()) {
			setVariable (var);
		}
	}
}
