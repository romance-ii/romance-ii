/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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
package org.starhope.appius.geometry;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Room;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class Vector3D extends Tuple3D <Vector3D> {

    /**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 5144366048358976770L;

	/**
     * Creates a vector from two points
     *
     * @param location
     * @param destination
     */
    public Vector3D (final Coord3D location, final Coord3D destination) {
        super (destination.x - location.x, destination.y - location.y,
                destination.z - location.z);
    }

    /**
     * Create a coordinate pair from an x, y and zvalue
     *
     * @param x0 x
     * @param y0 y
     */
    public Vector3D (final double x0, final double y0, final double z0) {
        super (x0, y0, z0);
    }

    /**
     * Creates a vector from an existing vector pair
     *
     * @param v WRITEME
     */
    public Vector3D (final Vector3D v) {
        super (v);
    }

    /**
	 * Gets the dot product of the two vectors
	 * 
	 * @param v3d another 3D vector
	 * @return dot-product
	 */
    public double dot (final Vector3D v3d) {
        return x * v3d.x + y * v3d.y + z * v3d.z;
    }

    /**
     * @return true, if x == y == 0
     */
    public boolean isZero () {
        return x == 0 && y == 0 && z == 0;
    }

    /**
     * Gets the length/magnitude of the vector
     *
     * @return the length (magnitude) of the vector
     */
    public double length () {
        return Math.sqrt (x * x + y * y + z * z);
    }

    /**
     * Creates a new instance of the coordinate pair for use by the
     * abstract generic parent class to get around downcasting problems
     *
     * @see org.starhope.appius.geometry.Tuple2D#newInstance(double,
     *      double)
     */
    @Override
    protected Vector3D newInstance (final double x0, final double y0,
            final double z0) {
        return new Vector3D (x0, y0, z0);
    }

    /**
     * Returns a normalized version of the vector
     *
     * @return WRITEME
     */
    public Vector3D normalize () {
        return scale (1 / length ());
    }

    /**
     * Returns a new vector scaled by the magnitude given
     *
     * @param magnitude WRITEME
     * @return WRITEME
     */
    public Vector3D scale (final double magnitude) {
        return new Vector3D (x * magnitude, y * magnitude, z
                * magnitude);
    }

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param room
	 * @return
	 */
	public Vector3D toEdge (final Room room) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented Vector3D::toEdge (brpocock@star-hope.org, Sep 21, 2010)");
		return this;
	}

}
