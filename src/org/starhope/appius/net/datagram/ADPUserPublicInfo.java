/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
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
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.net.datagram;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.net.UserAgentInfo;
import org.starhope.appius.user.AbstractUser;

/**
 * <p>
 * WRITEME: This type has been undocumented by brpocock@star-hope.org since Nov 22,
 * 2010.
 * </p>
 * <p>
 * ADPUserPublicInfo represents … WRITEME brpocock@star-hope.org
 * </p>
 * <p>
 * ADPUserPublicInfo should be used for … WRITEME brpocock@star-hope.org
 * </p>
 * <p>
 * ADPUserPublicInfo should not be used for … WRITEME brpocock@star-hope.org
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
public class ADPUserPublicInfo extends AbstractDatagram {
	
	private final AbstractUser myUser;

	/**
	 *
	 * @param theUser the user whose public information is to be returned
	 */
	public ADPUserPublicInfo (final AbstractUser theUser) {
	myUser=theUser;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2216 $";
	}
	
	public AbstractUser getUser () {
		return myUser;
	}
	
	/**
	 * @see org.starhope.appius.net.datagram.AbstractDatagram#toString()
	 */
	@Override
	public String toString () {
		return myUser.getPublicInfo ().toString ();
	}

	/**
	 * @see org.starhope.appius.net.datagram.AbstractDatagram#toString(double,
	 *      org.starhope.appius.net.UserAgentInfo)
	 */
	@Override
	public String toString (final double protocolLanguage,
			final UserAgentInfo userAgent) {
		JSONObject jso = new JSONObject ();
		try {
			if (Double.POSITIVE_INFINITY == protocolLanguage
					&& userAgent.getInfinityModeMaxLevel () >= 2) {
				jso.put ("f", "u");
				jso.put ("0", myUser.getPublicInfo ());
			} else {
				jso.put ("from", "avatars");
				jso.put ("status", true);
				jso.put ("0", myUser.getPublicInfo ());
			}
		} catch (JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
		return jso.toString ();
	}

}
