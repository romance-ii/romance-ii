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
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.mb.fields;

import org.starhope.appius.mb.MBErrorReason;
import org.starhope.appius.mb.MBSession;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.User;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class MBField_LoginRequest extends MBField_String {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 8165313610825442687L;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param mySession
	 * @param myIdent
	 */
	public MBField_LoginRequest (final MBSession mySession,
			final MBFieldIdent myIdent) {
		super (mySession, myIdent);
		// TODO Auto-generated constructor stub brpocock@star-hope.org
	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField#check()
	 */
	@Override
	public void check () {
		super.check ();
		
		if (null == value) {
			return;
		}
		
		if (value.length () < User.MIN_LOGIN_LENGTH) {
			session.add (ident, MBErrorReason.TOO_SHORT);
		}
		
		if (value.length () > User.MAX_LOGIN_LENGTH) {
			session.add (ident, MBErrorReason.TOO_LONG);
		}

		if ( !Nomenclator.isLoginAvailable (value)) {
			session.add (ident, MBErrorReason.ALREADY_USED);
		}

		if (Nomenclator.isLoginForbidden (value)) {
			session.add (ident, MBErrorReason.FORMAT);
		}
	}

}
