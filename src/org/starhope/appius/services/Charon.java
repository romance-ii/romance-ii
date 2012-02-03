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
package org.starhope.appius.services;

import java.lang.ref.WeakReference;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.AppiusConfig;

/**
 * Charon is the reaper for zombie threads. It just removes threads from
 * the server to clear out the memory and process space and such —
 * threadwise garbage collection.
 *
 * @author brpocock@star-hope.org
 */
public class Charon extends Thread {

	/**
	 * The set of threads who might be zombies
	 */
	private final Set <WeakReference <Thread>> restlessDead = new HashSet <WeakReference <Thread>> ();

	/**
	 * How long to wait for a zombie to join us before passing it over
	 * for this reaper pass
	 */
	private final long threadJoinTimeout = AppiusConfig
			.getIntOrDefault (
					"org.starhope.appius.charon.threadJoinTimeout", 10);

	/**
	 * the singleton instance
	 */
	private static Charon theCharon = new Charon ();

	/**
	 * @return the singleton instance
	 */
	public static Charon instance () {
		return Charon.theCharon;
	}

	/**
	 * Add a thread to the pool to be checked to reaping periodically
	 *
	 * @param t The zombie thread to be checked for reaping
	 */
	public synchronized void addZombie (final Thread t) {
		restlessDead.add (new WeakReference <Thread> (t));
	}

	/**
	 * Write a log entry about someone
	 *
	 * @param victim the thread's name
	 * @param note what we want to talk about
	 */
	public void blog (final String victim, final String note) {
		AppiusClaudiusCaecus
				.blather ("Thread “" + victim + "” " + note);
	}

	/**
	 * “blog” about the thread state
	 *
	 * @param t the thread whose state is to be examined
	 * @param name the name to use for blogging about it.
	 */
	private void blogThreadState (final Thread t, final String name) {
		switch (t.getState ()) {
		case NEW:
			blog (name, "is a new thread?");
			break;
		case BLOCKED:
			blog (name, "is blocked");
			break;
		case RUNNABLE:
			blog (name, "is runnable");
			break;
		case TERMINATED:
			blog (name, "is terminated");
			break;
		case TIMED_WAITING:
			blog (name, "is sleeping");
			break;
		case WAITING:
			blog (name, "is waiting");
			break;
		default:
			blog (name, "is in some exciting new state,"
					+ " which didn't exist when this code was written");
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private synchronized  void excise () {
		Iterator <WeakReference <Thread>> i = restlessDead
				.iterator ();
		while (i.hasNext ()) {

			final Thread t = i.next ().get ();
			if (null == t) {
				continue;
			}
			final String name = t.getName ();
			try {


				if (t.isAlive ()) {
					blog (name, "is a living thread");
					try {
						i.remove ();
					} catch (IllegalStateException e) {
						blog (name,
								"can't remove from restlessDead "
										+ e.getMessage ());
					}
					continue;
				}

// blogThreadState (t, name);

				t.join (threadJoinTimeout);
				// blog (name, "joined the afterlife");
				try {
					i.remove ();
				} catch (IllegalStateException e) {
					blog (name, "won't leave the restlessDead "
							+ e.getMessage ());
				}
			} catch (final InterruptedException e) {
				// No op. We'll be back, soon enough.
				blog (name, "is not quite dead yet.");
			}
		}
	}

	/**
	 * This is an overriding method.
	 *
	 * @see java.lang.Thread#run()
	 */
	@Override
	public void run () {
		setName ("Charon");

		// Knock off most dead users just by doing this...
		AppiusClaudiusCaecus.getAllUsers ();

		while (true) {
			if (restlessDead.size () > 0) {
				excise ();
			}
			Thread.yield ();
			try {
				Thread
						.sleep (AppiusConfig
								.getIntOrDefault (
										"org.starhope.appius.charon.reaperSleep",
										5000));
			} catch (final InterruptedException e) {
				// No op.
			}
		}
	}
}
