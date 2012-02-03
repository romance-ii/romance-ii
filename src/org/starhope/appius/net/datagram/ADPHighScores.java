/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
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
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author ewinkelman
 */
package org.starhope.appius.net.datagram;

import org.starhope.appius.game.ChannelListener;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman
 *
 */
public class ADPHighScores extends ADPJSON {
	
	/**
	 * WRITEME: Document this constructor ewinkelman
	 */
	public ADPHighScores (ChannelListener s) {
		super ("highScores", s);
	}

}
