package org.starhope.appius.game;

import org.starhope.appius.net.datagram.AbstractDatagram;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com
 * @param <T>
 */
public interface ChannelListener {
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param datagram
	 */
	public void acceptDatagram (AbstractDatagram datagram);
	
}
