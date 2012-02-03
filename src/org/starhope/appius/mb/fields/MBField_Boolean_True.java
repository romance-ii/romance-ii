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

import org.starhope.appius.mb.MBSession;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class MBField_Boolean_True extends MBField_Boolean {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -3353436029228667347L;

	/**
	 * @param mySession session owning this field
	 * @param newIdent identity of the field
	 */
	public MBField_Boolean_True (final MBSession mySession,
			final MBFieldIdent newIdent) {
		super (mySession, newIdent);
	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField_Boolean#checkValue(java.lang.Boolean)
	 */
	@Override
	protected boolean checkValue (final Boolean newValue) {
		return null != newValue
				&& newValue.booleanValue () == true;
	}

}
