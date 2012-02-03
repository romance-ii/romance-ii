/**
 * <h1>
 * LocalisedThread.java (org.starhope.appius.net)
 * </h1>
 * <h2>
 * Project: Romance
 * </h2>
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
 * </p><p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at
 * your option) any later version.
 * </p><p>
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * </p><p>
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see &lt;http://www.gnu.org/licenses/&gt;.
 * </p>
 */
package org.starhope.appius.net;

/**
 * An interface for threads who provide thread-wide localisation
 * potential.
 * 
 * @author brpocock@star-hope.org
 * 
 */
public interface LocalisedThread {
	/**
	 * 
	 * @return the language and dialect code, e.g. "en_US"
	 */
	public String getLanguage ();
}
