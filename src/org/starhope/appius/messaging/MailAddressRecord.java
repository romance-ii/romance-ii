/**
 * <p> Copyright © 2012, Bruce-Robert Pocock</p><p> Copyright © 2010, Res Interactive, LLC. </p> <p>     This program is free software: you can redistribute it and/or modify
*        it under the terms of the GNU Affero General Public License as
 *           published by the Free Software Foundation, either version 3 of the
  *              License, or (at your option) any later version.</p><p>
   *                 This program is distributed in the hope that it will be useful,
    *                    but WITHOUT ANY WARRANTY; without even the implied warranty of
     *                       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      *                          GNU Affero General Public License for more details.
*</p><p>                                
 *                                   You should have received a copy of the GNU Affero General Public License
  *                                      along with this program.  If not, see <http://www.gnu.org/licenses/>.</p>
 */
package org.starhope.appius.messaging;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class MailAddressRecord extends
		SimpleDataRecord <MailAddressRecord> {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -9055209338618445113L;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String address;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param newAddress address
	 */
	public MailAddressRecord (final String newAddress) {
		super (MailAddressRecord.class);
		address = newAddress;
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof MailAddressRecord)) {
			return false;
		}
		final MailAddressRecord other = (MailAddressRecord) obj;
		if (address == null) {
			if (other.address != null) {
				return false;
			}
		} else if ( !address.equals (other.address)) {
			return false;
		}
		return true;
	}
	
	/**
	 * @return the address
	 */
	public String getAddress () {
		return address; /* brpocock@star-hope.org */
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		throw new NotFoundException ("no ID");
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () {
		return address;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2262 $";
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result)
				+ (address == null ? 0 : address.hashCode ());
		return result;
	}
	
	/**
	 * @param newAddress the address to set
	 */
	public void setAddress (final String newAddress) {
		address = newAddress;
	}
}
