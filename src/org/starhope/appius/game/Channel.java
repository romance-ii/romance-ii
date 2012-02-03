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
 * @author ewinkelman
 */
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
	 * Broadcasts the datagram to all listeners
	 *
	 * @param datagram WRITEME ewinkelman
	 */
	public void broadcast (final AbstractDatagram datagram) {
		datagram.setChannel (this);
		synchronized (listeners) {
			HashSet <ChannelListener> copy = new HashSet <ChannelListener> (
					listeners); // Get around listeners removing
								// themselves in response to a datagram
			for (final ChannelListener listener : copy) {
				listener.acceptDatagram (datagram);
			}
		}
	}

	/**
	 * WRITEME: Document this method ewinkelman
	 *
	 * @param datagram Datagram to send
	 * @param excludes Which listener(s) to exclude
	 */
	public void broadcast (final AbstractDatagram datagram,
			final ChannelListener... excludes) {
		final HashSet <ChannelListener> exs = new HashSet <ChannelListener> (
				Arrays.asList (excludes));
		datagram.setChannel (this);
		synchronized (listeners) {
			HashSet <ChannelListener> copy = new HashSet <ChannelListener> (
					listeners); // Get around listeners removing
								// themselves in response to a datagram
			for (final ChannelListener listener : copy) {
				if (exs.contains (listener)) {
					continue;
				}
				listener.acceptDatagram (datagram);
			}
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
		synchronized (listeners) {
			HashSet <ChannelListener> copy = new HashSet <ChannelListener> (
					listeners); // Get around listeners removing
								// themselves in response to a datagram
			for (final ChannelListener listener : copy) {
				final ADPChannelPart datagram = new ADPChannelPart (
						listener);
				datagram.setChannel (this);
				listener.acceptDatagram (datagram);
			}
			listeners.clear ();
		}
		zone.unregisterChannel (this);
	}

	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (obj instanceof Channel) {
			return 0 == compareTo ((Channel) obj);
		}
		return false;
	}

	/**
	 * Gets all listeners on this channel
	 *
	 * @return
	 */
	public Set <ChannelListener> getListeners () {
		return new HashSet <ChannelListener> (listeners);
	}

	/**
	 * @return the moniker of the channel
	 */
	public String getMoniker () {
		return moniker;
	}

	/**
	 * @return the zone to which this channel is attached
	 */
	public Zone getZone () {
		return zone;
	}

	/**
	 * Joins the channel and notifies members of the join
	 *
	 * @param joiner
	 * @return
	 */
	public boolean join (final ChannelListener joiner) {
		boolean result;
		result = open && listeners.add (joiner);
		if ( !result && listeners.contains (joiner)) {
			result = true;
		}

		if (result) {
			final ADPChannelJoin datagram = new ADPChannelJoin (joiner);
			broadcast (datagram);
		}

		return result;
	}

	/**
	 * Leaves the channel and notifies members of the parting
	 *
	 * @param parter
	 * @return
	 */
	public boolean part (final ChannelListener parter) {
		boolean result;
		result = listeners.remove (parter);

		if (result) {
			final ADPChannelPart datagram = new ADPChannelPart (parter);
			broadcast (datagram);
			parter.acceptDatagram (datagram);
		}

		return result;
	}

	/**
	 * Sends a message specifically to a given listener
	 *
	 * @param datagram
	 * @param target
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
