/**
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Res Interactive, LLC. This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful,    but WITHOUT ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the   GNU Affero General Public License for more details.  You should have received a copy of the GNU Affero General Public License  along with this program.  If not, see <http://www.gnu.org/licenses/>..
 */
package org.starhope.appius.physica;

import org.starhope.appius.game.BugReporter;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.geometry.PolygonPrimitive;
import org.starhope.appius.geometry.Vector2D;

/**
 * A generic collision object. Used primarily for 'rewinding' objects
 * when they collide so that the true point of collision can be found
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public final class CollisionObject implements Collidable {
	
	/**
	 * Object's center of mass
	 */
	private Coord2D centerofMass;
	
	/**
	 * Determines if this object has changed since the last reset
	 */
	private boolean changed = false;
	
	/**
	 * Object's collision boundaries
	 */
	private PolygonPrimitive <?> collisionBounds;
	
	/**
	 * Object's mass
	 */
	final private double mass;
	
	/**
	 * The time the object will stop moving
	 */
	final private long moveEndTime;
	
	/**
	 * The time the object started moving
	 */
	final private long moveStartTime;
	
	/**
	 * The current time index for this snapshot
	 */
	private long referenceTime;
	
	/**
	 * Object's velocity
	 */
	private Vector2D velocity;
	
	/**
	 * WRITEME: Document this constructor
	 * 
	 * @param obj WRITEME
	 * @param currentTime WRITEME
	 */
	public CollisionObject (final Collidable obj,
			final long currentTime) {
		mass = obj.getMass ();
		collisionBounds = obj.getCollisionBounds ();
		centerofMass = obj.getCenterOfMass ();
		final double x = centerofMass.getX ();
		if (Double.isNaN (x)) {
			BugReporter.getReporter ("srv").reportBug ("Hate you");
		}
		velocity = obj.getVelocity ();
		referenceTime = currentTime;
		moveEndTime = obj.getEndMovementTime (currentTime);
		moveStartTime = obj.getStartMovementTime ();
	}
	
	/**
	 * Gets the current moved status
	 * 
	 * @return WRITEME
	 */
	public boolean changed () {
		return changed;
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#getCenterOfMass()
	 */
	@Override
	public Coord2D getCenterOfMass () {
		return centerofMass;
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#getCollisionBounds()
	 */
	@Override
	public PolygonPrimitive <?> getCollisionBounds () {
		return collisionBounds;
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#getEndMovementTime(long)
	 */
	@Override
	public long getEndMovementTime (final long currentTime) {
		return moveEndTime;
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#getMass()
	 */
	@Override
	public double getMass () {
		return mass;
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#getStartMovementTime()
	 */
	@Override
	public long getStartMovementTime () {
		return moveStartTime;
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#getVelocity()
	 */
	@Override
	public Vector2D getVelocity () {
		return new Vector2D (velocity);
	}
	
	/**
	 * Moves the object forward/backwards by x milliseconds Also
	 * watches for objects that start/stop
	 * 
	 * @param milliseconds WRITEME
	 */
	public void move (final long milliseconds) {
		long ms = milliseconds; // How much of the requested time we
		// actually move
		final long temp = ms + referenceTime;
		if (moveEndTime > moveStartTime) { // Normal case
			if (referenceTime < moveStartTime) {
				ms = temp > moveStartTime ? referenceTime
						- moveStartTime : 0;
			} else if (referenceTime > moveEndTime) {
				ms = temp < moveEndTime ? referenceTime
						- moveEndTime : 0;
			} else {
				ms = temp > moveEndTime ? moveEndTime
						- referenceTime : ms;
				ms = temp < moveStartTime ? moveStartTime
						- referenceTime : ms;
			}
		} else if (moveEndTime < moveStartTime) { // Highly unusual.
			// Not
			// handling the
			// case
			// of starting
			// and stopping in the same requested interval
			if (referenceTime > moveStartTime) {
				
				ms = temp < moveStartTime ? referenceTime
						- moveStartTime : ms;
			} else if (referenceTime < moveEndTime) {
				ms = temp > moveEndTime ? referenceTime
						- moveEndTime : ms;
			} else {
				ms = temp > moveStartTime ? temp - moveStartTime
						: 0;
				ms = temp < moveEndTime ? temp - moveEndTime : 0;
			}
		} else { // Start and end time are the same... can't move!
			ms = 0;
		}
		referenceTime += milliseconds;
		final double xDiff = velocity.getX () * ms * 0.001;
		final double yDiff = velocity.getY () * ms * 0.001;
		collisionBounds = collisionBounds.translate (xDiff, yDiff);
		centerofMass = centerofMass.translate (xDiff, yDiff);
		if ( (ms != 0) && (xDiff != 0) && (yDiff != 0)) {
			changed = true;
		}
	}
	
	/**
	 * Resets the moved flag
	 */
	public void reset () {
		changed = false;
	}
	
	/**
	 * Sets the center of mass
	 * 
	 * @see org.starhope.appius.physica.Collidable#setCenterOfMass(Coord2D)
	 */
	@Override
	public void setCenterOfMass (final Coord2D com) {
		changed = true;
		centerofMass = new Coord2D (com);
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#setVelocity(Vector2D)
	 */
	@Override
	public void setVelocity (final Vector2D newVelocity) {
		changed = true;
		velocity = new Vector2D (newVelocity);
	}
}
