/**
 * <p> Copyright © 2010, Res Interactive, LLC </p>
 * <p>     This program is free software: you can redistribute it and/or modify
*     it under the terms of the GNU Affero General Public License as
 *        published by the Free Software Foundation, either version 3 of the
  *           License, or (at your option) any later version.
   *          </p><p>
    *             This program is distributed in the hope that it will be useful,
     *                but WITHOUT ANY WARRANTY; without even the implied warranty of
      *                   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
       *                      GNU Affero General Public License for more details.
        *                     </p><p>
         *                        You should have received a copy of the GNU Affero General Public License
          *                           along with this program.  If not, see <http://www.gnu.org/licenses/>. </p>
 */
package org.starhope.appius.physica;

import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.geometry.PolygonPrimitive;
import org.starhope.appius.geometry.Vector2D;

/**
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public interface Collidable {
	/**
	 * Gets the object's current center of mass in world coordinates
	 * 
	 * @return A 2D point representing the center of mass
	 */
	Coord2D getCenterOfMass ();
	
	/**
	 * Gets the collision boundaries for the object
	 * 
	 * @return A polygon outlining the boundaries of the object
	 */
	PolygonPrimitive <?> getCollisionBounds ();
	
	/**
	 * @return the time the object will stop moving
	 * @param currentTime The current time
	 */
	long getEndMovementTime (final long currentTime);
	
	/**
	 * Gets the mass of the collidable object
	 * 
	 * @return Mass
	 */
	double getMass ();
	
	/**
	 * @return the time the object started moving
	 */
	long getStartMovementTime ();
	
	/**
	 * Gets the object's current velocity
	 * 
	 * @return A 2D velocity vector
	 */
	Vector2D getVelocity ();
	
	/**
	 * Sets the object's new center of mass in world space coordinates
	 * (i.e. this moves the object and doesn't reposition the relative
	 * location of the center of mass with respect to its bounds)
	 * 
	 * @param com New center of mass in world coordinates
	 */
	void setCenterOfMass (final Coord2D com);
	
	/**
	 * Sets the object's new velocity
	 * 
	 * @param velocity WRITEME
	 */
	void setVelocity (final Vector2D velocity);
}
