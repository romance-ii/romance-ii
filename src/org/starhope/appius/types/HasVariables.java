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

package org.starhope.appius.types;

import java.util.Map;
import java.util.Map.Entry;

import org.starhope.appius.via.Setter;

/**
 * WRITEME: The documentation for this type (HasVariables) is
 * incomplete. (brpocock@star-hope.org, Dec 1, 2009)
 * 
 * @author brpocock@star-hope.org
 */
public interface HasVariables {
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 1,
	 * 2009)
	 * 
	 * @param key WRITEME
	 */
	public void deleteVariable (final String key);
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 1,
	 * 2009)
	 * 
	 * @param key WRITEME
	 * @return WRITEME
	 */
	public String getVariable (final String key);
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public Map <String, String> getVariables ();

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param map WRITEME
	 */
	@Setter (getter = "getVariables")
	public void resetVariables (Map <String, String> map);

	/**
	 * @param var A Hash type Entry object containing a key-value pair
	 *        to be used to set a variable.
	 */
	public void setVariable (final Entry <String, String> var);

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 1, 2009)
	 *
	 * @param key WRITEME
	 * @param value WRITEME
	 */
	public void setVariable (final String key, final String value);

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 1, 2009)
	 *
	 * @param map WRITEME
	 */
	public void setVariables (final Map <String, String> map);
}
