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
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game;

import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import org.json.JSONObject;
import org.starhope.appius.user.AbstractUser;

/**
 * A channel located in a zone
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class RoomChannel extends Channel {
	
	/**
	 * Java serialization unique ID
	 */
	private static final long serialVersionUID = 777843822192305723L;
	
	/**
	 * WRITEME ewinkelman@resinteractive.com
	 */
	final private List <RoomListener> listeners = Collections
			.synchronizedList (new LinkedList <RoomListener> ());
	
	/**
	 * Room related to this room channel
	 */
	final private Room room;
	
	/**
	 * automatically register itself with its associated zone *
	 * 
	 * @param name Channel Name
	 * @param newZone Zone the channel belongs to
	 */
	public RoomChannel (final String name, final Zone newZone,
			final Room newRoom) {
		super (name, newZone);
		room = newRoom;
	}
	
	/**
	 * Broadcasts accept game actions to all room listeners
	 * 
	 * @param u WRITEME ewinkelman@resinteractive.com
	 * @param jso WRITEME ewinkelman@resinteractive.com
	 */
	public void broadcastAcceptGameAction (final AbstractUser u,
			final JSONObject jso) {
		for (final RoomListener listener : getAllListeners ()) {
			listener.acceptGameAction (u, jso);
		}
	}
	
	/**
	 * Broadcasts join channel to all room listeners
	 * 
	 * @param user WRITEME ewinkelman@resinteractive.com
	 */
	private void broadcastAcceptObjectJoinChannel (
			final RoomListener joiner) {
		for (final RoomListener listener : getAllListeners ()) {
			listener.acceptObjectJoinChannel (this, joiner);
		}
	}
	
	/**
	 * Broadcasts part channel to all room listeners
	 * 
	 * @param user WRITEME ewinkelman@resinteractive.com
	 */
	private void broadcastAcceptObjectPartChannel (
			final RoomListener parter) {
		for (final RoomListener listener : getAllListeners ()) {
			listener.acceptObjectPartChannel (this, parter);
		}
		// Needed because it's already left the list of listeners
		parter.acceptObjectPartChannel (this, parter);
	}
	
	/**
	 * Broadcasts part channel to all room listeners
	 * 
	 * @param user WRITEME ewinkelman@resinteractive.com
	 */
	public void broadcastAcceptOutOfBandMessage (
			final AbstractUser sender, final JSONObject body) {
		for (final RoomListener listener : getAllListeners ()) {
			listener.acceptOutOfBandMessage (sender, this, body);
		}
	}
	
	/**
	 * Broadcasts accept user actions to all room listeners
	 * 
	 * @param user WRITEME ewinkelman@resinteractive.com
	 */
	public void broadcastAcceptUserAction (final AbstractUser user) {
		for (final RoomListener listener : getAllListeners ()) {
			listener.acceptUserAction (this, user);
		}
	}
	
	/**
	 * Broadcasts user variable update to all listeners
	 * 
	 * @param user WRITEME ewinkelman@resinteractive.com
	 * @param varName WRITEME ewinkelman@resinteractive.com
	 * @param varValue WRITEME ewinkelman@resinteractive.com
	 */
	public void broadcastAcceptUserVariableUpdate (
			final AbstractUser user, final String varName,
			final String varValue) {
		for (final RoomListener listener : getAllListeners ()) {
			listener.acceptUserVariableUpdate (user, varName,
					varValue);
		}
	}
	
	/**
	 * @param o WRITEME ewinkelman@resinteractive.com
	 * @return WRITEME ewinkelman@resinteractive.com
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	public int compareTo (final RoomChannel o) {
		return o.compareString.compareTo (compareString);
	}
	
	/**
	 * Destroys this channel. Notifies anyone listening for the
	 * destruction event of the destruction of the channel and
	 * unregister itself from the zone
	 */
	@Override
	public void destroy () {
		for (final ChannelListener listener : getListeners ()) {
			part (listener);
		}
		zone.unregisterChannel (this);
	}
	
	/**
	 * Gets all listeners on this channel
	 * 
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public Set <RoomListener> getAllListeners () {
		final HashSet <RoomListener> listenerSet = new HashSet <RoomListener> ();
		listenerSet.addAll (listeners);
		return listenerSet;
	}
	
	/**
	 * Gets the moniker of the channel
	 * 
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	@Override
	public String getMoniker () {
		return moniker;
	}
	
	/**
	 * WRITEME: Document this method WRITEME
	 * ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public Room getRoom () {
		return room;
	}
	
	/**
	 * Gets the zone that this channel is attached to
	 * 
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	@Override
	public Zone getZone () {
		return zone;
	}
	
	/**
	 * Joins the channel and notifies members of the join
	 * 
	 * @param listener WRITEME ewinkelman@resinteractive.com
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public boolean join (final RoomListener listener) {
		return join (listener, false);
	}
	
	/**
	 * Joins the channel and notifies members of the join if
	 * broadcasting is not surpressed
	 * 
	 * @param listener WRITEME ewinkelman@resinteractive.com
	 * @param suppressBroadcast WRITEME ewinkelman@resinteractive.com
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public boolean join (final RoomListener listener,
			final boolean suppressBroadcast) {
		listeners.add (listener);
		final boolean result = super.join (listener);
		if (result && !suppressBroadcast) {
			broadcastAcceptObjectJoinChannel (listener);
		} else if (result) {
			listener.acceptObjectJoinChannel (this, listener);
		}
		return result;
	}
	
	/**
	 * Leaves the channel and notifies members of the parting
	 * 
	 * @param listener WRITEME ewinkelman@resinteractive.com
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public boolean part (final RoomListener listener) {
		listeners.remove (listener);
		return super.part (listener);
	}
	
	/**
	 * Joins the channel and notifies members of the join if
	 * broadcasting is not supressed
	 * 
	 * @param listener WRITEME ewinkelman@resinteractive.com
	 * @param suppressBroadcast WRITEME ewinkelman@resinteractive.com
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public boolean part (final RoomListener listener,
			final boolean suppressBroadcast) {
		listeners.remove (listener);
		final boolean result = super.part (listener);
		if (result && !suppressBroadcast) {
			broadcastAcceptObjectPartChannel (listener);
		} else if (result) {
			listener.acceptObjectPartChannel (this, listener);
		}
		return result;
	}
	
}
