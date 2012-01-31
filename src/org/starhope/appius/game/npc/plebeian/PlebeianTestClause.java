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
 * License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.game.npc.plebeian;

import java.util.Locale;

import org.starhope.appius.game.Room;
import org.starhope.appius.user.AbstractNonPlayerCharacter;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.events.Action;

/**
 * a test clause for checking an {@link Action} against a scripted
 * proposition
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class PlebeianTestClause {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final private String accusative;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final private String dative;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final private String locative;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final private String nominative;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	final private String verb;
	
	/**
	 * construct a neutral test clause that would match anything
	 */
	public PlebeianTestClause () {
		verb = null;
		nominative = null;
		accusative = null;
		dative = null;
		locative = null;
	}
	
	/**
	 * construct a test clause with the provided stream of parameters
	 * 
	 * @param v WRITEME
	 * @param nom WRITEME
	 * @param acc WRITEME
	 * @param dat WRITEME
	 * @param loc WRITEME
	 */
	public PlebeianTestClause (final String v, final String nom,
			final String acc, final String dat, final String loc) {
		verb = v;
		nominative = nom;
		accusative = acc;
		dative = dat;
		locative = loc;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param acc WRITEME
	 * @return WRITEME
	 */
	public PlebeianTestClause addAccusativeProposition (
			final String acc) {
		return new PlebeianTestClause (verb, nominative, acc, dative,
				locative);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param dat WRITEME
	 * @return WRITEME
	 */
	public PlebeianTestClause addDativeProposition (final String dat) {
		return new PlebeianTestClause (verb, nominative, accusative,
				dat, locative);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param loc WRITEME
	 * @return WRITEME
	 */
	public PlebeianTestClause addLocativeProposition (final String loc) {
		return new PlebeianTestClause (verb, nominative, accusative,
				dative, loc);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param nom WRITEME
	 * @return WRITEME
	 */
	public PlebeianTestClause addNominativeProposition (
			final String nom) {
		return new PlebeianTestClause (verb, nom, accusative, dative,
				locative);
	}
	
	/**
	 * add a verb proposition to this test clause
	 * 
	 * @param v verb
	 * @return test clause based upon this one with the verb
	 *         proposition added
	 */
	public PlebeianTestClause addVerbProposition (final String v) {
		return new PlebeianTestClause (v, nominative, accusative,
				dative, locative);
	}
	
	/**
	 * @return the accusative
	 */
	public String getAccusative () {
		return accusative;
	}
	
	/**
	 * @return the dative
	 */
	public String getDative () {
		return dative;
	}
	
	/**
	 * @return the locative
	 */
	public String getLocative () {
		return locative;
	}
	
	/**
	 * @return the nominative
	 */
	public String getNominative () {
		return nominative;
	}
	
	/**
	 * @return the verb
	 */
	public String getVerb () {
		return verb;
	}
	
	/**
	 * determine whether this test clause matches a given action
	 * 
	 * @param a some action
	 * @param whoAmI WRITEME
	 * @return true, if the test clause matches a given action
	 */
	public boolean matches (final Action a, final AbstractUser whoAmI) {
		if ( (null != verb) && !a.getVerb ().equals (verb)) {
			return false;
		}
		final AbstractUser subject = a.getSubject ();
		if ("Myself".equals (nominative) && whoAmI.equals (subject)) {
			// OK so far…
		} else if ( (null != nominative)
				&& (null != subject)
				&& !AbstractNonPlayerCharacter
						.getNameStripped (
								subject.getAvatarLabel ())
						.toLowerCase (Locale.ENGLISH)
						.equals (nominative
								.toLowerCase (Locale.ENGLISH))) {
			return false;
		}
		final AbstractUser object = a.getObject ();
		if ("Myself".equals (accusative) && whoAmI.equals (object)) {
			// OK so far…
		} else if ( (null != accusative)
				&& (null != object)
				&& !AbstractNonPlayerCharacter
						.getNameStripped (
								object.getAvatarLabel ())
						.toLowerCase (Locale.ENGLISH)
						.equals (accusative
								.toLowerCase (Locale.ENGLISH))) {
			return false;
		}
		final Room where = a.getWhere ();
		if ("Here".equals (locative)
				&& whoAmI.getRoom ().equals (where)) {
			// OK so far…
		} else if ( (null != locative) && (null != where)
				&& !where.getName ().equals (locative)) {
			return false;
		}
		final String indirectObject = a.getIndirectObject ();
		if ( (null != dative) && (null != indirectObject)
				&& !indirectObject.equals (dative)) {
			return false;
		}
		return true;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return "(TEST: v." + verb + " nom." + nominative + " acc."
				+ accusative + " dat." + dative + " loc."
				+ locative + ")";
	}
	
}
