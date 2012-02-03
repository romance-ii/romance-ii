/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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
 * @author ewinkelman@resinteractive.com
 */
package org.starhope.appius.net.datagram;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Channel;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.net.UserAgentInfo;

/**
 * Temporary class for datagrams containing arbitrary JSON data. These should be phased-out in favour of more precise packet objects as time permits.
 *
 * @author ewinkelman@resinteractive.com
 *
 */
public class ADPJSON extends AbstractDatagram {


	/**
	 * WRITEME: Document this field brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -5892420707701078465L;
	/**
	 * Internal JSON object
	 */
	final protected JSONObject jso;
	
	/**
	 * WRITEME: Document this constructor ewinkelman
	 * 
	 * @param j JSON
	 * @param s Source
	 */
	public ADPJSON (final JSONObject j, final ChannelListener s) {
		super (s);
		jso = j;
	}
	
	/**
	 * WRITEME: Document this constructor ewinkelman
	 * 
	 * @param from
	 * @param s Source
	 * @param newSource WRITEME: Document this constructor ewinkelman
	 */
	public ADPJSON (final String from, final ChannelListener newSource) {
		super (newSource);
		jso = new JSONObject ();
		setJSON ("from", from);
	}
	
	/**
	 * Clears the from field for this datagram
	 */
	private void clearCommand () {
		try {
			jso.put ("from", null);
			jso.put ("c", null);
		} catch (JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}
	
	/**
	 * Gets the from command
	 * 
	 * @return
	 */
	public String getCommand () {
		return jso.optString ("from", jso.optString ("c"));
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2234 $";
	}
	
	/**
	 * Formats a datagram for inclusion
	 * 
	 * @param datagram The datagram to include
	 * @return
	 */
	protected void include (ADPJSON datagram) {
		if (datagram != null) {
			setJSON (datagram.getCommand (), datagram.jso);
			datagram.clearCommand ();
		}
	}
	
	/**
	 * Formats a datagram for inclusion with the specified key
	 * 
	 * @param key The key to use for the included datagram
	 * @param datagram The datagram to include
	 */
	protected void include (String key, ADPJSON datagram) {
		if (datagram != null) {
			setJSON (key, datagram.jso);
			datagram.clearCommand ();
		} else {
			setJSON (key, null);
		}
	}

	/**
	 *
	 * @see org.starhope.appius.net.datagram.AbstractDatagram#setChannel(org.starhope.appius.game.Channel)
	 */
	@Override
	public void setChannel (final Channel c) {
		if (null != c.getMoniker () && "" != c.getMoniker ()) {
		try {
			jso.put ("ch", c.getMoniker ());
		} catch (JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
			}
		}
		super.setChannel (c);
	}
	
	/**
	 * Sets a JSON parameter
	 * 
	 * @param param
	 * @param value
	 */
	protected void setJSON (String param, boolean value) {
		try {
			jso.put (param, value);
		} catch (JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}
	
	/**
	 * Sets a JSON parameter
	 * 
	 * @param param
	 * @param value
	 */
	protected void setJSON (String param, int value) {
		try {
			jso.put (param, value);
		} catch (JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}

	/**
	 * Sets a JSON parameter
	 * 
	 * @param param
	 * @param value
	 */
	protected void setJSON (String param, long value) {
		try {
			jso.put (param, value);
		} catch (JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}

	/**
	 * Sets a JSON parameter
	 * 
	 * @param param
	 * @param value
	 */
	protected void setJSON (String param, Object value) {
		try {
			jso.put (param, value);
		} catch (JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}
	
	/**
	 * Sets a JSON parameter
	 * 
	 * @param param
	 * @param value
	 */
	protected void setJSON (String param, String value) {
		try {
			jso.put (param, value);
		} catch (JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
	}

	/**
	 * @see org.starhope.appius.net.datagram.AbstractDatagram#toString()
	 */
	@Override
	public String toString () {
		return jso.toString ();
	}

	/**
	 * Gets the JSON command type for this datagram
	 * 
	 * @return
	 * @see org.starhope.appius.net.datagram.AbstractDatagram#toString(double,
	 *      org.starhope.appius.net.UserAgentInfo)
	 */
	@Override
	public String toString (final double protocolLanguage,
			final UserAgentInfo userAgent) {
		return jso.toString ();
	}

}
