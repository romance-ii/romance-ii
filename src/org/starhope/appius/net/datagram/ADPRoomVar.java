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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.net.datagram;

import java.util.Hashtable;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.ChannelListener;

/**
 * WRITEME: Document this type.
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ADPRoomVar extends ADPJSON {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (ADPRoomVar.class);
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final JSONObject jsonVars = new JSONObject ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int room;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final Hashtable <String, String> vars = new Hashtable <String, String> ();
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param roomID Room ID
	 */
	public ADPRoomVar (final ChannelListener s, final int roomID) {
		super ("rv", s);
		setRoom (roomID);
		setJSON ("var", jsonVars);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME  ewinkelman 
	 * @param value WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public void add (final String key, final String value) {
		vars.put (key, value);
		try {
			jsonVars.put (key, value);
		} catch (final JSONException e) {
			ADPRoomVar.log.error ("Exception", e);
		}
	}
	
	/**
	 * @return the room
	 */
	public int getRoom () {
		return room;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public String getValue (final String key) {
		return vars.get (key);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public boolean hasKey (final String key) {
		return vars.containsKey (key);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME  ewinkelman 
	 */
	public void remove (final String key) {
		vars.remove (key);
		jsonVars.remove (key);
	}
	
	/**
	 * @param room the room to set
	 */
	public void setRoom (final int room) {
		this.room = room;
		setJSON ("r", room);
	}
}
