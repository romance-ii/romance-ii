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
package org.starhope.rahab.ui;

import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.border.Border;

import org.starhope.rahab.Rahab;
import org.starhope.rahab.util.LoginCallBack;

/**
 * WRITEME: Document this type. twheys@gmail.com Dec 29, 2009
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys Timothy W. Heys
 */
public class LoginUI extends JPanel {
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 29, 2009
	 */
	private static final long serialVersionUID = -4540386371686781482L;
	
	/**
	 *
	 */
	private final KeyListener keyAction = new KeyListener () {
		/**
		 * @see java.awt.event.KeyListener#keyPressed(java.awt.event.KeyEvent)
		 */
		@Override
		public void keyPressed (final KeyEvent e) {
			if (e.getKeyCode () == KeyEvent.VK_ENTER) {
				login ();
				e.consume ();
			}
		}
		
		/**
		 * @see java.awt.event.KeyListener#keyReleased(java.awt.event.KeyEvent)
		 */
		@Override
		public void keyReleased (final KeyEvent e) {
			// do nothing
		}
		
		/**
		 * @see java.awt.event.KeyListener#keyTyped(java.awt.event.KeyEvent)
		 */
		@Override
		public void keyTyped (final KeyEvent e) {
			// do nothing
		}
	};
	
	/**
	 *
	 */
	Logger logger = Logger.getLogger (LoginUI.class.getName ());
	
	/**
	 *
	 */
	private final LoginCallBack loginCallBack;
	
	/**
	 *
	 */
	private final JPasswordField passwordField;
	
	/**
	 *
	 */
	private final JComboBox serverField;
	
	/**
	 *
	 */
	private final JTextField userNameField;
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 * 
	 * A LoginUI WRITEME...
	 * 
	 * @param callback WRITEME
	 */
	public LoginUI (final LoginCallBack callback) {
		logger.setLevel (Level.ALL);
		loginCallBack = callback;
		final GridLayout layout = new GridLayout (4, 2);
		layout.setHgap (5);
		layout.setVgap (5);
		logger.fine ("Setting Layout Manger for LoginUI");
		setLayout (layout);
		final Border border = BorderFactory.createEmptyBorder (10,
				10, 10, 10);
		logger.fine ("Setting Border for LoginUI");
		setBorder (border);
		
		userNameField = new JTextField ("");
		passwordField = new JPasswordField ("");
		serverField = new JComboBox (Rahab.servers);
		final JButton submitLogin = new JButton ("Login");
		
		passwordField.addKeyListener (keyAction);
		userNameField.addKeyListener (keyAction);
		submitLogin.addActionListener (new ActionListener () {
			/**
			 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
			 */
			@Override
			public void actionPerformed (final ActionEvent e) {
				login ();
			}
		});
		
		final JLabel userNameLabel = new JLabel ("User Name");
		final JLabel passwordLabel = new JLabel ("Password");
		final JLabel serverLabel = new JLabel ("Server");
		
		logger.finest ("Adding User Name Label for LoginUI");
		this.add (userNameLabel);
		logger.finest ("Adding User Name Field for LoginUI");
		this.add (userNameField);
		logger.finest ("Adding Password Label for LoginUI");
		this.add (passwordLabel);
		logger.finest ("Adding Password Field for LoginUI");
		this.add (passwordField);
		logger.finest ("Adding Server Label for LoginUI");
		this.add (serverLabel);
		logger.finest ("Adding Server Field for LoginUI");
		this.add (serverField);
		logger.finest ("Adding Empty Space for LoginUI");
		this.add (new JLabel ());
		logger.finest ("Adding Login Button for LoginUI");
		this.add (submitLogin);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 * 
	 * TO login WRITEME...
	 */
	protected void login () {
		final String username = userNameField.getText ();
		final String password = String.valueOf (passwordField
				.getPassword ());
		final String server = String.valueOf (serverField
				.getSelectedItem ());
		logger.info ("Retreived username (" + username
				+ ") and server (" + server + ").");
		login (username, password, server);
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 * 
	 * TO login WRITEME...
	 * 
	 * @param username WRITEME
	 * @param password WRITEME
	 * @param server WRITEME
	 */
	private void login (final String username, final String password,
			final String server) {
		loginCallBack.doLogin (username, password, server);
	}
}
