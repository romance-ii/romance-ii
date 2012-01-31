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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.net.datagram;

import java.util.Hashtable;
import java.util.Map;
import java.util.Map.Entry;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.user.AbstractUser;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ADPUserVar extends ADPJSON {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (ADPUserVar.class);
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final JSONObject jsonVars = new JSONObject ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private AbstractUser user;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final Hashtable <String, String> vars = new Hashtable <String, String> ();
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param userID Room ID
	 */
	public ADPUserVar (final ChannelListener s) {
		super ("uv", s);
		setJSON ("vars", jsonVars);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param variables WRITEME 
	 */
	public void add (final Map <String, String> variables) {
		for (final Entry <String, String> entry : variables
				.entrySet ()) {
			add (entry.getKey (), entry.getValue ());
		}
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME 
	 * @param value WRITEME 
	 * @return WRITEME 
	 */
	public void add (final String key, final String value) {
		vars.put (key, value);
		try {
			jsonVars.put (key, value);
		} catch (final JSONException e) {
			ADPUserVar.log.error ("Exception", e);
		}
	}
	
	/**
	 * @return the user
	 */
	public AbstractUser getUser () {
		return user;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME 
	 * @return WRITEME 
	 */
	public String getValue (final String key) {
		return vars.get (key);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME 
	 * @return WRITEME 
	 */
	public boolean hasKey (final String key) {
		return vars.containsKey (key);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param key WRITEME 
	 */
	public void remove (final String key) {
		vars.remove (key);
		jsonVars.remove (key);
	}
	
	/**
	 * @param user the user to set
	 */
	public void setUser (final AbstractUser user) {
		this.user = user;
		setJSON ("who", user.getAvatarLabel ());
	}
}
