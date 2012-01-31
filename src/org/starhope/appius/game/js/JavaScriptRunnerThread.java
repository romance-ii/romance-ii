/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
 * License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */

package org.starhope.appius.game.js;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Locale;

import org.mozilla.javascript.Context;
import org.mozilla.javascript.Script;
import org.mozilla.javascript.Scriptable;
import org.mozilla.javascript.ScriptableObject;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.user.AbstractUser;

/**
 * A thread executing JavaScript code
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class JavaScriptRunnerThread extends Thread {
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final JavaScriptHelper helper = new JavaScriptHelper ();
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final Scriptable globalScope;
	/**
	 * JavaScript context
	 */
	private final Context jsCx;
	
	/**
	 * compiled script
	 */
	private final Script myScript;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param scriptName WRITEME
	 * @param user WRITEME
	 * @throws FileNotFoundException duh.
	 * @throws IOException duh.
	 */
	public JavaScriptRunnerThread (final String scriptName,
			final AbstractUser user) throws IOException {
		super (AppiusClaudiusCaecus.getThreadGroup ("JavaScript"),
				"JavaScript/" + scriptName);
		jsCx = Context.enter ();
		jsCx.setErrorReporter (JavaScriptRunnerThread.helper);
		jsCx.setDebugger (JavaScriptRunnerThread.helper, jsCx);
		jsCx.setLanguageVersion (Context.VERSION_1_7);
		jsCx.setLocale (Locale.ENGLISH);
		globalScope = jsCx.initStandardObjects ();
		ScriptableObject.putProperty (globalScope, "user",
				Context.javaToJS (user, globalScope));
		ScriptableObject.putProperty (globalScope, "room",
				Context.javaToJS (user.getRoom (), globalScope));
		ScriptableObject.putProperty (globalScope, "zone",
				Context.javaToJS (user.getZone (), globalScope));
		final FileReader in = new FileReader ("/etc/appius/"
				+ scriptName + ".js");
		myScript = jsCx.compileReader (in, scriptName, 1, null);
	}
	
	/**
	 * @see java.lang.Thread#run()
	 */
	@Override
	public void run () {
		myScript.exec (jsCx, globalScope);
		AppiusClaudiusCaecus.getCharon ().addZombie (this);
	}
	
}
