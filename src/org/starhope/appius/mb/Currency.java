/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.net.datagram.ADPCurrencyInfo;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.CastsToJSON;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Currency extends SimpleDataRecord <Currency> implements
		CastsToJSON {
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (Currency.class);
	
	/**
	 *
	 */
	private static final long serialVersionUID = -6340388141547546058L;
	
	/**
	 * <p>
	 * This is a quick "semantic sugar" to pick up U.S. Dollars as a
	 * currency format, since that's realistically the only one we're
	 * dealing with at the moment.
	 * </p>
	 * <p>
	 * TODO: refer to database, to be paranoid.
	 * </p>
	 * 
	 * @return a Currency object representing U.S. Dollars.
	 */
	public static final Currency get_USD () {
		final Currency dollar = new Currency ();
		dollar.code = "USD";
		dollar.symbol = "$";
		dollar.title = "US Dollar";
		return dollar;
	}
	
	/**
	 * Convenience method for fetching currency
	 * 
	 * @return Tootsville™ Peanuts
	 */
	public static final Currency getPeanuts () {
		try {
			return Nomenclator.getDataRecord (Currency.class,
					"x-TvPn");
		} catch (final NotFoundException e) {
			Currency.log.error ("Exception", e);
		}
		return new Currency ();
	}
	
	/**
	 * Convenience method for fetching currency
	 * 
	 * @return Tootsville™ Toot Tokens
	 */
	public static final Currency getTootTokens () {
		try {
			return Nomenclator.getDataRecord (Currency.class,
					"x-TvTk");
		} catch (final NotFoundException e) {
			Currency.log.error ("Exception", e);
		}
		return new Currency ();
	}
	
	/**
	 * The ISO-4217 currency code (three letters); "USD" is U.S.
	 * Dollar, and "EUR" is the Euro.
	 */
	private String code;
	
	/**
	 * The URL of the image for the currency
	 */
	private String icon;
	
	/**
	 * The display character sequence. For US Dollars, it's " US $ ";
	 * for Euros, it's just the Euro sign
	 */
	private String symbol;
	
	/**
	 * Title
	 */
	private String title;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public Currency () {
		super (Currency.class);
	}
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param loader WRITEME
	 */
	public Currency (final RecordLoader <Currency> loader) {
		super (loader);
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
		if ( ! (obj instanceof Currency)) {
			return false;
		}
		final Currency other = (Currency) obj;
		if (code == null) {
			if (other.code != null) {
				return false;
			}
		} else if ( !code.equals (other.code)) {
			return false;
		}
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		throw new NotFoundException ("No numeric ID");
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return code;
	}
	
	/**
	 * Get the three-character (ISO-4217) currency code, or (for
	 * fictional currencies) a string beginning with “x-” and up to
	 * four characters
	 * 
	 * @return A string of three uppercase characters, or up to six
	 *         characters beginning with “x-”
	 */
	public String getCode () {
		return code;
	}
	
	/**
	 * @return the icon
	 */
	public String getIcon () {
		return icon;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * @see #setSymbol Returns the currency symbol for user
	 *      presentation of prices.
	 * @return A string of 1-5 characters suitable for unambiguous
	 *         representation of this currency.
	 */
	public String getSymbol () {
		return symbol;
	}
	
	/**
	 * @return the title of the currency
	 */
	public String getTitle () {
		return title;
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result)
				+ (code == null ? 0 : code.hashCode ());
		return result;
	}
	
	/**
	 * Change the currency code for this instance.
	 * 
	 * @param newCode The new currency code to be set (ISO-4217,
	 *             uppercase, e.g. "USD")
	 * @throws DataException if the specification does not consist of
	 *              three AppiusCharacter.UPPERCASE_LETTER characters.
	 */
	public void setCode (final String newCode) throws DataException {
		code = newCode;
		changed ();
	}
	
	/**
	 * @param icon the icon to set
	 */
	public void setIcon (final String icon) {
		this.icon = icon;
	}
	
	/**
	 * Set the user-visible displayed symbol of this currency. E.G. for
	 * the US Dollar, this is "US $"; Mexican New Peso, "Mx $"; for the
	 * Canadian dollar, "CA $"; for the Chinese RMB, it might be "RMB",
	 * versus Japanese Yen "Jp ¥"; Euro, just "€" (since there's no
	 * confusion with any other country using a similar currency
	 * symbol)
	 * 
	 * @param newSymbol The new symbol string to be used for this
	 *             currency
	 * @throws DataException if the new symbol string is not supplied,
	 *              or is more than 5 characters long
	 */
	public void setSymbol (final String newSymbol)
			throws DataException {
		if ( (null == newSymbol) || (newSymbol.length () == 0)) {
			throw new DataException ("Currency symbol must be given");
		}
		if (newSymbol.length () > 5) {
			throw new DataException (
					"Currency symbol length must be less than 5 characters");
		}
		symbol = newSymbol;
		changed ();
	}
	
	/**
	 * @param newTitle the title to set
	 */
	public void setTitle (final String newTitle) {
		title = newTitle;
		changed ();
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	public ADPCurrencyInfo toDatagram (final ChannelListener s) {
		final ADPCurrencyInfo currencyInfo = new ADPCurrencyInfo (s);
		currencyInfo.setIcon (icon);
		currencyInfo.setIsoCode (code);
		currencyInfo.setName (title);
		currencyInfo.setSym (symbol);
		return currencyInfo;
	}
	
	/**
	 * Get a JSON object with the ISO code, title, and symbol
	 * representing this currency. (See the individual getters for
	 * discussion.)
	 * 
	 * @return { c: {@link #getCode()}, t: {@link #getTitle()}, s:
	 *         {@link #getSymbol()}
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject r = new JSONObject ();
		try {
			r.put ("c", getCode ());
			r.put ("t", getTitle ());
			r.put ("s", getSymbol ());
		} catch (final JSONException e) {
			Currency.log.error (
					"Caught a JSONException in Currency.toJSON ",
					e);
		}
		return r;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return getTitle () + " (" + getCode () + ") " + getSymbol ();
	}
	
}
