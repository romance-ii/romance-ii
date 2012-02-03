/**
 * <p>
 * Copyright © 2010, brpocock@star-hope.org
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
package com.tootsville.game;

import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.GameRoom;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.RoomChannel;
import org.starhope.appius.game.Zone;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.util.AppiusConfig;

/**
 * Set the weather value to the special Props animation on each screen
 * across the main row of Tootsville on a timer
 * 
 * @author brpocock@star-hope.org
 */
public class PropsWeather extends GameRoom {

	/**
	 * Java serialization unique ID
	 */
	private static final long serialVersionUID = 7580121413655444221L;

	/**
	 * The ordered set of rooms for which the weather is to be set
	 */
	private final Room [] animationRooms;

	/**
	 * The current phase of the animation sequence
	 */
	private long phase = 0;

	/**
	 * Instantiate the Props weather pattern
	 * 
	 * @param z The zone to which it should be connected
	 */
	public PropsWeather (final Zone z) {
		super (z, 'p');
		try {
			animationRooms = new Room [] { (z.getRoom ("soccerField")),
					(z.getRoom ("tootUniversity")),
					(z.getRoom ("tootSquare")),
					(z.getRoom ("tootSquareWest")),
					(z.getRoom ("motorSpeedway")) };
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus
			.reportBug (
					"Caught a NotFoundException in PropsWeather getting rooms ",
					e);
			throw new RuntimeException (e);
		}
		for (int i = 0; i < animationRooms.length; ++i) {
			if (null == animationRooms [i]) {
				AppiusClaudiusCaecus
				.reportBug ("Can't find room (misspelled?) seq#"
						+ i);
			}
		}
		phase = 0;
		AppiusClaudiusCaecus.add (this);
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.RoomListener#acceptGameAction(org.starhope.appius.user.AbstractUser,
	 *      org.json.JSONObject)
	 */
	@Override
	public void acceptGameAction (final AbstractUser u,
			final JSONObject action) {
		// no op

	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.RoomListener#acceptOutOfBandMessage(org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.Room, org.json.JSONObject)
	 */
	@Override
	public void acceptOutOfBandMessage (final AbstractUser sender,
			final RoomChannel channel, final JSONObject body) {
		// no op

	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.RoomListener#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	@Override
	public void acceptPublicMessage (final AbstractUser from,
			final String message) {
		// no op

	}

	/**
	 * @see org.starhope.appius.game.RoomListener#acceptUserAction(org.starhope.appius.game.Room,
	 *      org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void acceptUserAction (final RoomChannel channel,
			final AbstractUser u) {
		// No op
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.GameEvent#getGameEventPrefix()
	 */
	@Override
	public String getGameEventPrefix () {
		return null;
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.util.HasName#getName()
	 */
	@Override
	public String getName () {
		return "PropsWeather";
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.GameEvent#tick(long, long)
	 */
	@Override
	public void tick (final long currentTime, final long deltaTime)
	throws UserDeadException {
		final int frequency = AppiusConfig.getIntOrDefault (
				"com.tootsville.game.PropsWeather.freq", 600000);
		final int stepTime = AppiusConfig.getIntOrDefault (
				"com.tootsville.game.PropsWeather.step", 60000);
		final long newPhase = currentTime % frequency / stepTime;
		if (phase == newPhase) return;
		phase = newPhase;
		AppiusClaudiusCaecus
		.blather ("PropsWeather: transition to phase " + phase);
		for (int i = 0; i < animationRooms.length; ++i) {
			animationRooms [i]
			                .setOverlay (i == phase ? "propsPlaneMessageNT.swf"
			                		: "");
		}
		super.tick (currentTime, deltaTime);
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.game.GameEvent#updateRoomVars()
	 */
	@Override
	protected void updateRoomVars () {
		/* No! Don't! */
	}
	
}
