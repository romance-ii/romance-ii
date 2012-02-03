/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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

package org.starhope.appius.user.events;

import org.starhope.appius.game.Room;
import org.starhope.appius.user.AbstractUser;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class ActionHandler implements ActionHandlerInterface {

	/**
	 * whether any direct object is matched
	 */
	private boolean anyObject;

	/**
	 * WRITEME
	 */
	private boolean anyRoom;
	/**
	 * WRITEME
	 */
	private boolean anySubject;
	/**
	 * whether any verb is matched
	 */
	private boolean anyVerb;
	/**
	 * WRITEME
	 */
	private AbstractUser myObject;
	/**
	 * WRITEME
	 */
	private Room myRoom;
	/**
	 * WRITEME
	 */
	private AbstractUser mySubject;
	/**
	 * target method of the action
	 */
	private ActionMethod myTarget;
	/**
	 * verb to be matched
	 */
	private String myVerb;

	/**
	 * WRITEME
	 */
	private boolean zoneMatch;

	/**
	 * whether to match any indirect object
	 */
	private boolean anyIndirectObject = true;

	/**
	 *
	 */
	private String myIndirectObject = null;

	/**
	 * Create a new action handler matching a usual set of conditions.
	 * Setting any condition-noun to “null” will cause it to match any
	 * possible item of that type; e.g. setting the room to null will
	 * {@link #setAnyRoom(boolean)} to true. These conditions can be
	 * altered once the handler is created.
	 * 
	 * @param room WRITEME
	 * @param subject WRITEME
	 * @param verb WRITEME
	 * @param object WRITEME
	 * @param target WRITEME
	 */
	public ActionHandler (final Room room,
			final AbstractUser subject,
			final String verb, final AbstractUser object,
			final ActionMethod target) {
		this (room, subject, verb, object, null, target);
	}
	
	/**
	 * This is the “old form” action handler interface, to be replaced
	 * with the new {@link Action} object interface.
	 * 
	 * @param room place in which the action happened
	 * @param subject actor causing something to happen
	 * @param verb what happened
	 * @param object actor to whom something has happened
	 * @param dative indirect object explaining more about what happened
	 * @param target code to be run if the event occurs as described
	 */
	public ActionHandler (final Room room, final AbstractUser subject,
			final String verb, final AbstractUser object,
			final String dative, final ActionMethod target) {
		zoneMatch = false;
		myRoom = room;
		anyRoom = null == room;
		mySubject = subject;
		anySubject = null == subject;
		myVerb = verb;
		anyVerb = null == verb;
		myObject = object;
		anyObject = null == object;
		myIndirectObject = dative;
		anyIndirectObject = null == dative;
		myTarget = target;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#compareTo(Object)
	 */
	@Override
	public int compareTo (final Object o) {
		return toString ().compareTo (o.toString ());
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (null == obj) {
			return false;
		}
		if ( ! (obj instanceof ActionHandler)) {
			return false;
		}
		return 0 == compareTo (obj);
	}

	/**
	 * @return the myIndirectObject
	 */
	public String getIndirectObject () {
		return myIndirectObject;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#getObject()
	 */
	@Override
	public AbstractUser getObject () {
		return myObject;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#getRoom()
	 */
	@Override
	public Room getRoom () {
		return myRoom;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#getSubject()
	 */
	@Override
	public AbstractUser getSubject () {
		return mySubject;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#getTarget()
	 */
	@Override
	public ActionMethod getTarget () {
		return myTarget;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#getVerb()
	 */
	@Override
	public String getVerb () {
		return myVerb;
	}

/**
 * @see org.starhope.appius.user.events.ActionHandlerInterface#hashCode()
 */
@Override
public int hashCode () {
	return LibMisc.makeHashCode (toString ());
}

	/**
	 *
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#invoke(org.starhope.appius.user.events.Action)
	 */
		@Override
		public boolean invoke (final Action action) {
			return myTarget.acceptAction (action.getWhere (), action.getSubject (),action.getVerb (),action.getObject (),action.getIndirectObject (), action.getTrailer ());
		}

	/**
	 * @return the anyIndirectObject
	 */
	public boolean isAnyIndirectObject () {
		return anyIndirectObject;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#isAnyObject()
	 */
	@Override
	public boolean isAnyObject () {
		return anyObject;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#isAnyRoom()
	 */
	@Override
	public boolean isAnyRoom () {
		return anyRoom;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#isAnySubject()
	 */
	@Override
	public boolean isAnySubject () {
		return anySubject;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#isAnyVerb()
	 */
	@Override
	public boolean isAnyVerb () {
		return anyVerb;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#isZoneMatch()
	 */
	@Override
	public boolean isZoneMatch () {
		return zoneMatch;
	}

	/**
	 *
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#matches(org.starhope.appius.user.events.Action)
	 */
	@Override
	public boolean matches (final Action action) {
		final Room where = action.getWhere ();
		if ( !anyRoom) {
			if (zoneMatch) {
				if (null == where || null == myRoom) {
					return false;
				}
				if ( !where.getZone ().equals (myRoom.getZone ())) {
					return false;
				}
			} else {
				if (null == myRoom) {
					if (null != where) {
						return false;
					}
				} else if ( !myRoom.equals (where)) {
					return false;
				}
			}
		}
		final AbstractUser subject=action.getSubject ();
		if ( !anySubject) {
			if (null == mySubject) {
				if (null != subject) {
					return false;
				}
			} else if ( !mySubject.equals (subject)) {
				return false;
			}
		}
		 final String verb = action.getVerb ();

		if ( !anyVerb) {
			if (null == myVerb) {
				if (null != verb) {
					return false;
				}
			} else if ( !myVerb.equals (verb)) {
				return false;
			}
		}
		final AbstractUser object=action.getObject ();
		if ( !anyObject) {
			if (null == myObject) {
				if (null != object) {
					return false;
				}
			} else if ( !myObject.equals (object)) {
				return false;
			}
		}
		final String indirectObject = action.getIndirectObject ();
		if ( !isAnyIndirectObject()) {
			if (null == getIndirectObject()) {
				if (null != indirectObject) {
					return false;
				}
			} else if ( !getIndirectObject().equals (indirectObject)) {
				return false;
			}
		}

		return true;
	}

	/**
	 * @param really the anyIndirectObject to set
	 */
	public void setAnyIndirectObject (final boolean really) {
		anyIndirectObject = really;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#setAnyObject(boolean)
	 */
	@Override
	public void setAnyObject (final boolean newObject) {
		anyObject = newObject;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#setAnyRoom(boolean)
	 */
	@Override
	public void setAnyRoom (final boolean newRoom) {
		anyRoom = newRoom;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#setAnySubject(boolean)
	 */
	@Override
	public void setAnySubject (final boolean newSubject) {
		anySubject = newSubject;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#setAnyVerb(boolean)
	 */
	@Override
	public void setAnyVerb (final boolean newVerb) {
		anyVerb = newVerb;
	}
	
	/**
	 * @param indirectObject the Indirect Object to set
	 */
	public void setIndirectObject (final String indirectObject) {
		myIndirectObject = indirectObject;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#setObject(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void setObject (final AbstractUser newObject) {
		myObject = newObject;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#setRoom(org.starhope.appius.game.Room)
	 */
	@Override
	public void setRoom (final Room newRoom) {
		myRoom = newRoom;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#setSubject(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void setSubject (final AbstractUser newSubject) {
		mySubject = newSubject;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#setTarget(org.starhope.appius.user.events.ActionMethod)
	 */
	@Override
	public void setTarget (final ActionMethod newTarget) {
		myTarget = newTarget;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#setVerb(java.lang.String)
	 */
	@Override
	public void setVerb (final String newVerb) {
		myVerb = newVerb;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#setZoneMatch(boolean)
	 */
	@Override
	public void setZoneMatch (final boolean newMatch) {
		zoneMatch = newMatch;
	}

	/**
	 * @see org.starhope.appius.user.events.ActionHandlerInterface#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder s = new StringBuilder ();
		s.append ("ActionHandler:");
		if ( !anyRoom) {
			if (zoneMatch) {
				s.append ("(zone=");
			} else {
				s.append ("(room=");
			}
			s.append (myRoom.getDebugName ());
			s.append (')');
		}
		if ( !anySubject) {
			s.append ("(subject=");
			s.append (mySubject.getDebugName ());
			s.append (')');
		}
		if ( !anyObject) {
			s.append ("(object=");
			s.append (myObject.getDebugName ());
			s.append (')');
		}
		if ( !anyVerb) {
			s.append ("(verb=");
			s.append (myVerb);
			s.append (')');
		}
		if ( !anyIndirectObject) {
			s.append ("(indirect=");
			s.append (myIndirectObject);
			s.append (')');
		}
		s.append ("->");
		s.append (myTarget.toString ());
		return s.toString ();
	}

}
