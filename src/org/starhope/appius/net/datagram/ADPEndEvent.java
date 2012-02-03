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

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.mb.Currency;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman
 *
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
	 * WRITEME: Document this ewinkelman
	 */
	private ADPHighScores _highScores;
	
	/**
	 * Constructor
	 * 
	 * @param s Listener
	 */
	public ADPEndEvent (ChannelListener s) {
		super ("endEvent", s);
	}
	
	/**
	 * @return the completionTimestamp
	 */
	public long getCompletionTimestamp () {
		return _completionTimestamp == null ? 0 : _completionTimestamp
				.longValue ();
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
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param currency
	 * @return
	 */
	public BigDecimal getCurrencyEarned (Currency currency) {
		return _currency == null ? null : _currency
				.getCurrencyEarned (currency);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param currency
	 * @return
	 */
	public BigDecimal getCurrencyTotal (Currency currency) {
		return _currency == null ? null : _currency
				.getCurrencyTotal (currency);
	}
	
	/**
	 * @param completionTimestamp the completionTimestamp to set
	 */
	public void setCompletionTimestamp (long completionTimestamp) {
		_completionTimestamp = completionTimestamp > 0 ? Long
				.valueOf (completionTimestamp) : null;
		setJSON ("completed", _completionTimestamp);
	}
	
	/**
	 * @param creationTimestamp the creationTimestamp to set
	 */
	public void setCreationTimestamp (long creationTimestamp) {
		_creationTimestamp = creationTimestamp > 0 ? Long
				.valueOf (creationTimestamp) : null;
		setJSON ("completed", _creationTimestamp);
	}
	
	/**
	 * @param creator the name of the creator
	 */
	public void setCreator (String creator) {
		_creator = creator;
		setJSON ("creator", creator);
	}
	
	/**
	 * Adds currency earned to the end event
	 * 
	 * @param currencyEarned
	 */
	public void setCurrencyEarned (ADPCurrencyEarned currencyEarned) {
		_currency = currencyEarned;
		include (currencyEarned);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @return
	 */
	public ADPCurrencyEarned getCurrencyEarned () {
		return _currency;
	}

	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param scores
	 */
	public void setHighScores (ADPHighScores scores) {
		_highScores = scores;
		include (scores);
	}
}
