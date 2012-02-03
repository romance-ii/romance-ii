/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
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
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author ewinkelman
 */
package org.starhope.appius.net.datagram;

import java.util.Hashtable;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.ChannelListener;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman
 *
 */
public class ADPRoomVar extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	private JSONObject jsonVars = new JSONObject ();
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	private int room;

	/**
	 * WRITEME: Document this ewinkelman
	 */
	private Hashtable <String, String> vars = new Hashtable <String, String> ();

	/**
	 * WRITEME: Document this constructor ewinkelman
	 * 
	 * @param roomID Room ID
	 */
	public ADPRoomVar (ChannelListener s, int roomID) {
		super ("rv", s);
		setRoom (roomID);
		setJSON ("var", jsonVars);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param key
	 * @param value
	 * @return
	 */
	public void add (String key, String value) {
		vars.put (key, value);
		try {
			jsonVars.put (key, value);
		} catch (JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}
	
	/**
	 * @return the room
	 */
	public int getRoom () {
		return room;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param key
	 * @return
	 */
	public String getValue (String key) {
		return vars.get (key);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param key
	 * @return
	 */
	public boolean hasKey (String key) {
		return vars.containsKey (key);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param key
	 */
	public void remove (String key) {
		vars.remove (key);
		jsonVars.remove (key);
	}
	
	/**
	 * @param room the room to set
	 */
	public void setRoom (int room) {
		this.room = room;
		setJSON ("r", room);
	}
}
