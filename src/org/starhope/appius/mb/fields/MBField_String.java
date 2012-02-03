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

import org.starhope.appius.except.DataException;
import org.starhope.appius.mb.MBSession;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class MBField_String extends MBField <String> {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 2103856421525316561L;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param mySession
	 * @param myIdent
	 */
	public MBField_String (final MBSession mySession, final MBFieldIdent myIdent) {
		super (mySession, myIdent);
	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField#checkValue(java.lang.Object)
	 */
	@Override
	protected boolean checkValue (final String newValue) {
		return null != newValue;
	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField#convert(java.lang.Object)
	 */
	@Override
	public String convert (final Object newValue) throws DataException {
		if (null == newValue) {
			throw new DataException ("Null");
		}
		return newValue.toString ();
	}

}
