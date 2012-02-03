/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
 * @author brpocock@star-hope.org
 */

package org.starhope.vergil.logic;

import java.net.URL;

/**
 * @author brpocock@star-hope.org
 */
public interface GameImplementor extends VergilEventHandler {

	/**
	 * <p>
	 * Examples:
	 * </p>
	 * <ul>
	 * <li>Copyright © 2008-2010, Res Interactive, LLC</li>
	 * <li>Copyright © 2009-2010, Bruce-Robert Pocock</li>
	 * </ul>
	 * <p>
	 * Do <em>not</em> include the game's title, version/release
	 * information, or license terms (e.g. “All Rights Reserved”) in
	 * this string.
	 * </p>
	 * 
	 * @return A string indicating the game's copyright.
	 */
	public String getGameCopyright ();

	/**
	 * <p>
	 * Examples:
	 * </p>
	 * <ul>
	 * <li>All Rights Reserved</li>
	 * <li>Some Rights Reserved (Creative Commons Attribution-ShareAlike
	 * 3.0)</li>
	 * <li>GNU Affero General Public License (V3 or later)</li>
	 * </ul>
	 * 
	 * @return the game's brief licensing terms
	 */
	public String getGameLicenseBrief ();

	/**
	 * <p>
	 * Examples:
	 * </p>
	 * <ul>
	 * <li>All Rights Reserved. Reproduction in any form or any medium
	 * without express permission is prohibited and punishable by law.</li>
	 * <li>
	 * <p>
	 * This program is free software; you can redistribute it and/or
	 * modify it under the terms of the GNU Affero General Public
	 * License as published by the Free Software Foundation, either
	 * version 3 of the License, or (at your option) any later version.
	 * </p>
	 * <p>
	 * This program is distributed in the hope that it will be useful,
	 * but WITHOUT ANY WARRANTY; without even the implied warranty of
	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
	 * General Public License for more details.
	 * </p>
	 * <p>
	 * You should have received a copy of the GNU Affero General Public
	 * License along with this program. If not, see <a
	 * href="http://www.gnu.org/licenses/"
	 * >http://www.gnu.org/licenses/</a>.
	 * </p>
	 * </li>
	 * <li>
	 * <p>
	 * You are free:
	 * <ul>
	 * <li>to Share — to copy, distribute and transmit the work</li>
	 * <li>to Remix — to adapt the work</li>
	 * </ul>
	 * </p>
	 * 
	 <p>
	 * Under the following conditions:
	 * <ul>
	 * <li><strong> Attribution </strong> — You must attribute the work
	 * in the manner specified by the author or licensor (but not in any
	 * way that suggests that they endorse you or your use of the work).
	 * </li>
	 * <li><strong>Share Alike </strong>— If you alter, transform, or
	 * build upon this work, you may distribute the resulting work only
	 * under the same, similar or a compatible license.</li>
	 * </ul>
	 * </p>
	 * </li>
	 * </ul>
	 * 
	 * @return the game's longer licensing terms
	 */
	public String getGameLicenseLong ();

	/**
	 * <p>
	 * Get a link to the full text of the license agreement.
	 * </p>
	 * <p>
	 * Some useful ones (for my own use):
	 * </p>
	 * <ul>
	 * <li>http://creativecommons.org/licenses/by-sa/3.0/us/</li>
	 * <li>http://www.gnu.org/licenses/gpl.html</li>
	 * </ul>
	 * 
	 * @return a URL of the full license terms
	 */
	public URL getGameLicenseTextLink ();
	
	/**
	 * @return a short, C-type identifier used in constructing URL's and
	 *         things like that, that uniquely'ish identifies this game.
	 */
	public String getGameShortIdentifier ();

	/**
	 * @return the subtitle or other minor text accompanying the game's
	 *         title
	 */
	public String getGameSubtitle ();

	/**
	 * @return the game's official title
	 */
	public String getGameTitle ();

	/**
	 * @return true, if the game is running in a debugging mode or
	 *         environment
	 */
	public boolean isDebug ();

}
