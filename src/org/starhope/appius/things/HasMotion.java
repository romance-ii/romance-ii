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

import java.util.List;

/**
 * WRITEME: Document this type.
 * 
 * @author brpocock@star-hope.org
 * 
 */
public interface HasMotion {
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return the active motion
	 */
	public Motion getCurrentMotion ();

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return all motions
	 */
	public List<Motion> getMotions ();

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param newObserver WRITEME
	 * @return WRITEME
	 */
	public boolean startObserving (MotionObserver newObserver);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param oldObserver WRITEME
	 * @return WRITEME
	 */
	public boolean stopObserving (MotionObserver oldObserver);
}
