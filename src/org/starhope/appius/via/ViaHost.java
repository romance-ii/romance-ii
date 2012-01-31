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

package org.starhope.appius.via;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.net.UnknownHostException;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class ViaHost implements Comparable <ViaHost> {
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) hostname (ViaHost)
	 */
	private final String hostname;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) in (ViaHost)
	 */
	private final InputStream in;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) out (ViaHost)
	 */
	private final OutputStream out;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) peerChannel (ViaHost)
	 */
	private final Socket peerChannel;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) port (ViaHost)
	 */
	private final int port;
	
	/**
	 * @param host WRITEME
	 * @param portNumber WRITEME
	 * @throws UnknownHostException WRITEME
	 * @throws IOException WRITEME
	 */
	public ViaHost (final String host, final int portNumber)
			throws UnknownHostException, IOException {
		hostname = host;
		port = portNumber;
		peerChannel = new Socket (getHostname (), getPort ());
		out = getPeerChannel ().getOutputStream ();
		in = getPeerChannel ().getInputStream ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final ViaHost arg0) {
		return toString ().compareTo (arg0.toString ());
	}
	
	/**
	 * @return the hostname
	 */
	public String getHostname () {
		return hostname;
	}
	
	/**
	 * @return the in
	 */
	public InputStream getInput () {
		return in;
	}
	
	/**
	 * @return the out
	 */
	public OutputStream getOutput () {
		return out;
	}
	
	/**
	 * @return the peerChannel
	 */
	public Socket getPeerChannel () {
		return peerChannel;
	}
	
	/**
	 * @return the port
	 */
	public int getPort () {
		return port;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return "via-appia://" + hostname + ":" + port + "#"
				+ peerChannel.toString ();
	}
}
