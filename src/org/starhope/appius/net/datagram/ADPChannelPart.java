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

import java.security.InvalidParameterException;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Channel;
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
public class ADPChannelPart extends ADPJSON {
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param whoLeft WRITEME  ewinkelman 
	 */
	public ADPChannelPart (final ChannelListener whoLeft) {
		super ("channelPart", whoLeft);
		setWho ();
	}
	
	/**
	 * Constructor that builds the datagram based off of the JSON
	 * 
	 * @param j WRITEME  ewinkelman 
	 */
	public ADPChannelPart (final JSONObject j,
			final ChannelListener whoLeft) {
		super (j, whoLeft);
		final String c = j.optString ("c", j.optString ("from"));
		if ( !c.equalsIgnoreCase ("channelPart")) {
			throw new InvalidParameterException (
					"Wrong JSON packet type");
		}
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * Adds channel information to the JSON packet
	 * 
	 * @see org.starhope.appius.net.datagram.AbstractDatagram#setChannel(org.starhope.appius.game.Channel)
	 */
	@Override
	public void setChannel (final Channel aChannel) {
		try {
			jso.put ("channel", aChannel.getMoniker ());
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
		super.setChannel (aChannel);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 */
	private void setWho () {
		String who = null;
		
		if (source instanceof AbstractUser) {
			who = ((AbstractUser) source).getAvatarLabel ();
		}
		try {
			jso.put ("who", who);
			jso.put ("from", "channelPart");
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug ("Exception",
					e);
		}
	}
	
}
