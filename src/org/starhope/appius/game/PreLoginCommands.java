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
package org.starhope.appius.game;

import java.util.Iterator;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.net.BatchProcessor;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.User;
import org.starhope.util.LibMisc;

/**
 * Commands that can be executed using JSON calls before the user has
 * sent a login packet; or when the user is in hte process of logging-in
 *
 * @author brpocock@star-hope.org
 */
public class PreLoginCommands {
	/**
	 * Handle a batch request
	 *
	 * @param jso { userName: NAME, zone: ZONE, room: ROOM, auth:
	 *            $(sha1hex(pass + apple + sha1hex(d))), userName:
	 *            LOGIN, d: { 0: { c: CMD, d: {} }, 1: ... } }
	 * @param nil0 unused
	 * @param nil1 unused
	 * @return Replies with { from: batch, r: {0: ..., 1: ..., ... } }
	 * @throws JSONException if the result JSO cannot be generated
	 */
	@SuppressWarnings ("unchecked")
	public static JSONObject do_batch (final JSONObject jso,
			final AbstractUser nil0, final Channel nil1)
		throws JSONException {
		final JSONObject result = new JSONObject ();
		final ServerThread myThread = PreLoginCommands
				.findMyself (result);
		if (null == myThread || ! (myThread instanceof BatchProcessor)) {
			return result;
		}
		final BatchProcessor myself = (BatchProcessor) myThread;
		final String authString = jso.getString ("auth");
		final String userLogin = jso.getString ("userName");
		final JSONObject dList = jso.getJSONObject ("d");
		final String channel = jso.optString ("ch");
		if ( !myself.isBatchAuth (authString, userLogin, dList)) {
			result.put ("status", false);
			result.put ("err", "auth.fail");
			return result;
		}

		myself.logIn (AppiusClaudiusCaecus.getZone (jso
				.getString ("zone")), userLogin, myself
				.getSessionApple ((User) Nomenclator
						.getUserByLogin (userLogin)));

		final Iterator <String> keys = dList.keys ();
		while (keys.hasNext ()) {
			final JSONObject command = dList.getJSONObject (keys
					.next ());
			myself.commandJSON (command.getString ("c"),
					command.getJSONObject ("d"), channel,
					Commands.class);
		}

		result.put ("r", myself.getBatchReplies ());

		return result;
	}
	
	/**
	 * Finger an user account to obtain basic public information about
	 * it
	 * 
	 * @param jso The JSON parameters passed to the finger command. The
	 *            only parameter interpreted is “id,” which must be the
	 *            user ID number whose public information is to be
	 *            returned.
	 * @param u unused
	 * @param channel unused
	 * @return no return, but replies with user information: { "from":
	 *         "finger", "status": "false", "msg": "user.notfound",
	 *         "userID": ### } or {@link User#getPublicInfo()}
	 * @throws JSONException if the result set can't be created
	 */
	public static JSONObject do_finger (final JSONObject jso,
			final AbstractUser u, final Channel channel)
		throws JSONException {
		final int userID = jso.getInt ("id");
		final AbstractUser userByID = Nomenclator.getUserByID (userID);
		if (null == userByID) {
			final JSONObject fail = new JSONObject ();
			fail.put ("from", "finger");
			fail.put ("status", "false");
			fail.put ("msg", "user.notfound");
			fail.put ("userID", userID);
			return fail;
		}
		final JSONObject ok = new JSONObject ();
		ok.put ("from", "finger");
		ok.put ("info", userByID.getPublicInfo ());
		return ok;
	}

	/**
	 * Get the apple to get into, or out of, $Eden
	 *
	 * @param jso ignored
	 * @param nil0 unused
	 * @param nil1 unused
	 * @return Replies with { from: getApple, apple: (OPAQUE-STRING) }
	 * @throws JSONException if the reply can't be encoded in JSON form
	 *             for some reason...
	 */
	public static JSONObject do_getApple (final JSONObject jso,
			final AbstractUser nil0, final Channel nil1)
		throws JSONException {
		final JSONObject apple = new JSONObject ();
		apple.put ("from", "getApple");
		final ServerThread myself = PreLoginCommands.findMyself (apple);
		if (null == myself) {
			return apple;
		}

		apple.put ("status", true);
		apple.put ("apple",
				myself.getRandomKey (Double.POSITIVE_INFINITY));
		return apple;
	}

	/**
	 * Handle a login request
	 *
	 * @param jso { userName: LOGIN, password: PASS, zone: ZONE }
	 * @param nil0 unused
	 * @param nil1 unused
	 * @return Replies with { from: login ... }
	 * @throws JSONException if the result JSO cannot be generated
	 */
	public static JSONObject do_login (final JSONObject jso,
			final AbstractUser nil0, final Channel nil1)
		throws JSONException {
		final JSONObject result = new JSONObject ();

		result.put ("from", "login");
		final ServerThread myself = PreLoginCommands
				.findMyself (result);
		if (null == myself) {
			return result;
		}

		try {
			if ( !myself.logIn (AppiusClaudiusCaecus.getZone (jso
					.getString ("zone")), jso.getString ("userName"),
					jso.getString ("password"))) {
				result.put ("status", false);
				result.put ("err", "login.fail");
				result.put ("msg", LibMisc.getText ("login.fail"));
				return result;
			}
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a JSONException in do_login", e);
			result.put ("status", false);
			result.put ("err", "json");
			result.put ("cause", "malformed login packet");
		}

		result.put ("status", true);
		return result;
	}

	/**
	 * Find the AppiusClaudiusCaecus thread in which we're being called
	 *
	 * @param result a JSON result object into which errors can be
	 *            stored
	 * @return the {@link AppiusClaudiusCaecus} thread, or null if we
	 *         were called from some other thread
	 * @throws JSONException if the error packet can't be generated
	 */
	private static ServerThread findMyself (final JSONObject result)
		throws JSONException {
		final Thread myThread = Thread.currentThread ();
		if ( ! (myThread instanceof ServerThread)) {
			result.put ("status", false);
			result.put ("err", "blind.man.missing");
			result.put ("msg", "Where is the Consul?");
			return null;
		}
		final ServerThread myself = (ServerThread) myThread;
		return myself;
	}

	/**
	 * Get the revision level of this file
	 *
	 * @return the revision level of this file in Subversion
	 */
	public static String getRev () {
		return "$Rev: 2213 $";
	}
}
