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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.net.datagram;

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.mb.Currency;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ADPCurrencyAmount extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Currency currency;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Long total;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Long value;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param s WRITEME 
	 */
	public ADPCurrencyAmount (final ChannelListener s) {
		super ("currency", s);
	}
	
	/**
	 * @return the _currency
	 */
	public Currency getCurrency () {
		return currency;
	}
	
	/**
	 * @return the total
	 */
	public Long getTotal () {
		return total;
	}
	
	/**
	 * @return the value
	 */
	public Long getValue () {
		return value;
	}
	
	/**
	 * @param currency the _currency to set
	 */
	public void setCurrency (final Currency currency) {
		this.currency = currency;
		setJSON ("cu", currency.getCode ());
	}
	
	/**
	 * @param total the total to set
	 */
	public void setTotal (final Long total) {
		this.total = total;
		if (total != null) {
			setJSON ("total", total.longValue ());
		} else {
			setJSON ("total", null);
		}
	}
	
	/**
	 * @param currencyAmountEarned the value to set
	 */
	public void setValue (final Long currencyAmountEarned) {
		value = currencyAmountEarned;
		if (currencyAmountEarned != null) {
			setJSON ("amt", currencyAmountEarned.longValue ());
		} else {
			setJSON ("amt", null);
		}
	}
}
