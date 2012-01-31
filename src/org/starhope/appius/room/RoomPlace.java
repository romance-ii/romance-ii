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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.room;

import java.awt.geom.GeneralPath;

import org.starhope.appius.except.GameLogicException;

/**
 * <p>
 * A place (region, area) within a room. A place occupies space, most
 * generally as a 2-dimensional field extended to an infinite prism, and
 * can have various effects applied to it.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class RoomPlace {
	
	/**
	 * Arbitrary string attributes
	 */
	private String [] attributes;
	
	/**
	 * The name of this place (unique)
	 */
	private String name;
	
	/**
	 * The shape describing this place
	 */
	private GeneralPath shape = new GeneralPath ();
	
	/**
	 * The type of Place defined by this object
	 */
	private RoomPlaceType type;
	
	/**
	 * @param kindOfPlace {@link #type}
	 * @param placeName {@link #name}
	 * @param placeShape {@link #shape}
	 * @param placeAttributes {@link #attributes}
	 */
	public RoomPlace (final RoomPlaceType kindOfPlace,
			final String placeName, final GeneralPath placeShape,
			final String [] placeAttributes) {
		type = kindOfPlace;
		name = placeName;
		shape = placeShape;
		attributes = placeAttributes;
	}
	
	/**
	 * add an additional shape to this one's (union operation)
	 * 
	 * @param additionalShape another shape
	 */
	public void add (final GeneralPath additionalShape) {
		// TODO
	}
	
	/**
	 * called whenever this changes … TODO
	 */
	private void changed () {
		// no op
	}
	
	/**
	 * @return the attributes
	 */
	public String [] getAttributes () {
		// XXX: return a copy
		return attributes;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public String getName () {
		return name;
	}
	
	/**
	 * @return the shape
	 */
	public GeneralPath getShape () {
		return shape;
	}
	
	/**
	 * @return the type
	 */
	public RoomPlaceType getType () {
		return type;
	}
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param placeType WRITEME
	 * @param placeName WRITEME
	 * @param placeShape WRITEME
	 * @param placeAttributes WRITEME
	 * @return WRITEME
	 * @throws GameLogicException WRITEME
	 */
	public RoomPlace makePlace (final RoomPlaceType placeType,
			final String placeName, final GeneralPath placeShape,
			final String... placeAttributes)
			throws GameLogicException {
		switch (placeType) {
		case evt_$:
			return new ServerEventPlace (placeName, placeShape,
					placeAttributes);
		case evt_item_:
			return new ItemPurchasePlace (placeName, placeShape,
					placeAttributes);
		case evt_itm2_:
			return new ItemPurchasePlace_FreeVsPaid (placeName,
					placeShape, placeAttributes);
		case evt_vitm_:
			return new ItemPurchasePlace_PaidOnly (placeName,
					placeShape, placeAttributes);
		case evt__:
		case gam_:
			return new ClientEventPlace (placeName, placeShape,
					placeAttributes);
		case out_:
			return new EntrancePlace (placeName, placeShape,
					placeAttributes);
		case rom_:
			return new ExitPlace (placeName, placeShape,
					placeAttributes);
		case walk:
			return new WalkSpace (placeName, placeShape,
					placeAttributes);
		case obs_:
			return new ObstacleSpace (placeName, placeShape,
					placeAttributes);
		case xpt_:
			return new TransportSpace (placeName, placeShape,
					placeAttributes);
		}
		throw new GameLogicException ("unknown place type",
				placeType, placeName);
	}
	
	/**
	 * @param newAttributes the attributes to set
	 */
	public void setAttributes (final String [] newAttributes) {
		attributes = newAttributes;
		changed ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param newName WRITEME
	 */
	public void setName (final String newName) {
		name = newName;
		changed ();
	}
	
	/**
	 * @param replacementShape the shape to set
	 */
	public void setShape (final GeneralPath replacementShape) {
		shape = replacementShape;
		changed ();
	}
	
	/**
	 * @param newType the type to set
	 */
	public void setType (final RoomPlaceType newType) {
		type = newType;
		changed ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param removeShape WRITEME
	 */
	public void subtract (final GeneralPath removeShape) {
		// TODO
	}
	
}
