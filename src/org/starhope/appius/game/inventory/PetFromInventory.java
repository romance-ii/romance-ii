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
package org.starhope.appius.game.inventory;

import org.starhope.appius.game.npc.PetBehaviour;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.util.AcceptsMetronomeTicks;

/**
 * TODO: The documentation for this type (PetFromInventory) is
 * incomplete. (brpocock@star-hope.org, Nov 24, 2009)
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public interface PetFromInventory extends AbstractUser,
		AcceptsMetronomeTicks {
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 24,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public PetBehaviour getActiveBehaviour ();
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 24,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public AbstractUser getUserBeingFollowed ();
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 24,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public boolean isFollowingUser ();
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 24,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public boolean isInFlock ();
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 24,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public boolean isInTrain ();
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 24,
	 * 2009)
	 * 
	 * @param member WRITEME
	 */
	public void joinFlock (AbstractUser member);
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 24,
	 * 2009)
	 * 
	 * @param member WRITEME
	 */
	public void joinTrain (AbstractUser member);
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 24,
	 * 2009)
	 * 
	 * @param behaviour WRITEME
	 */
	public void setNextBehaviour (PetBehaviour behaviour);
}
