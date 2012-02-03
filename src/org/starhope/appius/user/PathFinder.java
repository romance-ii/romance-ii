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
package org.starhope.appius.user;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Room;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.physica.Geometry;
import org.starhope.appius.physica.Kalendor;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 */
public class PathFinder implements Serializable {

	/**
	 * WRITEME: Document this type.
	 *
	 * @author brpocock@star-hope.org
	 */
	public class ContinuePathRunner implements Runnable {

		/**
		 * Where are we going?
		 */
		private final Coord3D target;

		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 *
		 * @param until the place we want to eventually reach
		 */
		public ContinuePathRunner (final Coord3D until) {
			target = until;
		}

		/**
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run () {
			if ( !user.isOnline ()) {
				return;
			}
			takei (target);
		}

	}

	/**
	 * Java Serialisation unique ID
	 */
	private static final long serialVersionUID = 171577900883858985L;

	/**
	 * who is lost?
	 */
	final AbstractUser user;

	/**
	 * Try so many times to find a random point that just so happens to
	 * make a path to an unreachable point
	 */
	private static final int PATH_TRIES = 10;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private long timedEvent = -1;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final transient Kalendor kalendor = AppiusClaudiusCaecus
			.getKalendor ();

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param newUser user
	 */
	public PathFinder (final AbstractUser newUser) {
		user = newUser;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param to WRITEME
	 * @param visited WRITEME
	 * @param nextHop WRITEME
	 * @return WRITEME
	 */
	public List <String> findPathSolution (final String to,
			final List <String> visited, final String nextHop) {
		final List <String> solution = new LinkedList <String> ();
		if (nextHop.equals (to)) {
			return solution;
		} else if (visited.contains (nextHop)) {
			return null;
		} else {
			final List <String> subPath = findPathsTo (nextHop, to);
			return subPath;
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param from moniker from which to travel
	 * @param to moniker to which to travel
	 * @return shortest path (by number of links)
	 */
	public List <String> findPathsTo (final String from, final String to) {
		final List <String> path = new LinkedList <String> ();
		path.add (from);
		final List <List <String>> solutions = new LinkedList <List <String>> ();
		for (final String otherString : user.getZone ().getRoomMap ()
				.get (from)) {
			return findPathSolution (to, path, otherString);
		}
		if (solutions.size () == 0) {
			return null;
		}
		final int bestSolutionSize = Integer.MAX_VALUE;
		List <String> bestWay = null;
		for (final List <String> solution : solutions) {
			if (solution.size () < bestSolutionSize) {
				bestWay = solution;
			}
		}
		path.addAll (bestWay);
		return path;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param room WRITEME
	 * @return WRITEME
	 */
	public String getRoomToward (final String room) {
		final String thisRoom = user.getRoom ().getMoniker ();
		if (room.equals (thisRoom)) {
			return null;
		}
		List <String> bestSolution = null;
		for (final String other : user.getZone ().getRoomMap ().get (
				thisRoom)) {
			if (other.equals (room)) {
				return null;
			}
			final List <String> path = findPathsTo (other, room);
			if (null != path) {
				if (null == bestSolution) {
					bestSolution = path;
				} else if (bestSolution.size () > path.size ()) {
					bestSolution = path;
				}
			}
		}
		if (null != bestSolution) {
			return bestSolution.get (0);
		}
		return null;
	}

	/**
	 * Take a step toward the target. Might make an intermediate step;
	 * keep calling until it returns true.
	 *
	 * @param target the goal
	 * @return true, if the current walk should bring us to the target;
	 *         false, if more steps are needed
	 */
	public boolean pathTo (final Coord3D target) {
		Room currentRoom = user.getRoom ();
		if ( !currentRoom.canWalk (target)) {
			// Unreachable! Just get as close as we can, from here.
			currentRoom.goTo (user, currentRoom.goTo_clipToWalkSpace (
					user, target), null, "Walk");
			return true;
		}
		final Coord3D location = user.getLocation ();
		if (currentRoom.canWalk (location, target)) {
			currentRoom.goTo (user, target, null, "Walk");
			return true;
		}
		Coord3D p = null;
		int tries = PathFinder.PATH_TRIES;
		while (tries-- > 0) {
			p = Coord3D.randomIn (currentRoom);
			if ( !currentRoom.canWalk (location, p)) {
				continue;
			}
			if (currentRoom.canWalk (p, target)) {
				currentRoom.goTo (user, p, null, "Walk");
				return false;
			}
		}

		tries = PathFinder.PATH_TRIES;
		Coord3D randWaypoint = location;
		double dist = Double.MAX_VALUE;
		while (tries-- > 0) {
			p = Coord3D.randomIn (currentRoom);
			if ( !currentRoom.canWalk (location, p)) {
				continue;
			}
			final double thisDist = target.distance (p);
			if (thisDist < dist) {
				dist = thisDist;
				randWaypoint = p;
			}
		}
		currentRoom.goTo (user, randWaypoint, null, "Walk");
		return false;

	}

	/**
	 * @param r the room to seek
	 * @return true, if we're in the room.
	 */
	public boolean seekRoom (final Room r) {
		final Room currentRoom = user.getRoom ();
		if (r == currentRoom) {
			return true;
		}
		String nextRoom = getRoomToward (r.getMoniker ());
		if (null != nextRoom) {
			try {
				if (false == pathTo (Geometry.getRandomPointWithin (
						currentRoom.getExitTo (nextRoom)).toCoord3D ())) {
					return false; // not there yet
				}
			} catch (NotFoundException e) {
				// fall through
			}
		}
		r.join (user);
		user.setRoom (r);
		return true;
	}

	/**
	 * stop any planned movements into the future
	 */
	public synchronized void stop () {
		if (timedEvent > 0) {
			kalendor.cancel (timedEvent);
			timedEvent = -1;
		}
	}

	/**
	 * Plot a course, Mr Sulu
	 *
	 * @param target second star to the right
	 */
	public synchronized void takei (final Coord3D target) {
		if (timedEvent > 0) {
			stop ();
		}
		if ( !pathTo (target)) {
			timedEvent = whenAtTarget (new ContinuePathRunner (target));
		}
	}

	/**
	 * Perform some action when the current movement-target position has
	 * been reached
	 *
	 * @param runnable what to do when the target position is (or at
	 *            least, should have been) reached
	 * @return the handle to the event, in case it's needed to cancel it
	 * @see Kalendor#schedule(long, Runnable)
	 * @see Kalendor#cancel(long)
	 * @see Geometry#getTimeToTarget(AbstractUser, long)
	 */

	public long whenAtTarget (final Runnable runnable) {
		return kalendor.schedule (Geometry.getTimeToTarget (user,
				System.currentTimeMillis ())
				+ System.currentTimeMillis (), runnable);
	}

}
