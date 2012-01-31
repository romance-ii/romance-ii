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
public class ADPGameStart extends ADPJSON implements
		HasSubversionRevision {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String filename;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Integer height;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String loader;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String moniker;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Integer width;
	
	/**
	 * Default constructor
	 * 
	 * @param s WRITEME 
	 */
	public ADPGameStart (final ChannelListener s) {
		super ("gameStart", s);
	}
	
	/**
	 * @return the filename
	 */
	public String getFilename () {
		return filename;
	}
	
	/**
	 * @return the height
	 */
	public Integer getHeight () {
		return height;
	}
	
	/**
	 * @return the loader
	 */
	public String getLoader () {
		return loader;
	}
	
	/**
	 * @return the moniker
	 */
	public String getMoniker () {
		return moniker;
	}
	
	/**
	 * @return the width
	 */
	public Integer getWidth () {
		return width;
	}
	
	/**
	 * @param filename the filename to set
	 */
	public void setFilename (final String filename) {
		this.filename = filename;
		setJSON ("filename", filename);
	}
	
	/**
	 * @param height the height to set
	 */
	public void setHeight (final Integer height) {
		this.height = height;
		setJSON ("height", height);
	}
	
	/**
	 * @param loader the loader to set
	 */
	public void setLoader (final String loader) {
		this.loader = loader;
		setJSON ("loader", loader);
	}
	
	/**
	 * @param moniker the moniker to set
	 */
	public void setMoniker (final String moniker) {
		this.moniker = moniker;
		setJSON ("moniker", moniker);
	}
	
	/**
	 * @param width the width to set
	 */
	public void setWidth (final Integer width) {
		this.width = width;
		setJSON ("width", width);
	}
	
}
