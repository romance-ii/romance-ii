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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
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
import org.starhope.appius.physica.Geometry;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.util.AcceptsMetronomeTicks;
import org.starhope.appius.util.AppiusConfig;

/**
 *Run physics/simulation tasks on a fixed schedule without taxing the
 * global metronome
 *
 * @author brpocock@star-hope.org
 */
public class PhysicsScheduler {

	/**
	 * helper class buddy
	 *
	 * @author brpocock@star-hope.org
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
			
			synchronized (interestingPersons) {
				for (AbstractUser person : interestingPersons) {
					Geometry.updateUserPositioning (person, now);
				}
			}
			
			synchronized (wannabes) {
				for (AcceptsMetronomeTicks engine : wannabes) {
					listeners.add (engine);
				}
				wannabes.clear ();
			}
			
			synchronized (exs) {
				for (AcceptsMetronomeTicks engine : exs) {
					listeners.remove (engine);
				}
				exs.clear ();
			}

			for (AcceptsMetronomeTicks engine : listeners) {
				
				try {
					engine.tick (now, now - then);
				} catch (final UserDeadException e) {
					// no op
				} catch (final RuntimeException e) {
					AppiusClaudiusCaecus
							.reportBug (
									"Exception in Crankshaft for PhysicsScheduler",
									e);
				}
			}
			then = now;
		}
	}
	
	/**
	 * All listeners
	 */
	final static LinkedList <AcceptsMetronomeTicks> listeners = new LinkedList <AcceptsMetronomeTicks> ();
	
	/**
	 * Things that want to be listeners
	 */
	final static LinkedList <AcceptsMetronomeTicks> wannabes = new LinkedList <AcceptsMetronomeTicks> ();
	
	/**
	 * Things that no longer want to be listeners
	 */
	final static LinkedList <AcceptsMetronomeTicks> exs = new LinkedList <AcceptsMetronomeTicks> ();
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	final static List <AbstractUser> interestingPersons = Collections
			.synchronizedList (new LinkedList <AbstractUser> ());

	/**
	 * Universal scheduler
	 */
	private final static ScheduledExecutorService scheduler = Executors
			.newScheduledThreadPool (1);

	/**
	 * WRITEME: Document this ewinkelman
	 */
	private static ScheduledFuture <?> future;

	/**
	 * Look for errors in the futures
	 */
	public static void purgeFutures () {
		if (null != future) {
			try {
				future.get (1, TimeUnit.MILLISECONDS);
				future.cancel (false);
			} catch (final TimeoutException e) {
				AppiusClaudiusCaecus
						.blather ("Timed out trying to purge ");
			} catch (final InterruptedException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a InterruptedException in PhysicsScheduler.purgeFutures",
								e);
			} catch (final ExecutionException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a ExecutionException in PhysicsScheduler.purgeFutures",
								e);
			} catch (final Throwable t) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught something fucked-up in PhysicsScheduler.purgeFutures",
								t);
			}
			future = null;
		}
		PhysicsScheduler.start ();
	}

	/**
	 * stop all currently-scheduled threads
	 */
	public static void shutdown () {
		stop ();
		synchronized (listeners) {
			listeners.clear ();
		}
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param listener
	 */
	public static void add (AcceptsMetronomeTicks listener) {
		synchronized (wannabes) {
			if (null != listener) {
				try {
					wannabes.add (listener);
				} catch (ConcurrentModificationException e) {
					AppiusClaudiusCaecus
							.reportBug ("Got a concurrent modification exception inside of a lock?");
				}
			}
		}
	}
	
	/**
	 * Adds a person to the list of things to have their locations
	 * automatically updated
	 * 
	 * @param user
	 */
	public static void addPersonOfInterest (AbstractUser user) {
		interestingPersons.add (user);
	}

	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param listener
	 */
	public static void remove (AcceptsMetronomeTicks listener) {
		synchronized (exs) {
			if (null != listener) {
				try {
					exs.add (listener);
				} catch (ConcurrentModificationException e) {
					AppiusClaudiusCaecus
							.reportBug ("Got a concurrent modification exception inside of a lock?");
				}
			}
		}
	}

	/**
	 * Removes a person from the list of things to have their locations
	 * automatically updated
	 * 
	 * @param user
	 */
	public static void removePersonOfInterest (AbstractUser user) {
		interestingPersons.remove (user);
	}

	/**
	 * Starts ticking
	 */
	public static void start () {
		if (future == null) {
			final int initialDelay = AppiusConfig
					.getIntOrDefault (
							"org.starhope.appius.physica.PhysicsThread.initialDelay",
							33);
			final int interval = AppiusConfig
					.getIntOrDefault (
							"org.starhope.appius.physica.PhysicsThread.interval",
							33);
			future = scheduler.scheduleAtFixedRate (new Crankshaft (),
					initialDelay, interval, TimeUnit.MILLISECONDS);
		}
	}
	
	/**
	 * Stops ticking
	 *
	 */
	private static void stop () {
		if (null != future) {
			future.cancel (true);
			try {
				future.get (1, TimeUnit.MILLISECONDS);
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
			future.cancel (true);
			future = null;
		}
	}
}
