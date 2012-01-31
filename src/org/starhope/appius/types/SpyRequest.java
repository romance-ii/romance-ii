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

package org.starhope.appius.types;

import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.GeneralUser;

/**
 * This contains the information required to request to spy upon someone
 * else.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class SpyRequest {
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) spy (SpyRequest)
	 */
	private GeneralUser spy;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) stopping (SpyRequest)
	 */
	private boolean stopping;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) victim (SpyRequest)
	 */
	private String victim;
	
	/**
	 * @return the spy
	 */
	public AbstractUser getSpy () {
		return spy;
	}
	
	/**
	 * @return the victim
	 */
	public String getVictim () {
		return victim;
	}
	
	/**
	 * @return the stopping
	 */
	public boolean isStopping () {
		return stopping;
	}
	
	/**
	 * @param newSpy the spy to set
	 */
	public void setSpy (final GeneralUser newSpy) {
		// default setter (brpocock@star-hope.org, Sep 3, 2009)
		spy = newSpy;
	}
	
	/**
	 * @param stopping1 the stopping to set
	 */
	public void setStopping (final boolean stopping1) {
		// default setter (brpocock@star-hope.org, Sep 3, 2009)
		stopping = stopping1;
	}
	
	/**
	 * @param newVictim the victim to set
	 */
	public void setVictim (final String newVictim) {
		// default setter (brpocock@star-hope.org, Sep 3, 2009)
		victim = newVictim;
	}
}
