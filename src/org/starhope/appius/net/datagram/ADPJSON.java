/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.net.datagram;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.Channel;
import org.starhope.appius.game.ChannelListener;

/**
 * Temporary class for datagrams containing arbitrary JSON data. These
 * should be phased-out in favour of more precise packet objects as time
 * permits.
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public abstract class ADPJSON extends AbstractDatagram {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (ADPJSON.class);
	
	/**
	 * WRITEME: Document this field brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -5892420707701078465L;
	/**
	 * Internal JSON object
	 */
	final JSONObject jso;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param j JSON
	 * @param s Source
	 */
	public ADPJSON (final JSONObject j, final ChannelListener s) {
		super (s);
		jso = j;
	}
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param from WRITEME 
	 * @param s Source
	 * @param newSource WRITEME: Document this constructor
	 *             ewinkelman@resinteractive.com
	 */
	public ADPJSON (final String from, final ChannelListener newSource) {
		super (newSource);
		jso = new JSONObject ();
		setJSON ("from", from);
	}
	
	/**
	 * Clears the from field for this datagram
	 */
	void clearCommand () {
		try {
			jso.put ("from", null);
			jso.put ("c", null);
		} catch (final JSONException e) {
			ADPJSON.log.error ("Exception", e);
		}
	}
	
	/**
	 * Gets the from command
	 * 
	 * @return WRITEME 
	 */
	public String getCommand () {
		return jso.optString ("from", jso.optString ("c"));
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * Formats a datagram for inclusion
	 * 
	 * @param datagram The datagram to include
	 * @return WRITEME 
	 */
	protected void include (final ADPJSON datagram) {
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
	protected void include (final String key, final ADPArray <?> array) {
		if (array != null) {
			setJSON (key, array.jso);
		} else {
			setJSON (key, null);
		}
	}
	
	/**
	 * Formats a datagram for inclusion with the specified key
	 * 
	 * @param key The key to use for the included datagram
	 * @param datagram The datagram to include
	 */
	protected void include (final String key, final ADPJSON datagram) {
		if (datagram != null) {
			setJSON (key, datagram.jso);
			datagram.clearCommand ();
		} else {
			setJSON (key, null);
		}
	}
	
	/**
	 * @see org.starhope.appius.net.datagram.AbstractDatagram#setChannel(org.starhope.appius.game.Channel)
	 */
	@Override
	public void setChannel (final Channel c) {
		if ( (null != c.getMoniker ()) && ("" != c.getMoniker ())) {
			try {
				jso.put ("ch", c.getMoniker ());
			} catch (final JSONException e) {
				ADPJSON.log.error ("Exception", e);
			}
		}
		super.setChannel (c);
	}
	
	/**
	 * Sets a JSON parameter
	 * 
	 * @param param WRITEME 
	 * @param value WRITEME 
	 */
	protected void setJSON (final String param, final boolean value) {
		try {
			jso.put (param, value);
		} catch (final JSONException e) {
			ADPJSON.log.error ("Exception", e);
		}
	}
	
	/**
	 * Sets a JSON parameter
	 * 
	 * @param param WRITEME 
	 * @param value WRITEME 
	 */
	protected void setJSON (final String param, final double value) {
		try {
			jso.put (param, value);
		} catch (final JSONException e) {
			ADPJSON.log.error ("Exception", e);
		}
	}
	
	/**
	 * Sets a JSON parameter
	 * 
	 * @param param WRITEME 
	 * @param value WRITEME 
	 */
	protected void setJSON (final String param, final int value) {
		try {
			jso.put (param, value);
		} catch (final JSONException e) {
			ADPJSON.log.error ("Exception", e);
		}
	}
	
	/**
	 * Sets a JSON parameter
	 * 
	 * @param param WRITEME 
	 * @param value WRITEME 
	 */
	protected void setJSON (final String param, final long value) {
		try {
			jso.put (param, value);
		} catch (final JSONException e) {
			ADPJSON.log.error ("Exception", e);
		}
	}
	
	/**
	 * Sets a JSON parameter
	 * 
	 * @param param WRITEME 
	 * @param value WRITEME 
	 */
	protected void setJSON (final String param, final Object value) {
		try {
			jso.put (param, value);
		} catch (final JSONException e) {
			ADPJSON.log.error ("Exception", e);
		}
	}
	
	/**
	 * Sets a JSON parameter
	 * 
	 * @param param WRITEME 
	 * @param value WRITEME 
	 */
	protected void setJSON (final String param, final String value) {
		try {
			jso.put (param, value);
		} catch (final JSONException e) {
			ADPJSON.log.error ("Exception", e);
		}
	}
	
	/**
	 * @see org.starhope.appius.net.datagram.AbstractDatagram#toString()
	 */
	@Override
	public String toString () {
		return jso.toString ();
	}
	
}
