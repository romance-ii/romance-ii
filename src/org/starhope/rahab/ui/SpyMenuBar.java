/**
 * THE SpyMenuBar.java WRITEME...
 */
package org.starhope.rahab.ui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JCheckBoxMenuItem;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;

import org.starhope.rahab.util.UIActions;

/**
 * WRITEME: Document this type. twheys@gmail.com Jan 22, 2010
 * 
 * @author <a h="mailto:twheys@gmail.com">Tim Heys</a>
 */
public class SpyMenuBar extends JMenuBar {
	/**
	 * WRITEME: Document this field. twheys@gmail.com Jan 22, 2010
	 */
	private static final long serialVersionUID = 4213646383231430330L;
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 22, 2010
	 * </pre>
	 * 
	 * A SpyMenuBar WRITEME...
	 */
	public SpyMenuBar () {
		add (getFileMenu ());
		add (getShiftMenu ());
		add (getSpyHelpMenu ());
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 22, 2010
	 * </pre>
	 * 
	 * TO getFileMenu WRITEME...
	 * 
	 * @return the file menu
	 */
	private JMenu getFileMenu () {
		final JMenu fileMenu = new JMenu ("File");
		final JMenuItem scrollMenu = new JCheckBoxMenuItem (
				"Auto Scroll");
		scrollMenu.setSelected (true);
		final JMenuItem echoJoinsMenu = new JCheckBoxMenuItem (
				"Show Join Events");
		echoJoinsMenu.setSelected (true);
		final JMenuItem exitAction = new JMenuItem ("Exit");
		fileMenu.add (scrollMenu);
		fileMenu.add (echoJoinsMenu);
		fileMenu.addSeparator ();
		fileMenu.add (exitAction);
		scrollMenu.addActionListener (new ActionListener () {
			@Override
			public void actionPerformed (final ActionEvent arg0) {
				UIActions.setAutoScroll (scrollMenu.isSelected ());
			}
		});
		echoJoinsMenu.addActionListener (new ActionListener () {
			@Override
			public void actionPerformed (final ActionEvent arg0) {
				UIActions.setEchoJoins (echoJoinsMenu.isSelected ());
			}
		});
		exitAction.addActionListener (new ActionListener () {
			@Override
			public void actionPerformed (final ActionEvent e) {
				UIActions.exit ();
			}
		});

		return fileMenu;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 * 
	 * TO getShiftMenu WRITEME...
	 * 
	 * @return WRITEME
	 */
	private JMenu getShiftMenu () {
		final JMenu shiftMenu = new JMenu ("Shift");
		final JMenuItem shiftJournalAction = new JMenuItem (
				"Shift Journal");
		final JMenuItem reloadListsAction = new JMenuItem (
				"Reload User/Room List");
		final JMenuItem changeZoneAction = new JMenuItem ("Switch Zone");
		final JMenuItem changeUserAction = new JMenuItem ("Switch User");
		shiftMenu.add (shiftJournalAction);
		shiftMenu.addSeparator ();
		shiftMenu.add (reloadListsAction);
		shiftMenu.add (changeZoneAction);
		shiftMenu.add (changeUserAction);
		shiftJournalAction.addActionListener (new ActionListener () {
			@Override
			public void actionPerformed (final ActionEvent e) {
				UIActions.displayShiftJournal ();
			}
		});
		reloadListsAction.addActionListener (new ActionListener () {
			@Override
			public void actionPerformed (final ActionEvent e) {
				UIActions.reloadSpyUserAndRoomLists ();
			}
		});
		changeZoneAction.addActionListener (new ActionListener () {
			@Override
			public void actionPerformed (final ActionEvent e) {
				UIActions.reloadZoneList ();
			}
		});
		changeUserAction.addActionListener (new ActionListener () {
			@Override
			public void actionPerformed (final ActionEvent e) {
				UIActions.loginNewUser ();
			}
		});
		return shiftMenu;

	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 22, 2010
	 * </pre>
	 * 
	 * TO getSpyHelpMenu WRITEME...
	 * 
	 * @return the help menu
	 */
	private JMenu getSpyHelpMenu () {
		final JMenu helpMenu = new JMenu ("Help");
		final JMenuItem opCommandsAction = new JMenuItem (
				"Operator Commands");
		helpMenu.add (opCommandsAction);
		opCommandsAction.addActionListener (new ActionListener () {
			@Override
			public void actionPerformed (final ActionEvent arg0) {
				UIActions.showOpCommandsHelp ();
			}
		});
		return helpMenu;
	}
}

