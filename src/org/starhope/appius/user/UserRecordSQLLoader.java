/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.appius.user;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.sql.SQLLoader;
import org.starhope.appius.test.ConnectionDebug;
import org.starhope.appius.types.AgeBracket;
import org.starhope.appius.types.Colour;
import org.starhope.appius.types.UserActiveState;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.util.LibMisc;

/**
 * <h1>User Record</h1>
 * <p>
 * The User Record is the canonical storage for all things that describe
 * a character in the game world; this is the “character sheet.” An User
 * Record may describe a player-character, an NPC, or even a
 * non-character that acts in some way <em>like</em> an user, e.g. an
 * intelligent object driven by a script, which logically acts as an
 * NPC, but is essentially not.
 * </p>
 * <p>
 * Every user-like object is required to implement {@link AbstractUser},
 * which provides an enormous number of accessor methods to the data
 * defined by an UserRecord. While there is <em>no requirement</em> that
 * any given Abstract User implementation <em>must</em> use a UserRecord
 * for its backing store, it is <em>extremely strongly recommended</em>
 * that they should do so.
 * </p>
 * <h3>Migration</h3>
 * <p>
 * If migrating with default (Tootsville™-like) table layouts from
 * Appius 1.0 to Appius 1.1, you'll need to execute the following DDL
 * instructions on your database server to update the table structures.
 * Note that “avatarID” was never used by Appius Claudius Cæcus,
 * however, the sample SQL table structures distributed with 0.8 through
 * 1.0 had this column in place. (Appius has always used the avatarClass
 * column exclusively.)
 * </p>
 * <p>
 * It is believed that removing the “classID” column should also be
 * harmless, however, there may be some reference to it in the codebase
 * still. The contents of the “classID” column have never been used by
 * Appius directly, however, the contents of that column should indicate
 * the version of Appius which last wrote to the database. Early
 * versions of Appius (0.x.x) wrote a classID of -3; Appius 1.0.x wrote
 * -4; and this series (1.1.x) writes -5.
 * </p>
 * 
 * <pre>
 * ALTER TABLE users ADD COLUMN travelRate DECIMAL(5,2) UNSIGNED NOT NULL DEFAULT 100.00;
 * ALTER TABLE users ADD COLUMN parentApprovedName ENUM('Y','N') NOT NULL DEFAULT 'N';
 * ALTER TABLE users ADD COLUMN lastZoneName VARCHAR(50) NOT NULL DEFAULT '';
 * ALTER TABLE users DROP COLUMN avatarID;
 * </pre>
 * 
 * @author brpocock@star-hope.org
 * @author twheys@gmail.com
 * @author edward.winkelman@gmail.com
 */
public class UserRecordSQLLoader implements SQLLoader <UserRecord>,
		UserRecordLoader {
	/**
	 * The Class ID for user records created or updated by this loader.
	 * For debugging purposes only; the classID column is no longer
	 * read.
	 */
	private static final int CLASS_ID_CURRENT = -5;

	/**
	 * The SQL statement for inserting or updating user records
	 */
	private static final String SAVE_RECORD_SQL = "INSERT INTO users "
			+ "(ID, userName, password, classID, mail, avatarClass, baseColor,"
			+ "extraColor, birthDate, ageGroup, language, dialect, parentID,"
			+ "approvedDate, emailPlusDate, canTalk, canEnterChatZone,"
			+ "canEnterMenuZone, canBetaTest, givenName, kickedUntil,"
			+ "kickedReasonCode, kickedBy, isActive, needsNaming, staffLevel,"
			+ "notable, canContact, requestedName, passRecoverQ, passRecoverA,"
			+ "nameRequestedAt, mailConfirmed, referer, registeredAt, chatFG,"
			+ "chatBG, travelRate, parentApprovedName, lastZoneName) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,"
			+ "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) "
			+ ""
			+ "ON DUPLICATE KEY UPDATE ID=LAST_INSERT_ID(ID),"
			+ "userName=Values(userName),password=Values(password),"
			+ "classID=Values(classID),mail=Values(mail),avatarClass=Values(AvatarClass),"
			+ "baseColor=Values(baseColor),extraColor=Values(extraColor),"
			+ "birthDate=Values(birthDate),ageGroup=Values(ageGroup),"
			+ "language=Values(language),dialect=Values(dialect),"
			+ "parentID=Values(parentID),approvedDate=Values(approvedDate),"
			+ "emailPlusDate=Values(emailPlusDate),canTalk=Values(canTalk),"
			+ "canEnterChatZone=Values(canEnterChatZone),canEnterMenuZone=Values(canEnterMenuZone),"
			+ "canBetaTest=Values(canBetaTest),givenName=Values(givenName),"
			+ "kickedUntil=Values(kickedUntil),kickedReasonCode=Values(kickedReasonCode),"
			+ "kickedBy=Values(kickedBy),isActive=Values(isActive),"
			+ "needsNaming=Values(needsNaming),staffLevel=Values(staffLevel),"
			+ "notable=Values(notable),canContact=Values(canContact),"
			+ "requestedName=Values(requestedName),passRecoverQ=Values(passRecoverQ),"
			+ "passRecoverA=Values(passRecoverA),nameRequestedAt=Values(nameRequestedAt),"
			+ "mailConfirmed=Values(mailConfirmed),referer=Values(referer),"
			+ "registeredAt=Values(registeredAt),chatFG=Values(chatFG),"
			+ "chatBG=Values(chatBG),travelRate=Values(travelRate),"
			+ "parentApprovedName=Values(parentApprovedName),"
			+ "lastZoneName=Values(lastZoneName)";

	/**
	 * Fetch the user's avatar information from the database
	 * 
	 * @param userRecord The UserRecord being serviced
	 * @param resultSet database record to interpret
	 * @throws SQLException if the record can't be interpreted
	 */
	protected static void fetch_avatarInfo (
			final UserRecord userRecord, final ResultSet resultSet)
			throws SQLException {

		try {
			userRecord.setAvatarClass (Nomenclator
					.getDataRecord (AvatarClass.class, resultSet
							.getInt ("avatarClass")));
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a NotFoundException in UserRecordSQLLoader.fetch_avatarInfo ",
							e);
		}

		userRecord.setBaseColor (new Colour (resultSet
				.getInt ("baseColor")));
		userRecord.setExtraColor (new Colour (resultSet
				.getInt ("extraColor")));

	}

	/**
	 * Fetch the chat colours for this user from the database
	 * 
	 * @param userRecord The UserRecord being serviced
	 * @param resultSet database record to interpret
	 * @throws SQLException if the record can't be interpreted
	 */
	protected static void fetch_chatColours (
			final UserRecord userRecord, final ResultSet resultSet)
			throws SQLException {
		userRecord.setChatFG (new Colour (resultSet.getInt ("chatFG")));
		userRecord.setChatBG (new Colour (resultSet.getInt ("chatBG")));
	}

	/**
	 * Fetch the user's date of birth and related information from the
	 * database record provided
	 * 
	 * @param userRecord The UserRecord being serviced
	 * @param resultSet database record to interpret
	 * @throws SQLException if the record can't be interpreted
	 */
	protected static void fetch_dobInfo (final UserRecord userRecord,
			final ResultSet resultSet) throws SQLException {
		try {
			userRecord.setBirthDate (resultSet.getDate ("birthDate"));
		} catch (final SQLException e) {
			userRecord.setBirthDate (null);
		}

		final String group = resultSet.getString ("ageGroup");
		if (group.equals ("K")) {
			userRecord.setAgeGroup (AgeBracket.Kid);
		} else if (group.equals ("T")) {
			userRecord.setAgeGroup (AgeBracket.Teen);
		} else if (group.equals ("A")) {
			userRecord.setAgeGroup (AgeBracket.Adult);
		} else if (group.equals ("X")) {
			userRecord.setAgeGroup (AgeBracket.System);
		} else {
			userRecord.setAgeGroup (AgeBracket.System);
			AppiusClaudiusCaecus
					.reportBug ("Unexpected users.ageGroup value = "
							+ group);
		}

	}

	/**
	 * Fetch the user's language and dialect information from the
	 * database record
	 * 
	 * @param userRecord The UserRecord being serviced
	 * @param resultSet the database record from which to be loaded
	 * @throws SQLException if the record can't be interpreted
	 */
	protected static void fetch_language (final UserRecord userRecord,
			final ResultSet resultSet) throws SQLException {
		userRecord.setLanguage (resultSet.getString ("language"),
				resultSet.getString ("dialect"));
	}

	/**
	 * Fetch the user's last activity information from the database
	 * record
	 * 
	 * @param userRecord record being loaded
	 * @throws SQLException if the record can't be interpreted.
	 */
	protected static void fetch_laston (final UserRecord userRecord)
			throws SQLException {
		Connection con = null;
		PreparedStatement laston = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			laston = con
					.prepareStatement ("SELECT * FROM userLaston WHERE userID=? LIMIT 1");
			laston.setInt (1, userRecord.getUserID ());
			if (laston.execute ()) {
				rs = laston.getResultSet ();
				if (rs.next ()) {
					final AbstractUser myUser = userRecord.myUser ();
					if (myUser instanceof GeneralUser) {
						try {
							((User) myUser).setLastActive (rs
									.getTimestamp ("timestamp"));
						} catch (final SQLException e) {
							((User) myUser)
									.setLastActive (new Timestamp (0));
						}
					}
					userRecord.setLastZoneName (rs
							.getString ("lastZoneName"));
				}
			}
		} finally {
			LibMisc.closeAll (rs, laston, con);
		}
	}

	/**
	 * Fetch the user's eMail info from the database record
	 * 
	 * @param userRecord The UserRecord being serviced
	 * @param resultSet database record to interpret
	 * @throws SQLException if the record can't be interpreted
	 */
	protected static void fetch_mailInfo (final UserRecord userRecord,
			final ResultSet resultSet) throws SQLException {
		userRecord.setMail (resultSet.getString ("mail"));
		if (resultSet.wasNull ()) {
			userRecord.setMail (null);
		}
		userRecord.setMailConfirmed (resultSet
				.getDate ("mailConfirmed"));
		if (resultSet.wasNull ()) {
			userRecord.setMailConfirmed (null);
		}
	}

	/**
	 * Fetch information about the user's parent (if any).
	 * 
	 * @param userRecord The UserRecord being serviced
	 * @param resultSet database record to interpret
	 * @throws SQLException if the record can't be interpreted
	 */
	protected static void fetch_parentInfo (
			final UserRecord userRecord, final ResultSet resultSet)
			throws SQLException {
		userRecord.setParentID (resultSet.getInt ("parentID"));
		if (resultSet.wasNull ()) {
			userRecord.setParentID ( -1);
		}
		userRecord.setApprovedDate (resultSet.getDate ("approvedDate"));
		if (resultSet.wasNull ()) {
			userRecord.setApprovedDate (null);
		}

		userRecord.setEmailPlusDate (resultSet
				.getDate ("emailPlusDate"));
		if (resultSet.wasNull ()) {
			userRecord.setEmailPlusDate (null);
		}
	}

	/**
	 * Fetch the password reset question and answer from the provided
	 * database record.
	 * 
	 * @param userRecord The UserRecord being serviced
	 * @param resultSet the database record
	 * @throws SQLException If the records can't be found, or are in an
	 *             invalid format of some kind
	 */
	protected static void fetch_passwordResetInfo (
			final UserRecord userRecord, final ResultSet resultSet)
			throws SQLException {

		String answer = resultSet.getString ("passRecoverA");
		if (resultSet.wasNull ()) {
			answer = null;
		}
		userRecord.setPasswordRecovery (resultSet
				.getString ("passRecoverQ"), answer);

	}

	/**
	 * Fetch the permissions-related portion of a user's record out of
	 * the SQL ResultSet. Used while populating the record from the
	 * database.
	 * 
	 * @param userRecord The UserRecord being serviced
	 * @param resultSet The ResultSet being used to set the user up.
	 * @throws SQLException if the data in the record can't be
	 *             interpreted.
	 */
	protected static void fetch_permissionsInfo (
			final UserRecord userRecord, final ResultSet resultSet)
			throws SQLException {
		userRecord.setCanTalk (resultSet.getString ("canTalk").equals (
				"Y"));
		userRecord.setCanEnterChatZone (resultSet.getString (
				"canEnterChatZone").equals ("Y"));
		userRecord.setCanEnterMenuZone (resultSet.getString (
				"canEnterMenuZone").equals ("Y"));
		userRecord.setGivenName (resultSet.getString ("givenName"));
		if (resultSet.wasNull ()) {
			userRecord.setGivenName (null);
		}

		try {
			userRecord.setKickedUntil (resultSet
					.getTimestamp ("kickedUntil"));
		} catch (final SQLException e) {
			userRecord.setKickedUntil (null);
		}
		if (resultSet.wasNull ()) {
			userRecord.setKickedUntil (null);
		}
		userRecord.setKickedReasonCode (resultSet
				.getString ("kickedReasonCode"));
		if (resultSet.wasNull ()) {
			userRecord.setKickedReasonCode (null);
		}
		userRecord.setKickedByUserID (resultSet.getInt ("kickedBy"));
		if (resultSet.wasNull ()) {
			userRecord.setKickedByUserID ( -1);
		}
		final String activity = resultSet.getString ("isActive");
		if ("CAN".equals (activity)) {
			userRecord.setActive (UserActiveState.CAN);
		} else if ("BAN".equals (activity)) {
			userRecord.setActive (UserActiveState.BAN);
		} else {
			userRecord.setActive (UserActiveState.OK);
		}
		userRecord.setCanBetaTest ("Y".equals (resultSet
				.getString ("canBetaTest")));
	}

	/**
	 * Fetch the user's basic information: user ID, user name, and
	 * password — from the provided database record
	 * 
	 * @param userRecord The UserRecord being serviced
	 * @param resultSet database record to interpret
	 * @throws SQLException if the record can't be interpreted
	 */
	protected static void fetch_userBasicInfo (
			final UserRecord userRecord, final ResultSet resultSet)
			throws SQLException {
		userRecord.setUserID (resultSet.getInt ("ID"));

		userRecord.setLogin (resultSet.getString ("userName"));
		if (resultSet.wasNull ()) {
			userRecord.setLogin (null);
		}

		userRecord.setPassword (resultSet.getString ("password"));

		try {
			userRecord.setRegisteredAt (resultSet
					.getTimestamp ("registeredAt"));
		} catch (final java.sql.SQLException e) {
			if (e.getMessage ().contains ("0000-00-00")) {
				Timestamp defaultTime;
				try {
					defaultTime = Timestamp
							.valueOf ("2007-01-01 12:00:00");
				} catch (final IllegalArgumentException e1) {
					throw AppiusClaudiusCaecus.fatalBug (e1);
				}
				userRecord.setRegisteredAt (defaultTime);
			} else {
				throw e;
			}
		}

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final UserRecord changedRecord) {
		synchronized (changedRecord) {
			DataRecordFlushManager.update (this, changedRecord);
		}
	}

	/**
	 * Fetch additional results fields from a database record — mostly
	 * intended to be overridden by derived classes
	 * 
	 * @param resultSet the user record
	 * @throws SQLException if the record can't be interpreted
	 */
	protected void fetch_more (final ResultSet resultSet)
			throws SQLException {
		// No op.
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}

	/**
	 * Initialize the database connection pool to be used for accessing
	 * user records. The “storageURL” parameter <em>is ignored</em>
	 * 
	 * @throws NotReadyException if the database can't be accessed
	 * @see org.starhope.appius.util.RecordLoader#initializeStorage(java.lang.String)
	 */
	@Override
	public void initializeStorage (final String storageURL)
			throws NotReadyException {
		// No op
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
	public UserRecord loadRecord (final int id) {
		System.err.println ("UserRecordSQLLoader::loadRecord(" + id
				+ ")");
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT * FROM users WHERE ID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			if (rs.next ()) {
				final UserRecord rec = set (rs);
				System.err
						.println ("-> loaded: " + rec.getDebugName ());
				return rec;
			} else {
				System.err.println ("-> no results from query");
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (
					"Database failed to find user ID=" + id, e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return null;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public UserRecord loadRecord (final String identifier) {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT * FROM users WHERE userName=?");
			st.setString (1, identifier);
			rs = st.executeQuery ();
			if (rs.next ()) {
				final UserRecord rec = set (rs);
				System.err
						.println ("-> loaded: " + rec.getDebugName ());
				return rec;
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus
					.reportBug ("Database failed to find userName="
							+ identifier, e);

		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		return null;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#refresh(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void refresh (final UserRecord record) {
		final int id = record.getUserID ();
		System.err.println ("UserRecordSQLLoader::refresh(" + id + ")");
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con
					.prepareStatement ("SELECT * FROM users WHERE ID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			if (rs.next ()) {
				record.markForReload ();
				reload (rs, record);
				System.err.println ("-> reloaded: "
						+ record.getDebugName ());
			} else {
				System.err.println ("-> no results from query");
			}
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (
					"Database failed to find user ID=" + id, e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param resultSet WRITEME
	 * @param userRecord WRITEME
	 * @return WRITEME
	 * @throws SQLException WRITEME
	 */
	protected UserRecord reload (final ResultSet resultSet,
			final UserRecord userRecord) throws SQLException {
		synchronized (userRecord) {
			userRecord.markForReload ();
			ConnectionDebug.dumpOpenConnections ();
			UserRecordSQLLoader.fetch_userBasicInfo (userRecord,
					resultSet);
			UserRecordSQLLoader
					.fetch_avatarInfo (userRecord, resultSet);
			ConnectionDebug.dumpOpenConnections ();
			UserRecordSQLLoader.fetch_mailInfo (userRecord, resultSet);
			UserRecordSQLLoader.fetch_dobInfo (userRecord, resultSet);
			UserRecordSQLLoader.fetch_language (userRecord, resultSet);
			UserRecordSQLLoader
					.fetch_parentInfo (userRecord, resultSet);
			UserRecordSQLLoader.fetch_passwordResetInfo (userRecord,
					resultSet);
			UserRecordSQLLoader.fetch_permissionsInfo (userRecord,
					resultSet);
			UserRecordSQLLoader.fetch_chatColours (userRecord,
					resultSet);
			ConnectionDebug.dumpOpenConnections ();

			userRecord.referer = resultSet.getString ("referer");
			if (resultSet.wasNull ()) {
				userRecord.referer = null;
			}

			userRecord.needsNaming = resultSet
					.getString ("needsNaming").equals ("Y");
			userRecord.staffLevel = resultSet.getInt ("staffLevel");
			userRecord.setCanContact (resultSet
					.getString ("canContact").equals ("Y"));

			try {
				userRecord.nameRequestedAt = resultSet
						.getTimestamp ("nameRequestedAt");
			} catch (final SQLException e) {
				userRecord.nameRequestedAt = null;
			}
			if (resultSet.wasNull ()) {
				userRecord.nameRequestedAt = null;
			}
			userRecord.requestedName = resultSet
					.getString ("requestedName");
			if (resultSet.wasNull ()) {
				userRecord.requestedName = null;
			}

			userRecord.setParentApprovedName ("Y".equals (resultSet
					.getString ("parentApprovedName")));
			userRecord.setLastZoneName (resultSet
					.getString ("lastZoneName"));

			// FIXME: hack to prevent TOO SLOW Toots.
			double travelRate = resultSet.getBigDecimal ("travelRate")
					.doubleValue ();
			if (travelRate < 32) {
				travelRate = 100;
			}

			userRecord.setTravelRate (travelRate);

			UserRecordSQLLoader.fetch_laston (userRecord);

			userRecord.markAsLoaded ();
			return userRecord;
		}
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final UserRecord record) {
		AppiusClaudiusCaecus
				.reportBug ("unimplemented RecordLoader<UserRecord>::removeRecord (brpocock@star-hope.org, Jul 22, 2010)");
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final UserRecord r) {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;

		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement (
					UserRecordSQLLoader.SAVE_RECORD_SQL,
					Statement.RETURN_GENERATED_KEYS);

			final int userID = r.getUserID ();
			if (userID <= 0) {
				st.setNull (1, Types.INTEGER);
			} else {
				st.setInt (1, userID);
			}

			final String login = r.getLogin ();
			if (null == login) {
				st.setNull (2, Types.VARCHAR);
			} else {
				st.setString (2, login);
			}
			st.setString (3, r.getPassword ());
			st.setInt (4, UserRecordSQLLoader.CLASS_ID_CURRENT);
			final String mail = r.getMail ();
			if (null == mail) {
				st.setNull (5, Types.VARCHAR);
			} else {
				st.setString (6, mail);
			}
			st.setString (5, mail);
			st.setInt (6, r.getAvatarClass ().getID ());
			st.setInt (7, r.getBaseColor ().toInt ());
			st.setInt (8, r.getExtraColor ().toInt ());
			st.setDate (9, r.getBirthDate ());
			switch (r.getAgeGroup ()) {
			case Adult:
				st.setString (10, "A");
				break;
			case Kid:
				st.setString (10, "K");
				break;
			case System:
				st.setString (10, "X");
				break;
			case Teen:
				st.setString (10, "T");
				break;
			default:
				AppiusClaudiusCaecus.fatalBug ("Unhandled age group");
			}
			st.setString (11, r.getLanguage ());
			st.setString (12, r.getDialect ());
			final int parentID = r.getParentID ();
			if (parentID <= 0) {
				st.setNull (13, Types.INTEGER);
			} else {
				st.setInt (13, parentID);
			}
			final Date approvedDate = r.getApprovedDate ();
			if (null == approvedDate) {
				st.setNull (14, Types.DATE);
			} else {
				st.setDate (14, approvedDate);
			}
			final Date emailPlusDate = r.getEmailPlusDate ();
			if (null == emailPlusDate) {
				st.setNull (15, Types.DATE);
			} else {
				st.setDate (15, emailPlusDate);
			}
			st.setString (16, r.canTalk () ? "Y" : "N");
			st.setString (17, r.canEnterChatZone () ? "Y" : "N");
			st.setString (18, r.canEnterMenuZone () ? "Y" : "N");
			st.setString (19, r.canBetaTest () ? "Y" : "N");
			final String givenName = r.getGivenName ();
			if (null == givenName) {
				st.setNull (20, Types.VARCHAR);
			} else {
				st.setString (20, givenName);
			}
			final Timestamp kickedUntil = r.getKickedUntil ();
			if (null == kickedUntil
					|| kickedUntil.compareTo (new Timestamp (System
							.currentTimeMillis ())) <= 0) {
				st.setNull (21, Types.TIMESTAMP);
			} else {
				st.setTimestamp (21, kickedUntil);
			}
			final String kickedReason = r.getKickedReasonCode ();
			if (null == kickedReason) {
				st.setNull (22, Types.VARCHAR);
			} else {
				st.setString (22, kickedReason);
			}
			final int kickedBy = r.getKickedByUserID ();
			if (kickedBy <= 0) {
				st.setNull (23, Types.INTEGER);
			} else {
				st.setInt (23, kickedBy);
			}
			st.setString (24, r.isActive () ? "OK"
					: r.isCanceled () ? "CAN" : r.isBanned () ? "BAN"
							: "ERR");
			st.setString (25, r.needsNaming () ? "Y" : "N");
			st.setBigDecimal (26, new BigDecimal (r.getStaffLevel ()));
			st.setString (27, r.isNotable () ? "Y" : "N");
			st.setString (28, r.canContact () ? "Y" : "N");
			final String requestedName = r.getRequestedName ();
			if (null == requestedName) {
				st.setNull (29, Types.VARCHAR);
			} else {
				st.setString (29, requestedName);
			}
			st.setString (30, r.getPasswordRecoveryQuestion ());
			final String answer = r.getPasswordRecoveryAnswer ();
			if (null == answer) {
				st.setNull (31, Types.VARCHAR);
			} else {
				st.setString (31, answer);
			}
			final Timestamp nameRequestedAt = r.getNameRequestedAt ();
			if (null == nameRequestedAt) {
				st.setNull (32, Types.TIMESTAMP);
			} else {
				st.setTimestamp (32, nameRequestedAt);
			}
			final Date mailConfirmed = r.getMailConfirmed ();
			if (null == mailConfirmed) {
				st.setNull (33, Types.DATE);
			} else {
				st.setDate (33, mailConfirmed);
			}
			final String referer = r.getReferer ();
			if (null == referer) {
				st.setNull (34, Types.VARCHAR);
			} else {
				st.setString (34, referer);
			}
			st.setTimestamp (35, r.getRegisteredAt ());
			st.setInt (36, r.getChatFG ().toInt ());
			st.setInt (37, r.getChatBG ().toInt ());
			st.setBigDecimal (38, BigDecimal.valueOf (r
					.getTravelRate ()));
			st.setString (39, r.isParentApprovedName () ? "Y" : "N");
			st.setString (40, r.getLastZoneName ());

			st.executeUpdate ();

			if (userID <= 0) {
				rs = st.getGeneratedKeys ();
				rs.next ();
				r.setUserID (rs.getInt (1));
			}
			r.markAsSaved ();

		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (
					"Database failed to insert or update "
							+ r.getDebugName (), e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}

	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return userRecord The UserRecord been loaded
	 * @param resultSet WRITEME
	 * @throws SQLException WRITEME
	 */
	protected UserRecord set (final ResultSet resultSet)
			throws SQLException {
		final UserRecord userRecord = new UserRecord (this);
		return reload (resultSet, userRecord);
	}

}
