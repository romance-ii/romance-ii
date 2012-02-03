/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.util.types;

import java.lang.reflect.Method;
import java.util.Map.Entry;
import java.util.Queue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;

import org.json.JSONObject;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.user.AbstractUser;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 */
public class CommandExecutorThread extends Thread implements
Comparable <Thread> {

	private static final ConcurrentHashMap <String, Queue <Long>> profiles = new ConcurrentHashMap <String, Queue <Long>> ();

	public static StringBuilder dumpTimes () {
		StringBuilder times = new StringBuilder ();
		for ( Entry <String, Queue<Long>> cmd : CommandExecutorThread.profiles.entrySet ()) {
			times.append (cmd.getKey ());
			Queue <Long> entries = cmd.getValue ();
			long sum = 0; long least = Long.MAX_VALUE; long greatest = 0;
			for (Long val : entries){
				long i = val.longValue ();
				if (i > greatest) { greatest = i; }
				if (i < least) {
					least=i;
				}
				sum += i;
			}
			times.append ("\tmin:");
			times.append (least);
			times.append ("\tmax:");
			times.append(greatest);
			times.append ("\t#:");
			times.append(entries.size ());
			times.append("\tmean:");
			times.append (sum/entries.size ());
			times.append("\n");
		}
		return times;
	}
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final String cmd;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final Method commandProcessor;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final CanProcessCommands commandThread;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final JSONObject jso;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private boolean keepRunning;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final AbstractUser user;
	
	/**
	 * WRITEME
	 */
	private final String channel;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param _cmd WRITEME
	 * @param _jso WRITEME
	 * @param _commandThread WRITEME
	 * @param _user WRITEME
	 * @param _channel WRITEME
	 * @param _commandProcessor WRITEME
	 */
	public CommandExecutorThread (final String _cmd,
			final JSONObject _jso,
			final CanProcessCommands _commandThread,
			final AbstractUser _user, final String _channel,
			final Method _commandProcessor) {
		cmd = _cmd;
		jso = _jso;
		commandThread = _commandThread;
		commandProcessor = _commandProcessor;
		user = _user;
		channel = _channel;
		setName (commandThread.getName () + "//" + cmd);
	}

	/**
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final Thread arg0) {
		return getName ().compareTo (arg0.getName ());
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public void quit () {
		keepRunning = false;
		// final CommandExecutorThread self = this;
		// timeout.schedule (
		// new TimerTask () {
		// @SuppressWarnings ("deprecation")
		// @Override
		// public void run () {
		// self.stop (new Error (
		// "timeout in CommandExecutorThread"));
		// }
		// },
		// System.currentTimeMillis ()
		// + AppiusConfig.getIntOrDefault (
		// "org.starhope.appius.commandExitTimeout",
		// 3000));
	}

	/**
	 * @see Thread#run()
	 */
	@Override
	public void run () {
		long startTime = System.currentTimeMillis ();
		LibMisc.executeCommand (cmd, jso, commandThread, user, channel,
				commandProcessor);
		long endTime = System.currentTimeMillis ();
		Queue<Long> times = null;
		synchronized (CommandExecutorThread.profiles) {
			times=	CommandExecutorThread.profiles.get (cmd);
		if (null == times) { times = new ConcurrentLinkedQueue <Long> ();
		CommandExecutorThread.profiles.put(cmd,times);
		}
		}
		times.add (Long.valueOf(endTime-startTime));
		AppiusClaudiusCaecus.getCharon ().addZombie (this);
	}
	
	/**
	 * @return false, when the thread should bail out
	 */
	public boolean shouldKeepRunning () {
		return keepRunning;
	}
}

