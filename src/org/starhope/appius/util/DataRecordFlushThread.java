/**
 * <p>
 * Copyright © 2010, Res Interactive, LLC.
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
package org.starhope.appius.util;

import org.starhope.appius.game.AppiusClaudiusCaecus;

/**
 * Perform asynchronous background flushes of data records that were
 * updated at some point, but haven't been written to the database
 * server yet — this process is designed to ensure that a flurry of data
 * record changes don't result in a massive surge of database writes as
 * well, as the likelihood is that the entire series of changes will be
 * written at a go.
 * 
 * @author brpocock@star-hope.org
 */
public class DataRecordFlushThread extends Thread {

	/**
	 * The last time this thread was “pinged.”
	 */
	private long lastPingTime = System.currentTimeMillis ();

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 */
	public DataRecordFlushThread () {
		super ();
		setName ("DataRecordFlush-" + getName ());
	}

	/**
	 * Keep the thread running for a while longer. The thread will exit
	 * “a while” after the last ping (configurable as
	 * org.starhope.appius.dataFlushThread.pingLatency, default 30000 ms
	 * = 30 s)
	 */
	public void ping () {
		lastPingTime = System.currentTimeMillis ();
	}

	/**
	 * @see java.lang.Thread#run()
	 */
	@Override
	public void run () {
		while (lastPingTime > System.currentTimeMillis ()
				- AppiusConfig
						.getIntOrDefault (
								"org.starhope.appius.dataFlushThread.pingLatency",
								30000)) {
			try {
				Thread
						.sleep (AppiusConfig
								.getIntOrDefault (
										"org.starhope.appius.dataFlushThread.sleepTime",
										60000));
			} catch (InterruptedException e) {
				// don't really care
			}

			if (DataRecordFlushManager.pendingRecords.size () > 0) {
				AppiusClaudiusCaecus.blather ("Background flush with "
						+ DataRecordFlushManager.pendingRecords.size ()
						+ " database record(s)");
				int left = DataRecordFlushManager
						.flush (AppiusConfig
								.getIntOrDefault (
										"org.starhope.appius.dataFlushThread.flushMax",
										300));
				if (0 < left) {
					AppiusClaudiusCaecus
							.blather ("Will need to return for another "
									+ left + " records");
					ping ();
				}
			}

			Thread.yield ();
		}
	}

}
