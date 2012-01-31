/**
 * <h1>TestRetrieveMail</h1>
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2009-2010, Res Interactive, LLC.
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 */

package org.starhope.appius.test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import javax.servlet.jsp.JspWriter;

import org.starhope.appius.game.BugReporter;
import org.starhope.appius.user.Nomenclator;

/**
 * WRITEME
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 */
public class TestRetrieveMail {
	/**
	 * @param out WRITEME
	 */
	public static void getMailFromFile (final JspWriter out) {
		System.out.println ("Running");
		final File input = new File ("/etc/appius/newUsers.txt");
		BufferedReader reader = null;
		try {
			reader = new BufferedReader (new FileReader (input));
			System.out.println ("Trying");
			
			String line = null;
			
			while (null != (line = reader.readLine ())) {
				System.out.println ("Looping");
				final int id = Integer.parseInt (line.trim ());
				final String mail = Nomenclator.getUserByID (id)
						.getResponsibleMail ();
				if (null != mail) {
					out.println (mail + "\n");
				}
			}
			reader.close ();
			reader = null;
			
		} catch (final FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace ();
		} catch (final IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace ();
		} finally {
			try {
				if (null != reader) {
					reader.close ();
					reader = null;
				}
			} catch (final IOException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a IOException in getMailFromFile",
								e);
			}
		}
		System.out.println ("Ending");
		
	}
}
