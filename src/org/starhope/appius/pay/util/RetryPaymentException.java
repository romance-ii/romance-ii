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

package org.starhope.appius.pay.util;

import java.io.IOException;
import java.util.Date;

import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.Payment;

/**
 * @author brpocock@star-hope.org
 * 
 */
public class RetryPaymentException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6281463386314458042L;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 20, 2009)
	 * 
	 * message (RetryPaymentException)
	 */
	private final String message;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 20, 2009)
	 * 
	 * p (RetryPaymentException)
	 */
	private final Payment p;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 20, 2009)
	 * 
	 * retry (RetryPaymentException)
	 */
	private Date retry;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 20, 2009)
	 * 
	 * title (RetryPaymentException)
	 */
	private final String title;

	/**
	 * @param title1 The title of the message to show the user
	 * @param message1 A detailed explanation of the delay in
	 *        user-visible terms
	 * @param p1 The payment object which needs to be retried.
	 */
	public RetryPaymentException (final String title1,
			final String message1, final Payment p1) {
		title = title1;
		message = message1;
		p = p1;

		try {
			p1.prepareForRetry (this);
			setRetry (p1.getRetryTime ());
		} catch (final AlreadyUsedException e) {
			AppiusClaudiusCaecus.reportBug (e);
			setRetry (new Date (Long.MAX_VALUE));
		} catch (final DataException e) {
			AppiusClaudiusCaecus.reportBug (e);
			setRetry (new Date (Long.MAX_VALUE));
		}

	}

	/**
	 * @see java.lang.Throwable#getMessage()
	 */
	@Override
	public String getMessage () {
		return message;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 * 
	 * @return WRITEME
	 */
	public Date getRetry () {
		return new Date (retry.getTime ());
	}

	/**
	 * @return the title of the retry message
	 */
	public String getTitle () {
		return title;
	}

	/**
	 * @throws UnsupportedCurrencyException WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws UnsupportedCredentialException WRITEME
	 * @throws IOException WRITEME
	 * @throws RetryPaymentException WRITEME
	 * @throws DataException WRITEME
	 * @throws AlreadyUsedException WRITEME
	 * @throws GameLogicException WRITEME
	 */
	public void retry () throws UnsupportedCurrencyException,
	NotFoundException, UnsupportedCredentialException,
			IOException, RetryPaymentException, GameLogicException,
			AlreadyUsedException, DataException {
		p.getPaymentGateway ().transactPayment (p);
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23, 2009)
	 * 
	 * @param retry1 WRITEME
	 */
	public void setRetry (final Date retry1) {
		retry = new Date (retry1.getTime ());
	}

}
