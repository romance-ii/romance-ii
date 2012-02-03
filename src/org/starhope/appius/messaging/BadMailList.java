/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
 * </p>
 * <p>
 * Based upon public domain sample code provided by Authorize.net
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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.messaging;

import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecordSet;

/**
 * @author brpocock@star-hope.org
 */
public class BadMailList extends
		SimpleDataRecordSet <BadMailRecord, BadMailList> {

	/**
	 *  Java serialization unique ID
	 */
	private static final long serialVersionUID = 4116058706799325467L;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param loader the record loader
	 */
	protected BadMailList (
			final RecordLoader <SimpleDataRecordSet <BadMailRecord, BadMailList>> loader) {
		super (loader);
	}

	/*
	 * Ban an eMail address from being used for a certain amount of
	 * time. This will also close any User accounts which are associated
	 * with it.
	 */


	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () {
		return 1;
	}



	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () {
		return "The Bad Mail List";
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}

	/**
	 * @param mail The eMail address to be tested
	 * @return true, if the eMail address is on the bad mail list and
	 *         not yet expired from it.
	 */
	public boolean isBad (final String mail) {
		if (contains (mail)) {
			//			FIXME!
			//			if (badMail.get (mail).compareTo (now) <= 0) {
			//				badMail.remove (mail);
			//				return false;
			//			}
			return true;
		}
		return false;
	}


}
