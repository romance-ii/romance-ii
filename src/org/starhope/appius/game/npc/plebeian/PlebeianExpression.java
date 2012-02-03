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
package org.starhope.appius.game.npc.plebeian;

import java.util.Queue;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Room;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.events.Action;
import org.starhope.appius.user.events.ActionHandler;
import org.starhope.appius.user.events.ActionHandlerInterface;
import org.starhope.appius.user.events.ActionMethod;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class PlebeianExpression {

	/**
	 * WRITEME: Document this type.
	 * 
	 * @author brpocock@star-hope.org
	 */
	private final class HackSetToActionRunner implements ActionMethod {
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final ScriptRunner scriptRunner;

		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param newRunner WRITEME
		 */
		HackSetToActionRunner (final ScriptRunner newRunner) {
			scriptRunner = newRunner;
		}

		/**
		 * @see org.starhope.appius.user.events.ActionMethod#acceptAction(org.starhope.appius.game.Room,
		 *      org.starhope.appius.user.AbstractUser, java.lang.String,
		 *      org.starhope.appius.user.AbstractUser, java.lang.String,
		 *      java.lang.Object[])
		 */
		@Override
		public boolean acceptAction (final Room where,
				final AbstractUser subject, final String verb,
				final AbstractUser object, final String indirectObject,
				final Object... trailer) {
			scriptRunner.dispatch (new Action (where, subject, verb,
					object, indirectObject, trailer));
			return false;
		}

		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return "Set->Action adaptor for "
			+ PlebeianExpression.this.toString ();
		}
	}

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final PlebeianScript myOutcome;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final String myState;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final PlebeianTestClause myTest;
	/**
	 * the user owning this script (for “Myself” and “Here” references)
	 */
	private final AbstractUser myUser;

	/**
	 * construct a new Plebeian script expression
	 * 
	 * @param testState the state in which the script could be run
	 * @param test the condition in which the script would be run
	 * @param outcome the script to run if the condition is met in the
	 *            correct state
	 * @param user the victim of the script
	 */
	public PlebeianExpression (final String testState,
			final PlebeianTestClause test,
			final PlebeianScript outcome, final AbstractUser user) {
		myState = testState;
		myTest = test;
		myOutcome = outcome;
		myUser = user;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param a WRITEME
	 * @return WRITEME
	 */
	public Queue <Runnable> accept (final Action a) {
		if (myTest.matches (a, myUser)) return myOutcome.getSteps ();
		return null;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public String getState () {
		return myState;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param scriptRunner WRITEME
	 * @return WRITEME
	 */
	public ActionHandlerInterface handler (
			final ScriptRunner scriptRunner) {
		final String locative = myTest.getLocative ();
		Room room;
		try {
			room = null == locative ? null : scriptRunner.getPuppet ()
					.getZone ().getRoomByName (locative);
		} catch (final NotFoundException e) {
			throw AppiusClaudiusCaecus
			.fatalBug (
					"Caught a NotFoundException in PlebeianExpression.handler ",
					e);
		}
		final String nominative = myTest.getNominative ();
		final AbstractUser subject = null == nominative ? null : Nomenclator
				.getUserByLogin (nominative);
		final String accusative = myTest.getAccusative ();
		final AbstractUser object = null == accusative ? null : Nomenclator
				.getUserByLogin (accusative);
		return new ActionHandler (room, subject, myTest.getVerb (),
				object, myTest.getDative (), new HackSetToActionRunner (
						scriptRunner));
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return " (Expression state=“" + myState + "”,  test="
		+ myTest.toString () + ", outcome=("
		+ myOutcome.toString () + "))";
	}

}
