/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, brpocock@star-hope.org
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
package org.starhope.appius.net;

import java.net.Socket;
import java.sql.Date;

import org.json.JSONObject;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Zone;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.User;
import org.starhope.util.LibMisc;

/**
 * Process JSON interactions in bulk
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class BatchProcessor extends ServerThread {
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param newSocket WRITEME
	 */
	public BatchProcessor (final Socket newSocket) {
		super (newSocket);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public JSONObject getBatchReplies () {
		final JSONObject replySet = new JSONObject ();
		final int count = 0;
		return replySet;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param user WRITEME
	 * @return WRITEME
	 */
	public String getSessionApple (final User user) {
		return sha1hexify (socket.getInetAddress ().toString () + "/"
				+ user.getUserID () + "/" + user.getPassword ());
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return session key string
	 */
	public String initSession () {
		if (null == myUser) {
			return "";
		}
		return getSessionApple (myUser);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param auth WRITEME
	 * @param userName WRITEME
	 * @param d WRITEME
	 * @return true, if the batch is authenticated
	 */
	public boolean isBatchAuth (final String auth,
			final String userName, final JSONObject d) {
		final AbstractUser user = Nomenclator
				.getUserByLogin (userName);
		if (null == user) {
			return false;
		}
		if ( ! (user instanceof GeneralUser)) {
			return false;
		}
		return auth.equals (sha1hexify ( ((User) user).getPassword ()
				+ getSessionApple ( ((User) user))
				+ sha1hexify (d.toString ())));
	}
	
	/*
	 * (non-Javadoc)
	 * @see
	 * org.starhope.appius.net.ServerThread#logIn_checkPassword(org
	 * .starhope.appius.user.User, java.lang.String,
	 * org.starhope.appius.game.Zone)
	 */
	/**
	 * @see org.starhope.appius.net.ServerThread#logIn_checkPassword(org.starhope.appius.user.User,
	 *      java.lang.String, org.starhope.appius.game.Zone)
	 */
	@Override
	protected boolean logIn_checkPassword (final User user,
			final String password, final Zone z) {
		return password.equals (getSessionApple (user));
	}
	
	/**
	 * This returns a plethora of debugging-useful information about
	 * this particular server thread.
	 * 
	 * @see java.lang.Thread#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder res = new StringBuilder (
				super.toString ());
		res.append ("\nAppius Claudius Caecus: BatchProcessor");
		if (null != myUser) {
			res.append ("\n\tUser:\t");
			res.append (myUser.getUserName ());
			res.append (" #");
			res.append (myUser.getUserID ());
		} else {
			res.append ("\n\tNot logged in");
		}
		if (null != myUser.getZone ()) {
			res.append ("\n\tZone:\t");
			res.append (myUser.getZone ().getName ());
		}
		res.append ("\n\tProtocol language:\t");
		res.append (getStreamProtocolLanguage ());
		res.append ("\n\tDebug mode:\t");
		res.append (AppiusClaudiusCaecus.debug);
		res.append ("\n\tLast input:\t");
		res.append (LibMisc.formatPastDate (new Date (lastInputTime)));
		res.append ("\n\tState code:\t");
		res.append (state);
		res.append ('\n');
		return res.toString ();
	}
	
}
