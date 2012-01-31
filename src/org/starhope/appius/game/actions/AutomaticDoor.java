/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 * Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public
 * License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game.actions;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Room;
import org.starhope.appius.util.AppiusConfig;

/**
 * This handles opening and closing automatic doors when players step
 * into specific “door mat” event polygons
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class AutomaticDoor {
	
	/**
	 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	static final class DoorCancelHandler extends
			ActionEventAreaExitHandler {
		
		/**
		 * @see org.starhope.appius.game.actions.ActionEventAreaExitHandler#invoke(org.starhope.appius.game.actions.ActionEventAreaExit)
		 */
		@Override
		public void invoke (final ActionEventAreaExit action) {
			if ( !action.getEventArea ().startsWith ("evt_$door_")) {
				return;
			}
			
			final String doorAndSound = action.getEventArea ()
					.substring (10);
			final String [] doorParts = doorAndSound.split ("/");
			final String door = doorParts [0];
			final String [] sounds = (doorParts.length > 1 ? doorParts [1]
					: "").split (",");
			final String sound = sounds.length > 1 ? sounds [1] : "";
			final int wait = doorParts.length > 2 ? Integer
					.parseInt (doorParts [2]) * 1000 : 0;
			
			if (wait < 0) {
				AppiusClaudiusCaecus.getKalendor ().schedule (
						System.currentTimeMillis ()
								+ Math.abs (wait),
						new Runnable () {
							@Override
							public void run () {
								AutomaticDoor.closeDoor (
										action.getSource (),
										door, sound);
							}
						});
			} else if (wait == 0) {
				AutomaticDoor.closeDoor (action.getSource (), door,
						sound);
			}
		}
	}
	
	/**
	 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	static final class DoorHandler extends ActionEventAreaEnterHandler {
		
		/**
		 * @see org.starhope.appius.game.actions.ActionEventAreaEnterHandler#invoke(org.starhope.appius.game.actions.ActionEventAreaEnter)
		 */
		@Override
		public void invoke (final ActionEventAreaEnter action) {
			if ( !action.getEventArea ().startsWith ("evt_$door_")) {
				return;
			}
			
			final String doorAndSound = action.getEventArea ()
					.substring (10);
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
				AutomaticDoor.openDoor (action.getSource (), door,
						openSound);
			}
			
			if (wait > 0) {
				AppiusClaudiusCaecus.getKalendor ().schedule (
						System.currentTimeMillis () + wait,
						new Runnable () {
							
							@Override
							public void run () {
								AutomaticDoor.closeDoor (
										action.getSource (),
										door, closeSound);
							}
						});
			}
		}
	}
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final static DoorCancelHandler cancelHandler = new DoorCancelHandler ();
	
	/**
	 * users on doormats
	 */
	private static Map <String, Integer> doorCounter = new ConcurrentHashMap <String, Integer> ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final static DoorHandler doorHandler = new DoorHandler ();
	
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
					BugReporter
							.getReporter ("srv")
							.reportBug (
									"Caught a JSONException in DoorHandler.acceptAction/playSound",
									e);
				}
				where.broadcast ("playSound", soundKey);
			}
			where.setVariable (
					AutomaticDoor.getDoorAnimationPrefix () + door,
					"door," + AutomaticDoor.getDoorClosedCode ());
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
		return AppiusConfig
				.getConfigOrDefault (
						"org.starhope.appius.actions.AutomaticDoor.doorClosed",
						"closed");
	}
	
	/**
	 * @return string to indicate that a door is open
	 */
	public static String getDoorOpenCode () {
		return AppiusConfig
				.getConfigOrDefault (
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
					BugReporter
							.getReporter ("srv")
							.reportBug (
									"Caught a JSONException in DoorHandler.acceptAction/playSound",
									e);
				}
				where.broadcast ("playSound", soundKey);
			}
			/*
			 * FIXME: this is (improperly) putting a
			 * Tootsville-specific prefix of “door,” before the door
			 * open code set in the config file. FIXME: This is a
			 * work-around for Tootsville, only, and should be set in
			 * the Tootsville config files, not hard-coded here.
			 */
			where.setVariable (
					AutomaticDoor.getDoorAnimationPrefix () + door,
					"door," + AutomaticDoor.getDoorOpenCode ());
		}
		AutomaticDoor.doorCounter.put (str,
				Integer.valueOf (curDoorCount + 1));
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param room WRITEME 
	 */
	public static void registerListeners (final Room room) {
		room.subscribe (AutomaticDoor.doorHandler);
		room.subscribe (AutomaticDoor.cancelHandler);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param room WRITEME 
	 */
	public static void unregisterListeners (final Room room) {
		room.unsubscribe (AutomaticDoor.doorHandler);
		room.unsubscribe (AutomaticDoor.cancelHandler);
	}
	
}
