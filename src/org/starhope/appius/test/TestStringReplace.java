/**
 * <p>
 * Copyright © 2010, Tim Heys
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
 * @author twheys@gmail.com
 */

package org.starhope.appius.test;

/**
 * WRITEME: Document this type. twheys@gmail.com Feb 9, 2010
 *
 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
 *
 */
public class TestStringReplace {
	/**
	 * WRITEME: Document this method twheys@gmail.com
	 * 
	 * @param args WRITEME
	 */
	public static void main (final String args[]) {
		final String local = "testmail%%haha__haha_%haha%_";
		final String escapedLocal = local.replace ("%", "@%").replace (
				"_", "@_");
		System.out.println (local);
		System.out.println (escapedLocal);
	}
}
