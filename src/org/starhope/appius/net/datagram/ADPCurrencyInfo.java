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
package org.starhope.appius.net.datagram;

import org.starhope.appius.game.ChannelListener;
import org.starhope.util.HasSubversionRevision;

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
public class ADPCurrencyInfo extends ADPJSON implements
		HasSubversionRevision {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String icon;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String isoCode;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String name;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String sym;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param s WRITEME 
	 */
	public ADPCurrencyInfo (final ChannelListener s) {
		super ("currencyInfo", s);
	}
	
	/**
	 * @return the icon
	 */
	public String getIcon () {
		return icon;
	}
	
	/**
	 * @return the isoCode
	 */
	public String getIsoCode () {
		return isoCode;
	}
	
	/**
	 * @return the name
	 */
	public String getName () {
		return name;
	}
	
	/**
	 * @return the sym
	 */
	public String getSym () {
		return sym;
	}
	
	/**
	 * @param icon the icon to set
	 */
	public void setIcon (final String icon) {
		this.icon = icon;
		setJSON ("icon", icon);
	}
	
	/**
	 * @param isoCode the isoCode to set
	 */
	public void setIsoCode (final String isoCode) {
		this.isoCode = isoCode;
		setJSON ("code", isoCode);
	}
	
	/**
	 * @param name the name to set
	 */
	public void setName (final String name) {
		this.name = name;
		setJSON ("name", name);
	}
	
	/**
	 * @param sym the sym to set
	 */
	public void setSym (final String sym) {
		this.sym = sym;
		setJSON ("sym", sym);
	}
}
