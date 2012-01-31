/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * Affero General Public License for more details.
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

import java.util.EnumSet;
import java.util.Map.Entry;

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.game.inventory.RealItem.DatagramFormat;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.user.AbstractUser;
import org.starhope.util.HasSubversionRevision;

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
public class ADPEarning extends ADPJSON implements
		HasSubversionRevision {
	
	/**
	 * The default format for items
	 */
	final static EnumSet <DatagramFormat> itemFormat = EnumSet.of (
			DatagramFormat.Desc, DatagramFormat.InventoryItemType,
			DatagramFormat.Rarity, DatagramFormat.Title,
			DatagramFormat.Count);
	
	/**
	 * All currencies earned
	 */
	final private ADPMap <ADPCurrencyAmount> currencies;
	
	/**
	 * All items earned
	 */
	final private ADPMap <ADPItem> items;
	
	/**
	 * The user the earnings are for
	 */
	private AbstractUser user;
	
	/**
	 * Sends earnings to the client
	 * 
	 * @param s WRITEME 
	 */
	public ADPEarning (final ChannelListener s) {
		super ("earning", s);
		currencies = new ADPMap <ADPCurrencyAmount> ("currency", s);
		items = new ADPMap <ADPItem> ("item", s);
		include (currencies);
		include (items);
	}
	
	/**
	 * Clears the totals out of all currencies
	 */
	public void clearTotals () {
		for (final Entry <String, ADPCurrencyAmount> currency : currencies
				.entrySet ()) {
			currency.getValue ().setTotal (null);
		}
	}
	
	/**
	 * @return the user
	 */
	public AbstractUser getUser () {
		return user;
	}
	
	/**
	 * Sets a value for how much of a given currency was earned
	 * 
	 * @param cur WRITEME 
	 * @param currencyAmountEarned WRITEME 
	 * @return WRITEME 
	 */
	public void setCurrencyEarned (final Currency cur,
			final long currencyAmountEarned) {
		if ( !currencies.exists (cur.getCode ())) {
			currencies.add (cur.getCode (), new ADPCurrencyAmount (
					source));
		}
		final ADPCurrencyAmount currency = currencies.get (cur
				.getCode ());
		currency.setValue (currencyAmountEarned);
	}
	
	/**
	 * Sets a value for how much of a given currency was earned
	 * 
	 * @param cur WRITEME 
	 * @param amount WRITEME 
	 * @return WRITEME 
	 */
	public void setCurrencyTotal (final Currency cur, final long total) {
		if ( !currencies.exists (cur.getCode ())) {
			currencies.add (cur.getCode (), new ADPCurrencyAmount (
					source));
		}
		final ADPCurrencyAmount currency = currencies.get (cur
				.getCode ());
		currency.setTotal (total);
	}
	
	/**
	 * Sets an item that was earned
	 * 
	 * @param itemID WRITEME 
	 * @param title WRITEME 
	 * @param type WRITEME 
	 * @param rarity WRITEME 
	 */
	public void setItem (final RealItem item, final int count) {
		final ADPItem adpItem = item.getDatagram (source,
				ADPEarning.itemFormat);
		adpItem.setCount (count);
		items.add (Integer.toString (item.getItemID ()), adpItem);
	}
	
	/**
	 * @param user the user to set
	 */
	public void setUser (final AbstractUser user) {
		this.user = user;
		setJSON ("who", user != null ? user.getAvatarLabel () : null);
	}
	
}
