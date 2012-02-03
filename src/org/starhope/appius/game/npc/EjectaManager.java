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
 * along with this program. If not, see
 * &lt;http://www.gnu.org/licenses/&gt;.
 * </p>
 * <p>
 * 
 * @author brpocock@star-hope.org
 *         </p>
 *         <p>
 *         Created Jun 23, 2010
 *         </p>
 */
package org.starhope.appius.game.npc;

import java.util.LinkedList;
import java.util.List;

import org.starhope.appius.game.Room;

/**
 * @author brpocock@star-hope.org
 */
public class EjectaManager {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final List <Ejecta> ejecta = new LinkedList <Ejecta> ();

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param o WRITEME
	 */
	public static void add (final Ejecta o) {
		synchronized (EjectaManager.ejecta) {
			EjectaManager.ejecta.add (o);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param o WRITEME
	 */
	public static void remove (final Ejecta o) {
		final Room room = o.getRoom ();
		if (null != room) {
			room.part (o);
		}
		synchronized (EjectaManager.ejecta) {
			EjectaManager.ejecta.remove (o);
		}
	}
}
