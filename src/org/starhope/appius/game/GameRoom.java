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

import java.math.BigInteger;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map.Entry;
import java.util.NoSuchElementException;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ConcurrentSkipListSet;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.net.NetIOThread;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.events.EventRecord;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * A GameEvent is a room-wide (or multi-room) game that occurs within
 * the larger context of the game. Think “arena” or similar.
 *
 * @author brpocock@star-hope.org
 */
public abstract class GameRoom extends GameEvent implements RoomListener {

	/**
	 * Queue for state changes in all GameEvents
	 */
	private static ConcurrentLinkedQueue <Entry <GameRoom, GameStateFlag>> stateChangeQueue = new ConcurrentLinkedQueue <Entry <GameRoom, GameStateFlag>> ();

	/**
	 * Propagate any waiting game state changes to listeners
	 */
	public static void propagateGameStateChange () {
		try {
			while (true) {
				final Entry <GameRoom, GameStateFlag> e = GameRoom.stateChangeQueue
				.remove ();
				final GameRoom ev = e.getKey ();
				final GameStateFlag state = e.getValue ();
				AppiusClaudiusCaecus
				.blather ("game state pump firing game "
						+ ev.toString () + " to "
						+ state.toString ());
				for (final AbstractUser who : ev.getEveryone ()) {
					who.acceptGameStateChange (ev, state);
				}
				ev.acceptGameStateChange (ev, state);
				ev.freezeTag = false;
			}
		} catch (final NoSuchElementException e) {
			// blather ("game state pump emptied");
			return;
		}
	}

	/**
	 * Shitty recursion guard endingSolo (GameEvent)
	 */
	private boolean endingSolo = false;

	/**
	 * freeze game actions
	 */
	protected boolean freezeTag = false;

	/**
	 * the current game state (mode)
	 */
	protected GameStateFlag gameState = GameStateFlag.GAME_SOLO;

	/**
	 * the events in the global events table for each player, used for
	 * recording scores
	 */
	private final ConcurrentHashMap <Integer, Integer> playerEvents = new ConcurrentHashMap <Integer, Integer> ();

	/**
	 * The rooms which this GameEvent controls
	 */
	protected final ConcurrentSkipListSet <Room> rooms = new ConcurrentSkipListSet <Room> ();

	/**
	 * The rooms which this GameEvent will report the score to (in
	 * addition to {@link #rooms}) scoreWatchRooms (GameEvent)
	 */
	protected final ConcurrentSkipListSet <Room> scoreWatchRooms = new ConcurrentSkipListSet <Room> ();

	/**
	 * The game (countdown/play time) timer
	 */
	private long timer;

	/**
	 * The game char id
	 */
	private final char gameCode;

	/**
	 * @param z the zone in which the game is being played
	 * @param c the game code character
	 */
	protected GameRoom (final Zone z, final char c) {
		super(z, String.valueOf(c));
		gameCode=c;
	}

	/**
	 * @param u The operator issuing the command
	 * @param arena The room in which the operator's command is being
	 *            executed
	 * @param command The command and parameters
	 */
	@Override
	public void acceptCommand (final AbstractUser u,
			final Room arena, final String [] command) {
		/* No op */
	}

	/**
	 * Accept a developer-level command and react to it.
	 *
	 * @param zone2 The zone in which the game is attached (should be
	 *            "zone" usually)
	 * @param room The room in which the invoking user exists
	 * @param user The invoking user
	 * @param command A command string split on whitespace
	 */
	public void acceptCommand (final GeneralUser user,
			final Room room, final Zone zone2,
			final String [] command) {
		if ("#pumpstate".equals (command [0])) {
			GameRoom.propagateGameStateChange ();
			user.acceptMessage ("pumpstate", "DM", "pumpstate");
			return;
		}
		if ("#changestate".equals (command [0])) {
			final GameStateFlag newState;

			if ("#countdown".equals (command [1])) {
				newState = GameStateFlag.GAME_COUNTDOWN;
			} else if ("#solo".equals (command [1])) {
				newState = GameStateFlag.GAME_SOLO;
			} else if ("#running".equals (command [1])) {
				newState = GameStateFlag.GAME_RUNNING;
			} else {
				user
				.acceptMessage ("#changestate", "DM",
				"#changestate to [ #solo | #countdown | #running ]");
				return;
			}
			user.acceptMessage ("#changestate", "DM",
					"change state to " + newState.toString ());
			changeGameState (newState);
			return;
		}
		if ("#resetplayers".equals (command [0])) {
			resetPlayers ();
			user.acceptMessage ("resetPlayers " + getGameShortName (),
					"DM", "resetPlayers: OK");
			return;
		}
		if ("#roster".equals (command [0])) {
			final StringBuilder msg = new StringBuilder ();
			msg.append ("Roster for GameEvent:\n");
			for (final Integer player : players) {
				final AbstractUser playerUser = Nomenclator
				.getUserByID (player.intValue ());
				if (null == playerUser) {
					msg.append (" <INVALID> UserID#" + player);
				} else {
					msg.append (playerUser.getAvatarLabel ());
					if (false == playerUser.isOnline ()) {
						msg.append ("<OFFLINE> ");
					}
				}
				msg.append (", ");
			}
			msg.append ("<END>");
			user.acceptMessage ("Roster for " + getGameShortName (),
					"DM", msg.toString ());
			return;
		}
		if ("#scores".equals (command [0])) {
			final StringBuilder msg = new StringBuilder ();
			msg.append ("Scores (");
			msg.append (toString ());
			msg.append (")\n");
			for (final Entry <AbstractUser, BigInteger> score : scores
					.entrySet ()) {
				final AbstractUser u = score.getKey ();
				if (null != u) {
					msg.append (u.getAvatarLabel ());
					msg.append ('\t');
					msg.append (score.getValue ());
					msg.append ('\n');
				}
			}
			user.acceptMessage ("scores", "DM", msg.toString ());
			return;
		}
		if ("#state".equals (command [0])) {
			user
			.acceptMessage (
					"Game State " + getGameShortName (), "DM",
					"Game\t" + toString () + "\ncode\t"
					+ gameCode + "\nstate\t"
					+ gameState.toString ()
					+ "\ntimer\t" + timer
					+ "\nendingSolo\t" + endingSolo
					+ "\n#rooms\t" + rooms.size ()
					+ "\n#scoreWatchRooms\t"
					+ scoreWatchRooms.size ()
					+ "\nfreezeTag\t" + freezeTag
					+ "\nzone\t" + zone.toString ());
			return;
		}
		if ("#purge".equals (command [0])) {
			int purgedNull = 0;
			int purgedOffline = 0;
			for (final Integer player : players) {
				final AbstractUser playerUser = Nomenclator
				.getUserByID (player.intValue ());
				if (null == playerUser) {
					players.remove (player);
					++purgedNull;
				} else if (false == playerUser.isOnline ()) {
					players.remove (player);
					++purgedOffline;
				}
			}
			user.acceptMessage ("Purge", "DM", "Purged " + purgedNull
					+ " nulls and " + purgedOffline
					+ " dead players from roster");
			return;
		}
		user.sendOops ();
		return;
	}

	/**
	 * @see org.starhope.appius.game.ChannelListener#acceptDatagram(org.starhope.appius.net.datagram.AbstractDatagram)
	 */
	@Override
	public void acceptDatagram (final AbstractDatagram datagram) {
		// TODO Auto-generated method stub

	}


	/**
	 *
	 * @see org.starhope.appius.game.RoomListener#acceptGameStateChange(org.starhope.appius.game.GameRoom, org.starhope.appius.game.GameStateFlag)
	 * @deprecated WRITEME
	 */
	@Override
	@Deprecated
	public void acceptGameStateChange (final GameRoom game,
			final GameStateFlag newGameState) {
		assert game == this;
		gameState = newGameState;
		updateRoomVars ();
		sendTimers ();
		freezeTag = false;
	}

	/**
	 * @see org.starhope.appius.game.RoomListener#acceptObjectJoinChannel(org.starhope.appius.game.RoomChannel,
	 *      org.starhope.appius.game.RoomListener)
	 * @deprecated WRITEME
	 */
	@Deprecated
	@Override
	public void acceptObjectJoinChannel (final RoomChannel channel,
			final RoomListener newListener) {
		if (newListener instanceof AbstractUser) {
			final AbstractUser newUser = (AbstractUser) newListener;
			final String playerTag = newUser.hasVariable ("player") ? newUser
					.getVariable ("player")
					: "0";
			AppiusClaudiusCaecus.blather (newUser.getAvatarLabel (),
					channel.getMoniker (), "",
					" *** User entered game room",
					false);
			if (0 != Integer.parseInt (playerTag)) {
				if (players.size () == 0) {
					changeGameState (GameStateFlag.GAME_SOLO);
				}
				players.add (Integer.valueOf (newUser.getUserID ()));
				if ( !scores.containsKey (newUser)) {
					scores.put (newUser, BigInteger.ZERO);
				}
				if (players.size () > 1
						&& GameStateFlag.GAME_SOLO == gameState) {
					// start game play when 2º player has just entered
					changeGameState (GameStateFlag.GAME_COUNTDOWN);
				}
			}
			updateRoomVars ();
			sendTimers ();
		}
	}

	/**
	 * @see org.starhope.appius.game.RoomListener#acceptObjectPartChannel(org.starhope.appius.game.RoomChannel,
	 *      org.starhope.appius.game.RoomListener)
	 */
	@Override
	public void acceptObjectPartChannel (final RoomChannel channel,
			final RoomListener object) {
		if (object instanceof AbstractUser
				&& players
				.contains (Integer
						.valueOf ( ((AbstractUser) object)
								.getUserID ()))) {
			if (GameStateFlag.GAME_SOLO == gameState) {
				if ( !endingSolo) {
					endingSolo = true;
					sendEndEvents (getGameEventPrefix () + ".solo");
					endingSolo = false;
				}
				changeGameState (GameStateFlag.GAME_SOLO);
			}
			updateRoomVars ();
		}
	}

	/**
	 * This is an overriding method.
	 *
	 * @see org.starhope.appius.game.RoomListener#acceptPublicMessage(AbstractUser,
	 *      Room, String)
	 */
	@Override
	public void acceptPublicMessage (final AbstractUser sender,
			final RoomChannel channel, final String message) {
		this.acceptPublicMessage (sender, message);
	}

	/**
	 * Receive notification of the change of an user variable
	 *
	 * @param user The user updating their variable
	 * @param varName The name of the variable (key)
	 * @param varValue The new value (null if unset)
	 */
	@Override
	public void acceptUserVariableUpdate (final AbstractUser user,
			final String varName, final String varValue) {
		// no default action
	}

	/**
	 * @param newState the new state of the game
	 */
	protected void changeGameState (final GameStateFlag newState) {
		freezeTag = true;
		if (GameStateFlag.GAME_COUNTDOWN == newState) {
			timer = getCountdownDuration ();
		} else if (GameStateFlag.GAME_RUNNING == newState) {
			timer = getGameDuration ();
		}

		final HashMap <GameRoom, GameStateFlag> trickery = new HashMap <GameRoom, GameStateFlag> ();
		trickery.put (this, newState);

		GameRoom.stateChangeQueue.addAll (trickery.entrySet ());
	}

	/**
	 * decrease a user's score, but do not allow it to drop below 0.
	 *
	 * @param who who lost points
	 * @param howMuch the number of points to lose
	 */
	protected void decrementScore (final AbstractUser who,
			final BigInteger howMuch) {
		if (scores.containsKey (who)) {
			final BigInteger score = scores.get (who);
			if (BigInteger.ZERO.equals (score)) {
				return;
			}
			if (score.compareTo (howMuch) < 0) {
				incrementScore (who, score.negate ());
				return;
			}
		}
		incrementScore (who, howMuch.negate ());
	}

	/**
	 * Destroy this event — during Zone shutdown usually
	 */
	@Override
	public void destroySelf () {
		// AppiusClaudiusCaecus.blather ("Destroying myself! " + getName
		// () + "@" + getZone ().getName ());
		AppiusClaudiusCaecus.remove (this);
	}

	/**
	 * disconnect the game event from the associated rooms.
	 */
	public void disconnect () {
		endAllEvents ();
		for (final Room room : rooms) {
			room.remove (this);
		}
		for (final Room room : scoreWatchRooms) {
			room.remove (this);
		}
	}

	/**
	 * close out all pending events
	 */
	private void endAllEvents () {
		// no op
	}

	/**
	 * Stupid case of equals override.
	 *
	 * @param other other game event
	 * @return true if they're the same
	 */
	public boolean equals (final GameRoom other) {
		return this == other;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object other) {
		if (other instanceof GameRoom) {
			return this.equals ((GameRoom) other);
		}
		return false;
	}

	/**
	 * Time (in ms) for the game countdown period timer. Can be
	 * overridden by derived classes.
	 *
	 * @return The game countdown timer in ms
	 */
	protected long getCountdownDuration () {
		return AppiusConfig.getIntOrDefault (
				"org.starhope.appius.games.countdownTime", 30000);
	}

	/**
	 * @return all players and spectators
	 */
	@Override
	public Set <AbstractUser> getEveryone () {
		final Set <AbstractUser> everyone = getPlayers ();
		everyone.addAll (getSpectators ());
		return everyone;
	}

	/**
	 * @return the gameCode
	 */
	public char getGameCode () {
		return gameCode;
	}

	/**
	 * Time (in ms) for the game play period timer. Can be overridden by
	 * derived classes.
	 *
	 * @return The game play timer in ms
	 */
	protected long getGameDuration () {
		return timer = AppiusConfig.getIntOrDefault (
				"org.starhope.appius.games.playTime", 120000);
	}

	/**
	 * Get the prefix to be applied to event types for this game
	 *
	 * @return the string prefix used to find event types for this game
	 */
	@Override
	public abstract String getGameEventPrefix ();

	/**
	 * @return the short name of the game: the class name without its
	 *         package (canonical) prefix
	 */
	@Override
	public String getGameShortName () {
		final String [] canonicalName = this.getClass ()
		.getCanonicalName ().split ("\\.");
		return canonicalName [canonicalName.length - 1];
	}

	/**
	 * @return bonus points awarded to the leader, or else anyone tied
	 *         for max score
	 */
	protected int getLeaderBonus () {
		return 0;
	}

	/**
	 * @return all players
	 */
	@Override
	public Set <AbstractUser> getPlayers () {
		final HashSet <AbstractUser> ret = new HashSet <AbstractUser> ();
		for (final int playerID : players) {
			ret.add (Nomenclator.getUserByID (playerID));
		}
		return ret;
	}

	/**
	 * @return one of the rooms in which this game takes place
	 */
	public Room getRoom () {
		return rooms.first ();
	}

	/**
	 * Get all of the rooms participating in this GameEvent
	 *
	 * @return the set of all rooms participating in this GameEvent
	 */
	public Set <Room> getRooms () {
		final HashSet <Room> myRooms = new HashSet <Room> ();
		myRooms.addAll (rooms);
		return myRooms;
	}

	/**
	 * Get all of the rooms which are either participating in this
	 * GameEvent, or monitoring its scores
	 *
	 * @return all rooms participating in, or watching the score from,
	 *         this GameEvent
	 */
	public Set <Room> getScoreWatchRooms () {
		final HashSet <Room> watchingRooms = new HashSet <Room> ();
		watchingRooms.addAll (rooms);
		watchingRooms.addAll (scoreWatchRooms);
		return watchingRooms;
	}

	/**
	 * @return all spectators
	 */
	@Override
	public Set <AbstractUser> getSpectators () {
		final HashSet <AbstractUser> ret = new HashSet <AbstractUser> ();
		for (final Room r : getRooms ()) {
			for (final AbstractUser guy : r.getAllUsers ()) {
				if ( !players.contains (Integer.valueOf (guy
						.getUserID ()))) {
					ret.add (guy);
				}
			}
		}
		return ret;
	}

	/**
	 * @return the timer
	 */
	public long getTimer () {
		return timer;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (toString ());
	}

	/**
	 * @param who user ID of the player to have score increased
	 * @param howMuch increment amount, can be negative
	 */
	public void incrementScore (final AbstractUser who,
			final BigInteger howMuch) {
		final BigInteger score;
		if (null == who) {
			return;
		}
		if (scores.containsKey (who)) {
			score = scores.get (who).add (howMuch);
		} else {
			AppiusClaudiusCaecus
			.blather (
					"#" + who,
					toString (),
					"",
					"Increment score for someone with no score present",
					false);
			score = howMuch;
		}
		AppiusClaudiusCaecus.blather ("#" + who, toString (), "",
				" Score  = " + score, false);
		scores.put (who, score);
		updateRoomVars ();

		sendScoreUpdate (who, score);
	}

	/**
	 * Clear all players; clear all scores; put all users into player or
	 * spectator queues
	 */
	protected void resetPlayers () {
		AppiusClaudiusCaecus.blather ("", toString (), "",
				"Resetting players", false);
		playerEvents.clear ();
		players.clear ();
		scores.clear ();
		for (final Room room : rooms) {
			for (final AbstractUser user : room.getAllUsers ()) {
				final String isPlayer = user.getVariable ("player");
				if (null != isPlayer && Integer.parseInt (isPlayer) > 0) {
					final Integer userID = Integer.valueOf (user
							.getUserID ());
					players.add (userID);
					scores.put (user, BigInteger.ZERO);
				}
			}
		}
		updateScores ();
	}

	/**
	 * @param gameMoniker The unique event moniker for this game
	 */
	protected void sendEndEvents (final String gameMoniker) {
		AppiusClaudiusCaecus.blather ("", toString (), "",
				"sending end events", false);
		int maxScore = 0;
		for (final int i : players) {
			final AbstractUser userByID = Nomenclator.getUserByID (i);
			if (scores.containsKey (userByID)) {
				final int thisScore = scores.get (userByID).intValue ();
				if (thisScore > maxScore) {
					maxScore = thisScore;
				}
			}
		}

		for (final int id : players) {
			final AbstractUser user = Nomenclator.getUserByID (id);
			if (null != user) {
				final int userID = user.getUserID ();
				if (playerEvents.containsKey (Integer.valueOf (userID))) {
					AppiusClaudiusCaecus.blather (user
							.getAvatarLabel (), toString (), user
							.getIPAddress (), "sending end event",
							false);
					/*
					 * Check all parameters, very paranoid
					 */
					final Integer eventID = playerEvents.get (Integer
							.valueOf (userID));
					if (null == eventID) {
						throw AppiusClaudiusCaecus
						.fatalBug ("null eventID");
					}
					if (eventID.intValue () <= 0) {
						throw AppiusClaudiusCaecus.fatalBug ("zero");
					}
					// BigInteger playerScore = scores.get (user);
					// if (null == playerScore) {
					// playerScore = BigInteger.ZERO;
					// }
					// if (maxScore == playerScore.intValue ()) {
					// playerScore = playerScore.add (BigInteger
					// .valueOf (getLeaderBonus ()));
					// }
					// final BigDecimal playerScoreDecimal = new
					// BigDecimal (
					// playerScore.intValue ());

					/*
					 * Copy the scores table and sort it
					 */
					final ConcurrentHashMap <AbstractUser, BigInteger> scoresCopy = new ConcurrentHashMap <AbstractUser, BigInteger> ();
					scoresCopy.putAll (scores);
					final LinkedHashMap <AbstractUser, BigInteger> sortedScores = LibMisc
					.sortHashMapByValues (scoresCopy);

					EventRecord event;
					try {
						event = Quaestor.getEventByID (eventID
								.intValue ());
						event.end (sortedScores);
						// user.acceptSuccessReply ("endEvent", user
						// .endMultiplayerEvent (eventID,
						// gameMoniker, "" + gameCode,
						// playerScoreDecimal,
						// sortedScores), user.getRoom ());
					} catch (final NotFoundException e) {
						AppiusClaudiusCaecus
						.reportBug (
								"Caught a NotFoundException in GameEvent.sendEndEvents Quaestor.getEventByID",
								e);
					}
				} else {
					AppiusClaudiusCaecus.blather (user
							.getAvatarLabel (), toString (), "",
							"user never started", false);
				}
			}
		}
		resetPlayers ();
	}

	/**
	 * Send an update on the score of the game to a player
	 *
	 * @param score the player's score
	 * @param player the player him/her-self
	 */
	private void sendScoreUpdate (final AbstractUser player,
			final BigInteger score) {
		int place = 1;
		for (final BigInteger i : scores.values ()) {
			if (i.compareTo (score) > 0) {
				++place;
			}
		}

		final JSONObject msg = new JSONObject ();
		try {
			msg.put ("score", score.toString ());
			msg.put ("place", place);
			player.acceptSuccessReply ("scoreUpdate", msg, player
					.getRoom ());
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (e);
		}

	}

	/**
	 * Send the start of events to all players
	 *
	 * @param gameMoniker The game's unique event moniker
	 */
	protected void sendStartEvents (final String gameMoniker) {
		AppiusClaudiusCaecus.blather ("", toString (), "",
				"sending start events", false);
		for (final int id : players) {
			final AbstractUser user = Nomenclator.getUserByID (id);
			if (null != user) {
				if (playerEvents.containsKey (Integer.valueOf (user
						.getUserID ()))) {
					AppiusClaudiusCaecus.blather (user
							.getAvatarLabel (), toString (), user
							.getIPAddress (), "already started", false);
				} else {
					AppiusClaudiusCaecus.blather (user
							.getAvatarLabel (), toString (), user
							.getIPAddress (), "starting user", false);
					try {
						final JSONObject result = Quaestor
						.startEvent_JSON (user, gameMoniker);
						user.acceptSuccessReply ("startEvent", result,
								user.getRoom ());

						playerEvents.put (Integer.valueOf (user
								.getUserID ()), Integer.valueOf (result
										.getInt ("eventID")));
					} catch (final JSONException e) {
						AppiusClaudiusCaecus.reportBug (e);
					}
				}
			}
		}
	}

	/**
	 * Send the game timers out to players and spectators. Uses the
	 * server time broadcast.
	 */
	private void sendTimers () {
		for (final int id : players) {
			final AbstractUser guy = Nomenclator.getUserByID (id);
			if (null != guy) {
				try {
					Commands.do_getServerTime (null, guy, guy
							.getRoom ().getRoomChannel ());
				} catch (final JSONException e) {
					AppiusClaudiusCaecus.reportBug (e);
				}
			}
		}
		for (final AbstractUser guy : getSpectators ()) {
			if (guy instanceof GeneralUser) {
				try {
					Commands.do_getServerTime (null, guy,
							((GeneralUser) guy).getRoom ()
									.getRoomChannel ());
				} catch (final JSONException e) {
					AppiusClaudiusCaecus.reportBug (e);
				}
			}
		}
	}

	/**
	 * @see org.starhope.appius.util.AcceptsMetronomeTicks#tick(long,
	 *      long)
	 */
	@Override
	public void tick (final long currentTime, final long deltaTime)
	throws UserDeadException {
		if (GameStateFlag.GAME_COUNTDOWN == gameState) {
			timer -= deltaTime;
			if (players.size () < 2) {
				changeGameState (GameStateFlag.GAME_SOLO);
			} else if (timer <= 0) {
				changeGameState (GameStateFlag.GAME_RUNNING);
			}
		} else if (GameStateFlag.GAME_RUNNING == gameState) {
			timer -= deltaTime;
			if (timer < 0) {
				if (players.size () < 2) {
					changeGameState (GameStateFlag.GAME_SOLO);
				} else {
					changeGameState (GameStateFlag.GAME_COUNTDOWN);
				}
			}
		}
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return getGameShortName () + "(" + getGameCode () + "@"
		+ getZone ().getName () + ")";

	}

	/**
	 * Send updated room variables with the game score and status.
	 */
	protected void updateRoomVars () {
		final HashMap <String, String> vars = new HashMap <String, String> ();
		vars.put ("numPlayers", String.valueOf (players.size ()));
		vars.put ("gameCode", "" + getGameCode ());
		switch (gameState) {
			case GAME_COUNTDOWN:
				vars.put ("leader", "");
				vars.put ("gameState", "countdown");
				break;
			case GAME_RUNNING:
				String leaderName = "";
			BigInteger leaderScore = BigInteger.ZERO;
			for (final Entry <AbstractUser, BigInteger> who : scores
						.entrySet ()) {
				final BigInteger playerScore = who.getValue ();
				if (playerScore.compareTo (leaderScore) > 0) {
					leaderName = who.getKey ().getAvatarLabel ();
					leaderScore = playerScore;
					}
				}
				vars.put ("leader", leaderScore + "~" + leaderName);
				vars.put ("gameState", "combat");
				break;
			case GAME_SOLO:
			default:
				vars.put ("leader", "");
				vars.put ("gameState", "practice");
				break;
		}
		for (final Room room : getScoreWatchRooms ()) {
			for (final Entry <String, String> var : vars.entrySet ()) {
				room.setVariable (var);
			}
		}
	}

	/**
	 * notify a player of their score
	 *
	 * @param who the player whose score is being sent
	 */
	@Override
	protected void updateScore (final AbstractUser who) {
		if (null != who && who instanceof GeneralUser) {
			final NetIOThread playerThread = ((GeneralUser) who)
			.getServerThread ();
			if (null != playerThread) {
				// final Integer who_id = Integer.valueOf (who
				// .getUserID ());
				if (scores.containsKey (who)) {
					final BigInteger score = scores.get (who);
					AppiusClaudiusCaecus.blather (
							who.getAvatarLabel (), toString (), "",
							"Score update = " + score.toString (),
							false);
					sendScoreUpdate (who, score);
				}
			}
		}
	}

	/**
	 * update all players of their scores and update room vars to boot
	 */
	protected void updateScores () {
		for (final int id : players) {
			final AbstractUser player = Nomenclator.getUserByID (id);
			updateScore (player);
		}
		updateRoomVars ();
	}



}
