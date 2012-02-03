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
package org.starhope.appius.except;

import java.math.BigDecimal;

/**
 * <p>
 * This exception may be thrown for a purchase attempt by a player who
 * does not have enough (in-game) currency to afford the item being
 * purchased.
 * </p>
 * <p>
 * This has nothing to do with actual real-world money.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
public class NonSufficientFundsException extends Exception {

    /**
     * Java serialisation unique ID
     */
    private static final long serialVersionUID = -6462517287925538686L;
    /**
     * the amount of money lacking
     */
    private final BigDecimal lack;
	/**
	 * their total currency count
	 */
	private final BigDecimal userHas;

    /**
     * @param difference how much more currency is needed to make the
     *        transaction work
     */
    public NonSufficientFundsException (final BigDecimal difference) {
        lack = difference;
		userHas = null;
    }

	/**
	 * @param price the total price
	 * @param userHad how much currency they actually have got
	 */
	public NonSufficientFundsException (final BigDecimal price,
			final BigDecimal userHad) {
		userHas = userHad;
		lack = price.subtract (userHad);
	}

	/**
	 * @see java.lang.Throwable#toString()
	 */
    @Override
    public String toString () {
        return "Non-sufficient funds exception (lacking "
				+ lack.toPlainString ()
				+ ")\n"
				+ (null == userHas ? "" : "(user has "
						+ userHas.toPlainString () + ")")
				+ super.toString ();
    }
}
