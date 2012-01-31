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
package org.starhope.appius.util;

import java.util.Date;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.http.Cookie;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.BugReporter;

import com.google.gwt.json.client.JSONValue;

/**
 * This class contains static helper functions for converting various
 * types of data to/from JSON form.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class JSONUtil {
	
	/**
	 * @param object A JSON representation of a Cookie
	 * @return the Cookie back in Java form
	 */
	public static Cookie toCookie (final JSONObject object) {
		final Cookie c = new Cookie (object.optString ("name"), null);
		c.setComment (object.optString ("comment"));
		c.setDomain (object.optString ("domain"));
		c.setMaxAge (object.optInt ("maxAge"));
		c.setPath (object.optString ("path"));
		c.setSecure (object.optBoolean ("secure"));
		c.setValue (object.optString ("value"));
		c.setVersion (object.optInt ("version"));
		return c;
	}
	
	/**
	 * This is an utility method to convert a JSON object which we have
	 * created from an SQL Date value back into an SQL Date value.
	 * 
	 * @param o The JSON Object
	 * @return the Date object representing the same date & time value
	 * @throws JSONException if the JSON data is badly-formed
	 */
	public static Date toDate (final JSONObject o)
			throws JSONException {
		return new Date (o.getInt ("unix_time"));
	}
	
	/**
	 * @param in the JSON object in JSON.Org form
	 * @return the JSON object in Googley form
	 */
	@SuppressWarnings ("unchecked")
	public static com.google.gwt.json.client.JSONObject toGoogle (
			final JSONObject in) {
		final com.google.gwt.json.client.JSONObject out = new com.google.gwt.json.client.JSONObject ();
		final Iterator <String> i = in.keys ();
		while (i.hasNext ()) {
			final String s = i.next ();
			try {
				out.put (s, (JSONValue) in.get (s));
			} catch (final JSONException e) {
				BugReporter.getReporter ("srv").reportBug (
						"Exception", e);
			}
		}
		return out;
	}
	
	/**
	 * @param c A Cookie object to be converted to JSON
	 * @return that Cookie
	 * @throws JSONException if the data can't be stored successfully
	 */
	public static JSONObject toJSON (final Cookie c)
			throws JSONException {
		final JSONObject jc = new JSONObject ();
		jc.put ("comment", c.getComment ());
		jc.put ("domain", c.getDomain ());
		jc.put ("maxAge", c.getMaxAge ());
		jc.put ("name", c.getName ());
		jc.put ("path", c.getPath ());
		jc.put ("secure", c.getSecure ());
		jc.put ("value", c.getValue ());
		jc.put ("version", c.getVersion ());
		return jc;
	}
	
	/**
	 * This is an utility method to convert a Time value
	 * (java.sql.Time) into a JSONObject. Implementation note: We just
	 * store the Unix time (seconds since the epoch of 1970-01-01
	 * 00:00:00 UCT/GMT) in a single field. The broken-down date and
	 * time values are not included.
	 * 
	 * @param when The Time to be converted
	 * @return a JSON object representing the given Time.
	 * @throws JSONException If the data cannot be represented in JSON
	 *              for some reason
	 */
	public static JSONObject toJSON (final Date when)
			throws JSONException {
		final JSONObject o = new JSONObject ();
		o.put ("unix_time", when.getTime ());
		return o;
	}
	
	/**
	 * Convert a set of strings into a JSONArray
	 * 
	 * @param data The string set to be converted
	 * @return A JSON array of strings
	 * @throws JSONException if the data cannot be represented in JSON
	 */
	public static JSONObject toJSON (final Set <String> data)
			throws JSONException {
		final JSONArray set = new JSONArray ();
		final Iterator <String> i = data.iterator ();
		while (i.hasNext ()) {
			final String s = i.next ();
			set.put (s);
		}
		return set.toJSONObject (set);
	}
	
	/**
	 * This is an utility method to convert an array of Strings into a
	 * JSONObject, as a compatibility layer for Smartfox.
	 * 
	 * @param strings An array of Strings
	 * @return A JSONObject representing the same data
	 * @throws JSONException if the data can't be represented in JSON
	 */
	public static JSONObject toJSON (final String [] strings)
			throws JSONException {
		final JSONArray set = new JSONArray ();
		set.put (strings);
		return set.toJSONObject (set);
	}
}
