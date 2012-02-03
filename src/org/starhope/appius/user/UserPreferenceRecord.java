/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * Provide storage for user preferences
 * 
 * @author brpocock@star-hope.org
 */
public class UserPreferenceRecord extends
		SimpleDataRecord <UserPreferenceRecord> {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -448227682673826827L;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private int myUserID = -1;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final Map <String, String> prefs = new ConcurrentHashMap <String, String> ();

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param u WRITEME
	 * @throws AlreadyExistsException if the user already has a
	 *             preferences file
	 */
	public UserPreferenceRecord (final AbstractUser u)
			throws AlreadyExistsException {
		super (UserPreferenceRecord.class);
		myUserID = u.getUserID ();
		try {
			Nomenclator.getDataRecord (UserPreferenceRecord.class,
					myUserID);
			throw new AlreadyExistsException (u.getAvatarLabel ());
		} catch (NotFoundException e) {
			setRecordLoader (AppiusConfig
					.getRecordLoaderForClass (UserPreferenceRecord.class));
			markAsLoaded ();
		}
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return myUserID;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return String.valueOf (myUserID);
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param jso WRITEME
	 * @param prefix WRITEME
	 * @return WRITEME
	 */
	@SuppressWarnings ("unchecked")
	private Map <String, String> jsonToMap (final JSONObject jso,
			final String prefix) {
		HashMap <String, String> keys = new HashMap <String, String> ();
		Iterator <String> i = jso.keys ();
		while (i.hasNext ()) {
			String key = i.next ();
			JSONObject sub = jso.optJSONObject (key);
			String subKey = prefix + '.' + key;
			if ("".equals (prefix)) {
				subKey = key;
			}
			if (null != sub) {
				keys.putAll (jsonToMap (sub, subKey));
				continue;
			}
			try {
				keys.put (subKey, jso.getString (key));
			} catch (JSONException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a JSONException in UserPreferenceRecord.jsonToMap ",
								e);
			}
		}
		return keys;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param jso JSON values to be saved
	 */
	public void save (final JSONObject jso){
		save (jsonToMap (jso, ""));
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param keys WRITEME
	 */
	public void save (final Map <String, String>keys  ) {
		prefs.putAll (keys);
		changed();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param key WRITEME
	 * @param value WRITEME
	 */
	public void save (final String key, final String value){
		prefs.put(key,value);
		changed();
	}

	/**
	 * @return all keys & values as a JSON object
	 */
	public JSONObject toJSON () {
		JSONObject jso = new JSONObject ();
		for (Map.Entry <String, String> entry : prefs.entrySet ()) {
			try {
				jso.put (entry.getKey (), entry.getValue ());
			} catch (JSONException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a JSONException in UserPreferenceRecord.toJSON ",
								e);
			}
		}
		return jso;
	}

}
