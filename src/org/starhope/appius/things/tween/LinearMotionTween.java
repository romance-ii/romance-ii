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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.things.tween;

import org.starhope.appius.game.BugReporter;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.geometry.LineSeg3D;
import org.starhope.appius.things.Motion;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class LinearMotionTween implements MotionTween {
	
	private final Motion motion;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param motion WRITEME  brpocock 
	 */
	public LinearMotionTween (final Motion newMotion) {
		motion = newMotion;
	}
	
	/**
	 * @see org.starhope.appius.things.tween.MotionTween#computeMotionAtTime(long)
	 */
	@Override
	public Coord3D computeMotionAtTime (final long time) {
		final double x1, y1, z1, x2, y2, z2;
		// motion.getStartPosition ().toDoubles (x1,y1,z1);
		return null;
	}
	
	/**
	 * @see org.starhope.appius.things.tween.MotionTween#getMotionLineForTimeInterval(long,
	 *      long)
	 */
	@Override
	public LineSeg3D getMotionLineForTimeInterval (
			final long startTime, final long endTime) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"unimplemented LinearMotionTween::getMotionLineForTimeInterval (brpocock@star-hope.org, Oct 5, 2010)");
		return null;
	}
	
}
