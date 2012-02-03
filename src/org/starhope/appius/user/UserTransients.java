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
import java.util.WeakHashMap;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class UserTransients {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
    private static final Map <AbstractUser, UserTransientEffects> effects = new WeakHashMap <AbstractUser, UserTransientEffects> ();

	/**
	 * @param u the user
	 * @return the user's effects
	 */
	public static UserTransientEffects getEffects (final AbstractUser u) {
		UserTransientEffects fx = UserTransients.effects.get (u);
		if (null != fx) {
			return fx;
		}
		fx = new UserTransientEffects (u);
		UserTransients.effects.put (u, fx);
		return fx;
	}
}
