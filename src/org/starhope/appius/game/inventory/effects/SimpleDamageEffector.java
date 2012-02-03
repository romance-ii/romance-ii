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
package org.starhope.appius.game.inventory.effects;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.DamageTypeRanks;
import org.starhope.appius.game.npc.DamageHitHandler;
import org.starhope.appius.game.npc.Projectile;
import org.starhope.appius.user.AbstractUser;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class SimpleDamageEffector implements DamageHitHandler {

	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -1793684815554397957L;
	/**
	 * The types of damage effected by this
	 */
	private DamageTypeRanks damage;

	/**
	 * Basic ctor
	 * 
	 * @param effect the damage to be effected by this handler.
	 */
	public SimpleDamageEffector (final DamageTypeRanks effect) {
		damage = effect;
	}

	/**
	 * @see org.starhope.appius.game.npc.DamageHitHandler#hitForDamage(org.starhope.appius.game.npc.Projectile, org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void hitForDamage (final Projectile projectile, final AbstractUser victim) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		damage = damage;
		AppiusClaudiusCaecus
				.reportBug ("unimplemented SimpleDamageEffector::hitForDamage (brpocock@star-hope.org, Sep 22, 2010)");

	}

}
