/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General
 * Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any
 * later version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game.rooms;

import org.json.JSONObject;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.game.GameRoom;
import org.starhope.appius.game.GameStateFlag;
import org.starhope.appius.user.AbstractUser;

/**
 * A participant in a Room who wishes to observe activity in that Room
 * should be a RoomListener.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
@Deprecated
public interface RoomListener extends ChannelListener {
	/**
	 * Broadcast message of a game action taking place
	 * 
	 * @param u the sender
	 * @param action The game action. The verb is in
	 *            action.getString("action").
	 */
	public void acceptGameAction (final AbstractUser u, final JSONObject action);
	
	/**
	 * Notification of a GameEvent changing state for the room
	 * 
	 * @param gameCode The GameEvent whose state is changing
	 * @param gameState The new state
	 */
	public void acceptGameStateChange (final GameRoom gameCode, final GameStateFlag gameState);
	
	/**
	 * Notification that someone has entered the room.
	 * 
	 * @param room The room
	 * @param object The thing (probably user) entering
	 */
	public void acceptObjectJoinChannel (final RoomChannel room, final RoomListener object);
	
	/**
	 * Notification that someone has left a room
	 * 
	 * @param room The room
	 * @param thing The thing (probably user) departing
	 */
	public void acceptObjectPartChannel (final RoomChannel room, final RoomListener thing);
	
	/**
	 * Accept an out-of-band communications packet that was broadcast to
	 * a room in which this Listener is listening.
	 * 
	 * @param sender The sender of the OOB message
	 * @param room The room in which the OOB message is being broadcast
	 * @param body A JSON object containing the OOB message. The
	 *            contents of this message are not constrained.
	 */
	public void acceptOutOfBandMessage (final AbstractUser sender, final RoomChannel room, final JSONObject body);
	
	/**
	 * Accept a public chat message or /emote.
	 * 
	 * @param sender The speaker
	 * @param room The room in which the words were spoken
	 * @param message The spoken text or /emote
	 */
	public void acceptPublicMessage (final AbstractUser sender, final RoomChannel room, final String message);
	
	/**
	 * Accept a public chat message. This prototype does not specify the
	 * room, on the (potentially invalid) assumption that the room
	 * listener doesn't care from which room the speech was made.
	 * 
	 * @param from The speaker
	 * @param message The spoken text or /emote
	 */
	public void acceptPublicMessage (final AbstractUser from, final String message);
	
	/**
	 * User actions (go/do actions) propagate through this channel.
	 * 
	 * @param r the room in which the user is taking an action
	 * @param u the user taking an action
	 */
	public void acceptUserAction (RoomChannel r, AbstractUser u);
	
	/**
	 * Receive notification of the change of an user variable
	 * 
	 * @param user The user updating their variable
	 * @param varName The name of the variable (key)
	 * @param varValue The new value (null if unset)
	 */
	public void acceptUserVariableUpdate (AbstractUser user, String varName, String varValue);
}
