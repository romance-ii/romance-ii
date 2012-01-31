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

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.user.AbstractUser;

/**
 * WRITEME: Document this type.
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ADPSpeak extends ADPJSON {
	
	/**
	 * What is being said
	 */
	private String speech;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 */
	public ADPSpeak (final ChannelListener source, final String text) {
		super ("pub", source);
		if (source instanceof AbstractUser) {
			final AbstractUser user = (AbstractUser) source;
			setJSON ("id", user.getUserID ());
			setJSON ("who", user.getAvatarLabel ());
			setJSON ("r", user.getRoom ().getID ());
		}
		setSpeech (text);
	}
	
	/**
	 * Get what's being said
	 * 
	 * @return What's being said
	 */
	public String getSpeech () {
		return speech;
	}
	
	/**
	 * Set what's being said
	 * 
	 * @param speech What's being said
	 */
	public void setSpeech (final String speech) {
		this.speech = speech;
		setJSON ("t", speech);
	}
}
