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
package org.starhope.appius.game.npc.plebeian;

import org.starhope.appius.user.events.Action;

/**
 * An interface for things that can run scripts based upon actions.
 * Works together with the {@link ScriptPuppet} interface.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public interface ScriptRunner {
	
	/**
	 * Handle dispatching any script events appropriate upon receipt of
	 * an {@link Action}
	 * 
	 * @param a the action to be dispatched
	 */
	void dispatch (final Action a);
	
	/**
	 * Perform another step in the script, as/if needed.
	 */
	void doNextToDoItem ();
	
	/**
	 * Get the {@link ScriptPuppet} being controlled by this
	 * ScriptRunner
	 * 
	 * @return the victim of the script
	 */
	ScriptPuppet getPuppet ();
	
	/**
	 * Push a task into the queue to be performed by this ScriptRunner.
	 * 
	 * @param runnable a task to be performed
	 */
	void pushToDo (Runnable runnable);
	
	/**
	 * @param when the time at which the script last ran
	 */
	void setLastScriptTime (long when);
}
