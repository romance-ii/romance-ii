/**
 * <p>
 * Copyright © 2010, Res Interactive, LLC.
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

package org.starhope.util;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public interface HasSubversionRevision {
	/**
	 * <p>
	 * Return the Subversion revision level of this class's source code
	 * file, as supplied via the special &quot;$Rev: &quot; sequence.
	 * </p>
	 * <p>
	 * As an example,the Subversion revision string for this file is
	 * "$Rev: 2188 $"
	 * </p>
	 * 
	 * <pre>
	 * 
	 * &#064;Override
	 * public String getSubversionRevision () {
	 * 	return &quot;$Rev: &quot;;
	 * }
	 * </pre>
	 * 
	 * @return The Subversion revision level for this class's source
	 *         code file.
	 */
	public String getSubversionRevision ();
}
