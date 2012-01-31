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

import org.json.JSONObject;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.game.SFX;
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
public class ADPUserSFX extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final JSONObject jsonVars = new JSONObject ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final private ADPArray <ADPSFX> sfxList;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private AbstractUser user;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param userID Room ID
	 */
	public ADPUserSFX (final ChannelListener s) {
		super ("usfx", s);
		sfxList = new ADPArray <ADPSFX> (s);
		include ("sfx", sfxList);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param sfx WRITEME 
	 */
	public void addSFX (final SFX sfx) {
		sfxList.put (sfx.getDatagram (source));
	}
	
	/**
	 * Method used to indicate that a given special effect is being
	 * deleted Does NOT remove it from the list of effects
	 * 
	 * @param sfx WRITEME 
	 */
	public void deleteSFX (final SFX sfx) {
		final ADPSFX adpsfx = sfx.getDatagram (source);
		adpsfx.setSfxInfo (null);
		sfxList.put (adpsfx);
	}
	
	/**
	 * @return the user
	 */
	public AbstractUser getUser () {
		return user;
	}
	
	/**
	 * @param user the user to set
	 */
	public void setUser (final AbstractUser user) {
		this.user = user;
		setJSON ("who", user.getAvatarLabel ());
	}
}
