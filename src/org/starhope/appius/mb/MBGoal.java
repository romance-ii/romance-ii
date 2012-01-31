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
package org.starhope.appius.mb;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public enum MBGoal {
	/**
	 * User wants to change their password (as a player)
	 */
	CHANGE_PASSWORD, CHOOSE_ACCOUNT_TO_PAY,
	/**
	 * User wants to log in (as a parent)
	 */
	LOG_IN_AS_PARENT,
	/**
	 * User wants to log in themself (as a player)
	 */
	LOG_IN_SELF, MY_ACCOUNT,
	/**
	 * User wants to pay for a membership enrolment
	 */
	PAY_ACCOUNT, PLAY_NOW, /**
	 * User wants to register themself as a
	 * parent
	 */
	REGISTER_SELF_PARENT, /**
	 * User wants to register a new account for
	 * themself or their child
	 */
	REGISTER_USER, SET_RESPONSIBLE_MAIL
}
