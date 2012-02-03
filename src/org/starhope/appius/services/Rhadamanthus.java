/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at
 * your option) any later version.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.services;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.net.ServerThread;


/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class Rhadamanthus extends Thread implements Comparable<Thread> {

	/**
	 * WRITEME
	 */
	private ServerThread damned;

	/**
	 *
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * @param myDamned WRITEME
	 *
	 */
	public Rhadamanthus (final ServerThread myDamned) {
		super ("Rhadamanthus:" + myDamned.getName ());
		damned = myDamned;
	}

	/**
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final Thread arg0) {
		return arg0.getName ().compareTo (getName());
	}

	/** WRITEME
	 * @see java.lang.Thread#run()
	 */
	@Override
	public void run () {
		damned.doRealClose ();
		AppiusClaudiusCaecus.getCharon ().addZombie (damned);
		damned = null;
		AppiusClaudiusCaecus.getCharon ().addZombie (this);
	}

}
