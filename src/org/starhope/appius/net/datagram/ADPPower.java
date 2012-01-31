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
public class ADPPower extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int count;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private long duration;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int icon;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int ID;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private double percent;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private long remaining;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param s WRITEME 
	 */
	public ADPPower (final ChannelListener s) {
		super ("power", s);
	}
	
	/**
	 * @return the count
	 */
	public int getCount () {
		return count;
	}
	
	/**
	 * @return the duration
	 */
	public long getDuration () {
		return duration;
	}
	
	/**
	 * @return the icon
	 */
	public int getIcon () {
		return icon;
	}
	
	/**
	 * @return the iD
	 */
	public int getID () {
		return ID;
	}
	
	/**
	 * @return the percent
	 */
	public double getPercent () {
		return percent;
	}
	
	/**
	 * @return the remaining
	 */
	public long getRemaining () {
		return remaining;
	}
	
	/**
	 * @param count the count to set
	 */
	public void setCount (final int count) {
		this.count = count;
		setJSON ("count", count);
	}
	
	/**
	 * @param l the duration to set
	 */
	public void setDuration (final long l) {
		duration = l;
		setJSON ("duration", l);
	}
	
	/**
	 * @param icon the icon to set
	 */
	public void setIcon (final int icon) {
		this.icon = icon;
		setJSON ("icon", icon);
	}
	
	/**
	 * @param id the iD to set
	 */
	public void setID (final int id) {
		ID = id;
		setJSON ("ID", id);
	}
	
	/**
	 * @param percent the percent to set
	 */
	public void setPercent (final double percent) {
		this.percent = percent;
		setJSON ("percent", percent);
	}
	
	/**
	 * @param l the remaining to set
	 */
	public void setRemaining (final long l) {
		remaining = l;
		setJSON ("remaining", l);
	}
}
