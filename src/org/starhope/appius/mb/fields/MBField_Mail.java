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

import org.starhope.appius.mb.MBSession;
import org.starhope.appius.messaging.Mail;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class MBField_Mail extends MBField_String {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 2608036293725288813L;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param mySession WRITEME
	 * @param myIdent WRITEME
	 */
	public MBField_Mail (final MBSession mySession,
			final MBFieldIdent myIdent) {
		super (mySession, myIdent);
	}
	
	/**
	 * @see org.starhope.appius.mb.fields.MBField_String#checkValue(java.lang.String)
	 */
	@Override
	protected boolean checkValue (final String newValue) {
		try {
			Mail.validateMail (newValue);
		} catch (final Exception e) {
			return false;
		}
		return true;
	}
	
}
