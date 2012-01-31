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

package org.starhope.appius.mb;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.pay.AuthorizeNetGateway;
import org.starhope.appius.pay.util.CredentialType;
import org.starhope.appius.pay.util.PaymentGatewayReal;
import org.starhope.appius.pay.util.RetryPaymentException;
import org.starhope.appius.pay.util.UnsupportedCredentialException;
import org.starhope.appius.pay.util.UnsupportedCurrencyException;
import org.starhope.appius.sql.SQLPeerDatum;
import org.starhope.appius.user.AbstractPerson;
import org.starhope.appius.user.Parent;

/**
 * A payment gateway is a transaction broker for payments. E.G. Res
 * Interactive/Tootsville is using Authorize.Net. Alternative providers
 * might include other credit-card or cheque processing companies, or
 * other electronic transfer means such as Paypal or micro-currency
 * systems used in other online gaming sites/communities. Gift card
 * transactions are also processed through a special payment gateway.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class PaymentGateway extends SQLPeerDatum implements
		PaymentGatewayReal {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (PaymentGateway.class);
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -3850242661914601113L;
	
	/**
	 * @param id The 4-char authorization code for the payment gateway.
	 *             (Used as the order_source part of the order ID), in
	 *             lower-case letters.
	 *             <ul>
	 *             <li>auth = Authorize.net</li>
	 *             <li>ppal = PayPal</li>
	 *             <li>goog = Google Checkout</li>
	 *             <li>card = Giftcard (Not used)</li>
	 *             <li>ibcc = iBC Prepaid Card</li>
	 *             </ul>
	 * @return the Class specified, which can then be instantiated.
	 * @throws NotFoundException if the payment gateway type does not
	 *              exist or is unimplemented.
	 */
	public static Class <? extends PaymentGatewayReal> get (
			final String id) throws NotFoundException {
		
		if ("auth".equals (id)) {
			return AuthorizeNetGateway.class;
		} else if ("goog".equals (id)) {
			// FIXME return GoogleCheckoutGateway.class;
			throw new NotFoundException (
					"Google Checkout support not yet implemented");
		} else {
			throw new NotFoundException (id);
		}
		
	}
	
	/**
	 * @param klass A class implementing PaymentGatewayReal
	 * @return the PaymentGateway database object associated therewith
	 */
	public static PaymentGatewayReal getByClass (
			final Class <? extends PaymentGatewayReal> klass) {
		try {
			return klass.newInstance ();
		} catch (final IllegalAccessException e) {
			return null;
		} catch (final InstantiationException e) {
			return null;
		}
	}
	
	/**
	 * WRITEME
	 */
	private String code;
	
	/**
	 * WRITEME
	 */
	private PaymentGatewayReal implementation;
	
	/**
	 * The class implementing the actual functionality, e.g.
	 * org.starhope.appius.pay.AuthorizeNetGateway
	 */
	private String implementor;
	/**
	 * WRITEME
	 */
	private String managementURL;
	/**
	 * WRITEME
	 */
	private String title;
	/**
	 * WRITEME
	 */
	private AbstractPerson user;
	
	/**
	 * WRITEME
	 */
	public PaymentGateway () {
		code = null;
		implementation = null;
		implementor = "";
		managementURL = "";
		title = "";
		user = null;
	}
	
	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#alterEnrolment(org.starhope.appius.mb.Payment,
	 *      org.starhope.appius.mb.UserEnrolment)
	 */
	@Override
	public void alterEnrolment (final Payment payment,
			final UserEnrolment newForm)
			throws UnsupportedCurrencyException, NotFoundException,
			UnsupportedCredentialException, IOException,
			RetryPaymentException, GameLogicException {
		implementation.alterEnrolment (payment, newForm);
	}
	
	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#endEnrolment(org.starhope.appius.mb.Payment)
	 */
	@Override
	public void endEnrolment (final Payment payment)
			throws UnsupportedCurrencyException, NotFoundException,
			UnsupportedCredentialException, IOException,
			RetryPaymentException, GameLogicException {
		implementation.endEnrolment (payment);
	}
	
	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#enumerateCredentialTypes()
	 */
	@Override
	public List <CredentialType> enumerateCredentialTypes () {
		return implementation.enumerateCredentialTypes ();
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerDatum#flush()
	 */
	@Override
	public void flush () {
		// No op
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerDatum#getCacheUniqueID()
	 */
	@Override
	protected String getCacheUniqueID () {
		return getOrderSourceCode ();
	}
	
	/**
	 * @return WRITEME
	 * @deprecated use {@link #getOrderSourceCode()}
	 */
	@Deprecated
	public String getCode () {
		return code;
	}
	
	/**
	 * @return an actual PaymentGatewayReal implementation
	 * @throws Exception of many kinds, because this is funky mojo
	 */
	private PaymentGatewayReal getImplementation () throws Exception {
		if (implementation == null) {
			try {
				implementation = (PaymentGatewayReal) Class
						.forName (implementor).newInstance ();
			} catch (final Exception e) {
				PaymentGateway.log.error ("Exception", e);
				throw e;
			}
		}
		return implementation;
	}
	
	/**
	 * @return WRITEME
	 */
	public String getImplementor () {
		return implementor;
	}
	
	// /**
	// * @see
	// org.starhope.appius.pay.util.PaymentGatewayReal#getPayment(java.lang.String)
	// */
	// @Override
	// public Payment getPayment (final String gatewayTransactionCode)
	// {
	// return this.implementation.getPayment (gatewayTransactionCode);
	// };
	
	/**
	 * @return WRITEME
	 */
	public String getManagementURL () {
		return managementURL;
	}
	
	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#getOrderSourceCode()
	 */
	@Override
	public String getOrderSourceCode () {
		return null == implementation ? null : implementation
				.getOrderSourceCode ();
	}
	
	/**
	 * This is an overriding method. It also passes the buck to the
	 * implementor.
	 * 
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#getPayment(java.math.BigDecimal)
	 */
	@Override
	public Payment getPayment (final BigDecimal bigDecimal) {
		return implementation.getPayment (bigDecimal);
	}
	
	/**
	 * @return Get the title of this Payment Gateway (end-user-visible)
	 */
	public String getTitle () {
		return title;
	}
	
	/**
	 * Get the user account associated with the payment gateway. (Each
	 * payment gateway has a user account in the system, which should
	 * have an age bracket of 'X')
	 * 
	 * @return the system user account used for this payment gateway's
	 *         moderator actions
	 */
	public AbstractPerson getUser () {
		return user;
	}
	
	/**
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#isAvailable()
	 */
	@Override
	public boolean isAvailable () {
		return implementation.isAvailable ();
	}
	
	/**
	 * @see org.starhope.appius.util.CastsToJSON#set(org.json.JSONObject)
	 */
	@Override
	public void set (final JSONObject o) {
		try {
			setCode (o.getString ("code"));
			setTitle (o.getString ("title"));
			try {
				// setUser (User.get (o.getJSONObject ("user")));
				throw new Error ("not implemented FIXME");
			} catch (final Exception e) {
				PaymentGateway.log.error ("Exception", e);
			}
			setManagementURL (o.getString ("managementURL"));
			setImplementor (o.getString ("implementor"));
		} catch (final JSONException e) {
			PaymentGateway.log.error ("Exception", e);
		}
		
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerDatum#set(java.sql.ResultSet)
	 */
	@Override
	protected void set (final ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub (brpocock@star-hope.org,
		// Aug 25, 2009)
		
	}
	
	/**
	 * @param newCode The new code for this payment gateway
	 */
	public void setCode (final String newCode) {
		code = newCode;
	}
	
	/**
	 * @param implementor1 Set the actual Payment Gateway
	 *             implementation to be used (String)
	 */
	public void setImplementor (final String implementor1) {
		implementor = implementor1;
	}
	
	/**
	 * @param newManagementURL the management URL for accessing this
	 *             payment gateway's settings (outside of our systems)
	 */
	public void setManagementURL (final String newManagementURL) {
		managementURL = newManagementURL;
	}
	
	/**
	 * @param newTitle the (user-visible) title
	 */
	public void setTitle (final String newTitle) {
		title = newTitle;
	}
	
	/**
	 * @param newUser the user account
	 */
	public void setUser (final AbstractPerson newUser) {
		user = newUser;
	}
	
	/**
	 * @param byID WRITEME
	 */
	public void setUser (final Parent byID) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @throws AlreadyUsedException WRITEME
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#startEnrolment(org.starhope.appius.mb.Payment)
	 */
	@Override
	public void startEnrolment (final Payment payment)
			throws UnsupportedCurrencyException, NotFoundException,
			UnsupportedCredentialException, IOException,
			RetryPaymentException, GameLogicException,
			AlreadyUsedException {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @throws DataException WRITEME
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#startTransaction(org.starhope.appius.mb.Payment)
	 */
	@Override
	public void startTransaction (final Payment payment)
			throws UnsupportedCurrencyException, NotFoundException,
			UnsupportedCredentialException, IOException,
			RetryPaymentException, GameLogicException,
			AlreadyUsedException, DataException {
		// TODO Auto-generated method stub (twheys@gmail.com, Oct 1,
		// 2009)
		
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerDatum#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject o = super.toJSON ();
		try {
			o.put ("code", getCode ());
			o.put ("title", getTitle ());
			// XXX o.put ("user", getUser ().toJSON ());
			o.put ("managementURL", getManagementURL ());
		} catch (final JSONException e) {
			PaymentGateway.log.error ("Exception", e);
		}
		return o;
	}
	
	/**
	 * @throws DataException WRITEME
	 * @throws AlreadyUsedException WRITEME
	 * @throws GameLogicException WRITEME
	 * @see org.starhope.appius.pay.util.PaymentGatewayReal#transactPayment(Payment)
	 */
	@Override
	public void transactPayment (final Payment p)
			throws UnsupportedCurrencyException, NotFoundException,
			UnsupportedCredentialException, IOException,
			RetryPaymentException, GameLogicException,
			AlreadyUsedException, DataException {
		try {
			getImplementation ().transactPayment (p);
			return;
		} catch (final Exception e) {
			PaymentGateway.log.error ("Exception", e);
		}
	}
}
