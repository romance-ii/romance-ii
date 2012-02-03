/**
 * <p>
 * Copyright © 2010, Tim Heys
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
import java.util.HashMap;

import javax.swing.AbstractAction;
import javax.swing.JOptionPane;

import org.starhope.rahab.util.MessageCallBack;

/**
 * WRITEME: Document this type. twheys@gmail.com Dec 31, 2009
 *
 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
 *
 */
public abstract class RulesAction extends AbstractAction {
	/**
	 *
	 */
	public static final HashMap <String, String> options = new HashMap <String, String> ();

	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 31, 2009
	 */
	private static final long serialVersionUID = 8729943067605304703L;

	static {
		RulesAction.options.put ("Don't share personal information", "per");
		RulesAction.options.put ("Don't share personal "
				+ "information like eMail addresses!", "per.mail");
		RulesAction.options.put ("Don't share personal "
				+ "information like your real name!", "per.name");
		RulesAction.options.put ("Don't share personal "
				+ "information like passwords!", "per.pass");
		RulesAction.options.put ("Don't share personal "
				+ "information like chat and instant "
				+ "messaging information!", "per.chat");
		RulesAction.options.put ("Don't share personal "
				+ "information like your location!", "per.loca");
		RulesAction.options.put ("Don't share personal "
				+ "information like your age!", "per.ages");
		RulesAction.options.put ("Don't share personal "
				+ "information like your birth date!", "per.bday");
		RulesAction.options.put ("Don't share personal "
				+ "information about web sites!", "per.site");
		RulesAction.options.put ("Don't be mean", "bul");
		RulesAction.options.put ("Don't be mean!", "bul.mean");
		RulesAction.options.put ("Don't use bad language", "obs");
		RulesAction.options.put ("Don't be rude!", "obs.rude");
		RulesAction.options.put ("Don't use foul words!", "obs.foul");
		RulesAction.options.put ("No cheating!", "net");
		RulesAction.options.put ("No cheating!", "net.chtr");
		RulesAction.options.put ("Your registration information was not valid",
				"app");
		RulesAction.options.put ("You need your parent's "
				+ "permission in order to chat in Tootsville.",
				"app.parn");
		RulesAction.options.put ("You need to confirm your "
				+ "eMail address in order to chat in Tootsville.",
				"app.mail");
		RulesAction.options.put ("Lying about your "
				+ "birth date is against the law!", "app.ages");
	}

	/**
	 *
	 */
	protected final MessageCallBack actionCallBack;

	/**
	 *
	 */
	protected final String userOfInterest;
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 31, 2009
	 * </pre>
	 * 
	 * A RulesAction WRITEME...
	 * 
	 * @param title WRITEME
	 * @param callback WRITEME
	 * @param userName WRITEME
	 */
	public RulesAction (final String title, final String userName,
			final MessageCallBack callback) {
		super (title);
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
				final String selection = (String) JOptionPane
						.showInputDialog (null, getMoniker () + " "
								+ userOfInterest,
								"Please select an option.",
								JOptionPane.PLAIN_MESSAGE, null,
								RulesAction.options.keySet ().toArray (
										new String [] {}), "");
				if (null == selection) {
					return;
				}
				System.out.println ("Selection is " + selection);
				doCommand (RulesAction.options.get (selection));
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
	 * @param option WRITEME
	 */
	protected abstract void doCommand (String option);

	/**
	 * <pre>
	 * twheys@gmail.com Dec 31, 2009
	 * </pre>
	 *
	 * TO getMoniker WRITEME...
	 *
	 * @return WRITEME
	 */
	protected abstract String getMoniker ();
}
