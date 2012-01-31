/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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

package org.starhope.vergil.net;

import java.io.IOException;
import java.net.UnknownHostException;

import org.starhope.appius.game.BugReporter;
import org.starhope.appius.user.UserRecord;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class AppianGWTClient implements AppianClient {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	VergilAppiusGWTCommunicator communicator = new VergilAppiusGWTCommunicator (
			this);
	
	/**
	 * whether this is busy doing something
	 */
	private boolean isBusy;
	
	/**
	 * the last time something cool happened
	 */
	private long lastInputTime;
	/**
	 * The user connected through this client; Field only ever set to
	 * null: org.starhope.vergil.net.AppianGWTClient.userRecord
	 */
	UserRecord userRecord = null;
	
	/**
	 * @see org.starhope.vergil.net.AppianClient#close()
	 */
	@Override
	public void close () {
		logOut ();
	}
	
	/**
	 * @see org.starhope.vergil.net.AppianClient#connect(java.lang.String,
	 *      int)
	 */
	@Override
	public void connect (final String serverAddress,
			final int serverPort) throws UnknownHostException,
			IOException, ServerDisconnectedException {
		// TODO Auto-generated method stub brpocock@star-hope.org
		
	}
	
	/**
	 * @return time since last input in milliseconds
	 */
	public long getIdleTime () {
		return System.currentTimeMillis () - lastInputTime;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public String getName () {
		if (null == userRecord) {
			return getClass ().getName () + "/no-user";
		}
		return getClass ().getName () + "/u:"
				+ userRecord.getLogin () + "=#"
				+ userRecord.getUserID ();
	}
	
	/**
	 * @return true if the client is busy
	 */
	public boolean isBusy () {
		return isBusy;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private void logOut () {
		// TODO Auto-generated method stub brpocock@star-hope.org
		
	}
	
	/**
	 * @see org.starhope.vergil.net.AppianClient#send(java.lang.String)
	 */
	@Override
	public void send (final String string) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"unimplemented AppianClient::send (brpocock@star-hope.org, Jul 23, 2010)");
		
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param ret WRITEME
	 * @throws ServerDisconnectedException WRITEME
	 */
	@Override
	public void sendResponse (
			final com.google.gwt.json.client.JSONObject ret)
			throws ServerDisconnectedException {
		communicator.sendJSON (ret);
	}
	
	/**
	 * @see org.starhope.vergil.net.AppianClient#setBusyState(boolean)
	 */
	@Override
	public void setBusyState (final boolean b) {
		isBusy = b;
	}
	
	/**
	 * @see org.starhope.util.types.CanProcessCommands#setLastInputTime(long)
	 */
	@Override
	public void setLastInputTime (final long thatTime) {
		lastInputTime = thatTime;
	}
	
	/**
	 * @see org.starhope.vergil.net.AppianClient#tick(long, long)
	 */
	@Override
	public void tick (final long currentTime, final long deltaTime) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		
	}
	
}
