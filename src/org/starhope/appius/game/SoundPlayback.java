/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
package org.starhope.appius.game;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class SoundPlayback implements Comparable <Object> {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final String urlPart;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param substring WRITEME
	 */
	public SoundPlayback (final String substring) {
		urlPart = substring;
	}

	/**
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final Object o) {
	final int myHash = hashCode ();
	final int theirHash = o.hashCode ();
		return myHash < theirHash ? -1 : myHash == theirHash ? 0 : 1;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public boolean isDone () {
		// TODO Auto-generated method stub brpocock@star-hope.org
		return false;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return urlPart;
	}

}
