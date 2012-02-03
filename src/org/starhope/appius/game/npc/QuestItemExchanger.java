/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
package org.starhope.appius.game.npc;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.regex.Pattern;

import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.inventory.Inventory;
import org.starhope.appius.game.inventory.GenericItemReference;
import org.starhope.appius.user.AbstractNonPlayerCharacter;
import org.starhope.appius.user.AbstractUser;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public abstract class QuestItemExchanger extends
AbstractNonPlayerCharacter
{
    /**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 7867396818890658736L;
	/**
     * WRITEME
     */
    protected final Map <Pattern, String> speechReactions =
        new ConcurrentHashMap <Pattern, String> ();
    /**
     * WRITEME
     */
    protected final Map <GenericItemReference, Runnable> itemReactions =
                                                              new ConcurrentHashMap <GenericItemReference, Runnable> ();
    /**
     * WRITEME
     */
    protected final Map <GenericItemReference, GenericItemReference> itemExchanges =
        new ConcurrentHashMap <GenericItemReference, GenericItemReference> ();

    /**
     * WRITEME
     */
    protected final Map <GenericItemReference, GenericItemReference> itemFollowUps =
        new ConcurrentHashMap <GenericItemReference, GenericItemReference> ();

    /**
     * WRITEME: Document this constructor brpocock@star-hope.org
     * 
     * @param login the user name
     * 
     * @throws GameLogicException if the character isn't an NPC or
     *         something like that
     * @throws NotFoundException if the login can't be found, or similar
     * 
     */
    protected QuestItemExchanger (final String login)
    throws NotFoundException, GameLogicException
    {
        super (login);
    }

    protected void dealWith (final AbstractUser who) {
        final Inventory inv = who.getInventory ();
        for (final Map.Entry <GenericItemReference, Runnable> ent : itemReactions
                .entrySet ())
        {
            if (inv.contains (ent.getKey ())) {
                ent.getValue ().run ();
            }
        }
        for (final Map.Entry <GenericItemReference, GenericItemReference> ent : itemExchanges
                .entrySet ())
        {
            if (inv.contains (ent.getKey ())) {
                inv.remove (ent.getKey ());
                inv.add (ent.getValue ());
            }
        }
    }

}
