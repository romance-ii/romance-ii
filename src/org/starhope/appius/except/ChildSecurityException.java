/**
 * <p>
 * Copyright © 2010, Timothy Heys
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
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.except;

/**
 * Child security exception … WRITEME twheys@gmail.com
 * 
 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
 */
public class ChildSecurityException extends Exception {

	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -751452585358243489L;

	/**
	 * Reason for exception
	 */
	private final String myReason;

	/**
	 * @param reason reason for exception
	 */
	public ChildSecurityException (final String reason) {
		myReason = reason;
	}

	/**
	 * @see java.lang.Throwable#toString()
	 */
	@Override
	public String toString () {
		return myReason + "; " + super.toString ();
	}

}

