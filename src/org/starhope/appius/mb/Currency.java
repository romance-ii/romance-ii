/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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

package org.starhope.appius.mb;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.CastsToJSON;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * @author brpocock@star-hope.org
 */
public class Currency extends SimpleDataRecord <Currency> implements
		CastsToJSON {

	/**
	 *
	 */
	private static final long serialVersionUID = -6340388141547546058L;

	/**
	 * @param id ISO-4217 currency code
	 * @return currency with that database ID
	 * @throws NotFoundException if it's not found in the database
	 * @throws RuntimeException if something else wonky were to happen
	 * @deprecated Use {@link Nomenclator#getDataRecord(Class, String)}
	 *             instead
	 */
	@Deprecated
	public static Currency get (final String id)
			throws RuntimeException, NotFoundException {
		return Nomenclator.getDataRecord (Currency.class, id);
	}
	
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
	 * @deprecated use {@link Nomenclator#getDataRecord(Class, String)}
	 * @param string ISO-4217 currency code
	 * @return a Currency object
	 * @throws NotFoundException if it can't be found
	 */
	@Deprecated
	public static Currency getByCode (final String string)
			throws NotFoundException {
		return Nomenclator.getDataRecord (Currency.class, string);
	}

	/**
	 * TODO: refer to database, to be paranoid.
	 *
	 * @return Tootsville™ Peanuts
	 */
	public static final Currency getPeanuts () {
		Currency peanuts = new Currency ();
		peanuts.code = "x-TvPn";
		peanuts.title = "Tootsville™ Peanuts";
		peanuts.symbol = "Þ";
		return peanuts;
	}

	/**
	 * TODO: refer to database, to be paranoid.
	 *
	 * @return Tootsville™ Toot Tokens
	 */
	public static final Currency getTootTokens () {
		Currency tokens = new Currency ();
		tokens.code = "x-TvTk";
		tokens.title = "Tootsville™ Tokens";
		tokens.symbol = "Ţ";
		return tokens;
	}

	/**
	 * The ISO-4217 currency code (three letters); "USD" is U.S. Dollar,
	 * and "EUR" is the Euro.
	 */
	private String code;

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
	 * fictional currencies) a string beginning with “x-” and up to four
	 * characters
	 * 
	 * @return A string of three uppercase characters, or up to six
	 *         characters beginning with “x-”
	 */
	public String getCode () {
		return code;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}

	/**
	 * @see #setSymbol Returns the currency symbol for user presentation
	 *      of prices.
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
	 * Change the currency code for this instance.
	 *
	 * @param newCode The new currency code to be set (ISO-4217,
	 *            uppercase, e.g. "USD")
	 * @throws DataException if the specification does not consist of
	 *             three AppiusCharacter.UPPERCASE_LETTER characters.
	 */
	public void setCode (final String newCode) throws DataException {
		if ( ! (newCode.charAt (0) == 'x' && newCode.charAt (1) == '-')
				&& (newCode.length () != 3
						|| Character.getType (newCode.charAt (0)) != Character.UPPERCASE_LETTER
						|| Character.getType (newCode.charAt (1)) != Character.UPPERCASE_LETTER || Character
						.getType (newCode.charAt (2)) != Character.UPPERCASE_LETTER)) {
			throw new DataException (
					"Code must be a three-character ISO-4217 code in uppercase, e.g. USD");
		}
		code = newCode;
		changed ();
	}
	
	/**
	 * Set the user-visible displayed symbol of this currency. E.G. for
	 * the US Dollar, this is "US $"; Mexican New Peso, "Mx $"; for the
	 * Canadian dollar, "CA $"; for the Chinese RMB, it might be "RMB",
	 * versus Japanese Yen "Jp ¥"; Euro, just "€" (since there's no
	 * confusion with any other country using a similar currency symbol)
	 * 
	 * @param newSymbol The new symbol string to be used for this
	 *            currency
	 * @throws DataException if the new symbol string is not supplied,
	 *             or is more than 5 characters long
	 */
	public void setSymbol (final String newSymbol) throws DataException {
		if (null == newSymbol || newSymbol.length () == 0) {
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
	 * Get a JSON object with the ISO code, title, and symbol
	 * representing this currency. (See the individual getters for
	 * discussion.)
	 * 
	 * @return { c: {@link #getCode()}, t: {@link #getTitle()}, s:
	 *         {@link #getSymbol()}
	 */
	@Override
	public JSONObject toJSON () {
		JSONObject r = new JSONObject ();
		try {
			r.put ("c", getCode ());
			r.put ("t", getTitle ());
			r.put ("s", getSymbol ());
		} catch (JSONException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a JSONException in Currency.toJSON ", e);
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
