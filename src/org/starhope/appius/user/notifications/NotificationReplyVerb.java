/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Timothy Heys
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
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.user.notifications;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.util.CastsToJSON;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class NotificationReplyVerb implements CastsToJSON {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 3396983348273834331L;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final String labelKey;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String payload;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final String verb;
	
	/**
	 * @param verbPair string used as both the verb and label key
	 */
	public NotificationReplyVerb (final String verbPair) {
		verb = verbPair;
		labelKey = verbPair;
	}
	
	/**
	 * @param newVerb the verb
	 * @param newLabelKey the label key
	 */
	public NotificationReplyVerb (final String newVerb,
			final String newLabelKey) {
		verb = newVerb;
		labelKey = newLabelKey;
	}
	
	/**
	 * @return the labelKey
	 */
	public String getLabelKey () {
		return labelKey; /* brpocock@star-hope.org */
	}
	
	/**
	 * @return the payload
	 */
	public String getPayload () {
		return payload; /* brpocock@star-hope.org */
	}
	
	/**
	 * @return the verb
	 */
	public String getVerb () {
		return verb; /* brpocock@star-hope.org */
	}
	
	/**
	 * @param newPayload the payload to set
	 */
	public void setPayload (final String newPayload) {
		payload = newPayload;
	}
	
	/**
	 * @see org.starhope.appius.util.CastsToJSON#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject jso = new JSONObject ();
		try {
			jso.put ("v", verb);
			jso.put ("k", labelKey);
			jso.put ("p", payload);
		} catch (final JSONException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a JSONException in NotificationReplyVerb.toJSON ",
							e);
		}
		return jso;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder s = new StringBuilder ();
		s.append ("*");
		s.append (verb);
		s.append ("(");
		s.append (labelKey);
		s.append ("=>");
		s.append (payload);
		s.append (")");
		return s.toString ();
	}
	
}
