/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.appius.user;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.catullus.Copyable;

/**
 * @author brpocock@star-hope.org
 */
public class Wallet extends SimpleDataRecord <Wallet> implements
		Copyable <Wallet> {

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -6217318950360071843L;

	/**
	 * Get the wallet for a given user, creating a new one if necessary.
	 *
	 * @param userRecord the user whose wallet we want to see
	 * @return their new or existing wallet, as appropriate
	 */
	public static Wallet forUser (final UserRecord userRecord) {
		try {
			return Nomenclator.getDataRecord (Wallet.class, userRecord
					.getUserID ());
		} catch (final NotFoundException e) {
			return new Wallet (userRecord);
		}
	}

	/**
	 * amount of money in various forms
	 */
	private final Map <String, BigDecimal> currency = new HashMap <String, BigDecimal> ();

	/**
	 * The owner of the wallet
	 */
	private UserRecord myOwner;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public Wallet () {
		super (Wallet.class);
	}

	/**
	 * constructor for being loaded for a certain user;
	 *
	 * @param loader the record loader
	 * @param owner the owner
	 */
	public Wallet (final RecordLoader <Wallet> loader,
			final UserRecord owner) {
		super (loader);
		myOwner = owner;
	}

	/**
	 * default constructor for a <em>new</em> wallet for the given user
	 *
	 * @param owner the owner of the wallet
	 */
	public Wallet (final UserRecord owner) {
		super (Wallet.class);
		myOwner = owner;
		markAsLoaded ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param cu WRITEME
	 * @param amount WRITEME
	 */
	public void add (final String cu, final BigDecimal amount) {
		final BigDecimal have = currency.get (cu);
		if (null == have) {
			currency.put (cu, amount);
		} else {
			currency.put (cu, have.add (amount));
		}
	}

	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#changed()
	 */
	@Override
	protected void changed () {
		if (isBeingLoaded ()) {
			final AbstractUser onlineOwner = Nomenclator
					.getOnlineUserByLogin (myOwner.getLogin ());
			if (null != onlineOwner) {
				onlineOwner.updateWallet ();
			}
		}
		super.changed ();
	}

	/**
	 * @see org.starhope.catullus.Copyable#copyProtoype(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public Wallet copyProtoype (final Wallet prototype) {
		setOwner (prototype.getOwner ());
		for (final Map.Entry <String, BigDecimal> cur : prototype
				.getAllCurrency ().entrySet ()) {
			currency.put (cur.getKey (), cur.getValue ());
		}
		return this;
	}

	/**
	 * @param cu currency units
	 * @return amount of the given currency currently held
	 */
	public BigDecimal get (final Currency cu) {
		return currency.get (cu.getCode ());
	}

	/**
	 * Check a random currency. really only useful if the wallet
	 * contains a single currency. not very advisable.
	 *
	 * @param n WRITEME
	 * @return WRITEME
	 */
	public BigDecimal get (final int n) {
		if (currency.size () == 0) {
			return BigDecimal.ZERO;
		}
		return currency.values ().iterator ().next ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public Map <String, BigDecimal> getAllCurrency () {
		return new HashMap <String, BigDecimal> (currency);
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () {
		return myOwner.getCacheableID ();
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return myOwner.getCacheableIdent ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	private UserRecord getOwner () {
		return myOwner;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param cu WRITEME
	 * @param amount WRITEME
	 */
	public void put (final Currency cu, final BigDecimal amount) {
		currency.put (cu.getCode (), amount);
		changed ();
	}

	/**
	 * @param cu currency units
	 * @param amount amount of the given currency currently held
	 */
	public void put (final String cu, final BigDecimal amount) {
		currency.put (cu, amount);
		changed ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param owner WRITEME
	 */
	private void setOwner (final UserRecord owner) {
		myOwner = owner;
	}

	/**
	 * @return the wallet description in JSON
	 */
	public JSONObject toJSON () {
		final JSONObject jso = new JSONObject ();
		try {
			jso.put ("walletOwner", myOwner.getLogin ());
			final JSONObject contents = new JSONObject ();
			for (final Map.Entry <String, BigDecimal> cur : currency
					.entrySet ()) {
				contents.put (cur.getKey (), cur.getValue ()
						.toPlainString ());
			}
			jso.put ("currency", contents);
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a JSONException in Wallet.toJSON ", e);
		}
		return jso;
	}

}
