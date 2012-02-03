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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.pay.util;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.mb.Payment;
import org.starhope.appius.mb.PaymentGateway;
import org.starhope.appius.mb.UserEnrolment;

/**
 * @author brpocock@star-hope.org
 */
public interface PaymentGatewayReal {

	/**
	 * @param payment WRITEME
	 * @param newForm WRITEME
	 * @throws UnsupportedCurrencyException WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws UnsupportedCredentialException WRITEME
	 * @throws IOException WRITEME
	 * @throws RetryPaymentException WRITEME
	 * @throws GameLogicException WRITEME
	 */
	void alterEnrolment (Payment payment, UserEnrolment newForm)
	throws UnsupportedCurrencyException, NotFoundException,
	UnsupportedCredentialException, IOException,
	RetryPaymentException, GameLogicException;
	
	/**
	 * @param payment WRITEME
	 * @throws UnsupportedCurrencyException WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws UnsupportedCredentialException WRITEME
	 * @throws IOException WRITEME
	 * @throws RetryPaymentException WRITEME
	 * @throws GameLogicException WRITEME
	 */
	void endEnrolment (Payment payment)
	throws UnsupportedCurrencyException, NotFoundException,
	UnsupportedCredentialException, IOException,
	RetryPaymentException, GameLogicException;

	/**
	 * Provides a list of all credential types supported by the given
	 * payment gateway.
	 *
	 * @return all supported {@link CredentialType}:s
	 */
	public List <CredentialType> enumerateCredentialTypes ();

	/**
	 * <p>
	 * Get the status of a prior transaction <em>from the gateway</em>.
	 * This method <em>should not</em> be based upon our internal
	 * database.
	 * </p>
	 * <p>
	 * It is not necessary for every gateway to provide details of
	 * failed transactions. If possible, however, they should be
	 * returned as well.
	 * </p>
	 * <p>
	 * It <em>is</em> an implementation requirement that all successful
	 * transactions must return valid results information. An auditing
	 * subsystem (TODO) should validate this information on a periodic
	 * basis (say, weekly?) against our internal database to ensure
	 * conformance.
	 * </p>
	 *
	 * @param bigDecimal The identifier used by the implementing payment
	 *        gateway to uniquely identify the transaction in question.
	 * @return the results information available about that transaction
	 */
	public Payment getPayment (final BigDecimal bigDecimal);

	/**
	 * @return The source code (currently hard-coded list in {@link PaymentGateway#get(String)}
	 */
	public String getOrderSourceCode ();

	/**
	 * @return true, if the payment gateway appears to be online and
	 *         functioning (or was known to be online and functioning
	 *         recently enough)
	 */
	boolean isAvailable ();

	/**
	 * @param payment WRITEME
	 * @throws UnsupportedCurrencyException WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws UnsupportedCredentialException WRITEME
	 * @throws IOException WRITEME
	 * @throws RetryPaymentException WRITEME
	 * @throws GameLogicException WRITEME
	 * @throws AlreadyUsedException WRITEME
	 */
	void startEnrolment (Payment payment)
	throws UnsupportedCurrencyException, NotFoundException,
	UnsupportedCredentialException, IOException,
	RetryPaymentException, GameLogicException,
	AlreadyUsedException;

	/**
	 * @param payment WRITEME
	 * @throws UnsupportedCurrencyException WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws UnsupportedCredentialException WRITEME
	 * @throws IOException WRITEME
	 * @throws RetryPaymentException WRITEME
	 * @throws GameLogicException WRITEME
	 * @throws AlreadyUsedException WRITEME
	 * @throws DataException WRITEME
	 */
	void startTransaction (Payment payment)
	throws UnsupportedCurrencyException, NotFoundException,
	UnsupportedCredentialException, IOException,
	RetryPaymentException, GameLogicException,
	AlreadyUsedException, DataException;

	/**
	 * @param payment WRITEME
	 * @throws UnsupportedCurrencyException WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws UnsupportedCredentialException WRITEME
	 * @throws IOException WRITEME
	 * @throws RetryPaymentException WRITEME
	 * @throws GameLogicException WRITEME
	 * @throws AlreadyUsedException WRITEME
	 * @throws DataException WRITEME
	 */
	void transactPayment (Payment payment)
	throws UnsupportedCurrencyException, NotFoundException,
	UnsupportedCredentialException, IOException,
	RetryPaymentException, GameLogicException,
	AlreadyUsedException, DataException;

}
