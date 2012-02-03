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

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class ZoneServerRecord extends
		SimpleDataRecord <ZoneServerRecord> {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 3237801196555351020L;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String serverName;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String zoneName;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private int id;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param loader WRITEME
	 */
	public ZoneServerRecord (
			final RecordLoader <ZoneServerRecord> loader) {
		super (loader);
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		throw new NotFoundException ("No numeric ID");
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () {
		return "appius://" + getServerName () + "/" + getZoneName ();
	}

	/**
	 *
	 * @return the ID
	 */
	public int getID ()  { return id; }

	/**
	 * @return the serverName
	 */
	public String getServerName () {
		return serverName;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Revision: 2188 $";
	}

	/**
	 * @return the zoneName
	 */
	public String getZoneName () {
		return zoneName;
	}

	/**
	 * @param newID the new ID to be set
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}

	/**
	 * @param newServerName the serverName to set
	 */
	public void setServerName (final String newServerName) {
		serverName = newServerName;
		changed ();
	}

	/**
	 * @param newZoneName the zoneName to set
	 */
	public void setZoneName (final String newZoneName) {
		zoneName = newZoneName;
		changed ();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return getCacheableIdent ();
	}


}
