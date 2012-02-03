/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.messaging;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.Vector;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.messaging.MailMessage.MessageFlag;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * SQL loader for {@link MailMessage}, used for in-world eMail and also
 * wall posts
 *
 * @author brpocock@star-hope.org
 */
public class MailMessageSQLLoader implements RecordLoader <MailMessage> {

	/**
	 * @param originalMessage the message ID to which replies are wanted
	 * @return mail messages posted on the user's wall in reply to the
	 *         given message
	 * @deprecated Use
	 *             {@link MailMessage#getMailOnWallInReplyTo(MailMessage)}
	 *             instead
	 */
	@Deprecated
	public static Vector <MailMessage> getMailOnWallInReplyTo (
			final MailMessage originalMessage) {
		return MailMessage.getMailOnWallInReplyTo (originalMessage);
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public MailMessageSQLLoader () {
		// no op
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final MailMessage changedRecord) {
		DataRecordFlushManager.update (this, changedRecord);
	}

	/**
	 * <pre>
	 * twheys@gmail.com Apr 6, 2010
	 * </pre>
	 *
	 * TO getFlags WRITEME...
	 *
	 * @param con database connection
	 * @param mailMessage message
	 */
	void getFlags (final Connection con, final MailMessage mailMessage) {
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			st = con.prepareStatement ("SELECT * FROM messageFlags WHERE postID=?");
			st.setInt (1, mailMessage.getID ());
			rs = st.executeQuery ();
			while (rs.next ()) {
				final int fromUserID = rs.getInt ("userID");
				final MessageFlag flag = MessageFlag.valueOf (rs
						.getString ("flag"));
				mailMessage.addFlag (fromUserID, flag);
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (e);
		} finally {
			LibMisc.closeAll (rs, st);
		}
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2291 $";
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#initializeStorage(java.lang.String)
	 */
	@Override
	public void initializeStorage (final String storageURL)
			throws NotReadyException {
		// no op
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#isRealtime()
	 */
	@Override
	public boolean isRealtime () {
		return false;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
	 */
	@Override
	public MailMessage loadRecord (final int id)
			throws NotFoundException {
		return set (new MailMessage (this), id);
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public MailMessage loadRecord (final String identifier)
			throws NotFoundException {
		// return loadRecord (identifier);
		throw new NotFoundException (
				"Can't load mail message from a string ID");
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final MailMessage record) {
		record.markForReload ();
		try {
			set (record, record.getID ());
		} catch (NotFoundException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a NotFoundException in MailMessageSQLLoader.refresh ",
							e);
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final MailMessage record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
				.reportBug ("unimplemented MailMessageSQLLoader::removeRecord (brpocock@star-hope.org, Oct 28, 2010)");

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final MailMessage record) {
		if (record.getID () == -1) {
			Connection con = null;
			PreparedStatement st = null;
			ResultSet rs = null;
			try {
				con = AppiusConfig.getDatabaseConnection ();
				st = con.prepareStatement (
						"INSERT INTO messages (fromUserID, toUserID, sentTime, readTime, subject, body, isDeleted, inReplyTo, attachmentURL) VALUES (?,?,?,?,?,?,?,?,?)",
						Statement.RETURN_GENERATED_KEYS);

				st.setInt (1, record.getFromID ());
				st.setInt (2, record.getToID ());
				st.setTimestamp (3, record.getSent ());
				if (null == record.getRead ()) {
					st.setNull (4, Types.TIMESTAMP);
				} else {
					st.setTimestamp (4, record.getRead ());
				}
				st.setString (5, record.getSubject ());
				st.setString (6, record.getBody ());
				st.setString (
						7,
						record.isDeleted () ? "D" : record
								.isWallPost () ? "W" : "M");
				if (record.getInReplyTo () > 0) {
					st.setInt (8, record.getInReplyTo ());
				} else {
					st.setNull (8, Types.INTEGER);
				}
				if (null != record.getAttachmentURL ()) {
					st.setString (9, record.getAttachmentURL ());
				} else {
					st.setNull (9, Types.VARCHAR);
				}
				st.execute ();
				rs = st.getGeneratedKeys ();
				rs.next ();
				record.setID (rs.getInt (1));

			} catch (final SQLException e) {
				AppiusClaudiusCaecus.reportBug (
						"Couldn't write message", e);
			} finally {
				LibMisc.closeAll (rs, st, con);
			}
			return;
		}
		Connection con = null;
		PreparedStatement st = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("UPDATE messages SET fromUserID = ?, toUserID = ?, sentTime = ?, readTime = ?, subject = ?, body = ?, isDeleted = ?, inReplyTo = ?, attachmentURL = ? WHERE ID=?");
			st.setInt (1, record.getFromID ());
			st.setInt (2, record.getToID ());
			st.setTimestamp (3, record.getSent ());
			if (null == record.getRead ()) {
				st.setNull (4, Types.TIMESTAMP);
			} else {
				st.setTimestamp (4, record.getRead ());
			}
			st.setString (5, record.getSubject ());
			st.setString (6, record.getBody ());
			st.setString (7,
					record.isDeleted () ? "D"
							: record.isWallPost () ? "W" : " ");
			if (record.getInReplyTo () > 0) {
				st.setInt (8, record.getInReplyTo ());
			} else {
				st.setNull (8, Types.INTEGER);
			}
			if (null != record.getAttachmentURL ()) {
				st.setString (9, record.getAttachmentURL ());
			} else {
				st.setNull (9, Types.VARCHAR);
			}
			st.setInt (10, record.getID ());
			st.execute ();
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (e);
		} finally {
			LibMisc.closeAll (st, con);
		}
	}

	/**
	 * set properties of a mail message from a given database record ID
	 *
	 * @param m the message object to be set
	 * @param id the database message ID
	 * @return the message object, having been set
	 * @throws NotFoundException if the record ID is not found in the
	 *             database
	 */
	public MailMessage set (final MailMessage m, final int id)
			throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM messages WHERE ID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			rs.next ();
			m.setID (rs.getInt ("id"));
			m.setBody (rs.getString ("body"));
			m.setSubject (rs.getString ("subject"));
			m.setFromID (rs.getInt ("fromUserID"));
			m.setToID (rs.getInt ("toUserID"));
			m.setSent (rs.getTimestamp ("sentTime"));
			m.setAttachmentURL (rs.getString ("attachmentURL"));
			try {
				m.setRead (rs.getTimestamp ("readTime"));
				if (rs.wasNull ()) {
					m.setRead (null);
				}
			} catch (final SQLException e) {
				m.setRead (null);
			}
			try {
				m.setInReplyTo (rs.getInt ("inReplyTo"));
				if (rs.wasNull ()) {
					m.setInReplyTo ( -1);
				}
			} catch (final SQLException e) {
				m.setInReplyTo ( -1);
			}
			final String place = rs.getString ("isDeleted");
			m.setDeleted ("D".equals (place));
			m.setWallPost ("W".equals (place));
			getFlags (con, m);
			m.markAsLoaded ();
			return m;
		} catch (final SQLException e) {
			throw new NotFoundException (e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}
}
