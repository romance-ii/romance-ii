/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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

package org.starhope.appius.types;

import java.sql.Timestamp;

import org.json.JSONObject;
import org.starhope.appius.user.GeneralUser;

/**
 * @author brpocock@star-hope.org
 */
public interface GameWorldMessage {

	/**
	 * Delete this message (making it invisible in the inbox or wall)
	 */
	public abstract void delete ();


	/**
	 * @return the attachmentURL
	 */
	public abstract String getAttachmentURL ();

	/**
	 * @return the body
	 */
	public abstract String getBody ();

	//
	// /**
	// * @param id WRITEME
	// * @return WRITEME
	// * @throws NotFoundException WRITEME
	// */
	// public GameWorldMessage getByID (int id) throws
	// NotFoundException;

	/**
	 * @return the fromID
	 */
	public abstract int getFromID ();

	/**
	 * @return the fromName
	 */
	public abstract String getFromName ();
	
	/**
	 * Returns the ID of this post.
	 * 
	 * @return the ID of the post.
	 */
	public abstract int getID ();

	/**
	 * @return the inReplyTo
	 */
	public abstract int getInReplyTo ();

// /**
	// * @param st WRITEME
	// * @return WRITEME
	// * @throws SQLException WRITEME
	// */
	// public abstract Vector <GameWorldMessage> getMessagesFrom (
	// PreparedStatement st) throws SQLException;

	/**
	 * @return the read
	 */
	public abstract Timestamp getRead ();

	/**
	 * @return the sent
	 */
	public abstract Timestamp getSent ();

	/**
	 * @return the subject
	 */
	public abstract String getSubject ();

	/**
	 * @return the toID
	 */
	public abstract int getToID ();

	/**
	 * @return the toName
	 */
	public abstract String getToName ();

	/**
	 * @return true, if this message has been deleted
	 */
	public abstract boolean isDeleted ();

	/**
	 * @return the isWallPost
	 */
	public abstract boolean isWallPost ();

	/**
	 *
	 */
	public abstract void markAsRead ();

	/**
	 * @return Send this message (store it into the database)
	 */
	public abstract boolean send ();

	/**
	 * @param newURL the attachmentURL to set
	 */
	public abstract void setAttachmentURL (final String newURL);

	/**
	 * @param body1 the body to set
	 * @return If the body does not pass the filters, return false
	 */
	public abstract boolean setBody (final String body1);
	
	/**
	 * Set the sender of this message
	 * 
	 * @param sender the sender of the mail message
	 */
	public abstract void setFrom (final GeneralUser sender);

	/**
	 * @param fromID1 the fromID to set
	 */
	public abstract void setFromID (final int fromID1);

	/**
	 * @param parentMessageID the inReplyTo to set
	 */
	public abstract void setInReplyTo (final int parentMessageID);

	/**
	 * @param read1 the read to set
	 */
	public abstract void setRead (final Timestamp read1);

	/**
	 * @param sent1 the sent to set
	 */
	public abstract void setSent (final Timestamp sent1);

	/**
	 * @param subject1 the subject to set
	 */
	public abstract void setSubject (final String subject1);
	
	/**
	 * Set the recipient of this message
	 * 
	 * @param recipient the recipient of this message
	 */
	public abstract void setTo (final GeneralUser recipient);
	
	/**
	 * Set the recipient of this message
	 * 
	 * @param toID1 the ID of the recipient of this message
	 */
	public abstract void setToID (final int toID1);

	/**
	 * @param wallPostQ the isWallPost to set
	 */
	public abstract void setWallPost (final boolean wallPostQ);
	
	/**
	 * Return a representation of this object in JSON form. Identical to
	 * calling {@link #toJSON(boolean)} with inMailbox set to “false”
	 * 
	 * @return WRITEME
	 * @see org.starhope.appius.sql.SQLPeerDatum#toJSON()
	 */
	public abstract JSONObject toJSON ();
	
	/**
	 * Get the public representation of this message in JSON form
	 * 
	 * @param inMailbox if true, suppress the body (for use in mailbox
	 *            listings)
	 * @return the JSON representation of this message (or, if
	 *         {inMailbox} is set, only the envelope)
	 */
	public abstract JSONObject toJSON (final boolean inMailbox);

	/**
	 * <p>
	 * Undeletes a mail message and places it in the Inbox.
	 * </p>
	 *<p>
	 * <strong>Note</strong> that this will <em>not</em> undelete a Wall
	 * message correctly, as it will go into the Inbox regardless.
	 * </p>
	 */
	public abstract void undelete ();

}
