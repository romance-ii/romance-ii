/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.game.actions;

import org.starhope.appius.game.Room;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.user.AbstractUser;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ActionClick extends ActionObject <Room> {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = 8821644934880175360L;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final boolean alt;
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final String clickTarget;
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final boolean ctrl;
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final boolean shift;
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final Coord2D targetCoords;
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final AbstractUser user;
	
	/**
	 * Contains the information for a click event in a room
	 * 
	 * @param source The room the click event happened in
	 * @param newUser The user triggering the click event
	 * @param newTarget The thing clicked (can be null)
	 * @param newCoords Where the click occured in world coordinates
	 * @param isShifted If shift was held during the click
	 * @param isControlDown If ctrl was held during the click
	 * @param isAlternate If alt was held during the click
	 */
	public ActionClick (final Room source, final AbstractUser newUser,
			final String newTarget, final Coord2D newCoords,
			final boolean isShifted, final boolean isControlDown,
			final boolean isAlternate) {
		super (source);
		user = newUser;
		clickTarget = newTarget;
		targetCoords = newCoords;
		shift = isShifted;
		alt = isAlternate;
		ctrl = isControlDown;
	}
	
	/**
	 * @return the alt
	 */
	public boolean alt () {
		return alt;
	}
	
	/**
	 * @return the ctrl
	 */
	public boolean ctrl () {
		return ctrl;
	}
	
	/**
	 * @return the clickTarget
	 */
	public String getClickTarget () {
		return clickTarget;
	}
	
	/**
	 * @return the targetCoords
	 */
	public Coord2D getTargetCoords () {
		return targetCoords;
	}
	
	/**
	 * @return the user
	 */
	public AbstractUser getUser () {
		return user;
	}
	
	/**
	 * @return the shift
	 */
	public boolean shift () {
		return shift;
	}
	
}
