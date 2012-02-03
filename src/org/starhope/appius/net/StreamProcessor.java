/**
 * <p>
 * Copyright © 2010, brpocock@star-hope.org
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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.net;

import java.net.Socket;

/**
 *
 * WRITEME: The documentation for this type (StreamProcessor) is incomplete. (brpocock@star-hope.org, Mar 9, 2010)
 *
 * @author brpocock@star-hope.org
 *
 */
public class StreamProcessor extends ServerThread {
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param maxSize WRITEME
	 */
	protected StreamProcessor (final int maxSize) {
		super (maxSize);
	}

	/**
     * WRITEME: Document this constructor brpocock@star-hope.org
     *
     * @see ServerThread#ServerThread(Socket)
     * @param newSocket WRITEME
     */
    public StreamProcessor (final Socket newSocket) {
        super (newSocket);
    }

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}

}
