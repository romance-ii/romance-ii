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
import java.math.MathContext;

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.util.AppiusConfig;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman
 *
 */
public class ADPCurrency extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	private Currency currency;
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	private BigDecimal value;
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	private BigDecimal total;
	
	/**
	 * WRITEME: Document this constructor ewinkelman
	 * 
	 * @param s
	 */
	public ADPCurrency (ChannelListener s) {
		super ("currency", s);
	}
	
	/**
	 * @param currency the _currency to set
	 */
	public void setCurrency (Currency currency) {
		this.currency = currency;
		setJSON ("cu", value);
	}
	
	/**
	 * @return the _currency
	 */
	public Currency getCurrency () {
		return this.currency;
	}
	
	/**
	 * @param value the value to set
	 */
	public void setValue (BigDecimal value) {
		this.value = value;
		final String putValue = AppiusConfig
				.getConfigBoolOrTrue ("org.starhope.appius.events.currencyInt") ? String
				.valueOf (value.round (MathContext.DECIMAL32)
						.intValue ()) : value.toPlainString ();
		setJSON ("amt", putValue);
	}
	
	/**
	 * @return the value
	 */
	public BigDecimal getValue () {
		return value;
	}
	
	/**
	 * @param total the total to set
	 */
	public void setTotal (BigDecimal total) {
		this.total = total;
		final String putValue = AppiusConfig
				.getConfigBoolOrTrue ("org.starhope.appius.events.currencyInt") ? String
				.valueOf (total.round (MathContext.DECIMAL32)
						.intValue ()) : total.toPlainString ();
		setJSON ("total", putValue);
	}
	
	/**
	 * @return the total
	 */
	public BigDecimal getTotal () {
		return total;
	}
}
