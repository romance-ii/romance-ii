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

import org.json.JSONArray;
import org.starhope.appius.game.ChannelListener;
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
public class ADPWallet extends ADPJSON implements HasSubversionRevision {
	
	/**
	 * Wallet datagram
	 */
	final JSONArray currencies = new JSONArray ();
	
	/**
	 * Who the wallet belongs to
	 */
	private AbstractUser owner;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param s WRITEME 
	 */
	public ADPWallet (final ChannelListener s) {
		super ("wallet", s);
		setJSON ("currency", currencies);
	}
	
	/**
	 * Adds a currency to the wallet
	 * 
	 * @param currency WRITEME 
	 * @param amount WRITEME 
	 */
	public void add (final Currency currency, final long amount) {
		final ADPCurrencyAmount adpCurrency = new ADPCurrencyAmount (
				source);
		adpCurrency.setCurrency (currency);
		adpCurrency.setTotal (new Long (amount));
		currencies.put (adpCurrency.jso);
	}
	
	/**
	 * @return the owner
	 */
	public AbstractUser getOwner () {
		return owner;
	}
	
	/**
	 * @param owner the owner to set
	 */
	public void setOwner (final AbstractUser owner) {
		this.owner = owner;
		setJSON ("who", owner.getAvatarLabel ());
	}
	
}
