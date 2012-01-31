/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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
 * License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.net.datagram;

import org.json.JSONObject;
import org.starhope.appius.game.ChannelListener;

/**
 * WRITEME: The documentation for this type (AppiusStringDatagram) is
 * incomplete. (brpocock@star-hope.org, Dec 14, 2009)
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class ADPString extends AbstractDatagram {
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Dec 14,
	 * 2009) datagram (AppiusStringDatagram)
	 */
	private final String datagram;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 */
	public ADPString (final ChannelListener source) {
		super (source);
		datagram = "";
	}
	
	/**
	 * WRITEME
	 * 
	 * @param newDatagram WRITEME
	 */
	public ADPString (final JSONObject jsonObject,
			final ChannelListener source) {
		super (source);
		datagram = jsonObject.toString ();
		disconnectAfterSending = false;
	}
	
	/**
	 * Basic packet constructor
	 * 
	 * @param string string contents of the datagram
	 */
	public ADPString (final String string) {
		super (null);
		datagram = string;
	}
	
	/**
	 * WRITEME
	 * 
	 * @param newDatagram WRITEME
	 * @param whetherToDisconnect WRITEME
	 * @param source the channel listener source
	 */
	public ADPString (final String newDatagram,
			final boolean whetherToDisconnect,
			final ChannelListener source) {
		super (source);
		datagram = newDatagram;
		disconnectAfterSending = whetherToDisconnect;
	}
	
	/**
	 * WRITEME
	 * 
	 * @param newDatagram WRITEME
	 * @param whetherToDisconnect WRITEME
	 */
	public ADPString (final String newDatagram,
			final ChannelListener source) {
		super (source);
		datagram = newDatagram;
		disconnectAfterSending = false;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2262 $";
	}
	
	/**
	 * @return the datagram's contents as a string
	 */
	@Override
	public String toString () {
		return datagram;
	}
	
}
