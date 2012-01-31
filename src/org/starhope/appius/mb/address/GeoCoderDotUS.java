/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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
package org.starhope.appius.mb.address;

import org.starhope.appius.mb.UserAddress;

/**
 * This class is used to validate addresses and provide alternate
 * suggestions for addresses which are suspected to be invalid. It's
 * used to reduce user error in inputs.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class GeoCoderDotUS implements UserAddressValidator {
	/**
	 * @see org.starhope.appius.mb.address.UserAddressValidator#getAddressSuggestions(org.starhope.appius.mb.UserAddress)
	 */
	@Override
	public UserAddress [] getAddressSuggestions (final UserAddress ua) {
		// TODO Auto-generated method stub (brpocock@star-hope.org,
		// Aug 24, 2009)
		return new UserAddress [] {};
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.mb.address.UserAddressValidator#validateUserAddress(org.starhope.appius.mb.UserAddress)
	 */
	@Override
	public boolean validateUserAddress (final UserAddress ua) {
		
		// TODO Auto-generated method stub (brpocock@star-hope.org,
		// Aug 24, 2009)
		return false;
	}
	
}
