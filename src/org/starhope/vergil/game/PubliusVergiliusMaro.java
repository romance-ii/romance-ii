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

package org.starhope.vergil.game;

import java.io.IOException;
import java.net.UnknownHostException;

import org.starhope.util.LibMisc;
import org.starhope.vergil.logic.EventNotPlannedException;
import org.starhope.vergil.logic.EventPlanner;
import org.starhope.vergil.logic.GameImplementor;
import org.starhope.vergil.net.AppianClient;
import org.starhope.vergil.net.AppianGWTClient;
import org.starhope.vergil.net.ServerDisconnectedException;

import com.google.gwt.json.client.JSONObject;
import com.google.gwt.json.client.JSONString;

/**
 * This is the static class that dispatches calls to the specific
 * GameImplementor for the local client implementation
 * 
 * @author brpocock@star-hope.org
 */
public class PubliusVergiliusMaro {
	/**
	 * the AppianClient for the current instance
	 */
	private static AppianClient client;
	/**
	 * The game implementation must supply these callbacks in its
	 * interface
	 */
	private static GameImplementor gameImplementor;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static String userLogin;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static String userPassword;

	/**
	 * WRITEME
	 * 
	 * @param hostName WRITEME
	 * @param portNumber WRITEME
	 */
	public static void connectClient (final String hostName,
			final int portNumber) {
		PubliusVergiliusMaro.client = new AppianGWTClient ();
		try {
			PubliusVergiliusMaro.client.connect (hostName, portNumber);
		} catch (final UnknownHostException e) {
			PubliusVergiliusMaro.reportBug (e);
		} catch (final IOException e) {
			PubliusVergiliusMaro.reportBug (e);
		} catch (final ServerDisconnectedException e) {
			PubliusVergiliusMaro.reportBug (e);
		}

	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public static String getImplementorCanonicalName () {
		return PubliusVergiliusMaro.gameImplementor.getClass ().getCanonicalName ();
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public static String getImplementorCopyright () {
		return PubliusVergiliusMaro.gameImplementor.getGameCopyright ();
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public static String getImplementorSubtitle () {
		return PubliusVergiliusMaro.gameImplementor.getGameSubtitle ();
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public static String getImplementorTitle () {
		return PubliusVergiliusMaro.gameImplementor.getGameTitle ();
	}

	/**
	 * @return the userLogin
	 */
	public static String getUserLogin () {
		return PubliusVergiliusMaro.userLogin;
	}

	/**
	 * @return the userPassword
	 */
	public static String getUserPassword () {
		return PubliusVergiliusMaro.userPassword;
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public static boolean isDebug () {
		return PubliusVergiliusMaro.gameImplementor.isDebug ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public static void promptForLogin () {
		try {
			EventPlanner.criticalEvent ("net.login.prompt");
		} catch (EventNotPlannedException e) {
			PubliusVergiliusMaro.reportBug (
					"Caught a EventNotPlannedException in PubliusVergiliusMaro.promptForLogin ",
					e);
		}
	}

	/**
	 * WRITEME
	 * 
	 * @param string WRITEME
	 */
	public static void reportBug (final String string) {
		EventPlanner.event ("bug", string);
	}
	
	/**
	 * WRITEME
	 * 
	 * @param string WRITEME
	 * @param t WRITEME
	 */
	public static void reportBug (final String string, final Throwable t) {
		final StringBuilder sb = new StringBuilder (string);
		sb.append (LibMisc.stringify (t));
		PubliusVergiliusMaro.reportBug (sb.toString ());
	}
	
	/**
	 * WRITEME
	 * 
	 * @param t WRITEME
	 */
	public static void reportBug (final Throwable t) {
		PubliusVergiliusMaro.reportBug (LibMisc.stringify (t));
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * @param string string to be sent
	 */
	public static void send (final String string) {
		PubliusVergiliusMaro.client.send (string);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param command command verb
	 * @param data any ancillary data (null is accepted)
	 * @throws ServerDisconnectedException if it did
	 */
	public static void sendCommand (final String command,
			final JSONObject data) throws ServerDisconnectedException {
		com.google.gwt.json.client.JSONObject c = new com.google.gwt.json.client.JSONObject ();
		c.put ("c", new JSONString (command));
			c.put("d", null == data ? new JSONObject () : data);
		PubliusVergiliusMaro.client.sendResponse (c);
	}

	/**
	 * WRITEME
	 *
	 * @param implementation WRITEME
	 */
	public static void setImplementation (
			final GameImplementor implementation) {
		PubliusVergiliusMaro.gameImplementor = implementation;
		EventPlanner.event ("game.start");
	}
	/**
	 * Set the user's login and password at one go.
	 *
	 * @param login login
	 * @param password password
	 */
	public void setLoginCredentials (final String login, final String password) {
		setUserLogin (login);
		setUserPassword (password);
	}

	/**
	 * @param newLogin the userLogin to set
	 */
	public void setUserLogin (final String newLogin) {
		PubliusVergiliusMaro.userLogin = newLogin;
	}

	/**
	 * @param newPassword the userPassword to set
	 */
	public void setUserPassword (final String newPassword) {
		PubliusVergiliusMaro.userPassword = newPassword;
	}

}
