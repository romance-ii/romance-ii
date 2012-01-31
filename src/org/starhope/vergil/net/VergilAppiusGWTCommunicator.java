/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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

import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.json.client.JSONObject;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class VergilAppiusGWTCommunicator {
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param jso WRITEME
	 * @param handler WRITEME
	 */
	public static void dispatchJSON (final JavaScriptObject jso,
			final HandlesJSONReply handler) {
		handler.handleJSONReply (new JSONObject (jso));
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param url WRITEME
	 * @param handler WRITEME
	 */
	public static native void makeJSONRequest (String url,
			HandlesJSONReply handler)
	/*-{
	 $wnd.jsonCallback = function(jsonObj) {
	 @org.starhope.vergil.net.AppianJSONClient::dispatchJSON(Lcom/google/gwt/core/client/JavaScriptObject;Lorg/starhope/vergil/net/HandlesJSONReply;)(jso, handler);
	 }

	 // create SCRIPT tag, and set SRC attribute equal to JSON feed URL + callback function name
	 var script = $wnd.document.createElement("script");
	 script.setAttribute("src", url);
	 script.setAttribute("type", "text/javascript");

	 $wnd.document.getElementsByTagName("head")[0].appendChild(script);

	 }-*/;
	
	/**
	 * WRITEME
	 */
	private AppianGWTClient client;
	
	/**
	 * session apple, used to encrypt communications
	 */
	public String sessionApple;
	
	/**
	 * WRITEME
	 */
	public String sessionID;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param appianJSONClient WRITEME
	 */
	public VergilAppiusGWTCommunicator (
			final AppianGWTClient appianJSONClient) {
		setClient (appianJSONClient);
	}
	
	/**
	 * @return the client
	 */
	public AppianGWTClient getClient () {
		return client;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param jso WRITEME
	 */
	public void sendJSON (final JSONObject jso) {
		// TODO
	}
	
	/**
	 * @param newClient the client to set
	 */
	public void setClient (final AppianGWTClient newClient) {
		client = newClient;
	}
}
