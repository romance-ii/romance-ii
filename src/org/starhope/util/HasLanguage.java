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
 * @author brpocock@star-hope.org Bruce-Robert Pocock Bruce-Robert Pocock
 */
package org.starhope.util;

/**
 * Implement this interface on any object that has a definite language.
 * Note that threads should implement this language interface for the
 * purposes of supporting internationalization
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock Bruce-Robert Pocock
 */
public interface HasLanguage {
	/**
	 * Get the minor language or dialect code, often a country code
	 * (e.g. "US", "UK", "MX")
	 * 
	 * @return the minor language or dialect or country code.
	 */
	public String getDialect ();
	
	/**
	 * Get the major language code (e.g. "en", "es")
	 * 
	 * @return the major language code
	 */
	public String getLanguage ();
}
