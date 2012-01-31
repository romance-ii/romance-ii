/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.appius.user.events;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLDataException;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.Set;
import java.util.TimerTask;
import java.util.WeakHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ConcurrentSkipListSet;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Room;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Quaestor extends TimerTask {
	
	/**
	 * collection of all action handlers in the system
	 */
	static Collection <ActionHandlerInterface> actionHandlers = new ConcurrentSkipListSet <ActionHandlerInterface> ();
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static Quaestor defaultQuaestor;
	/**
	 * The local Quaestor instance, in case it's needed
	 */
	private static final Quaestor localQuaestor = new Quaestor ();
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param subject WRITEME
	 * @param verb WRITEME
	 * @deprecated use {@link #action(Action)}
	 */
	@Deprecated
	public static void action (final AbstractUser subject,
			final String verb) {
		Quaestor.dispatchAction (null, subject, verb, null, null);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param subject WRITEME
	 * @param verb WRITEME
	 * @param object WRITEME
	 * @deprecated use {@link #action(Action)}
	 */
	@Deprecated
	public static void action (final AbstractUser subject,
			final String verb, final AbstractUser object) {
		Quaestor.dispatchAction (null, subject, verb, object, null);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param user WRITEME
	 * @param verb WRITEME
	 * @param string WRITEME
	 * @deprecated use {@link #action(Action)}
	 */
	@Deprecated
	public static void action (final AbstractUser user,
			final String verb, final String string) {
		Quaestor.dispatchAction (null, user, verb, null, string,
				(Object []) null);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param where WRITEME
	 * @param subject WRITEME
	 * @param verb WRITEME
	 * @deprecated use {@link #action(Action)}
	 */
	@Deprecated
	public static void action (final Room where,
			final AbstractUser subject, final String verb) {
		Quaestor.dispatchAction (where, subject, verb, null, null);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param where WRITEME
	 * @param subject WRITEME
	 * @param verb WRITEME
	 * @param object WRITEME
	 * @deprecated use {@link #action(Action)}
	 */
	@Deprecated
	public static void action (final Room where,
			final AbstractUser subject, final String verb,
			final AbstractUser object) {
		Quaestor.dispatchAction (where, subject, verb, object, null);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param where WRITEME
	 * @param subject WRITEME
	 * @param verb WRITEME
	 * @param object WRITEME
	 * @param indirectObject WRITEME
	 * @param trailer WRITEME
	 * @deprecated use {@link #action(Action)}
	 */
	@Deprecated
	public static void action (final Room where,
			final AbstractUser subject, final String verb,
			final AbstractUser object, final String indirectObject,
			final Object... trailer) {
		Quaestor.dispatchAction (where, subject, verb, object,
				indirectObject, trailer);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param room WRITEME
	 * @param user WRITEME
	 * @param verb WRITEME
	 * @param indirectObject WRITEME
	 * @deprecated use {@link #action(Action)}
	 */
	@Deprecated
	public static void action (final Room room,
			final AbstractUser user, final String verb,
			final String indirectObject) {
		Quaestor.dispatchAction (room, user, verb, null,
				indirectObject, (Object []) null);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param where WRITEME
	 * @param verb WRITEME
	 * @param object WRITEME
	 * @deprecated use {@link #action(Action)}
	 */
	@Deprecated
	public static void action (final Room where, final String verb,
			final AbstractUser object) {
		Quaestor.dispatchAction (where, null, verb, object, null);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param verb WRITEME
	 * @deprecated use {@link #action(Action)}
	 */
	@Deprecated
	public static void action (final String verb) {
		Quaestor.dispatchAction (null, null, verb, null, null);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param verb WRITEME
	 * @param object WRITEME
	 * @deprecated use {@link #action(Action)}
	 */
	@Deprecated
	public static void action (final String verb,
			final AbstractUser object) {
		Quaestor.dispatchAction (null, null, verb, object, null);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param verb WRITEME
	 * @param indirectObject WRITEME
	 * @deprecated use {@link #action(Action)}
	 */
	@Deprecated
	public static void action (final String verb,
			final String indirectObject) {
		Quaestor.dispatchAction (null, null, verb, null,
				indirectObject);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param where WRITEME
	 * @param subject WRITEME WRITEME
	 * @param verb WRITEME
	 * @param object WRITEME
	 * @param indirectObject WRITEME
	 * @param trailer WRITEME
	 */
	private static void dispatchAction (final Room where,
			final AbstractUser subject, final String verb,
			final AbstractUser object, final String indirectObject,
			final Object... trailer) {
		Quaestor.getDefault ().action (
				new Action (where, subject, verb, object,
						indirectObject, trailer));
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME: Document this method brpocock@star-hope.org
	 */
	public static Quaestor getDefault () {
		if (null == Quaestor.defaultQuaestor) {
			Quaestor.defaultQuaestor = Quaestor.localQuaestor;
		}
		return Quaestor.defaultQuaestor;
	}
	
	/**
	 * Gets a count of all ended events of a specific event type for a
	 * given user
	 * 
	 * @param user User
	 * @param moniker Event Type
	 * @return Number of Occurrences
	 */
	public static int getEndedEventCount (final AbstractUser user,
			final String moniker) {
		int result = 0;
		PreparedStatement st = null;
		Connection con = null;
		int eventTypeID = 0;
		try {
			eventTypeID = EventType.getIDForMoniker (moniker);
		} catch (final NotFoundException e) {
			return result;
		}
		
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT COUNT(*) FROM events WHERE eventTypeID = ? AND creatorID = ? and completionTimestamp IS NOT NULL");
			st.setInt (1, eventTypeID);
			st.setInt (2, user.getUserID ());
			final ResultSet rs = st.executeQuery ();
			if (rs.next ()) {
				result = rs.getInt (1);
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught an Exception in getEndedEventCount",
							e);
		} finally {
			LibMisc.closeAll (st, con);
		}
		
		return result;
	}
	
	/**
	 * @param eventID the ID of the event to be loaded
	 * @return the event record
	 * @throws NotFoundException if the event record does not exist
	 */
	public static EventRecord getEventByID (final int eventID)
			throws NotFoundException {
		return Nomenclator.getDataRecord (EventRecord.class, eventID);
	}
	
	/**
	 * Gets a count of a all occurrences of a specific event for a
	 * specified user regardless of finished status
	 * 
	 * @param user User
	 * @param moniker Event Type
	 * @return Number of Occurrences
	 */
	public static int getEventCount (final AbstractUser user,
			final String moniker) {
		int result = 0;
		PreparedStatement st = null;
		Connection con = null;
		int eventTypeID = 0;
		try {
			eventTypeID = EventType.getIDForMoniker (moniker);
		} catch (final NotFoundException e) {
			return result;
		}
		
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT COUNT(*) FROM events WHERE eventTypeID = ? AND creatorID = ?");
			st.setInt (1, eventTypeID);
			st.setInt (2, user.getUserID ());
			final ResultSet rs = st.executeQuery ();
			if (rs.next ()) {
				result = rs.getInt (1);
			}
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").reportBug (
					"Caught an Exception in getEventCount", e);
		} finally {
			LibMisc.closeAll (st, con);
		}
		
		return result;
	}
	
	/**
	 * Get an event type, given its ID. Just calls
	 * {@link Nomenclator#getDataRecord(Class, int)} with
	 * EventType.class, these days.
	 * 
	 * @param eventTypeID id number
	 * @return EventType object
	 * @throws NotFoundException if not found
	 */
	public static EventType getEventTypeByID (final int eventTypeID)
			throws NotFoundException {
		return Nomenclator.getDataRecord (EventType.class,
				eventTypeID);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param moniker WRITEME
	 * @return WRITEME
	 * @throws NotFoundException not found
	 */
	private static EventType getEventTypeForMoniker (
			final String moniker) throws NotFoundException {
		return Nomenclator.getDataRecord (EventType.class, moniker);
	}
	
	/**
	 * Gets a count of a all occurrences of a specific event for a
	 * specified user that adds an item
	 * 
	 * @param user User
	 * @param moniker Event Type
	 * @param itemID Item ID
	 * @return Number of Occurrences
	 */
	public static int getItemGainedEventCount (
			final AbstractUser user, final String moniker,
			final int itemID) {
		int result = 0;
		PreparedStatement st = null;
		Connection con = null;
		int eventTypeID = 0;
		try {
			eventTypeID = EventType.getIDForMoniker (moniker);
		} catch (final NotFoundException e) {
			return result;
		}
		
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT COUNT(*) FROM events WHERE eventTypeID = ? AND creatorID = ? AND itemGained = ?");
			st.setInt (1, eventTypeID);
			st.setInt (2, user.getUserID ());
			st.setInt (3, itemID);
			final ResultSet rs = st.executeQuery ();
			if (rs.next ()) {
				result = rs.getInt (1);
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught an Exception in getItemGainedEventCount",
							e);
		} finally {
			LibMisc.closeAll (st, con);
		}
		
		return result;
	}
	
	/**
	 * Get the local Quaestor, even if a network one is available
	 * 
	 * @return the local Quaestor
	 */
	public static Quaestor getLocal () {
		return Quaestor.localQuaestor;
	}
	
	/**
	 * Gets a list of all events of the given type that were started
	 * but not yet ended
	 * 
	 * @param moniker Event Type moniker
	 * @param user User
	 * @return A list of event IDs
	 */
	public static List <Integer> getStartedEventsByType (
			final AbstractUser user, final String moniker) {
		final List <Integer> result = new LinkedList <Integer> ();
		PreparedStatement st = null;
		Connection con = null;
		int eventTypeID = 0;
		try {
			eventTypeID = EventType.getIDForMoniker (moniker);
		} catch (final NotFoundException e) {
			return result;
		}
		
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT ID FROM events WHERE eventTypeID = ? AND creatorID = ? AND completionTimestamp IS NULL");
			st.setInt (1, eventTypeID);
			st.setInt (2, user.getUserID ());
			final ResultSet rs = st.executeQuery ();
			while (rs.next ()) {
				final int i = rs.getInt (1);
				if (i != 0) {
					result.add (Integer.valueOf (i));
				}
			}
		} catch (final SQLException e) {
			BugReporter.getReporter ("srv").reportBug (
					"Caught an Exception in getHighScores", e);
		} finally {
			LibMisc.closeAll (st, con);
		}
		
		return result;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param handler WRITEME
	 */
	public static void ignore (final ActionHandlerInterface handler) {
		Quaestor.actionHandlers.remove (handler);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param handler WRITEME
	 */
	public static void listen (final ActionHandlerInterface handler) {
		System.out.println (" Quaestor.listen | "
				+ handler.toString ());
		Quaestor.actionHandlers.add (handler);
	}
	
	/**
	 * Set the local quaestor as the default one to be used, normally
	 * flagging the death of a network Quaestor for some reason
	 */
	public static void setDefaultToLocal () {
		Quaestor.defaultQuaestor = Quaestor.localQuaestor;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param user user starting (creating) the event
	 * @param moniker WRITEME
	 * @return WRITEME
	 * @throws AlreadyExistsException if the event can't be started
	 *              again
	 * @throws NotFoundException if the type isn't found
	 */
	public static EventRecord startEvent (final AbstractUser user,
			final String moniker) throws AlreadyExistsException,
			NotFoundException {
		return Quaestor.getEventTypeForMoniker (moniker).startEvent (
				user);
	}
	
	/**
	 * Start an event and return the JSON object for the client with
	 * event details
	 * 
	 * @param user the user starting the event
	 * @param moniker the event moniker
	 * @return the JSON data structure containing WRITEME
	 */
	public static JSONObject startEvent_JSON (final AbstractUser user,
			final String moniker) {
		final JSONObject result = new JSONObject ();
		EventRecord ev;
		try {
			ev = Quaestor.startEvent (user, moniker);
		} catch (final AlreadyExistsException e) {
			try {
				result.put ("alreadyDone", true);
			} catch (final JSONException e1) {
				BugReporter.getReporter ("srv").reportBug (
						"Caught a JSONException in Quaestor.startEvent_JSON("
								+ moniker + ")", e1);
			}
			return result;
		} catch (final NotFoundException e) {
			try {
				result.put ("err", "eventType.notFound");
			} catch (final JSONException e1) {
				BugReporter.getReporter ("srv").reportBug (
						"Caught a JSONException in Quaestor.startEvent_JSON("
								+ moniker + ")", e1);
			}
			return result;
		}
		try {
			result.put ("eventID", ev.getID ());
			final EventType eventType = ev.getEventType ();
			result.put ("moniker", eventType.getMoniker ());
			result.put ("filename", eventType.getFilename ());
			// TODO: Remove this
			result.put ("asVersion", eventType.getEngine ()); // XXX
			result.put ("engine", eventType.getEngine ());
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug (
					"Caught a JSONException in Quaestor.startEvent_JSON("
							+ moniker + ")", e);
		}
		return result;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param user WRITEME
	 * @param moniker WRITEME
	 * @return WRITEME
	 * @throws AlreadyExistsException if the user can't perform this
	 *              event because of event limits in place on it
	 */
	public static int startEventRaw (final AbstractUser user,
			final String moniker) throws AlreadyExistsException {
		int eventID = -1;
		PreparedStatement createEvent = null;
		ResultSet newEventInfo = null;
		Connection con = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			createEvent = con
					.prepareStatement (
							"INSERT INTO events (creatorID, creationTimestamp, eventTypeID) SELECT ?, NOW(), ID FROM eventTypes WHERE name = ?",
							Statement.RETURN_GENERATED_KEYS);
			createEvent.setInt (1, user.getUserID ());
			createEvent.setString (2, moniker);
			
			if (createEvent.executeUpdate () == 0) {
				throw AppiusClaudiusCaecus
						.fatalBug ("Event not started: creatorID="
								+ user.getUserID ()
								+ "; moniker=" + moniker);
			}
			
			newEventInfo = createEvent.getGeneratedKeys ();
			if (newEventInfo.next ()) {
				try {
					eventID = newEventInfo.getInt (1);
				} catch (final SQLException e1) {
					throw AppiusClaudiusCaecus
							.fatalBug (new SQLDataException (
									"Can't retrieve auto-incremented key from “INSERT INTO events”"));
				} finally {
					newEventInfo.close ();
				}
			}
		} catch (final SQLException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		} finally {
			LibMisc.closeAll (newEventInfo, createEvent, con);
		}
		
		return eventID;
	}
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final Queue <Action> actionQueue = new ConcurrentLinkedQueue <Action> ();
	
	/**
	 * weak listeners stuff
	 */
	private final WeakHashMap <AbstractUser, Set <ActionHandlerInterface>> weakListeners = new WeakHashMap <AbstractUser, Set <ActionHandlerInterface>> ();
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	private Quaestor () {
		// …
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param action WRITEME
	 */
	public void action (final Action action) {
		if (AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.jdbc.useTomcat")) {
			final String via = AppiusConfig
					.getConfigOrNull ("org.starhope.appius.useViaLoader");
			if ( (null == via) || "".equals (via)) {
				return;
			}
		}
		actionQueue.add (action);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param action WRITEME
	 * @return true, if any handler were found.
	 */
	private boolean dispatchAction (final Action action) {
		action.log ();
		boolean found = false;
		final QuaestorRunner runner = new QuaestorRunner (action);
		for (final ActionHandlerInterface handler : Quaestor.actionHandlers) {
			if (handler.matches (action)) {
				runner.add (handler);
				found = true;
			}
		}
		if (found) {
			runner.start ();
		}
		return found;
	}
	
	/**
	 * @see java.util.TimerTask#run()
	 */
	@Override
	public void run () {
		final Iterator <Action> i = actionQueue.iterator ();
		while (i.hasNext ()) {
			final Action action = i.next ();
			i.remove ();
			dispatchAction (action);
		}
	}
	
	/**
	 * Set the default Quaestor to be used when {@link #getDefault()}
	 * is called. Most routines will use this one.
	 */
	public void setDefault () {
		Quaestor.defaultQuaestor = this;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param action WRITEME
	 * @throws NotFoundException if no handler accepts the action
	 */
	public void tryAction (final Action action)
			throws NotFoundException {
		if (AppiusConfig
				.getConfigBoolOrFalse ("org.starhope.appius.jdbc.useTomcat")) {
			final String via = AppiusConfig
					.getConfigOrNull ("org.starhope.appius.useViaLoader");
			if ( (null == via) || "".equals (via)) {
				return;
			}
		}
		if ( !dispatchAction (action)) {
			throw new NotFoundException (action.toString ());
		}
	}
	
	/**
	 * Listen for an event, weakly, forgetting about it if the user
	 * logs out.
	 * 
	 * @param u the user to weakly listen for an event
	 * @param actionHandler the handler to use
	 */
	public void weakListen (final AbstractUser u,
			final ActionHandlerInterface actionHandler) {
		synchronized (weakListeners) {
			Set <ActionHandlerInterface> set = weakListeners.get (u);
			if (null == set) {
				set = new ConcurrentSkipListSet <ActionHandlerInterface> ();
			}
			set.add (actionHandler);
		}
	}
}
