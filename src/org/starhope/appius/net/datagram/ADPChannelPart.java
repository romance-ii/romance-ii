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

import java.security.InvalidParameterException;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Channel;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.user.AbstractUser;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman
 *
 */
public class ADPChannelPart extends ADPJSON {
	
	/**
	 * Constructor that builds the datagram based off of the JSON
	 * 
	 * @param j
	 */
	public ADPChannelPart (JSONObject j,
			ChannelListener source) {
		super (j, source);
		final String c = j.optString ("c", j.optString ("from"));
		if ( !c.equalsIgnoreCase ("channelPart"))
			throw new InvalidParameterException (
					"Wrong JSON packet type");
	}
	
	/**
	 * WRITEME: Document this constructor ewinkelman
	 * 
	 * @param source
	 */
	public ADPChannelPart (ChannelListener source) {
		super ("channelPart", source);
		setWho ();
	}
	
	/**
	 * Adds channel information to the JSON packet
	 * 
	 * @see org.starhope.appius.net.datagram.AbstractDatagram#setChannel(org.starhope.appius.game.Channel)
	 */
	@Override
	public void setChannel (Channel channel) {
		try {
			jso.put ("channel", channel.getMoniker ());
		} catch (JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
		super.setChannel (channel);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 */
	private void setWho () {
		String who = null;
		
		if (source instanceof AbstractUser) {
			who = ( ((AbstractUser) source).getAvatarLabel ());
		}
		try {
			jso.put ("who", who);
			jso.put ("from", "channelPart");
		} catch (JSONException e) {
			AppiusClaudiusCaecus.reportBug (e);
		}
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2212 $";
	}
	
}
