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

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.user.events.EventType;

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
public class ADPEventResult extends ADPJSON {
	
	/**
	 * Time completed. Equal to null if zero.
	 */
	private Long completionTimestamp;
	
	/**
	 * Time created. Equal to null if zero.
	 */
	private Long creationTimestamp;
	
	/**
	 * Creator
	 */
	private String creator;
	
	/**
	 * What the user earned from this event
	 */
	final private ADPEarning earnings;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int highScoreRank;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private ADPMap <ADPScore> highScores;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private EventType type;
	
	/**
	 * Constructor
	 * 
	 * @param s Listener
	 */
	public ADPEventResult (final ChannelListener s) {
		super ("eventResult", s);
		earnings = new ADPEarning (s);
		include (earnings);
	}
	
	/**
	 * @return the completionTimestamp
	 */
	public long getCompletionTimestamp () {
		return completionTimestamp == null ? 0 : completionTimestamp
				.longValue ();
	}
	
	/**
	 * @return the creationTimestamp
	 */
	public long getCreationTimestamp () {
		return creationTimestamp == null ? 0 : creationTimestamp
				.longValue ();
	}
	
	/**
	 * @return the creatorID
	 */
	public String getCreator () {
		return creator;
	}
	
	/**
	 * @return the earnings
	 */
	public ADPEarning getEarnings () {
		return earnings;
	}
	
	/**
	 * @return the highScoreRank
	 */
	public int getHighScoreRank () {
		return highScoreRank;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	public ADPMap <ADPScore> getHighScores () {
		return highScores;
	}
	
	/**
	 * @return the type
	 */
	public EventType getType () {
		return type;
	}
	
	/**
	 * @param completionTimestamp the completionTimestamp to set
	 */
	public void setCompletionTimestamp (final long completionTimestamp) {
		this.completionTimestamp = completionTimestamp > 0 ? Long
				.valueOf (completionTimestamp) : null;
		setJSON ("completed", completionTimestamp);
	}
	
	/**
	 * @param creationTimestamp the creationTimestamp to set
	 */
	public void setCreationTimestamp (final long creationTimestamp) {
		this.creationTimestamp = creationTimestamp > 0 ? Long
				.valueOf (creationTimestamp) : null;
		setJSON ("completed", creationTimestamp);
	}
	
	/**
	 * @param creator the name of the creator
	 */
	public void setCreator (final String creator) {
		this.creator = creator;
		setJSON ("creator", creator);
	}
	
	/**
	 * Adds currency earned to the end event
	 * 
	 * @param currency WRITEME 
	 * @param currencyAmountEarned WRITEME 
	 */
	public void setCurrencyEarned (final Currency currency,
			final long currencyAmountEarned) {
		earnings.setCurrencyEarned (currency, currencyAmountEarned);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param currencyEarned WRITEME 
	 * @param bigDecimal WRITEME 
	 */
	public void setCurrencyTotal (final Currency currency,
			final long total) {
		earnings.setCurrencyTotal (currency, total);
	}
	
	/**
	 * @param highScoreRank the highScoreRank to set
	 */
	public void setHighScoreRank (final int highScoreRank) {
		this.highScoreRank = highScoreRank;
		setJSON ("gotHighScore", highScoreRank);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param scores WRITEME 
	 */
	public void setHighScores (final ADPMap <ADPScore> scores) {
		highScores = scores;
		include (scores);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param item WRITEME 
	 * @param count WRITEME 
	 */
	public void setItemEarned (final RealItem item, final int count) {
		earnings.setItem (item, count);
	}
	
	/**
	 * @param type the type to set
	 */
	public void setType (final EventType type) {
		this.type = type;
		setJSON ("type", type.getMoniker ());
	}
	
}
