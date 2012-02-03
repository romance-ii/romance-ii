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

package org.starhope.appius.types;

/**
 * Enumeration of potential types of filters that might exist in the
 * world.
 * 
 * @author brpocock@star-hope.org
 */
public enum FilterType {
	/**
	 * A filter suitable for filtering chat between adults
	 */
	ADULT_CHAT, /**
	 * A filter suitable for filtering chat between children
	 */
	KID_CHAT, /**
	 * A filter suitable for filtering user names
	 */
	USER_LOGIN

}
