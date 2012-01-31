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

import org.starhope.appius.except.DataException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.mb.MBSession;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.Parent;
import org.starhope.appius.user.User;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class MBField_Child extends MBField <User> {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 1685986479216630491L;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param mySession WRITEME  brpocock 
	 * @param myIdent WRITEME  brpocock 
	 */
	public MBField_Child (final MBSession mySession,
			final MBFieldIdent myIdent) {
		super (mySession, myIdent);
	}
	
	/**
	 * @see org.starhope.appius.mb.fields.MBField#checkValue(java.lang.Object)
	 */
	@Override
	protected boolean checkValue (final User newValue) {
		final Parent p;
		try {
			p = session.getVisitorAsParent ();
		} catch (final NotFoundException e) {
			return false;
		}
		return newValue.getParent ().equals (p);
	}
	
	/**
	 * @see org.starhope.appius.mb.fields.MBField#convert(java.lang.Object)
	 */
	@Override
	public User convert (final Object newValue) throws DataException {
		if (newValue instanceof User) {
			return (User) newValue;
		}
		if (newValue instanceof String) {
			final AbstractUser user = Nomenclator
					.getUserByLogin ((String) newValue);
			if ( (null != user) && (user instanceof User)) {
				return (User) user;
			}
			
		}
		if (newValue instanceof Integer) {
			final AbstractUser user = Nomenclator
					.getUserByID ( ((Integer) newValue)
							.intValue ());
			if ( (null != user) && (user instanceof User)) {
				return (User) user;
			}
			
		}
		throw new DataException (newValue.toString ());
	}
	
}
