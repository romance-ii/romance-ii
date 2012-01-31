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
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import org.starhope.appius.net.datagram.ADPChannelJoin;
import org.starhope.appius.net.datagram.ADPChannelPart;
import org.starhope.appius.net.datagram.AbstractDatagram;

/**
 * A channel located in a zone
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
 @Deprecated
public class Channel implements Comparable <Channel> {
	
	/**
	 * Java serialization unique ID
	 */
	private static final long serialVersionUID = 777843822192305722L;
	
	/**
	 * The string used to compare two channels for the Comparable
	 * interface
	 */
	final protected String compareString;
	
	/**
	 * List of all channel subscribers. Can't use ConcurrentSkipListSet
	 * due to limitations of Comparable interface
	 */
	final private Set <ChannelListener> listeners = Collections
			.synchronizedSet (new HashSet <ChannelListener> ());
	
	/**
	 * The name/moniker of the channel
	 */
	final protected String moniker;
	
	/**
	 * Is this channel open
	 */
	private boolean open = true;
	
	/**
	 * The zone the channel is registered to
	 */
	final protected Zone zone;
	
	/**
	 * automatically register itself with its associated zone *
	 * 
	 * @param name Channel Name
	 * @param myZone Zone the channel belongs to
	 */
	public Channel (final String name, final Zone myZone) {
		moniker = name;
		zone = myZone;
		compareString = myZone.getName () + "/" + moniker;
		myZone.registerChannel (this);
	}
	
	/**
	 * Sends a datagram to all current channel subscribers with the
	 * exception of the optional exclude list
	 * 
	 * @param datagram Datagram to send
	 * @param excludes Which listener(s) to exclude
	 */
	public void broadcast (final AbstractDatagram datagram,
			final ChannelListener... excludes) {
		final HashSet <ChannelListener> exs = new HashSet <ChannelListener> (
				Arrays.asList (excludes));
		datagram.setChannel (this);
		final Set <ChannelListener> copy = getListeners ();
		copy.removeAll (exs);
		for (final ChannelListener target : copy) {
			target.acceptDatagram (datagram);
		}
	}
	
	/**
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final Channel o) {
		return o.compareString.compareTo (compareString);
	}
	
	/**
	 * Destroys this channel. Notifies anyone listening for the
	 * destruction event of the destruction of the channel and
	 * unregister itself from the zone
	 */
	public void destroy () {
		open = false;
		final Set <ChannelListener> copy = getListeners ();
		for (final ChannelListener listener : copy) {
			final ADPChannelPart datagram = new ADPChannelPart (
					listener);
			datagram.setChannel (this);
			listener.acceptDatagram (datagram);
		}
		synchronized (listeners) {
			listeners.clear ();
		}
		zone.unregisterChannel (this);
	}
	
	/**
	 * Gets all listeners on this channel
	 * 
	 * @return WRITEME 
	 */
	public Set <ChannelListener> getListeners () {
		HashSet <ChannelListener> copy;
		synchronized (listeners) {
			// Get around listeners removing
			// themselves in response to a datagram
			copy = new HashSet <ChannelListener> (listeners);
		}
		return copy;
	}
	
	/**
	 * Gets the moniker of the channel
	 * 
	 * @return WRITEME 
	 */
	public String getMoniker () {
		return moniker;
	}
	
	/**
	 * Gets the zone that this channel is attached to
	 * 
	 * @return WRITEME 
	 */
	public Zone getZone () {
		return zone;
	}
	
	/**
	 * Joins the channel and notifies members of the join
	 * 
	 * @param joiner WRITEME 
	 * @return WRITEME 
	 */
	public boolean join (final ChannelListener joiner) {
		boolean result;
		result = open && listeners.add (joiner);
		if ( !result && listeners.contains (joiner)) {
			result = true;
		}
		
		if (result) {
			final ADPChannelJoin datagram = new ADPChannelJoin (
					joiner);
			broadcast (datagram);
		}
		
		return result;
	}
	
	/**
	 * Leaves the channel and notifies members of the parting
	 * 
	 * @param parter WRITEME 
	 * @return WRITEME 
	 */
	public boolean part (final ChannelListener parter) {
		boolean result;
		result = listeners.remove (parter);
		
		if (result) {
			final ADPChannelPart datagram = new ADPChannelPart (
					parter);
			broadcast (datagram);
			parter.acceptDatagram (datagram);
		}
		
		return result;
	}
	
	/**
	 * Sends a message specifically to a given listener
	 * 
	 * @param datagram WRITEME 
	 * @param target WRITEME 
	 */
	public void send (final AbstractDatagram datagram,
			final ChannelListener target) {
		datagram.setChannel (this);
		target.acceptDatagram (datagram);
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return compareString;
	}
}
