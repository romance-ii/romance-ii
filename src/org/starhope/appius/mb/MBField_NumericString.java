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

import org.starhope.appius.mb.fields.MBFieldIdent;
import org.starhope.appius.mb.fields.MBField_String;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class MBField_NumericString extends MBField_String {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 5101722040449014704L;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final int maxDigits;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final int minDigits;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param mySession WRITEME
	 * @param myIdent WRITEME
	 * @param leastDigits WRITEME
	 * @param mostDigits WRITEME
	 */
	public MBField_NumericString (final MBSession mySession,
			final MBFieldIdent myIdent, final int leastDigits,
			final int mostDigits) {
		super (mySession, myIdent);
		minDigits = leastDigits;
		maxDigits = mostDigits;
	}
	
	/**
	 * @see org.starhope.appius.mb.fields.MBField#checkValue(java.lang.Object)
	 */
	@Override
	protected boolean checkValue (final String newValue) {
		return super.checkValue (newValue)
				&& (newValue.length () >= minDigits)
				&& (newValue.length () <= maxDigits)
				&& !newValue.matches ("[^0-9]");
	}
	
}
