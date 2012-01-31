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

package org.starhope.appius.via;

/**
 * This serves as the remote endpoint of a server-to-server link
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @param <T> type
 */
public interface ViaMunita <T> {
	/**
	 * @return The hostname of the Via Appia peer (Appius server) on
	 *         which the remote object is actually located
	 */
	public String getViaAppiaHostname ();
	
	/**
	 * @return The object endpoint code of the Via Appia peer (Appius
	 *         server) on which the remote object is actually located
	 */
	public String getViaAppiaRemoteEndpointID ();
	
	/**
	 * @return The port number of the Via Appia peer (Appius server) on
	 *         which the remote object is actually located
	 */
	public int getViaAppiaServerPort ();
	
	/**
	 * @return the class of the ViaAppia peer. This is a hack to obtain
	 *         the generic type equivalences stuff for the
	 *         implementers, and can probably be factored out if I get
	 *         smarter about reflection and generics.
	 */
	public Class <T> getViaPeerClass ();
}
