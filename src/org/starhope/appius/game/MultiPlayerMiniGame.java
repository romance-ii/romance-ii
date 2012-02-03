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
package org.starhope.appius.game;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;

/**
 * <p>
 * General base class for multi-player mini-game implementations.
 * </p>
 * <p>
 * This class provides the essential lobby functionality. Details are
 * client-side. The actual rules of a particular minigame's server-side
 * moderation are handled by an instance of {@link GameRoom} which is
 * <em>not</em> also an instance of {@link MultiPlayerMiniGame}, the
 * class providing which is passed up to this constructor.
 * </p>
 * 
 * @author brpocock@star-hope.org
 * 
 */
public abstract class MultiPlayerMiniGame extends GameRoom {

	/**
	 * the lobby room is instanced off for individual games, but used to
	 * negotiate game joins.
	 */
	protected final Room lobbyRoom;

	/**
	 * the class of game events for instance rooms to invoke. Must have a constructor taking “this” and the room as parameters (in that order). Needs to be strongly typed to take the implementing subclass…
	 */
	private final Class <? extends GameRoom> roomEventClass;

	/**
	 * Constructor for derived classes
	 * 
	 * @param z zone
	 * @param c unique character for hashing this minigame. Must be
	 *            globally unique. Use Unicode!
	 * @param moniker the room moniker to which to attach as a lobby
	 *            room for the minigame.
	 * @param roomEvent minigame handler class — {@link #roomEventClass}
	 * @throws NotFoundException if the given room doesn't exist
	 */
	protected MultiPlayerMiniGame (final Zone z, final char c, final String moniker, final Class<? extends GameRoom> roomEvent)
	throws NotFoundException {
		super (z, c);
		lobbyRoom = z.getRoom (moniker);
		roomEventClass = roomEvent;
		lobbyRoom.add (this);
		scoreWatchRooms.add (lobbyRoom);
	}

	/**
	 * This should be called from child classes. It handles the
	 * following gameControl verbs:
	 * <ul>
	 * <li>start</li>
	 * <li>quit</li>
	 * <li>invite</li>
	 * <li>list</li>
	 * 
	 * @see org.starhope.appius.game.RoomListener#acceptGameAction(org.starhope.appius.user.AbstractUser,
	 *      org.json.JSONObject)
	 */
	@Override
	public void acceptGameAction (final AbstractUser u, final JSONObject action) {
		try {
			if (action.has ("gameControl")) {
				String gameControl;
				gameControl = action.getString ("gameControl");
				if ("start".equals (gameControl)) {
					final Room instance = lobbyRoom.initInstanceRoom ();
					instance.join (u, lobbyRoom.getMoniker ());
					rooms.add (instance);
					return;
				}
				if ("quit".equals (gameControl)) {
					lobbyRoom.join (u);
					return;
				}
				if ("invite".equals (gameControl)) {
					final AbstractUser target = Nomenclator
					.getOnlineUserByLogin (action
							.getString ("invitee"));
					if (null != target) {
						target.acceptGameAction (u, action);
					}
					return;
				}
				if ("list".equals (gameControl)) {
					final JSONObject roomInfo = new JSONObject ();
					for (final Room r : rooms) {
						roomInfo.put ("room", r.getMoniker ());
						final JSONObject roster = new JSONObject ();
						int i = 0;
						for (final AbstractUser player : r
								.getAllUsers ()) {
							roster.put (String.valueOf (i++ ),
									player.getAvatarLabel ());
						}
						roomInfo.put ("roster", roster);
						u.acceptGameAction (u, roomInfo);
					}
					return;
				}
			}
		} catch (final JSONException e) {
			AppiusClaudiusCaecus
			.reportBug (
					"Caught a JSONException in MultiPlayerMiniGame.acceptGameAction ",
					e);
		}
	}

	/**
	 * @see org.starhope.appius.game.GameRoom#acceptObjectJoinRoom(org.starhope.appius.game.Room,
	 *      org.starhope.appius.game.RoomListener)
	 */
	@Override
	public void acceptObjectJoinChannel (final RoomChannel channel,
			final RoomListener newListener) {
		if (newListener instanceof AbstractUser
				&& rooms.contains (channel)) {
			final AbstractUser newUser = (AbstractUser) newListener;
			AppiusClaudiusCaecus.blather (newUser.getAvatarLabel (),
					channel.getMoniker (), "",
					" *** User entered game instance", false);
			if (players.size () == 0) {
				try {
					final GameRoom newGame = roomEventClass
							.getConstructor (this.getClass (),
									Room.class)
							.newInstance (this, channel);
					newGame.acceptObjectJoinChannel (channel, newListener);
				} catch (final Exception e) {
					AppiusClaudiusCaecus
							.reportBug (
									"Caught a exception in MultiPlayerMiniGame.acceptObjectJoinRoom ",
									e);
				}
			}
		}
	}

	/**
	 * @see org.starhope.appius.game.GameRoom#acceptObjectPartRoom(org.starhope.appius.game.Room,
	 *      org.starhope.appius.game.RoomListener)
	 */
	@Override
	public void acceptObjectPartChannel (final RoomChannel room,
			final RoomListener object) {
		// no op.
	}

	/**
	 * @see org.starhope.appius.game.RoomListener#acceptOutOfBandMessage(org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.Room, org.json.JSONObject)
	 */
	@Override
	public void acceptOutOfBandMessage (final AbstractUser sender,
			final RoomChannel room,
			final JSONObject body) {
		// no op
	}

	/**
	 * @see org.starhope.appius.game.RoomListener#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	@Override
	public void acceptPublicMessage (final AbstractUser from, final String message) {
		// no op
	}

	/**
	 * @see org.starhope.appius.game.RoomListener#acceptUserAction(org.starhope.appius.game.Room,
	 *      org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void acceptUserAction (final RoomChannel r,
			final AbstractUser u) {
		// no op
	}

}
