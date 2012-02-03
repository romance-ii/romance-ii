/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
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
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author ewinkelman
 */
package org.starhope.appius.game;

import java.util.Collections;
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
 * @author ewinkelman
 *
 */
public class GameVar extends SimpleDataRecord <GameVar> implements
		HasVariables {
	
	/**
	 * Game class
	 */
	private String klass;
	
	/**
	 * Map of all current variables for this game
	 */
	private ConcurrentHashMap <String, String> variables = new ConcurrentHashMap <String, String> ();
	
	/**
	 * List of vars that have changed since last save
	 */
	private ConcurrentSkipListSet <String> changedVars = new ConcurrentSkipListSet <String> ();
	
	/**
	 * List of vars that have been deleted since last save
	 */
	private ConcurrentSkipListSet <String> removedVars = new ConcurrentSkipListSet <String> ();

	/**
	 * WRITEME: Document this ewinkelman
	 */
	private Set <AcceptsVariableUpdates> varUpdateListeners = Collections
			.synchronizedSet (new HashSet <AcceptsVariableUpdates> ());
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	private static final long serialVersionUID = -2420439802645673693L;
	
	/**
	 * WRITEME: Document this constructor ewinkelman
	 * 
	 * @param loader
	 */
	public GameVar (RecordLoader <? super GameVar> loader) {
		super (loader);
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#deleteVariable(java.lang.String)
	 */
	@Override
	public void deleteVariable (String key) {
		variables.remove (key);
		removedVars.add (key);
		changed ();
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param key
	 * @return
	 */
	public boolean exists (String key) {
		return variables.containsKey (key);
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#getVariable(java.lang.String)
	 */
	@Override
	public String getVariable (String key) {
		// Delay if this record is being (re)loaded
		if (isBeingLoaded ()) {
			int i = 0;
			while (isBeingLoaded () && i++ < 10) {
				try {
					Thread.sleep (10);
				} catch (InterruptedException e) {
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
	 * Replaces the current set of variables with a new set
	 * 
	 * @see org.starhope.appius.types.HasVariables#resetVariables(java.util.Map)
	 */
	@Override
	public void resetVariables (Map <String, String> map) {
		removedVars.addAll (variables.keySet ());
		variables.clear ();
		setVariables (map);
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#setVariable(java.util.Map.Entry)
	 */
	@Override
	public void setVariable (Entry <String, String> var) {
		setVariable (var.getKey (), var.getValue ());
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#setVariable(java.lang.String, java.lang.String)
	 */
	@Override
	public void setVariable (String key, String value) {
		if (null == key) {
			AppiusClaudiusCaecus.reportBug (
					"Received a null in GameVar::setVariable",
					new NullPointerException ("null=" + value));
			return;
		}
		final String varV = null == value ? "" : value;
		
		if (varV.equals (variables.get (key)))
			return;
		
		variables.put (key, value);
		if (isBeingLoaded ()) {
			synchronized (varUpdateListeners) {
				for (AcceptsVariableUpdates listener : varUpdateListeners) {
					listener.acceptVariableUpdate (key, value);
				}
			}
		}
		changedVars.add (key);
		changed ();
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#setVariables(java.util.Map)
	 */
	@Override
	public void setVariables (Map <String, String> map) {
		for (final Entry <String, String> var : map.entrySet ()) {
			setVariable (var);
		}
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		throw new NotFoundException ("gameVar");
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return klass;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2223 $";
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @return
	 */
	public String getMoniker () {
		return klass;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param value
	 */
	public void setMoniker (String value) {
		klass = value;
	}
	
	/**
	 * Gets a list of all variables that have changed since last being
	 * called. Resets the list of changes.
	 * 
	 * @return
	 */
	public List <String> getChangedVars () {
		final List <String> result = new LinkedList <String> (
				changedVars);
		// Do it this way instead of clear() in case there's a variable
		// being changed while we're fetching the set
		changedVars.removeAll (result);
		return result;
	}
	
	/**
	 * Gets a list of all variables that have been removed since last
	 * being called. Resets the list of deletions.
	 * 
	 * @return
	 */
	public List <String> getRemovedVars () {
		final List <String> result = new LinkedList <String> (
				removedVars);
		// Do it this way instead of clear() in case there's a variable
		// being changed while we're fetching the set
		removedVars.removeAll (result);
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
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param listener
	 */
	public void add (AcceptsVariableUpdates listener) {
		varUpdateListeners.add (listener);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param listener
	 */
	public void remove (AcceptsVariableUpdates listener) {
		varUpdateListeners.remove (listener);
	}
}
