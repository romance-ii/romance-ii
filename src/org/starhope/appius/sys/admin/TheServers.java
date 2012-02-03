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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.sys.admin;

import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecordSet;

/**
 * This is the (global) set of all zone servers across the game's
 * multiverse.
 * 
 * @author brpocock@star-hope.org
 */
public class TheServers extends
		SimpleDataRecordSet <ZoneServerRecord, TheServers> {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 6096921012328355668L;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param loader the record loader
	 */
	public TheServers (
			final RecordLoader <SimpleDataRecordSet <ZoneServerRecord, TheServers>> loader) {
		super (loader);
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () {
		return 0;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () {
		return "The Servers";
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}




}
