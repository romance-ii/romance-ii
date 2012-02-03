/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
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
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author ewinkelman
 */
package org.starhope.appius.net.datagram;

import java.math.BigDecimal;
import java.util.HashMap;

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.mb.Currency;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman
 *
 */
public class ADPCurrencyEarned extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	private HashMap <String, ADPCurrency> currencies = new HashMap <String, ADPCurrency> ();
	
	/**
	 * WRITEME: Document this constructor ewinkelman
	 * 
	 * @param s
	 */
	public ADPCurrencyEarned (ChannelListener s) {
		super ("currencyEarned", s);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param currency
	 * @return
	 */
	private ADPCurrency getCurrency (Currency currency) {
		ADPCurrency adpCurrency;
		if ( !currencies.containsKey (currency.getCode ())) {
			adpCurrency = new ADPCurrency (source);
			currencies.put (currency.getCode (), adpCurrency);
			include (adpCurrency);
		} else {
			adpCurrency = currencies.get (currency.getCode ());
		}
		return adpCurrency;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param currency
	 * @return
	 */
	public BigDecimal getCurrencyEarned (Currency currency) {
		BigDecimal result = null;
		if (currencies.containsKey (currency.getCode ())) {
			result = currencies.get (currency.getCode ()).getValue ();
		}
		return result;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param currency
	 * @return
	 */
	public BigDecimal getCurrencyTotal (Currency currency) {
		BigDecimal result = null;
		if (currencies.containsKey (currency.getCode ())) {
			result = currencies.get (currency.getCode ()).getTotal ();
		}
		return result;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param currency
	 * @param amount
	 */
	public void setCurrencyEarned (Currency currency,BigDecimal amount) {
		final ADPCurrency result = getCurrency (currency);
		if (result != null)
			result.setValue (amount);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param currency
	 * @param total
	 */
	public void setCurrencyTotal (Currency currency, BigDecimal total) {
		final ADPCurrency result = getCurrency (currency);
		if (result != null)
			result.setTotal (total);
	}

}
