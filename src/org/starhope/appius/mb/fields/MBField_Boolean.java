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
 * A simple, boolean field.
 * 
 * @author brpocock@star-hope.org
 */
public class MBField_Boolean extends MBField <Boolean> {

	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 4968117149602818108L;

	/**
	 * @param mySession Session to own this field
	 * @param newIdent Field's identity
	 */
	public MBField_Boolean (final MBSession mySession,
			final MBFieldIdent newIdent) {
		super (mySession, newIdent);
	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField#check()
	 */
	@Override
	public void check () {
		return;
	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField#checkValue(java.lang.Object)
	 */
	@Override
	protected boolean checkValue (final Boolean newValue) {
		return true;
	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField#convert(java.lang.Object)
	 */
	@Override
	public Boolean convert (final Object newValue) throws DataException {
		if (null == newValue) {
			return Boolean.FALSE;
		}
		if (newValue instanceof Boolean) {
			return (Boolean) newValue;
		}
		if (newValue instanceof String) {
			return Boolean.valueOf ((String) newValue);
		}
		if (newValue instanceof Integer) {
			if ( ((Integer)newValue).intValue () == 0) {
				return Boolean.FALSE;
			}
			return Boolean.TRUE;
		}
		return convert (newValue.toString ());
	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField#getValue()
	 */
	@Override
	public Boolean getValue () {
		if (null==value) {
			return Boolean.FALSE;
		}
		return super.getValue ();
	}

}
