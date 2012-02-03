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
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.MBSession;
import org.starhope.appius.mb.Payment;
import org.starhope.appius.user.Nomenclator;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 */
public class MBField_Payment extends MBField <Payment> {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 1952450376542034101L;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param mySession
	 * @param myIdent
	 */
	public MBField_Payment (final MBSession mySession,
			final MBFieldIdent myIdent) {
		super (mySession, myIdent);
	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField#checkValue(java.lang.Object)
	 */
	@Override
	protected boolean checkValue (final Payment newValue) {
		return null != newValue;
	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField#convert(java.lang.Object)
	 */
	@Override
	public Payment convert (final Object newValue) throws DataException {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented MBField_Payment::convert (brpocock@star-hope.org, Oct 13, 2010)");
		return null;
	}

	/**
	 * @see org.starhope.appius.mb.fields.MBField#getValue()
	 */
	@Override
	public Payment getValue () {
		if (null == value) {
			try {
				value = Nomenclator.makeSQLPeer (Payment.class);
			} catch (NotReadyException e) {
				throw AppiusClaudiusCaecus.fatalBug (e);
			}
		}
		return super.getValue ();
	}

}
