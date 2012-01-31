/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Res Interactive, LLC.
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
package org.starhope.vergil.net.smartFaux;

import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Map;

import org.starhope.appius.game.BugReporter;
import org.starhope.vergil.game.PubliusVergiliusMaro;
import org.starhope.vergil.game.Room;
import org.starhope.vergil.logic.EventNotHandledException;
import org.starhope.vergil.logic.GameImplementor;
import org.starhope.vergil.logic.VergilEvent;
import org.starhope.vergil.net.ServerDisconnectedException;
import org.starhope.vergil.test.SFSVariable;

import com.google.gwt.json.client.JSONObject;
import com.google.gwt.json.client.JSONParser;
import com.google.gwt.json.client.JSONString;

/**
 * A nearly drop-in replacement for the basics of porting a SmartFox
 * Server Pro client application to use Appius Claudius Caecus.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class SmartFauxClient implements GameImplementor {
	
	/**
	 * server to which we're connected
	 */
	private String connectedHost = "";
	
	/**
	 * server port to which we're connected
	 */
	private int connectedPort = -1;
	
	/**
	 * server zone to which we're connected
	 */
	private final String connectedZone = "";
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private boolean debug;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String defaultXt;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String gameCopyright;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String gameLicenseBrief;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String gameLicenseLong;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private java.net.URL gameLicenseTextLink;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String gameShortID;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String gameSubtitle;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String gameTitle;
	
	/**
	 * An ignored public boolean for compatibility purposes.
	 */
	public boolean smartConnect = true;
	
	/**
	 * Server connection
	 */
	private Socket socket = null;
	
	/**
	 * random key from server
	 */
	private final String theApple;
	
	/**
	 * Constructor
	 * 
	 * @param b Whether to enable debugging mode
	 */
	public SmartFauxClient (final boolean b) {
		setDebug (b);
		socket = null;
		connectedHost = "";
		connectedPort = -1;
		smartConnect = true;
		theApple = null;
		PubliusVergiliusMaro.setImplementation (this);
	}
	
	/**
	 * @see org.starhope.vergil.logic.VergilEventHandler#acceptEvent(org.starhope.vergil.logic.VergilEvent)
	 */
	@Override
	public void acceptEvent (final VergilEvent ev)
			throws EventNotHandledException {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param eventString WRITEME
	 * @param eventHandler WRITEME
	 */
	public void addEventListener (final String eventString,
			final SmartFauxEventListener eventHandler) {
		
		// TODO FIXME brpocock@star-hope.org
		// EventPlanner.listen (eventString, new VergilEventHandler ()
		// {
		//
		// @Override
		// public void acceptEvent (final String identifier,
		// final Object... details)
		// throws EventNotHandledException {
		// eventHandler.handleEvent (SmartFauxEvent.fromVergil (
		// identifier, details));
		// }
		// });
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param userPassword WRITEME
	 * @return WRITEME
	 */
	private String chapPassword (final String userPassword) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"unimplemented SmartFauxClient::chapPassword (brpocock@star-hope.org, Jul 23, 2010)");
		return null;
	}
	
	/**
	 * Connect to a server, trying the default Smart Fox Server port
	 * (9339) and the default Appius port (2770).
	 * 
	 * @param server The server to which to connect.
	 * @throws UnknownHostException if the server name can't be
	 *              resolved
	 */
	public void connect (final String server)
			throws UnknownHostException {
		connect (server, 9339);
		connect (server, 2770);
	}
	
	/**
	 * Connect to a server on a specific port.
	 * 
	 * @param server The server to which to connect
	 * @param port The port number on which to connect. The default for
	 *             SmartFox Server is 9339; the default for Appius is
	 *             2770.
	 * @throws UnknownHostException if the given server name can't be
	 *              resolved
	 */
	public void connect (final String server, final int port)
			throws UnknownHostException {
		for (final InetAddress address : InetAddress
				.getAllByName (server)) {
			try {
				socket = new Socket (address, port);
				break;
			} catch (final IOException e) {
				continue;
			}
		}
		connectedHost = server;
		connectedPort = port;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param jsonObject WRITEME
	 * @return WRITEME
	 */
	private JSONObject convert (final org.json.JSONObject jsonObject) {
		return (JSONObject) JSONParser.parse (jsonObject.toString ());
	}
	
	/**
	 * Disconnect from the server, if connected.
	 */
	public void disconnect () {
		if (null != socket) {
			try {
				socket.close ();
			} catch (final IOException e) {
				// don't really care, at this point. it's gone.
			}
		}
	}
	
	/**
	 * @return the connectedHost
	 */
	public String getConnectedHost () {
		return connectedHost;
	}
	
	/**
	 * @return the connectedPort
	 */
	public int getConnectedPort () {
		return connectedPort;
	}
	
	/**
	 * @return the connectedZone
	 */
	public String getConnectedZone () {
		return connectedZone;
	}
	
	/**
	 * @see org.starhope.vergil.logic.GameImplementor#getGameCopyright()
	 */
	@Override
	public String getGameCopyright () {
		return null == gameCopyright ? "(© unknown)" : gameCopyright;
	}
	
	/**
	 * @see org.starhope.vergil.logic.GameImplementor#getGameLicenseBrief()
	 */
	@Override
	public String getGameLicenseBrief () {
		return null == gameLicenseBrief ? "(unknown)"
				: gameLicenseBrief;
	}
	
	/**
	 * @see org.starhope.vergil.logic.GameImplementor#getGameLicenseLong()
	 */
	@Override
	public String getGameLicenseLong () {
		return null == gameLicenseLong ? "(unknown)"
				: gameLicenseLong;
	}
	
	/**
	 * @see org.starhope.vergil.logic.GameImplementor#getGameLicenseTextLink()
	 */
	@Override
	public java.net.URL getGameLicenseTextLink () {
		return gameLicenseTextLink;
		
	}
	
	/**
	 * @see org.starhope.vergil.logic.GameImplementor#getGameShortIdentifier()
	 */
	@Override
	public String getGameShortIdentifier () {
		return null == gameShortID ? "Unknown" : gameShortID;
		
	}
	
	/**
	 * @see org.starhope.vergil.logic.GameImplementor#getGameSubtitle()
	 */
	@Override
	public String getGameSubtitle () {
		return null == gameSubtitle ? "" : gameSubtitle;
	}
	
	/**
	 * @see org.starhope.vergil.logic.GameImplementor#getGameTitle()
	 */
	@Override
	public String getGameTitle () {
		return null == gameTitle ? "Unknown" : gameTitle;
	}
	
	/**
	 * May return null if the apple hasn't yet been retrieved
	 * 
	 * @return random key for cryptographic exchange (CHAP)
	 */
	public String getRandomKey () {
		return theApple;
	}
	
	/**
	 * fetch and store the room list.
	 */
	public void getRoomList () {
		try {
			PubliusVergiliusMaro.sendCommand ("getRoomList", null);
		} catch (final ServerDisconnectedException e) {
			// TODO Auto-generated catch block brpocock@star-hope.org
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a ServerDisconnectedException in SmartFauxClient.getRoomList ",
							e);
		}
	}
	
	/**
	 * @see org.starhope.vergil.logic.GameImplementor#isDebug()
	 */
	@Override
	public boolean isDebug () {
		return debug;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param i WRITEME
	 */
	public void joinRoom (final int i) {
		final Room r = Room.getByID (i);
		joinRoom (r.getMoniker (), null, false);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param roomMoniker WRITEME
	 * @param roomPassword ignored
	 * @param b ignored
	 */
	public void joinRoom (final String roomMoniker,
			final String roomPassword, final boolean b) {
		final JSONObject join = new JSONObject ();
		join.put ("room", new JSONString (roomMoniker));
		try {
			PubliusVergiliusMaro.sendCommand ("join", join);
		} catch (final ServerDisconnectedException e) {
			// TODO Auto-generated catch block brpocock@star-hope.org
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a ServerDisconnectedException in SmartFauxClient.joinRoom ",
							e);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param zoneName WRITEME
	 * @param userName WRITEME
	 * @param password WRITEME
	 */
	public void login (final String zoneName, final String userName,
			final String password) {
		final JSONObject loginPacket = new JSONObject ();
		loginPacket.put ("userName", new JSONString (
				PubliusVergiliusMaro.getUserLogin ()));
		loginPacket.put (
				"password",
				new JSONString (chapPassword (PubliusVergiliusMaro
						.getUserPassword ())));
		loginPacket.put ("zone", new JSONString (zoneName));
		try {
			PubliusVergiliusMaro.sendCommand ("login", loginPacket);
		} catch (final ServerDisconnectedException e) {
			// TODO Auto-generated catch block brpocock@star-hope.org
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a ServerDisconnectedException in SmartFauxClient.login ",
							e);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public void logout () {
		try {
			PubliusVergiliusMaro.sendCommand ("logout", null);
		} catch (final ServerDisconnectedException e) {
			// TODO Auto-generated catch block brpocock@star-hope.org
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a ServerDisconnectedException in SmartFauxClient.logout ",
							e);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param string something that might have once been JSON
	 */
	public void sendJson (final String string) {
		PubliusVergiliusMaro.send (string);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param string WRITEME
	 */
	public void sendPublicMessage (final String string) {
		final JSONObject speaking = new JSONObject ();
		speaking.put ("speech", new JSONString (string));
		try {
			PubliusVergiliusMaro.sendCommand ("speak", speaking);
		} catch (final ServerDisconnectedException e) {
			// TODO Auto-generated catch block brpocock@star-hope.org
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a ServerDisconnectedException in SmartFauxClient.sendPublicMessage ",
							e);
		}
		
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param xtName WRITEME
	 * @param xtCommand WRITEME
	 * @param jsonObject WRITEME
	 */
	public void sendXtMessage (final String xtName,
			final String xtCommand,
			final org.json.JSONObject jsonObject) {
		final JSONObject jso = convert (jsonObject);
		
		try {
			if ( (null != xtName) && (xtName.length () > 0)
					&& !xtName.equals (defaultXt)) {
				PubliusVergiliusMaro.sendCommand (xtName + "_$_"
						+ xtCommand, jso);
			} else {
				PubliusVergiliusMaro.sendCommand (xtCommand, jso);
			}
		} catch (final ServerDisconnectedException e) {
			// TODO Auto-generated catch block brpocock@star-hope.org
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a ServerDisconnectedException in SmartFauxClient.sendXtMessage ",
							e);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param b WRITEME
	 */
	public void setDebug (final boolean b) {
		debug = b;
	}
	
	/**
	 * Under SmartFox Server™, extensions are bundled into various
	 * prefices. Appius doesn't do that. So, set the default Xt prefix
	 * to the one that you want to map to the basic namespace. Most
	 * users will call this once at startup and then forget about it.
	 * 
	 * @param prefix The Xt code that should <em>not</em> be made into
	 *             a prefix on server calls.
	 */
	public void setDefaultXt (final String prefix) {
		defaultXt = prefix;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param vars WRITEME
	 */
	public void setUserVariables (final Map <String, SFSVariable> vars) {
		org.starhope.vergil.game.User.getLocalUser ().setVariables (
				vars);
	}
	
}
