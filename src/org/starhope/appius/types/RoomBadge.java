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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.sql.SQLPeerEnum;

/**
 * 
 * TODO: The documentation for this type (RoomBadge) is incomplete.
 * (brpocock@star-hope.org, Nov 19, 2009)
 * 
 * @author brpocock@star-hope.org
 * 
 */
public class RoomBadge extends SQLPeerEnum {

	/**
	 * Java serialization unique ID
	 */
	private static final long	serialVersionUID	= -7582592792547852890L;

	/**
	 * WRITEME
	 */
	public RoomBadge () {
		super (RoomBadge.class);
		// TODO Auto-generated constructor stub (brpocock@star-hope.org, Dec 11, 2009)
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerDatum#flush()
	 */
	@Override
	public void flush () {
		// TODO Auto-generated method stub (brpocock@star-hope.org, Nov 19, 2009)

	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerEnum#getStatement(java.sql.Connection)
	 */
	@Override
	protected PreparedStatement getStatement (
			final Connection connection) {
		// TODO Auto-generated method stub (brpocock@star-hope.org, Nov 19, 2009)
		return null;
	}

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerDatum#set(java.sql.ResultSet)
	 */
	@Override
	protected void set (final ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub (brpocock@star-hope.org, Nov 19, 2009)

	}

}
