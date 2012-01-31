/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.appius.user;

import java.lang.ref.WeakReference;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.net.datagram.ADPWallet;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.catullus.Copyable;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Wallet extends SimpleDataRecord <Wallet> implements
		Copyable <Wallet> {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -6217318950360071843L;
	
	/**
	 * Get the wallet for a given user, creating a new one if
	 * necessary.
	 * 
	 * @param userRecord the user whose wallet we want to see
	 * @return their new or existing wallet, as appropriate
	 */
	public static Wallet forUser (final UserRecord userRecord) {
		try {
			return Nomenclator.getDataRecord (Wallet.class,
					userRecord.getUserID ());
		} catch (final NotFoundException e) {
			return new Wallet (userRecord);
		}
	}
	
	/**
	 * amount of money in various forms
	 */
	private final Map <Currency, BigDecimal> currency = new HashMap <Currency, BigDecimal> ();
	
	/**
	 * The owner of the wallet
	 */
	private WeakReference <AbstractUser> owner = new WeakReference <AbstractUser> (
			null);
	
	/**
	 * The owner ID of the wallet
	 */
	private int ownerID;
	
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
	 */
	public Wallet (final RecordLoader <Wallet> loader) {
		super (loader);
	}
	
	/**
	 * default constructor for a <em>new</em> wallet for the given user
	 * 
	 * @param newOwner the owner of the wallet
	 */
	public Wallet (final UserRecord newOwner) {
		super (Wallet.class);
		owner = new WeakReference <AbstractUser> (newOwner.getUser ());
		ownerID = newOwner.getUserID ();
		markAsLoaded ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param cu WRITEME
	 * @param amount WRITEME
	 */
	public void add (final Currency cu, final BigDecimal amount) {
		final BigDecimal have = currency.containsKey (cu) ? currency
				.get (cu) : BigDecimal.ZERO;
		currency.put (cu, have.add (amount));
		changed ();
	}
	
	/**
	 * @see org.starhope.catullus.Copyable#copyProtoype(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public Wallet copyProtoype (final Wallet prototype) {
		setOwner (ownerID);
		for (final Map.Entry <Currency, BigDecimal> cur : prototype
				.getAllCurrency ().entrySet ()) {
			currency.put (cur.getKey (), cur.getValue ());
		}
		return this;
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
		if ( ! (obj instanceof Wallet)) {
			return false;
		}
		final Wallet other = (Wallet) obj;
		if (ownerID != other.ownerID) {
			return false;
		}
		return true;
	}
	
	/**
	 * @param cu currency units
	 * @return amount of the given currency currently held
	 */
	public BigDecimal get (final Currency cu) {
		return currency.containsKey (cu) ? currency.get (cu)
				: BigDecimal.ZERO;
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
	public Map <Currency, BigDecimal> getAllCurrency () {
		return new HashMap <Currrency, BigDecimal> ();
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () {
		return ownerID;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return owner.get ().getCacheableIdent ();
	}
	
	/**
	 * Gets the ID of this wallet's owner
	 * 
	 * @return WRITEME
	 */
	public AbstractUser getOwner () {
		AbstractUser result = owner.get ();
		if (result == null) {
			owner = new WeakReference <AbstractUser> (
					Nomenclator.getUserByID (ownerID));
			result = owner.get ();
		}
		return result;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result) + ownerID;
		return result;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param cu WRITEME
	 * @param amount WRITEME
	 */
	public void put (final Currency cu, final BigDecimal amount) {
		currency.put (cu, amount);
		changed ();
	}
	
	/**
	 * Sets the owner ID of this wallet
	 * 
	 * @param id WRITEME
	 */
	void setOwner (final int id) {
		ownerID = id;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param newOwner WRITEME
	 */
	private void setOwner (final UserRecord newOwner) {
		owner = new WeakReference <AbstractUser> (
				Nomenclator.getUserByID (newOwner.getUserID ()));
		ownerID = newOwner.getUserID ();
	}
	
	/**
	 * Gets the wallet as a datagram
	 * 
	 * @param s WRITEME 
	 * @return WRITEME 
	 */
	public ADPWallet toDatagram (final ChannelListener s) {
		final ADPWallet result = new ADPWallet (s);
		for (final Entry <Currency, BigDecimal> entry : currency
				.entrySet ()) {
			result.add (entry.getKey (), entry.getValue ());
		}
		result.setOwner (getOwner ());
		return result;
	}
	
	/**
	 * @return the wallet description in JSON
	 */
	public JSONObject toJSON () {
		final JSONObject jso = new JSONObject ();
		try {
			jso.put ("walletOwner", owner.get ().getLogin ());
			final JSONObject contents = new JSONObject ();
			for (final Entry <Currency, BigDecimal> cur : currency
					.entrySet ()) {
				contents.put (cur.getKey ().toString (), cur
						.getValue ().toPlainString ());
			}
			jso.put ("currency", contents);
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug (
					"Caught a JSONException in Wallet.toJSON ", e);
		}
		return jso;
	}
	
}
