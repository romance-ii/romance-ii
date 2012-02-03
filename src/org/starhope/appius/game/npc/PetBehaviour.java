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
package org.starhope.appius.game.npc;

/**
 * 
 * TODO: The documentation for this type (PetBehaviour) is incomplete.
 * (brpocock@star-hope.org, Nov 24, 2009)
 * 
 * @author brpocock@star-hope.org
 * 
 */
public enum PetBehaviour {
	/**
	 * Set this pet to follow a random person in the room
	 * 
	 * BOTHER_FRIEND (PetBehaviour)
	 */
	BOTHER_FRIEND,

	/**
	 * Join into a flock of pets
	 * 
	 * FLOCK (PetBehaviour)
	 */
	FLOCK,
	/**
	 * Follow-the-leader, baby chick style. Each member will join a
	 * “train” like a Conga Line.
	 * 
	 * FOLLOW_LEADER (PetBehaviour)
	 */
	FOLLOW_LEADER,
	/**
	 * Follow the master (owner). This will create a sort of flock
	 * around the owner if many pets choose it.
	 * 
	 * FOLLOW_MASTER (PetBehaviour)
	 */
	FOLLOW_MASTER,
	/**
	 * When the master leaves the screen, hurry to their last-known
	 * position and then vanish ourself.
	 * 
	 * MASTER_EXIT (PetBehaviour)
	 */
	MASTER_EXIT,
	/**
	 * Choose a new behavioral pattern at random
	 * 
	 * RANDOM (PetBehaviour)
	 */
	RANDOM,
	/**
	 * Do nothing for a while.
	 * 
	 * TAKE_NAP (PetBehaviour)
	 */
	TAKE_NAP
}
