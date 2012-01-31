/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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
package org.starhope.appius.game;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Map.Entry;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ConcurrentSkipListSet;

import javax.mail.MessagingException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.messaging.Mail;
import org.starhope.appius.net.AdminProcessor;
import org.starhope.appius.net.BatchProcessor;
import org.starhope.appius.net.HttpSSLServer;
import org.starhope.appius.net.ListeningThread;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.net.StreamProcessor;
import org.starhope.appius.net.WebSocketListener;
import org.starhope.appius.net.WebSocketProcessor;
import org.starhope.appius.physica.Kalendor;
import org.starhope.appius.services.Charon;
import org.starhope.appius.sys.admin.TheZones;
import org.starhope.appius.sys.op.OpCommands;
import org.starhope.appius.test.UserLoadTest;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.User;
import org.starhope.appius.user.UserPowerKeeper;
import org.starhope.appius.util.AcceptsMetronomeTicks;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.catullus.GaiusValeriusCatullus;
import org.starhope.util.LibMisc;

/**
 * <p>
 * Appius Claudius Caecus is a game server application framework.
 * Extensible using Java classes loaded from its extensive library of
 * configurable options, Appius provides a network server for real-time
 * data exchange.
 * </p>
 * <p>
 * Originally titled “Braque,” this application was developed for use
 * with the videogame (work in progress) “Sideres.” It was designed to
 * operate with a messaging protocol called “Cubist,” which has since
 * been defined in terms of a simple JSON + \0 wire protocol.
 * </p>
 * <p>
 * Since that time, I have repurposed the game engine for use with
 * Tootsville™ (http://www.Tootsville.com/) and set up a new series of
 * communications supports designed to be compatible with the
 * ActionScript 3 libraries for Smart Fox Server Pro.
 * </p>
 * <p>
 * The server should still be able to operate on its own with minimal
 * changes. Most of the Tootsville-specific code has been isolated into
 * the com.tootsville.* package, but replacement code for some methods
 * might be needed to create a stand-alone game. Also, some default
 * configuration values are Tootsville-oriented.
 * </p>
 * <p>
 * This class in general operates as both the main game thread and
 * socket listener — in the static methods and variables — and the
 * client-connected user thread — in the instance methods and variables.
 * The “metronome” timer thread also runs using the static methods of
 * this class.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class AppiusClaudiusCaecus {
	/**
	 * Prepared statement used to inject log entries into the log
	 */
	private static PreparedStatement blatherStatement;
	
	/**
	 * The time at which the server was started
	 */
	private static final long bootTime = System.currentTimeMillis ();
	
	/**
	 * when were bugs eMailed? Don't blow up my mailbox
	 */
	static Set <Long> bugsMailed = new HashSet <Long> ();
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static GaiusValeriusCatullus catullus;
	
	/**
	 * Determines if this server is running with extra debug info
	 */
	public final static boolean debug = "true".equals (System
			.getProperty ("debug"));
	
	/**
	 * Default listeners are called for actions on all rooms in the
	 * world
	 */
	private static Collection <RoomListener> defaultListeners = new LinkedList <RoomListener> ();
	
	/**
	 * The delay before the first run of the NPC manager task.
	 */
	public static final int DELAY_MS = 5000;
	
	/**
	 * If true, the internal user system load testing should be enabled
	 */
	private static boolean doUserLoadTest = false;
	
	/**
	 * The most users who have been online since the server started
	 */
	private static int highWaterUsers = 0;
	
	/**
	 * HTTPS server for AJAX functionality
	 */
	private static HttpSSLServer https = new HttpSSLServer ();
	
	/**
	 * If true, this is a follower server in a cluster (not the leader)
	 */
	private static boolean isFollower = false;
	
	/**
	 * The date format used for system messages. A constant.
	 */
	final static SimpleDateFormat isoDate = new SimpleDateFormat (
			"yyyy-MM-dd HH:mm:ss");
	
	/**
	 * The connection to the journal database, used by blather
	 */
	private static Connection journalDB;
	
	/**
	 * the kalendor
	 */
	private static final Kalendor kalendor = new Kalendor ();
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static Timer kalendorTimer;
	
	/**
	 * If this ever transitions to “false,” stop listening for new
	 * connections. Global kill switch.
	 */
	private static boolean keepRunning = true;
	
	/**
	 * If the journaling database goes offline, this variable will keep
	 * from getting a flood of bug reports. On every successful write
	 * to the journal database, this flag is reset to false. However,
	 * after any failure, it flip-flops to true, allowing only one bug
	 * report to be mailed at a time.
	 */
	private static boolean knowWhyJournalDBOut = false;
	
	/**
	 * The time at which the global metronome thread last ticked.
	 */
	private static long lastMetronomeTick = System
			.currentTimeMillis ();
	
	/**
	 * all listeners who might be active
	 */
	static Collection <ListeningThread> listeningThreads = new ConcurrentSkipListSet <ListeningThread> ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static final Logger log = LoggerFactory
			.getLogger (AppiusClaudiusCaecus.class);
	
	/**
	 * WRITEME
	 */
	private static ListeningThread mainListeningThread = null;
	
	/**
	 * The timer driving the global metronome.
	 */
	static Timer metronome;
	
	/**
	 * Collection of arbitrary objects who wish to receive Metronome
	 * ticks
	 */
	private final static ConcurrentLinkedQueue <AcceptsMetronomeTicks> metronomeListeners = new ConcurrentLinkedQueue <AcceptsMetronomeTicks> ();
	
	/**
	 * The global metronome thread.
	 */
	static Thread metronomeThread;
	
	/**
	 * Message of the day
	 */
	private static String motd = "";
	
	/**
	 * addresses from which connections are not accepted
	 */
	private static Collection <String> quenchedAddresses = new ConcurrentSkipListSet <String> ();
	
	/**
	 * The version of the serialized form of this class.
	 */
	private static final long serialVersionUID = 3936846581752697097L;
	
	/**
	 * All live server threads
	 */
	private static ConcurrentHashMap <String, ServerThread> serverThreads = new ConcurrentHashMap <String, ServerThread> ();
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static ZoneSpawner spawner;
	
	/**
	 * A global boolean flag to indicate that the server has started up
	 * successfully
	 */
	private static boolean started;
	
	/**
	 * Time at which the Game State pump last ran
	 */
	private static long tGameStatePump;
	
	/**
	 * Thread groups, by name.
	 */
	private static ConcurrentHashMap <String, ThreadGroup> threadGroups = new ConcurrentHashMap <String, ThreadGroup> ();
	
	/**
	 * Time at which the server statistics were last “reportBug” mailed
	 */
	private static long tStats = 0;
	
	/**
	 * The number of milliseconds in 21 years. Used for
	 * autovivification of accounts.
	 */
	public static final int TWENTY_ONE_YEARS_MSEC = 365 * 21 * 60 * 60
			* 1000;
	
	/**
	 * Add a thread to the Metronome tick event schedule without that
	 * thread being
	 * 
	 * @param listener The listener who wishes to receive Metronome
	 *             ticks.
	 */
	public static void add (final AcceptsMetronomeTicks listener) {
		AppiusClaudiusCaecus.metronomeListeners.add (listener);
	}
	
	/**
	 * @param listeningThread to be added
	 */
	public static void add (final ListeningThread listeningThread) {
		AppiusClaudiusCaecus.listeningThreads.add (listeningThread);
	}
	
	/**
	 * Add a Zone to the global Zones list
	 * 
	 * @param zone the Zone to be added
	 */
	public static void add (final Zone zone) {
		TheZones.local ().add (zone);
	}
	
	/**
	 * Add a default room listener to all rooms in every zone (except
	 * limbo rooms)
	 * 
	 * @param listener the new default listener to be added
	 */
	public static void addDefaultListener (final RoomListener listener) {
		AppiusClaudiusCaecus.defaultListeners.add (listener);
	}
	
	/**
	 * @param zoneName The zone's name (ignored)
	 * @param zone The Zone object
	 * @deprecated use {@link #add(Zone)}
	 */
	@Deprecated
	public static void addZone (final String zoneName, final Zone zone) {
		AppiusClaudiusCaecus.add (zone);
	}
	
	/**
	 * WRITEME: Document this method brpocock
	 * 
	 * @param aString WRITEME 
	 */
	public static void blather (final String aString) {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method blather in AppiusClaudiusCaecus, added Jan 31, 2012 by brpocock. TODO.");
		
	}
	
	/**
	 * WRITEME: Document this method brpocock
	 * 
	 * @param aString WRITEME 
	 * @param aString2
	 */
	public static void bugDuplex (final String aString,
			final String aString2) {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method bugDuplex in AppiusClaudiusCaecus, added Jan 31, 2012 by brpocock. TODO.");
		
	}
	
	/**
	 * Create the $Eden special login zone. Normally happens on the
	 * lead server of a cluster during start-up
	 * 
	 * @return the login zone
	 */
	private static Zone createLoginZone () {
		TheZones.loginZone = new Zone ("$Eden");
		
		TheZones.loginZone.init ();
		TheZones.loginZone.activate ();
		return TheZones.loginZone;
	}
	
	/**
	 * Get the accurate number of users in all zones.
	 * 
	 * @return The number of users in all zones.
	 */
	private static int getAccurateHeadcount () {
		int sum = 0;
		for (final Zone z : TheZones.local ().getZonesOn (
				AppiusClaudiusCaecus.getServerHostname ())) {
			if ( !z.getName ().startsWith ("$")) {
				sum += z.getAllUsersIDsInZone ().size ();
			}
		}
		return sum;
	}
	
	/**
	 * Get a collection of all users in all zones.
	 * 
	 * @return all users in all Zones
	 */
	public static Collection <AbstractUser> getAllUsers () {
		final HashSet <AbstractUser> everybody = new HashSet <AbstractUser> ();
		for (final Zone z : AppiusClaudiusCaecus.getAllZones ()) {
			everybody.addAll (z.getAllUsersInZone ());
		}
		return everybody;
	}
	
	/**
	 * @return All active zones in the multiverse
	 */
	public static LinkedList <Zone> getAllZones () {
		return new LinkedList <Zone> (TheZones.local ().getZonesOn (
				AppiusClaudiusCaecus.getServerHostname ()));
	}
	
	/**
	 * Get the server start time
	 * 
	 * @return The time at which the server started in milliseconds
	 *         since epoch
	 */
	public static long getBootTime () {
		return AppiusClaudiusCaecus.bootTime;
	}
	
	/**
	 * @return the C. Valerius Catullus object for remote method
	 *         invocation
	 */
	public static GaiusValeriusCatullus getCatullus () {
		return AppiusClaudiusCaecus.catullus;
	}
	
	/**
	 * Get the {@link Charon} reaper thread
	 * 
	 * @return Charon
	 */
	public static Charon getCharon () {
		return Charon.instance ();
	}
	
	/**
	 * Get the hostname of the cluster leader, or this server if it is
	 * the cluster leader
	 * 
	 * @return the hostname of the cluster leader
	 */
	public static String getClusterLeader () {
		return AppiusClaudiusCaecus.isFollower ? TheZones.clusterLeader
				: AppiusClaudiusCaecus.getServerHostname ();
	}
	
	/**
	 * Get the set of default room listeners upon all rooms in the
	 * world
	 * 
	 * @return the default room listeners
	 */
	public static Collection <RoomListener> getDefaultListeners () {
		final Collection <RoomListener> returns = new LinkedList <RoomListener> ();
		returns.addAll (AppiusClaudiusCaecus.defaultListeners);
		return returns;
	}
	
	/**
	 * Get the high-water mark count of users
	 * 
	 * @return the highest number of simultaneous users who have been
	 *         online since server boot
	 */
	public static int getHighWaterUsers () {
		AppiusClaudiusCaecus.updateHighWaterMark ();
		return AppiusClaudiusCaecus.highWaterUsers;
	}
	
	/**
	 * @return the https
	 */
	public static HttpSSLServer getHttps () {
		if ( (https == null)
				|| ( !https.isReadyToRun () && !https.running ())) {
			https = new HttpSSLServer ();
		}
		return https;
	}
	
	/**
	 * @return the kalendor
	 */
	public static Kalendor getKalendor () {
		return AppiusClaudiusCaecus.kalendor;
	}
	
	/**
	 * @return the time at which the metronome last ticked
	 */
	public static long getLastMetronomeTick () {
		return AppiusClaudiusCaecus.lastMetronomeTick;
	}
	
	/**
	 * @return the login zone
	 */
	public static Zone getLoginZone () {
		if (null == TheZones.loginZone) {
			return AppiusClaudiusCaecus.createLoginZone ();
		}
		return TheZones.loginZone;
	}
	
	/**
	 * @return the motd
	 */
	public static String getMOTD () {
		return AppiusClaudiusCaecus.motd;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public static Set <String> getQuenchedAddresses () {
		return new HashSet <String> (
				AppiusClaudiusCaecus.quenchedAddresses);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 * @throws NotFoundException WRITEME
	 */
	static Class <? extends RunCommands> getRCClass ()
			throws NotFoundException {
		final String runCommandsClass = AppiusConfig
				.getConfig ("org.starhope.appius.runCommands");
		AppiusClaudiusCaecus.log.debug ("runCommands class : {}",
				runCommandsClass);
		Class <? extends Object> runCommands = null;
		try {
			runCommands = Class.forName (runCommandsClass);
		} catch (final ClassNotFoundException e) {
			AppiusClaudiusCaecus.log
					.error ("Caught a ClassNotFoundException in AppiusClaudiusCaecus.runCommands ",
							e);
			return null;
		}
		Class <? extends RunCommands> rcRC = null;
		try {
			rcRC = runCommands.asSubclass (RunCommands.class);
		} catch (final ClassCastException e) {
			AppiusClaudiusCaecus.log
					.error ("Caught a ClassCastException in AppiusClaudiusCaecus.runCommands ",
							e);
			return null;
		}
		return rcRC;
	}
	
	/**
	 * Get the revision number of this file
	 * 
	 * @return The revision number of this file
	 */
	public static String getRev () {
		return "$Rev: 2293 $";
	}
	
	/**
	 * Get the hostname on which the server process is running
	 * 
	 * @return the hostname of the local host
	 */
	public static String getServerHostname () {
		String result = "";
		try {
			result = InetAddress.getLocalHost ().getHostName ();
		} catch (final UnknownHostException e) {
			AppiusClaudiusCaecus.log.error (
					"Failed to find host name", e);
		}
		return result;
	}
	
	/**
	 * @return a string listing all active server ports, comma-joined
	 */
	public static String getServerPorts () {
		final StringBuilder ports = new StringBuilder ();
		for (final ListeningThread t : AppiusClaudiusCaecus.listeningThreads) {
			ports.append (t.getPortNumber ());
			ports.append (',');
		}
		return ports.toString ();
	}
	
	/**
	 * Returns the number of server threads running. There are more
	 * threads in the VM, because there are also bookkeeping threads,
	 * the main listener, the metronome, etc.
	 * 
	 * @return The number of server threads running
	 */
	public static int getThreadCount () {
		AppiusClaudiusCaecus.updateHighWaterMark ();
		return AppiusClaudiusCaecus.serverThreads.size ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param string WRITEME
	 * @return WRITEME
	 */
	public static ThreadGroup getThreadGroup (final String string) {
		final ThreadGroup group = AppiusClaudiusCaecus.threadGroups
				.get (string);
		if (null == group) {
			final ThreadGroup t = new ThreadGroup (string);
			AppiusClaudiusCaecus.threadGroups.put (string, t);
			return t;
		}
		return group;
	}
	
	/**
	 * Find a Zone object for a given zone name
	 * 
	 * @param zoneName The name of the zone to be found
	 * @return The Zone object, if the selected Zone exists; else, null
	 * @throws NotFoundException
	 */
	public static Zone getZone (final String zoneName)
			throws NotFoundException {
		Zone z = null;
		z = TheZones.local ().get (zoneName);
		return z;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public static ZoneSpawner getZoneSpawner () {
		return AppiusClaudiusCaecus.spawner;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private static void installShutdownHooks () {
		Runtime.getRuntime ().addShutdownHook (new Thread () {
			/**
			 * @see java.lang.Thread#run()
			 */
			@Override
			public void run () {
				AppiusClaudiusCaecus.shutdown ();
			}
		});
	}
	
	/**
	 * @return true, if this is a follower server in a cluster (not the
	 *         leader)
	 */
	public static boolean isFollower () {
		return AppiusClaudiusCaecus.isFollower;
	}
	
	/**
	 * @return true, if this is the leader server in a cluster (not a
	 *         follower)
	 */
	public static boolean isLeader () {
		return !AppiusClaudiusCaecus.isFollower;
	}
	
	/**
	 * Determine whether a zone is active
	 * 
	 * @param zoneName the name of the zone
	 * @return true, if the zone is active
	 */
	public static boolean isZoneActive (final String zoneName) {
		try {
			TheZones.local ().get (zoneName);
			return true;
		} catch (final NotFoundException e) {
			return false;
		}
	}
	
	/**
	 * Begin threads to listen on the stream and batch ports.
	 */
	private static void listenForever () {
		boolean critical = false;
		while ( !critical) {
			try {
				AppiusClaudiusCaecus.mainListeningThread = new ListeningThread (
						StreamProcessor.class,
						"org.starhope.appius.net.stream");
				AppiusClaudiusCaecus.mainListeningThread.start ();
				critical = true;
			} catch (final Throwable e) {
				BugReporter.getReporter ("srv").reportBug (
						"Can't listen for streams", e);
			}
		}
		if (AppiusClaudiusCaecus.isLeader ()) {
			try {
				new ListeningThread (BatchProcessor.class,
						"org.starhope.appius.net.batch").start ();
			} catch (final Throwable e) {
				BugReporter.getReporter ("srv").reportBug (
						"Can't listen for batch calls", e);
			}
		}
		try {
			new ListeningThread (AdminProcessor.class,
					"org.starhope.appius.net.backdoor").start ();
		} catch (final Throwable e) {
			BugReporter.getReporter ("srv").reportBug (
					"Can't listen on admin backdoor", e);
		}
		if (AppiusClaudiusCaecus.isLeader ()) {
			try {
				new WebSocketListener (WebSocketProcessor.class,
						"org.starhope.appius.net.websocket")
						.start ();
			} catch (final Throwable e) {
				BugReporter.getReporter ("srv").reportBug (
						"Can't listen on Caesar port", e);
			}
		}
	}
	
	/**
	 * This is the main routine to run Appius as a stand-alone server.
	 * 
	 * @param argv Any command-line arguments
	 * @throws IOException if there's an I/O exception
	 */
	public static void main (final String [] argv) throws IOException {
		Thread.currentThread ().setName ("AppiusClaudiusCaecus.main");
		
		AppiusClaudiusCaecus.log.debug ("parsing argv…");
		AppiusClaudiusCaecus.parseArgV (argv);
		
		AppiusConfig.init ();
		
		AppiusClaudiusCaecus.log.info ("Server Startup");
		
		AppiusClaudiusCaecus.log
				.debug ("Installing shutdown handler");
		AppiusClaudiusCaecus.installShutdownHooks ();
		
		AppiusClaudiusCaecus.log.debug ("Starting Charon");
		Charon.instance ().start ();
		
		AppiusClaudiusCaecus.log
				.debug ("Setting uncaught exception handler");
		Thread.setDefaultUncaughtExceptionHandler (new ServerThread (
				"AppiusClaudiusCaecus.uncaughtExceptionHandler"));
		
		AppiusClaudiusCaecus.log.debug ("running rc");
		AppiusClaudiusCaecus.runCommands ();
		AppiusClaudiusCaecus.log.debug ("creating login zone…");
		AppiusClaudiusCaecus.createLoginZone ();
		
		AppiusClaudiusCaecus.log.debug ("starting metronome…");
		AppiusClaudiusCaecus.startMetronome ();
		AppiusClaudiusCaecus.log.debug ("starting zone spawner…");
		AppiusClaudiusCaecus.spawner = new ZoneSpawner (
				AppiusClaudiusCaecus.getServerHostname ());
		AppiusClaudiusCaecus.log.debug ("spawner = "
				+ AppiusClaudiusCaecus.spawner.toString ());
		AppiusClaudiusCaecus.add (AppiusClaudiusCaecus.spawner);
		AppiusClaudiusCaecus.log.debug ("…added to Metronome list");
		
		if (AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.catullus.server")) {
			AppiusClaudiusCaecus.log
					.debug ("Starting C. Valerius Catullus…");
			try {
				AppiusClaudiusCaecus.catullus = new GaiusValeriusCatullus ();
			} catch (final NotReadyException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a NotReadyException in AppiusClaudiusCaecus.main ",
								e);
			}
		} else {
			AppiusClaudiusCaecus.catullus = null;
		}
		
		AppiusClaudiusCaecus.log
				.debug ("starting user load test, if selected…");
		AppiusClaudiusCaecus.startUserLoadTest ();
		
		AppiusClaudiusCaecus.log
				.debug ("starting listening threads…");
		
		AppiusClaudiusCaecus.listenForever ();
		
		AppiusClaudiusCaecus.started = true;
		AppiusClaudiusCaecus.log
				.debug ("Appius Claudius Caecus server started");
		
		while (AppiusClaudiusCaecus.keepRunning) {
			try {
				Thread.sleep (3000);
			} catch (final InterruptedException e) {
				/* Don't care. */
			}
		}
		
		AppiusClaudiusCaecus.log.info ("Exiting");
	}
	
	/**
	 * <p>
	 * Migrate all users to another host. They will attempt to connect
	 * to identical zones as the ones which are currently active.
	 * </p>
	 * <p>
	 * This is a low-level function and does nothing to ensure that the
	 * given zone actually exists on the other server
	 * </p>
	 * 
	 * @param otherHost the other host to which users should migrate
	 * @param otherPort the other host's listening port to which users
	 *             should migrate
	 */
	public static void migrateAll (final String otherHost,
			final int otherPort) {
		for (final ServerThread server : AppiusClaudiusCaecus.serverThreads
				.values ()) {
			final String zoneName = null == server.getUser ()
					.getZone () ? server.getUser ().getZone ()
					.getName () : "$Eden";
			server.migrate (otherHost, otherPort, zoneName);
		}
	}
	
	/**
	 * Parse command-line arguments (for the loosest definition of
	 * “parse”)
	 * 
	 * @param argv Command-line arguments “vector”
	 * @throws NumberFormatException if a numerical parameter can't be
	 *              interpreted properly
	 */
	private static void parseArgV (final String [] argv)
			throws NumberFormatException {
		int argc = 0;
		while (argv.length > argc) {
			final String arg = argv [argc++ ];
			if ("-c".equals (arg)) {
				final String key = argv [argc++ ];
				final String value = argv [argc++ ];
				AppiusConfig.setConfig (key, value);
			}
			if ("-t".equals (arg)) {
				AppiusClaudiusCaecus.doUserLoadTest = true;
			}
			if ("-f".equals (arg)) {
				AppiusClaudiusCaecus.isFollower = true;
				TheZones.clusterLeader = argv [argc++ ];
			}
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param address WRITEME
	 */
	public static void quenchConnectionsFrom (final InetAddress address) {
		AppiusClaudiusCaecus.quenchedAddresses.add (address
				.getHostAddress ());
	}
	
	/**
	 * Remove a metronome listener
	 * 
	 * @param listener The listener to deregister
	 */
	public static void remove (final AcceptsMetronomeTicks listener) {
		AppiusClaudiusCaecus.metronomeListeners.remove (listener);
	}
	
	/**
	 * @param listeningThread WRITEME
	 */
	public static void remove (final ListeningThread listeningThread) {
		AppiusClaudiusCaecus.listeningThreads
				.remove (listeningThread);
	}
	
	/**
	 * Remove a zone from the server
	 * 
	 * @param whichZone The zone to be removed
	 * @deprecated Use {@link TheZones#remove(Zone)} instead
	 */
	@Deprecated
	public static void remove (final Zone whichZone) {
		TheZones.local ().remove (whichZone);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private static void reportRestartBefore () {
		AppiusClaudiusCaecus.wallops (Nomenclator.getSystemUser (),
				"The server is restarting (initiated by "
						+ Thread.currentThread ().getName ());
		
		// OpCommands
		// .op_wall (
		// new String [] {
		// "The game will be stopping for just a moment, but we'll be right back!"
		// },
		// Nomenclator.getSystemUser (),
		// AppiusClaudiusCaecus.zones.get ("$Eden")
		// .getNextLobby ());
		AppiusClaudiusCaecus.log.debug ("Restart requested     !");
		AppiusClaudiusCaecus.log.debug ("Restart requested    !!!");
		AppiusClaudiusCaecus.log.debug ("Restart requested   !!!!!");
		AppiusClaudiusCaecus.log.debug ("Restart requested  !!!!!!!");
		AppiusClaudiusCaecus.log
				.debug ("Restart requested !!!!!!!!!");
		try {
			Mail.sendMail (
					Nomenclator.getUserByID (2).getMail (),
					"Appius Claudius Caecus restart requested",
					"Attention! A server restart has been requested!\n\n"
							+ "This is kinda scary, so I'm sending this\n"
							+ "message as I begin global destruction.\n\n"
							+ "My high-water mark was "
							+ AppiusClaudiusCaecus
									.getHighWaterUsers ()
							+ " users.\n\n"
							+ "The server restart was initiated by the following thread:\n\n"
							+ Thread.currentThread ()
									.toString ());
		} catch (final MessagingException e) {
			AppiusClaudiusCaecus.log
					.error ("Caught a MessagingException in restart (pre-restart mail)",
							e);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	private static void reportRestartFinal () {
		try {
			Mail.sendMail (
					Nomenclator.getUserByID (2).getMail (),
					"Appius Claudius Caecus restart re-executing",
					"The server restart is about to re-execute\n"
							+ "the server process naïvely.\n\n"
							+ "The server restart was initiated by the following thread:\n\n"
							+ Thread.currentThread ()
									.toString ());
		} catch (final MessagingException e) {
			AppiusClaudiusCaecus.log
					.error ("Caught a MessagingException in restart (post-restart mail)",
							e);
		}
		
		AppiusClaudiusCaecus.log.debug ("Restarting now        !");
		AppiusClaudiusCaecus.log.debug ("Restarting now       !!!");
		AppiusClaudiusCaecus.log.debug ("Restarting now      !!!!!");
		AppiusClaudiusCaecus.log.debug ("Restarting now     !!!!!!!");
		AppiusClaudiusCaecus.log
				.debug ("Restarting now    !!!!!!!!!");
		
	}
	
	/**
	 * This should restart the server, but it doesn't work (yet) XXX
	 */
	public static void restart () {
		
		final Thread dumper = new Thread () {
			@Override
			public void run () {
				OpCommands.op_dumpthreads (new String [] {},
						Nomenclator.getSystemUser (), null);
			}
		};
		dumper.start ();
		
		AppiusClaudiusCaecus.reportRestartBefore ();
		AppiusClaudiusCaecus.shutdown ();
		try {
			dumper.join ();
		} catch (final InterruptedException e1) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a InterruptedException in AppiusClaudiusCaecus.restart joining thread dumper",
							e1);
		}
		AppiusClaudiusCaecus.reportRestartFinal ();
		
		try {
			Runtime.getRuntime ().exec (
					"/opt/appius/restart.appius.silent");
			Runtime.getRuntime ().exit (0);
		} catch (final IOException e) {
			BugReporter.getReporter ("srv").reportBug (
					"Caught a IOException in restart", e);
		} catch (final Throwable t) {
			BugReporter.getReporter ("srv")
					.reportBug (t.toString ());
		}
		
		while (true) {
			try {
				Thread.sleep (1000);
			} catch (final InterruptedException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a InterruptedException on doomsday",
								e);
			}
			AppiusClaudiusCaecus.log.debug ("doomsday tick");
		}
	}
	
	/**
	 * Attempt to restart the global metronome — this probably won't
	 * work as currently implemented (?)
	 */
	public static void restartMetronome () {
		try {
			AppiusClaudiusCaecus.stopMetronome ();
		} catch (final Exception e) {
			BugReporter.getReporter ("srv").reportBug (
					"Metronome exception", e);
		}
		AppiusClaudiusCaecus.startMetronome ();
	}
	
	/**
	 * Run the initial "run commands" (RC) for the game in question.
	 * This is an auto-started script which is run once to initialize
	 * the game world for game-specific (e.g. Tootsville™-specific)
	 * initialization; it often will do things such as add default
	 * event listeners to rooms or initialize things.
	 */
	private static void runCommands () {
		try {
			final Class <? extends RunCommands> rcRC = AppiusClaudiusCaecus
					.getRCClass ();
			if (null == rcRC) {
				return;
			}
			RunCommands rc = null;
			try {
				rc = rcRC.newInstance ();
			} catch (final InstantiationException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a InstantiationException in AppiusClaudiusCaecus.runCommands ",
								e);
				return;
			} catch (final IllegalAccessException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a IllegalAccessException in AppiusClaudiusCaecus.runCommands ",
								e);
				return;
			}
			try {
				rc.run ();
			} catch (final Throwable t) {
				BugReporter.getReporter ("srv").reportBug (
						"Problem with run commands", t);
				return;
			}
			AppiusClaudiusCaecus.log.debug ("RC Complete");
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus.log
					.debug ("No runCommands class specified. Starting up pure and clean.");
			return;
		}
	}
	
	/**
	 * Send an eMail with server statistics, if the timer has elapsed
	 * 
	 * @param t the current time
	 */
	private static void sendStatsMail (final long t) {
		// if (t - AppiusClaudiusCaecus.tStats >
		// AppiusConfig.getIntOrDefault
		// ("org.starhope.appius.statsTimer",
		// 21600000)) {
		// final int sum = AppiusClaudiusCaecus.getAccurateHeadcount
		// ();
		// try {
		// final StringBuilder statsMsg = new StringBuilder ();
		// statsMsg.append ("The current number of users online is ");
		// statsMsg.append (sum);
		// statsMsg.append ("; with a high water mark of ");
		// statsMsg.append (AppiusClaudiusCaecus.getHighWaterUsers
		// ());
		// statsMsg.append (".\n\nServer started at ");
		// statsMsg.append (new java.sql.Timestamp
		// (AppiusClaudiusCaecus.bootTime));
		// statsMsg.append (" (");
		// statsMsg.append (LibMisc.formatPastDate (new Date
		// (AppiusClaudiusCaecus.bootTime)));
		// statsMsg.append (")");
		// Mail.sendMail (Nomenclator.getUserByID (2).getMail (),
		// "Stats — Appius Claudius Caecus",
		// statsMsg.toString ());
		// } catch (final MessagingException e) {
		// log.error ("Caught a MessagingException sending stats", e);
		// }
		// AppiusClaudiusCaecus.tStats = t;
		// }
	}
	
	/**
	 * Set the message of the day string
	 * 
	 * @param string new message of the day
	 */
	public static void setMOTD (final String string) {
		AppiusClaudiusCaecus.motd = string;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public static void shutdown () {
		AppiusClaudiusCaecus.log.info ("Server Shutdown");
		AppiusClaudiusCaecus.mainListeningThread.shutdown ();
		AppiusClaudiusCaecus.keepRunning = false;
		for (final ListeningThread t : AppiusClaudiusCaecus.listeningThreads) {
			t.shutdown ();
		}
		
		AppiusClaudiusCaecus.log
				.debug ("Beginning global destruction");
		UserPowerKeeper.instance ().shutdown ();
		
		AppiusClaudiusCaecus.log.debug ("Shutting down metronome");
		AppiusClaudiusCaecus.metronomeListeners.clear ();
		AppiusClaudiusCaecus.stopMetronome ();
		
		AppiusClaudiusCaecus.log.debug ("Destroying server threads");
		for (final ServerThread thread : AppiusClaudiusCaecus.serverThreads
				.values ()) {
			if (Thread.currentThread () != thread) {
				AppiusClaudiusCaecus.log
						.debug ("Destroying server thread "
								+ thread.getName ());
				thread.close ();
			}
		}
		AppiusClaudiusCaecus.serverThreads.clear ();
		
		AppiusClaudiusCaecus.log
				.debug ("Flushing all outstanding records to database");
		DataRecordFlushManager.flushAll ();
		
		AppiusClaudiusCaecus.log
				.debug ("After the Ball was over, Charon took out his glass eye...");
		try {
			Charon.instance ().join (10);
		} catch (final InterruptedException e1) {
			AppiusClaudiusCaecus.log
					.error ("Caught a InterruptedException in stopping Charon for restart",
							e1);
		}
		AppiusClaudiusCaecus.log
				.debug ("Global destruction complete");
	}
	
	/**
	 * Start the global metronome to ticking
	 */
	public static void startMetronome () {
		AppiusClaudiusCaecus.metronome = new Timer ("metronome", true);
		final TimerTask metronomeTask = new TimerTask () {
			@Override
			public void run () {
				AppiusClaudiusCaecus.tick ();
			}
		};
		final long tickInterval = AppiusConfig.getMetronomeTime ();
		final long fiveTicks = tickInterval * 5;
		AppiusClaudiusCaecus.metronome.scheduleAtFixedRate (
				metronomeTask, fiveTicks, tickInterval);
		AppiusClaudiusCaecus.kalendorTimer = new Timer ("kalendor",
				true);
		AppiusClaudiusCaecus.kalendorTimer.scheduleAtFixedRate (
				AppiusClaudiusCaecus.kalendor, fiveTicks,
				tickInterval);
	}
	
	/**
	 * Register an object (usually a server thread) who wishes to begin
	 * accepting metronome ticks.
	 * 
	 * @param thread the thread who wants to accept ticks now
	 */
	public static void startTicking (final ServerThread thread) {
		AppiusClaudiusCaecus.log.debug ("Adding " + thread.getName ()
				+ " to event timer");
		AppiusClaudiusCaecus.serverThreads.put (thread.getName (),
				thread);
		AppiusClaudiusCaecus.updateHighWaterMark ();
	}
	
	/**
	 * Start the parallel user load test threads
	 */
	private static void startUserLoadTest () {
		if (AppiusClaudiusCaecus.doUserLoadTest) {
			AppiusClaudiusCaecus.log
					.debug (" > Preparing for UserLoadTest");
			final UserLoadTest test = new UserLoadTest ();
			AppiusClaudiusCaecus.log
					.debug (" > Creating zones before UserLoadTest");
			ZoneSpawner.spawnNewZone ();
			ZoneSpawner.spawnNewZone ();
			ZoneSpawner.spawnNewZone ();
			AppiusClaudiusCaecus.log
					.debug (" > Starting UserLoadTest in 5 seconds");
			try {
				Thread.sleep (5000);
			} catch (final InterruptedException e) {
				AppiusClaudiusCaecus.log.error (
						"Caught a InterruptedException in main",
						e);
			}
			AppiusClaudiusCaecus.log
					.debug (" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Starting UserLoadTest!");
			test.start ();
		}
	}
	
	/**
	 *
	 */
	public synchronized static void stopMetronome () {
		if (null == AppiusClaudiusCaecus.metronome) {
			return;
		}
		try {
			AppiusClaudiusCaecus.metronome.cancel ();
		} catch (final Exception e) {
			AppiusClaudiusCaecus.log
					.error ("Metronome exception", e);
		}
		AppiusClaudiusCaecus.metronome = null;
	}
	
	/**
	 * Stop sending metronome ticks to a particular object. If that
	 * object happens to be a {@link Thread} as well, also sends the
	 * {@link Thread} an {@link Thread#interrupt()}. If it's an
	 * instance of {@link ServerThread}, it will first call the
	 * thread's {@link ServerThread#end()} method.
	 * 
	 * @param thread the object who doesn't want to get any more ticks
	 */
	public static void stopTicking (final AcceptsMetronomeTicks thread) {
		int antiThrash = 10;
		while (AppiusClaudiusCaecus.serverThreads
				.containsValue (thread)) {
			AppiusClaudiusCaecus.log.debug ("Removing "
					+ thread.getName () + " from event timer…");
			for (final Entry <String, ServerThread> ent : AppiusClaudiusCaecus.serverThreads
					.entrySet ()) {
				if (ent.getValue ().equals (thread)) {
					AppiusClaudiusCaecus.log.debug ("Removing "
							+ thread.getName () + " ("
							+ ent.getKey () + ")");
					AppiusClaudiusCaecus.serverThreads.remove (ent
							.getKey ());
				}
			}
			if ( --antiThrash < 0) {
				AppiusClaudiusCaecus.log
						.error ("Can't get rid of thread!");
				return;
			}
		}
		if (thread instanceof ServerThread) {
			((ServerThread) thread).end ();
		} else if (thread instanceof Thread) {
			((Thread) thread).interrupt ();
		}
	}
	
	/**
	 * The main metronome single-threaded tick
	 */
	public static void tick () {
		final long t = System.currentTimeMillis ();
		final long deltaT = t
				- AppiusClaudiusCaecus.lastMetronomeTick;
		final boolean dumpUserThreads;
		if (AppiusConfig.getConfigBoolOrFalse ("dumpUserThreads")) {
			AppiusClaudiusCaecus.log
					.info ("\n\n *** Dumping All User Threads *** \n\n");
			dumpUserThreads = true;
		} else {
			dumpUserThreads = false;
		}
		
		AppiusClaudiusCaecus.tickServerThreads (t, deltaT,
				dumpUserThreads);
		AppiusClaudiusCaecus.tickMetronomeListeners (t, deltaT);
		AppiusClaudiusCaecus.tickGameStatePump (t);
		AppiusClaudiusCaecus.sendStatsMail (t);
		AppiusClaudiusCaecus.lastMetronomeTick = t;
		
	}
	
	/**
	 * Send a metronome tick to the game state pump
	 * 
	 * @param t The current time
	 */
	private static void tickGameStatePump (final long t) {
		if ( (t - AppiusClaudiusCaecus.tGameStatePump) > AppiusConfig
				.getIntOrDefault (
						"org.starhope.appius.gameStateChangeTime",
						400)) {
			GameRoom.propagateGameStateChange ();
			AppiusClaudiusCaecus.tGameStatePump = t;
		}
	}
	
	/**
	 * Tick all listeners to the Metronome
	 * 
	 * @param t the current time in milliseconds (at the start of the
	 *             global “tick”)
	 * @param deltaT the time since the last metronome tick
	 */
	private static void tickMetronomeListeners (final long t,
			final long deltaT) {
		for (final AcceptsMetronomeTicks listener : AppiusClaudiusCaecus.metronomeListeners) {
			try {
				if (null == listener) {
					AppiusClaudiusCaecus.metronomeListeners
							.remove (listener);
				} else {
					listener.tick (t, deltaT);
				}
			} catch (final UserDeadException e) {
				// No op
			} catch (final Throwable e) {
				AppiusClaudiusCaecus.log.error (
						"Metronome tick exception", e);
			}
		}
	}
	
	/**
	 * Tick all server threads
	 * 
	 * @param t The time at the start of the tick
	 * @param deltaT The time since the last tick
	 * @param dumpUserThreads If true, dump out the status information
	 *             on each thread to STDOUT
	 */
	private static void tickServerThreads (final long t,
			final long deltaT, final boolean dumpUserThreads) {
		for (final ServerThread listener : AppiusClaudiusCaecus.serverThreads
				.values ()) {
			try {
				listener.tick (t, deltaT);
				if (dumpUserThreads) {
					log.info (listener.toString ());
					log.info (LibMisc.stringify (listener
							.getStackTrace ()));
				}
			} catch (final UserDeadException e) {
				listener.sendAdminDisconnect (
						"Your Internet connection was believed to be disconnected. If you are seeing this message, please contact Customer Service. Code Lazarus "
								+ AppiusClaudiusCaecus
										.getRev (),
						"Disconnected from server", "Lazarus",
						"doa");
				listener.close ();
			} catch (final Throwable e) {
				AppiusClaudiusCaecus.log.error ("Exception", e);
			}
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param address WRITEME
	 */
	public static void unquench (final InetAddress address) {
		AppiusClaudiusCaecus.quenchedAddresses.remove (address
				.toString ());
	}
	
	/**
	 * Update the high water mark, if necessary
	 */
	public static void updateHighWaterMark () {
		final int currentUsers = AppiusClaudiusCaecus
				.getAccurateHeadcount ();
		if (currentUsers > AppiusClaudiusCaecus.highWaterUsers) {
			AppiusClaudiusCaecus.highWaterUsers = currentUsers;
		}
	}
	
	/**
	 * Write a message to all online operators
	 * 
	 * @param user The user sending the message
	 * @param string The message to broadcast
	 */
	public static void wallops (final AbstractUser user,
			final String string) {
		for (final AbstractUser anybody : AppiusClaudiusCaecus
				.getAllUsers ()) {
			if (anybody.getStaffLevel () > User.STAFF_LEVEL_PUBLIC) {
				anybody.acceptMessage ("Write to all operators",
						user.getAvatarLabel (), string);
			}
		}
	}
	
	/**
	 * The version information, published here for implementations to
	 * refer back to.
	 */
	public final String versionInformation = "Appius Claudius Cæcus Game Server\n"
			+ "Copyright © 2009-2012, Bruce-Robert Pocock\n"
			+ "This program is free software; you can redistribute it and/or modify "
			+ "it under the terms of the GNU Affero General Public License as published by "
			+ "the Free Software Foundation, either version 3 of the License, or (at "
			+ "your option) any later version.\n"
			+ "This program is distributed in the hope that it will be useful, but "
			+ "WITHOUT ANY WARRANTY; without even the implied warranty of "
			+ "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU "
			+ "General Public License for more details.\n"
			+ "You should have received a copy of the GNU Affero General Public License "
			+ "along with this program. If not, see http://www.gnu.org/licenses/ .\n"
			+ "Thanks to Res Interactive, LLC for their sponsorship.";
	
}
