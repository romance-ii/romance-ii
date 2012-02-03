/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
 * @author twheys@gmail.com
 */
package org.starhope.appius.user.events;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.sql.SQLPeerEnum;


/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class MedalType extends SQLPeerEnum {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 1163836714942876254L;

	/**
	 * create an instance with the given ID
	 *
	 * @param typeID the medal type
	 */
	public MedalType (final int typeID) {
		super (MedalType.class, typeID);
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param moniker WRITEME
	 * @throws NotFoundException if the moniker isn't defined valid
	 **/
	public MedalType (final String moniker) throws NotFoundException {
		super (MedalType.class);
		if (SQLPeerEnum.enumeration.get (this.getClass ()).size () == 0) {
			prepCache ();
		}
		if ( !SQLPeerEnum.enumeration.get (this.getClass ())
				.containsValue (moniker)) {
			throw new NotFoundException (moniker);
		}
		for (final java.util.Map.Entry <Integer, String> tuple : SQLPeerEnum.enumeration
				.get (this.getClass ()).entrySet ()) {
			if (tuple.getValue ().equals (moniker)) {
				instance = tuple.getKey ().intValue ();
				return;
			}
		}
		throw new NotFoundException (moniker); // unreachable, in
												// theory.
	}

	/**
	 * @see org.starhope.appius.sql.SQLPeerDatum#flush()
	 */
	@Override
	public void flush () {
		// TODO Auto-generated method stub brpocock@star-hope.org

	}

	/**
	 * @see org.starhope.appius.sql.SQLPeerEnum#getStatement(java.sql.Connection)
	 */
	@Override
	protected PreparedStatement getStatement (final Connection connection) {
		try {
			return connection
					.prepareStatement ("SELECT ID,name FROM medalTypes");
		} catch (SQLException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a SQLException in MedalType.getStatement ",
					e);
		}
	}

	/**
	 * @see org.starhope.appius.sql.SQLPeerDatum#set(java.sql.ResultSet)
	 */
	@Override
	protected void set (final ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub brpocock@star-hope.org

	}

}
