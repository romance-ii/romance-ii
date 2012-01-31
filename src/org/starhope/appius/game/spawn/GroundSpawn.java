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
package org.starhope.appius.game.spawn;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.events.EventType;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.appius.util.WeakRecord;

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
public class GroundSpawn extends SimpleDataRecord <GroundSpawn> {

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int id;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private WeakRecord <RealItem> realItem = null;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private WeakRecord <EventType> eventType = null;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int eventRadius = 0;

	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final long serialVersionUID = 1768828700270823975L;

	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 *
	 * @param loader WRITEME 
	 */
	public GroundSpawn (final RecordLoader <GroundSpawn> loader) {
		super (loader);
	}

	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) { return true; }
		if (obj == null) { return false; }
		if ( ! (obj instanceof GroundSpawn)) { return false; }
		GroundSpawn other = (GroundSpawn) obj;
		if (id != other.id) { return false; }
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
		return Integer.toString (id);
	}

	/**
	 * @return the eventRadius
	 */
	public int getEventRadius () {
		return eventRadius;
	}

	/**
	 * @return the eventType
	 */
	public EventType	 getEventType () {
		return eventType!=null?eventType.get ():null;
	}

	/**
	 * @return the id
	 */
	public int getID () {
		return id + 31;
	}

	/**
	 * @return the realItem
	 */
	public RealItem getRealItem () {
		return realItem!=null? realItem.get ():null;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}

	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#hashCode()
	 */
	@Override
	public int hashCode () {
		return id;
	}

	/**
	 * @param eventRadius the eventRadius to set
	 */
	public void setEventRadius (final int eventRadius) {
		this.eventRadius = eventRadius;
	}

	/**
	 * @param eventTypeID the eventType to set
	 */
	public void setEventType (final int eventTypeID) {
		eventType= new WeakRecord <EventType> (EventType.class, eventTypeID);
	}

	/**
	 * @param id the id to set
	 */
	public void setID (final int id) {
		this.id = id;
	}
	
	/**
	 * @param realItem the realItem to set
	 */
	public void setRealItem (final int realItemID) {
		realItem = new WeakRecord <RealItem> (RealItem.class, realItemID);
	}

}
