/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.game;

import java.util.Calendar;
import java.util.ConcurrentModificationException;
import java.util.HashSet;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.messaging.Mail;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 */
public class BugReporter {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final static Map <String, BugReporter> reporters = new ConcurrentHashMap <String, BugReporter> ();

	/**
	 * Get a bug reporter instance for a certain type of bugs.
	 * Generally-expected strings include:
	 * <dl>
	 * <dt>srv</dt>
	 * <dd>Server-related bugs: problems inside of Appius Claudius
	 * Caecus or its local processes</dd>
	 * <dt>net</dt>
	 * <dd>Network-outage-type bugs, like DNS failures, that should go
	 * to a systems operator</dd>
	 * <dt>client</dt>
	 * <dd>Bugs reported by an accessing client application. XXX: allow
	 * clients to report their identification so that this can be split
	 * up</dd>
	 * <dt>design</dt>
	 * <dd>Bugs found in design-related data, such as bad strings in
	 * room variables, missing exit spaces</dd>
	 * </dl>
	 *
	 * @param purpose what kind of bugs are we reporting? see above.
	 * @return a bug reporter for those bugs
	 */
	public static BugReporter getReporter (final String purpose) {

		if (BugReporter.reporters.containsKey (purpose)) {
			return BugReporter.reporters.get (purpose);
		}
		try {
			return new BugReporter (purpose);
		} catch (Exception e) {
			try {
				return new BugReporter ("default");
			} catch (NotFoundException e1) {
				System.err
						.println ("\n\n\n *** BUG REPORTING IS NOT AVAILABLE: Missing configuration \n\n\n\07");
				System.err.flush ();
				return null; // unreachable, but makes compiler happy.
			} catch (AddressException e1) {
				System.err
						.println ("\n\n\n *** BUG REPORTING IS NOT AVAILABLE: Bad eMail address for “from” or “to” \n\n\n\07");
				System.err.flush ();
				return null; // unreachable, but makes compiler happy.
			}
		}
	}

	/**
	 * <p>
	 * This extracts a stack backtrace from a Throwable into a string
	 * format for a bug report. Each line is tagged with a leading "/#"
	 * string, followed by a space, the stack backtrace element, and a
	 * newline.
	 * </p>
	 * <p>
	 * This is the same as calling
	 * {@link BugReporter#getStackTrace(Throwable, String)} with a
	 * prefix of "\n/#"
	 * </p>
	 *
	 * @param throwable The Throwable containing stack backtrace data
	 * @return A string representation of the backtrace, suitable for
	 *         logging or bug reports.
	 */
	static String getStackTrace (final Throwable throwable) {
		return BugReporter.getStackTrace (throwable, "\n/# ") + "\n";
	}

	/**
	 * This extracts a stack backtrace from a Throwable into a string
	 * format for a bug report. Each line is preceded by the supplied
	 * prefix string, followed the stack backtrace element. The string
	 * does not end with a newline.
	 *
	 * @param throwable A {@link Throwable} from which to extract a
	 *            stack trace
	 * @param prefix The string with which to separate lines of the
	 *            trace.
	 * @return The stacktrace as a string
	 */
	static String getStackTrace (final Throwable throwable,
			final String prefix) {
		int watchdog = 0;
		final StringBuilder stackTrace = new StringBuilder ();
		if (null == throwable) {
			return "";
		}
		for (final StackTraceElement element : throwable
				.getStackTrace ()) {
			stackTrace.append (prefix);
			stackTrace.append (element.toString ());
			if (80 < ++watchdog) {
				stackTrace.append (prefix);
				stackTrace
						.append ("... and many more (limiter invoked)");
				return stackTrace.toString ();
			}
		}
		return stackTrace.toString ();
	}

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private Address mailTo;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String subjectTagline;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String bugPrelude;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final String confPrefix;
	/**
	 * when were bugs eMailed? Don't blow up my mailbox
	 */
	private static Set <Long> bugsMailed = new HashSet <Long> ();

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private Address mailFrom;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final String purpose;

	/**
	 * Whether to include a stack backtrace in the bug report.
	 */
	private boolean includeStackTrace = true;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 * @param newPurpose WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws AddressException if the addresses given for “from” or
	 *             “to” fail to parse
	 */
	private BugReporter (final String newPurpose)
			throws NotFoundException, AddressException {
		purpose = newPurpose;
		BugReporter old = BugReporter.reporters.put (purpose, this);
		if (null != old) {
			BugReporter.reporters.put (purpose, old);
			throw new ConcurrentModificationException (purpose
					+ " exists");
		}
		confPrefix = "org.starhope.appius.bugReport." + purpose + '.';
		setMailTo (AppiusConfig.getConfigOrDefault (confPrefix
				+ "mailTo", Nomenclator.getUserByID (2).getMail ()));
		setMailFrom (AppiusConfig
				.getConfigOrDefault (confPrefix + "mailFrom",
						AppiusConfig.getMailSender ().toString ()));
		setSubjectTagline (AppiusConfig.getConfigOrDefault (confPrefix
				+ "subject", "Appius Claudius Caecus"));
		setIncludeStackTrace (AppiusConfig
				.getConfigBoolOrTrue (confPrefix + "includeStackTrace"));
		setBugPrelude (AppiusConfig.getConfigOrDefault (confPrefix
				+ ".prelude",
				"Bug report caught by Appius Claudius Caecus"));
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param subject WRITEME
	 * @param message WRITEME
	 */
	public void bugDuplex (final String subject, final String message) {
		if (AppiusConfig.mailBugs ()) {
			if ( !tooManyBugsMailed ()) {
				AppiusConfig.setMailBugs (false);
				sendBugReport (subject, message);
				AppiusConfig.setMailBugs (true);
				BugReporter.bugsMailed.add (Long.valueOf (System
						.currentTimeMillis ()));
			}
		}
		// AbstractWebLocation abstractWebLocation = new
		// AbstractWebLocation
		// ("http://goethe.tootsville.com/trac.cgi";
		// Version version = xxx;
		// TracClientFactory.createClient(abstractWebLocation, version)

		//
		//
		// try { Mail.sendTemplateMail (Nomenclator.getByLogin
		// ("Catvlle"),
		// true, "bugReport", "Bug Report from Appius", null, reason +
		// "\n\n" + e.toString ()); } catch (final FileNotFoundException
		// e1) { System.err .println
		// ("Can't write bug report to mail: Template bugReport is missing"
		// ); } catch (final IOException e1) { System.err .println
		// ("Can't write bug report to mail: I/O Exception"); } catch
		// (final NotFoundException e1) { System.err .println
		// ("Can't write bug report to mail: User not found"); }

		System.err.println (message);
		System.err.flush ();
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param e WRITEME
	 * @return WRITEME
	 */
	public Error fatalBug (final Exception e) {
		reportBug (e);
		throw new Error (e);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param string WRITEME
	 * @param t WRITEME
	 * @return WRITEME
	 */
	public Error fatalBug (final String string, final Throwable t) {
		reportBug (string, t);
		throw new Error (t);
	}

	/**
	 * @return the bugPrelude
	 */
	public String getBugPrelude () {
		return bugPrelude;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return WRITEME
	 */
	public Address getMailFrom () {
		return mailFrom;
	}

	/**
	 * @return the mailTo
	 */
	public Address getMailTo () {
		return mailTo;
	}

	/**
	 * @return the purpose for which this BugReporter instance was
	 *         created. Typically “srv,” “net,” or “client”
	 */
	private String getPurpose () {
		return purpose;
	}

	/**
	 * @return the subjectTagline
	 */
	public String getSubjectTagline () {
		return subjectTagline;
	}

	/**
	 * @return the includeStackTrace
	 */
	public boolean includeStackTrace () {
		return includeStackTrace;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param e WRITEME
	 */
	public void reportBug (final Exception e) {
		reportBug (e.getLocalizedMessage (), e);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param message WRITEME
	 */
	public void reportBug (final String message) {
		final Throwable t = new Throwable ();
		try {
			throw t;
		} catch (final Throwable blah) {
			this.reportBug (message, blah);
		}
	}

	/**
	 * <p>
	 * WRITEME: Document this method brpocock@star-hope.org
	 * </p>
	 *
	 * @param string WRITEME
	 * @param b ignored
	 */
	public void reportBug (final String string, final boolean b) {
		bugDuplex (string, string);
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param reason the message content
	 * @param thread the thread throwing the exception
	 */
	public void reportBug (final String reason, final Thread thread) {
		StringBuilder bugReport = new StringBuilder ();
		bugReport
				.append ("/* Bug report auto-generated by software.\n/= Reason: ");
		bugReport.append (reason);
		bugReport.append ("\n\n Thread reporting bug:");
		bugReport.append ( (null == thread ? "" : thread.toString ()));
		bugReport.append ("\n/> End automated bug report");
		bugDuplex (getBugPrelude (), bugReport.toString ());
	}

	/**
	 * Report a bug to the automatic bug-tracking systems. This is an
	 * exception which "should never" be thrown, being caught and
	 * referred back for programmer intervention.
	 *
	 * @param reason The reason this is a bug, if known.
	 * @param throwable The "impossible" exception.
	 */
	public void reportBug (final String reason,
			final Throwable throwable) {

		final String stackTrace = includeStackTrace ? BugReporter
				.getStackTrace (throwable) : " (no) ";

		final StringBuilder bugReport = new StringBuilder ();
		bugReport
				.append ("/* <*>BUG<*>\n\n// Bug report, auto-generated by software.\n/= Reason: ");
		bugReport.append (reason);
		bugReport.append ("\n/= Exception class: ");
		bugReport.append (throwable.getClass ().getCanonicalName ());
		bugReport.append ("\n/= Exception message: ");
		bugReport.append (throwable.getMessage ());
		bugReport.append ("\n/= Exception localized message: ");
		bugReport.append (throwable.getLocalizedMessage ());
		bugReport.append ("\n/= Thread: ");
		bugReport.append (Thread.currentThread ().getName ());
		bugReport.append ("\n/= Stack Backtrace:");
		bugReport.append (stackTrace);
		Throwable cause = throwable.getCause ();
		int depth = 1;
		while (null != cause) {
			final StringBuilder prefix = new StringBuilder ("\n/");
			for (int i = 0; i < depth; ++i) {
				prefix.append ('/');
			}
			bugReport.append (prefix);
			bugReport.append (" Exception depth: ");
			bugReport.append (depth);
			bugReport.append (prefix);
			bugReport
					.append (" Exception was caused by another exception");
			bugReport.append (prefix);
			bugReport.append ("= Caused by exception class: ");
			bugReport.append (cause.getClass ().getCanonicalName ());
			bugReport.append (prefix);
			bugReport.append ("= Caused by exception message: ");
			bugReport.append (cause.getMessage ());
			bugReport.append (prefix);
			bugReport.append ("= Caused by localized message: ");
			bugReport.append (cause.getLocalizedMessage ());
			bugReport.append (prefix);
			bugReport.append ("= Caused by stack backtrace:");
			bugReport.append (BugReporter.getStackTrace (cause, prefix
					+ "# "));
			cause = cause.getCause ();
			++depth;
		}
		bugReport.append ("\n/= Timestamp Now: "
				+ "\n/= Human Timestamp: ");
		bugReport.append (AppiusClaudiusCaecus.isoDate.format (Calendar
				.getInstance ().getTime ()));
		bugReport.append ("\n/> End automated bug report");
		AppiusClaudiusCaecus.bugDuplex (
				reason + " — " + subjectTagline, bugReport.toString ());

	}

	/**
	 * Send a bug report via eMail. Must be toggled on in the
	 * configuration. Do not call this method directly: just report the
	 * bug via Appius Claudius Caecus, and (if configured to do so) it
	 * will relay the message through this method.
	 *
	 * @param subject The subject of the mail message
	 * @param message The stack trace and associated details involved.
	 */
	private void sendBugReport (final String subject,
			final String message) {
		final Properties props = new Properties ();
		props.put ("mail.smtp.host", AppiusConfig.getSMTPHost ());
		final Session session = Session.getInstance (props, null);

		final MimeMessage msg = new MimeMessage (session);

		if (null == mailFrom || null == mailTo) {
			System.err
					.println (" [×] Can't send mail: sender or recipient is null.");
			return;
		}

		String messagePlusTrailer = message
				+ "\n\n (× END OF MESSAGE ×) \n « Romance Game System » \n\n-- \nThis is an automatically generated report from the Romance Game System.\nYour eMail address is configured to receive messages for this videogame when they have a reason code of “"
				+ purpose + ";” if this is an error, please contact "
				+ mailFrom + " to be removed.";

		try {
			msg.setFrom (mailFrom);
			msg.setRecipient (Message.RecipientType.TO, mailTo);
			if (subject.length () < 72) {
				msg.setSubject (subject);
			} else {
				msg.setSubject (subject.substring (0, 70) + "…");
			}
			msg.setSentDate (new java.util.Date ());
			msg.setText (messagePlusTrailer);
			msg.setHeader ("X-Generator", BugReporter.class
					.getCanonicalName ()
					+ "/" + Mail.class.getCanonicalName ());
			Transport.send (msg);
			System.err.println (" [×] Bug report being sent to: "
					+ mailTo);
			System.err.flush ();
		} catch (final MessagingException e) {
			if ("net".equals (getPurpose ())) {
				System.err.println ("Mail cannot be sent.");
				e.printStackTrace (System.err);
				System.err.flush ();
				return;
			}
			StringBuilder report = new StringBuilder ();
			report
					.append ("Unable to send the following message because of an exception in sending the eMail.\n\nMessage:\n\nSubject: ");
			report.append (subject);
			report.append ("\nFrom: ");
			report.append (getMailFrom ().toString ());
			report.append ("\nTo: ");
			report.append (getMailTo ().toString ());
			report.append ("\n----------\n\n");
			report.append (message);
			report.append ("\n(END OF TEXT.)\n");
			BugReporter.getReporter ("net").reportBug (
					report.toString (), e);
		}
	}

	/**
	 * @param newPrelude the bugPrelude to set
	 */
	public void setBugPrelude (final String newPrelude) {
		bugPrelude = newPrelude;
	}

	/**
	 * @param nowIncludeStackTrace the includeStackTrace to set
	 */
	public void setIncludeStackTrace (final boolean nowIncludeStackTrace) {
		includeStackTrace = nowIncludeStackTrace;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param newMailFrom WRITEME
	 * @throws AddressException WRITEME
	 */
	public void setMailFrom (final String newMailFrom)
			throws AddressException {
		mailFrom = new InternetAddress (newMailFrom);
	}

	/**
	 * @param newMail the mailTo to set
	 * @throws AddressException WRITEME
	 */
	public void setMailTo (final String newMail)
			throws AddressException {
		mailTo = new InternetAddress (newMail);
	}

	/**
	 * @param newTagline the subjectTagline to set
	 */
	public void setSubjectTagline (final String newTagline) {
		subjectTagline = newTagline;
	}

	/**
	 * @return true, if I'm getting my mailbox blown up
	 */
	private boolean tooManyBugsMailed () {
		int fiveMinutes = 0;
		int hour = 0;
		long now = System.currentTimeMillis ();
		for (Long when : AppiusClaudiusCaecus.bugsMailed) {
			if (when.longValue () > now - 5 * 60 * 1000) {
				++fiveMinutes;
			}
			if (when.longValue () > now - 60 * 60 * 1000) {
				++hour;
			}
		}
		if (fiveMinutes > AppiusConfig.getIntOrDefault (
				"org.starhope.appius.mailBugs.fiveMinutes", 10)
				|| hour > AppiusConfig.getIntOrDefault (
						"org.starhope.appius.mailBugs.hour", 50)) {
			return true;
		}
		return false;
	}
}
