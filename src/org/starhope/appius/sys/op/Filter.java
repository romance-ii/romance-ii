/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
 * </p>
 * <p>
 * Based upon public domain sample code provided by Authorize.net
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

package org.starhope.appius.sys.op;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.JSONObject;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.messaging.AbstractCensor;
import org.starhope.appius.sql.SQLPeerDatum;
import org.starhope.appius.types.FilterType;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * <p>
 * This class represents (and actually provides the services of) a
 * filter capable of identifying offensive content in text, and flagging
 * it.
 * </p>
 * <p>
 * The actual implementation of the filter itself can be altered as
 * necessary to catch more malevolent attempts to bypass the filtration
 * system, as needed.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author Bruce-Robert Pocock <BRPocock@Star-Hope.org>
 */
public class Filter extends SQLPeerDatum implements AbstractCensor {
	
	/**
	 * This class is basically just a structure to group together some
	 * data pertaining to a filtered pattern.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	static private class FilterPattern {
		/**
		 * The default action to undertake if this pattern is matched
		 */
		public FilterAction defaultAction;
		/**
		 * The patterns which are exceptions to this rule, and the
		 * actions to undertake if they are encountered
		 */
		public Map <Pattern, FilterAction> exceptions;
		
		/**
		 * Constructor
		 */
		public FilterPattern () {
			defaultAction = FilterAction.ACT_NONE;
			exceptions = new HashMap <Pattern, FilterAction> ();
		}
	}
	
	/**
	 *
	 */
	private static final long serialVersionUID = -3010893618678442775L;
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Aug 24,
	 * 2009)
	 * 
	 * @param theTitle WRITEME
	 * @return WRITEME
	 * @throws NotFoundException WRITEME
	 */
	private static Filter getByTitle (final String theTitle)
			throws NotFoundException {
		PreparedStatement st = null;
		try {
			st = AppiusConfig
					.getDatabaseConnection ()
					.prepareStatement (
							"SELECT id FROM filterNames WHERE title=?");
			st.setString (1, theTitle);
			final ResultSet rs = st.executeQuery ();
			rs.next ();
			return new Filter (rs);
		} catch (final SQLException e) {
			throw new NotFoundException (e.toString ());
		} finally {
			if (null != st) {
				try {
					st.close ();
				} catch (final SQLException e) {
					BugReporter.getReporter ("srv").reportBug (
							"finally", e);
				}
				st = null;
			}
		}
	}
	
	/**
	 * @return The active filter
	 */
	@Deprecated
	public static AbstractCensor getChatFilter () {
		return AppiusConfig.getFilter (FilterType.KID_CHAT);
	}
	
	/**
	 * @return The active filter
	 * @throws NotFoundException
	 */
	public static Filter getLoginFilter () throws NotFoundException {
		return Filter.getByTitle (AppiusConfig.getLoginFilterName ());
	}
	
	/**
	 * <p>
	 * This is an handy little utility which takes a string and
	 * squishes it down, removing all non-letter characters.
	 * </p>
	 * <p>
	 * Exceptions: We map @ => a, and ! => i.
	 * </p>
	 * <p>
	 * Example:
	 * </p>
	 * <p>
	 * ‘Oh,’ she said, ‘you're changing;’ but we're always changing,
	 * and it does not bother me to say, ‘This isn't love,’ because if
	 * you don't want to talk about it then it isn't love, and I guess
	 * I'm gonna have to learn to live without it; but I'm sure there's
	 * something in a shade of grey — something in-between — and I can
	 * always change my name, if that's what you mean.
	 * </p>
	 * <p>
	 * Becomes (with line breaks added for clarity):
	 * </p>
	 * 
	 * <pre>
	 * ohshesaidyourechangingbutwerealwayschanginganditdoesnotbothermeto
	 * saythisisntlovebecauseifyoudontwanttotalkaboutitthenitisntloveand
	 * iguessimgonnahavetolearntolivewithoutitbutimsuretheressomethingin
	 * ashadeofgreysomethinginbetweenandicanalwayschangemynameifthatswha
	 * tyoumean
	 * </pre>
	 * <p>
	 * <small>(lyrics, "Anna Begins," <i>Ten</i>, Pearl Jam, © You Make
	 * Me Sick I Make Music, Inc.)</small>
	 * </p>
	 * 
	 * @param in the string to be squished
	 * @return The squished string.
	 */
	private static String squish (final String in) {
		final StringBuilder s = new StringBuilder ();
		for (final char ch : in.toCharArray ()) {
			if (Character.isLetter (ch)) {
				s.append (Character.toLowerCase (ch));
			} else if (ch == '@') {
				s.append ('a');
			} else if (ch == '!') {
				s.append ('i');
			}
		}
		return s.toString ();
	}
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) id (Filter)
	 */
	private int id;
	
	/**
	 * This binds the patterns to their FilterPattern records
	 */
	private final Map <Pattern, FilterPattern> patterns = new HashMap <Pattern, FilterPattern> ();
	
	/**
	 * This is the (admin-visible, but not end-user-visible) title for
	 * this filter
	 */
	private String title = "untitled";
	
	/**
	 * WRITEME
	 */
	public Filter () {
		super ();
		title = "";
	}
	
	/**
	 * @param rs WRITEME
	 * @throws SQLException WRITEME
	 */
	public Filter (final ResultSet rs) throws SQLException {
		id = rs.getInt ("ID");
		Connection con = null;
		PreparedStatement getPatternIDs = null;
		PreparedStatement getPatterns = null;
		PreparedStatement getExceptions = null;
		ResultSet patternIDs = null;
		ResultSet patternsReceived = null;
		ResultSet exceptions = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			getPatternIDs = con
					.prepareStatement ("SELECT patternID FROM filterSet WHERE filterID=?");
			getPatterns = con
					.prepareStatement ("SELECT * FROM filterPatterns WHERE ID=?");
			getExceptions = con
					.prepareStatement ("SELECT * FROM filterExceptions WHERE patternID=?");
			getPatternIDs.setInt (1, id);
			if (getPatternIDs.execute ()) {
				patternIDs = getPatterns.getResultSet ();
				while (patternIDs.next ()) {
					final int patternID = patternIDs.getInt (1);
					getPatterns.setInt (1, patternID);
					if (getPatterns.execute ()) {
						patternsReceived = getPatterns
								.getResultSet ();
						while (patternsReceived.next ()) {
							final String pat = patternsReceived
									.getString ("pattern");
							addPattern (
									pat,
									patternsReceived
											.getString ("matcher"),
									patternsReceived
											.getString ("action"));
							getExceptions.setInt (1, patternID);
							if (getExceptions.execute ()) {
								exceptions = getExceptions
										.getResultSet ();
								while (exceptions.next ()) {
									addException (
											pat,
											exceptions.getString ("exception"),
											exceptions.getString ("matcher"),
											exceptions.getString ("action"));
								}
							}
						}
					}
				}
			}
		} catch (final SQLException e) {
			throw e;
		} finally {
			LibMisc.closeAll (patternIDs, patternsReceived,
					exceptions, getExceptions, getPatterns,
					getPatternIDs, con);
		}
	}
	
	/**
	 * This adds an exception to a pattern.
	 * 
	 * @param pat The pattern to which the exception is needed
	 * @param exception The pattern which defines an exception to the
	 *             parent pattern
	 * @param action the Action to take if the exception is matched
	 * @throws DataException if the action is not supplied
	 */
	@SuppressWarnings ("deprecation")
	public void addException (final String pat,
			final String exception, final FilterAction action)
			throws DataException {
		if (action == null) {
			throw new DataException ("Action is required");
		}
		final Pattern p = Pattern.compile (pat, Pattern.CANON_EQ);
		final Pattern e = Pattern.compile (exception,
				Pattern.CANON_EQ);
		patterns.get (p).exceptions.put (e, action);
		changed ();
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Aug 25,
	 * 2009)
	 * 
	 * @param pattern WRITEME
	 * @param exception WRITEME
	 * @param matcher WRITEME
	 * @param action WRITEME
	 */
	private void addException (final String pattern,
			final String exception, final String matcher,
			final String action) {
		final FilterPattern pat = patterns.get (Pattern
				.compile (pattern));
		pat.exceptions.put (Pattern.compile (exception),
				FilterAction.valueOf (action));
	}
	
	/**
	 * Adds a new pattern to this filter, with the supplied action
	 * associated.
	 * 
	 * @param pat The pattern which is to be filtered
	 * @param action The action to be taken if the pattern is
	 *             encountered
	 * @throws DataException if the pattern or action are missing or
	 *              invalid
	 */
	public void addPattern (final String pat, final FilterAction action)
			throws DataException {
		if ( (action == null) || (action == FilterAction.ACT_NONE)) {
			throw new DataException ("Valid action is required");
		}
		final Pattern p = Pattern.compile (pat, Pattern.CANON_EQ);
		final FilterPattern newGuy = new FilterPattern ();
		newGuy.defaultAction = action;
		newGuy.exceptions = new HashMap <Pattern, FilterAction> ();
		patterns.put (p, newGuy);
		changed ();
	}
	
	/**
	 * Used for adding patterns from the database's stringy
	 * representations
	 * 
	 * @param pattern The pattern or word
	 * @param matcher "R" for regular expression or "W" for word
	 * @param action "K" for kick, "W" for warn, "X" for none.
	 */
	private void addPattern (final String pattern,
			final String matcher, final String action) {
		// TODO Auto-generated method stub (brpocock@star-hope.org,
		// Aug 25, 2009)
		
	}
	
	/**
	 * @see org.starhope.appius.messaging.AbstractCensor#checkLists(java.lang.String)
	 */
	@Override
	public FilterResult checkLists (final String token) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * This is the actual regular-expression matching test routine.
	 * 
	 * @param text The text to be compared
	 * @param pat The pattern against which to compare it
	 * @return true, if they match
	 */
	private boolean fancyMatch (final String text,
			final java.util.regex.Pattern pat) {
		// XXX: handle things like "ffuucckk" by removing doubled
		// characters in both pattern and text
		
		final Matcher m = pat.matcher (text);
		if (m.find ()) {
			return true;
		}
		return false;
	}
	
	/**
	 * Returns the filter action result of matching the given string.
	 * 
	 * @param actualText The text to be tested
	 * @return The result of the tests
	 */
	public FilterAction filter (final String actualText) {
		String text = actualText;
		for (final Pattern pat : patterns.keySet ()) {
			if (fancyMatch (text, pat)) {
				final FilterPattern p = patterns.get (pat);
				FilterAction act = p.defaultAction;
				for (final Pattern except : p.exceptions.keySet ()) {
					if (fancyMatch (text, except)) {
						act = p.exceptions.get (except);
					}
				}
				if (act != FilterAction.ACT_NONE) {
					return act;
				}
			}
		}
		text = Filter.squish (actualText);
		for (final Pattern pat : patterns.keySet ()) {
			if (fancyMatch (text, pat)) {
				final FilterPattern p = patterns.get (pat);
				FilterAction act = p.defaultAction;
				for (final Pattern except : p.exceptions.keySet ()) {
					if (fancyMatch (text, except)) {
						act = p.exceptions.get (except);
					}
				}
				if (act != FilterAction.ACT_NONE) {
					return act;
				}
			}
		}
		return FilterAction.ACT_NONE;
	}
	
	/**
	 * @see org.starhope.appius.messaging.AbstractCensor#filterMessage(java.lang.String)
	 */
	@Override
	public FilterResult filterMessage (final String text) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerDatum#flush()
	 */
	@Override
	public void flush () {
		// TODO Auto-generated method stub (brpocock@star-hope.org,
		// Aug 24, 2009)
		
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerDatum#getCacheUniqueID()
	 */
	@Override
	protected String getCacheUniqueID () {
		// TODO Auto-generated method stub (brpocock@star-hope.org,
		// Aug 26, 2009)
		return null;
	}
	
	/**
	 * Gets the action associated with a certain exception to a certain
	 * pattern
	 * 
	 * @param pat the pattern whose exception is being queried
	 * @param exception the exception which is being queried
	 * @return the action to be taken if that pattern-exception is
	 *         matched
	 * @throws NotFoundException if the pattern or exception isn't
	 *              found
	 */
	public FilterAction getExceptionAction (final String pat,
			final String exception) throws NotFoundException {
		final FilterPattern p = patterns.get (Pattern.compile (pat,
				Pattern.CANON_EQ));
		if (p == null) {
			throw new NotFoundException ("Pattern not found");
		}
		final FilterAction act = p.exceptions.get (Pattern.compile (
				exception, Pattern.CANON_EQ));
		if (act == null) {
			throw new NotFoundException ("Exception not found");
		}
		return act;
	}
	
	/**
	 * Gets the exception patterns associated with a given "main"
	 * pattern
	 * 
	 * @param pat the pattern to which the exceptions are wanted
	 * @return a (possibly zero-length) vector containing the pattern
	 *         strings of all exceptions to the given pattern
	 * @throws NotFoundException if the pattern is not found
	 */
	public Vector <String> getExceptions (final String pat)
			throws NotFoundException {
		final FilterPattern p = patterns.get (Pattern.compile (pat,
				Pattern.CANON_EQ));
		if (p == null) {
			throw new NotFoundException ("Pattern not found");
		}
		final Vector <String> strings = new Vector <String> ();
		for (final Pattern ex : p.exceptions.keySet ()) {
			strings.add (ex.toString ());
		}
		return strings;
	}
	
	/**
	 * Returns the default action associated with a pattern (ignoring
	 * exceptions)
	 * 
	 * @param pat the pattern to query
	 * @return the default action
	 * @throws NotFoundException if the pattern is not found in this
	 *              Filter
	 */
	public FilterAction getPatternAction (final String pat)
			throws NotFoundException {
		final FilterPattern p = patterns.get (Pattern.compile (pat,
				Pattern.CANON_EQ));
		if (p == null) {
			throw new NotFoundException ("Pattern not found");
		}
		return p.defaultAction;
	}
	
	/**
	 * Return any and all patterns which match a given string. This
	 * does <em>not</em> exclude patterns with exceptions.
	 * 
	 * @param text the string to be tested (filtered)
	 * @return returns which (if any) patterns match the given string
	 */
	public Set <String> getPatternsMatching (final String text) {
		final Set <String> resultSet = new HashSet <String> ();
		for (final Pattern p : patterns.keySet ()) {
			if (fancyMatch (text, p)) {
				resultSet.add (p.toString ());
			}
		}
		return resultSet;
	}
	
	/**
	 * @return the title
	 */
	public String getTitle () {
		return title;
	}
	
	/**
	 * @see org.starhope.appius.messaging.AbstractCensor#getWhiteListLength()
	 */
	@Override
	public int getWhiteListLength () {
		// TODO Auto-generated method stub
		return 0;
	}
	
	/**
	 * Determine whether the given pattern is found in the Filter.
	 * 
	 * @param pat The pattern for which to search
	 * @return true, if the pattern is defined.
	 */
	public boolean hasPattern (final String pat) {
		return patterns.containsKey (Pattern.compile (pat,
				Pattern.CANON_EQ));
		
	}
	
	/**
	 * Note: the definition of "allowed" is that the string results in
	 * no action, either because it does not match any patterns, or
	 * because it matches an exception with an action type of ACT_NONE
	 * 
	 * @param text the string to be tested (filtered)
	 * @return true, if the string is allowed (action of ACT_NONE) by
	 *         this filter.
	 */
	public boolean isAllowed (final String text) {
		return filter (text) == FilterAction.ACT_NONE;
	}
	
	/**
	 * This is the inverse of {@link #isAllowed(String)} (q.v.)
	 * 
	 * @param text the text to be tested (filtered)
	 * @return true, if the string is forbidden (action other than
	 *         ACT_NONE) by this filter
	 */
	public boolean isForbidden (final String text) {
		return filter (text) != FilterAction.ACT_NONE;
	}
	
	/**
	 * @see org.starhope.appius.messaging.AbstractCensor#loadLists(java.sql.Connection)
	 */
	@Override
	public void loadLists (final Connection databaseConnection) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		
	}
	
	/**
	 * @see org.starhope.appius.messaging.AbstractCensor#prime(java.sql.Connection)
	 */
	@Override
	public void prime (final Connection databaseConnection) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		
	}
	
	/**
	 * @see org.starhope.appius.messaging.AbstractCensor#reloadLists(java.sql.Connection)
	 */
	@Override
	public void reloadLists (final Connection databaseConnection) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		
	}
	
	/**
	 * Removes a pattern-exception from a filter.
	 * 
	 * @param pat The regular expression pattern
	 * @param exception The exception to the pattern to be removed
	 * @throws NotFoundException if the exception pattern is not found
	 *              or if the pattern itself is not found.
	 */
	public void removeException (final String pat,
			final String exception) throws NotFoundException {
		final FilterPattern myPattern = patterns.get (Pattern
				.compile (pat, Pattern.CANON_EQ));
		if (myPattern == null) {
			throw new NotFoundException (
					"Pattern not found in filter");
		}
		final Pattern theirException = Pattern.compile (exception,
				Pattern.CANON_EQ);
		for (final Pattern myException : myPattern.exceptions
				.keySet ()) {
			if (myException.equals (theirException)) {
				myPattern.exceptions.remove (myException);
				changed ();
				return;
			}
		}
		throw new NotFoundException ("Exception not found to pattern");
	}
	
	/**
	 * Removes a pattern from a filter.
	 * 
	 * @param pat The regular expression pattern to be removed
	 * @throws NotFoundException if the exception pattern is not found
	 */
	public void removePattern (final String pat)
			throws NotFoundException {
		final Pattern theirs = Pattern
				.compile (pat, Pattern.CANON_EQ);
		for (final Pattern mine : patterns.keySet ()) {
			if (mine.equals (theirs)) {
				patterns.remove (mine);
				changed ();
				return;
			}
		}
		throw new NotFoundException ("Pattern not found in filter");
	}
	
	/**
	 * This object doesn't support JSON (de-)serialisation. This method
	 * is a no-op.
	 * 
	 * @see org.starhope.appius.util.CastsToJSON#set(org.json.JSONObject)
	 */
	@Override
	public void set (final JSONObject o) {
		// No op
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.sql.SQLPeerDatum#set(java.sql.ResultSet)
	 */
	@Override
	protected void set (final ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub (brpocock@star-hope.org,
		// Aug 24, 2009)
		
	}
	
	/**
	 * 20-char limit; visible only to staff
	 * 
	 * @param title1 the title to set
	 * @throws DataException if the title is not 1-20 chars
	 */
	public void setTitle (final String title1) throws DataException {
		if ( (title1 != null) && (title1.length () < 20)
				&& (title1.length () > 1)) {
			
			title = title1;
			changed ();
		} else {
			throw new DataException ("Title must be 1-20 chars");
		}
	}
	
	/**
	 * This routine returns a null JSON object. Filters are not
	 * currently serialized to the client, because we don't want anyone
	 * to be able to find out what we're filtering. This might need to
	 * be revisited, though, for the purposes of moderators.
	 */
	@Override
	public JSONObject toJSON () {
		return new JSONObject ();
	}
	
}
