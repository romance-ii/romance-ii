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

import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class PlebeianScript {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final Queue <Runnable> mySteps;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param steps WRITEME
	 */
	public PlebeianScript (final Queue <Runnable> steps) {
		mySteps = steps;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	Queue <Runnable> getSteps () {
		return mySteps;
	}
	
	/**
	 * Given a script, prepend the contents of the script to the toDo
	 * list, so that those steps will be executed before anything else.
	 * Used by e.g. “If” clauses. The steps will be prepended in
	 * reverse order so as to retain their original sequence.
	 * 
	 * @param pleb TODO
	 */
	protected void nowRun (final ScriptPuppet pleb) {
		final List <Runnable> steps = new LinkedList <Runnable> (
				getSteps ());
		for (int i = steps.size () - 1; i >= 0; --i) {
			pleb.getScriptRunner ().pushToDo (steps.get (i));
		}
		pleb.getScriptRunner ().doNextToDoItem ();
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder s = new StringBuilder (" { SCRIPT: ");
		for (final Runnable r : mySteps) {
			s.append ('{');
			s.append (r.toString ());
			s.append ('}');
		}
		s.append (" } ");
		return s.toString ();
	}
	
}
