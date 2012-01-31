/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.sys.admin;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.sql.SQLPeerEnum;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Security {
	/**
	 * WRITEME
	 */
	static CapabilityRecords capabilities;
	
	/**
	 * @param grantor WRITEME
	 * @param recipient WRITEME
	 * @param cap WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 */
	public synchronized static void grantCapability (
			final AbstractUser grantor,
			final AbstractUser recipient,
			final SecurityCapability cap)
			throws PrivilegeRequiredException {
		Security.capabilities.grantCapability (grantor, recipient,
				cap);
	}
	
	/**
	 * This is a convenience method, principally for using the
	 * constants in {@link SecurityCapability} like
	 * {@link SecurityCapability#CAP_SYSOP_COMMANDS} and the like.
	 * 
	 * @param who the user being queried
	 * @param capabilityID The numeric ID of the security capability in
	 *             question
	 * @return true, if the user has the capability
	 */
	public static boolean hasCapability (final AbstractUser who,
			final Integer capabilityID) {
		return Security
				.hasCapability (who, SQLPeerEnum.get (
						SecurityCapability.class,
						capabilityID.intValue ()));
	}
	
	/**
	 * Determine whether the user possesses a particular security
	 * capability.
	 * 
	 * @param who the user being queried
	 * @param cap The security capability in question
	 * @return true, only if the user has the given capability
	 */
	public synchronized static boolean hasCapability (
			final AbstractUser who, final SecurityCapability cap) {
		if (null == Security.capabilities) {
			try {
				Security.capabilities = Nomenclator.getDataRecord (
						CapabilityRecords.class, 1);
			} catch (final NotFoundException e) {
				throw BugReporter.getReporter ("srv").fatalBug (e);
			}
		}
		return Security.capabilities.forUser (who).contains (cap)
				|| Security.capabilities
						.forUser (who)
						.contains (
								new SecurityCapability (
										SecurityCapability.CAP_UNIVERSAL
												.intValue ()));
	}
}
