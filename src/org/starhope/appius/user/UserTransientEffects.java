/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.user;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;

import org.starhope.appius.game.DamageTypeRanks;
import org.starhope.appius.game.inventory.InventoryItem;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class UserTransientEffects {

    /**
     * WRITEME: Document this brpocock@star-hope.org
     */
    public final Set <InventoryItem> addItems = new ConcurrentSkipListSet <InventoryItem> ();
    /**
     * WRITEME: Document this brpocock@star-hope.org
     */
    public final Map<UserStat,Integer> alterStats = new ConcurrentHashMap<UserStat,Integer> ();
    /**
     * WRITEME: Document this brpocock@star-hope.org
     */
    public double heightScalar = 1.0;
    /**
     * Transient removal of items
     */
    public final Set <InventoryItem> removeItems = new ConcurrentSkipListSet <InventoryItem> ();

    /**
     * Transient alterations to the user's defenses
     */
    public DamageTypeRanks alterDefenses;

    /**
     * Create a {@link UserTransientEffects} object for a given user. We
     * actually end up discarding the user, at present.
     * 
     * @param u user
     */
    public UserTransientEffects (final AbstractUser u) {
        // no op
    }

}
