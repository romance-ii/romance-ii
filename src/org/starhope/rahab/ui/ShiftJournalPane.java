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
package org.starhope.rahab.ui;

import java.awt.Dimension;
import java.awt.Label;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

import javax.swing.JButton;
import javax.swing.JPanel;
import javax.swing.JTextArea;

import org.starhope.rahab.Rahab;

/**
 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
 */
public class ShiftJournalPane extends JPanel {
	/**
    *
    */
	private static final long serialVersionUID = 5012737603870817064L;
	/**
    *
    */
	private final JTextArea shiftJournalEntryField;
	/**
    *
    */
	private final JButton submitButton;
	
	/**
    *
    */
	public ShiftJournalPane () {
		shiftJournalEntryField = getTextField ();
		submitButton = getSubmitButton ();
		add (new Label ("Shift Journal Entry"));
		add (shiftJournalEntryField);
		add (submitButton);
	}

	/**
	 * @return WRITEME
	 */
	private JButton getSubmitButton () {
		final JButton button = new JButton ("Submit Journal Entry");
		button.addActionListener (new ActionListener () {
			@Override
			public void actionPerformed (final ActionEvent e) {
				submitEntry ();
			}
		});
		return button;
	}

	/**
	 * @return WRITEME
	 */
	private JTextArea getTextField () {
		final JTextArea textField = new JTextArea ();
		textField.setLineWrap (true);
		textField.setPreferredSize (new Dimension (400, 300));
		textField.addKeyListener (new KeyListener () {

			@Override
			public void keyPressed (final KeyEvent e) {
				// do nothing
			}

			@Override
			public void keyReleased (final KeyEvent e) {
				// do nothing
			}

			@Override
			public void keyTyped (final KeyEvent e) {
				final String journalText = textField.getText ();
				if (2000 < journalText.length ()) {
					textField.setText (journalText.substring (0, 1999));
				}
			}
		});
		return textField;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 28, 2010
	 * </pre>
	 * 
	 * TO submitEntry WRITEME...
	 */
	protected void submitEntry () {
		final String entryText = shiftJournalEntryField.getText ();
		shiftJournalEntryField.setText ("");
		Rahab.addJournalEntry (entryText);
	}
}
