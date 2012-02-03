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

import java.util.HashMap;

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
public class ADPUserList extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	private String listType;
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	private HashMap <String, JSONObject> userList = new HashMap <String, JSONObject> ();
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	private JSONObject users = new JSONObject ();

	/**
	 * User List datagram
	 * 
	 * @param s Datagram source
	 * @param list List type ($buddy, $ignore, et als.)
	 */
	public ADPUserList (ChannelListener s, String list) {
		super ("userList", s);
		setJSON ("list", list);
		setJSON ("users", users);
		setJSON ("status", true);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param user
	 */
	public void add (String user) {
		if ( !userList.containsKey (user)) {
			JSONObject o = new JSONObject ();
			userList.put (user, o);
			try {
				users.put (user, o);
			} catch (JSONException e) {
				BugReporter.getReporter ("srv").reportBug (e);
			}
		}
	}
	
	/**
	 * @return the listType
	 */
	public String getList () {
		return listType;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param user
	 * @return
	 */
	public boolean getOnline (String user) {
		JSONObject object = userList.get (user);
		if (object != null) {
			return object.optBoolean ("online");
		}
		return false;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param user
	 */
	public void remove (String user) {
		if (userList.containsKey (user)) {
			userList.remove (user);
			try {
				users.put (user, null);
			} catch (JSONException e) {
				BugReporter.getReporter ("srv").reportBug (e);
			}
		}
	}
	
	/**
	 * @param list the listType to set
	 */
	public void setList (String list) {
		this.listType = list;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param user
	 * @param online
	 */
	public void setOnline (String user, boolean online) {
		JSONObject object = userList.get (user);
		if (object != null) {
			try {
				object.put ("online", online);
			} catch (JSONException e) {
				BugReporter.getReporter ("srv").reportBug (e);
			}
		}
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param user
	 * @param zone
	 */
	public void setZone (String user, String zone) {
		JSONObject object = userList.get (user);
		if (object != null) {
			try {
				object.put ("zone", zone);
			} catch (JSONException e) {
				BugReporter.getReporter ("srv").reportBug (e);
			}
		}
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param user
	 * @return
	 */
	public boolean getZone (String user) {
		JSONObject object = userList.get (user);
		if (object != null) {
			return object.optBoolean ("zone");
		}
		return false;
	}

}
