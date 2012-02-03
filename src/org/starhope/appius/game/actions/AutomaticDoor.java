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
package org.starhope.appius.game.actions;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.RunCommands;
import org.starhope.appius.game.Zone;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.events.ActionHandler;
import org.starhope.appius.user.events.ActionMethod;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.AppiusConfig;

/**
 * This handles opening and closing automatic doors when players step
 * into specific “door mat” event polygons
 * 
 * @author brpocock@star-hope.org
 * @author ewinkelman@resinteractive.com
 */
public class AutomaticDoor implements RunCommands {

	/**
	 * @author brpocock@star-hope.org
	 */
	static final class DoorCancelHandler implements ActionMethod {
		/**
		 * @see org.starhope.appius.user.events.ActionMethod#acceptAction(org.starhope.appius.game.Room,
		 *      org.starhope.appius.user.AbstractUser, java.lang.String,
		 *      org.starhope.appius.user.AbstractUser, java.lang.String,
		 *      java.lang.Object[])
		 */
		@Override
		public boolean acceptAction (final Room where,
				final AbstractUser subject, final String verb,
				final AbstractUser object, final String indirectObject,
				final Object... trailer) {
			if ( !indirectObject.startsWith ("evt_$door_")) return false;

			final String doorAndSound = indirectObject.substring (10);
			final String [] doorParts = doorAndSound.split ("/");
			final String door = doorParts [0];
			final String [] sounds = (doorParts.length > 1 ? doorParts [1]
			                                                            : "").split (",");
			final String sound = sounds.length > 1 ? sounds [1] : "";
			final int wait = doorParts.length > 2 ? Integer
					.parseInt (doorParts [2]) * 1000 : 0;

					if (wait < 0) {
						AppiusClaudiusCaecus.getKalendor ().schedule (
								System.currentTimeMillis () + Math.abs (wait),
								new Runnable () {
									@Override
									public void run () {
										AutomaticDoor.closeDoor (where, door, sound);
									}
								});
					} else if (wait == 0) {
						AutomaticDoor.closeDoor (where, door, sound);
					}

					return false;
		}
	}

	/**
	 * @author brpocock@star-hope.org
	 */
	static final class DoorHandler implements ActionMethod {

		/**
		 * @see org.starhope.appius.user.events.ActionMethod#acceptAction(org.starhope.appius.game.Room,
		 *      org.starhope.appius.user.AbstractUser, java.lang.String,
		 *      org.starhope.appius.user.AbstractUser, java.lang.String,
		 *      java.lang.Object[])
		 */
		@Override
		public boolean acceptAction (final Room where,
				final AbstractUser subject, final String verb,
				final AbstractUser object, final String indirectObject,
				final Object... trailer) {
			if ( !indirectObject.startsWith ("evt_$door_")) return false;

			final String doorAndSound = indirectObject.substring (10);
			final String [] doorParts = doorAndSound.split ("/");
			final String door = doorParts [0];
			final String [] sounds = (doorParts.length > 1 ? doorParts [1]
			                                                            : "").split (",");
			final String openSound = sounds [0];
			final String closeSound = sounds.length > 1 ? sounds [1]
			                                                      : "";
			final int wait = doorParts.length > 2 ? Integer
					.parseInt (doorParts [2]) * 1000 : 0;

					if ( !"".equals (door)) {
						AutomaticDoor.openDoor (where, door, openSound);
					}

					if (wait > 0) {
						AppiusClaudiusCaecus.getKalendor ().schedule (
								System.currentTimeMillis () + wait,
								new Runnable () {

									@Override
									public void run () {
										AutomaticDoor.closeDoor (where, door, closeSound);
									}
								});
					}

					return false;
		}
	}

	/**
	 * users on doormats
	 */
	private static Map <String, Integer> doorCounter = new ConcurrentHashMap <String, Integer> ();

	/**
	 * close a door
	 * 
	 * @param where room in which the door is found
	 * @param door door moniker
	 * @param sound sound effect to play
	 */
	static synchronized void closeDoor (final Room where,
			final String door, final String sound) {
		final String str = door.toString () + "@" + where.toString ();
		Integer current = AutomaticDoor.doorCounter.get (str);
		if (null == current) {
			current = Integer.valueOf (1);
			AutomaticDoor.doorCounter.put (str, current);
		}
		final int curDoorCount = current.intValue () - 1;
		if (curDoorCount == 0) {
			if ( !"".equals (sound)) {
				final JSONObject soundKey = new JSONObject ();
				try {
					soundKey.put ("url", sound);
				} catch (final JSONException e) {
					AppiusClaudiusCaecus
					.reportBug (
							"Caught a JSONException in DoorHandler.acceptAction/playSound",
							e);
				}
				where.broadcast ("playSound", soundKey);
			}
			where.setVariable (AutomaticDoor.getDoorAnimationPrefix ()
					+ door, "door," + AutomaticDoor.getDoorClosedCode ());
		}
		if (curDoorCount > 0) {
			AutomaticDoor.doorCounter.put (str,
					Integer.valueOf (curDoorCount));
		} else {
			AutomaticDoor.doorCounter.remove (str);
		}
	}

	/**
	 * FIXME: Default is “door~,” it's fine for Tootsville to override
	 * it, but that shouldn't be put in here, that should be in the
	 * Tootsville config files.
	 * 
	 * @return the animation prefix to apply to doors' room variables.
	 *         (Default is “door~”)
	 */
	public static String getDoorAnimationPrefix () {
		return AppiusConfig
		.getConfigOrDefault (
				"org.starhope.appius.actions.AutomaticDoor.doorAnimationPrefix",
		"mc~");
	}

	/**
	 * @return string to indicate that a door is closed
	 */
	public static String getDoorClosedCode () {
		return AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.actions.AutomaticDoor.doorClosed",
		"closed");
	}

	/**
	 * @return string to indicate that a door is open
	 */
	public static String getDoorOpenCode () {
		return AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.actions.AutomaticDoor.doorOpen",
		"open");
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param where WRITEME
	 * @param door WRITEME
	 * @param sound WRITEME
	 */
	static synchronized void openDoor (final Room where,
			final String door, final String sound) {
		final String str = door.toString () + "@" + where.toString ();
		Integer current = AutomaticDoor.doorCounter.get (str);
		if (null == current) {
			current = Integer.valueOf (0);
			AutomaticDoor.doorCounter.put (str, current);
		}
		final int curDoorCount = current.intValue ();
		if (curDoorCount == 0) {
			if ( !"".equals (sound)) {
				final JSONObject soundKey = new JSONObject ();
				try {
					soundKey.put ("url", sound);
				} catch (final JSONException e) {
					AppiusClaudiusCaecus
					.reportBug (
							"Caught a JSONException in DoorHandler.acceptAction/playSound",
							e);
				}
				where.broadcast ("playSound", soundKey);
			}
			/*
			 * FIXME: this is (improperly) putting a Tootsville-specific
			 * prefix of “door,” before the door open code set in the
			 * config file. FIXME: This is a work-around for Tootsville,
			 * only, and should be set in the Tootsville config files,
			 * not hard-coded here.
			 */
			where.setVariable (AutomaticDoor.getDoorAnimationPrefix ()
					+ door, "door," + AutomaticDoor.getDoorOpenCode ());
		}
		AutomaticDoor.doorCounter.put (str,
				Integer.valueOf (curDoorCount + 1));
	}

	/**
	 * @see org.starhope.appius.game.RunCommands#newZone(org.starhope.appius.game.Zone)
	 */
	@Override
	public void newZone (final Zone z) {
		// no op
	}

	/**
	 * @see org.starhope.appius.game.RunCommands#run()
	 */
	@Override
	public void run () {
		Quaestor.listen (new ActionHandler (null, null,
				"event.srv.enter", null, new DoorHandler ()));
		Quaestor.listen (new ActionHandler (null, null,
				"event.srv.exit", null, new DoorCancelHandler ()));
	}

}
