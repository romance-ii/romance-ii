/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
 * </p>
 * <p>
 * Based upon public domain sample code provided by Authorize.net
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
 * License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */

package org.starhope.appius.pay.util;

/**
 * This is based upon the following codes enumerated by Authorize.Net.
 * (Future gateways may add other codes or reuse existing codes for
 * conformity.)
 * <p>
 * A = Address (Street) matches, ZIP does not
 * </p>
 * <p>
 * B = Address information not provided for AVS check
 * </p>
 * <p>
 * TODO: Case "C" Response.Write
 * "Street address and Postal Code not verified for international transaction due to incompatible formats. (Acquirer sent both street address and Postal Code.)"
 * Case "D" Response.Write
 * "International Transaction:  Street address and Postal Code match."
 * </p>
 * <p>
 * E = AVS error
 * </p>
 * <p>
 * G = Non-U.S. Card Issuing Bank
 * </p>
 * <p>
 * N = No Match on Address (Street) or ZIP
 * </p>
 * <p>
 * P = AVS not applicable for this transaction
 * </p>
 * <p>
 * R = Retry – System unavailable or timed out
 * </p>
 * <p>
 * S = Service not supported by issuer
 * </p>
 * <p>
 * U = Address information is unavailable
 * </p>
 * <p>
 * W = Nine digit ZIP matches, Address (Street) does not
 * </p>
 * <p>
 * X = Address (Street) and nine digit ZIP match
 * </p>
 * <p>
 * Y = Address (Street) and five digit ZIP match
 * </p>
 * <p>
 * Z = Five digit ZIP matches, Address (Street) does not
 * </p>
 * <p>
 * TODO: Copy the documentation and codes from here (the class Javadocs)
 * into the individual Javadoc comments for each enumerated value.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public enum AddressVerificationCode {
	
	/**
	 * WRITEME
	 */
	ADDRESS_AND_ZIP_MISMATCH,
	/**
	 * WRITEME
	 */
	ADDRESS_AND_ZIP_OK,
	/**
	 * WRITEME
	 */
	ADDRESS_AND_ZIP_PLUS4_OK,
	/**
	 * WRITEME
	 */
	ADDRESS_NOT_PROVIDED,
	/**
	 * WRITEME
	 */
	ADDRESS_OK_ZIP_BAD,
	/**
	 * WRITEME
	 */
	ADDRESS_UNAVAILABLE,
	/**
	 * WRITEME
	 */
	AVS_ERROR,
	/**
	 * WRITEME
	 */
	AVS_NOT_APPLICABLE,
	/**
	 * WRITEME
	 */
	AVS_NOT_SUPPORTED_BY_BANK,
	/**
	 * WRITEME
	 */
	AVS_SYSTEM_UNAVAIL_RETRY,
	/**
	 * WRITEME
	 */
	INVALID_AVS,
	/**
	 * WRITEME
	 */
	NON_US_ADDRESS,
	/**
	 * WRITEME
	 */
	NON_US_BANK,
	/**
	 * WRITEME
	 */
	NON_US_STREET_AND_POSTAL_OK, /**
	 * WRITEME
	 */
	ZIP_OK_ADDRESS_BAD, /**
	 * WRITEME
	 */
	ZIP_PLUS4_OK_ADDRESS_BAD;
	
	/**
	 * Generate a human-presentable (end-user-visible) explanation of
	 * this status code. May be verbose, as needed.
	 * 
	 * @param avs The AddressVerificationCode to be explained
	 * @return the string explanation of that value
	 */
	public static String explain (final AddressVerificationCode avs) {
		switch (avs) {
		case ADDRESS_AND_ZIP_MISMATCH:
			return "The address and ZIP code provided are incorrect.";
		case ADDRESS_AND_ZIP_OK:
			return "The address and ZIP code provided are OK.";
		case ADDRESS_AND_ZIP_PLUS4_OK:
			return "The address and ZIP+4 code provided are OK.";
		case ADDRESS_NOT_PROVIDED:
			return "An address was not provided.";
		case ADDRESS_OK_ZIP_BAD:
			return "The address was OK, but the ZIP code was not.";
		case ADDRESS_UNAVAILABLE:
			return "Address information was not provided for verification.";
		case AVS_ERROR:
			return "Address verification system error.";
		case AVS_NOT_APPLICABLE:
			return "Address verification is not applicable to this transaction.";
		case AVS_NOT_SUPPORTED_BY_BANK:
			return "The financial institution does not support address verification service.";
		case AVS_SYSTEM_UNAVAIL_RETRY:
			return "Please retry this transaction. The financial institution reported a temporary problem with address verification, and requests that you retry the transaction without making changes.";
		case INVALID_AVS:
			return "An invalid or unrecognized code was returned during address verification.";
		case NON_US_BANK:
			return "The financial institution is outside of the US, and may not support address verification service.";
		case ZIP_OK_ADDRESS_BAD:
			return "The ZIP code provided was OK, but the address was not.";
		case ZIP_PLUS4_OK_ADDRESS_BAD:
			return "The ZIP+4 code provided was OK, but the address was not.";
		case NON_US_ADDRESS:
			return "The overseas/non-US address was not verified.";
		case NON_US_STREET_AND_POSTAL_OK:
			return "The overseas/non-US address and postal code were verified.";
		}
		return "(unknown.)";
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jul 14,
	 * 2009)
	 * 
	 * @param string WRITEME
	 * @return WRITEME
	 */
	public static Object forAuthorizeNetCode (final String string) {
		if (Math.sqrt (4) == 2) {
			throw new RuntimeException ("TODO! FIXME!"); // TODO
		}
		return null;
	}
}
