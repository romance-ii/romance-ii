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

import java.util.Arrays;

import org.starhope.appius.game.Room;
import org.starhope.appius.user.AbstractUser;

/**
 * An action (event) that has happened in the game (or the system) and
 * can be accepted by various event handlers. In most systems, these
 * would be called an Event, except that the existing terminology
 * conflicts.
 * 
 * @author brpocock@star-hope.org
 */
public class Action {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final private String indirectObject;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final private AbstractUser object;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final private AbstractUser subject;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final private Object [] trailer;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final private String verb;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final private Room where;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param someSubject WRITEME
	 * @param someVerb WRITEME
	 * @param someObject WRITEME
	 * @param optionalTrailer WRITEME
	 */
	public Action (final AbstractUser someSubject,
			final String someVerb, final AbstractUser someObject,

			final Object ... optionalTrailer)
	{
		where = null;
		subject = someSubject;
		verb = someVerb;
		object = someObject;
		indirectObject = null;
		trailer = optionalTrailer;
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param someSubject WRITEME
	 * @param someVerb WRITEME
	 * @param someObject WRITEME
	 * @param someIndirectObject WRITEME
	 * @param optionalTrailer WRITEME
	 */
	public Action (final AbstractUser someSubject,
			final String someVerb, final AbstractUser someObject,
			final String someIndirectObject,
			final Object ... optionalTrailer)
	{
		where = null;
		subject = someSubject;
		verb = someVerb;
		object = someObject;
		indirectObject = someIndirectObject;
		trailer = optionalTrailer;
	}

	/**
	 * Create a new Action with only a subject, verb, and optional
	 * trailer records
	 * 
	 * @param someSubject subject
	 * @param someVerb verb
	 * @param optionalTrailer optional trailer
	 */
	public Action (final AbstractUser someSubject,
			final String someVerb, final Object ... optionalTrailer)
	{
		where = null;
		subject = someSubject;
		verb = someVerb;
		object = null;
		indirectObject = null;
		trailer = optionalTrailer;
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param someSubject WRITEME
	 * @param someVerb WRITEME
	 * @param someIndirectObject WRITEME
	 * @param optionalTrailer WRITEME
	 */
	public Action (final AbstractUser someSubject,
			final String someVerb, final String someIndirectObject,
			final Object ... optionalTrailer)
	{
		where = null;
		subject = someSubject;
		verb = someVerb;
		object = null;
		indirectObject = someIndirectObject;
		trailer = optionalTrailer;
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param somewhere WRITEME
	 * @param someSubject WRITEME
	 * @param someVerb WRITEME
	 * @param someObject WRITEME
	 * @param optionalTrailer WRITEME
	 */
	public Action (final Room somewhere,
			final AbstractUser someSubject, final String someVerb,
			final AbstractUser someObject,

			final Object ... optionalTrailer)
	{
		where = somewhere;
		subject = someSubject;
		verb = someVerb;
		object = someObject;
		indirectObject = null;
		trailer = optionalTrailer;
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param somewhere WRITEME
	 * @param someSubject WRITEME
	 * @param someVerb WRITEME
	 * @param someObject WRITEME
	 * @param someIndirectObject WRITEME
	 * @param optionalTrailer WRITEME
	 */
	public Action (final Room somewhere,
			final AbstractUser someSubject, final String someVerb,
			final AbstractUser someObject,
			final String someIndirectObject,
			final Object ... optionalTrailer)
	{
		where = somewhere;
		subject = someSubject;
		verb = someVerb;
		object = someObject;
		indirectObject = someIndirectObject;
		trailer = optionalTrailer;
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * @param newWhere WRITEME
	 * @param newSubject WRITEME
	 * @param newVerb WRITEME
	 * @param newTrailer WRITEME
	 *
	 */
	public Action (final Room newWhere, final AbstractUser newSubject, final String newVerb,
			final Object... newTrailer) {
		where=newWhere; subject=newSubject;verb=newVerb;trailer=newTrailer;
		object=null;indirectObject=null;
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param somewhere WRITEME
	 * @param someSubject WRITEME
	 * @param someVerb WRITEME
	 * @param someIndirectObject WRITEME
	 * @param optionalTrailer WRITEME
	 */
	public Action (final Room somewhere,
			final AbstractUser someSubject, final String someVerb,
			final String someIndirectObject,
			final Object ... optionalTrailer)
	{
		where = somewhere;
		subject = someSubject;
		verb = someVerb;
		object = null;
		indirectObject = someIndirectObject;
		trailer = optionalTrailer;
	}

	/**
	 * an Action with just a bare verb
	 * 
	 * @param justAVerb just a verb
	 */
	public Action (final String justAVerb) {
		verb = justAVerb;
		where = null;
		subject = null;
		object = null;
		indirectObject = null;
		trailer = null;
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param v verb
	 * @param dative indirect object
	 */
	public Action (final String v, final String dative) {
		verb = v;
		indirectObject = dative;
		where = null;
		object = null;
		subject = null;
		trailer = null;
	}

	/**
	 * @return the indirectObject
	 */
	public String getIndirectObject () {
		return indirectObject;
	}

	/**
	 * @return the object
	 */
	public AbstractUser getObject () {
		return object;
	}

	/**
	 * @return the subject
	 */
	public AbstractUser getSubject () {
		return subject;
	}

	/**
	 * @return (a copy of) the trailer
	 */
	public Object [] getTrailer () {
		return Arrays.copyOf (trailer, trailer.length);
	}

	/**
	 * Get an item from the trailer, if it exists, or a “null” if not.
	 *
	 * @param n the index into the trailer records
	 * @return the object from the trailer, or a “null”
	 */
	public Object getTrailer (final int n) {
		if (trailer.length > n) {
			return trailer [n];
		}
		return null;
	}

	/**
	 * Get a string from the trailer, if it exists, or a zero-length
	 * string, if not.
	 *
	 * @param n the index into the trailer records
	 * @return the object from the trailer, if it exists, and is a
	 *         string; else, a zero-length string ("")
	 */
	public String getTrailerString (final int n) {
		if (trailer.length > n) {
			if (trailer [n] instanceof String) {
				return (String) trailer [n];
			}
		}
		return "";
	}

	/**
	 * @return the verb
	 */
	public String getVerb () {
		return verb;
	}

	/**
	 * @return the where
	 */
	public Room getWhere () {
		return where;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public void log () {
		final StringBuilder logEntry = new StringBuilder ();
		logEntry.append ("Quaestor.action | ");
		logEntry.append (toString ());
		System.out.println (logEntry.toString ());
		System.out.flush ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	@Override
	public String toString () {
		StringBuilder s = new StringBuilder ();
		s
		.append ( (null == where ? "Ø" : where.getDebugName ()));
		s.append (" | ");
		s.append ( (null == subject ? "Ø" : subject
				.getDebugName ()));
		s.append (" | ");
		final StringBuilder predicate = new StringBuilder ();
		predicate.append ( (null == verb ? "Ø" : verb));
		predicate.append (" | ");
		predicate.append ( (null == object ? "Ø" : object
				.getDebugName ()));
		predicate.append (" | ");
		predicate.append ( (null == indirectObject ? "Ø"
				: indirectObject));
		predicate.append (" | trailer × ");
		predicate.append (null == trailer ? 0 : trailer.length);
		s.append (predicate);
		return s.toString ();
	}
}
