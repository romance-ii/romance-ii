/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.mb.fields;

import java.io.Serializable;

import org.starhope.appius.except.DataException;
import org.starhope.appius.mb.MBErrorReason;
import org.starhope.appius.mb.MBSession;

/**
 * An abstract type for user-provided data fields, used extensively in
 * {@link MBSession}
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @param <T> the actual type of values for this field
 */
public abstract class MBField <T> implements Serializable {
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (MBField.class);
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 5153396735288451843L;
	
	/**
	 * {@link #getIdent()}
	 */
	protected final MBFieldIdent ident;
	
	/**
	 * The session owning this field
	 */
	protected final MBSession session;
	
	/**
	 * The actual value in the field.
	 */
	protected T value = null;
	
	/**
	 * Constructor for implementing child classes
	 * 
	 * @param mySession the session associated with this field
	 * @param myIdent the field identity represented by this field
	 */
	protected MBField (final MBSession mySession,
			final MBFieldIdent myIdent) {
		session = mySession;
		ident = myIdent;
	}
	
	/**
	 * Check this field's current value, setting any necessary session
	 * error flags.
	 */
	public void check () {
		if (null == value) {
			session.add (ident, MBErrorReason.BLANK);
		} else if ( !checkValue (value)) {
			session.add (ident, MBErrorReason.INCORRECT);
		}
	}
	
	/**
	 * @param newValue a value asking to be set into this field
	 * @return true, if the value is OK
	 */
	protected abstract boolean checkValue (T newValue);
	
	/**
	 * Sets the field's value to null, even if
	 * {@link #checkValue(Object)} does not accept null as a valid
	 * value.
	 */
	public void clear () {
		value = null;
	}
	
	/**
	 * Attempt to convert a value of unknown type ({@link Object}) into
	 * the type contained by this field. Does not make any changes to
	 * the field's actual value. Used internally by
	 * {@link #setValueConverted(Object)}, but can be called directly.
	 * 
	 * @param newValue Something which might be an alternate
	 *             representation of <T>
	 * @return A value of type <T>
	 * @throws DataException if the input cannot be converted
	 */
	public abstract T convert (Object newValue) throws DataException;
	
	// public com.google.gwt.dom.client.Element getEditHTML (
	// final Document doc) {
	// final com.google.gwt.dom.client.Element box = doc
	// .createElement ("label");
	// final com.google.gwt.dom.client.Element input = doc
	// .createTextInputElement ();
	// input.setAttribute ("type", "text");
	// input.setAttribute ("value", getValue ().toString ());
	// final String name = "MBField_" + getIdent ().name ();
	// input.setAttribute ("id", name);
	// input.setAttribute ("name", name);
	// box.appendChild (doc.createTextNode (getIdent ().getName ()
	// + ":" + (char) 0xa0));
	// box.appendChild (input);
	// return box;
	// }
	
	/**
	 * @return the {@link MBFieldIdent} representing this field
	 */
	public MBFieldIdent getIdent () {
		return ident;
	}
	
	/**
	 * @return the current value of the field (which can be null)
	 */
	public T getValue () {
		return value;
	}
	
	/**
	 * Set the value, only if it passes {@link #checkValue(Object)}
	 * test for validity.
	 * 
	 * @param newValue the new value
	 * @return the actual value, regardless as to whether it changed
	 */
	public T setValue (final T newValue) {
		final boolean check = checkValue (newValue);
		if (check) {
			value = newValue;
		}
		return value;
	}
	
	/**
	 * Set the value of this field, only if the two values provided
	 * match. Used for double-entry confirmation fields like setting
	 * passwords and eMail addresses and such.
	 * 
	 * @param newValue One copy of the requested value
	 * @param confirmValue Another copy, which must match, or nothing
	 *             will happen.
	 * @return The actual resultant value, as per {@link #getValue()},
	 *         regardless as to whether it changed
	 */
	public T setValue (final T newValue, final T confirmValue) {
		if ( (null == newValue) || (null == confirmValue)) {
			if ( (null == newValue) && (null == confirmValue)) {
				return setValue ((T) null);
			}
		}
		if ( (null != newValue) && newValue.equals (confirmValue)) {
			return setValue (newValue);
		}
		
		session.add (ident, MBErrorReason.CONFIRM);
		return getValue ();
	}
	
	/**
	 * Note, this routine does not return any exceptions that might be
	 * thrown in an attempt to convert the input into the local type
	 * <T>
	 * 
	 * @param newValue An object that may be able to be converted into
	 *             the new value
	 * @return the actual value resulting, whether or not it has been
	 *         changed.
	 */
	public T setValueConverted (final Object newValue) {
		try {
			final T converted = convert (newValue);
			return setValue (converted);
		} catch (final DataException e) {
			MBField.log.debug ("Input error: " + ident.toString ()
					+ " " + e.getMessage ());
			return value;
		}
	}
	
	/**
	 * Set the value, only if we don't already have one. Used
	 * for “casual population of fields,” e.g. accepting input from a
	 * cookie
	 * 
	 * @param newValue the new value to set, only if the current value
	 *             is null
	 * @return The value resulting, as from {@link #getValue()},
	 *         regardless of the action taken; mostly provided for
	 *         convenience in chaining
	 */
	public T setValueIfNull (final T newValue) {
		if (null == value) {
			return setValue (newValue);
		}
		return value;
	}
	
	/**
	 * Write out an editing widget for this control to the servlet's
	 * page context given.
	 * 
	 * @param context the {@link PageContext} of the servlet, into
	 *             which to write.
	 * @throws IOException if the output stream argues
	 */
	// public void writeEditForServlet (final PageContext context)
	// throws IOException {
	// if (context.getResponse ().getContentType ().contains ("html"))
	// {
	// context.getResponse ()
	// .getOutputStream ()
	// .write (getEditHTML (session.getDocument ())
	// .toString ().getBytes ());
	// } else {
	// log.error
	// ("Unimplemented: non-HTML output");
	// }
	// }
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return session.toString () + "f:" + ident.toString () + "="
				+ (null == value ? "(null)" : value.toString ());
	}
	
}
