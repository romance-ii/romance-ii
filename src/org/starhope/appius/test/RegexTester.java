/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Timothy W. Heys
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

import java.util.Scanner;
import java.util.regex.Pattern;

/**
 * WRITEME: Document this type. twheys@gmail.com Jan 15, 2010
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys Timothy W. Heys
 */
public class RegexTester {
	
	/**
	 * Enter a pattern to test
	 */
	static Pattern pattern;
	
	/**
	 * WRITEME: Document this field. twheys@gmail.com Jan 15, 2010
	 */
	private static final String regex = "^[a-zA-Z\\.,!\\?\\\"\\\' -]*$";
	
	/**
     *
     */
	private static Scanner scan = new Scanner (System.in);
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 15, 2010
	 * </pre>
	 * 
	 * TO main WRITEME...
	 * 
	 * @param args WRITEME
	 */
	public static void main (final String args[]) {
		RegexTester.pattern = Pattern.compile (RegexTester.regex);
		String input = "";
		while (true) {
			System.out.println ("Enter a string to match the pattern");
			input = RegexTester.scan.nextLine ();
			if (RegexTester.pattern.matcher (input).matches ()) {
				System.out.println (input + " matches "
						+ RegexTester.regex);
			} else {
				System.out.println (input + " does not match "
						+ RegexTester.regex);
			}
		}
	}
}
