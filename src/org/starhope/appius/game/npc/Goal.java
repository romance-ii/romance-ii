/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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
 * The state of the NPC's sequence of actions
 * 
 * @author brpocock@star-hope.org
 */
public enum Goal {
	/**
	 * Following someone to be seated
	 */
	RESTAURANT_BEING_SEATED,
	/**
	 * Eating their food
	 */
	EATING,
	/**
	 * Coming in to the restaurant
	 */
	GO_TO_RESTAURANT,
	/**
	 * Waiting for food
	 */
	HUNGRY_WAIT_SERVICE,
	/**
	 * Going to watch a game someplace
	 */
	GO_TO_GAME,
	/**
	 * Gossipping
	 */
	GOSSIP,
	/**
	 * Looking for someone
	 */
	FIND_SOMEONE,
	/**
	 * Looking for something
	 */
	FIND_SOMETHING
}
