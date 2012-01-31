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
 * @author twheys@gmail.com Timothy W. Heys
 */
package org.starhope.rahab.ui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.net.URL;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JToolBar;

import org.starhope.rahab.Rahab;
import org.starhope.rahab.util.UIActions;

/**
 * WRITEME: Document this type. twheys@gmail.com Feb 3, 2010
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys Timothy W. Heys
 */
public class RahabToolBar extends JToolBar {
	/**
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	final static class ChangeUserActionListener implements
			ActionListener {
		/**
		 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
		 */
		@Override
		public void actionPerformed (final ActionEvent e) {
			UIActions.loginNewUser ();
		}
	}
	
	/**
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	final static class ChangeZoneActionListener implements
			ActionListener {
		/**
		 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
		 */
		@Override
		public void actionPerformed (final ActionEvent e) {
			UIActions.reloadZoneList ();
		}
	}
	
	/**
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	final static class ReloadUserListsActionListener implements
			ActionListener {
		/**
		 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
		 */
		@Override
		public void actionPerformed (final ActionEvent e) {
			UIActions.reloadSpyUserAndRoomLists ();
		}
	}
	
	/**
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	final static class ShiftJournalActionListener implements
			ActionListener {
		/**
		 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
		 */
		@Override
		public void actionPerformed (final ActionEvent e) {
			UIActions.displayShiftJournal ();
		}
	}
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -7630497495393407243L;
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 * 
	 * A SpyToolBar WRITEME...
	 */
	public RahabToolBar () {
		final ShiftJournalActionListener shiftJournalActionListener = new ShiftJournalActionListener ();
		final JButton shiftJournalAction = makeNavigationButton (
				"shift-journal", "Shift Journal Entry",
				"Shift Journal", shiftJournalActionListener);
		final ReloadUserListsActionListener reloadUserListsActionListener = new ReloadUserListsActionListener ();
		final JButton reloadListsAction = makeNavigationButton (
				"reload-lists", "Reload User and Room Lists",
				"Reload User List", reloadUserListsActionListener);
		final ChangeZoneActionListener changeZoneActionListener = new ChangeZoneActionListener ();
		final JButton changeZoneAction = makeNavigationButton (
				"change-zone", "Change Zone", "Change Zone",
				changeZoneActionListener);
		final ChangeUserActionListener changeUserActionListener = new ChangeUserActionListener ();
		final JButton changeUserAction = makeNavigationButton (
				"change-zone", "Log in as a different user",
				"Change User", changeUserActionListener);
		
		add (changeUserAction);
		addSeparator ();
		add (changeZoneAction);
		addSeparator ();
		add (shiftJournalAction);
		add (reloadListsAction);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 * 
	 * TO makeNavigationButton WRITEME...
	 * 
	 * @param imageName WRITEME
	 * @param toolTipText WRITEME
	 * @param altText WRITEME
	 * @param actionListener WRITEME
	 * @return WRITEME
	 */
	protected JButton makeNavigationButton (final String imageName,
			final String toolTipText, final String altText,
			final ActionListener actionListener) {
		// Look for the image.
		final String imgLocation = "images/" + imageName + ".gif";
		final URL imageURL = Rahab.class.getResource (imgLocation);
		
		// Create and initialize the button.
		final JButton button = new JButton ();
		button.setToolTipText (toolTipText);
		button.addActionListener (actionListener);
		
		if (imageURL != null) { // image found
			button.setIcon (new ImageIcon (imageURL, altText));
		} else { // no image found
			button.setText (altText);
			System.err.println ("Resource not found: " + imgLocation);
		}
		
		return button;
	}
}
