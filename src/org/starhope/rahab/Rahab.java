/**
 * <p>
 * Copyright © 2009-2010, Tim Heys
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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 *@author twheys@gmail.com
 * @author brpocock@star-hope.org
 */

package org.starhope.rahab;

import java.awt.Dimension;
import java.awt.GridLayout;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Iterator;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.WindowConstants;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.rahab.ui.LoginUI;
import org.starhope.rahab.ui.ShiftJournalPane;
import org.starhope.rahab.ui.SpyHTMLWindow;
import org.starhope.rahab.ui.SpyMenuBar;
import org.starhope.rahab.ui.SpyUI;
import org.starhope.rahab.ui.ZonePromptUI;
import org.starhope.rahab.util.Actions;
import org.starhope.rahab.util.LoginCallBack;
import org.starhope.rahab.util.MessageCallBack;
import org.starhope.rahab.util.Zone;
import org.starhope.rahab.util.ZoneCallBack;
import org.starhope.vergil.game.PubliusVergiliusMaro;
import org.starhope.vergil.net.smartFaux.SmartFauxClient;
import org.starhope.vergil.net.smartFaux.SmartFauxEvent;
import org.starhope.vergil.net.smartFaux.SmartFauxEventListener;

/**
 * WRITEME: Document this type. twheys@gmail.com Dec 29, 2009
 *
 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
 */
public class Rahab {
	/**
	 * @author brpocock@star-hope.org
	 */
	final class DisplayInterfaceRunner implements Runnable {
		/**
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run () {
			Rahab.logger.info ("Building Application User Interface");
			applicationGUI = createAndShowGUI ();
			applicationGUI
			.showSystemMessage ("Application Initialized.");
			applicationGUI
			.showSystemMessage ("Connecting to " + server);
		}
	}

	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 30, 2009
	 */
	public static final String $EAVES = "$Eaves";
	
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 30, 2009
	 */
	public static final String $MOD = "MOD";
	
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 30, 2009
	 */
	private static Rahab client;
	
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 30, 2009
	 */
	static boolean isConnected;
	
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 30, 2009
	 */
	static boolean isLoggedIn;
	
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 30, 2009
	 */
	protected final static Logger logger =
		Logger
		.getLogger (Rahab.class
				.getName ());
	
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 30, 2009
	 */
	public static final String LOGIN_ZONE = "$Eden";
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 30, 2009
	 */
	private static final String roomPassword =
		"Lasciate ogne speranza, voi ch'intrate";
	
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 30, 2009
	 */
	public static final String servers[] = { "whitney.tootsville.com",
		"whitney-beta.tootsville.com",
		"whitney-dev.tootsville.com", "localhost" };
	
	/**
	 * WRITEME: Document this field. twheys@gmail.com Dec 30, 2009
	 */
	public static final String unitSep = "\u001f";

	/**
	 * <pre>
	 * twheys@gmail.com Jan 28, 2010
	 * </pre>
	 *
	 * TO addJournalEntry WRITEME...
	 *
	 * @param entryText WRITEME
	 */
	public static void addJournalEntry (final String entryText) {
		Rahab.client.createJournalExtension (entryText);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 *
	 * TO createAndShowLoginScreen WRITEME...
	 *
	 * @param url WRITEME
	 */
	public static void createAndShowHTMLPage (final String url) {
		// Create and set up the window.
		final JFrame frame = new JFrame ("Tootsville Spy");
		frame
		.setDefaultCloseOperation (WindowConstants.DISPOSE_ON_CLOSE);

		// Create and set up the content pane.
		final SpyHTMLWindow htmlInterface = new SpyHTMLWindow (url);
		htmlInterface.setOpaque (true); // content panes must be opaque
		frame.setContentPane (htmlInterface);

		// Display the window.
		frame.pack ();
		frame.setVisible (true);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 *
	 * TO createAndShowLoginScreen WRITEME...
	 */
	public static void createAndShowLoginPrompt () {
		// Create and set up the window.
		final JFrame frame = new JFrame ("Tootsville Spy");
		frame.setDefaultCloseOperation (JFrame.EXIT_ON_CLOSE);

		final LoginCallBack callback = new LoginCallBack () {
			/**
			 * @see org.starhope.rahab.util.LoginCallBack#doLogin(java.lang.String,
			 *      java.lang.String, java.lang.String)
			 */
			@Override
			public void doLogin (final String username,
					final String password, final String server) {
				frame.setVisible (false);
				frame.setEnabled (false);
				Rahab.login (username, password, server);
			}
		};

		// Create and set up the content pane.
		final LoginUI loginInterface = new LoginUI (callback);
		loginInterface.setOpaque (true); // content panes must be opaque
		frame.setContentPane (loginInterface);
		frame.setPreferredSize (new Dimension (400, 150));

		// Display the window.
		frame.pack ();
		frame.setVisible (true);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 *
	 * TO createAndShowLoginScreen WRITEME...
	 */
	public static void createAndShowShiftJournal () {
		// Create and set up the window.
		final JFrame frame = new JFrame ("Tootsville Spy");
		frame.setDefaultCloseOperation (WindowConstants.HIDE_ON_CLOSE);

		// Create and set up the content pane.
		final ShiftJournalPane journalInterface = new ShiftJournalPane ();
		journalInterface.setOpaque (true); // content panes must be
		// opaque
		frame.setContentPane (journalInterface);
		frame.setPreferredSize (new Dimension (450, 400));

		// Display the window.
		frame.pack ();
		frame.setVisible (true);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO getApple WRITEME...
	 *
	 * @param key The secret key to hash the password with.
	 * @param pass The password to be encrypted
	 * @return a sha1 hash "apple" that allows access into $Eden
	 */
	protected static String getApple (final String key,
			final String pass) {
		/* Check the CHAP key hex code sequence */

		byte [] sha1digest = {};
		try {
			final MessageDigest stomach = MessageDigest
			.getInstance ("SHA1");
			stomach.reset ();
			try {
				stomach.update ( (key + pass).getBytes ("US-ASCII"));
			} catch (final UnsupportedEncodingException e) {
				e.printStackTrace ();
			}
			sha1digest = stomach.digest ();
		} catch (final NoSuchAlgorithmException e) {
			e.printStackTrace ();
		} catch (final NumberFormatException e) {
			e.printStackTrace ();
		}
		final StringBuilder sha1hex = new StringBuilder (
				sha1digest.length * 2);
		for (final byte element : sha1digest) {
			sha1hex.append (Integer.toString (
					(element & 0xff) + 0x100, 16).substring (1));
		}
		return sha1hex.toString ();
	}

	/**
	 *
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 *
	 * TO killSession WRITEME...
	 *
	 * @param andExit WRITEME
	 */
	public static void killSessionStatically (final boolean andExit) {
		Rahab.client.killSession (andExit);
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
	protected static void login (final String username,
			final String password, final String server) {
		Rahab.client = new Rahab (username, password, server);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Jan 22, 2010
	 * </pre>
	 *
	 * TO loginNewUser WRITEME...
	 */
	public static void loginNewUser () {
		if (null != Rahab.client) {
			Rahab.client.killSession (false);
			Rahab.client.getWindow ().setVisible (false);
		}
		Rahab.client = null;
		Rahab.createAndShowLoginPrompt ();
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 *
	 * TO main WRITEME...
	 *
	 * @param args WRITEME
	 */
	public static void main (final String [] args) {
		/**
		 * <p>
		 * FIXME:
		 * </p>
		 * <p>
		 * OpenJDK introduces a potential incompatibility. In
		 * particular, the java.util.logging.Logger behavior has
		 * changed. Instead of using strong references, it now uses weak
		 * references internally. That's a reasonable change, but
		 * unfortunately some code relies on the old behavior - when
		 * changing logger configuration, it simply drops the logger
		 * reference. That means that the garbage collector is free to
		 * reclaim that memory, which means that the logger
		 * configuration is lost. For example, consider:
		 * </p>
		 * 
		 * <pre>
		 * public static void initLogging () throws Exception {
		 * 	Logger logger = Logger.getLogger (&quot;edu.umd.cs&quot;);
		 * 	logger.addHandler (new FileHandler ()); // call to change logger configuration
		 * 	logger.setUseParentHandlers (false); // another call to change logger configuration
		 * }
		 * </pre>
		 * <p>
		 * The logger reference is lost at the end of the method (it
		 * doesn't escape the method), so if you have a garbage
		 * collection cycle just after the call to initLogging, the
		 * logger configuration is lost (because Logger only keeps weak
		 * references).
		 * </p>
		 * 
		 * <pre>
		 * public static void main (String [] args) throws Exception {
		 * 	initLogging (); // adds a file handler to the logger
		 * 	System.gc (); // logger configuration lost
		 * 	Logger.getLogger (&quot;edu.umd.cs&quot;).info (&quot;Some message&quot;); // this isn't logged to the file as expected
		 * }
		 * </pre>
		 */
		Rahab.logger.setLevel (Level.ALL);
		// Schedule a job for the event-dispatching thread:
		// creating and showing this application's GUI.
		javax.swing.SwingUtilities.invokeLater (new Runnable () {
			@Override
			public void run () {
				Rahab.createAndShowLoginPrompt ();
				Rahab.logger.info ("Prompting for Login...");
			}
		});
	}

	/**
	 * <pre>
	 * twheys@gmail.com Jan 22, 2010
	 * </pre>
	 *
	 * TO openWebPage WRITEME...
	 *
	 * @param url WRITEME
	 */
	public static void openResource (final String url) {
		try {
			Runtime.getRuntime ().exec (url);
		} catch (final IOException e) {
			Rahab.createAndShowHTMLPage (url);
		}
	}

	/**
	 *
	 */
	public static void reloadUserAndRoomLists () {
		Rahab.client.getUserAndRoomListsFromServer ();
	}

	/**
	 *
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 *
	 * TO retrieveZoneListStatically WRITEME...
	 *
	 */
	public static void retrieveZoneListStatically () {
		Rahab.client.retrieveZoneList ();
	}

	/**
	 * <pre>
	 * twheys@gmail.com Feb 8, 2010
	 * </pre>
	 *
	 * TO setAutoScrolls WRITEME...
	 *
	 * @param selected WRITEME
	 */
	public static void setAutoScrollsStatically (final boolean selected) {
		Rahab.client.setAutoscrolls (selected);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Mar 3, 2010
	 * </pre>
	 *
	 * TO setEchoJoinsStatically WRITEME...
	 *
	 * @param selected WRITEME
	 */
	public static void setEchoJoinsStatically (final boolean selected) {
		Rahab.client.setEchoRoomJoins (selected);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 *
	 * TO validateUserStaffLevelOrExit WRITEME...
	 *
	 * @param staffLevel WRITEME
	 */
	public static void validateUserStaffLevelOrExit (
			final int staffLevel) {
		if (1 > staffLevel) {
			System.exit (-1);
		}
	}

	/**
	 *
	 */
	protected transient Timer antiTimeOut;

	/**
	 *
	 */
	protected SpyUI applicationGUI;

	/**
	 *
	 */
	private JFrame applicationWindow;

	/**
	 *
	 */
	private String currentZone = "Loading...";

	/**
	 * Display room joins
	 */
	private boolean echoRoomJoins = true;

	/**
	 * WRITEME
	 */
	protected String key = "";

	/**
	 * WRITEME
	 */
	private final SmartFauxEventListener messageEvent = new SmartFauxEventListener () {
		/**
		 * WRITEME: Document this method brpocock@star-hope.org
		 *
		 * @param event WRITEME
		 */
		@Override
		public void handleEvent (final SmartFauxEvent event) {
			try {
				disectMessageEvent (event.getParams ().getString (
						"message"));
			} catch (final JSONException e) {
				PubliusVergiliusMaro.reportBug (
						"Caught a JSONException in .handleEvent ", e);
			}
		}
	};

	/**
	 * WRITEME
	 */
	private final SmartFauxEventListener onConnection = new SmartFauxEventListener () {
		/**
		 * WRITEME: Document this method brpocock@star-hope.org
		 *
		 * @param event WRITEME
		 */
		@Override
		public void handleEvent (final SmartFauxEvent event) {
			try {
				if (event.getParams ().getBoolean ("success")) {
					Rahab.logger.info ("Successfully connected to server.");
					applicationGUI
					.showSystemMessage ("Connected to server.  Requesting Zones.");
					Rahab.isConnected = true;
				} else {
					Rahab.logger.info ("Cannot connect to server.");
					handleFailedLogin ("Cannot connect to server.  Check your internet connection.");
				}
			} catch (final JSONException e) {
				PubliusVergiliusMaro.reportBug (
						"Caught a JSONException in .handleEvent ", e);
			}
		}
	};

	/**
	 * WRITEME
	 */
	private final SmartFauxEventListener onConnectionLost = new SmartFauxEventListener () {
		/**
		 * @param event WRITEME
		 */
		@Override
		public void handleEvent (final SmartFauxEvent event) {
			Rahab.logger.info ("Lost connection to server.");
			handleFailedLogin ("You have disconnected from the server.");
		}
	};

	/**
	 * WRITEME
	 */
	private final SmartFauxEventListener onExtensionRequest = new SmartFauxEventListener () {
		@Override
		public void handleEvent (final SmartFauxEvent event) {
			Rahab.logger
			.info ("Received an xt request: "
					+ event.toString ());
			try {
				final JSONObject dataObj = new JSONObject (event
						.getParams ().toString ())
				.getJSONObject ("dataObj");
				if (dataObj.has ("_cmd")) {
					extractLoginInfoFromJSON (dataObj);
					return;
				} else if (dataObj.has ("userList")) {
					extractUserListFromJSON (dataObj);
					extractRoomListFromJSON (dataObj);
				} else if (dataObj.has ("message")) {
					applicationGUI.showDialog (dataObj
							.getString ("title"), dataObj
							.getString ("label"), dataObj
							.getString ("message"));
				} else if (dataObj.has ("msg")) {
					applicationGUI.showSystemMessage (dataObj
							.getString ("msg"));
				}

			} catch (final Exception e) {
				Rahab.logger.log (Level.SEVERE,
						"JSONException in onExtensionRequest", e);
			}
		}
	};

	/**
	 * WRITEME
	 */
	private final SmartFauxEventListener onJoinRoom = new SmartFauxEventListener () {
		/**
		 * @see SmartFauxEventListener#handleEvent(SmartFauxEvent)
		 */
		@Override
		public void handleEvent (final SmartFauxEvent event) {
			applicationGUI
			.showSystemMessage ("You have successfully joined "
					+ Rahab.$EAVES + ".");
			Rahab.isLoggedIn = true;
			antiTimeOut = new Timer ();
			antiTimeOut.scheduleAtFixedRate (task, 0, 1 * 1000 * 60);
			Rahab.logger.info ("Requesting Room List");
			applicationGUI
			.showSystemMessage ("Retrieving user and room lists.");
			getUserAndRoomListsFromServer ();
		}
	};

	/**
	 * WRITEME
	 */
	private final SmartFauxEventListener onJoinRoomError = new SmartFauxEventListener () {
		/**
		 * WRITEME: Document this method brpocock@star-hope.org
		 *
		 * @param event WRITEME
		 */
		@Override
		public void handleEvent (final SmartFauxEvent event) {
			Rahab.logger.info ("Failed to join $Eaves: "
					+ event.getParams ().toString ());
			handleFailedLogin ("Failed to join room.");
		}
	};

	/**
	 * WRITEME
	 */
	private final SmartFauxEventListener onRandomKey = new SmartFauxEventListener () {
		/**
		 * WRITEME: Document this method brpocock@star-hope.org
		 *
		 * @param event WRITEME
		 */
		@Override
		public void handleEvent (
				final SmartFauxEvent event) {
			try {
				key = event.getParams ().getString ("key");
			} catch (final JSONException e) {
				PubliusVergiliusMaro.reportBug (
						"Caught a JSONException in .handleEvent ", e);
			}
			Rahab.logger.info ("Random key received.");
			retrieveZoneList ();
		}
	};

	/**
	 * WRITEME
	 */
	private final SmartFauxEventListener onRoomListUpdate = new SmartFauxEventListener () {
		/**
		 * WRITEME: Document this method brpocock@star-hope.org
		 *
		 * @param event WRITEME
		 */
		@Override
		public void handleEvent (final SmartFauxEvent event) {
			sfClient.joinRoom (Rahab.$EAVES, Rahab.roomPassword, false);
		}
	};

	/**
	 *
	 */
	private final SmartFauxEventListener onUserEnterRoom = new SmartFauxEventListener () {
		@Override
		public void handleEvent (final SmartFauxEvent event) {
			String userThatLeft = "¿someone?";
			try {
				userThatLeft = event.getParams ()
				.getString ("userName");
			} catch (final JSONException e) {
				PubliusVergiliusMaro.reportBug (
						"Caught a JSONException in .handleEvent ", e);
			}
			applicationGUI.showSystemMessage (userThatLeft
					+ " has logged in.");
		}
	};

	/**
	 *
	 */
	private final SmartFauxEventListener onUserLeftRoom = new SmartFauxEventListener () {
		@Override
		public void handleEvent (final SmartFauxEvent event) {
			String userThatLeft = "¿someone?";
			try {
				userThatLeft = event.getParams ()
				.getString ("userName");
			} catch (final JSONException e) {
				PubliusVergiliusMaro.reportBug (
						"Caught a JSONException in .handleEvent ", e);
			}
			applicationGUI.showSystemMessage (userThatLeft
					+ " has logged off.");
		}
	};

	/**
	 *
	 */
	private final String password;

	/**
	 *
	 */
	final String server;

	/**
	 * Smart Fox Server
	 */
	public transient final SmartFauxClient sfClient;

	/**
	 *
	 */
	transient TimerTask task = new TimerTask () {
		@Override
		public void run () {
			sfClient.sendXtMessage ("Tootsville", "ping",
					new JSONObject ());
		}
	};

	/**
	 *
	 */
	private final String userName;

	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 *
	 * A Spy WRITEME...
	 *
	 * @param userNameAttempt WRITEME
	 * @param passwordAttempt WRITEME
	 * @param serverAttempt WRITEME
	 */
	public Rahab (final String userNameAttempt,
			final String passwordAttempt, final String serverAttempt) {
		userName = userNameAttempt;
		password = passwordAttempt;
		server = serverAttempt;
		sfClient = new SmartFauxClient (false);
		displayInterface ();
		initSFListeners ();
		connect ();
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO connect WRITEME...
	 */
	private void connect () {
		try {
			sfClient.connect (server, 2770);
			sfClient.getRandomKey ();
		} catch (final Exception e) {
			Rahab.logger.log (Level.SEVERE,
					"Failed to initialize connection.", e);
			JOptionPane
			.showMessageDialog (applicationGUI,
					"Failed to get connection.  Please check your network.");
			Rahab.loginNewUser ();
		}
	}

	/**
	 * Create the GUI and show it. For thread safety, this method should
	 * be invoked from the event-dispatching thread.
	 *
	 * @return a pointer to a {@link SpyUI} object that displays the
	 *         interface.
	 */
	protected SpyUI createAndShowGUI () {
		// Create and set up the window.
		applicationWindow = new JFrame ("Tootsville Spy");
		applicationWindow
		.setDefaultCloseOperation (JFrame.EXIT_ON_CLOSE);

		final MessageCallBack callback = new MessageCallBack () {
			@Override
			public void sendCommand (final String command,
					final String... params) {
				sendPublicCommand (command, params);
			}

			@Override
			public void sendMessage (final String message) {
				sendPublicMessage (message);
			}
		};

		// Create and set up the content pane.
		applicationGUI = new SpyUI (callback, currentZone);
		applicationGUI.setOpaque (true); // content panes must be opaque
		applicationWindow.setJMenuBar (new SpyMenuBar ());
		applicationWindow.setContentPane (applicationGUI);

		// Display the window.
		applicationWindow.setLayout (new GridLayout ());
		applicationWindow.pack ();
		applicationWindow.setVisible (true);
		return applicationGUI;
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 *
	 * TO createAndShowLoginScreen WRITEME...
	 *
	 * @param zones WRITEME
	 */
	protected void createAndShowZonePrompt (final Vector <Zone> zones) {
		// Create and set up the window.
		final JFrame frame = new JFrame ("Tootsville Spy");
		frame.setDefaultCloseOperation (WindowConstants.HIDE_ON_CLOSE);

		final ZoneCallBack callback = new ZoneCallBack () {
			/**
			 * @see org.starhope.rahab.util.ZoneCallBack#joinZone(java.lang.String)
			 */
			@Override
			public void joinZone (final String zone) {
				frame.setVisible (false);
				frame.setEnabled (false);
				loginToZone (zone);
			}
		};

		// Create and set up the content pane.
		final ZonePromptUI zonePromptInterface = new ZonePromptUI (
				zones, callback);
		zonePromptInterface.setOpaque (true); // content panes must be
		// opaque
		frame.setContentPane (zonePromptInterface);

		// Display the window.
		frame.pack ();
		frame.setVisible (true);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Jan 28, 2010
	 * </pre>
	 *
	 * TO createJournalExtension WRITEME...
	 *
	 * @param entryText WRITEME
	 */
	private void createJournalExtension (final String entryText) {
		final JSONObject journalJSON = new JSONObject ();
		try {
			journalJSON.put ("entry", entryText);
			sfClient.sendJson (journalJSON.toString ());
		} catch (final JSONException e) {
			Rahab.logger.log (Level.ALL, "Failed to send JSON", e);
		}
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO readMessage WRITEME...
	 *
	 * @param messageEventParam WRITEME
	 */
	protected void disectMessageEvent (final String messageEventParam) {
		if (messageEventParam.contains (Rahab.unitSep)) {
			final String [] fields = messageEventParam
			.split (Rahab.unitSep);
			String user;
			String room;
			Actions verb;
			String message;
			try {
				user = fields [0];
				room = fields [1];
				verb = Actions.valueOf (fields [2]);
				message = fields [3];
				doMessageEventAction (user, room, verb, message);
			} catch (final IndexOutOfBoundsException e) {
				Rahab.logger.info ("Unhandled message: " + messageEventParam);
			}
		} else if (messageEventParam.equals ("/00p$")) {
			applicationGUI
			.showErrorMessage ("Oops!  You can't say that.");
		} else {
			Rahab.logger.info ("Unhandled message: " + messageEventParam);
		}
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 *
	 * TO displayInterface WRITEME...
	 */
	private void displayInterface () {
		// Schedule a job for the event-dispatching thread:
		// creating and showing this application's GUI.
		javax.swing.SwingUtilities
		.invokeLater (new DisplayInterfaceRunner ());
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO doMessageEventAction WRITEME...
	 *
	 * @param user WRITEME
	 * @param room WRITEME
	 * @param verb WRITEME
	 * @param message WRITEME
	 */
	private void doMessageEventAction (final String user,
			final String room, final Actions verb, final String message) {
		switch (verb) {
			case join:
				moveUser (user, room);
				break;
			case said:
				applicationGUI.showSaidMessage (user, room, message);
				break;
			case part:
				removeUser (user, room);
				break;
			case ban:
				applicationGUI.showSaidMessage (user, room, "was banned "
						+ message);
				break;
			case kick:
				applicationGUI.showSaidMessage (user, room, "was kicked "
						+ message);
				break;
			case mail:
				break;
			case mod:
				applicationGUI.showSaidMessage (user, room, message);
				break;
			case post:
				break;
			case warn:
				applicationGUI.showSaidMessage (user, room, "warned "
						+ message);
				break;
			case reporting:
				reportUser (user, room, message);
				break;
			case Oops:
				applicationGUI.showBlackListMessage (user, room, message);
				break;
			case REDLIST:
				applicationGUI.showRedListMessage (user, room, message);
				break;
		default:
			applicationGUI.showSystemMessage (user + "@" + room + " "
					+ verb + " " + message);
		}
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO extractLoginInfoFromJSON WRITEME...
	 *
	 * @param dataObj WRITEME
	 * @throws JSONException WRITEME
	 */
	protected void extractLoginInfoFromJSON (final JSONObject dataObj)
	throws JSONException {
		if (dataObj.getString ("_cmd").equals ("logOK")
				|| dataObj.getString ("_cmd").equals ("loginComplete")) {
			if (dataObj.has ("zoneList")) {
				Rahab.logger.info ("Requesting zone list.");
				promptForZone (getZoneListFromJSON (dataObj
						.getJSONObject ("zoneList")));
				return;
			}
			Rahab.validateUserStaffLevelOrExit (dataObj
					.getJSONObject ("user").getInt ("staffLevel"));
			Rahab.logger.info ("Requesting list of rooms.");
			sfClient.getRoomList ();

			return;

			// logKO for unsuccessful log attempt
		} else if (dataObj.getString ("_cmd").equals ("logKO")) {
			final String message = dataObj.getString ("msg");
			handleFailedLogin (message);
			return;
		} else {
			return;
		}
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO extractUserListFromJSON WRITEME...
	 *
	 * @param dataObj WRITEME
	 * @throws JSONException WRITEME
	 */
	@SuppressWarnings ("unchecked")
	protected void extractRoomListFromJSON (final JSONObject dataObj)
	throws JSONException {
		final JSONObject roomListJSON = dataObj.getJSONObject ("rooms");
		final Iterator <String> keys = roomListJSON.keys ();
		while (keys.hasNext ()) {
			final String room = keys.next ();
			final Iterator <String> users = roomListJSON.getJSONObject (
					room).keys ();
			while (users.hasNext ()) {
				final String userInRoom = roomListJSON.getJSONObject (
						room).getString (users.next ());
				updateRoomListWithMovedUser (userInRoom, room);
			}
		}
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO extractUserListFromJSON WRITEME...
	 *
	 * @param dataObj WRITEME
	 * @throws JSONException WRITEME
	 */
	protected void extractUserListFromJSON (final JSONObject dataObj)
	throws JSONException {
		final JSONObject userListJSON = dataObj
		.getJSONObject ("userList");
		final Vector <String> userList = getUserListFromJSON (userListJSON);
		applicationGUI.initListOfUsers (userList);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO getRoomDisplayName WRITEME...
	 *
	 * @param room WRITEME
	 * @return a displayable name for a room
	 */
	private String getRoomDisplayName (final String room) {
		if (room.equals ("$Eaves")) {
			return Rahab.$MOD;
		} else if (room.equals ("nowhere")) {
			return "PLAYING/POV";
		} else if (room.startsWith ("user~")) {
			return room.split ("~") [1] + "'s House";
		}
		return room;
	}

	/**
	 * <pre>
	 * twheys@gmail.com Jan 22, 2010
	 * </pre>
	 *
	 * TO getUserAndRoomListsFromServer WRITEME...
	 */
	public void getUserAndRoomListsFromServer () {
		sfClient.sendXtMessage ("Tootsville", "getOnlineUsers",
				new JSONObject ());
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO getUserListFromJSON WRITEME...
	 *
	 * @param userListJSON WRITEME
	 * @return a Vector of user names
	 */
	@SuppressWarnings ("unchecked")
	private Vector <String> getUserListFromJSON (
			final JSONObject userListJSON) {
		final Vector <String> userConversion = new Vector <String> ();
		final Iterator <String> keys = userListJSON.keys ();
		while (keys.hasNext ()) {
			userConversion.add (keys.next ());
		}
		return userConversion;
	}

	/**
	 * <pre>
	 * twheys@gmail.com Jan 22, 2010
	 * </pre>
	 *
	 * TO getWindow WRITEME...
	 *
	 * @return the application JFrame window
	 */
	public JFrame getWindow () {
		return applicationWindow;
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO getZoneListFromJSON WRITEME...
	 *
	 * @param zoneList WRITEME
	 * @return A Vector with the zone list
	 * @throws JSONException WRITEME
	 */
	@SuppressWarnings ("unchecked")
	protected Vector <Zone> getZoneListFromJSON (
			final JSONObject zoneList) throws JSONException {
		final Vector <Zone> zones = new Vector <Zone> ();
		Rahab.logger.finest (zoneList.toString ());
		Rahab.logger.fine ("Number of zones: " + zoneList.length ());
		final Iterator <String> keys = zoneList.keys ();
		while (keys.hasNext ()) {
			final String keyName = keys.next ();
			final JSONObject zoneObj = zoneList.getJSONObject (keyName);
			final String zoneName = zoneObj.getString ("name");
			final String zoneHost = zoneObj.getString ("host");
			final int usersOn = Integer.parseInt (zoneObj
					.getString ("usersOn"));
			Rahab.logger.fine ("New zone (#" + keyName + "):  " + zoneName
					+ "\n" + zoneHost + "\n" + usersOn);
			zones.add (new Zone (zoneName, zoneHost, usersOn));
		}

		return zones;
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 *
	 * TO handleFailedLogin WRITEME...
	 *
	 * @param message WRITEME
	 */
	protected void handleFailedLogin (final String message) {
		applicationGUI.showSystemMessage (message);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 *
	 * TO initAppiusListener WRITEME...
	 */
	private void initSFListeners () {
		sfClient.smartConnect = false;
		sfClient.addEventListener (SmartFauxEvent.onConnection, onConnection);
		sfClient.addEventListener (SmartFauxEvent.onConnectionLost,
				onConnectionLost);
		sfClient.addEventListener (SmartFauxEvent.onRandomKey, onRandomKey);
		sfClient.addEventListener (SmartFauxEvent.onRoomListUpdate,
				onRoomListUpdate);
		sfClient.addEventListener (SmartFauxEvent.onExtensionResponse,
				onExtensionRequest);
		sfClient.addEventListener (SmartFauxEvent.onJoinRoom, onJoinRoom);
		sfClient.addEventListener (SmartFauxEvent.onJoinRoomError,
				onJoinRoomError);
		sfClient.addEventListener (SmartFauxEvent.onPublicMessage,
				messageEvent);
		sfClient.addEventListener (SmartFauxEvent.onModeratorMessage,
				messageEvent);
		sfClient.addEventListener (SmartFauxEvent.onAdminMessage,
				messageEvent);
		sfClient.addEventListener (SmartFauxEvent.onPrivateMessage,
				messageEvent);
		sfClient.addEventListener (SmartFauxEvent.onUserEnterRoom,
				onUserEnterRoom);
		sfClient.addEventListener (SmartFauxEvent.onUserLeaveRoom,
				onUserLeftRoom);
	}

	/**
	 * @return the echoRoomJoins
	 */
	public boolean isEchoRoomJoins () {
		return echoRoomJoins;
	}

	/**
	 * <pre>
	 * twheys@gmail.com Jan 22, 2010
	 * </pre>
	 *
	 * TO quit WRITEME...
	 *
	 * @param andExit WRITEME
	 */
	public void killSession (final boolean andExit) {
		try {
			sfClient.logout ();
			sfClient.disconnect ();
		} catch (final Exception e) {
			Rahab.logger
			.finer ("Failed to log out or disconnect, not connected");
		}
		if (andExit) {
			System.exit (0);
		}
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 *
	 * TO login WRITEME...
	 *
	 * @param zone WRITEME
	 */
	protected void loginToZone (final String zone) {
		if (null == zone) {
			Rahab.logger.info ("Failed to join zone. Reason: Zone is null.");
			return;
		}
		currentZone = zone;
		applicationGUI.setTreeRoot (currentZone);
		Rahab.logger.info ("Logging in to zone: " + zone);
		sfClient.logout ();
		sfClient.login (zone, userName, Rahab.getApple (key, password));
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO moveUser WRITEME...
	 *
	 * @param user WRITEME
	 * @param room WRITEME
	 */
	private void moveUser (final String user, final String room) {
		if (echoRoomJoins) {
			applicationGUI.showSystemMessage (user + " has joined "
					+ room + ".");
		}
		updateRoomListWithMovedUser (user, room);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 29, 2009
	 * </pre>
	 *
	 * TO promptForZone WRITEME...
	 *
	 * @param zones WRITEME
	 */
	public void promptForZone (final Vector <Zone> zones) {
		createAndShowZonePrompt (zones);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO removeUser WRITEME...
	 *
	 * @param user WRITEME
	 * @param room WRITEME
	 */
	private void removeUser (final String user, final String room) {
		if (echoRoomJoins) {
			applicationGUI.showSystemMessage (user + " has left "
					+ room + ".");
		}
		applicationGUI.removeUserFromRoomList (userName);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Jan 5, 2010
	 * </pre>
	 *
	 * TO reportUser WRITEME...
	 *
	 * @param user WRITEME
	 * @param room WRITEME
	 * @param reportedUser WRITEME
	 */
	private void reportUser (final String user, final String room,
			final String reportedUser) {
		applicationGUI.showReport (user, reportedUser, room);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Jan 22, 2010
	 * </pre>
	 *
	 * THIS WILL DISCONNECT FROM THE CURRENT ZONE.
	 */
	public void retrieveZoneList () {
		loginToZone (Rahab.LOGIN_ZONE);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO sendActionCommand WRITEME...
	 *
	 * @param command WRITEME
	 * @param params WRITEME
	 */
	protected void sendPublicCommand (final String command,
			final String [] params) {
		final StringBuilder action = new StringBuilder ();
		action.append ("#");
		action.append (command);
		action.append (" ");
		for (final String param : params) {
			action.append (param);
			action.append (" ");
		}
		System.out.println ("Sending command: " + action.toString ());
		sendPublicMessage (action.toString ());
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO sendPublicMessage WRITEME...
	 *
	 * @param message WRITEME
	 */
	protected void sendPublicMessage (final String message) {
		Rahab.logger.info ("Sending message: " + message);
		applicationGUI.addToHistory (message);
		if (Rahab.isLoggedIn) {
			sfClient.sendPublicMessage (message);
		} else {
			applicationGUI
			.showErrorMessage ("You must finish connecting before you can do that.");
		}
	}

	/**
	 * <pre>
	 * twheys@gmail.com Feb 8, 2010
	 * </pre>
	 *
	 * TO setAutoscrolls WRITEME...
	 *
	 * @param selected WRITEME
	 */
	private void setAutoscrolls (final boolean selected) {
		applicationGUI.setZoneChatAutoScrolls (selected);
	}

	/**
	 * @param newEchoRoomJoins the echoRoomJoins to set
	 */
	public void setEchoRoomJoins (final boolean newEchoRoomJoins) {
		echoRoomJoins = newEchoRoomJoins;
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * @deprecated use
	 *             {@link SpyUI#showSaidMessage(String, String, String)}
	 *             instead
	 * @param user WRITEME
	 * @param room WRITEME
	 * @param message WRITEME
	 */
	@SuppressWarnings ("unused")
	@Deprecated
	private void showMessage (final String user, final String room,
			final String message) {
		applicationGUI.showSaidMessage (user,
				getRoomDisplayName (room), message);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 *
	 * TO updateRoomListWithMovedUser WRITEME...
	 *
	 * @param user WRITEME
	 * @param room WRITEME
	 */
	private void updateRoomListWithMovedUser (final String user,
			final String room) {
		final String roomDisplayName = getRoomDisplayName (room);
		if (roomDisplayName.contains ("'s House")) {
			applicationGUI.addUserToHouse (user, roomDisplayName);
		} else if (roomDisplayName.contains (Rahab.$MOD)) {
			applicationGUI.addUserToMOD (user);
		} else {
			applicationGUI.addUserToRoom (user, roomDisplayName);
		}
		applicationGUI.addUserToUserList (user);
	}

}
