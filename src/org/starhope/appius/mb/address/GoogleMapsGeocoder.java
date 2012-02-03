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
package org.starhope.appius.mb.address;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.UserAddress;
import org.starhope.appius.util.AppiusConfig;

import com.google.gwt.http.client.URL;

/**
 * WRITEME: The documentation for this type (GoogleMapsGeocoder) is
 * incomplete. (brpocock@star-hope.org, Jul 20, 2009)
 * 
 * @author brpocock@star-hope.org
 */
public class GoogleMapsGeocoder implements UserAddressValidator {
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.mb.address.UserAddressValidator#getAddressSuggestions(org.starhope.appius.mb.UserAddress)
	 */
	@Override
	public UserAddress [] getAddressSuggestions (final UserAddress ua) {
		// TODO Auto-generated method stub (brpocock@star-hope.org, Aug 24, 2009)
		return new UserAddress [] {};
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.mb.address.UserAddressValidator#validateUserAddress(org.starhope.appius.mb.UserAddress)
	 */
	@Override
	public boolean validateUserAddress (final UserAddress ua) {

		// final com.google.gwt.maps.client.geocode.GeoAddressAccuracy
		// geoAddressAccuracy;
		final StringBuilder request = new StringBuilder (
		"http://maps.google.com/maps/geo?output=json&oe=utf8&sensor=false&q=");
		request.append (URL.encodeComponent (ua.toString ()));
		request.append ("&key=");
		try {
			request.append (URL.encodeComponent (AppiusConfig
					.getConfig ("com.google.apiKey")));
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus.reportBug (e);
			// XXX
		}
		request.append ("&gl=");
		request.append (URL.encodeComponent (ua.getCountry ()));
		/*
		 * FIXME final HttpClient client = new HttpClient (new URL
		 * (request .toString ()), AppiusConfig.getConfigOrDefault (
		 * "com.sun.www.http.proxyHost", ""), Integer .parseInt
		 * (AppiusConfig.getConfigOrDefault (
		 * "com.sun.www.http.proxy.port", "-1")));
		 */
		return true; // by default.
	}
}
