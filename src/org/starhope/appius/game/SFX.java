/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.game;

import java.util.concurrent.atomic.AtomicInteger;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.npc.NullLoader;
import org.starhope.appius.net.datagram.ADPSFX;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class SFX extends SimpleDataRecord <SFX> {
	/**
	 * Counter for custom IDs. They start in the negatives and
	 * decrement.
	 */
	private static AtomicInteger nextCustomID = new AtomicInteger ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = -5810726795840409857L;
	
	static {
		SFX.nextCustomID.set ( -1); // Initialize the custom ID
								// counter
	}
	
	/**
	 * <p>
	 * Creates a custom special effect from a string formatted as a
	 * JSON object The JSON object should contain the information for
	 * fxInfo and the name of the power Custom powers should be careful
	 * to avoid names that conflict with names of database backed
	 * powers such that they end up overwriting each other
	 * </p>
	 * <p>
	 * JSON infomation should be formatted as
	 * {"name":"myName","sfxInfo":{...}} where the ... indicates the
	 * JSON information that the client special effects engine uses
	 * </p>
	 * 
	 * @param sfxString WRITEME 
	 * @return WRITEME 
	 * @throws JSONException
	 */
	public static SFX getCustomSFX (final String sfxString)
			throws JSONException {
		final JSONObject sfxJsonObject = new JSONObject (sfxString);
		final String name = sfxJsonObject.getString ("name");
		final JSONObject sfxInfoObject = sfxJsonObject
				.getJSONObject ("sfxInfo");
		SFX result = null;
		try {
			result = Nomenclator.findInCache (SFX.class, name);
		} catch (final NotFoundException e) {
			// Do nothing, we expect this
		}
		// If we didn't find it, then create it
		if (result == null) {
			result = new SFX (new NullLoader <SFX> (SFX.class));
			result.setMoniker (name);
			result.setID (SFX.nextCustomID.getAndDecrement ());
			Nomenclator.cache (result);
		}
		result.setFxInfo (sfxInfoObject); // Update value
		return result;
	}
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private JSONObject fxInfo;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int hashcode;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int id;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String moniker;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 */
	public SFX () {
		super (SFX.class);
	}
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param loader WRITEME 
	 */
	public SFX (final RecordLoader <SFX> loader) {
		super (loader);
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof SFX)) {
			return false;
		}
		final SFX other = (SFX) obj;
		if (moniker != other.moniker) {
			return false;
		}
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return id;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return moniker;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param source WRITEME 
	 * @return WRITEME 
	 */
	public ADPSFX getDatagram (final ChannelListener source) {
		final ADPSFX result = new ADPSFX (source);
		result.setName (moniker);
		result.setSfxInfo (fxInfo);
		return result;
	}
	
	/**
	 * @return the fxInfo
	 */
	public JSONObject getFxInfo () {
		return fxInfo;
	}
	
	/**
	 * @return the moniker
	 */
	public String getMoniker () {
		return moniker;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4591 $";
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return hashcode;
	}
	
	/**
	 * @param fxInfo the fxInfo to set
	 */
	public void setFxInfo (final JSONObject fxInfo) {
		this.fxInfo = fxInfo;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param id WRITEME 
	 */
	public void setID (final int id) {
		this.id = id;
	}
	
	/**
	 * @param moniker the moniker to set
	 */
	public void setMoniker (final String moniker) {
		this.moniker = moniker;
		final int prime = 31;
		final int result = 1;
		hashcode = (prime * result) + moniker.hashCode ();
	}
}
