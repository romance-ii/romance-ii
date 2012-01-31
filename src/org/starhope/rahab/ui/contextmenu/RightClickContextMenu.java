/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Timothy W. Heys
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
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 */
package org.starhope.rahab.ui.contextmenu;

import java.awt.Component;
import java.awt.Point;
import java.awt.event.MouseEvent;

import javax.swing.JPopupMenu;
import javax.swing.Popup;
import javax.swing.SwingUtilities;

import org.starhope.rahab.util.MessageCallBack;

/**
 * WRITEME: Document this type. twheys@gmail.com Dec 31, 2009
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys Timothy W. Heys
 */
public class RightClickContextMenu extends Popup {
	
	/**
	 *
	 */
	private final MessageCallBack callback;
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 31, 2009
	 * </pre>
	 * 
	 * A RightClickContextMenu WRITEME...
	 * 
	 * @param actionCallBack WRITEME
	 */
	public RightClickContextMenu (final MessageCallBack actionCallBack) {
		callback = actionCallBack;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 31, 2009
	 * </pre>
	 * 
	 * TO show WRITEME...
	 * 
	 * @param userNameOfInterest WRITEME
	 * @param me WRITEME
	 */
	public void show (final String userNameOfInterest,
			final MouseEvent me) {
		final Component invoker = me.getComponent ();
		final JPopupMenu menu = new JPopupMenu ();
		menu.add (new CopyNameAction (userNameOfInterest));
		menu.add (new FingerAction (userNameOfInterest, callback));
		menu.add (new ModMessageAction (userNameOfInterest, callback));
		menu.addSeparator ();
		menu.add (new GrantAction (userNameOfInterest, callback));
		menu.add (new GiveNutsAction (userNameOfInterest, callback));
		menu.addSeparator ();
		// menu.add (new ScottieUserAction (userNameOfInterest,
		// callback));
		// menu.addSeparator ();
		menu.add (new WarnUserAction (userNameOfInterest, callback));
		menu.add (new KickUserAction (userNameOfInterest, callback));
		menu.add (new BanUserAction (userNameOfInterest, callback));
		
		final Point pt = SwingUtilities.convertPoint (invoker,
				me.getPoint (), invoker);
		menu.show (invoker, pt.x, pt.y);
	}
	
}
