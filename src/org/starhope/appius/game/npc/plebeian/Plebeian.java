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
package org.starhope.appius.game.npc.plebeian;

import java.util.concurrent.atomic.AtomicInteger;

import org.json.JSONObject;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.GameRoom;
import org.starhope.appius.game.GameStateFlag;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.RoomChannel;
import org.starhope.appius.game.RoomListener;
import org.starhope.appius.game.Zone;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.user.AbstractNonPlayerCharacter;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.events.Action;

/**
 * <p>
 * The Plebeian class is a base class for simply scripted NPC:s using the
 * Plebeian structure, which is meant to be a fairly understandable
 * scripting language for basic state machine representation.
 * </p>
 * <p>
 * TODO: document secret Plebeian script language!
 * </p>
 * <p>
 * Note that there are probably significant problems with the
 * implementation of simultaneous steps in a plebian script. For now,
 * all scripts should use only the sequential keywords (e.g. "then" or
 * "&" between steps). I haven't had time to resolve the issues involved
 * in correctly handling simultaneous steps just yet — they might
 * potentially “blow up” the script interpreter system.
 * </p>
 * @author brpocock@star-hope.org
 */
public class Plebeian extends AbstractNonPlayerCharacter implements
ScriptPuppet {

	/**
	 * unique instance ID generator
	 */
	private static final AtomicInteger instanceCounter = new AtomicInteger ();

	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 818315216872740970L;

	/**
	 * script runner object
	 */
	PlebeianScriptRunner scriptRunner = new PlebeianScriptRunner (this);

	/**
	 * Spawn a new Plebeian into a certain Zone
	 * 
	 * @param z the zone in which to spawn
	 * @param login the name of the Plebeian; the user name must match
	 *            (case-insensitive), and the script file name will be
	 *            the same in lower-case, with a “.pleb” extension
	 *            suffixed
	 * @throws NotFoundException if the user account isn't found or the
	 *             zone doesn't have a “nowhere” room
	 * @throws GameLogicException if the character is not an NPC or the
	 *             (NPC-NAME-HERE).pleb script is not found
	 */
	public Plebeian (final Zone z, final String login)
	throws NotFoundException,
	GameLogicException {
		super (login);
		final Room nowhere = z.getRoom ("nowhere");
		nowhere.join (this);
		setRoom (nowhere);
		scriptRunner.load (login);
		scriptRunner.setLogicalState ("Starting!");
	}

	/**
	 * @see org.starhope.appius.user.AbstractNonPlayerCharacter#acceptErrorReply(java.lang.String,
	 *      java.lang.String, org.json.JSONObject,
	 *      org.starhope.appius.game.Room)
	 */
	@Override
	public void acceptErrorReply (final String command,
			final String error, final JSONObject result,
			final Room userCurrentRoomInZone) {
		scriptRunner.dispatch (new Action (userCurrentRoomInZone, this,
				command + ".err", error));
	}

	/**
	 * @see org.starhope.appius.user.AbstractNonPlayerCharacter#acceptGameAction(org.starhope.appius.user.AbstractUser,
	 *      org.json.JSONObject)
	 */
	@Override
	public void acceptGameAction (final AbstractUser u,
			final JSONObject action) {
		scriptRunner.dispatch (new Action (u, "gameAction", action));
	}

	/**
	 * @see org.starhope.appius.user.AbstractNonPlayerCharacter#acceptGameStateChange(org.starhope.appius.game.GameEvent,
	 *      org.starhope.appius.game.GameStateFlag)
	 */
	@Override
	public void acceptGameStateChange (final GameRoom gameCode,
			final GameStateFlag gameState) {
		scriptRunner.dispatch (new Action ((AbstractUser) null,
				"gameStateChange", (AbstractUser) null, gameCode
				.getClass ().toString ()
				+ "/" + gameState));
	}

	/**
	 * @see org.starhope.appius.user.AbstractNonPlayerCharacter#acceptMessage(java.lang.String,
	 *      java.lang.String, java.lang.String)
	 */
	@Override
	public void acceptMessage (final String title, final String label,
			final String content) {
		scriptRunner.dispatch (new Action ((AbstractUser) null, "msg",
				this, label, title, content));
	}

	/**
	 * @see org.starhope.appius.user.GeneralUser#acceptObjectJoinRoom(org.starhope.appius.game.Room,
	 *      org.starhope.appius.game.RoomListener)
	 */
	@Override
	public void acceptObjectJoinChannel (final RoomChannel channel,
			final RoomListener object) {
		if (object instanceof AbstractUser) {
			scriptRunner
					.dispatch (new Action (channel.getRoom (),
							(AbstractUser) object,
							"join", (AbstractUser) null));
		} else {
			scriptRunner.dispatch (new Action (channel.getRoom (),
					(AbstractUser) null, "join.listener",
					(AbstractUser) null, object));
		}
	}

	/**
	 * @see org.starhope.appius.user.GeneralUser#acceptObjectPartRoom(org.starhope.appius.game.Room,
	 *      org.starhope.appius.game.RoomListener)
	 */
	@Override
	public void acceptObjectPartChannel (final RoomChannel channel,
			final RoomListener thing) {
		if (thing instanceof AbstractUser) {
			scriptRunner.dispatch (new Action (channel.getRoom (),
					(AbstractUser) thing, "part", (AbstractUser) null));
		} else {
			scriptRunner.dispatch (new Action (channel.getRoom (),
					(AbstractUser) null, "part.listener",
					(AbstractUser) null, thing));
		}
	}

	/**
	 * @see org.starhope.appius.user.GeneralUser#acceptOutOfBandMessage(org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.Room, org.json.JSONObject)
	 */
	@Override
	public void acceptOutOfBandMessage (final AbstractUser sender,
			final RoomChannel channel, final JSONObject body) {
		scriptRunner.dispatch (new Action (channel.getRoom (), sender,
				"oob", body));
	}

	/**
	 * @see org.starhope.appius.user.AbstractNonPlayerCharacter#acceptPrivateMessage(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	@Override
	public void acceptPrivateMessage (final AbstractUser speaker,
			final String speech) {
		scriptRunner.dispatch (new Action (speaker, "whisper", speech));
	}

	/**
	 * @see org.starhope.appius.user.AbstractNonPlayerCharacter#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.Room, java.lang.String)
	 */
	@Override
	public void acceptPublicMessage (final AbstractUser sender,
			final RoomChannel channel, final String message) {
		if (sender instanceof ScriptPuppet
				|| sender instanceof AbstractNonPlayerCharacter) {
			return;
		}
		setFacing ("S"); // XXX
		scriptRunner.dispatch (new Action (channel.getRoom (), sender,
				"said",
				message));
	}

	/**
	 * @see org.starhope.appius.user.AbstractNonPlayerCharacter#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	@Override
	public void acceptPublicMessage (final AbstractUser sender,
			final String message) {
		if (sender instanceof ScriptPuppet
				|| sender instanceof AbstractNonPlayerCharacter) {
			return;
		}
		scriptRunner.dispatch (new Action (sender, "said", message));
	}

	/**
	 * @see org.starhope.appius.user.AbstractNonPlayerCharacter#acceptSuccessReply(java.lang.String,
	 *      org.json.JSONObject, org.starhope.appius.game.Room)
	 */
	@Override
	public void acceptSuccessReply (final String command,
			final JSONObject jsonData, final Room room) {
		scriptRunner.dispatch (new Action (room, this, command + ".ok",
				jsonData));
	}

	@Override
	public void acceptUserAction (RoomChannel r, AbstractUser u) {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see org.starhope.appius.user.GeneralUser#acceptUserVariableUpdate(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String, java.lang.String)
	 */
	@Override
	public void acceptUserVariableUpdate (final AbstractUser user,
			final String varName, final String varValue) {
		scriptRunner.dispatch (new Action (user, "uvar", varName,
				varValue));
	}

	/**
	 * @see org.starhope.appius.user.AbstractUser#ban(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	@Override
	public void ban (final AbstractUser u, final String banReason)
	throws PrivilegeRequiredException {
		destroy ();
	}

	/**
	 * @see org.starhope.appius.user.AbstractNonPlayerCharacter#destroy()
	 */
	@Override
	public void destroy () {
		getScriptRunner ().clearScript ();
		scriptRunner=null;
		super.destroy ();
	}

	/**
	 * @see org.starhope.appius.user.AbstractNonPlayerCharacter#getInstanceID()
	 */
	@Override
	protected int getInstanceID () {
		return Plebeian.instanceCounter.incrementAndGet ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	@Override
	public PlebeianScriptRunner getScriptRunner () {
		return scriptRunner;
	}


	/**
	 * @see org.starhope.appius.game.npc.plebeian.ScriptPuppet#getShortLabel()
	 */
	@Override
	public String getShortLabel () {
		return AbstractNonPlayerCharacter
		.getNameStripped (getAvatarLabel ());
	}

	/**
	 * @see org.starhope.appius.game.npc.plebeian.ScriptPuppet#seekRoom(org.starhope.appius.game.Room)
	 */
	@Override
	public void seekRoom (final Room r) {
		pathFinder.seekRoom (r);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#sendResponse(org.starhope.appius.net.datagram.AbstractDatagram)
	 */
	@Override
	public void sendResponse (AbstractDatagram datagram) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractNonPlayerCharacter#tick(long,
	 *      long)
	 */
	@Override
	public void tick (final long currentTime, final long deltaTime)
	throws UserDeadException {
		if (scriptRunner.getLastScriptTime () + 1000 < currentTime) {
			scriptRunner.doNextToDoItem ();
		}
		if (scriptRunner.getLastScriptTime () + 30000 < currentTime) {
			scriptRunner.dispatch (new Action ("idle"));
			scriptRunner.setLastScriptTime (currentTime);
		}
		casualSpeechRate = 7500;
		super.tick (currentTime, deltaTime);
	}
	
}
