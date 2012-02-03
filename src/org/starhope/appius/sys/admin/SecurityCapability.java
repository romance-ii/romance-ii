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
 */

package org.starhope.appius.sys.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.sql.SQLPeerEnum;

/**
 * WRITEME: Document this type.
 * <p>
 * Predefined, universal, Appius-standard capabilities are specially
 * enumerated here via SecurityCapability.CAP_* constants. The actual
 * integral values of the predefined types are in the range 0x42525000
 * .. 0x425250ff, with the range of all types beginning 0x42000000 &
 * 0xff000000 being reserved for Appius core development. It's
 * recommended that implementors number their own capabilities additions
 * to this system with low integers beginning with “1”.
 * </p>
 *
 * <pre>
 * CREATE TABLE securityCapabilities (
 *    ID INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
 *    name VARCHAR(32) NOT NULL UNIQUE KEY
 * ) ENGINE=InnoDB;
 * </pre>
 *
 * @author brpocock@star-hope.org
 */
public class SecurityCapability extends SQLPeerEnum {

    /**
     * Universal / God / Root / Master privileges
     */
	public static final Integer CAP_UNIVERSAL = Integer
			.valueOf (0x425250ff);
	/**
	 * Capability of creating a new room
	 */
	public static final Integer CAP_SPAWN_ROOM = Integer
			.valueOf (0x42525001);
	/**
	 * Can alter room properties (titles or world and weather
	 * memberships)
	 */
	public static final Integer CAP_ALTER_ROOM = Integer
			.valueOf (0x42525002);
	/**
	 * Can alter global weather patterns
	 */
	public static final Integer CAP_ALTER_WEATHER = Integer
			.valueOf (0x42525003);
	/**
	 * Can spawn a new Zone
	 */
	public static final Integer CAP_SPAWN_ZONE = Integer
			.valueOf (0x42525004);
	/**
	 * Can set room variables
	 */
	public static final Integer CAP_SET_ROOM_VAR = Integer
			.valueOf (0x42525005);
	/**
	 * Can order migration to another Zone
	 */
	public static final Integer CAP_MIGRATE = Integer
			.valueOf (0x42525006);
	/**
	 * User can kick a player offline
	 */
	public static final Integer CAP_KICK_PLAYER = Integer
			.valueOf (0x42525007);
	/**
	 * User can't be kicked offline
	 */
	public static final Integer CAP_UNKICKABLE = Integer
			.valueOf (0x42525008);
	/**
	 * ability to run arbitrary JavaScript contents
	 */
	public static final Integer CAP_RUN_JAVASCRIPT = Integer
			.valueOf (0x42525009);
	/**
	 * General operator commands (including the ability to execute any
	 * command by speaking a magic word beginning with “#”)
	 */
	public static final Integer CAP_SYSOP_COMMANDS = Integer
			.valueOf (0x4252500a);
	/**
	 * Systems administration commands
	 */
	public static final Integer CAP_SYSADM_COMMANDS = Integer
			.valueOf (0x4252500b);
	/**
	 * Special commands for actors being special characters
	 */
	public static final Integer CAP_CHARACTER_COMMANDS = Integer
			.valueOf (0x4252500c);

	/**
	 * Capability to manage or alter NPC:s
	 */
	public static final Integer CAP_NPC = Integer.valueOf (0x4252500d);

    /**
     * WRITEME: Document this brpocock@star-hope.org
     */
    private static final long serialVersionUID = 4646472117944371702L;
    /**
     * users with this capability aren't censored by the system
     */
	public static final Integer CAP_UNCENSORED = Integer
			.valueOf (0x4252500d);

	/**
	 * default non-instance-specifc constructor
	 */
    public SecurityCapability () {
        super (SecurityCapability.class);
    }

	/**
	 * constructor with instance ID
	 *
	 * @param id the instance ID
	 */
    public SecurityCapability (final int id) {
        super (SecurityCapability.class, id);
    }

	/**
	 * constructor with instance ID as Integer for convenience of CAP_
	 * members
	 *
	 * @param id the instance ID
	 */
	public SecurityCapability (final Integer id) {
		super (SecurityCapability.class, id.intValue ());
	}

	/**
	 * @see org.starhope.appius.sql.SQLPeerDatum#flush()
	 */
	@Override
	public void flush () {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus.reportBug("unimplemented SQLPeerDatum::flush (brpocock@star-hope.org, Jun 4, 2010)");

	}

	/**
	 * @throws SQLException if shit happens
	 * @see org.starhope.appius.sql.SQLPeerEnum#getStatement(java.sql.Connection)
	 */
    @Override
	protected PreparedStatement getStatement (
			final Connection connection) throws SQLException {
		return connection
				.prepareStatement ("SELECT ID,name FROM securityCapabilities");
    }

	/**
	 * @see org.starhope.appius.sql.SQLPeerDatum#set(java.sql.ResultSet)
	 */
	@Override
	protected void set (final ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented SQLPeerDatum::set (brpocock@star-hope.org, Jun 4, 2010)");

	}



}
