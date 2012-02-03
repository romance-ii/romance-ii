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
 *
 * This interface must be implemented by any class that supplies assets
 * to the user. For Persephone, we will be supplying (almost always) SWF
 * files, but for other clients we need to extend the option to
 * negotiate content types based upon screen resolution and supported
 * formats. For example, Android devices might be supplied fixed-
 * resolution PNG graphics that we render in advance.
 *
 * @author brpocock@star-hope.org
 *
 */
public interface HasAssets {
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @param token WRITEME
	 * @param accepts WRITEME
	 * @return WRITEME
	 */
	public String getAssetURL (String token, AssetPreferenceList accepts);
}
