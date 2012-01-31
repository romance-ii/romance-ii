/**
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Res Interactive, LLC. This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful,    but WITHOUT ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the   GNU Affero General Public License for more details.  You should have received a copy of the GNU Affero General Public License  along with this program.  If not, see <http://www.gnu.org/licenses/>..
 */
package org.starhope.appius.physica;

import java.awt.geom.GeneralPath;
import java.awt.geom.Line2D;
import java.awt.geom.PathIterator;
import java.awt.geom.Point2D;
import java.awt.geom.Point2D.Double;
import java.util.Collection;
import java.util.HashSet;

import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.geometry.Vector2D;

/**
 * WRITEME: Document this type.
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class RigidBody {
	
	/**
	 * Collides two objects. If the two objects are not in a collision
	 * state it leaves them unchanged.
	 * 
	 * @param obj1 First object in the collision
	 * @param obj2 Second object in the collision
	 * @param timeIndex Time index of the collision
	 * @throws GameLogicException WRITEME
	 */
	public static void collide (final Collidable obj1,
			final Collidable obj2, final long timeIndex)
			throws GameLogicException {
		if ( !obj1.getCollisionBounds ().intersects (
				obj2.getCollisionBounds ())) {
			return; // Don't bother if
			// they don't
			// collide
		}
		
		if (obj1.getVelocity ().isZero ()
				&& obj2.getVelocity ().isZero ()) {
			return; // Also can't do anything if they're not moving
		}
		
		final CollisionObject cobj1 = new CollisionObject (obj1,
				timeIndex);
		final CollisionObject cobj2 = new CollisionObject (obj2,
				timeIndex);
		long msRollback = 0;
		while (cobj1.getCollisionBounds ().intersects (
				cobj2.getCollisionBounds ())
				&& (msRollback < 100)) {
			cobj1.move ( -1);
			cobj2.move ( -1);
			msRollback++ ;
		}
		if (msRollback == 100) {
			throw new GameLogicException (
					"Cannot find collision point in last 100 ms",
					null, null);
		}
		
		final Coord2D com1 = cobj1.getCenterOfMass ();
		final Coord2D com2 = cobj2.getCenterOfMass ();
		final Vector2D comToComNorm = new Vector2D (com1.getX ()
				- com2.getX (), com1.getY () - com2.getY ());
		final Vector2D comToComTang = new Vector2D (
				comToComNorm.getY (), -comToComNorm.getX ());
		// Break object 1 & 2 velocities into component vectors
		final Vector2D com1NormVel = RigidBody.findComponent (
				cobj1.getVelocity (), comToComNorm);
		final Vector2D com1TangVel = RigidBody.findComponent (
				cobj1.getVelocity (), comToComTang);
		final Vector2D com2NormVel = RigidBody.findComponent (
				cobj2.getVelocity (), comToComNorm);
		final Vector2D com2TangVel = RigidBody.findComponent (
				cobj2.getVelocity (), comToComTang);
		// Calculate reflected velocities
		final Vector2D [] newVelocities = RigidBody.conserveMomentum (
				com1NormVel, com2NormVel, cobj1.getMass (),
				cobj2.getMass (), 0.9);
		cobj1.setVelocity (newVelocities [0].add (com1TangVel));
		cobj2.setVelocity (newVelocities [1].add (com2TangVel));
		// Move objects and set velocities
		cobj1.move (msRollback);
		cobj2.move (msRollback);
		// Order of setting these is important
		obj1.setCenterOfMass (cobj1.getCenterOfMass ());
		obj1.setVelocity (cobj1.getVelocity ());
		obj2.setCenterOfMass (cobj2.getCenterOfMass ());
		obj2.setVelocity (cobj2.getVelocity ());
	}
	
	/**
	 * Velocity change equation for conserving momentum between two
	 * objects
	 * 
	 * @param myVelocity Main object's velocity
	 * @param otherVelocity Other object's velocity
	 * @param myMass Main object's mass
	 * @param otherMass Other object's mass
	 * @param cor Coefficient of Restitution
	 * @return A pair of vectors with the new velocities for object 1
	 *         and object 2
	 */
	public static final Vector2D [] conserveMomentum (
			final Vector2D myVelocity, final Vector2D otherVelocity,
			final double myMass, final double otherMass,
			final double cor) {
		final Vector2D moment1 = myVelocity.scale (myMass);
		final Vector2D moment2 = otherVelocity.scale (otherMass);
		final Vector2D momentumSum = moment1.add (moment2);
		final double cor1 = myMass * cor;
		final double cor2 = otherMass * cor;
		final double massSum = 1d / (myMass + otherMass);
		final Vector2D v2v1 = otherVelocity.subtract (myVelocity);
		final Vector2D v1v2 = myVelocity.subtract (otherVelocity);
		final Vector2D v2v1cor = v2v1.scale (cor2);
		final Vector2D v1v2cor = v1v2.scale (cor1);
		final Vector2D newMomentum1 = momentumSum.add (v2v1cor);
		final Vector2D newMomentum2 = momentumSum.add (v1v2cor);
		final Vector2D v1 = newMomentum1.scale (massSum);
		final Vector2D v2 = newMomentum2.scale (massSum);
		return new Vector2D [] { v1, v2 };
	}
	
	/**
	 * Finds the vector component of the incident vector in the normal
	 * vector
	 * 
	 * @param incident Incident Vector
	 * @param normal Normal Vector
	 * @return The portion of the incident vector in the normal vector
	 */
	public static Vector2D findComponent (final Vector2D incident,
			final Vector2D normal) {
		return new Vector2D ( (incident.getX () * Math.abs (normal
				.getX ())) / normal.length (),
				(incident.getY () * Math.abs (normal.getY ()))
						/ normal.length ());
	}
	
	/**
	 * @param path1 WRITEME
	 * @param path2 WRITEME
	 * @return WRITEME
	 */
	public static Collection <Point2D> getCollisionPoints (
			final GeneralPath path1, final GeneralPath path2) {
		final HashSet <Point2D> result = new HashSet <Point2D> ();
		
		// Don't bother colliding if the bounding boxes don't touch
		if ( !path1.getBounds2D ().intersects (path2.getBounds2D ())) {
			return result;
		}
		
		final PathIterator iter1 = path1.getPathIterator (null);
		final PathIterator iter2 = path2.getPathIterator (null);
		
		Point2D.Double previous1Point = new Double (0d, 0d);
		while ( !iter1.isDone ()) {
			final double [] coords1 = new double [6];
			final int type1 = iter1.currentSegment (coords1);
			if (type1 == PathIterator.SEG_LINETO) {
				final Double point12 = new Double (coords1 [0],
						coords1 [1]);
				final Line2D.Double line1 = new Line2D.Double (
						previous1Point, point12);
				Point2D.Double previous2Point = new Double (0d, 0d);
				while ( !iter2.isDone ()) {
					final double [] coords2 = new double [6];
					final int type2 = iter2
							.currentSegment (coords2);
					if (type2 == PathIterator.SEG_LINETO) {
						final Double point22 = new Double (
								coords2 [2], coords2 [3]);
						final Line2D.Double line2 = new Line2D.Double (
								previous2Point, point22);
						
						final Double interPoint = Geometry
								.getIntersectionPoint (line1,
										line2);
						if (null != interPoint) {
							result.add (interPoint);
						}
					}
					if ( (type2 == PathIterator.SEG_MOVETO)
							|| (type2 == PathIterator.SEG_LINETO)) {
						previous2Point = new Double (coords2 [0],
								coords2 [1]);
					}
					iter2.next ();
				}
			}
			if ( (type1 == PathIterator.SEG_MOVETO)
					|| (type1 == PathIterator.SEG_LINETO)) {
				previous1Point = new Double (coords1 [0],
						coords1 [1]);
			}
			iter1.next ();
		}
		
		return result;
	}
	
	/**
	 * Gets a set of all current collision points between two objects
	 * 
	 * @param path1 Path of object one's collision boundaries
	 * @param path2 Path of object two's collision boundaries
	 * @return A set of points where the objects collide
	 */
	public static boolean hasCollision (final GeneralPath path1,
			final GeneralPath path2) {
		return !RigidBody.getCollisionPoints (path1, path2)
				.isEmpty ();
	}
	
	/**
	 * Reflects a vector around a normal
	 * 
	 * @param incident Incident vector
	 * @param normal Normal vector
	 * @return The new incident vector
	 */
	public static Vector2D Reflect (final Vector2D incident,
			final Vector2D normal) {
		return incident.subtract (normal.scale (2 * normal
				.dot (incident)));
	}
}
