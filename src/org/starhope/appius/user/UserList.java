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
package org.starhope.appius.user;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.util.LibMisc;

/**
 *
 * Generic class that handles both buddy lists and ignore lists,
 * depending upon its mood. Unlike most of my stuff, you can actually
 * use the constructor safely, here.
 *
 * @author brpocock@star-hope.org
 *
 */
public class UserList {

	/**
	 * Generate an opaque cookie which can only be produced by the
	 * requester, and must be returned by the requestee in order to
	 * prove that a request has been made. Note that a buddy list
	 * request will (by design) be invalid after either user changes
	 * their user name.
	 *
	 * @param requester user placing the buddy request
	 * @param requestee user being requested as a buddy
	 * @return the cookie
	 */
	public static String getBuddyApprovalCookie (
			final AbstractUser requester, final AbstractUser requestee) {
		MessageDigest stomach = null;
		try {
			stomach = MessageDigest.getInstance ("SHA1");
		} catch (final NoSuchAlgorithmException e1) {
			throw AppiusClaudiusCaecus.fatalBug (e1);
		}
		stomach.reset ();
		try {
			stomach
			.update ( (String.valueOf (requester.getUserID ())
					+ "$" + requester.getAvatarLabel ()
					+ requester.getNameRequestedAt () + "->"
					+ String.valueOf (requestee.getUserID ())
					+ "$" + requestee.getAvatarLabel ())
					.getBytes ("US-ASCII"));
		} catch (final UnsupportedEncodingException e) {
			AppiusClaudiusCaecus.blather ("can't go 16 bit");
		}
		return LibMisc.hexify (stomach.digest ());
	}

}
