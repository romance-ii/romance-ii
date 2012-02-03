/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
 * @author brpocock@star-hope.org, twheys@gmail.com
 */

package org.starhope.appius.messaging;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Vector;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.Messages;
import org.starhope.appius.sys.op.FilterResult;
import org.starhope.appius.sys.op.FilterStatus;
import org.starhope.appius.types.FilterType;
import org.starhope.appius.types.GameWorldMessage;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.util.LibMisc;

/**
 * @author brpocock@star-hope.org, twheys@gmail.com
 */
public class MailMessage extends SimpleDataRecord <MailMessage>
		implements GameWorldMessage {

	/**
	 * Flags for messages
	 *
	 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
	 */
	public enum MessageFlag {
		/**
		 * Used for TootsBook in line with Facebook's "like"
		 */
		COOL
	}

	/**
	 * The censoring object used to filter in-game mail messages
	 */
	private final static AbstractCensor censor = AppiusConfig
			.getFilter (FilterType.KID_CHAT);

	/**
	 * Java serialisation version ID
	 */
	private static final long serialVersionUID = -1350270979016126771L;
	
	/**
	 * @param originalMessage the message ID to which replies are wanted
	 * @return mail messages posted on the user's wall in reply to the
	 *         given message
	 */
	public static Vector <MailMessage> getMailOnWallInReplyTo (
	        final MailMessage originalMessage) {
		return originalMessage.getRepliesOnWall (); }

	/**
	 * URL of an attachment (XXX WHAT?)
	 */
	private String attachmentURL;

	/**
	 * body of the message
	 */
	private String body;

	/**
	 * Flags set on this message, stored by key of the userID who
	 * created the flag and the value of the flag names. See MySQL table
	 * messageFlags.
	 */
	final HashMap <Integer, MessageFlag> flags = new HashMap <Integer, MessageFlag> ();

	/**
	 * sender user ID
	 */
	private int fromID;
	/**
	 * sender name
	 */
	private String fromName;
	/**
	 * message unique ID
	 */
	private int id;

	/**
	 * If this message is in reply to another, then this is the message
	 * ID of the parent message.
	 */
	private int inReplyTo = -1;

	/**
	 * If true, the user (or a moderator) has deleted this message
	 */
	private boolean isDeleted;
	/**
	 * If true, this message is a Wall Post on TootsBook.
	 */
	private boolean isWallPost = false;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) read (MailMessage)
	 */
	private Timestamp read;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) sent (MailMessage)
	 */
	private Timestamp sent;

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) subject (MailMessage)
	 */
	private String subject;

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) toID (MailMessage)
	 */
	private int toID;

	/**
	 * The name of the message's recipient.
	 */
	private String toName;

	/**
	 * nil constructor
	 */
	public MailMessage (){
		super (MailMessage.class);
	}

	/**
	 * general constructor
	 *
	 * @param newLoader the loader
	 */
	public MailMessage (final RecordLoader <MailMessage> newLoader) {
		super (newLoader);
		subject = "eMail";
		fromID = -1;
		toID = -1;
		body = "";
		read = null;
		sent = null;
		fromName = "";
		toName = "";
		setDeleted (false);
		isWallPost = false;
		attachmentURL = null;
		inReplyTo = -1;
	}

	/**
	 * Add a flag to this message.
	 *
	 * @param u The user adding the flag
	 * @param flag the flag to be added
	 */
	public void addFlag (final AbstractUser u, final MessageFlag flag) {
		addFlag (u.getUserID (), flag);
	}



	/**
	 * Add a flag to this message. FIXME SQL move to
	 * MailMessageSQLLoader
	 *
	 * @param fromUserID The user ID for the user adding the flag
	 * @param flag the flag to be added
	 */
	public void addFlag (final int fromUserID, final MessageFlag flag) {
		flags.put (Integer.valueOf (fromUserID), flag);
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("INSERT INTO messageFlags (postID, userID, flag) VALUES (?, ?, ?)");
			st.setInt (1, getID ());
			st.setInt (2, fromUserID);
			st.setString (3, flag.toString ());
			st.execute ();
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (e);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}

	/**
	 * @see GameWorldMessage#delete()
	 */
	@Override
	public void delete () {
		setDeleted (true);
		changed ();
	}

	/**
	 * WRITEME
	 *
	 * @return the attachmentURL
	 */
	@Override
	public String getAttachmentURL () {
		return attachmentURL;
	}

	/**
	 * WRITEME
	 *
	 * @return WRITEME
	 * @see GameWorldMessage#getBody()
	 */
	@Override
	public String getBody () {
		return body;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return getID ();
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return String.valueOf (getID ());
	}

	/**
	 * @return WRITEME
	 * @see GameWorldMessage#getFromID()
	 */
	@Override
	public int getFromID () {
		return fromID;
	}

	/**
	 * @return WRITEME
	 * @see GameWorldMessage#getFromName()
	 */
	@Override
	public String getFromName () {
		return fromName;
	}

	// /**
	// * Fetch an ordered set of messages based upon a prepared
	// statement
	// *
	// * @param st A prepared statement ready to be executed
	// * @return the set of messages returned by the given prepared
	// * statement
	// * @throws SQLException if there's a problem getting results
	// */
	// @Override
	// public Vector <GameWorldMessage> getMessagesFrom (
	// final PreparedStatement st) throws SQLException {
	// final Vector <GameWorldMessage> messages = new Vector
	// <GameWorldMessage> ();
	//
	// if (st.execute ()) {
	// final ResultSet rs = st.getResultSet ();
	// while (rs.next ()) {
	// AppiusClaudiusCaecus.blather ("Mail subject: "
	// + rs.getString ("subject"));
	// try {
	// messages.add (new MailMessage (rs));
	// } catch (final RuntimeException e) {
	// e.printStackTrace ();
	// AppiusClaudiusCaecus
	// .blather ("Skipping a bad message :-(");
	// }
	// }
	// } else {
	// AppiusClaudiusCaecus.blather ("User has no mail");
	// }
	// return messages;
	// }

	/**
	 * @return WRITEME
	 * @see GameWorldMessage#getID()
	 */
	@Override
	public int getID () {
		return id;
	}

	/**
	 * @return WRITEME
	 * @see GameWorldMessage#getInReplyTo()
	 */
	@Override
	public int getInReplyTo () {
		return inReplyTo;
	}

	/**
	 * @return WRITEME
	 * @see GameWorldMessage#getRead()
	 */
	@Override
	public Timestamp getRead () {
		return read;
	}

	/**
	 * @return Get replies to this message which are wall posts.
	 *
	 */
	public Vector<MailMessage> getRepliesOnWall () {
		Vector <MailMessage> messages = new Vector <MailMessage> ();
	    Connection con = null;
	    PreparedStatement st = null;
		ResultSet rs = null;
	    try {
	        con = AppiusConfig.getDatabaseConnection ();
	        st = con
					.prepareStatement ("SELECT ID FROM messages WHERE isDeleted='W' AND inReplyTo=? AND body<>'' ORDER BY messages.sentTime ASC");

	        st.setInt (1, getID());
			rs = st.executeQuery ();
			while (rs.next ()) {
				final MailMessage m = new MailMessage ();
				try {
					messages.add (((MailMessageSQLLoader)m.getRecordLoader()).set (m, rs
							.getInt (1)));
				} catch (NotFoundException e) {
					AppiusClaudiusCaecus.reportBug ("Caught a NotFoundException in MailMessageSQLLoader.getMailOnWallInReplyTo ", e);
				}
			}
	    } catch (final SQLException e) {
	        AppiusClaudiusCaecus.reportBug (e);
	    } finally {
			LibMisc.closeAll (rs, st, con);
	    }
	    return messages;
	}

	/**
	 * @return WRITEME
	 * @see GameWorldMessage#getSent()
	 */
	@Override
	public Timestamp getSent () {
		return sent;
	}

	/**
	 * @return WRITEME
	 * @see GameWorldMessage#getSubject()
	 */
	@Override
	public String getSubject () {
		return subject;
	}



	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2223 $";
	}

	/**
	 * @return WRITEME
	 * @see GameWorldMessage#getToID()
	 */
	@Override
	public int getToID () {
		return toID;
	}

	/**
	 * @return WRITEME
	 * @see GameWorldMessage#getToName()
	 */
	@Override
	public String getToName () {
		return toName;
	}

	/**
	 * @return WRITEME
	 * @see GameWorldMessage#isDeleted()
	 */
	@Override
	public boolean isDeleted () {
		return isDeleted;
	}

	/**
	 * @return WRITEME
	 * @see GameWorldMessage#isWallPost()
	 */
	@Override
	public boolean isWallPost () {
		return isWallPost;
	}

	/**
	 * @see GameWorldMessage#markAsRead()
	 */
	@Override
	public void markAsRead () {
		if (null != read) {
			return;
		}
		read = new Timestamp (System.currentTimeMillis ());
		changed ();
	}

	/**
	 * @return WRITEME
	 * @see GameWorldMessage#send()
	 */
	@Override
	public boolean send () {
		if (null == sent) {
			sent.setTime (System.currentTimeMillis ());
		}
		return true;
	}

	/**
	 * WRITEME
	 *
	 * @param newAttachmentURL the attachmentURL to set
	 */
	@Override
	public void setAttachmentURL (final String newAttachmentURL) {
		attachmentURL = newAttachmentURL;
		changed ();
	}

	/**
	 * @param newBody The new body content for the message
	 * @see GameWorldMessage#setBody(java.lang.String)
	 */
	@Override
	public boolean setBody (final String newBody) {
		try {
			MailMessage.censor.prime (AppiusConfig
					.getDatabaseConnection ());
		} catch (final SQLException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		}
		final FilterResult carlSays = MailMessage.censor
				.filterMessage (newBody);
		if (FilterStatus.Ok == carlSays.status) {
			body = newBody;
			changed ();
			return true;
		}
		body = "";
		final AbstractUser sender = Nomenclator
				.getUserByID (getFromID ());
		if (null != sender && sender.isOnline ()) {
			sender
					.acceptMessage (
							LibMisc
									.getTextOrDefault (
											"com.tootsville.MailMessage.filterTitle",
											"That's not nice"),
							"POST",
							LibMisc
									.getTextOrDefault (
											"com.tootsville.MailMessage.filtered",
											"I removed the contents of your mail message, because it was not appropriate for Tootsville"));
		}
		changed ();
		return false;
	}

	/**
	 * @param really the isDeleted to set
	 */
	public void setDeleted (final boolean really) {
		isDeleted = really;
		changed ();
	}

	/**
	 * @param sender the sender (FROM: field) for the message
	 * @see GameWorldMessage#setFrom(GeneralUser)
	 */
	@Override
	public void setFrom (final GeneralUser sender) {
		fromID = sender.getUserID ();
		fromName = sender.getUserName ();
		changed ();
	}

	/**
	 * @param fromID1 the sender's user ID
	 * @see GameWorldMessage#setFromID(int)
	 */
	@Override
	public void setFromID (final int fromID1) {
		fromID = fromID1;
		fromName = Nomenclator.getLoginForID (fromID1);
		changed ();
	}

	/**
	 * @param newID the id to set
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}

	/**
	 * @param parentMessageID the message ID of the parent message, to
	 *            which this one is a reply
	 * @see GameWorldMessage#setInReplyTo(int)
	 */
	@Override
	public void setInReplyTo (final int parentMessageID) {
		inReplyTo = parentMessageID;
		changed ();
	}

	/**
	 * @param timeRead WRITEME
	 * @see GameWorldMessage#setRead(java.sql.Timestamp)
	 */
	@Override
	public void setRead (final Timestamp timeRead) {
		final long wasRead = null == read ? -1 : read.getTime ();
		if (null == read || 1 > wasRead
				|| timeRead.getTime () < wasRead) {
			read = timeRead;
		}
		changed ();
	}

	/**
	 * @param sent1 WRITEME
	 * @see GameWorldMessage#setSent(java.sql.Timestamp)
	 */
	@Override
	public void setSent (final Timestamp sent1) {
		sent = sent1;
		changed ();

	}

	/**
	 * @param subject1 The Subject of the message
	 * @see GameWorldMessage#setSubject(java.lang.String)
	 */
	@Override
	public void setSubject (final String subject1) {
		try {
			MailMessage.censor.prime (AppiusConfig
					.getDatabaseConnection ());
		} catch (final SQLException e) {
			throw AppiusClaudiusCaecus.fatalBug (e);
		}
		final FilterResult carlSays = MailMessage.censor
				.filterMessage (subject1);
		if (FilterStatus.Ok == carlSays.status) {
			subject = subject1;
		} else {
			subject = "";
			final AbstractUser sender = Nomenclator
					.getUserByID (getFromID ());
			if (null != sender && sender.isOnline ()) {
				sender
						.acceptMessage (
								LibMisc
										.getTextOrDefault (
												"com.tootsville.MailMessage.filterTitle",
												"That's not nice"),
								"POST",
								LibMisc
										.getTextOrDefault (
												"com.tootsville.MailMessage.filterWarning",
												"I removed the subject of your mail message, because it was not appropriate for Tootsville"));
			}
		}
		changed ();

	}

	/**
	 * @param recipient WRITEME
	 */
	@Override
	public void setTo (final GeneralUser recipient) {
		toID = recipient.getUserID ();
		toName = recipient.getUserName ();
		changed ();

	}

	/**
	 * @param toID1 WRITEME
	 * @see GameWorldMessage#setToID(int)
	 */
	@Override
	public void setToID (final int toID1) {
		toID = toID1;
		toName = Nomenclator.getLoginForID (toID1);
		changed ();

	}

	/**
	 * // * @param wallPostQ WRITEME
	 *
	 * @see GameWorldMessage#setWallPost(boolean)
	 */
	@Override
	public void setWallPost (final boolean wallPostQ) {
		isWallPost = wallPostQ;
		changed ();

	}

	/**
	 * @see GameWorldMessage#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		return toJSON (false);
	}

	/**
	 * @param inMailbox WRITEME
	 * @return WRITEME
	 * @see GameWorldMessage#toJSON(boolean)
	 */
	@Override
	public JSONObject toJSON (final boolean inMailbox) {
		final JSONObject self = new JSONObject ();
		try {
			self.put ("from", getFromName ());
			self.put ("to", getToName ());
			self.put ("subject", subject);
			if ( !inMailbox) {
				self.put ("body", body);
			}
			self.put ("sent", Messages.prettyDate (sent));
			self.put ("id", getID ());
			if (null != read) {
				self.put ("read", Messages.prettyDate (read));
			}
			if (inReplyTo > 0) {
				self.put ("reply-to", inReplyTo);
			}
			if (isWallPost) {
				self.put ("wall", true);
			}
			if (isDeleted ()) {
				self.put ("deleted", true);
			}
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (e);
		}
		return self;
	}

	/**
	 * @see GameWorldMessage#undelete()
	 */
	@Override
	public void undelete () {
		setDeleted (false);
		changed ();
	}
}
