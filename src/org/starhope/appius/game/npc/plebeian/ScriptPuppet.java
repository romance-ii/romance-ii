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
package org.starhope.appius.game.npc.plebeian;

import org.starhope.appius.game.Room;
import org.starhope.appius.user.AbstractUser;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public interface ScriptPuppet extends AbstractUser {
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return the script runner managing this puppet
	 */
	ScriptRunner getScriptRunner ();
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return the avatar label without any NPC instance ID's and such
	 */
	String getShortLabel ();
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param someone someone
	 * @return true, if someone is my buddy
	 */
	boolean isBuddy (AbstractUser someone);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * @param r
	 */
	void seekRoom (Room r);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param key a key for the speech to speak
	 */
	void speakCasually (String key);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param whatNext something to do when we get there
	 * @return the time we'll get there
	 */
	long whenAtTarget (Runnable whatNext);

}
