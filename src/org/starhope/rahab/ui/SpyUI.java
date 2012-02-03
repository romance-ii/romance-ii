/**
 * <p>
 * Copyright © 2010, twheys@gmail.com
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

import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.JButton;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextField;
import javax.swing.JTextPane;
import javax.swing.JTree;
import javax.swing.ScrollPaneConstants;
import javax.swing.text.BadLocationException;
import javax.swing.text.Style;
import javax.swing.text.StyleConstants;
import javax.swing.text.StyleContext;
import javax.swing.text.StyledDocument;
import javax.swing.tree.DefaultMutableTreeNode;

import org.starhope.rahab.ui.contextmenu.RightClickContextMenu;
import org.starhope.rahab.util.MessageCallBack;

/**
 * WRITEME: Document this type. twheys@gmail.com Dec 29, 2009
 * 
 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
 */
public class SpyUI extends JPanel {
	/**
	 *
	 */
	private static final String BLACKLIST_TEXT_STYLE = "blacklist-display-text-style";
	/**
	 *
	 */
	private static final String ERROR_TEXT_STYLE = "error-text-style";
	/**
	 *
	 */
	private static final String GRAY_TEXT_STYLE = "gray-text-style";
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 31, 2009
	 */
	private static final int MAX_HISTORY_TOKENS = 60;
	/**
	 *
	 */
	private static final String MOD_DISPLAY_TEXT_STYLE = "mod-text-style";
	/**
	 *
	 */
	private static final String MODERATOR_NAME_STYLE = "moderator-style";
	/**
	 *
	 */
	private static final String NORMAL_TEXT_STYLE = "display-text-style";

	/**
	 *
	 */
	private static final String PUBLIC_USER_NAME_STYLE = "public-user-style";

	/**
	 *
	 */
	private static final String REDLIST_TEXT_STYLE = "redlist-display-text-style";
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 29, 2009
	 */
	private static final long serialVersionUID = -6126668445890875030L;
	/**
	 *
	 */
	private static final String SYSTEM_NAME_STYLE = "system-message-style";
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 30, 2009
	 */
	private static final String SYSTEM_SPEAKER = "System";
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 5, 2010
	 * </pre>
	 * 
	 * TO getScrollForTextPane WRITEME...
	 * 
	 * @param textPane WRITEME
	 * @return WRITEME
	 */
	private static JScrollPane getScrollForTextPane (
			final Component textPane) {
		final JScrollPane textPaneScroll = new JScrollPane (textPane,
				ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED,
				ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
		textPaneScroll.setAutoscrolls (true);
		textPaneScroll.setPreferredSize (new Dimension (600, 575));
		return textPaneScroll;
	}

	/**
	 *
	 */
	private String currentZone;

	/**
	 * WRITEME: Document this field. twheys@gmail.com Jan 5, 2010
	 */
	private final DateFormat dateFormatter = new SimpleDateFormat (
			"hh:mm:ss");

	/**
    *
    */
	private final StyledDocument gameMailStyledDocument;

	/**
    *
    */
	private final JTextPane gameMailTextPane;

	/**
	 *
	 */
	private final Vector <String> history = new Vector <String> ();
	/**
	 *
	 */
	private int historyTracker = -1;
	/**
	 *
	 */
	private DefaultMutableTreeNode houseListRoot;
	/**
	 *
	 */
	protected JTextField inputTextArea;

	/**
	 *
	 */
	Logger logger = Logger.getLogger (SpyUI.class.getName ());

	/**
	 *
	 */
	private final MessageCallBack messageCallBack;

	/**
	 *
	 */
	private DefaultMutableTreeNode modListRoot;
	/**
	 *
	 */
	protected final RightClickContextMenu rightClickContext;

	/**
	 *
	 */
	private JTree roomList;

	/**
	 *
	 */
	private DefaultMutableTreeNode roomListRoot;

	/**
	 *
	 */
	private DefaultMutableTreeNode root;

	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 31, 2009
	 */
	private final MouseListener USER_LIST_MOUSE_LISTENER = new MouseListener () {

		private void do_Action (final MouseEvent e) {
			if (e.isPopupTrigger ()
					&& !getUserList ().isSelectionEmpty ()) {
				rightClickContext.show (getUserList ()
						.getSelectedValue ().toString (), e);
			}
		}

		@Override
		public void mouseClicked (final MouseEvent arg0) {
			// do nothing
		}

		@Override
		public void mouseEntered (final MouseEvent arg0) {
			// do nothing
		}

		@Override
		public void mouseExited (final MouseEvent arg0) {
			// do nothing
		}

		@Override
		public void mousePressed (final MouseEvent e) {
			do_Action (e);
		}

		@Override
		public void mouseReleased (final MouseEvent e) {
			do_Action (e);
		}
	};
	/**
	 *
	 */
	private JList userList;

	/**
	 *
	 */
	private Vector <String> userListVector;
	/**
	 *
	 */
	private final StyledDocument zoneChatStyledDocument;
	/**
	 *
	 */
	private final JTextPane zoneChatTextPane;
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 * 
	 * A SpyUI WRITEME...
	 * 
	 * @param actionCallBack WRITEME
	 * @param zoneName WRITEME
	 */
	public SpyUI (final MessageCallBack actionCallBack,
			final String zoneName) {
		currentZone = zoneName;
		messageCallBack = actionCallBack;
		rightClickContext = new RightClickContextMenu (actionCallBack);
		logger.setLevel (Level.ALL);
		final GridBagLayout layoutManager = new GridBagLayout ();
		logger.fine ("Setting Layout Manger for SpyUI");
		setLayout (layoutManager);

		zoneChatTextPane = new JTextPane ();
		zoneChatTextPane.setEditable (false);
		zoneChatStyledDocument = zoneChatTextPane.getStyledDocument ();
		gameMailTextPane = new JTextPane ();
		gameMailTextPane.setEditable (false);
		gameMailStyledDocument = zoneChatTextPane.getStyledDocument ();
		final JTabbedPane tabbedPanes = getTabbedPane ();

		final JSplitPane horizontalSplitPane = new JSplitPane (
				JSplitPane.HORIZONTAL_SPLIT);
		final JSplitPane verticalSplitPane = new JSplitPane (
				JSplitPane.VERTICAL_SPLIT);

		horizontalSplitPane.setLeftComponent (verticalSplitPane);
		horizontalSplitPane.setRightComponent (getUserLists ());

		verticalSplitPane.setTopComponent (tabbedPanes);
		verticalSplitPane.setBottomComponent (getInputField ());

		add (horizontalSplitPane);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO addLeafToTree WRITEME...
	 * 
	 * @param leafName WRITEME
	 * @param branchName WRITEME
	 * @param rootTree WRITEME
	 */
	private void addLeafToTree (final String leafName,
			final String branchName,
			final DefaultMutableTreeNode rootTree) {
		removeLeafFromTree (leafName, roomListRoot);
		removeLeafFromTree (leafName, modListRoot);
		removeLeafFromTree (leafName, houseListRoot);
		if ("nowhere".equals (branchName)) {
			try {
				throw new Exception ();
			} catch (final Exception e) {
				e.printStackTrace ();
			}
		}
		DefaultMutableTreeNode roomBranch;
		try {
			roomBranch = getBranchByNameFromRoot (branchName, rootTree);
		} catch (final Exception e) {
			logger.info (e.getMessage ());
			roomBranch = new DefaultMutableTreeNode (branchName);
			logger.info ("Adding new branch named: " + branchName
					+ " to tree " + rootTree.getUserObject ());
			rootTree.add (roomBranch);
		}
		final DefaultMutableTreeNode newLeaf = new DefaultMutableTreeNode (
				leafName);
		roomBranch.add (newLeaf);
		logger.info ("Added " + newLeaf.getUserObject () + " to "
				+ roomBranch.getUserObject ());
		refreshRoomList ();
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO addStylesToDocument WRITEME...
	 * 
	 * @param document WRITEME
	 */
	protected void addStylesToDocument (final StyledDocument document) {
		final Style defaultStyle = document
				.getStyle (StyleContext.DEFAULT_STYLE);
		final int fontSize = 14;
		final String fontName = "monospaced";

		// Create and add the style for displaying public user's names
		final Style userNameStyle = document.addStyle (
				SpyUI.PUBLIC_USER_NAME_STYLE, defaultStyle);
		StyleConstants.setFontSize (userNameStyle, fontSize);
		StyleConstants.setFontFamily (userNameStyle, fontName);
		StyleConstants.setForeground (userNameStyle, Color.BLUE);
		StyleConstants.setBold (userNameStyle, true);

		// Create and add the style for displaying moderator's names
		final Style modNameStyle = document.addStyle (
				SpyUI.MODERATOR_NAME_STYLE, defaultStyle);
		StyleConstants.setFontSize (modNameStyle, fontSize);
		StyleConstants.setFontFamily (modNameStyle, fontName);
		StyleConstants.setForeground (modNameStyle, Color.RED);
		StyleConstants.setBold (modNameStyle, true);

		// Create and add the style for displaying moderator's names
		final Style errorTextStyle = document.addStyle (
				SpyUI.ERROR_TEXT_STYLE, defaultStyle);
		StyleConstants.setFontSize (errorTextStyle, fontSize);
		StyleConstants.setFontFamily (errorTextStyle, fontName);
		StyleConstants.setForeground (errorTextStyle, Color.RED);
		StyleConstants.setBold (errorTextStyle, false);

		// Create and add the style for displaying system messages
		final Style sysNameStyle = document.addStyle (
				SpyUI.SYSTEM_NAME_STYLE, defaultStyle);
		StyleConstants.setFontSize (sysNameStyle, fontSize);
		StyleConstants.setFontFamily (sysNameStyle, fontName);
		StyleConstants.setForeground (sysNameStyle, Color.DARK_GRAY);
		StyleConstants.setBold (sysNameStyle, true);

		// Create and add the style for displaying text
		final Style displayText = document.addStyle (SpyUI.NORMAL_TEXT_STYLE,
				defaultStyle);
		StyleConstants.setFontSize (displayText, fontSize);
		StyleConstants.setFontFamily (displayText, fontName);
		StyleConstants.setForeground (displayText, Color.BLACK);
		StyleConstants.setBold (displayText, false);

		// Create and add the style for displaying text
		final Style blackListText = document.addStyle (
				SpyUI.BLACKLIST_TEXT_STYLE, defaultStyle);
		StyleConstants.setFontSize (blackListText, fontSize);
		StyleConstants.setFontFamily (blackListText, fontName);
		StyleConstants.setForeground (blackListText, Color.GRAY);
		StyleConstants.setBold (blackListText, false);

		// Create and add the style for displaying text
		final Style redListText = document.addStyle (
				SpyUI.REDLIST_TEXT_STYLE, defaultStyle);
		StyleConstants.setFontSize (redListText, fontSize);
		StyleConstants.setFontFamily (redListText, fontName);
		StyleConstants.setForeground (redListText, Color.RED);
		StyleConstants.setBold (redListText, false);

		// Create and add the style for displaying text
		final Style grayText = document.addStyle (SpyUI.GRAY_TEXT_STYLE,
				defaultStyle);
		StyleConstants.setFontSize (grayText, fontSize);
		StyleConstants.setFontFamily (grayText, fontName);
		StyleConstants.setForeground (grayText, Color.DARK_GRAY);
		StyleConstants.setBold (grayText, false);

		// Create and add the style for displaying text
		final Style modDisplayText = document.addStyle (
				SpyUI.MOD_DISPLAY_TEXT_STYLE, defaultStyle);
		StyleConstants.setFontSize (modDisplayText, fontSize);
		StyleConstants.setFontFamily (modDisplayText, fontName);
		StyleConstants.setForeground (modDisplayText, Color.BLACK);
		StyleConstants.setBold (modDisplayText, true);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 31, 2009
	 * </pre>
	 * 
	 * TO addToHistory WRITEME...
	 * 
	 * @param message WRITEME
	 */
	public void addToHistory (final String message) {
		if (SpyUI.MAX_HISTORY_TOKENS < history.size ()) {
			history.remove (history.firstElement ());
		}
		historyTracker = history.size () + 1;
		history.add (message);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO addUserToRoom WRITEME...
	 * 
	 * @param userName WRITEME
	 * @param room WRITEME
	 */
	public void addUserToHouse (final String userName, final String room) {
		logger.info ("Adding " + userName + " to " + room);
		addLeafToTree (userName, room, houseListRoot);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 31, 2009
	 * </pre>
	 * 
	 * TO addUserToMOD WRITEME...
	 * 
	 * @param userName WRITEME
	 */
	public void addUserToMOD (final String userName) {
		logger.info ("Adding " + userName + " to Moderator List");
		addLeafToTree (userName, "MODERATORS", modListRoot);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO addUserToRoom WRITEME...
	 * 
	 * @param userName WRITEME
	 * @param room WRITEME
	 */
	public void addUserToRoom (final String userName, final String room) {
		logger.info ("Adding " + userName + " to " + room);
		addLeafToTree (userName, room, roomListRoot);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO addUserToUserList WRITEME...
	 * 
	 * @param userName WRITEME
	 */
	public void addUserToUserList (final String userName) {
		userListVector.remove (userName);
		userListVector.add (userName);
		userList.setListData (userListVector);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO getRoomBranchByRoomName WRITEME...
	 * 
	 * @param room WRITEME
	 * @param rootTree WRITEME
	 * @return WRITEME
	 * @throws Exception WRITEME
	 */
	private DefaultMutableTreeNode getBranchByNameFromRoot (
			final String room, final DefaultMutableTreeNode rootTree)
			throws Exception {
		return getTreeBranchByUserObject (room, rootTree);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 * 
	 * TO getInputField WRITEME...
	 * 
	 * @return a constructed input field
	 */
	private JPanel getInputField () {
		final JPanel inputField = new JPanel ();
		inputTextArea = new JTextField ("", 40);
		inputTextArea.setPreferredSize (new Dimension (500, 20));
		final JButton submitButton = new JButton ("Submit");
		submitButton.setPreferredSize (new Dimension (100, 20));
		submitButton.addActionListener (new ActionListener () {
			@Override
			public void actionPerformed (final ActionEvent ev) {
				sendPublicMessage ();
			}
		});
		inputTextArea.addKeyListener (new KeyListener () {
			@Override
			public void keyPressed (final KeyEvent ev) {
				if (KeyEvent.VK_ENTER == ev.getKeyCode ()) {
					sendPublicMessage ();
					ev.consume ();
				} else if (KeyEvent.VK_UP == ev.getKeyCode ()) {
					inputTextArea
							.setText (getNextTokenInHistory (true));
				} else if (KeyEvent.VK_DOWN == ev.getKeyCode ()) {
					inputTextArea
							.setText (getNextTokenInHistory (false));
				}
			}

			@Override
			public void keyReleased (final KeyEvent ev) {
				// do nothing
			}

			@Override
			public void keyTyped (final KeyEvent ev) {
				// do nothing
			}
		});
		inputField.add (inputTextArea);
		inputField.add (submitButton);
		inputField.setPreferredSize (new Dimension (600, 20));
		return inputField;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 5, 2010
	 * </pre>
	 * 
	 * TO getLogo WRITEME...
	 * 
	 * @return WRITEME
	 */
	private String getLogo () {
		return "  Tootsville Spy";
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 31, 2009
	 * </pre>
	 * 
	 * TO getNextTokenInHistory WRITEME...
	 * 
	 * @param olderToken WRITEME
	 * @return WRITEME
	 */
	protected String getNextTokenInHistory (final boolean olderToken) {
		if (olderToken) {
			historyTracker-- ;
		} else {
			historyTracker++ ;
		}
		if (0 > historyTracker) {
			historyTracker = 0;
		} else if (history.size () <= historyTracker) {
			historyTracker = history.size ();
			return "";
		}
		history.get (historyTracker);
		return history.get (historyTracker);

	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO getRoomListTab WRITEME...
	 * 
	 * @return WRITEME
	 */
	private JScrollPane getRoomListTab () {
		roomListRoot = new DefaultMutableTreeNode ("Rooms");
		houseListRoot = new DefaultMutableTreeNode ("Houses");
		modListRoot = new DefaultMutableTreeNode ("Moderators");
		root = new DefaultMutableTreeNode (currentZone);
		roomList = new JTree (root);
		root.add (roomListRoot);
		root.add (houseListRoot);
		root.add (modListRoot);
		final JScrollPane roomListScroll = new JScrollPane (roomList,
				ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED,
				ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
		roomListScroll.setPreferredSize (new Dimension (300, 600));
		refreshRoomList ();
		return roomListScroll;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 5, 2010
	 * </pre>
	 * 
	 * TO getChatTabbedPane WRITEME...
	 * 
	 * @return WRITEME
	 */
	private JTabbedPane getTabbedPane () {
		final JScrollPane zoneChatTextPaneScroll = SpyUI.getScrollForTextPane (zoneChatTextPane);
		addStylesToDocument (zoneChatStyledDocument);
		final JScrollPane gameMailTextPaneScroll = SpyUI.getScrollForTextPane (gameMailTextPane);
		addStylesToDocument (gameMailStyledDocument);
		final JTabbedPane chatTabs = new JTabbedPane ();
		chatTabs.addTab ("Zone Chat", zoneChatTextPaneScroll);
		chatTabs.addTab ("Game Mail", gameMailTextPaneScroll);
		try {
			zoneChatStyledDocument.insertString (zoneChatStyledDocument
					.getLength (), getLogo (), zoneChatStyledDocument
					.getStyle (SpyUI.SYSTEM_NAME_STYLE));
		} catch (final BadLocationException e) {
			e.printStackTrace ();
		}
		return chatTabs;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO getRoomBranchByRoomName WRITEME...
	 * 
	 * @param room WRITEME
	 * @param leaf WRITEME
	 * @return WRITEME
	 * @throws Exception WRITEME
	 */
	private DefaultMutableTreeNode getTreeBranchByUserObject (
			final String room, final DefaultMutableTreeNode leaf)
			throws Exception {
		final Enumeration <?> children = leaf.children ();
		while (children.hasMoreElements ()) {
			final DefaultMutableTreeNode possibleRoomBranch = (DefaultMutableTreeNode) children
					.nextElement ();
			if (possibleRoomBranch.getUserObject ().equals (room)) {
				return possibleRoomBranch;
			}
		}
		throw new Exception ("No Room Exists By That Name: " + room);
	}

	/**
	 * @return the userList
	 */
	protected JList getUserList () {
		return userList;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 * 
	 * TO getUserLists WRITEME...
	 * 
	 * @return a constructed JTabbedPane to display a list of users in
	 *         alphabetical order and sorted by what room they're in.
	 */
	private JTabbedPane getUserLists () {
		final JTabbedPane userListTabs = new JTabbedPane ();
		final JScrollPane userListTab = getUserListTab ();
		final JScrollPane roomListTab = getRoomListTab ();
		userListTabs.addTab ("User List", userListTab);
		userListTabs.addTab ("Room List", roomListTab);
		return userListTabs;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO getUserListTab WRITEME...
	 * 
	 * @return WRITEME
	 */
	private JScrollPane getUserListTab () {
		userList = new JList ();
		userList.addMouseListener (USER_LIST_MOUSE_LISTENER);
		final JScrollPane userJListScroll = new JScrollPane (userList,
				ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED,
				ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
		userJListScroll.setPreferredSize (new Dimension (300, 600));
		return userJListScroll;
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO initListOfUsers WRITEME...
	 * 
	 * @param newUserListVector WRITEME
	 */
	public void initListOfUsers (final Vector <String> newUserListVector) {
		userListVector = newUserListVector;
		logger.info ("Initializing user list: "
				+ userListVector.toString ());
		userList.setListData (userListVector);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 5, 2010
	 * </pre>
	 * 
	 * TO refreshRoomList WRITEME...
	 * 
	 * @param jTree WRITEME
	 */
	private void refreshJTree (final JTree jTree) {
		final int rowCount = jTree.getRowCount ();
		logger.info ("Refreshing roomList with a row count of "
				+ rowCount);
		jTree.collapseRow (0);
		jTree.expandRow (0);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 5, 2010
	 * </pre>
	 * 
	 * TO refreshRoomList WRITEME...
	 */
	private void refreshRoomList () {
		refreshJTree (roomList);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO removeUserFromRoomList WRITEME...
	 * 
	 * @param userName WRITEME WRITEME
	 * @param rootTree WRITEME WRITEME
	 */
	public void removeLeafFromTree (final String userName,
			final DefaultMutableTreeNode rootTree) {
		final Enumeration <?> rooms = rootTree.children ();
		while (rooms.hasMoreElements ()) {
			final DefaultMutableTreeNode room = (DefaultMutableTreeNode) rooms
					.nextElement ();
			final Enumeration <?> users = room.children ();
			while (users.hasMoreElements ()) {
				final DefaultMutableTreeNode user = (DefaultMutableTreeNode) users
						.nextElement ();
				if (user.getUserObject ().equals (userName)) {
					logger.info ("Removing user ("
							+ user.getUserObject ()
							+ ") from room list");
					room.remove (user);
					if (0 == room.getChildCount ()) {
						logger.info ("Removing room ("
								+ room.getUserObject ()
								+ ") from room list");
						rootTree.remove (room);
					}
				}
			}
		}
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO removeUserFromRoomList WRITEME...
	 * 
	 * @param userName WRITEME
	 */
	public void removeUserFromRoomList (final String userName) {
		removeLeafFromTree (userName, roomListRoot);
		removeLeafFromTree (userName, houseListRoot);
		removeLeafFromTree (userName, modListRoot);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO scrollOutputToBottom WRITEME...
	 */
	private void scrollZoneOutputToBottom () {
		if (zoneChatTextPane.getAutoscrolls ()) {
			zoneChatTextPane.setCaretPosition (zoneChatStyledDocument
					.getLength ());
		}
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO sendPublicMessage WRITEME...
	 */
	protected void sendPublicMessage () {
		final String message = inputTextArea.getText ();
		inputTextArea.setText ("");
		messageCallBack.sendMessage (message);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO setTreeRoot WRITEME...
	 * 
	 * @param zone WRITEME
	 */
	public void setTreeRoot (final String zone) {
		currentZone = zone;
		root.setUserObject (zone);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 8, 2010
	 * </pre>
	 * 
	 * TO setZoneChatAutoScrolls set the autoscrolls on the
	 * zoneChatTextPane
	 * 
	 * @param autoscrolls WRITEME
	 */
	public void setZoneChatAutoScrolls (final boolean autoscrolls) {
		zoneChatTextPane.setAutoscrolls (autoscrolls);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Mar 10, 2010
	 * </pre>
	 * 
	 * TO showSaidMessage WRITEME...
	 * 
	 * @param speaker WRITEME
	 * @param room WRITEME
	 * @param message WRITEME
	 */
	public void showBlackListMessage (final String speaker,
			final String room, final String message) {
		final Style userNameStyle = zoneChatStyledDocument
				.getStyle (SpyUI.PUBLIC_USER_NAME_STYLE);
		final Style textStyle = zoneChatStyledDocument
				.getStyle (SpyUI.BLACKLIST_TEXT_STYLE);
		showMessage (speaker, room,
				"filtered{" + message.trim () + "}", userNameStyle,
				textStyle);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO showPopupDialog WRITEME...
	 * 
	 * @param title WRITEME
	 * @param label WRITEME
	 * @param message WRITEME
	 */
	public void showDialog (final String title, final String label,
			final String message) {
		final String dialog = String.format ("%s%n%s %s", title, label,
				message);
		showErrorMessage (dialog);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO showErrorMessage WRITEME...
	 * 
	 * @param message WRITEME
	 */
	public void showErrorMessage (final String message) {
		try {
			final String userNameStyle = SpyUI.SYSTEM_NAME_STYLE;
			final String userNameDisplayText = SpyUI.SYSTEM_SPEAKER + " ";
			zoneChatStyledDocument.insertString (zoneChatStyledDocument
					.getLength (), "\n", zoneChatStyledDocument
					.getStyle (SpyUI.ERROR_TEXT_STYLE));
			zoneChatStyledDocument.insertString (zoneChatStyledDocument
					.getLength (), userNameDisplayText,
					zoneChatStyledDocument.getStyle (userNameStyle));
			zoneChatStyledDocument.insertString (zoneChatStyledDocument
					.getLength (), message, zoneChatStyledDocument
					.getStyle (SpyUI.ERROR_TEXT_STYLE));
		} catch (final BadLocationException e) {
			e.printStackTrace ();
		}
		scrollZoneOutputToBottom ();
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 * 
	 * TO showMessage WRITEME...
	 * 
	 * @param speaker WRITEME
	 * @param room WRITEME
	 * @param message WRITEME
	 * @param userNameStyle WRITEME
	 * @param displayTextStyle WRITEME
	 */
	private void showMessage (final String speaker, final String room,
			final String message, final Style userNameStyle,
			final Style displayTextStyle) {
		final String timeStamp = dateFormatter.format (new Date (System
				.currentTimeMillis ()));
		String userNameDisplayText = String.format ("(%s)%s@%s:",
				timeStamp, speaker, room);
		if (SpyUI.SYSTEM_SPEAKER.equals (speaker)) {
			userNameDisplayText = String.format ("(%s)%s ", timeStamp,
					speaker);
		}
		logger.info ("Showing a message.  Speaker: " + speaker
				+ "  Room: " + room + "  Message: " + message
				+ "  using Style Name: " + userNameStyle);
		logger.info ("##" + userNameDisplayText + message);
		try {
			zoneChatStyledDocument.insertString (zoneChatStyledDocument
					.getLength (), "\n", zoneChatStyledDocument
					.getStyle (SpyUI.ERROR_TEXT_STYLE));
			zoneChatStyledDocument.insertString (zoneChatStyledDocument
					.getLength (), userNameDisplayText, userNameStyle);
			zoneChatStyledDocument.insertString (zoneChatStyledDocument
					.getLength (), message, displayTextStyle);
		} catch (final BadLocationException e) {
			e.printStackTrace ();
		}
		scrollZoneOutputToBottom ();
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Mar 10, 2010
	 * </pre>
	 * 
	 * TO showSaidMessage WRITEME...
	 * 
	 * @param speaker WRITEME
	 * @param message WRITEME
	 */
	public void showModMessage (final String speaker,
			final String message) {
		final Style userNameStyle = zoneChatStyledDocument
				.getStyle (SpyUI.MODERATOR_NAME_STYLE);
		final Style textStyle = zoneChatStyledDocument
				.getStyle (SpyUI.MOD_DISPLAY_TEXT_STYLE);
		showMessage (speaker, "SPY", message, userNameStyle, textStyle);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Mar 10, 2010
	 * </pre>
	 * 
	 * TO showSaidMessage WRITEME...
	 * 
	 * @param speaker WRITEME
	 * @param room WRITEME
	 * @param message WRITEME
	 */
	public void showRedListMessage (final String speaker,
			final String room, final String message) {
		final Style userNameStyle = zoneChatStyledDocument
				.getStyle (SpyUI.PUBLIC_USER_NAME_STYLE);
		final Style textStyle = zoneChatStyledDocument
				.getStyle (SpyUI.REDLIST_TEXT_STYLE);
		showMessage (speaker, room,
				"filtered{" + message.trim () + "}", userNameStyle,
				textStyle);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 5, 2010
	 * </pre>
	 * 
	 * TO showReport WRITEME...
	 * 
	 * @param reportingUser WRITEME
	 * @param reportedUser WRITEME
	 * @param room WRITEME
	 */
	public void showReport (final String reportingUser,
			final String reportedUser, final String room) {
		final String timeStamp = dateFormatter.format (new Date (System
				.currentTimeMillis ()));
		final String userNameDisplayText = String.format ("(%s)%s ",
				timeStamp, SpyUI.SYSTEM_SPEAKER);
		final String reportMessage = String.format (
				"%s was reported by %s in room %s.", reportedUser,
				reportingUser, room);
		try {
			zoneChatStyledDocument.insertString (zoneChatStyledDocument
					.getLength (), "\n", zoneChatStyledDocument
					.getStyle (SpyUI.NORMAL_TEXT_STYLE));
			zoneChatStyledDocument
					.insertString (zoneChatStyledDocument.getLength (),
							userNameDisplayText, zoneChatStyledDocument
									.getStyle (SpyUI.SYSTEM_NAME_STYLE));
			zoneChatStyledDocument.insertString (zoneChatStyledDocument
					.getLength (), reportMessage,
					zoneChatStyledDocument.getStyle (SpyUI.ERROR_TEXT_STYLE));
		} catch (final BadLocationException e) {
			e.printStackTrace ();
		}
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Mar 10, 2010
	 * </pre>
	 * 
	 * TO showSaidMessage WRITEME...
	 * 
	 * @param speaker WRITEME
	 * @param room WRITEME
	 * @param message WRITEME
	 */
	public void showSaidMessage (final String speaker,
			final String room, final String message) {
		if ("$Eaves".equals (room)) {
			showModMessage (speaker, message);
			return;
		}
		final Style userNameStyle = zoneChatStyledDocument
				.getStyle (SpyUI.PUBLIC_USER_NAME_STYLE);
		final Style textStyle = zoneChatStyledDocument
				.getStyle (SpyUI.NORMAL_TEXT_STYLE);
		showMessage (speaker, room, message, userNameStyle, textStyle);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 * 
	 * TO showMessage WRITEME...
	 * 
	 * @param systemMessage WRITEME
	 */
	public void showSystemMessage (final String systemMessage) {
		final Style userNameStyle = zoneChatStyledDocument
				.getStyle (SpyUI.SYSTEM_NAME_STYLE);
		final Style textStyle = zoneChatStyledDocument
				.getStyle (SpyUI.GRAY_TEXT_STYLE);
		showMessage (SpyUI.SYSTEM_SPEAKER, "", systemMessage, userNameStyle,
				textStyle);
	}
}
