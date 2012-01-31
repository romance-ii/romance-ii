/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game.powers;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 *
 */
@Deprecated
public interface SpeedPower {

	/**
	 * Gets the scalar adjustment for the speed of the
	 * user. Should return 0 if it does not change the user's
	 * speed.  A value of 1 means a 100% increase and a value of
	 * -1 means a 100% decrease (i.e. the speed is half of
	 * original) WRITEME: This makes no sense. 100% decrease means
	 * zero; so does -1 mean 50% decrease or 100% ?
	 *
	 * @return  WRITEME ewinkelman@resinteractive.com
	 */
	public double getSpeedScalar ();
}
