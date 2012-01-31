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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.things;

import java.util.LinkedList;
import java.util.List;

/**
 * A timeline can be attached to any object to provide motion over time
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Timeline {
	List <Motion> motions = new LinkedList <Motion> ();
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public Motion getCurrentMotion () {
		return getMotionAtTime (System.currentTimeMillis ());
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param t WRITEME
	 * @return WRITEME
	 */
	public Motion getMotionAtTime (final long t) {
		return null;
		// WRITEME
	}
	
	public List <Motion> getMotionForInterval (final long startTime,
			final long endTime) {
		final LinkedList <Motion> returns = new LinkedList <Motion> ();
		for (final Motion motion : motions) {
			if ( (motion.getStartTime () >= startTime)
					&& (motion.getStartTime () <= endTime)) {
				returns.add (motion);
			} else if ( (motion.getStartTime () <= startTime)
					&& (motion.getEndTime () >= endTime)) {
				returns.add (motion);
			} else if ( (motion.getEndTime () >= startTime)
					&& (motion.getEndTime () <= endTime)) {
				returns.add (motion);
			}
		}
		return returns;
	}
}
