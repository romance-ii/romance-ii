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

import java.util.Collections;
import java.util.ConcurrentModificationException;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.CancellationException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.geometry.Vector3D;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.util.AcceptsMetronomeTicks;
import org.starhope.appius.util.AppiusConfig;

/**
 * Run physics/simulation tasks on a fixed schedule without taxing the
 * global metronome
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class PhysicsScheduler {
	
	/**
	 * helper class buddy
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private static final class Crankshaft implements Runnable {
		/**
		 * last tick time
		 */
		private long then = System.currentTimeMillis ();
		
		/**
		 * Constructor
		 */
		public Crankshaft () {
			// Nothing to do
		}
		
		/**
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run () {
			final long now = System.currentTimeMillis ();
			
			final List <AbstractUser> interestingPeople = new LinkedList <AbstractUser> ();
			synchronized (PhysicsScheduler.interestingPersons) {
				for (final AbstractUser person : PhysicsScheduler.interestingPersons) {
					interestingPeople.add (person);
				}
			}
			for (final AbstractUser abstractUser : interestingPeople) {
				PhysicsScheduler.updateUserPositioning (
						abstractUser, now);
			}
			
			synchronized (PhysicsScheduler.wannabes) {
				for (final AcceptsMetronomeTicks engine : PhysicsScheduler.wannabes) {
					PhysicsScheduler.listeners.add (engine);
				}
				PhysicsScheduler.wannabes.clear ();
			}
			
			synchronized (PhysicsScheduler.exs) {
				for (final AcceptsMetronomeTicks engine : PhysicsScheduler.exs) {
					PhysicsScheduler.listeners.remove (engine);
				}
				PhysicsScheduler.exs.clear ();
			}
			
			for (final AcceptsMetronomeTicks engine : PhysicsScheduler.listeners) {
				
				try {
					engine.tick (now, now - then);
				} catch (final UserDeadException e) {
					// no op
				} catch (final RuntimeException e) {
					BugReporter
							.getReporter ("srv")
							.reportBug (
									"Exception in Crankshaft for PhysicsScheduler",
									e);
				}
			}
			then = now;
		}
	}
	
	/**
	 * Things that no longer want to be listeners
	 */
	final static LinkedList <AcceptsMetronomeTicks> exs = new LinkedList <AcceptsMetronomeTicks> ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static ScheduledFuture <?> future;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final static List <AbstractUser> interestingPersons = Collections
			.synchronizedList (new LinkedList <AbstractUser> ());
	
	/**
	 * All listeners
	 */
	final static LinkedList <AcceptsMetronomeTicks> listeners = new LinkedList <AcceptsMetronomeTicks> ();
	
	/**
	 * Universal scheduler
	 */
	private final static ScheduledExecutorService scheduler = Executors
			.newScheduledThreadPool (1);
	
	/**
	 * Things that want to be listeners
	 */
	final static LinkedList <AcceptsMetronomeTicks> wannabes = new LinkedList <AcceptsMetronomeTicks> ();
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param listener WRITEME 
	 */
	public static void add (final AcceptsMetronomeTicks listener) {
		synchronized (PhysicsScheduler.wannabes) {
			if (null != listener) {
				try {
					PhysicsScheduler.wannabes.add (listener);
				} catch (final ConcurrentModificationException e) {
					PhysicsScheduler.log
							.error ("Got a concurrent modification exception inside of a lock?");
				}
			}
		}
	}
	
	/**
	 * Adds a person to the list of things to have their locations
	 * automatically updated
	 * 
	 * @param user WRITEME 
	 */
	public static void addPersonOfInterest (final AbstractUser user) {
		PhysicsScheduler.interestingPersons.add (user);
	}
	
	/**
	 * Look for errors in the futures
	 */
	public static void purgeFutures () {
		if (null != PhysicsScheduler.future) {
			try {
				PhysicsScheduler.future.get (1,
						TimeUnit.MILLISECONDS);
				PhysicsScheduler.future.cancel (false);
			} catch (final TimeoutException e) {
				PhysicsScheduler.log
						.error ("Timed out trying to purge ");
			} catch (final InterruptedException e) {
				PhysicsScheduler.log
						.error ("Caught a InterruptedException in PhysicsScheduler.purgeFutures",
								e);
			} catch (final ExecutionException e) {
				PhysicsScheduler.log
						.error ("Caught a ExecutionException in PhysicsScheduler.purgeFutures",
								e);
			} catch (final Throwable t) {
				PhysicsScheduler.log
						.error ("Caught something fucked-up in PhysicsScheduler.purgeFutures",
								t);
			}
			PhysicsScheduler.future = null;
		}
		PhysicsScheduler.start ();
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param listener WRITEME 
	 */
	public static void remove (final AcceptsMetronomeTicks listener) {
		synchronized (PhysicsScheduler.exs) {
			if (null != listener) {
				try {
					PhysicsScheduler.exs.add (listener);
				} catch (final ConcurrentModificationException e) {
					PhysicsScheduler.log
							.error ("Got a concurrent modification exception inside of a lock?");
				}
			}
		}
	}
	
	/**
	 * Removes a person from the list of things to have their locations
	 * automatically updated
	 * 
	 * @param user WRITEME 
	 */
	public static void removePersonOfInterest (final AbstractUser user) {
		PhysicsScheduler.interestingPersons.remove (user);
	}
	
	/**
	 * stop all currently-scheduled threads
	 */
	public static void shutdown () {
		PhysicsScheduler.stop ();
		synchronized (PhysicsScheduler.listeners) {
			PhysicsScheduler.listeners.clear ();
		}
	}
	
	/**
	 * Starts ticking
	 */
	public static void start () {
		if (PhysicsScheduler.future == null) {
			final int initialDelay = AppiusConfig
					.getIntOrDefault (
							"org.starhope.appius.physica.PhysicsThread.initialDelay",
							100);
			final int interval = AppiusConfig
					.getIntOrDefault (
							"org.starhope.appius.physica.PhysicsThread.interval",
							20);
			PhysicsScheduler.future = PhysicsScheduler.scheduler
					.scheduleAtFixedRate (new Crankshaft (),
							initialDelay, interval,
							TimeUnit.MILLISECONDS);
		}
	}
	
	/**
	 * Stops ticking
	 */
	private static void stop () {
		if (null != PhysicsScheduler.future) {
			PhysicsScheduler.future.cancel (true);
			try {
				PhysicsScheduler.future.get (1,
						TimeUnit.MILLISECONDS);
			} catch (final InterruptedException e) {
				// don't care
			} catch (final ExecutionException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a ExecutionException in PhysicsScheduler.stop ",
								e);
			} catch (final TimeoutException e) {
				// don't care
			} catch (final CancellationException e) {
				// ignore it?
			}
			PhysicsScheduler.future.cancel (true);
			PhysicsScheduler.future = null;
		}
	}
	
	/**
	 * Determine the object's current position and updates it
	 * 
	 * @param thing what is moving
	 * @param when what time is it now
	 */
	static void updateUserPositioning (final AbstractUser thing,
			final long when) {
		
		try {
			final Coord3D startPos = thing.getLocation ();
			final Coord3D endPos = thing.getTarget ();
			final Vector3D vector = new Vector3D (startPos, endPos);
			
			if (vector.length () == 0) {
				return;
			} else if ( (vector.length () > 0d)
					&& (vector.length () < 1d)) {
				thing.setLocation (endPos);
				thing.setTravelStart (when);
			} else {
				final double travelTime = when
						- thing.getTravelStart ();
				final double rate = thing.getTravelRate ();
				final Vector3D distance = vector.normalize ()
						.multiply ( (rate * travelTime) / 1000d);
				if (distance.length () > vector.length ()) {
					thing.setLocation (endPos);
				} else {
					thing.setLocation (startPos.add (
							distance.getX (), distance.getY (),
							distance.getZ ()));
				}
				thing.setTravelStart (when);
			}
		} catch (final Exception e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}
}
