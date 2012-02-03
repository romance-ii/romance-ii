/**
 * Copyright © 2010, Res Interactive, LLC. All Rights Reserved.
 */
package org.starhope.appius.messaging;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
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
	 * @param newAddress address
	 *
	 */
	public MailAddressRecord (final String newAddress) {
		super (MailAddressRecord.class);
		address = newAddress;
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
		return "$Rev: 1983 $";
	}

	/**
	 * @param newAddress the address to set
	 */
	public void setAddress (final String newAddress) {
		address = newAddress;
	}
}
