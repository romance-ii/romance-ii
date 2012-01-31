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
package org.starhope.appius.except;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.util.CastsToJSON;

/**
 * An exception which can be thrown in the database code, that reflects
 * something that's less of a data-consistency error, and more of a game
 * logic issue.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class GameLogicException extends Exception implements
		CastsToJSON {
	
	/**
	 * WRITEME
	 */
	private static final long serialVersionUID = 1847882813339365932L;
	/**
	 * WRITEME
	 */
	private final Object myObj;
	/**
	 * WRITEME
	 */
	private final Object myOther;
	/**
	 * WRITEME
	 */
	private final String myString;
	
	/**
	 * @param string WRITEME
	 * @param obj WRITEME
	 * @param other WRITEME
	 */
	public GameLogicException (final String string, final Object obj,
			final Object other) {
		myObj = obj;
		myOther = other;
		myString = string;
	}
	
	/**
	 * @see java.lang.Throwable#getMessage()
	 */
	@Override
	public String getMessage () {
		return super.getMessage () + myString + ";obj="
				+ myObj.toString () + "; other="
				+ myOther.toString ();
	}
	
	/**
	 * @return a JSON version of the contents of this object
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject jso = new JSONObject ();
		try {
			jso.put ("s", myString);
			if (myObj instanceof CastsToJSON) {
				jso.put ("obj", ((CastsToJSON) myObj).toJSON ());
			} else {
				jso.put ("obj", myObj.toString ());
			}
			if (myOther instanceof CastsToJSON) {
				jso.put ("other", ((CastsToJSON) myOther).toJSON ());
			} else {
				jso.put ("other", myOther.toString ());
			}
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
		return jso;
	}
	
}
