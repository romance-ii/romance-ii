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
package org.starhope.appius.messaging;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;

import org.starhope.appius.except.DataException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.user.AbstractPerson;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.User;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock, <a href="mailto:twheys@gmail.com">Tim
 *         Heys</a>
 */
public class Mail {
	
	/**
	 * This extracts the mail domain from the address. Note that the
	 * mail domain is not implicitly validated in this routine: it is
	 * only extracted as a string. Note that, unlike "real" mail
	 * systems, this will NOT add an implicit "@tootsville.com" or
	 * similar to the end of a local-part-only address. (Personally, I
	 * think that's a bad idea in this case. ~BRP)
	 * 
	 * @param address An eMail address in RFC-2822 format
	 * @return The domain-part string
	 * @throws DataException if the domain-part can't be found, doesn't
	 *              conform to DNS requirements for a domain string, or
	 *              the address doesn't have an @ sign to declare a
	 *              domain part at all.
	 */
	public static String getDomainPart (final String address)
			throws DataException {
		/*
		 * Split the address, taking the domain name. This follows
		 * RFC-822.
		 */
		final String [] mailParts = address.split ("\\@");
		if (mailParts.length != 2) {
			throw new DataException (
					"eMail address must contain exacly one @ sign");
		}
		
		/*
		 * The domain name is the last part — after the @ sign. Since
		 * we're going to run an MX record search on it, in a minute,
		 * it doesn't matter if we validate it here or not.
		 */
		return mailParts [1];
		
	}
	
	/**
	 * Extracts the local-part specification out of an eMail address,
	 * removing any comment strings, and returns something like what
	 * people naïvely assume is a valid eMail address. This follows the
	 * RFC-2822 requirements for a valid address, instead of imposing
	 * some arbitrary limits upon what we'll accept.
	 * 
	 * @param address An eMail address string
	 * @return The local-part (mailbox or delivery instructions part)
	 *         of the address
	 * @throws DataException if the address does not conform to RFC-822
	 *              requirements
	 */
	public static String getLocalPart (final String address)
			throws DataException {
		/*
		 * Split the address, taking the domain name. This follows
		 * RFC-822.
		 */
		final String [] mailParts = address.split ("\\@");
		if (mailParts.length != 2) {
			throw new DataException (
					"eMail address must contain exacly one @ sign");
		}
		/*
		 * Everything to the left of the final @ sign — and, per
		 * RFC-822, there can be multiples — is the left-hand side of
		 * the eMail address. Let's just make sure it doesn't have any
		 * control bytes in it; other than that, we're fine with
		 * whatever crap people want to inject.
		 */
		final String localPart = mailParts [0];
		
		// if (localPart.length () < 1)
		// throw new DataException (
		// "eMail address must have something left of the @ sign");
		//
		// if ('"' == localPart.charAt (0)) {
		// // Quoted-string checkings
		//
		// } else {
		// // (atom * ) [ '.' atom * ]*
		// /*
		// * <any CHAR except specials, SPACE and CTLs>
		// */
		// }
		
		return localPart;
	}
	
	/**
	 * <p>
	 * Determine whether an eMail address is known to be bad (because
	 * we've received a 5xx series bounce from the MX recently)
	 * </p>
	 * <p>
	 * The definition of “recently” is
	 * (org.starhope.appius.mail.bounceBadDays) days; default of 7.
	 * </p>
	 * <p>
	 * XXX: also monitor sexual offender databases
	 * </p>
	 * 
	 * @param address The eMail address to be checked
	 * @return true, if the eMail address is known to be bad due to a
	 *         bounce
	 */
	private static boolean isBadMail (final String address) {
		return Mail.isBouncedMail (address);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param address WRITEME
	 * @return WRITEME
	 */
	private static boolean isBouncedMail (final String address) {
		java.sql.Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT COUNT(*) FROM bounced_mails WHERE address=? AND bouncedAt > NOW() - INTERVAL ? DAY");
			st.setString (1, address);
			st.setInt (2, AppiusConfig.getIntOrDefault (
					"org.starhope.appius.mail.bounceBadDays", 7));
			if ( !st.execute ()) {
				return false;
			}
			rs = st.getResultSet ();
			if (null == rs) {
				return false;
			}
			if ( !rs.next ()) {
				return true;
			}
			if (0 == rs.getInt (1)) {
				return false;
			}
		} catch (final SQLException e) {
			LibMisc.closeAll (rs, st, con);
			BugReporter.getReporter ("srv").reportBug (
					"Caught a SQLException in isBadMail", e);
		}
		return false;
	}
	
	/**
	 * Determine whether an eMail address might be valid.
	 * 
	 * @param address eMail address string
	 * @return false, if the address is provably invalid. true, if it
	 *         might be valid.
	 */
	public static boolean isValidMail (final String address) {
		try {
			Mail.validateMail (address);
		} catch (final NamingException e) {
			return true;
		} catch (final DataException e) {
			return false;
		}
		return true;
	}
	
	/**
	 * Reads in a template file from the appropriate folder
	 * 
	 * @param templateName the template file
	 * @return the contents of the template file
	 * @throws FileNotFoundException If the template file can't be
	 *              found
	 * @throws IOException If the template file can't be read
	 * @throws NotFoundException If the name of the template file can't
	 *              be found in AppiusConfig
	 */
	public static String readTemplate (final String templateName)
			throws FileNotFoundException, IOException,
			NotFoundException {
		final File file = new File (AppiusConfig.getConfigOrDefault (
				"org.starhope.appius.util.Mail.template_folder",
				"/etc/appius/mail/")
				+ templateName + ".template");
		BufferedInputStream bis = null;
		byte [] bytes;
		try {
			bis = new BufferedInputStream (
					new FileInputStream (file));
			bytes = new byte [(int) file.length ()];
			final int readBytes = bis.read (bytes);
			if (readBytes != file.length ()) {
				// do nothing? XXX? really?
			}
		} catch (final FileNotFoundException e) {
			throw e;
		} catch (final IOException e) {
			throw e;
		} finally {
			if (null != bis) {
				bis.close ();
			}
		}
		return new String (bytes);
	}
	
	/**
	 * Send an eMail notification to a parent, advising them that their
	 * child has signed up, and requesting authorization.
	 * 
	 * @param kid WRITEME
	 * @throws FileNotFoundException WRITEME
	 * @throws IOException WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws DataException WRITEME
	 * @throws NamingException WRITEME
	 */
	public static void sendChildSignupMail (final User kid)
			throws FileNotFoundException, IOException,
			NotFoundException, DataException, NamingException {
		try {
			Mail.sendTemplateMail (kid, "ParentNotification", true,
					"Tootsville.com - Parent Approval Required");
		} catch (final MessagingException e) {
			// Do nothing XXX why not?
		}
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 * 
	 * TO sendMail WRITEME...
	 * 
	 * @param toAddress WRITEME twheys@gmail.com
	 * @param subject WRITEME twheys@gmail.com
	 * @param body WRITEME twheys@gmail.com
	 * @throws MessagingException WRITEME twheys@gmail.com
	 */
	public static void sendMail (final String toAddress,
			final String subject, final String body)
			throws MessagingException {
		Mail.sendMail (toAddress, subject, body, new String [] {});
	}
	
	/**
	 * <pre>
	 * twheys@gmail.com Feb 3, 2010
	 * </pre>
	 * 
	 * TO sendMail WRITEME...
	 * 
	 * @param toAddress WRITEME twheys@gmail.com
	 * @param subject WRITEME twheys@gmail.com
	 * @param body WRITEME twheys@gmail.com
	 * @param ccAddresses WRITEME twheys@gmail.com
	 * @throws MessagingException WRITEME twheys@gmail.com
	 */
	public static void sendMail (final String toAddress,
			final String subject, final String body,
			final String... ccAddresses) throws MessagingException {
		final Properties props = new Properties ();
		props.put ("mail.smtp.host", AppiusConfig.getSMTPHost ());
		final Session session = Session.getInstance (props, null);
		final MimeMessage msg = new MimeMessage (session);
		
		msg.setFrom (AppiusConfig.getMailSender ());
		msg.setRecipients (Message.RecipientType.TO, toAddress);
		
		for (final String ccAddress : ccAddresses) {
			msg.setRecipients (Message.RecipientType.CC, ccAddress);
		}
		
		msg.setSubject (subject);
		msg.setSentDate (new java.util.Date ());
		msg.setText (body);
		msg.setHeader ("X-Generator",
				AppiusClaudiusCaecus.class.getCanonicalName ()
						+ "/" + Mail.class.getCanonicalName ());
		AppiusClaudiusCaecus.blather ("Sending new Mail:\n" + "To: "
				+ toAddress + "\nSubject: " + subject);
		Transport.send (msg);
		AppiusClaudiusCaecus.blather ("Mail sent successfully");
	}
	
	/**
	 * Send a user's or parent's password out, after they have
	 * successfully completed the forgotten password recovery question.
	 * 
	 * @param user The user who forgot his/her password
	 * @throws NotFoundException ?? WRITEME
	 * @throws IOException if the template can't be read
	 * @throws FileNotFoundException if the template isn't found
	 */
	public static void sendPasswordRecoveryMail (
			final AbstractPerson user) throws FileNotFoundException,
			IOException, NotFoundException {
		try {
			Mail.sendTemplateMail (user, "PasswordRecover", false,
					"Tootsville.com - Password Recovery");
		} catch (final MessagingException e) {
			// Default catch action, report bug (twheys@gmail.com,
			// Sep
			// 9, 2009)
		}
		user.sentConfirmationMail ();
	}
	
	/**
	 * <p>
	 * This method is called when a member has signed up to be a VIT
	 * (Very Important Toot) member.
	 * </p>
	 * <p>
	 * Update the email address for the user and then send an
	 * enrollment email to the address.
	 * </p>
	 * 
	 * @param user User name that should be updated.
	 * @throws IOException if the template can't be read or something
	 *              similar
	 * @throws FileNotFoundException if the template file is missing
	 * @throws NotFoundException if the template file is not found
	 * @throws NamingException if the eMail address is invalid
	 * @throws DataException if something else bad happens
	 * @returns $object->status == true on success.
	 */
	public static void sendPremiumMail (final User user)
			throws FileNotFoundException, IOException,
			NotFoundException, DataException, NamingException {
		try {
			Mail.sendTemplateMail (
					user,
					"PremiumConfirmation",
					false,
					LibMisc.getText ("vitConfirmation.mailSubject"));
		} catch (final MessagingException e) {
			// Default catch action, report bug (twheys@gmail.com,
			// Sep
			// 9, 2009)
		}
		
	}
	
	/**
	 * Update the email address for the user and then send an
	 * enrollment email to the address.
	 * 
	 * @param user User name that should be updated.
	 * @throws IOException if the template can't be read or something
	 *              similar
	 * @throws FileNotFoundException if the template file is missing
	 * @throws NotFoundException if the template file is not found
	 * @throws NamingException if the eMail address is invalid
	 * @throws DataException if something else bad happens
	 * @returns $object->status == true on success.
	 */
	public static void sendSignupMail (final AbstractPerson user)
			throws FileNotFoundException, IOException,
			NotFoundException, DataException, NamingException {
		try {
			Mail.sendTemplateMail (user,
					user.getConfirmationTemplate (), false,
					"Tootsville.com - Account Approval Required");
		} catch (final MessagingException e) {
			// Default catch action, report bug (twheys@gmail.com,
			// Sep
			// 9, 2009)
		}
		
	}
	
	/**
	 * WRITEME: Don't know why this would be sent. twheys needs to
	 * document this method.
	 * 
	 * @param person WRITEME
	 * @throws FileNotFoundException WRITEME
	 * @throws IOException WRITEME
	 * @throws NotFoundException WRITEME
	 */
	public static void sendStaffPaswordResetMail (
			final AbstractPerson person)
			throws FileNotFoundException, IOException,
			NotFoundException {
		try {
			Mail.sendTemplateMail (person, "PasswordStaffRecover",
					false,
					"Tootsville.com - Account Approval Required");
		} catch (final MessagingException e) {
			// Default catch action, report bug (twheys@gmail.com,
			// Sep
			// 9, 2009)
		}
	}
	
	/**
	 * @param user The user to whom the mail should be sent (or, the
	 *             user's parent, if selected)
	 * @param templateName The name of the mail message template file
	 * @param isChildNotification WRITEME
	 * @param subject The subject to apply to the eMail.
	 * @throws FileNotFoundException if the template is not found
	 * @throws IOException failure reading template
	 * @throws NotFoundException ... WRITEME?
	 * @throws MessagingException WRITEME
	 */
	public static void sendTemplateMail (final AbstractPerson user,
			final String templateName,
			final boolean isChildNotification, final String subject)
			throws FileNotFoundException, IOException,
			NotFoundException, MessagingException {
		
		String message = Mail.readTemplate (templateName);
		
		final Pattern members_url = Pattern
				.compile ("\\$members_url");
		final Matcher m = members_url.matcher (message);
		message = m.replaceAll (AppiusConfig.getConfigOrDefault (
				"com.tootsville.members.url",
				"https://members.tootsville.com/membership"));
		
		final Pattern www_url = Pattern.compile ("\\$www_url");
		final Matcher w = www_url.matcher (message);
		message = w.replaceAll ("http://www.tootsville.com");
		
		final Pattern display = Pattern.compile ("\\$display");
		final Matcher d = display.matcher (message);
		message = d.replaceAll (user.getDisplayName ());
		
		final Pattern s_cookie = Pattern.compile ("\\$cookie");
		final Matcher s = s_cookie.matcher (message);
		message = s.replaceAll (user.getApprovalCookie ());
		
		final Pattern username = Pattern.compile ("\\$username");
		final Matcher u = username.matcher (message);
		message = u.replaceAll (user.getPotentialUserName ());
		
		final Pattern password = Pattern.compile ("\\$password");
		final Matcher p = password.matcher (message);
		message = p.replaceAll (user.getPassword ());
		
		if (isChildNotification && (user instanceof GeneralUser)) {
			final Pattern child_un = Pattern.compile ("\\$child_un");
			final Matcher cu = child_un.matcher (message);
			message = cu.replaceAll ( ((User) user)
					.getUserNameOrRequest ());
		}
		
		final Pattern child_pw = Pattern.compile ("\\$child_pw");
		final Matcher cp = child_pw.matcher (message);
		message = cp.replaceAll (isChildNotification ? user
				.getPassword () : "");
		
		try {
			Mail.sendMail (user.getResponsibleMail (), subject,
					message);
		} catch (final MessagingException e) {
			BugReporter.getReporter ("srv").reportBug (
					"Mail cannot be sent.", e);
		}
		
	}
	
	/**
	 * Forbids recently-bounced addresses from being used as well.
	 * 
	 * @see BadMailList
	 * @param address Any RFC-2822-valid eMail address string
	 * @throws DataException if the address isn't appropriate somehow
	 *              (e.g. bad format)
	 * @throws NamingException if the JNDI DNS provider fails (bubble
	 *              up)
	 */
	public static void validateMail (final String address)
			throws DataException, NamingException {
		
		final Pattern rfc2822 = Pattern
				.compile ("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
		
		final Matcher mailIsOk = rfc2822.matcher (address);
		if ( !mailIsOk.matches ()) {
			throw new DataException ("Invalid eMail address");
		}
		
		// final String leftSide = Mail.getLocalPart (address);
		Mail.validateMXDomain (Mail.getDomainPart (address));
		
		if (Mail.isBadMail (address)) {
			throw new DataException (
					"Bad eMail Address (received bounce message)");
		}
		
		/*
		 * OK. If we got here, then we're good: the address passes our
		 * test.
		 */
		return;
	}
	
	/**
	 * @param domainName the domain name for which we're looking for a
	 *             mail exchanger
	 * @throws NamingException if the JNDI provider fails
	 * @throws DataException if the domain does not have an MX record
	 *              in DNS
	 */
	public static void validateMXDomain (final String domainName)
			throws NamingException, DataException {
		final Hashtable <String, String> env = new Hashtable <String, String> ();
		env.put ("java.naming.factory.initial",
				"com.sun.jndi.dns.DnsContextFactory");
		env.put ("java.naming.provider.url",
				AppiusConfig.getDNS_JNDI ());
		
		final DirContext ctx = new InitialDirContext (env);
		
		final Attributes attrs = ctx.getAttributes (domainName,
				new String [] { "MX" });
		
		for (final NamingEnumeration <?> ae = attrs.getAll (); ae
				.hasMoreElements ();) {
			final Attribute attr = (Attribute) ae.next ();
			// String attrId = attr.getID();
			final NamingEnumeration <?> vals = attr.getAll ();
			if ( !vals.hasMoreElements ()) {
				throw new DataException ("Domain " + domainName
						+ " is not capable of receiving eMail");
			}
		}
		
		ctx.close ();
		
	}
	
}
