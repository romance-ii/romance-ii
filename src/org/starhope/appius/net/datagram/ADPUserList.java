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

import java.util.HashMap;

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
public class ADPUserList extends ADPJSON {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (ADPUserList.class);
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String listType;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final HashMap <String, JSONObject> userList = new HashMap <String, JSONObject> ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final JSONObject users = new JSONObject ();
	
	/**
	 * User List datagram
	 * 
	 * @param s Datagram source
	 * @param list List type ($buddy, $ignore, et als.)
	 */
	public ADPUserList (final ChannelListener s, final String list) {
		super ("userList", s);
		setJSON ("list", list);
		setJSON ("listUsers", users);
		setJSON ("status", true);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param user WRITEME 
	 */
	public void add (final String user) {
		if ( !userList.containsKey (user)) {
			final JSONObject o = new JSONObject ();
			userList.put (user, o);
			try {
				users.put (user, o);
			} catch (final JSONException e) {
				ADPUserList.log.error ("Exception", e);
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
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param user WRITEME 
	 * @return WRITEME 
	 */
	public boolean getOnline (final String user) {
		final JSONObject object = userList.get (user);
		if (object != null) {
			return object.optBoolean ("online");
		}
		return false;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param user WRITEME 
	 * @return WRITEME 
	 */
	public boolean getZone (final String user) {
		final JSONObject object = userList.get (user);
		if (object != null) {
			return object.optBoolean ("zone");
		}
		return false;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param user WRITEME 
	 */
	public void remove (final String user) {
		if (userList.containsKey (user)) {
			userList.remove (user);
			try {
				users.put (user, null);
			} catch (final JSONException e) {
				ADPUserList.log.error ("Exception", e);
			}
		}
	}
	
	/**
	 * @param list the listType to set
	 */
	public void setList (final String list) {
		listType = list;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param user WRITEME 
	 * @param online WRITEME 
	 */
	public void setOnline (final String user, final boolean online) {
		final JSONObject object = userList.get (user);
		if (object != null) {
			try {
				object.put ("online", online);
			} catch (final JSONException e) {
				ADPUserList.log.error ("Exception", e);
			}
		}
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param user WRITEME 
	 * @param zone WRITEME 
	 */
	public void setZone (final String user, final String zone) {
		final JSONObject object = userList.get (user);
		if (object != null) {
			try {
				object.put ("zone", zone);
			} catch (final JSONException e) {
				ADPUserList.log.error ("Exception", e);
			}
		}
	}
	
}
