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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class UnsupportedCredentialException extends Exception {
	
	/**
	 * serialVersionUID (long)
	 */
	private static final long serialVersionUID = -6011680212811283881L;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 20,
	 * 2009) credentialType (UnsupportedCredentialException)
	 */
	private final CredentialType credentialType;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 20,
	 * 2009) gateway (UnsupportedCredentialException)
	 */
	private final Class <? extends PaymentGatewayReal> gateway;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 20,
	 * 2009) message (UnsupportedCredentialException)
	 */
	private final String message;
	
	/**
	 * @param who WRITEME
	 * @param credentialType1 WRITEME
	 * @param string WRITEME
	 */
	public UnsupportedCredentialException (
			final Class <? extends PaymentGatewayReal> who,
			final CredentialType credentialType1, final String string) {
		gateway = who;
		credentialType = credentialType1;
		message = string;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Throwable#toString()
	 */
	@Override
	public String toString () {
		return "The type of payment which was attempted is not supported by our software.\n\n"
				+ "Message: "
				+ message
				+ "\n\n"
				+ "The payment attempted was using a credential type of: "
				+ PaymentCredential
						.getFriendlyName (credentialType)
				+ "\n"
				+ "The payment gateway attempting to process the payment was: "
				+ gateway.getName () + "\n";
	}
	
}
