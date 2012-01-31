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

package org.starhope.util;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.Socket;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.Lock;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Channel;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.net.LocalisedThread;
import org.starhope.appius.net.NetIOThread;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.physica.Geometry;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.CastsToJSON;
import org.starhope.util.types.CanProcessCommands;
import org.starhope.util.types.CommandExecutorThread;

/**
 * Miscellaneous utility methods that might be useful elsewhere
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class LibMisc {
	/**
	 * Word-forms of English cardinal numbers
	 */
	private final static String cardinalNumberWords_English[] = {
			"zero", "one", "two", "three", "four", "five", "six",
			"seven", "eight", "nine", "ten" };
	
	/**
	 * An extension class can be registered to supplement or replace
	 * methods in the basic built-in command interpreters. This is
	 * where they're stored.
	 */
	private static final HashMap <Class <?>, Class <?>> extensionClasses = new HashMap <Class <?>, Class <?>> ();
	
	/**
	 * Maximum number of times to clear the socket input buffer.
	 */
	static int MAX_SHUTDOWN_TRIES = 20;
	
	/**
	 * The currently-loaded message catalogs
	 */
	private static Map <String, Properties> messages = new ConcurrentHashMap <String, Properties> ();
	
	/**
	 * determine whether an user has (or will have, or had) reached
	 * his/her destination location at the time given. Uses
	 * {@link Geometry#getTimeToTarget(AbstractUser, long)}
	 * 
	 * @param thing Who are we?
	 * @param when When are we?
	 * @return true if we've arrived on station
	 */
	public static boolean areWeThereYet (final AbstractUser thing,
			final long when) {
		if (Geometry.getTimeToTarget (thing, when) > 0) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
	 * Get the English string form of a cardinal number
	 * 
	 * @param number a number
	 * @return a string
	 */
	private static String cardinalNumber_English (final int number) {
		if (number < 0) {
			return "negative "
					+ LibMisc.cardinalNumber_English ( -number);
		}
		if (number < 10) {
			return LibMisc.cardinalNumberWords_English [number];
		}
		return String.valueOf (number);
	}
	
	/**
	 * Close a bunch of things carefully, ignoring exceptions. The
	 * “things” supported, thus far, are:
	 * <ul>
	 * <li>JDBC ResultSet</li>
	 * <li>JDBC Statement</li>
	 * <li>JDBC Connection</li>
	 * <li>Lock:s</li>
	 * </ul>
	 * <p>
	 * This is mostly meant for “finally” clauses.
	 * 
	 * @param things A set of SQL statements, result sets, and database
	 *             connections
	 */
	public static void closeAll (final Object... things) {
		for (final Object thing : things) {
			if (null != thing) {
				try {
					if (thing instanceof ResultSet) {
						try {
							((ResultSet) thing).close ();
						} catch (final SQLException e) {
							/* No Op */
						}
					}
					if (thing instanceof Statement) {
						try {
							((Statement) thing).close ();
						} catch (final SQLException e) {
							/* No Op */
						}
					}
					if (thing instanceof Connection) {
						try {
							((Connection) thing).close ();
						} catch (final SQLException e) {
							/* No Op */
						}
					}
					if (thing instanceof Lock) {
						try {
							((Lock) thing).unlock ();
						} catch (final IllegalMonitorStateException e) {
							/* No Op */
						}
					}
				} catch (final RuntimeException e) {
					/* No Op */
				}
			}
		}
	}
	
	/**
	 * <p>
	 * Execute a command with a certain method signature from klass,
	 * passing it the JSON parameters as well as the environment
	 * (thread, zone, and user) to run with.
	 * </p>
	 * <p>
	 * The class klass is searched for a method with the name
	 * "do_COMMAND", which must take a Zone, JSONObject, User, and
	 * Integer (as a room number in which the user is standing) as
	 * input parameters. If no such method is found, the extension
	 * class (if any) defined for klass using
	 * {@link #loadExtension(Class)} will also be searched, before
	 * reporting an error back to the command thread.
	 * </p>
	 * 
	 * @param cmd The command's string name
	 * @param jso JSON parameters to that command
	 * @param commandThread The command processor thread
	 * @param user The user initiating the command
	 * @param channel The channel the command came in on
	 * @param klass The command-processor class in which to search for
	 *             the command
	 */
	public static void commandJSON (final String cmd,
			final JSONObject jso,
			final CanProcessCommands commandThread,
			final AbstractUser user, final String channel,
			final Class <?> klass) {
		final Class <?> extension = LibMisc.loadExtension (klass);
		
		Method commandProcessor = null;
		try {
			commandProcessor = klass.getMethod ("do_" + cmd,
					JSONObject.class, AbstractUser.class,
					Channel.class);
		} catch (final SecurityException e) {
			commandThread.sendError_RAW (cmd, e.toString ());
			BugReporter.getReporter ("srv").reportBug (e);
		} catch (final NoSuchMethodException e) {
			try {
				commandProcessor = extension.getMethod (
						"do_" + cmd, JSONObject.class,
						AbstractUser.class, Channel.class);
			} catch (final SecurityException e1) {
				commandThread.sendError_RAW (cmd, e.toString ());
				BugReporter.getReporter ("srv").reportBug (e);
			} catch (final NoSuchMethodException e1) {
				commandThread.sendError_RAW ("*",
						"No such method: " + cmd);
			}
		}
		if (null != commandProcessor) {
			final Thread currentThread = Thread.currentThread ();
			if (currentThread instanceof ServerThread) {
				if ( ((NetIOThread) currentThread)
						.isParallelMode ()) {
					final CommandExecutorThread t = new CommandExecutorThread (
							cmd, jso, commandThread, user,
							channel, commandProcessor);
					((ServerThread) currentThread).adopt (t);
					
				} else {
					LibMisc.executeCommand (cmd, jso,
							commandThread, user, channel,
							commandProcessor);
				}
			}
		}
	}
	
	/**
	 * Condense a collection of collections down to just a collection.
	 * 
	 * @param sets a collection of collections
	 * @param <T> whatever type of stuff you want to put into it
	 * @return just a collection
	 */
	public static <T> Collection <T> condense (
			final Collection <Collection <T>> sets) {
		final Collection <T> result = new LinkedList <T> ();
		final Iterator <Collection <T>> setI = sets.iterator ();
		while (setI.hasNext ()) {
			final Iterator <T> i = setI.next ().iterator ();
			while (i.hasNext ()) {
				result.add (i.next ());
			}
		}
		return result;
	}
	
	/**
	 * Get the actual, current distance between the pivot points of two
	 * users at the given time.
	 * 
	 * @param from one thing
	 * @param to another thing
	 * @param when when is it
	 * @return the distance between the two objects
	 */
	public static double distance (final AbstractUser from,
			final AbstractUser to, final long when) {
		Geometry.updateUserPositioning (from, when);
		Geometry.updateUserPositioning (to, when);
		final Coord3D fromPos = from.getLocation ();
		final Coord3D toPos = to.getLocation ();
		return fromPos.distance (toPos);
	}
	
	/**
	 * Get the simple Pythagorean distance between two 2D coördinates.
	 * Prefer using {@link Coord2D#distance(Coord2D)} for most
	 * purposes.
	 * 
	 * @param x1 start x abcessa
	 * @param y1 start y ordinate
	 * @param x2 end x abcessa
	 * @param y2 end y ordinate
	 * @return distance
	 */
	public static double distance (final double x1, final double y1,
			final double x2, final double y2) {
		final double dX = x2 - x1;
		final double dY = y2 - y1;
		return Math.sqrt ( (dX * dX) + (dY * dY));
	}
	
	/**
	 * <p>
	 * Execute a JSON command from a class provided with specific
	 * methods, discovered using reflection.
	 * </p>
	 * <p>
	 * The JSON command name will be converted into a method name by
	 * prepending “do_” to the command verb, as a static method,
	 * returning void, with a series of parameters of the types:
	 * JSONObject, AbstractUser, and Room. The reflective command
	 * Method object must be passed in.
	 * </p>
	 * <p>
	 * The provided JSONObject and AbstractUser will be passed in; if
	 * the user is non-null, the contents of
	 * {@link AbstractUser#getRoom()} will be used as the final
	 * parameter; otherwise, a null will be provided.
	 * </p>
	 * 
	 * @param cmd The command verb
	 * @param jso JSON parameter data to be passed in to the command
	 *             processing method.
	 * @param commandThread The command thread who should receive any
	 *             errors from processing.
	 * @param user The user invoking the command (whose security
	 *             privileges will be used to perform actions under the
	 *             command's authority, as necessary)
	 * @param channel The channel the command came in on
	 * @param commandProcessor The method to be used to process the
	 *             command.
	 */
	public static void executeCommand (final String cmd,
			final JSONObject jso,
			final CanProcessCommands commandThread,
			final AbstractUser user, final String channel,
			final Method commandProcessor) {
		try {
			final String channelString = channel != null ? channel
					: null == user ? ""
							: user.getRoom () == null ? ""
									: user.getRoom ()
											.getMoniker ();
			final Channel ch = null == user ? null
					: user.getZone () != null ? user.getZone ()
							.getChannel (channelString) : null;
			final JSONObject ret = (JSONObject) commandProcessor
					.invoke (null, jso, user, ch);
			commandThread.setLastInputTime (System
					.currentTimeMillis ());
			commandThread.setBusyState (false);
			if (null != ret) {
				commandThread.sendResponse (ret);
			}
		} catch (final IllegalArgumentException e) {
			BugReporter.getReporter ("srv").reportBug (e);
			commandThread.sendError_RAW (cmd, e.toString ());
		} catch (final IllegalAccessException e) {
			BugReporter.getReporter ("srv").reportBug (e);
			commandThread.sendError_RAW (cmd, e.toString ());
		} catch (final InvocationTargetException e) {
			LibMisc.sendJSONCommandBugReport (cmd, jso,
					commandThread, user, e);
		} catch (final UserDeadException e) {
			// Ignore, this will fix itself by disconnecting the
			// offending thread
		} catch (final Exception e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Generic (unhandled) exception inside request handler",
							e);
			if ( (commandThread instanceof NetIOThread)
					&& ((NetIOThread) commandThread)
							.getVerboseBugReplies ()) {
				final String stringyE = LibMisc.stringify (e);
				commandThread.sendError_RAW ("*" + cmd,
						e.toString () + "\n\007\n" + stringyE);
				if (commandThread instanceof ServerThread) {
					try {
						((ServerThread) commandThread)
								.sendAdminMessage (stringyE,
										"Exception in JSON call "
												+ cmd,
										"Catullus", true);
					} catch (final UserDeadException e1) {
						BugReporter
								.getReporter ("srv")
								.reportBug (
										"Caught a UserDeadException in LibMisc.executeCommand ",
										e1);
					}
				}
			} else {
				commandThread.sendError_RAW ("*" + cmd,
						e.toString ());
			}
		}
	}
	
	/**
	 * Format a date in a natural-language way that is to occur in the
	 * future. For example, such a phrase might be “five minutes from
	 * now” or “12 years from now” or similar.
	 * 
	 * @param targetDate a date in the future
	 * @return a human-legible expression describing the time in the
	 *         future
	 */
	public static String formatFutureDate (final Date targetDate) {
		if (Thread.currentThread () instanceof LocalisedThread) {
			return LibMisc.formatFutureDate (targetDate,
					((LocalisedThread) Thread.currentThread ())
							.getLanguage ());
		}
		return LibMisc.formatFutureDate (targetDate, "en_US");
	}
	
	/**
	 * Format a future date in the given language. For example, this
	 * routine might yield something like “two years from now”
	 * 
	 * @param targetDate The date to be described
	 * @param language_dialect The language code and dialect subcode
	 *             (e.g. “en_US”) into which the message should be
	 *             formatted
	 * @return the message describing the date based on today
	 */
	public static String formatFutureDate (final Date targetDate,
			final String language_dialect) {
		if ( !language_dialect.equals ("en_US")) {
			BugReporter.getReporter ("srv").reportBug (
					"Formatting future date in English for user who wanted "
							+ language_dialect);
		}
		return LibMisc.formatFutureDate_English (targetDate);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 18,
	 * 2010)
	 * 
	 * @param targetDate a date in the future
	 * @param language the user's language
	 * @param dialect the user's dialect
	 * @return a human-legible expression describing the time in the
	 *         future
	 */
	public static String formatFutureDate (final Date targetDate,
			final String language, final String dialect) {
		return LibMisc.formatFutureDate (targetDate, language + "_"
				+ dialect);
	}
	
	/**
	 * @param targetDate a date in the future
	 * @return a human-legible expression describing the time in the
	 *         future
	 */
	private static String formatFutureDate_English (
			final Date targetDate) {
		final Date now = new Date ();
		if (targetDate.compareTo (now) < 0) {
			return "the past";
		}
		if (targetDate.compareTo (now) == 0) {
			return "right now";
		}
		
		final long diffSec = targetDate.getTime () - now.getTime ();
		
		if (diffSec <= 0) {
			return "already";
		}
		
		if (diffSec == 1) {
			return "a second from now";
		}
		
		if (diffSec < 6) {
			return "a few seconds from now";
		}
		
		if (diffSec < 60) {
			return "" + diffSec + " seconds from now";
		}
		
		if (diffSec < 180) {
			final long remSec = diffSec - 60;
			return "a minute and " + diffSec + " second"
					+ (remSec > 1 ? "s" : "") + " from now";
		}
		
		if (diffSec < (60 * 90)) {
			return "" + (int) (diffSec / 60) + " minutes from now";
		}
		
		if (diffSec < (60 * 60 * 36)) {
			final long hours = diffSec / (60 * 60);
			final long minutes = ( (diffSec % (60 * 60)) / (60 * 15)) * 15;
			return hours + " hours and " + minutes
					+ " minutes from now";
		}
		
		final int days = (int) (diffSec / (60 * 60 * 24));
		if (days > 600) {
			return String
					.format ("%s years from now",
							LibMisc.cardinalNumber_English ((int) (days / 365.2489)));
		} else if (days > 31) {
			return String.format ("%s weeks from now",
					LibMisc.cardinalNumber_English (days / 7));
		}
		return String.format ("%s days from now",
				LibMisc.cardinalNumber_English (days));
		
	}
	
	/**
	 * Create an user-visible string using metric figures accurate to 1
	 * decimal place, expressing an amount of memory in KiB, MiB, &c.
	 * to one decimal place. For example, “12.1 KiB” or “4.2 GiB”.
	 * 
	 * @param numBytes a number of bytes (size_t)
	 * @return a human-legible string
	 */
	public static String formatMemory (final long numBytes) {
		if (numBytes > (1024L * 1024 * 1024 * 10240)) {
			return String.format (
					"%.1f TiB",
					Double.valueOf ((double) numBytes
							/ (1024L * 1024 * 1024 * 1024)));
		}
		if (numBytes > (1024 * 1024 * 1024)) {
			return String.format (
					"%.1f GiB",
					Double.valueOf ((double) numBytes
							/ (1024 * 1024 * 1024)));
		}
		if (numBytes > (1024 * 10240)) {
			return String.format (
					"%.1f MiB",
					Double.valueOf ((double) numBytes
							/ (1024 * 1024)));
		}
		if (numBytes > 10240) {
			return String.format ("%.1f KiB",
					Double.valueOf (numBytes / 1024.0));
		}
		return String.format ("%f bytes", Double.valueOf (numBytes));
	}
	
	/**
	 * See {@link #formatFutureDate(Date, String, String)}; applies the
	 * currently-selected default language of the thread context
	 * 
	 * @param pastDate the date to be thus described
	 * @return a string describing the past date in general terms
	 */
	public static String formatPastDate (final Date pastDate) {
		final Thread currentThread = Thread.currentThread ();
		if (currentThread instanceof HasLanguage) {
			return LibMisc.formatPastDate (pastDate,
					((HasLanguage) currentThread).getLanguage (),
					((HasLanguage) currentThread).getDialect ());
		}
		return LibMisc.formatPastDate (pastDate, "en", "US");
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 18,
	 * 2010)
	 * 
	 * @param targetDate a date in the future
	 * @param language the user's language
	 * @param dialect the user's dialect
	 * @return a human-legible expression describing the time in the
	 *         future
	 */
	public static String formatPastDate (final Date targetDate,
			final String language, final String dialect) {
		return LibMisc.formatPastDate_English (targetDate);
	}
	
	/**
	 * @param targetDate a date in the future
	 * @return a human-legible expression describing the time in the
	 *         future
	 */
	private static String formatPastDate_English (final Date targetDate) {
		final Date now = new Date ();
		if (targetDate.compareTo (now) > 0) {
			return "the future";
		}
		if (targetDate.compareTo (now) == 0) {
			return "right now";
		}
		
		final long diffSec = (now.getTime () - targetDate.getTime ()) / 1000;
		
		if (diffSec <= 0) {
			return "just now";
		}
		
		if (diffSec == 1) {
			return "a second ago";
		}
		
		if (diffSec < 6) {
			return "a few seconds ago";
		}
		
		if (diffSec < 60) {
			return String
					.format ("%s seconds ago",
							LibMisc.cardinalNumber_English ((int) diffSec));
		}
		
		if (diffSec < 120) {
			final long remSec = diffSec - 60;
			if (2 > remSec) {
				return String.format ("a minute ago");
			}
			return String
					.format ("a minute and %s seconds ago",
							LibMisc.cardinalNumber_English ((int) diffSec));
		}
		
		if (diffSec < (60 * 90)) {
			return String
					.format ("%s minutes ago",
							LibMisc.cardinalNumber_English ((int) (diffSec / 60)));
		}
		
		if (diffSec < (60 * 60 * 36)) {
			final long hours = diffSec / (60 * 60);
			return String.format ("%s hours ago",
					LibMisc.cardinalNumber_English ((int) hours));
		}
		
		final int days = (int) (diffSec / (60 * 60 * 24));
		if (days > 600) {
			return String
					.format ("%s years ago",
							LibMisc.cardinalNumber_English ((int) (days / 365.2489)));
		} else if (days > 31) {
			return String.format ("%s weeks ago",
					LibMisc.cardinalNumber_English (days / 7));
		}
		return String.format ("%s days ago",
				LibMisc.cardinalNumber_English (days));
	}
	
	/**
	 * Generate something that resembles an IP address, but is clearly
	 * not a valid host address. Nonetheless, this address will contain
	 * valid byte values. Some byte in the address will be a 255 or the
	 * address will begin or end with a zero byte. Since this method
	 * uses the object's hash code, it will be consistent for an
	 * object.
	 * 
	 * @param o The object for which to generate a fake IP address
	 * @return a string in dotted-quad form
	 */
	public static String genFakeIP (final Object o) {
		final long hash = o.hashCode ();
		final byte eh = (byte) ( (hash & 0xff000000) >> 030);
		final byte el = (byte) ( (hash & 0x00ff0000) >> 020);
		final byte ah = (byte) ( (hash & 0x0000ff00) >> 010);
		final byte al = (byte) ( (hash & 0x000000ff) >> 000);
		if ( ( -128 == eh) || (0x00 == eh) || ( -128 == el)
				|| (0x00 == el) || ( -128 == ah) || (0x00 == ah)
				|| ( -128 == al) || (0x00 == al)) {
			return String.valueOf (eh) + "." + el + "." + ah + "."
					+ al;
		}
		final byte crunch = (byte) (eh ^ el ^ ah ^ al);
		final byte chn = (byte) ( (crunch & 0xf0) >> 4);
		final byte chl = (byte) (crunch & 0x0f);
		final byte choose = (byte) ( (chn ^ chl) & 0x03);
		final boolean toggle = (byte) ( (chn ^ chl) & 0x08) == 1;
		if (toggle) {
			switch (choose) {
			case 0:
				return "255." + el + "." + ah + "." + al;
			case 1:
				return String.valueOf (eh) + ".255." + ah + "."
						+ al;
			case 2:
				return String.valueOf (eh) + "." + el + ".255."
						+ al;
			case 3:
				return String.valueOf (eh) + "." + el + "." + ah
						+ ".255";
			default:
				throw new Error ("Math stopped working.");
			}
		}
		{
			switch (choose) {
			case 0:
			case 2:
				return "0." + el + "." + ah + "." + al;
			case 1:
			case 3:
				return String.valueOf (eh) + "." + el + "." + ah
						+ ".0";
			default:
				throw new Error ("Math stopped working.");
			}
		}
	}
	
	/**
	 * @param string WRITEME
	 * @return WRITEME
	 */
	public static String getText (final String string) {
		return LibMisc.getText (string, "en_US");
	}
	
	/**
	 * WRITEME brpocock@star-hope.org Jul 21, 2010
	 * 
	 * @param string WRITEME
	 * @param language_dialect WRITEME
	 * @return WRITEME
	 */
	public static String getText (final String string,
			final String language_dialect) {
		if ( (null == LibMisc.messages)
				|| (null == LibMisc.messages.get (language_dialect))) {
			LibMisc.initMessages ();
		}
		return LibMisc.messages.get (language_dialect).getProperty (
				string, "(MESSAGE: " + string + ")");
	}
	
	/**
	 * @param string WRITEME
	 * @param language WRITEME
	 * @param dialect WRITEME
	 * @return WRITEME
	 */
	public static String getText (final String string,
			final String language, final String dialect) {
		return LibMisc.getText (string, language + "_" + dialect);
	}
	
	/**
	 * Look for a string key in the message catalogue. If a given key
	 * does exist, return that message. If not, fall back to the
	 * provided default text.
	 * 
	 * @param key The key name which should exist in the message
	 *             catalogue.
	 * @param fallback The fallback text to be used if that message
	 *             does not exist.
	 * @return Either the message from the catalogue, or the fallback
	 *         message if one is unavailable.
	 */
	public static String getTextOrDefault (final String key,
			final String fallback) {
		if (LibMisc.hasText (key)) {
			return LibMisc.getText (key);
		}
		return fallback;
	}
	
	/**
	 * Get a text message item from the catalogue, or use a supplied
	 * default if none is found.
	 * 
	 * @param key The key to locating the correct message text
	 * @param language The language of the translation to be used
	 * @param dialect The specific dialect to be used
	 * @param fallback An expression to be returned if the specified
	 *             key is not found in the message catalogue
	 * @return The given text in the provided language and dialect; or,
	 *         failing that, the supplied fallback expression
	 */
	public static String getTextOrDefault (final String key,
			final String language, final String dialect,
			final String fallback) {
		if (LibMisc.hasText (key, language, dialect)) {
			return LibMisc.getText (key, language, dialect);
		}
		return fallback;
	}
	
	/**
	 * Determine whether the local default language message catalogue
	 * contains a message. FIXME: currently hard-coded to en_US.
	 * 
	 * @param key The message text key to be checked
	 * @return True, if a translation of that message exists in the
	 *         catalogue
	 */
	public static boolean hasText (final String key) {
		if (null == LibMisc.messages) {
			LibMisc.initMessages ();
		}
		if ( (null == LibMisc.messages)
				|| (null == LibMisc.messages.get ("en_US"))) {
			LibMisc.initMessages ();
		}
		return LibMisc.messages.get ("en_US").getProperty (key) != null;
	}
	
	/**
	 * Determine whether a translation for a given message key exists
	 * in the catalogue for a certain language/dialect.
	 * 
	 * @param key The message text key
	 * @param language The language
	 * @param dialect The specific dialect
	 * @return True, if a translation exists
	 */
	public static boolean hasText (final String key,
			final String language, final String dialect) {
		if ( ! (language.equals ("en") && dialect.equals ("US"))) {
			return false;
		}
		if (null == LibMisc.messages) {
			LibMisc.initMessages ();
		}
		return LibMisc.messages.get (key) != null;
	}
	
	/**
	 * Convert an array of bytes into a string of ASCII hexadecimal
	 * nybbles.
	 * 
	 * @param input The bytes to be converted to hex
	 * @return the hex equivalent
	 */
	public static String hexify (final byte [] input) {
		final StringBuilder sha1hex = new StringBuilder (
				input.length * 2);
		for (final byte element : input) {
			sha1hex.append (Integer.toString (
					(element & 0xff) + 0x100, 16).substring (1));
		}
		return sha1hex.toString ();
	}
	
	/**
	 * <p>
	 * Initialise the configured message catalogues.
	 * </p>
	 * <p>
	 * Each message catalogue is loaded based upon the key named
	 * org.starhope.messages.LANG_DIALECT, and must be enumerated in
	 * the “master” list of org.starhope.messages.
	 * </p>
	 * <p>
	 * In the absence of either key, the default message language set
	 * is simply en_US (US English), and the default message catalogues
	 * are /etc/appius/messages/$LANG_DIALECT.properties, e.g.
	 * /etc/appius/messages/en_US.properties
	 * </p>
	 */
	private static void initMessages () {
		FileReader filer = null;
		final String [] languages = AppiusConfig.getConfigOrDefault (
				"org.starhope.messages", "en_US").split (":");
		for (final String lang : languages) {
			try {
				final Properties catalog = new Properties ();
				filer = new FileReader (
						AppiusConfig
								.getConfigOrDefault (
										"org.starhope.messages."
												+ lang,
										"/etc/appius/messages/"
												+ lang
												+ ".properties"));
				catalog.load (filer);
				LibMisc.messages.put (lang, catalog);
			} catch (final FileNotFoundException e) {
				throw BugReporter.getReporter ("srv").fatalBug (e);
			} catch (final IOException e) {
				throw BugReporter.getReporter ("srv").fatalBug (e);
			} finally {
				try {
					if (null != filer) {
						filer.close ();
					}
				} catch (final IOException e) {
					BugReporter.getReporter ("srv").reportBug (e);
				}
			}
		}
	}
	
	/**
	 * Limit a value to being between the minimum and maximum allowed
	 * 
	 * @param value the value
	 * @param min the least permitted value
	 * @param max the max permitted value
	 * @return the value, clipped to the range
	 */
	public static double limit (final double value, final double min,
			final double max) {
		return value < min ? min : value > max ? max : value;
	}
	
	/**
	 * Convert a list of items into an appropriately-worded phrase in
	 * the specified language. The English equivalent would be, for
	 * example: “One, two, three, and four.”
	 * 
	 * @param words The list of words or sub-phrases (Objects with
	 *             toString methods) to be enumerated
	 * @param language The major language
	 * @param dialect The specific dialect
	 * @return A natural-language phrase enumerating the list
	 */
	public static String listToDisplay (
			final Collection <? extends Object> words,
			final String language, final String dialect) {
		final List <String> wordList = new LinkedList <String> ();
		for (final Object o : words) {
			wordList.add (o.toString ());
		}
		return LibMisc.listToDisplay (wordList, language, dialect);
	}
	
	/**
	 * <p>
	 * Given a list of strings, combine then into a string for display
	 * purposes.
	 * </p>
	 * <p>
	 * For English, the list will obey the traditional grammatical
	 * usage of commas: List elements are joined with commas, except
	 * that the conjunction (in our case, always “and”) occurs
	 * penultimate, and two or three element lists do not use commas.
	 * </p>
	 * <p>
	 * For Spanish, works essentially the same way.
	 * </p>
	 * <p>
	 * For other languages, we just join the words with commas and omit
	 * the conjunction
	 * </p>
	 * 
	 * @param words A list of words.
	 * @param language The user's display language
	 * @param dialect The user's sublanguage dialect
	 * @return The list formatted into a string.
	 */
	public static String listToDisplay (final List <String> words,
			final String language, final String dialect) {
		if (words.size () == 1) {
			return words.get (0);
		}
		if (language.equals ("en")) {
			return LibMisc.listToDisplay_English (words);
		} else if (language.equals ("es")) {
			return LibMisc.listToDisplay_Español (words);
		} else if (language.equals ("pf")) {
			return LibMisc.listToDisplay_فرسئ (words);
		}
		final StringBuilder result = new StringBuilder ();
		for (int i = 0; i < words.size (); ++i) {
			result.append (words.get (i));
			if (i < words.size ()) {
				result.append (", ");
			}
		}
		return result.toString ();
		
	}
	
	/**
	 * @see #listToDisplay(Collection, String, String)
	 * @param set array of phrases
	 * @param language major language
	 * @param dialect minor dialect
	 * @return the phrase as described by
	 *         {@link #listToDisplay(Collection, String, String)}
	 */
	public static String listToDisplay (final Object [] set,
			final String language, final String dialect) {
		final LinkedList <String> stuff = new LinkedList <String> ();
		for (final Object o : set) {
			stuff.add (o.toString ());
		}
		return LibMisc.listToDisplay (stuff, language, dialect);
	}
	
	/**
	 * Internal helper method for
	 * {@link #listToDisplay(List, String, String)} for English.
	 * 
	 * @param words word list
	 * @return list formatted for display in English
	 */
	private static String listToDisplay_English (
			final List <String> words) {
		if (words.size () == 2) {
			final StringBuilder result = new StringBuilder ();
			result.append (words.get (0));
			result.append (" and ");
			result.append (words.get (1));
			return result.toString ();
		}
		if (words.size () == 3) {
			final StringBuilder result = new StringBuilder ();
			result.append (words.get (0));
			result.append (", ");
			result.append (words.get (1));
			result.append (" and ");
			result.append (words.get (2));
			return result.toString ();
		}
		final StringBuilder result = new StringBuilder ();
		for (int i = 0; i < words.size (); ++i) {
			result.append (words.get (i));
			if (i < (words.size () - 1)) {
				result.append (", ");
			}
			if (i == (words.size () - 2)) {
				result.append ("and ");
			}
		}
		return result.toString ();
	}
	
	/**
	 * Internal helper method for
	 * {@link #listToDisplay(List, String, String)} for Spanish.
	 * 
	 * @param words word list
	 * @return list formatted for display in Spanish
	 */
	private static String listToDisplay_Español (
			final List <String> words) {
		if (words.size () == 2) {
			return words.get (0) + " y " + words.get (1);
		}
		if (words.size () == 3) {
			return words.get (0) + ", " + words.get (1) + " y "
					+ words.get (2);
		}
		final StringBuilder result = new StringBuilder ();
		for (int i = 0; i < words.size (); ++i) {
			result.append (words.get (i));
			if (i < (words.size () - 1)) {
				result.append (", ");
			}
			if (i == (words.size () - 2)) {
				result.append ("y ");
			}
		}
		return result.toString ();
	}
	
	/**
	 * Internal helper method for
	 * {@link #listToDisplay(List, String, String)} for Persian.
	 * 
	 * @param words word list
	 * @return list formatted for display in Persian
	 */
	private static String listToDisplay_فرسئ (final List <String> words) {
		if (words.size () == 2) {
			return words.get (0) + " وا" + words.get (1);
		}
		if (words.size () == 3) {
			return words.get (0) + " وا " + words.get (1) + " وا "
					+ words.get (2);
		}
		final StringBuilder result = new StringBuilder ();
		for (int i = 0; i < words.size (); ++i) {
			result.append (words.get (i));
			if (i < (words.size () - 1)) {
				result.append ("، ");
			}
			if (i == (words.size () - 2)) {
				result.append (" وا ");
			}
		}
		return result.toString ();
	}
	
	/**
	 * Find a substitute class for a command interpreter class with
	 * local extensions. These are defined by specifying the canonical
	 * class name in the configuration as a parameter to a key of the
	 * form "xtn." plus the canonical class name of the main class to
	 * which the extension applies.
	 * 
	 * @param klass The class for which an extension might exist
	 * @return An extension class, if one exists; else, the same class
	 *         as passed-in
	 */
	public static Class <?> loadExtension (final Class <?> klass) {
		synchronized (LibMisc.extensionClasses) {
			Class <?> extension = LibMisc.extensionClasses
					.get (klass);
			if (null != extension) {
				return extension;
			}
			try {
				extension = Class.forName (AppiusConfig
						.getConfig ("xtn."
								+ klass.getCanonicalName ()));
			} catch (final ClassNotFoundException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a ClassNotFoundException in loadExtension",
								e);
				return klass;
			} catch (final NotFoundException e) {
				/*
				 * Not having an extension class is not per se an
				 * error
				 */
				return klass;
			}
			LibMisc.extensionClasses.put (klass, extension);
			return extension;
		}
	}
	
	/**
	 * Generate a hashcode using the SHA-1 algorithm. This produces a
	 * hash integer by taking the input string, generating its SHA-1
	 * hash, and then adding together the output bytes from that
	 * algorithm, alternate bytes being bitwise-exclusive-OR:ed with
	 * 0xaa, ignoring all overflow.
	 * 
	 * @param string The source string
	 * @return An integral hash value
	 */
	public static int makeHashCode (final String string) {
		byte [] sha1digest;
		try {
			final MessageDigest stomach = MessageDigest
					.getInstance ("SHA1");
			stomach.reset ();
			try {
				stomach.update (string.getBytes ("US-ASCII"));
			} catch (final UnsupportedEncodingException e) {
				BugReporter.getReporter ("srv").reportBug (
						"can't go 16 bit", e);
			}
			sha1digest = stomach.digest ();
		} catch (final NoSuchAlgorithmException e) {
			throw BugReporter.getReporter ("srv").fatalBug (
					"Can't understand how to do SHA1 digests");
		} catch (final NumberFormatException e) {
			throw BugReporter
					.getReporter ("srv")
					.fatalBug (
							new Exception (
									"Can't do some magic to make the SHA1 digest for hashing a user"));
		}
		int hash = 0;
		for (final byte n : sha1digest) {
			if ( (hash & 1) == 1) {
				hash += n ^ 0xaa;
			} else {
				hash = (hash << 1) + n;
			}
		}
		return hash;
		
	}
	
	/**
	 * Shuffle the contents of a map into an ordered map with
	 * pseudorandom key ordering. Uses
	 * {@link Collections#shuffle(List, Random)} with a new
	 * {@link Random} object created using seed values in turn obtained
	 * from {@link AppiusConfig#getRandomInt(int, int)}, which should
	 * provide a relatively high entropy source.
	 * 
	 * @param <K> key type
	 * @param <V> value type
	 * @param map the map to shuffle
	 * @return Map with key ordering shuffled as an ordered
	 *         {@link LinkedHashMap}
	 */
	public static <K, V> LinkedHashMap <K, V> randomize (
			final Map <K, V> map) {
		final List <K> keys = new ArrayList <K> ();
		keys.addAll (map.keySet ());
		Collections.shuffle (
				keys,
				new Random (AppiusConfig.getRandomInt (100000,
						Integer.MAX_VALUE)));
		final LinkedHashMap <K, V> shuffled = new LinkedHashMap <K, V> ();
		for (final K key : keys) {
			final V value = map.get (key);
			shuffled.put (key, value);
		}
		return shuffled;
	}
	
	/**
	 * Perform rot-13 on basic alphabetic characters in the font
	 * 
	 * @param msg The string to be rot-13:ed
	 * @return The string after rot-13
	 */
	public static String rot13 (final String msg) {
		final StringBuilder out = new StringBuilder ();
		
		final char [] chars = new char [msg.length ()];
		msg.getChars (0, msg.length (), chars, 0);
		
		for (final char ch : chars) {
			if ( ( (ch >= 'a') && (ch <= 'm'))
					|| ( (ch >= 'A') && (ch <= 'M'))) {
				out.append ((char) (ch + 13));
			} else if ( ( (ch >= 'n') && (ch <= 'z'))
					|| ( (ch >= 'N') && (ch <= 'Z'))) {
				out.append ((char) (ch - 13));
			} else {
				out.append (ch);
			}
		}
		return out.toString ();
	}
	
	/**
	 * <p>
	 * Given the contents of a map (presumably, of some kind of ordered
	 * map), perform a fairly sketchy randomization upon it which
	 * should be “good enough” for casual (e.g. non-security-related)
	 * purposes.
	 * </p>
	 * 
	 * @param <K> key type of the input and output maps
	 * @param <V> value type of the input and output maps
	 * @param stuffToRandomize the data to be scrambled
	 * @return the scrambled data
	 */
	public static <K extends Object, V extends Object> Map <K, V> scramble (
			final Map <K, V> stuffToRandomize) {
		final Map <K, V> randomizedMap = new HashMap <K, V> ();
		while ( !stuffToRandomize.isEmpty ()) {
			for (final Entry <K, V> thing : stuffToRandomize
					.entrySet ()) {
				if (AppiusConfig.getRandomBool ()
						&& AppiusConfig.getRandomBool ()) {
					randomizedMap.put (thing.getKey (),
							thing.getValue ());
					stuffToRandomize.remove (thing.getKey ());
				}
			}
		}
		return stuffToRandomize;
	}
	
	/**
	 * Send a bug report on something that occurred while attempting to
	 * process a JSON-based command
	 * 
	 * @param cmd a JSON command verb
	 * @param jso JSON data describing the bug
	 * @param commandThread the thread executing the command (which
	 *             <em>might not</em> be the current thread)
	 * @param user the user responsible for executing the command
	 * @param e an exception thrown while processing the ocmmand
	 */
	static void sendJSONCommandBugReport (final String cmd,
			final JSONObject jso,
			final CanProcessCommands commandThread,
			final AbstractUser user, final Exception e) {
		final StringBuilder report = new StringBuilder ();
		if (null != user) {
			report.append ("user: “");
			report.append (user.getAvatarLabel ());
			report.append ("” #");
			report.append (user.getUserID ());
		}
		if ( (null != user) && ( -1 != user.getRoomNumber ())) {
			report.append (" room “");
			report.append (user.getRoom ().getMoniker ());
			report.append ("” #");
			report.append (user.getRoomNumber ());
			report.append (" in zone “");
			if (user.getZone () != null) {
				report.append (user.getZone ().getName ());
				report.append ("” ");
			}
		}
		report.append ('\n');
		report.append (jso.toString ());
		report.append ('\n');
		report.append ('\n');
		report.append (LibMisc.stringify (e.getCause ()));
		AppiusClaudiusCaecus.bugDuplex (
				"Exception while handling JSON command " + cmd,
				report.toString ());
		commandThread.sendError_RAW (cmd, e.getCause ().getClass ()
				.getCanonicalName ());
	}
	
	/**
	 * Set the maximum number of times to clear the socket input
	 * buffer.
	 * 
	 * @param mst maximum number of tries to shut down a socket input
	 *             buffer
	 */
	public static void setMaxShutdownTries (final int mst) {
		LibMisc.MAX_SHUTDOWN_TRIES = mst;
	}
	
	/**
	 * <p>
	 * This method taken from Apache Tomcat:
	 * </p>
	 * <p>
	 * Licensed to the Apache Software Foundation (ASF) under one or
	 * more contributor license agreements. See the NOTICE file
	 * distributed with this work for additional information regarding
	 * copyright ownership. The ASF licenses this file to You under the
	 * Apache License, Version 2.0 (the "License"); you may not use
	 * this file except in compliance with the License. You may obtain
	 * a copy of the License at
	 * </p>
	 * <p>
	 * http://www.apache.org/licenses/LICENSE-2.0
	 * </p>
	 * <p>
	 * Unless required by applicable law or agreed to in writing,
	 * software distributed under the License is distributed on an
	 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
	 * either express or implied. See the License for the specific
	 * language governing permissions and limitations under the
	 * License.
	 * </p>
	 * <p>
	 * Shut down the input stream of a connection
	 * </p>
	 * 
	 * @param socket The socket whose input stream is to be shut down
	 * @throws IOException If the input stream cannot be shut down
	 *              despite best efforts
	 * @deprecated just use {@link Socket#shutdownInput()} now
	 */
	@Deprecated
	public static void shutdownInput (final Socket socket)
			throws IOException {
		socket.shutdownInput ();
	}
	
	/**
	 * Sort the contents of a hash map based upon comparing the values
	 * of its keys. This implementation operates on any types providing
	 * Comparable.
	 * 
	 * @param <K> key type
	 * @param <V> value type
	 * @param stuffToSort The hash table to be sorted
	 * @return the stuff all sorted
	 */
	public static <K extends Comparable <? super K>, V extends Comparable <? super V>> LinkedHashMap <K, V> sortHashMapByValues (
			final Map <K, V> stuffToSort) {
		final List <K> mapKeys = new ArrayList <K> (
				stuffToSort.keySet ());
		final List <V> mapValues = new ArrayList <V> (
				stuffToSort.values ());
		Collections.sort (mapValues);
		Collections.sort (mapKeys);
		
		final LinkedHashMap <K, V> sortedMap = new LinkedHashMap <K, V> ();
		
		final Iterator <V> valueIt = mapValues.iterator ();
		while (valueIt.hasNext ()) {
			final V val = valueIt.next ();
			final Iterator <K> keyIt = mapKeys.iterator ();
			
			while (keyIt.hasNext ()) {
				final K key = keyIt.next ();
				final String comp1 = stuffToSort.get (key)
						.toString ();
				final String comp2 = val.toString ();
				
				if (comp1.equals (comp2)) {
					stuffToSort.remove (key);
					mapKeys.remove (key);
					sortedMap.put (key, val);
					break;
				}
				
			}
			
		}
		return sortedMap;
	}
	
	/**
	 * Convert a map into a string, mostly for debugging purposes.
	 * 
	 * @param map a map object to be stringified
	 * @return a string containing all keys and values in the map
	 */
	public static String stringify (
			final Map <? extends Object, ? extends Object> map) {
		final StringBuilder b = new StringBuilder ();
		for (final Entry <? extends Object, ? extends Object> tuple : map
				.entrySet ()) {
			b.append ("“");
			b.append (tuple.getKey ());
			b.append ("”:\t“");
			b.append (tuple.getValue ());
			b.append ("”\n");
		}
		return b.toString ();
	}
	
	/**
	 * @param crap arbitrary stuff to stringify
	 * @return a somewhat legible stringification of the set
	 */
	public static String stringify (final Object... crap) {
		if (null == crap) {
			return "";
		}
		if (0 == crap.length) {
			return "";
		}
		final StringBuilder s = new StringBuilder ();
		for (final Object o : crap) {
			if (null == o) {
				s.append ("null");
				continue;
			}
			s.append ('(');
			s.append (o.getClass ().getSimpleName ());
			s.append ("=“");
			s.append (o.toString ());
			s.append ("”)");
		}
		return s.toString ();
	}
	
	/**
	 * Dump an SQL ResultSet as a string table
	 * 
	 * @param rs result set to dump
	 * @return tabular form
	 */
	public static String stringify (final ResultSet rs) {
		try {
			final int where = rs.getRow ();
			rs.beforeFirst ();
			final StringBuilder s = new StringBuilder ();
			final ResultSetMetaData meta = rs.getMetaData ();
			final int numCols = meta.getColumnCount ();
			if (numCols < 8) {
				LibMisc.stringify_tabular (rs, s, meta, numCols);
			} else {
				LibMisc.stringify_form (rs, s, meta, numCols);
			}
			rs.absolute (where);
			return s.toString ();
		} catch (final SQLException e) {
			throw new RuntimeException (e);
		}
	}
	
	/**
	 * Create a pure string version of a stack backtrace
	 * 
	 * @param stackTrace An array of StackTraceElements:s
	 * @return A string version of the entire stack backtrace
	 */
	public static String stringify (
			final StackTraceElement [] stackTrace) {
		final StringBuilder s = new StringBuilder ();
		for (final StackTraceElement el : stackTrace) {
			s.append ('\t');
			s.append (el.toString ());
			s.append (el.isNativeMethod () ? "(native)" : "");
			s.append ('\n');
		}
		return s.toString ();
	}
	
	/**
	 * @param e A Throwable to be stringified into a backtrace
	 * @return The string form
	 */
	public static String stringify (final Throwable e) {
		final StringBuilder s = new StringBuilder ();
		s.append (e.toString () + " " + e.getMessage ());
		s.append ('\n');
		s.append (LibMisc.stringify (e.getStackTrace ()));
		return s.toString ();
	}
	
	/**
	 * convert an SQL column from a result set into a String
	 * 
	 * @param rs the result set from an SQL query
	 * @param s a StringBuilder into which the stringified column value
	 *             will be appended
	 * @param meta metadata describing the result set
	 * @param i the integral column number
	 * @throws SQLException if the result set can't be interpreted for
	 *              some reason
	 */
	private static void stringify_column (final ResultSet rs,
			final StringBuilder s, final ResultSetMetaData meta,
			final int i) throws SQLException {
		final int type = meta.getColumnType (i);
		switch (type) {
		case Types.VARCHAR:
			s.append (rs.getString (i));
			break;
		case Types.INTEGER:
			s.append (rs.getInt (i));
			break;
		case Types.DECIMAL:
			s.append (rs.getBigDecimal (i));
			break;
		default:
			s.append (String.format ("$(%08x)",
					Integer.valueOf (type)));
		}
	}
	
	/**
	 * stringify output formatting from an SQL result set into a
	 * key:value format; the column values will be interpreted by
	 * {@link #stringify_column(ResultSet, StringBuilder, ResultSetMetaData, int)}
	 * 
	 * @param rs an SQL result set
	 * @param s a StringBuilder into which the output will be appended
	 * @param meta the metadata describing the result set
	 * @param numCols the number of columns to be written out
	 * @throws SQLException if the data cannot be formatted
	 */
	private static void stringify_form (final ResultSet rs,
			final StringBuilder s, final ResultSetMetaData meta,
			final int numCols) throws SQLException {
		while (rs.next ()) {
			for (int i = 1; i <= numCols; ++i) {
				s.append (meta.getColumnLabel (i));
				s.append (":\t");
				LibMisc.stringify_column (rs, s, meta, i);
				s.append ("\n");
			}
			s.append ("\n\n");
		}
	}
	
	/**
	 * stringify SQL data in tabular format, in traditional Unix
	 * tab-delimited columns, newline-delimited records, format.
	 * 
	 * @param rs result set from an SQL query
	 * @param s a StringBuilder into which the formatted output will be
	 *             appended
	 * @param meta metadata describing the result set
	 * @param numCols the number of columns to be written out
	 * @throws SQLException if the data can't be interpreted
	 */
	private static void stringify_tabular (final ResultSet rs,
			final StringBuilder s, final ResultSetMetaData meta,
			final int numCols) throws SQLException {
		for (int i = 1; i <= numCols; ++i) {
			s.append ("\t");
			s.append (meta.getColumnLabel (i));
		}
		s.append ("\n");
		while (rs.next ()) {
			s.append (rs.getRow ());
			for (int i = 1; i <= numCols; ++i) {
				s.append ("\t");
				LibMisc.stringify_column (rs, s, meta, i);
			}
			s.append ("\n");
		}
	}
	
	/**
	 * Joins an array of strings together using the given delimiter
	 * 
	 * @param array The array of strings
	 * @param delimiter The string to append between the other strings
	 * @return A new string with the strings all appended together
	 */
	public static String stringJoin (final String [] array,
			final String delimiter) {
		final StringBuilder s = new StringBuilder ();
		
		if (array.length < 0) {
			return "";
		}
		
		s.append (array [0]);
		for (int i = 1; i < array.length; i++ ) {
			s.append (delimiter);
			s.append (array [i]);
		}
		
		return s.toString ();
	}
	
	/**
	 * <p>
	 * Determine the object's current position, and the time until it
	 * reaches its target (from now). Note that this was the preferred
	 * routine to be used to update the position of an object. Now, use
	 * #updateUserPositioning(AbstractUser,long)
	 * </p>
	 * <p>
	 * When called through this interface, always executes side-effects
	 * </p>
	 * <p>
	 * Identical to
	 * {@link Geometry#updateUserPositioning(AbstractUser, long, boolean)}
	 * with the last parameter as “true.”
	 * </p>
	 * 
	 * @param thing what is moving
	 * @param when what time is it now
	 * @return how long until it gets there
	 * @deprecated use
	 *             {@link Geometry#updateUserPositioning(AbstractUser, long, boolean)}
	 * @see Geometry#getTimeToTarget(AbstractUser, long)
	 * @see Geometry#updateUserPositioning(AbstractUser)
	 * @see Geometry#updateUserPositioning(AbstractUser, long)
	 * @see Geometry#updateUserPositioning(AbstractUser, long, boolean)
	 */
	@Deprecated
	public static long timeToTarget (final AbstractUser thing,
			final long when) {
		return Geometry.updateUserPositioning (thing, when, true);
	}
	
	/**
	 * convert a user-visible string into a javaCased moniker; takes
	 * out all non-alpha chars and uses them as upper-case indicators
	 * 
	 * @param source the string provided
	 * @return the string converted into javaCased (CamelCase with
	 *         initial miniscule letter)
	 */
	public static String toJavaCase (final String source) {
		if (source.length () == 0) {
			return "";
		}
		final String working = source.toLowerCase (Locale.ENGLISH);
		final StringBuilder dest = new StringBuilder ();
		boolean toUpper = false;
		char c = working.charAt (0);
		for (int i = 0; i < working.length (); ++i) {
			c = working.charAt (i);
			if ( (c >= 'a') && (c <= 'z')) {
				if (toUpper) {
					dest.append (Character.toUpperCase (c));
				} else {
					dest.append (c);
				}
			} else if ( (c >= '0') && (c <= '9')) {
				dest.append (c);
			} else {
				toUpper = true;
			}
		}
		return dest.toString ();
		
	}
	
	/**
	 * Convert a collection of objects into a JSON array-like set.
	 * 
	 * @param <T> Generic
	 * @param collection the collection of objects to be encoded
	 * @param onlyString if true, do not use the
	 *             {@link CastsToJSON#toJSON()} method, if it's found,
	 *             but always use {@link Object#toString()}. If false,
	 *             JSONObject:s and CastsToJSON objects will be passed
	 *             through in that form.
	 * @return a new JSON object with elements numbered ascending from
	 *         0
	 */
	public static <T extends Object> JSONObject toJSON (
			final Collection <T> collection, final boolean onlyString) {
		final Iterator <T> i = collection.iterator ();
		int c = 0;
		final JSONObject jso = new JSONObject ();
		while (i.hasNext ()) {
			final Object o = i.next ();
			try {
				if (null == o) {
					jso.put (String.valueOf (c++ ), null);
					continue;
				}
				if ( !onlyString) {
					if (o instanceof CastsToJSON) {
						jso.put (String.valueOf (c++ ),
								((CastsToJSON) o).toJSON ());
						continue;
					} else if (o instanceof JSONObject) {
						jso.put (String.valueOf (c++ ), o);
						continue;
					}
				}
				jso.put (String.valueOf (c++ ), o.toString ());
			} catch (final JSONException e) {
				BugReporter.getReporter ("srv").reportBug (e);
			}
		}
		return jso;
	}
	
	/**
	 * <p>
	 * Replace all series of one or more whitespace characters
	 * (including carriage returns, newlines, and horizontal or
	 * vertical tabulations) with a single space, and trims off the
	 * leading and trailing whitespace.
	 * </p>
	 * <p>
	 * Note that this performs more or less the same whitespace
	 * compression as is typically defined behaviour for HTML display.
	 * </p>
	 * 
	 * @param string A string to be trimmed.
	 * @return the trimmed string
	 */
	public static String trimWhiteSpace (final String string) {
		System.out.println ("Before: “" + string + "”");
		final String trimmedString = string.replaceAll ("\\s+", " ")
				.trim ();
		System.out.println ("After: “" + trimmedString + "”");
		return trimmedString;
	}
	
}
