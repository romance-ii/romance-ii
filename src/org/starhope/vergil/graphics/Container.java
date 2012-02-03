/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */

package org.starhope.vergil.graphics;

import java.util.Collection;

import org.starhope.appius.geometry.Coord3D;

/**
 * A container of containers
 * 
 * @author brpocock@star-hope.org
 */
public interface Container {
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 5,
	 * 2010)
	 * 
	 * @return all sprites contained by this container or its children
	 */
	public Collection <Sprite> getAllContainedSprites ();

	/**
	 * @return the bounding box of this container
	 */
	// public Rectangle3D getBoundingBox ();

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 5,
	 * 2010)
	 * 
	 * @return all containers which are contained within this one
	 */
	public Collection <Container> getChildren ();

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 5,
	 * 2010)
	 * 
	 * @return this container's parent container
	 */
	public Container getParent ();

	/**
	 * @return the position of this container relative to its parent;
	 *         i.e. the coördinate space offset of this container from
	 *         its parent's frame of reference
	 */
	public Coord3D getPosition ();

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 5,
	 * 2010)
	 * 
	 * @return all sprites immediately contained by this container,
	 *         excluding those contained by children
	 */
	public Collection <Sprite> getSprites ();

	/**
	 * @return true, if this container wants to be visible
	 */
	public boolean isVisible ();

	/**
	 * @param pos set the position of this container relative to its
	 *            parent; i.e. the coördinate space offset of this
	 *            container from its parent's frame of reference
	 */
	public void setPosition (Coord3D pos);

	/**
	 * @param toBeSeen true, if you want this container to be
	 *            potentially visible
	 */
	public void setVisible (boolean toBeSeen);

}
