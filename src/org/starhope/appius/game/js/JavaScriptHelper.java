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

import org.mozilla.javascript.Context;
import org.mozilla.javascript.ErrorReporter;
import org.mozilla.javascript.EvaluatorException;
import org.mozilla.javascript.debug.DebugFrame;
import org.mozilla.javascript.debug.DebuggableScript;
import org.mozilla.javascript.debug.Debugger;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class JavaScriptHelper implements ErrorReporter, Debugger {
	
	/**
	 * @see org.mozilla.javascript.ErrorReporter#error(java.lang.String,
	 *      java.lang.String, int, java.lang.String, int)
	 */
	@Override
	public void error (final String arg0, final String arg1,
			final int arg2, final String arg3, final int arg4) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		
	}
	
	/**
	 * @see org.mozilla.javascript.debug.Debugger#getFrame(org.mozilla.javascript.Context,
	 *      org.mozilla.javascript.debug.DebuggableScript)
	 */
	@Override
	public DebugFrame getFrame (final Context arg0,
			final DebuggableScript arg1) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		return null;
	}
	
	/**
	 * @see org.mozilla.javascript.debug.Debugger#handleCompilationDone(org.mozilla.javascript.Context,
	 *      org.mozilla.javascript.debug.DebuggableScript,
	 *      java.lang.String)
	 */
	@Override
	public void handleCompilationDone (final Context arg0,
			final DebuggableScript arg1, final String arg2) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		
	}
	
	/**
	 * @see org.mozilla.javascript.ErrorReporter#runtimeError(java.lang.String,
	 *      java.lang.String, int, java.lang.String, int)
	 */
	@Override
	public EvaluatorException runtimeError (final String arg0,
			final String arg1, final int arg2, final String arg3,
			final int arg4) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		return null;
	}
	
	/**
	 * @see org.mozilla.javascript.ErrorReporter#warning(java.lang.String,
	 *      java.lang.String, int, java.lang.String, int)
	 */
	@Override
	public void warning (final String arg0, final String arg1,
			final int arg2, final String arg3, final int arg4) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		
	}
	
}
