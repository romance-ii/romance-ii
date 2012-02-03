/**
 * <p>
 * Copyright © 2010, brpocock@star-hope.org
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
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.test;

import java.util.LinkedList;

import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.Zone;
import org.starhope.appius.game.ZoneSpawner;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.User;
import org.starhope.appius.util.AppiusConfig;

/**
 *
 * WRITEME: The documentation for this type (UserLoadTest) is incomplete. (brpocock@star-hope.org, Mar 15, 2010)
 *
 * @author brpocock@star-hope.org
 *
 */
public class UserLoadTest extends ServerThread {

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Mar 15, 2010) serial
	 * (UserLoadTest)
	 */
	private final int serial;
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	private Zone zone;
	
	/**
	 * WRITEME
	 */
	public UserLoadTest () {
		super ("UserLoadTest/main");
		serial = -1;
	}
	
	/**
	 * WRITEME
	 * 
	 * @param n instance number
	 */
	private UserLoadTest (final int n, final Zone z) {
		super ("UserLoadTest/" + n);
		serial = n;
		zone = z;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see org.starhope.appius.net.ServerThread#checkInputStream()
	 */
	@Override
	protected synchronized void checkInputStream ()
	throws UserDeadException {
		return;
	}

	/**
	 * This is an overriding method.
	 *
	 * @see org.starhope.appius.net.ServerThread#dropSocketConnection()
	 */
	@Override
	protected synchronized void dropSocketConnection () {
		// no op
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.net.ServerThread#grabInput()
	 */
	@Override
	protected String grabInput () throws UserDeadException {
		return "{\"c\":\"speak\",\"d\":\"I want you to know / that I'm happy for you / I wish nothing but / the best for you both...\"}";
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.net.ServerThread#postLogIn(org.starhope.appius.game.Zone,
	 *      java.lang.String, org.starhope.appius.user.AbstractUser)
	 */
	@Override
	protected void postLogIn (final Zone z, final String password,
			final AbstractUser user) {
		myUser = (User) user;
		// myUser.updateCache ();

		/* Check for duplicate user in any Zone */
		kickDuplicates (myUser, password);

		setLoggedIn (true);
		myUser.setServerThread (this);
		z.add (myUser);
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Thread#run()
	 */
	@Override
	public void run () {
		if (serial == -1) {
			spawnChildren ();
			return;
		}
		tattle ("Instantiating user for load test, #"
				+ (10000 + serial));
		final AbstractUser myGuy = Nomenclator.getUserByID (10000 + serial);
		if (null == myGuy) {
			tattle ("No such user.");
			return;
		}
		tattle ("Log In processing");
		postLogIn (zone, "UserLoadTest", myGuy);
		tattle ("Joining lobby");
		final Room lobby = zone.getNextLobby ();
		myGuy.setRoom (lobby);
		while (true) {
			try {
				Thread.sleep (100);
			} catch (final InterruptedException e) {
				/* No Op */
			}
			tattle ("Speech for load test");
			myGuy
			.speak (
					lobby,
			"I want you to know / that I'm happy for you / I wish nothing but / the best for you both...");
		}
	}

	/**
	 * This is an overriding method.
	 *
	 * @see org.starhope.appius.net.ServerThread#sendLoginPacket(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	protected void sendLoginPacket (final String zoneName, final String nick,
			final String password) {
		return;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.net.ServerThread#sendRawMessageLater(java.lang.String)
	 */
	@Override
	protected void sendRawMessageLater (
			final AbstractDatagram reply)
	throws UserDeadException {
		return;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.net.ServerThread#sendRawMessageNow(java.lang.String)
	 */
	@Override
	protected synchronized void sendRawMessageNow (
			final AbstractDatagram reply)
	throws UserDeadException {

		return;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Mar 15, 2010)
	 *
	 */
	private void spawnChildren () {
		for (int n = 0; n < AppiusConfig.getIntOrDefault (
				"org.starhope.appius.test.loadUsers", 2000); ++n) {
			tattle ("Instantiating UserLoadTest/" + n);
			Zone z =
				AppiusClaudiusCaecus.getAllZones ().get (0);
			ZoneSpawner.checkZonesForSpawn ();
			z = null;
			while (null == z) {
				final LinkedList <Zone> zones =
					AppiusClaudiusCaecus.getAllZones ();
				final int zNum =
					AppiusConfig
					.getRandomInt (0,
							zones.size () - 1);
				tattle ("Looking for a zone: let's try #" + zNum);
				z =
					zones.get (zNum);
				if (null != z && z.getName ().startsWith ("$")) {
					z = null;
				}
			}
			tattle ("Choosing a zone for load test " + n
					+ ", got “" + z.getName () + "“");
			final UserLoadTest t = new UserLoadTest (n, z);
			tattle ("Starting UserLoadTest/" + n);
			t.start ();
			try {
				Thread.sleep (100);
			} catch (final InterruptedException e) {
				AppiusClaudiusCaecus.reportBug (
						"Caught a InterruptedException in run", e);
			}
		}
		tattle ("Done creating load users.");
		return;
	}

}
