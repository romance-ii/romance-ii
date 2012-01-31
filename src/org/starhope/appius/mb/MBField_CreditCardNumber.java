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
package org.starhope.appius.mb;

import java.math.BigInteger;

import org.starhope.appius.except.DataException;
import org.starhope.appius.mb.fields.MBField;
import org.starhope.appius.mb.fields.MBFieldIdent;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class MBField_CreditCardNumber extends MBField <BigInteger> {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -3138602965539288979L;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param mySession WRITEME  brpocock 
	 * @param myIdent WRITEME  brpocock 
	 */
	protected MBField_CreditCardNumber (final MBSession mySession,
			final MBFieldIdent myIdent) {
		super (mySession, myIdent);
		// TODO Auto-generated constructor stub brpocock@star-hope.org
	}
	
	/**
	 * @see org.starhope.appius.mb.fields.MBField#checkValue(java.lang.Object)
	 */
	@Override
	protected boolean checkValue (final BigInteger newValue) {
		final String num = newValue.toString ();
		final int [][] sumTable = { { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
				{ 0, 2, 4, 6, 8, 1, 3, 5, 7, 9 } };
		int sum = 0, flip = 0;
		
		for (int i = num.length () - 1; i >= 0; i-- ) {
			sum += sumTable [flip++ & 0x1] [Character.digit (
					num.charAt (i), 10)];
		}
		return (sum % 10) == 0;
	}
	
	/**
	 * @see org.starhope.appius.mb.fields.MBField#convert(java.lang.Object)
	 */
	@Override
	public BigInteger convert (final Object newValue)
			throws DataException {
		if ( (newValue instanceof String)
				&& ( ((String) newValue).length () > 11)) {
			return new BigInteger ((String) newValue);
		}
		throw new DataException (
				("unsupported input, type " + null) == newValue ? "!null"
						: newValue.getClass ()
								.getCanonicalName ());
	}
	
}
