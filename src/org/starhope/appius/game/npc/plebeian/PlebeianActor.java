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

import org.starhope.appius.user.events.Action;
import org.starhope.appius.user.events.Quaestor;

/**
 * <p>
 * When an {@link Action} fires through a {@link Quaestor}, there are
 * two or three users who can be involved in that Action: the subject,
 * the object, and the user embodying the listener. (Any or all of the
 * three can be null, however.)
 * </p>
 * <p>
 * This is an enumeration which embodies these three actors, used in
 * {@link ScriptRunner} mostly (e.g. {@link PlebeianScriptRunner} )
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
public enum PlebeianActor {
	/**
	 * The Subject of the Action
	 */
	Subject, /**
	 * The Object of the Action
	 */
	Object, /**
	 * The observer who is listening for an Action
	 */
	Myself
}
