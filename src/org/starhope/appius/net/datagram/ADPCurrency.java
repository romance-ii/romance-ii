/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
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
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ADPCurrency extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Currency currency;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private BigDecimal total;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private BigDecimal value;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param s WRITEME  ewinkelman 
	 */
	public ADPCurrency (final ChannelListener s) {
		super ("currency", s);
	}
	
	/**
	 * @return the _currency
	 */
	public Currency getCurrency () {
		return this.currency;
	}
	
	/**
	 * @return the total
	 */
	public BigDecimal getTotal () {
		return total;
	}
	
	/**
	 * @return the value
	 */
	public BigDecimal getValue () {
		return value;
	}
	
	/**
	 * @param currency the _currency to set
	 */
	public void setCurrency (final Currency currency) {
		this.currency = currency;
		setJSON ("cu", value);
	}
	
	/**
	 * @param total the total to set
	 */
	public void setTotal (final BigDecimal total) {
		this.total = total;
		final String putValue = AppiusConfig
				.getConfigBoolOrTrue ("org.starhope.appius.events.currencyInt") ? String
				.valueOf (total.round (MathContext.DECIMAL32)
						.intValue ()) : total.toPlainString ();
		setJSON ("total", putValue);
	}
	
	/**
	 * @param value the value to set
	 */
	public void setValue (final BigDecimal value) {
		this.value = value;
		final String putValue = AppiusConfig
				.getConfigBoolOrTrue ("org.starhope.appius.events.currencyInt") ? String
				.valueOf (value.round (MathContext.DECIMAL32)
						.intValue ()) : value.toPlainString ();
		setJSON ("amt", putValue);
	}
}
