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

import org.starhope.appius.game.Channel;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.net.UserAgentInfo;
import org.starhope.util.HasSubversionRevision;

/**
 * WRITEME: The documentation for this type (AppiusStringDatagram) is
 * incomplete. (brpocock@star-hope.org, Dec 14, 2009)
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public abstract class AbstractDatagram implements HasSubversionRevision {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 8901878531875918146L;
	
	/**
	 * The channel this datagram is being transmitted on
	 */
	protected Channel channel;
	
	/**
	 * Whether or not this packet is to be echoed out to clients
	 */
	protected boolean clientEcho = true;
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Dec 14,
	 * 2009) disconnectAfterSending (AppiusStringDatagram)
	 */
	protected boolean disconnectAfterSending;
	
	/**
	 * The source of the datagram
	 */
	protected final ChannelListener source;
	
	/**
	 * No-args constructor for derived classes
	 */
	AbstractDatagram () {
		source = null;
	}
	
	/**
	 * Basic default constructor
	 * 
	 * @param listenerTalking The source of the datagram
	 */
	public AbstractDatagram (final ChannelListener listenerTalking) {
		source = listenerTalking;
	}
	
	/**
	 * Gets if this packet is to be echoed out to clients
	 * 
	 * @return WRITEME  ewinkelman 
	 */
	public boolean echoClient () {
		return clientEcho;
	}
	
	/**
	 * Sets if this packet is to be echoed out to clients or not
	 * 
	 * @param userEcho WRITEME  ewinkelman 
	 */
	public void echoClient (final boolean userEcho) {
		clientEcho = userEcho;
	}
	
	/**
	 * Gets the channel this datagram was transmitted on
	 * 
	 * @return WRITEME  ewinkelman 
	 */
	public Channel getChannel () {
		return channel;
	}
	
	/**
	 * @return true, if the client should be disconnected after this
	 *         datagram is sent
	 */
	public boolean getDisconnectAfterSending () {
		return disconnectAfterSending;
	}
	
	/**
	 * Gets the source of the datagram
	 * 
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public ChannelListener getSource () {
		return source;
	}
	
	/**
	 * Sets the channel this datagram was transmitted on. DO NOT USE
	 * UNLESS YOU ARE A CHANNEL OR KNOW WHAT YOU'RE DOING
	 * 
	 * @param newChannel WRITEME ewinkelman@resinteractive.com
	 */
	public void setChannel (final Channel newChannel) {
		channel = newChannel;
	}
	
	/**
	 * Set the flag which determines whether the client should be
	 * disconnected after this datagram is sent
	 * 
	 * @param b if true, disconnect after sending this datagram
	 */
	public void setDisconnectAfterSending (final boolean b) {
		disconnectAfterSending = b;
	}
	
	/**
	 * Reminder: use {@link #toString(double, UserAgentInfo)} if you
	 * intend to write bytes to a socket.
	 * 
	 * @return the datagram's contents as a string in a default fashion
	 *         (not suitable for general-purpose network use!)
	 */
	@Override
	public abstract String toString ();
	
}
