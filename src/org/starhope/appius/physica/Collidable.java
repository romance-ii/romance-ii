/**
 *
 */
package org.starhope.appius.physica;

import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.geometry.PolygonPrimitive;
import org.starhope.appius.geometry.Vector2D;

/**
 * @author ewinkelman
 *
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