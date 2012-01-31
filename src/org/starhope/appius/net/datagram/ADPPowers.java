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
public class ADPPowers extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final ADPArray <ADPPower> equipPowers;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final ADPArray <ADPPower> tempPowers;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param s WRITEME 
	 */
	public ADPPowers (final ChannelListener s) {
		super ("powers", s);
		equipPowers = new ADPArray <ADPPower> (s);
		include ("equip", equipPowers);
		tempPowers = new ADPArray <ADPPower> (s);
		include ("temp", tempPowers);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param power WRITEME 
	 * @param itemID WRITEME 
	 */
	public void add (final ClickPower power, final PowerController pc) {
		final ADPPower p = new ADPPower (source);
		p.setID (power.getID ());
		if (power.getIcon () >= 0) {
			p.setIcon (power.getIcon ());
		}
		if (power.projectileUsesAmmo ()) {
			p.setCount (power.projectileAmmoCount (pc));
		}
		equipPowers.put (p);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param power WRITEME 
	 * @param itemID WRITEME 
	 */
	public void add (final EquipPower power) {
		final ADPPower p = new ADPPower (source);
		p.setID (power.getID ());
		if (power.getIcon () >= 0) {
			p.setIcon (power.getIcon ());
		}
		equipPowers.put (p);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param power WRITEME 
	 * @param itemID WRITEME 
	 */
	public void add (final TempPower power) {
		final ADPPower p = new ADPPower (source);
		if (power.getIcon () >= 0) {
			p.setIcon (power.getIcon ());
		}
		p.setDuration (power.getDuration ());
		p.setRemaining (power.getRemainingDuration ());
		tempPowers.put (p);
	}
}
