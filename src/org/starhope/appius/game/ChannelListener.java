package org.starhope.appius.game;

import org.starhope.appius.net.datagram.AbstractDatagram;

/**
 * <p> Copyright © 2010, Timothy W. Heys </p>
 * <p> Copyright © 2012, Bruce-Robert Pocock </p>
* <p>     This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
        published by the Free Software Foundation, either version 3 of the
            License, or (at your option) any later version.</p> <p>  This program is distributed in the hope that it will be useful,
                but WITHOUT ANY WARRANTY; without even the implied warranty of
                    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                        GNU Affero General Public License for more details.</p><p>   You should have received a copy of the GNU Affero General Public License
                            along with this program.  If not, see <http://www.gnu.org/licenses/>. </p>
 * WRITEME: Document this type.
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @param <T>
 */
public interface ChannelListener {
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param datagram WRITEME  ewinkelman 
	 */
	public void acceptDatagram (AbstractDatagram datagram);
	
}
