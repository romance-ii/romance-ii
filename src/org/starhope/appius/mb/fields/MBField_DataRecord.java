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
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.mb.MBSession;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.DataRecord;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class MBField_DataRecord <T extends DataRecord> extends
		MBField <T> {


	private final Class <T> klass;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -3415651421700102142L;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param myKlass
	 * @param mySession
	 * @param myIdent
	 */
	public MBField_DataRecord (final Class <T> myKlass,
			final MBSession mySession, final MBFieldIdent myIdent) {
		super (mySession, myIdent);
		klass = myKlass;
	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField#checkValue(java.lang.Object)
	 */
	@Override
	protected boolean checkValue (final T newValue) {
		return null != newValue;

	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField#convert(java.lang.Object)
	 */
	@Override
	public T convert (final Object newValue) throws DataException {
		if (newValue instanceof String) {
			try {
				return Nomenclator.getDataRecord (klass,
						(String) newValue);
			} catch (NotFoundException e) {
				throw new DataException (e.toString ());
			}
		}
		if (newValue instanceof Integer) {
			try {
				return Nomenclator.getDataRecord (klass,
						((Integer) newValue).intValue ());
			} catch (NotFoundException e) {
				throw new DataException (e.toString ());
			}
		}
		throw new DataException (newValue.toString ());
	}

}
