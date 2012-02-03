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

import org.starhope.appius.game.ChannelListener;

/**
 * ADP Overlay Windows represents a request to the client to show a
 * specific overlay
 * 
 * @author ewinkelman
 */
public class ADPOverlayWindow extends ADPJSON {
	
	private String moniker;
	private String channelMoniker;
	
	/**
	 * WRITEME: Document this constructor ewinkelman
	 * 
	 * @param s
	 * @param moniker
	 */
	public ADPOverlayWindow (ChannelListener s, String moniker) {
		super ("overlayWindow", s);
		setMoniker (moniker);
	}
	
	/**
	 * Sets the overlay window moniker
	 * 
	 * @param moniker
	 */
	public void setMoniker (String moniker) {
		this.moniker = moniker;
		setJSON ("moniker", moniker);
	}
	
	/**
	 * Gets the overlay moniker
	 * 
	 * @return
	 */
	public String getMoniker () {
		return moniker;
	}
	
	/**
	 * Sets the command channel the overlay is going to use
	 * 
	 * @param channel
	 */
	public void setChannelMoniker (String channel) {
		channelMoniker = channel;
		setJSON ("channel", channelMoniker);
	}
	
	/**
	 * Gets the command channel the overlay is going to use
	 */
	public String getChannelMoniker () {
		return channelMoniker;
	}
}
