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
package org.starhope.appius.game;

import java.math.BigInteger;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;

import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.util.AcceptsMetronomeTicks;
import org.starhope.util.LibMisc;

/**
 * A GameEvent is a room-wide (or multi-room) game that occurs within
 * the larger context of the game. Think “arena” or similar.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public abstract class GameEvent implements AcceptsMetronomeTicks {
	
	/**
	 * Java serialization unique ID serialVersionUID (long)
	 */
	private static final long serialVersionUID = -6751701646654524655L;
	
	/**
	 * the unique identifier for this game instance
	 */
	protected final String gameInstance;
	
	/**
	 * the players (in any room)
	 */
	protected ConcurrentSkipListSet <Integer> players = new ConcurrentSkipListSet <Integer> ();
	
	/**
	 * the current scores for all players
	 */
	protected final ConcurrentHashMap <AbstractUser, BigInteger> scores = new ConcurrentHashMap <AbstractUser, BigInteger> ();
	
	/**
	 * The zone zone (GameEvent)
	 */
	protected final Zone zone;
	
	/**
	 * @param z the zone in which the game is being played
	 * @param c the game code character
	 */
	protected GameEvent (final Zone z, final String moniker) {
		gameInstance = moniker;
		zone = z;
	}
	
	/**
	 * @param u The operator issuing the command
	 * @param arena The room in which the operator's command is being
	 *             executed
	 * @param command The command and parameters
	 */
	public void acceptCommand (final AbstractUser u, final Room arena,
			final String [] command) {
		/* No op */
	}
	
	/**
	 * Destroy this event — during Zone shutdown usually
	 */
	public void destroySelf () {
		// AppiusClaudiusCaecus.blather ("Destroying myself! " +
		// getName
		// () + "@" + getZone ().getName ());
		AppiusClaudiusCaecus.remove (this);
	}
	
	/**
	 * Stupid case of equals override.
	 * 
	 * @param other other game event
	 * @return true if they're the same
	 */
	public boolean equals (final GameEvent other) {
		return this == other;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object other) {
		if (other instanceof GameEvent) {
			return this.equals ((GameEvent) other);
		}
		return false;
	}
	
	/**
	 * @return all players and spectators
	 */
	public Set <AbstractUser> getEveryone () {
		final Set <AbstractUser> everyone = getPlayers ();
		everyone.addAll (getSpectators ());
		return everyone;
	}
	
	/**
	 * Get the prefix to be applied to event types for this game
	 * 
	 * @return the string prefix used to find event types for this game
	 */
	public abstract String getGameEventPrefix ();
	
	/**
	 * @return the game moniker
	 */
	public String getGameInstanceMoniker () {
		return gameInstance;
	}
	
	/**
	 * @return the short name of the game: the class name without its
	 *         package (canonical) prefix
	 */
	public String getGameShortName () {
		final String [] canonicalName = this.getClass ()
				.getCanonicalName ().split ("\\.");
		return canonicalName [canonicalName.length - 1];
	}
	
	/**
	 * @return all players
	 */
	public Set <AbstractUser> getPlayers () {
		final HashSet <AbstractUser> ret = new HashSet <AbstractUser> ();
		return ret;
	}
	
	/**
	 * @return all spectators
	 */
	public Set <AbstractUser> getSpectators () {
		final HashSet <AbstractUser> ret = new HashSet <AbstractUser> ();
		return ret;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.RoomListener#getZone()
	 */
	public Zone getZone () {
		return zone;
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
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return getGameShortName () + "(" + getGameInstanceMoniker ()
				+ "@" + getZone ().getName () + ")";
		
	}
	
	/**
	 * notify a player of their score
	 * 
	 * @param who the player whose score is being sent
	 */
	protected void updateScore (final AbstractUser who) {
		// FIXME … Missing… ?
	}
	
}
