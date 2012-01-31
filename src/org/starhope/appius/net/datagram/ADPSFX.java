/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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

import org.json.JSONObject;
import org.starhope.appius.game.ChannelListener;

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
public class ADPSFX extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String name;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private JSONObject sfxInfo;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param s WRITEME
	 */
	public ADPSFX (final ChannelListener s) {
		super ("sfx", s);
	}
	
	/**
	 * @return the name
	 */
	public String getName () {
		return name;
	}
	
	/**
	 * @return the sfxInfo
	 */
	public JSONObject getSfxInfo () {
		return sfxInfo;
	}
	
	/**
	 * @param newName the name to set
	 */
	public void setName (final String newName) {
		name = newName;
		setJSON ("name", newName);
	}
	
	/**
	 * @param newSFXInfo the sfxInfo to set
	 */
	public void setSfxInfo (final JSONObject newSFXInfo) {
		sfxInfo = newSFXInfo;
		setJSON ("sfxInfo", newSFXInfo);
	}
	
}
