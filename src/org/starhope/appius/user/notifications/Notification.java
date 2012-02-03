/**
 * <p>
 * Copyright © 2010, Timothy Heys
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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author twheys@gmail.com
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.user.notifications;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.CastsToJSON;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * Notification class. Used to notify users of events asynchronously.
 * Notifications can be generated for offline users as well.
 * 
 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
 */
public class Notification extends SimpleDataRecord <Notification>
implements CastsToJSON {

	/**
	 * Java Serialisation unique ID
	 */
	private static final long serialVersionUID = 7431972694779670411L;

	/** The ID of the notification */
	private final int id = -1;

	/**
	 * The message catalog label for the notification message
	 */
	private String messageLabel = "";

	/**
	 * set of parameters to be substituted into the message obtained
	 * from LibMisc#getText messageLabel for %s parameters
	 */
	private final Map <String, String> messageParams = new ConcurrentHashMap <String, String> ();

	/**
	 * Time at which the notification was read/dispatched
	 */
	private long readTime = -1;

	/**
	 * The user to whom this notification was directed
	 */
	private AbstractUser recipient = null;

	/** The ID of the User that initiated this notification */
	private AbstractUser sender = null;

	/**
	 * time at which the notification was sent
	 */
	private long sentTime = -1;

	/**
	 * verbs that can be used to respond to this notification
	 */
	protected NotificationReplyVerbSet verbs = new NotificationReplyVerbSet ();

	/**
	 * Instantiate a new Notification
	 * 
	 * @param newSender The sender of the notification
	 * @param label The verb/label
	 * @param newRecipient The recipient
	 */
	public Notification (final AbstractUser newSender,
			final String label, final AbstractUser newRecipient) {
		super (Notification.class);
		sender = newSender;
		recipient = newRecipient;
		messageLabel = label;
	}

	/**
	 * add a message parameter to the notification.
	 * 
	 * @param key the parameter ID
	 * 
	 * @param param the new message parameter
	 */
	public void addMessageParam (final String key, final String param) {
		messageParams.put (key, param);
		changed ();
	}

	/**
	 * add a series of message parameters to the notification. Order is
	 * significant!
	 * 
	 * @param params the new message parameters
	 */
	public void addMessageParams (final Map <String, String> params) {
		messageParams.putAll (params);
		changed ();
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return id;
	}

	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () {
		return String.valueOf (id);
	}

	/**
	 * @return the id
	 */
	public long getID () {
		return id; /* brpocock@star-hope.org */
	}

	/**
	 * @return the messageLabel
	 */
	public String getMessageLabel () {
		return messageLabel; /* brpocock@star-hope.org */
	}

	/**
	 * @return the messageParams
	 */
	public Map <String, String> getMessageParams () {
		final Map <String, String> m = new HashMap <String, String> ();
		m.putAll (messageParams);
		return m;
	}

	/**
	 * @return the readTime
	 */
	public long getReadTime () {
		return readTime; /* brpocock@star-hope.org */
	}

	/**
	 * @return the recipient
	 */
	public AbstractUser getRecipient () {
		return recipient; /* brpocock@star-hope.org */
	}

	/**
	 * get available response verbs, if any. Special case, returns null
	 * for zero verbs.
	 * 
	 * @return a set of verbs or null
	 */
	public NotificationReplyVerbSet getReplyVerbs () {
		if (verbs.size () == 0) return null;
		final NotificationReplyVerbSet returned = new NotificationReplyVerbSet (
				verbs);
		return returned;
	}

	/**
	 * @return the senderID
	 */
	public AbstractUser getSender () {
		return sender; /* brpocock@star-hope.org */
	}

	/**
	 * @return the sentTime
	 */
	public long getSentTime () {
		return sentTime; /* brpocock@star-hope.org */
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}

	/**
	 * @return true, if the notification has been read
	 */
	public boolean isRead () {
		return -1 != readTime;
	}

	/**
	 * @return true, if the notification has been sent
	 */
	public boolean isSent () {
		return -1 != sentTime;
	}

	/**
	 * Used when the notification is handled.
	 */
	public void markAsRead () {
		if ( -1 == readTime) {
			readTime = System.currentTimeMillis ();
		}
	}

	/**
	 * Send a notification
	 */
	public void send () {
		if (isSent ()) return;
		sentTime = System.currentTimeMillis ();
		Quaestor.action (null, null, "notify", recipient);
		if (recipient.isOnline ()) {
			recipient.acceptSuccessReply ("notify", toJSON (), null);
		}
		changed ();
	}

	/**
	 * @param newLabel the messageLabel to set
	 */
	public void setMessageLabel (final String newLabel) {
		messageLabel = newLabel;
		changed ();
	}

	/**
	 * @param newRecipient the recipient to set
	 */
	public void setRecipient (final AbstractUser newRecipient) {
		recipient = newRecipient;
		changed ();
	}

	/**
	 * @param newSender the senderID to set
	 */
	public void setSender (final AbstractUser newSender) {
		sender = newSender;
		changed ();
	}

	/**
	 * return a JSON version of this notification
	 * 
	 * @return JSON object describing this notific
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject jso = new JSONObject ();
		try {
			jso.put ("id", id);
			jso.put ("label", messageLabel);
			if (null != sender) {
				jso.put ("sender", sender.getUserID ());
			}
			if (null != recipient) {
				jso.put ("recipient", recipient.getUserID ());
			}
			if (isSent ()) {
				jso.put ("sent", sentTime);
			}
			if (isRead ()) {
				jso.put ("read", readTime);
			}
			jso.put ("verbs", verbs.toJSON ());
			final JSONObject parm = new JSONObject ();
			for (final Entry <String, String> each : messageParams
					.entrySet ()) {
				parm.put (each.getKey (), each.getValue ());
			}
			jso.put ("parm", parm);
		} catch (final JSONException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a JSONException in Notification.toJSON ",
							e);
		}
		return jso;
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder s = new StringBuilder ();
		s.append ("Notification #");
		s.append (id);
		s.append (" (");
		if (null != sender) {
			s.append (sender.getDebugName ());
		}
		s.append ("->");
		if (null != recipient) {
			s.append (recipient.getDebugName ());
		}
		s.append (") “");
		s.append (messageLabel);
		s.append ("” ");
		if (isSent ()) {
			s.append ("sent:");
			s.append (new java.sql.Timestamp (sentTime).toString ());
		}
		if (isSent () && isRead ()) {
			s.append ("; ");
		}
		if (isRead ()) {
			s.append ("read:");
			s.append (new java.sql.Timestamp (readTime).toString ());
			s.append ("; verbs(");
		}
		s.append (verbs.toString ());
		s.append ("); params(");
		for (final Entry <String, String> each : messageParams
				.entrySet ()) {
			s.append (each.getKey ());
			s.append ("=>");
			s.append (each.getValue ());
			s.append (", ");
		}
		s.append (")");
		return s.toString ();
	}
}
