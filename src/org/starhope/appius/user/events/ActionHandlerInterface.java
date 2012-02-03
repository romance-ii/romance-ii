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
package org.starhope.appius.user.events;

import org.starhope.appius.game.Room;
import org.starhope.appius.user.AbstractUser;

/**
 * This is an interface for an ActionHandler. There's really no reason
 * to use it directly — just call ActionHandler — but it's necessary for
 * preventing circular class dependencies.
 * 
 * @author brpocock@star-hope.org
 */
public interface ActionHandlerInterface extends
Comparable <Object> {

	/**
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public abstract int compareTo (final Object o);

	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public abstract boolean equals (final Object obj);

	/**
	 * @return the myObject
	 */
	public abstract AbstractUser getObject ();

	/**
	 * @return the myRoom
	 */
	public abstract Room getRoom ();

	/**
	 * @return the mySubject
	 */
	public abstract AbstractUser getSubject ();

	/**
	 * @return the myTarget
	 */
	public abstract ActionMethod getTarget ();

	/**
	 * @return the myVerb
	 */
	public abstract String getVerb ();

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public abstract int hashCode ();

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param action WRITEME
	 * @return true, if the action has been handled completely
	 */
	public abstract boolean invoke (Action action);

	/**
	 * @return the anyObject
	 */
	public abstract boolean isAnyObject ();

	/**
	 * @return the anyRoom
	 */
	public abstract boolean isAnyRoom ();

	/**
	 * @return the anySubject
	 */
	public abstract boolean isAnySubject ();

	/**
	 * @return the anyVerb
	 */
	public abstract boolean isAnyVerb ();

	/**
	 * @return the zoneMatch
	 */
	public abstract boolean isZoneMatch ();

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param action WRITEME
	 * @return WRITEME
	 */
	public abstract boolean matches (Action action);

	/**
	 * @param newObject the anyObject to set
	 */
	public abstract void setAnyObject (final boolean newObject);

	/**
	 * @param newRoom the anyRoom to set
	 */
	public abstract void setAnyRoom (final boolean newRoom);

	/**
	 * @param newSubject the anySubject to set
	 */
	public abstract void setAnySubject (final boolean newSubject);

	/**
	 * @param newVerb the anyVerb to set
	 */
	public abstract void setAnyVerb (final boolean newVerb);

	/**
	 * @param newObject the myObject to set
	 */
	public abstract void setObject (final AbstractUser newObject);

	/**
	 * @param newRoom the myRoom to set
	 */
	public abstract void setRoom (final Room newRoom);

	/**
	 * @param newSubject the mySubject to set
	 */
	public abstract void setSubject (final AbstractUser newSubject);

	/**
	 * @param newTarget the myTarget to set
	 */
	public abstract void setTarget (final ActionMethod newTarget);

	/**
	 * @param newVerb the myVerb to set
	 */
	public abstract void setVerb (final String newVerb);

	/**
	 * @param newMatch the zoneMatch to set
	 */
	public abstract void setZoneMatch (final boolean newMatch);

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public abstract String toString ();

}
