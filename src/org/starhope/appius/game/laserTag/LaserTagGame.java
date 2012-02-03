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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.game.laserTag;

import java.math.BigInteger;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.GameEvent;
import org.starhope.appius.game.GameRoom;
import org.starhope.appius.game.GameStateFlag;
import org.starhope.appius.game.Zone;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.GetsConfigReload;

/**
 * @author brpocock@star-hope.org
 */
public abstract class LaserTagGame extends GameRoom implements
GetsConfigReload {

    /**
     * Java Serialization Unique ID
     */
    private static final long serialVersionUID = 9135761790789751729L;

	/**
	 * @param z the zone in which the game is being played
	 * @param ch character code for game event list
	 */
	public LaserTagGame (final Zone z, final char ch) {
		super (z, ch);
        AppiusConfig.wantConfigReload (this);
    }

    /**
     * @see org.starhope.appius.game.RoomListener#acceptGameAction(AbstractUser,
     *      JSONObject)
     */
    @Override
	public void acceptGameAction (final AbstractUser sender,
            final JSONObject action) {
        if (freezeTag) {
            return;
        }
        try {
            final String actionVerb = action.getString ("action");
            if ("gotShot".equals (actionVerb)
                    && GameStateFlag.GAME_RUNNING == gameState) {
                shotPVP (action);
            } else if ("shotObject".equals (actionVerb)) {
                shotObject (sender, action);
            }
        } catch (final JSONException e) {
            AppiusClaudiusCaecus.reportBug (
                    "Bad gameAction from client", e);
        }
        updateScores ();
    }

    /**
     * @see org.starhope.appius.game.RoomListener#acceptGameStateChange(org.starhope.appius.game.GameEvent,
     *      org.starhope.appius.game.GameStateFlag)
     */
    @Override
    public void acceptGameStateChange (final GameRoom game,
            final GameStateFlag newGameState) {
        System.err
        .println ("******\n\n Game State Transition!\n\n LaserTag: New gameState = "
                + newGameState.toString ()
                + "; old gameState = "
                + gameState.toString ()
                + "; players = "
                + players.size ()
                + "; spectators = "
                + getSpectators ().size ()
                + "\n******\n");

        if (GameStateFlag.GAME_SOLO == newGameState) {
            sendStartEvents (getGameEventPrefix () + ".solo");
        }
        if (GameStateFlag.GAME_SOLO == gameState
                && GameStateFlag.GAME_SOLO != newGameState) {
            sendEndEvents (getGameEventPrefix () + ".solo");
        }
        if (GameStateFlag.GAME_RUNNING == newGameState
                && GameStateFlag.GAME_RUNNING != gameState) {
            sendStartEvents (getGameEventPrefix () + ".game");
        }
        if (GameStateFlag.GAME_RUNNING == gameState
                && GameStateFlag.GAME_RUNNING != newGameState) {
            sendEndEvents (getGameEventPrefix () + ".game");
        }
        updateScores ();
        super.acceptGameStateChange (game, newGameState);
    }
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.util.GetsConfigReload#configUpdated()
	 */
    @Override
	public void configUpdated () {
        // No op?
    }

    /**
     * @return bonus points awarded to the leader, or else anyone tied
     *         for max score
     */
    @Override
    protected int getLeaderBonus () {
        return AppiusConfig.getIntOrDefault (
                "org.starhope.appius.game.LaserTagGame.leaderBonus", 0);
    }

    /**
     * @param type the target type, "itm" or "obs"
     * @param subtype the specific subtype of that target
     * @return the number of peanuts earned for hitting the given target
     */
	protected abstract BigInteger getScoreForObject (String type,
			int subtype);

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Mar 11,
	 * 2010)
	 * 
	 * @param sender WRITEME
	 * @param action WRITEME
	 * @throws JSONException WRITEME
	 * @throws NumberFormatException WRITEME
	 */
    private void shotObject (final AbstractUser sender,
            final JSONObject action) throws JSONException,
            NumberFormatException {
        final String [] typeParts = action.getString ("type")
        .split ("~");
        if (typeParts.length != 2) {
            AppiusClaudiusCaecus
            .reportBug ("User shot object: can't interpret type: "
                    + action.getString ("type"));
        } else {
            final String mainType = typeParts [0];
            if (AppiusConfig
                    .getConfigBoolOrFalse ("org.starhope.appius.game.LaserTag.cantShoot."
                            + mainType)) {
                return;
            }
            final int subType = Integer
            .parseInt (typeParts [1]);
			incrementScore (sender,
                    getScoreForObject (mainType, subType));
            sender.getRoom ().deleteVariable (
                    action.getString ("victim"));
        }
    }
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Mar 11,
	 * 2010)
	 * 
	 * @param action WRITEME
	 * @throws JSONException WRITEME
	 */
    private void shotPVP (final JSONObject action) throws JSONException {
        final AbstractUser shooter = Nomenclator.getUserByLogin (action
                .getString ("shooter"));
        final int shooterID = shooter.getUserID ();
        if (players.contains (Integer.valueOf (shooterID))) {
			incrementScore (shooter, BigInteger.valueOf (AppiusConfig
					.getIntOrDefault (getClass ().getCanonicalName ()
							+ ".hitPlayer", 10)));
        }
        final AbstractUser victim = Nomenclator.getUserByLogin (action
                .getString ("victim"));
        final int victimID = victim.getUserID ();
        if (players.contains (Integer.valueOf (victimID))) {
			decrementScore (victim, BigInteger.valueOf (AppiusConfig
					.getIntOrDefault (getClass ().getCanonicalName ()
							+ ".hitDeduct", 3)));
        }
    }

}
