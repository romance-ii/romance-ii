/**
 * <p>
 * Copyright © 2010, Timothy W. Heys
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
 * @author twheys@gmail.com
 */
package org.starhope.rahab.ui.contextmenu;

import java.awt.event.ActionEvent;

import javax.swing.AbstractAction;
import javax.swing.JOptionPane;

import org.starhope.rahab.util.MessageCallBack;

/**
 * WRITEME: Document this type. twheys@gmail.com Dec 31, 2009
 *
 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
 *
 */
public class GrantAction extends AbstractAction {
	/**
	 *
	 */
	private static final long serialVersionUID = -1131387179594633180L;

	/**
	 *
	 */
	private final MessageCallBack actionCallBack;

	/**
	 *
	 */
	protected final String userOfInterest;

	/**
	 * <pre>
	 * twheys@gmail.com Dec 31, 2009
	 * </pre>
	 *
	 * A GiveNutsAction WRITEME...
	 *
	 * @param userName WRITEME
	 * @param callback WRITEME
	 */
	public GrantAction (final String userName,
			final MessageCallBack callback) {
		super ("Grant Item");
		userOfInterest = userName;
		actionCallBack = callback;
	}

	/**
	 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
	 */
	@Override
	public void actionPerformed (final ActionEvent e) {
		javax.swing.SwingUtilities.invokeLater (new Runnable () {
			@Override
			public void run () {
				final String selection = JOptionPane.showInputDialog (
						null, "Grant an item to " + userOfInterest,
						"Please enter an item ID number to grant",
						JOptionPane.PLAIN_MESSAGE);
				if (null == selection) {
					return;
				}
				doCommand (selection);
			}
		});
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 31, 2009
	 * </pre>
	 *
	 * TO doCommand WRITEME...
	 *
	 * @param itemNumber WRITEME
	 */
	protected void doCommand (final String itemNumber) {
		actionCallBack
				.sendCommand ("grant", itemNumber, userOfInterest);
	}
}
