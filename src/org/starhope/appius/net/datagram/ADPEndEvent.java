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

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.mb.Currency;

/**
 * WRITEME: Document this type.
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ADPEndEvent extends ADPJSON {
	
	/**
	 * Time completed. Equal to null if zero.
	 */
	private Long _completionTimestamp;
	
	/**
	 * Time created. Equal to null if zero.
	 */
	private Long _creationTimestamp;
	
	/**
	 * Creator
	 */
	private String _creator;
	
	/**
	 * Currency sub object
	 */
	private ADPCurrencyEarned _currency;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private ADPHighScores _highScores;
	
	/**
	 * Constructor
	 * 
	 * @param s Listener
	 */
	public ADPEndEvent (final ChannelListener s) {
		super ("endEvent", s);
	}
	
	/**
	 * @return the completionTimestamp
	 */
	public long getCompletionTimestamp () {
		return _completionTimestamp == null ? 0
				: _completionTimestamp.longValue ();
	}
	
	/**
	 * @return the creationTimestamp
	 */
	public long getCreationTimestamp () {
		return _creationTimestamp == null ? 0 : _creationTimestamp
				.longValue ();
	}
	
	/**
	 * @return the creatorID
	 */
	public String getCreator () {
		return _creator;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME  ewinkelman 
	 */
	public ADPCurrencyEarned getCurrencyEarned () {
		return _currency;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param currency WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public BigDecimal getCurrencyEarned (final Currency currency) {
		return _currency == null ? null : _currency
				.getCurrencyEarned (currency);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param currency WRITEME  ewinkelman 
	 * @return WRITEME  ewinkelman 
	 */
	public BigDecimal getCurrencyTotal (final Currency currency) {
		return _currency == null ? null : _currency
				.getCurrencyTotal (currency);
	}
	
	/**
	 * @param completionTimestamp the completionTimestamp to set
	 */
	public void setCompletionTimestamp (final long completionTimestamp) {
		_completionTimestamp = completionTimestamp > 0 ? Long
				.valueOf (completionTimestamp) : null;
		setJSON ("completed", _completionTimestamp);
	}
	
	/**
	 * @param creationTimestamp the creationTimestamp to set
	 */
	public void setCreationTimestamp (final long creationTimestamp) {
		_creationTimestamp = creationTimestamp > 0 ? Long
				.valueOf (creationTimestamp) : null;
		setJSON ("completed", _creationTimestamp);
	}
	
	/**
	 * @param creator the name of the creator
	 */
	public void setCreator (final String creator) {
		_creator = creator;
		setJSON ("creator", creator);
	}
	
	/**
	 * Adds currency earned to the end event
	 * 
	 * @param currencyEarned WRITEME  ewinkelman 
	 */
	public void setCurrencyEarned (
			final ADPCurrencyEarned currencyEarned) {
		_currency = currencyEarned;
		include (currencyEarned);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param scores WRITEME  ewinkelman 
	 */
	public void setHighScores (final ADPHighScores scores) {
		_highScores = scores;
		include (scores);
	}
}
