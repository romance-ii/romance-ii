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
package org.starhope.appius.game;

/**
 * The state of a GameEvent is one of countdown (between rounds),
 * running (currently in team or mass play), and solo (practice or
 * attract mode)
 * 
 * @author brpocock@star-hope.org
 */
public enum GameStateFlag {
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 5,
	 * 2009) GAME_COUNTDOWN (GameStateFlag)
	 */
	GAME_COUNTDOWN,
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 5,
	 * 2009) GAME_RUNNING (GameStateFlag)
	 */
	GAME_RUNNING,
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 5,
	 * 2009) GAME_SOLO (GameStateFlag)
	 */
	GAME_SOLO
}
