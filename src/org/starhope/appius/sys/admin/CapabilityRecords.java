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

import java.util.Collection;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class CapabilityRecords extends
		SimpleDataRecord <CapabilityRecords> {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 4868707855847066302L;
	
	/**
	 * WRITEME
	 */
	private final ConcurrentHashMap <Integer, ConcurrentSkipListSet <SecurityCapability>> caps = new ConcurrentHashMap <Integer, ConcurrentSkipListSet <SecurityCapability>> ();
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param loader the record loader
	 */
	public CapabilityRecords (
			final RecordLoader <CapabilityRecords> loader) {
		super (loader);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param userByID WRITEME
	 * @param securityCapability WRITEME
	 */
	public void addCapability (final AbstractUser userByID,
			final SecurityCapability securityCapability) {
		forUser (userByID).add (securityCapability);
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof CapabilityRecords)) {
			return false;
		}
		final CapabilityRecords other = (CapabilityRecords) obj;
		if (caps == null) {
			if (other.caps != null) {
				return false;
			}
		} else if ( !caps.equals (other.caps)) {
			return false;
		}
		return true;
	}
	
	/**
	 * @param who WRITEME
	 * @return WRITEME
	 */
	public Collection <SecurityCapability> forUser (
			final AbstractUser who) {
		return forUser (who.getUserID ());
	}
	
	/**
	 * @param userID WRITEME
	 * @return WRITEME
	 */
	public Collection <SecurityCapability> forUser (final int userID) {
		ConcurrentSkipListSet <SecurityCapability> userCaps = caps
				.get (Integer.valueOf (userID));
		if (null == userCaps) {
			userCaps = new ConcurrentSkipListSet <SecurityCapability> ();
			caps.put (Integer.valueOf (userID), userCaps);
		}
		return userCaps;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return 1;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return "CapabilityRecords";
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2262 $";
	}
	
	/**
	 * WRITEME
	 * 
	 * @param grantor WRITEME
	 * @param recipient WRITEME
	 * @param cap WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 */
	public void grantCapability (final AbstractUser grantor,
			final AbstractUser recipient,
			final SecurityCapability cap)
			throws PrivilegeRequiredException {
		if ( !forUser (grantor).contains (cap)) {
			throw new PrivilegeRequiredException (cap);
		}
		forUser (recipient).add (cap);
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result)
				+ (caps == null ? 0 : caps.hashCode ());
		return result;
	}
	
}
