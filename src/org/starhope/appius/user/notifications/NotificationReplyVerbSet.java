/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Timothy Heys
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
 * License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.user.notifications;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.util.CastsToJSON;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class NotificationReplyVerbSet implements
		Collection <NotificationReplyVerb>, CastsToJSON {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -8785675032265591315L;
	/**
	 * Internal storage implementation
	 */
	private final Collection <NotificationReplyVerb> n = new HashSet <NotificationReplyVerb> ();
	
	/**
	 * Constructor for an empty set
	 */
	public NotificationReplyVerbSet () {
		/* Nothing to do */
	}
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param other another collection of reply verbs to be added
	 */
	public NotificationReplyVerbSet (
			final Collection <NotificationReplyVerb> other) {
		addAll (other);
	}
	
	/**
	 * @see java.util.Collection#add(java.lang.Object)
	 */
	@Override
	public boolean add (final NotificationReplyVerb e) {
		return n.add (e);
	}
	
	/**
	 * @see java.util.Collection#addAll(java.util.Collection)
	 */
	@Override
	public boolean addAll (
			final Collection <? extends NotificationReplyVerb> c) {
		return n.addAll (c);
	}
	
	/**
	 * @see java.util.Collection#clear()
	 */
	@Override
	public void clear () {
		n.clear ();
	}
	
	/**
	 * @see java.util.Collection#contains(java.lang.Object)
	 */
	@Override
	public boolean contains (final Object o) {
		return n.contains (o);
	}
	
	/**
	 * @see java.util.Collection#containsAll(java.util.Collection)
	 */
	@Override
	public boolean containsAll (final Collection <?> c) {
		return n.containsAll (c);
	}
	
	/**
	 * @see java.util.Collection#isEmpty()
	 */
	@Override
	public boolean isEmpty () {
		return n.isEmpty ();
	}
	
	/**
	 * @see java.util.Collection#iterator()
	 */
	@Override
	public Iterator <NotificationReplyVerb> iterator () {
		return n.iterator ();
	}
	
	/**
	 * @see java.util.Collection#remove(java.lang.Object)
	 */
	@Override
	public boolean remove (final Object o) {
		return n.remove (o);
	}
	
	/**
	 * @see java.util.Collection#removeAll(java.util.Collection)
	 */
	@Override
	public boolean removeAll (final Collection <?> c) {
		return n.removeAll (c);
	}
	
	/**
	 * @see java.util.Collection#retainAll(java.util.Collection)
	 */
	@Override
	public boolean retainAll (final Collection <?> c) {
		return n.retainAll (c);
	}
	
	/**
	 * @see java.util.Collection#size()
	 */
	@Override
	public int size () {
		return n.size ();
	}
	
	/**
	 * @see java.util.Collection#toArray()
	 */
	@Override
	public Object [] toArray () {
		return n.toArray ();
	}
	
	/**
	 * @see java.util.Collection#toArray(T[])
	 */
	@Override
	public <T> T [] toArray (final T [] a) {
		return n.toArray (a);
	}
	
	/**
	 * @see org.starhope.appius.util.CastsToJSON#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject jso = new JSONObject ();
		int i = 0;
		for (final NotificationReplyVerb verb : n) {
			try {
				jso.put (String.valueOf (i++ ), verb.toJSON ());
			} catch (final JSONException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a JSONException in NotificationReplyVerbSet.toJSON ",
								e);
			}
		}
		return jso;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder s = new StringBuilder ();
		s.append ("[");
		final Iterator <NotificationReplyVerb> i = n.iterator ();
		while (i.hasNext ()) {
			s.append (i.next ().toString ());
			if (i.hasNext ()) {
				s.append (", ");
			}
		}
		s.append ("]");
		return s.toString ();
	}
	
}
