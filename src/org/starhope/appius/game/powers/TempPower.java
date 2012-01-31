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
public interface TempPower extends Power {

	/**
	 * Factory interface for the power
	 *
	 * @author ewinkelman@resinteractive.com Ed Winkelman
	 */
	static interface Factory extends Power {
		/**
		 * Creates an instance of this power
		 *
		 * @param info The power item info interface object
		 * @param pc The power controller interface object
		 * @param saveInfo Any saved information for
		 *            recreating this object at the moment it
		 *            was saved. Can be null or an empty
		 *            string.
		 * @return WRITEME WRITEME ewinkelman@resinteractive.com
		 */
		TempPower onUse (PowerController pc, String saveInfo);
	}

	/**
	 * Gets the duration of this power at inception
	 *
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public long getDuration ();

	/**
	 * Gets the item ID of the item to use as the icon for this power
	 *
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public int getIcon();

	/**
	 * Gets the remaining duration of this power
	 *
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public long getRemainingDuration ();

	/**
	 * Gets a string that encapsulates all the information
	 * required to restore this power to the state it is in when
	 * this call is made
	 *
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public String getSaveInfo ();

	/**
	 * Sets the duration of this power to the new value. Should be set to -1 if not used.
	 *
	 * @param duration WRITEME ewinkelman@resinteractive.com
	 */
	public void setRemainingDuration (long duration);

	/**
	 * Determines if this power stacks with itself or not.  If it
	 * stacks and a new item is used, then the duration will be
	 * added to with the duration of the new effect, otherwise it
	 * will replace the duration
	 *
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public boolean stacksWithSelf ();

	/**
	 * Periodically calls this with the current time and amount of
	 * time elapsed since last call so that the duration can be
	 * updated and any periodic effect changes made
	 *
	 * @param currentTime WRITEME ewinkelman@resinteractive.com
	 * @param deltaTime WRITEME ewinkelman@resinteractive.com
	 * @return True if something about the power changed (other
	 * than the remaining duration)
	 */
	public boolean tick (long currentTime, long deltaTime);

	/**
	 * Gets the name of the special effect to apply to the user,
	 * if there is one
	 *
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public String userSFX ();
}
