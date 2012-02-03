/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
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
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.util;

import org.starhope.appius.except.UserDeadException;

/**
 * WRITEME: The documentation for this type (AcceptsMetronomeTicks) is
 * incomplete. (brpocock@star-hope.org, Oct 31, 2009)
 * 
 * @author brpocock@star-hope.org
 * @param <T>
 */
public interface AcceptsMetronomeTicks extends HasName {
	/**
	 * This method is called periodically from the metronome thread. To
	 * save computation, it receives both the current time since epoch
	 * in milliseconds at the start of the global tick propagation, and
	 * the delta time since the previous metronome tick.
	 * 
	 * @param currentTime Time since epoch at the start of the global
	 *            metronome propagation, as per
	 *            System.currentTimeMillis()
	 * @param deltaTime Delta-time in milliseconds since the prior
	 *            global metronome tick
	 * @throws UserDeadException if a user has died during this tick
	 */
	public void tick (long currentTime, long deltaTime)
	throws UserDeadException;

}
