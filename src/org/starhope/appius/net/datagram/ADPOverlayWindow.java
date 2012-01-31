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

/**
 * ADP Overlay Windows represents a request to the client to show a
 * specific overlay
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ADPOverlayWindow extends ADPJSON {
	
	private String channelMoniker;
	private String moniker;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param s WRITEME  brpocock 
	 * @param moniker WRITEME  brpocock 
	 */
	public ADPOverlayWindow (final ChannelListener s,
			final String moniker) {
		super ("overlayWindow", s);
		setMoniker (moniker);
	}
	
	/**
	 * Gets the command channel the overlay is going to use
	 */
	public String getChannelMoniker () {
		return channelMoniker;
	}
	
	/**
	 * Gets the overlay moniker
	 * 
	 * @return WRITEME  brpocock 
	 */
	public String getMoniker () {
		return moniker;
	}
	
	/**
	 * Sets the command channel the overlay is going to use
	 * 
	 * @param channel WRITEME  brpocock 
	 */
	public void setChannelMoniker (final String channel) {
		channelMoniker = channel;
		setJSON ("channel", channelMoniker);
	}
	
	/**
	 * Sets the overlay window moniker
	 * 
	 * @param moniker WRITEME  brpocock 
	 */
	public void setMoniker (final String moniker) {
		this.moniker = moniker;
		setJSON ("moniker", moniker);
	}
}
