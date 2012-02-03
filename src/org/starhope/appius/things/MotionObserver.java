/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.things;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public interface MotionObserver {
	/**
	 * This method is called by a {@link HasMotion} object to add a
	 * {@link Motion} to the timeline.
	 * 
	 * @param mover The object in motion.
	 * @param newMotion The new motion state to be added to the
	 *            timeline.
	 */
	public void observeMotionCanceled (HasMotion mover, Motion newMotion);

	/**
	 * This method is called by a {@link HasMotion} object to remove a
	 * {@link Motion} from the timeline
	 * 
	 * @param mover The object in motion
	 * @param newMotion The motion to be removed from the timeline
	 */
	public void observeNewMotion (HasMotion mover, Motion newMotion);
}
