/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.net.datagram;

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.user.AbstractUser;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ADPUserAction extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String action;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Coord2D destination;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String facing;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Coord2D location;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private double rate;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private long start;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private AbstractUser user;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param s WRITEME 
	 */
	public ADPUserAction (final ChannelListener s) {
		super ("userAction", s);
	}
	
	/**
	 * @return the action
	 */
	public String getAction () {
		return action;
	}
	
	/**
	 * @return the destination
	 */
	public Coord2D getDestination () {
		return destination;
	}
	
	/**
	 * @return the facing
	 */
	public String getFacing () {
		return facing;
	}
	
	/**
	 * @return the location
	 */
	public Coord2D getLocation () {
		return location;
	}
	
	/**
	 * @return the rate
	 */
	public double getRate () {
		return rate;
	}
	
	/**
	 * @return the start
	 */
	public long getStart () {
		return start;
	}
	
	/**
	 * @return the user
	 */
	public AbstractUser getUser () {
		return user;
	}
	
	/**
	 * @param action the action to set
	 */
	public void setAction (final String action) {
		this.action = action;
		setJSON ("action", action);
	}
	
	/**
	 * @param destination the destination to set
	 */
	public void setDestination (final Coord2D destination) {
		this.destination = destination;
		setJSON ("tX", (int) destination.getX ());
		setJSON ("tY", (int) destination.getY ());
	}
	
	/**
	 * @param facing the facing to set
	 */
	public void setFacing (final String facing) {
		this.facing = facing;
		setJSON ("facing", facing);
	}
	
	/**
	 * @param location the location to set
	 */
	public void setLocation (final Coord2D location) {
		this.location = location;
		setJSON ("fX", (int) location.getX ());
		setJSON ("fY", (int) location.getY ());
	}
	
	/**
	 * @param rate the rate to set
	 */
	public void setRate (final double rate) {
		this.rate = rate;
		setJSON ("rate", rate);
	}
	
	/**
	 * @param start the start to set
	 */
	public void setStart (final long start) {
		this.start = start;
		setJSON ("at", start);
	}
	
	/**
	 * @param user the user to set
	 */
	public void setUser (final AbstractUser user) {
		this.user = user;
		setJSON ("who", user.getAvatarLabel ());
	}
}
