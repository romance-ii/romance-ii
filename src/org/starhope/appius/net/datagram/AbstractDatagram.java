/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
 * @author brpocock@star-hope.org
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
 * @author brpocock@star-hope.org
 */
public abstract class AbstractDatagram implements
 HasSubversionRevision {

	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 8901878531875918146L;

	/**
	 * The channel this datagram is being transmitted on
	 */
	protected Channel channel;

	/**
	 * The source of the datagram
	 */
	protected final ChannelListener source;

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Dec 14,
	 * 2009) disconnectAfterSending (AppiusStringDatagram)
	 */
	protected boolean disconnectAfterSending;
	
	/**
	 * Whether or not this packet is to be echoed out to clients
	 */
	protected boolean clientEcho = true;

	/**
	 * No-args constructor for derived classes
	 */
	protected AbstractDatagram () {
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
	 * Gets the channel this datagram was transmitted on
	 *
	 * @return
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
	 * @return WRITEME ewinkelman
	 */
	public ChannelListener getSource () {
		return source;
	}

	/**
	 * Sets the channel this datagram was transmitted on. DO NOT USE
	 * UNLESS YOU ARE A CHANNEL OR KNOW WHAT YOU'RE DOING
	 * 
	 * @param channel WRITEME ewinkelman
	 */
	public void setChannel (final Channel channel) {
		this.channel = channel;
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

	/**
	 * <p>
	 * Acquire this packet in a network-ready-to-send stream. The
	 * capabilities of the client to be receiving this packet must be
	 * considered, as packet formats change depending upon the protocol
	 * language and user-agent capabilities.
	 * </p>
	 * <p>
	 * In general, the protocol language is the version of Smart Fox
	 * Server Pro which we are emulating, or (if we are in native
	 * format) {@value Double#POSITIVE_INFINITY} for Infinity Mode.
	 * </p>
	 * <p>
	 * The creation of this packet <em>must</em> take into account the
	 * user-agent's capabilities and protocol language. For example,
	 * many packets in SFS mode must be emitted as XML, but in Infinity
	 * mode, have a JSON equivalent.
	 * </p>
	 * 
	 * @param protocolLanguage the version of Smart Fox Server Pro which
	 *            we are emulating, or (if we are in native format)
	 *            {@value Double#POSITIVE_INFINITY} for Infinity Mode.
	 * @param userAgent the capabilities and information about the
	 *            user-agent to receive this packet
	 * @return a string suitable for communications over the network.
	 */
	public abstract String toString (double protocolLanguage,
			UserAgentInfo userAgent);

	/**
	 * Sets if this packet is to be echoed out to clients or not
	 * 
	 * @param userEcho
	 */
	public void echoClient (boolean userEcho) {
		this.clientEcho = userEcho;
	}

	/**
	 * Gets if this packet is to be echoed out to clients
	 * 
	 * @return
	 */
	public boolean echoClient () {
		return clientEcho;
	}

}
