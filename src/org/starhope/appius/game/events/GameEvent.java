/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
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
package org.starhope.appius.game.events;

import java.lang.ref.WeakReference;



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
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
 *
 */
public class GameEvent extends SimpleDataRecord <GameEvent> implements HasSubversionRevision {

	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (GameEvent.class);

	/**
	 * Optional width for a flash file
	 */
	private Integer fileWidth = null;

	/**
	 * Optional height for a flash file
	 */
	private Integer fileHeight = null;

	/**
	 * The loader to use for the game, if any
	 */
	private String loader = "";

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int ID;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String moniker;
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String filePath;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private WeakReference <EventType> endEvent = new WeakReference <EventType> (null);

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int endEventID;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = -572025513127486450L;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public GameEvent () {
		super (GameEvent.class);
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param loader WRITEME
	 */
	public GameEvent (final RecordLoader <GameEvent> loader) {
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
		if ( ! (obj instanceof GameEvent)) {
			return false;
		}
		GameEvent other = (GameEvent) obj;
		if (ID != other.ID) {
			return false;
		}
		return true;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return ID;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return Integer.toString (ID);
	}

	/**
	 * @return the eventType
	 */
	public EventType getEndEvent () {
		EventType result = endEvent.get ();
		if (result == null) {
			try {
				endEvent = new WeakReference <EventType> (Nomenclator.getDataRecord (EventType.class, endEventID));
				result = endEvent.get ();
			} catch (NotFoundException e) {
				GameEvent.log.error ("Exception", e);
			}
		}
		return result;
	}

	/**
	 * @return the fileHeight
	 */
	public Integer getFileHeight () {
		return fileHeight;
	}

	/**
	 * @return the filePath
	 */
	public String getFilePath () {
		return filePath;
	}

	/**
	 * @return the fileWidth
	 */
	public Integer getFileWidth () {
		return fileWidth;
	}

	/**
	 * @return the iD
	 */
	public int getID () {
		return ID;
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
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = prime * result + ID;
		return result;
	}

	/**
	 * @param endEvent the eventType to set
	 */
	public void setEndEvent (final int eventTypeID) {
		endEventID = eventTypeID;
		endEvent = new WeakReference <EventType> (null);
	}

	/**
	 * @param fileHeight the fileHeight to set
	 */
	public void setFileHeight (final Integer fileHeight) {
		this.fileHeight = fileHeight;
	}

	/**
	 * @param filePath the filePath to set
	 */
	public void setFilePath (final String filePath) {
		this.filePath = filePath;
	}

	/**
	 * @param fileWidth the fileWidth to set
	 */
	public void setFileWidth (final Integer fileWidth) {
		this.fileWidth = fileWidth;
	}

	/**
	 * @param id the id to set
	 */
	public void setID (final int id) {
		ID = id;
	}

	/**
	 * @param loader the loader to set
	 */
	public void setLoader (final String loader) {
		this.loader = loader;
	}

	/**
	 * @param moniker the moniker to set
	 */
	public void setMoniker (final String moniker) {
		this.moniker = moniker;
	}

}
