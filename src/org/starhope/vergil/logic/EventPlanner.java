/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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
package org.starhope.vergil.logic;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class EventPlanner {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final static Map <String, List <VergilEventHandler>> handlers = new HashMap <String, List <VergilEventHandler>> ();
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param ident WRITEME
	 * @throws EventNotPlannedException WRITEME
	 */
	public static void criticalEvent (final String ident)
			throws EventNotPlannedException {
		EventPlanner.criticalEvent (ident, new Object [] {});
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param ident WRITEME
	 * @param data WRITEME
	 * @throws EventNotPlannedException WRITEME
	 */
	public static void criticalEvent (final String ident,
			final Object... data) throws EventNotPlannedException {
		final List <VergilEventHandler> list = EventPlanner.handlers
				.get (ident);
		if ( (null == list) || (0 == list.size ())) {
			throw new EventNotPlannedException ();
		}
		boolean handled = false;
		for (final VergilEventHandler handler : list) {
			boolean failed = false;
			try {
				handler.acceptEvent (VergilEventFactory.interpret (
						ident, data));
			} catch (final EventNotHandledException e) {
				failed = true;
			}
			if (false == failed) {
				handled = true;
			}
		}
		if ( !handled) {
			throw new EventNotPlannedException ();
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param ident WRITEME
	 */
	public static void event (final String ident) {
		try {
			EventPlanner.criticalEvent (ident);
		} catch (final EventNotPlannedException e) {
			// ignore for non-critical events
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param ident WRITEME
	 * @param data WRITEME
	 */
	public static void event (final String ident, final Object... data) {
		try {
			EventPlanner.criticalEvent (ident, data);
		} catch (final EventNotPlannedException e) {
			// ignore for non-critical events
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param ident WRITEME
	 * @param handler WRITEME
	 */
	public static void ignore (final String ident,
			final VergilEventHandler handler) {
		final List <VergilEventHandler> list = EventPlanner.handlers
				.get (ident);
		if (null == list) {
			return;
		}
		list.remove (handler);
		if (list.size () == 0) {
			EventPlanner.handlers.remove (ident);
		} else {
			EventPlanner.handlers.put (ident, list);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param ident WRITEME
	 * @param handler WRITEME
	 */
	public static void listen (final String ident,
			final VergilEventHandler handler) {
		if (null == EventPlanner.handlers.get (ident)) {
			final LinkedList <VergilEventHandler> list = new LinkedList <VergilEventHandler> ();
			list.add (handler);
			EventPlanner.handlers.put (ident, list);
			return;
		}
		EventPlanner.handlers.get (ident).add (handler);
		return;
	}
	
}
