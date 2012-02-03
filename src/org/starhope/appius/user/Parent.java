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
 * @author brpocock@star-hope.org,twheys@gmail.com
 */

package org.starhope.appius.user;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Locale;
import java.util.Vector;

import javax.naming.NamingException;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.DataException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.messaging.Mail;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.CastsToJSON;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.appius.via.Setter;
import org.starhope.util.LibMisc;

import biz.source_code.base64Coder.Base64Coder;

/**
 * This class represents the parent of a kid or teen account
 * 
 * @see User#getParent()
 * @author brpocock@star-hope.org
 * @author twheys@gmail.com
 */
public class Parent extends SimpleDataRecord <Parent> implements
AbstractPerson {
    /**
     * When showing the parent's name, how many children's names should
     * be displayed before we just start counting them?
     */
    private static final int MAX_KIDS_NAMES = 3;
    /**
     * Java serialisation unique ID
     */
    private static final long serialVersionUID = -793284706598303053L;

    /**
     * @param cookie the approval cookie uniquely identifying the
     *            desired Parent
     * @return the Parent uniquely identified by the given approval
     *         cookie
     * @throws NotFoundException if the cookie does not uniquely
     *             identify any Parent
     * @throws IOException if the contents of the approval cookie can't
     *             be decoded
     * @deprecated Use
     *             {@link Nomenclator#getParentByApprovalCookie(String)}
     *             instead
     */
    @Deprecated
    public static Parent getByApprovalCookie (final String cookie)
    throws NotFoundException, IOException {
        return Nomenclator.getParentByApprovalCookie (cookie);
    }

    /**
     * @param id database ID number
     * @return the relevant Parent record (if it exists), or null if
     *         not.
     * @deprecated Use {@link Nomenclator#getParentByID(int)} instead
     */
    @Deprecated
    public static Parent getByID (final int id) {
        return Nomenclator.getParentByID (id);
    }

    /**
     * @param mail The parent's eMail address
     * @return the relevant Parent record, or null if there is none
     * @deprecated Use {@link Nomenclator#getParentByMail(String)}
     *             instead
     */
    @Deprecated
    public static Parent getByMail (final String mail) {
        return Nomenclator.getParentByMail (mail);
    }

    /**
     * @param parentMail the mail address for the parent
     * @return a new parent record or existing one; never null.
     */
    public static Parent getOrCreateByMail (final String parentMail) {
        final Parent found = Nomenclator.getParentByMail (parentMail);
        if (null != found) {
            AppiusClaudiusCaecus.blather ("\n *** Found parent "
                    + found.getID () + " with e-mail "
                    + found.getMail ());
            return found;
        }
        try {
            final Parent newParent = new Parent (parentMail);
            AppiusClaudiusCaecus.blather ("\n *** Created parent "
                    + newParent.getID () + " with e-mail "
                    + newParent.getMail ());
            return newParent;
        } catch (final AlreadyExistsException e) {
            return Parent.getOrCreateByMail (parentMail);
        }
    }

    /**
     * consent to receive contact
     */
    private boolean canContact;
    /**
     * dialect of language
     */
    private String dialect;
    /**
     * password recovery question's answer
     */
    private String forgotPasswordAnswer;
    /**
     * password recovery question
     */
    private String forgotPasswordQuestion;
    /**
     * parent's given name (if known)
     */
    private String givenName;
    /**
     * Database ID value
     */
    private int id;
    /**
     * language
     */
    private String language;
    /**
     * email address
     */
    private String mail;
    /**
     * the date that the eMail address was confirmed
     */
    private Date mailConfirmed;
    /**
     * the date that the confirmation mail was sent
     */
    private Date mailConfirmSent;
    /**
     * password
     */
    private String password;

    /**
     * Create a blank parent record
     */
    public Parent () {
		super (Parent.class);
        canContact = false;
        dialect = "US";
        forgotPasswordAnswer = "2468";
        forgotPasswordQuestion = "What are the first four digits of the arctangent of the year you were born's square root?";
        givenName = null;
        id = -1;
        language = "en";
        mail = null;
        mailConfirmed = null;
        mailConfirmSent = null;
        password = "\07";
    }

	/**
	 * Create a new Parent record
	 * 
	 * @param parentMail the address of the parent
	 * @throws AlreadyExistsException if a parent record already exists
	 *             with the given eMail address
	 */
    public Parent (final String parentMail)
    throws AlreadyExistsException {
        this ();
        markAsLoaded ();
        try {
            setMail (parentMail);
        } catch (final GameLogicException e) {
            AppiusClaudiusCaecus.fatalBug ("impossible");
        }
        password = null;
        mailConfirmed = null;
        setMailConfirmSent (null);
        save ();
    }

	/**
	 * Create a new parent record and set an initial password at the
	 * same time
	 * 
	 * @param newMail mail address
	 * @param newPassword password
	 * @throws AlreadyExistsException if the user has an existing
	 *             account, and they know the password
	 * @throws PrivilegeRequiredException if the mail exists, but the
	 *             password is wrong
	 */
    public Parent (final String newMail, final String newPassword)
    throws PrivilegeRequiredException, AlreadyExistsException {
		super (Parent.class);
        Parent p;
        p = Nomenclator.getParentByMail (newMail);
        if (null != p) {
            if (p.getPassword ().equals (newPassword)) {
                throw new AlreadyExistsException (newMail);
            }
            throw new PrivilegeRequiredException ("password");
        }
        try {
            setMail (newMail);
        } catch (final GameLogicException e) {
            AppiusClaudiusCaecus.fatalBug (e);
        }
        setPassword (newPassword);
        insert ();
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#canContact()
     */
    @Override
    public boolean canContact () {
        return canContact;
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#checkPassword(java.lang.String)
     */
    @Override
    public boolean checkPassword (final String passwordGuess) {
        return password.equals (passwordGuess);
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#forgotPassword(java.lang.String,
     *      java.lang.String)
     */
    @Override
    public boolean forgotPassword (final String forgottenPasswordQ,
            final String forgottenPasswordA) {
        return Person.forgotPassword (this, forgottenPasswordQ,
                forgottenPasswordA);
    }

    /**
     * @return get an approval cookie which can be used to uniquely
     *         identify this Parent
     */
    @Override
    public String getApprovalCookie () {
        return Base64Coder.encodeString (id + "/" + mail);
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
    public String getCacheableIdent () throws NotFoundException {
        return mail;
    }

    /**
     * @return all children associated with this parent
     */
    public User [] getChildren () {
        final HashSet <AbstractUser> kids = new HashSet <AbstractUser> ();
        Connection con = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            con = AppiusConfig.getDatabaseConnection ();
            st = con.prepareStatement ("SELECT ID FROM users WHERE parentID=? ORDER BY ID");

            st.setInt (1, getID ());
            if (st.execute ()) {
                rs = st.getResultSet ();
                final Vector <Integer> kidIDs = new Vector <Integer> ();
                while (rs.next ()) {
                    kidIDs.add (Integer.valueOf (rs.getInt (1)));
                }
                final Iterator <Integer> kidNum = kidIDs.iterator ();
                while (kidNum.hasNext ()) {
                    kids.add (Nomenclator.getUserByID (kidNum.next ()
                            .intValue ()));
                }
            }
        } catch (final SQLException e) {
            AppiusClaudiusCaecus.reportBug (e);
        } finally {
            LibMisc.closeAll (rs, st, con);
        }
        final User kidsArray[] = kids.toArray (new User [kids.size ()]);
        try {
            Arrays.sort (kidsArray);
        } catch (final Exception e) {
            // don't sort if it fails — just return the array as-is ...
        }

        return kidsArray;
    }

	/**
	 * Get the name of the template file to be used to confirm accounts
	 * of this type.
	 * 
	 * @see org.starhope.appius.user.AbstractPerson#getConfirmationTemplate()
	 */
    @Override
    public String getConfirmationTemplate () {
        return "ParentConfirmation";
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#getDialect()
     */
    @Override
    public String getDialect () {
        return dialect;
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#getDisplayName()
     */
    @Override
    public String getDisplayName () {
        if (null != givenName) {
            return givenName;
        }
        final User [] children = getChildren ();
        if (null == children || children.length == 0) {
            // no op
        } else if (children.length > 1) {
            final LinkedList <String> childrensNames = new LinkedList <String> ();
            int count = 0;
            for (final User child : children) {
                if (count++ < Parent.MAX_KIDS_NAMES) {
                    childrensNames.add (child.getDisplayName ());
                } else {
                    break;
                }
            }
            final int moreKids = children.length
            - Parent.MAX_KIDS_NAMES;
            String tag;
            if (moreKids == 1) {
                tag = "one other."; // XXX i18n
                childrensNames.add (tag);
            } else if (moreKids > 1) {
                tag = moreKids + " others."; // XXX i18n
                childrensNames.add (tag);
            }

            return "Parent of "
            + LibMisc.listToDisplay (childrensNames,
                    getLanguage (), getDialect ());
        } else {
            return "Parent of " + children [0].getDisplayName ();
        }

        if (null != mail) {
            return "<" + mail + ">";
        }
        return "Parent";
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#getForgotPasswordAnswer()
     */
    @Override
    public String getForgotPasswordAnswer () {
        return forgotPasswordAnswer;
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#getForgotPasswordQuestion()
     */
    @Override
    public String getForgotPasswordQuestion () {
        return forgotPasswordQuestion;
    }

    /**
     * @return all children without a membership associated with this
     *         parent
     */
    public GeneralUser [] getFreeChildren () {
        final User [] allChildren = getChildren ();
        final Vector <User> freeChildren = new Vector <User> ();
        for (final User child : allChildren) {
            if ( !child.isPaidMember ()) {
                freeChildren.add (child);
            }
        }
        return freeChildren.toArray (new User [] {});
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#getGivenName()
     */
    @Override
    public String getGivenName () {
        return givenName;
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#getHistory(java.sql.Date,
     *      int)
     */
    @Override
    public HashMap <Timestamp, HashMap <String, String>> getHistory (
            final Date after, final int limit) {
        // TODO Auto-generated method stub
        return null;
    }

	/**
	 * Return the parent record's database ID
	 * 
	 * @return the parent ID
	 */
    public int getID () {
        return id;
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#getLanguage()
     */
    @Override
    public String getLanguage () {
        return language;
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#getMail()
     */
    @Override
    public String getMail () {
        return mail;
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#getMailConfirmed()
     */
    @Override
    public Date getMailConfirmed () {
        return mailConfirmed;
    }

    /**
     * @return the mailConfirmSent
     */
    public Date getMailConfirmSent () {
        return mailConfirmSent;
    }

	/**
	 * Get the given name of the parent
	 * 
	 * @return the parent's given name
	 */
    public String getName () {
        return givenName;
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#getPassword()
     */
    @Override
    public String getPassword () {
        return password;
    }

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.user.AbstractPerson#getPotentialUserName()
	 */
    @Override
    public String getPotentialUserName () {
        return getMail ();
    }

	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.user.AbstractPerson#getResponsibleMail()
	 */
    @Override
    public String getResponsibleMail () {
        return mail;
    }

    /**
     * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
     */
    @Override
    public String getSubversionRevision () {
        return "$Rev: 2188 $";
    }

    /**
     * @return true, if this parent has any child account that is banned
     */
    public boolean hasBannedKids () {
        for (final GeneralUser child : getChildren ()) {
            if (child.isBanned ()) {
                return true;
            }
        }
        return false;
    }

	/**
	 * Insert a new parent record into the database, saving the parent
	 * eMail address and password.
	 * 
	 * @throws AlreadyExistsException if the record already exists
	 */
    private void insert () throws AlreadyExistsException {
        Connection con = null;
        PreparedStatement st = null;
        try {
            con = AppiusConfig.getDatabaseConnection ();
            st = con.prepareStatement (
                    "INSERT INTO parents (mail, password) VALUES (?, ?)",
                    Statement.RETURN_GENERATED_KEYS);
            st.setString (1, mail);
            if (null == password) {
                st.setNull (2, java.sql.Types.VARCHAR);
            } else {
                st.setString (2, password);
            }
            st.execute ();
            final ResultSet newID = st.getGeneratedKeys ();
            newID.next ();
            id = newID.getInt (1);
        } catch (final SQLException e) {
            if (e.getMessage ().toLowerCase (Locale.ENGLISH)
                    .contains ("duplicate")) {
                throw new AlreadyExistsException (e.getMessage ());
            }
            throw AppiusClaudiusCaecus.fatalBug (e);
        } finally {
            if (null != st) {
                try {
                    st.close ();
                } catch (final SQLException e) { /* No Op */
                }
            }
            if (null != con) {
                try {
                    con.close ();
                } catch (final SQLException e) { /* No Op */
                }
            }
        }
    }

    /**
     * @return true, if the account has been registered (has a real
     *         password)
     */
    public boolean isRegistered () {
        return null != password && !password.equals ("\n")
        && !password.equals ("");
    }

    /**
     * assert that the mail
     */
    public void mailIsConfirmed () {
        mailConfirmed = new Date (System.currentTimeMillis ());
    }

	/**
	 * This is an overriding method. If any of this parent's children
	 * are staff members, resets their passwords as well as the parent
	 * account password and sends a flurry of reminder mails.
	 * 
	 * @see org.starhope.appius.user.AbstractPerson#remindPassword()
	 */
    @Override
	public void remindPassword () {
        for (final User kid : getChildren ()) {
            if (kid.hasStaffLevel (1)) {
                kid.setPassword (Person.generateNewPassword ());
				try {
					kid.remindPassword ();
				} catch (NotReadyException e) {
					AppiusClaudiusCaecus.reportBug (e);
				}
				setPassword (Person.generateNewPassword ());
            }
        }
		try {
			Person.remindPassword (this);
		} catch (NotReadyException e) {
			AppiusClaudiusCaecus.reportBug (e);
		}
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#rename(java.lang.String)
     */
    @Override
    public void rename (final String newName)
    throws GameLogicException, AlreadyUsedException,
    ForbiddenUserException {
        if ( !newName.equals (mail)) {
            final Parent existing = Nomenclator
            .getParentByMail (newName);
            if (null != existing) {
                throw new AlreadyUsedException (
                        "Parent e-mail already in use",
                        existing.getMailConfirmSent ());
            }
            mail = newName;
            changed ();
        }
    }

    /**
     * @param user send a notification for the given child user, to
     *            request parental approval
     */
    public void requestApproval (final User user) {
        sendNotificationForChild (user);
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#sendConfirmationMail()
     */
    @Override
    public void sendConfirmationMail () {
        Person.sendConfirmationMail (this);
    }

	/**
	 * <p>
	 * Send a notification to the parent that their child has registered
	 * an account, giving instructions on how to approve the account.
	 * </p>
	 * 
	 * @param sessionUser the user who is a child of this parent
	 */
    public void sendNotificationForChild (final User sessionUser) {
        for (final GeneralUser child : getChildren ()) {
            if (child.getUserID () == sessionUser.getUserID ()) {
                if ( !sessionUser.isApproved ()) {
                    try {
                        Mail.sendChildSignupMail (sessionUser);
                        return;
                    } catch (final FileNotFoundException e) {
                        AppiusClaudiusCaecus
                        .reportBug (
                                "Can't find parent notification template file!",
                                e);
                    } catch (final IOException e) {
                        AppiusClaudiusCaecus.reportBug (
                                "Can't send parent notification mail",
                                e);
                    } catch (final NotFoundException e) {
                        AppiusClaudiusCaecus.reportBug (e);
                    } catch (final DataException e) {
                        AppiusClaudiusCaecus.reportBug (e);
                    } catch (final NamingException e) {
                        AppiusClaudiusCaecus
                        .reportBug (
                                "Can't look up domain name for parent notification mail, DNS failure?",
                                e);
                    }
                }
            }
        }
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#sendStaffPasswordReset()
     */
    @Override
    public void sendStaffPasswordReset () {
        Person.sendStaffPasswordReset (this);
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#sentConfirmationMail()
     */
    @Override
    public void sentConfirmationMail () {
        mailConfirmSent = new Date (System.currentTimeMillis ());
        changed ();
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#setCanContact(boolean)
     */
    @Override
    public void setCanContact (final boolean canContact1) {
        canContact = canContact1;
        changed ();
    }

    /**
     * @param newDialect the dialect to set
     */
	@Setter (getter = "getDialect")
    public void setDialect (final String newDialect) {
        dialect = newDialect;
        changed ();
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#setForgotPasswordAnswer(java.lang.String)
     */
    @Override
	@Setter (getter = "getForgotPasswordAnswer")
    public void setForgotPasswordAnswer (final String answer) {
        forgotPasswordAnswer = answer;
        changed ();
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#setForgotPasswordQuestion(java.lang.String)
     */
    @Override
	@Setter (getter = "getForgotPasswordQuestion")
    public void setForgotPasswordQuestion (final String question) {
        forgotPasswordQuestion = question;
        changed ();

    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#setGivenName(java.lang.String)
     */
    @Override
	@Setter (getter = "getGivenName")
    public void setGivenName (final String givenName1) {
        givenName = givenName1;
        changed ();

    }

    /**
     * @param int1 new id
     */
	@Setter (getter = "getID")
    public void setID (final int int1) {
        id = int1;
    }

    /**
     * @param newLanguage the language to set
     */
	@Setter (getter = "getLanguage")
    public void setLanguage (final String newLanguage) {
        language = newLanguage;
        changed ();
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#setMail(java.lang.String)
     */
    @Override
	@Setter (getter = "getMail")
    public void setMail (final String mail1) throws GameLogicException {
        if (null != mail) {
            try {
                rename (mail1);
            } catch (final AlreadyUsedException e) {
                throw new GameLogicException ("already used", e, this);
            } catch (final ForbiddenUserException e) {
                throw new GameLogicException ("forbidden user", e, this);
            }
            return;
        }
        mail = mail1;
        changed ();
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#setMailConfirmed(java.sql.Date)
     */
    @Override
	@Setter (getter = "getMailConfirmed")
    public void setMailConfirmed (final Date mailConfirmed1) {
        mailConfirmed = mailConfirmed1;
        changed ();
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#setMailConfirmSent(java.sql.Date)
     */
    @Override
	@Setter (getter = "getMailConfirmSent")
    public void setMailConfirmSent (final Date date) {
        mailConfirmSent = date;
        changed ();
    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#setPassword(java.lang.String)
     */
    @Override
	@Setter (getter = "getPassword")
    public void setPassword (final String password1) {
        password = password1;
        changed ();

    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#setPasswordAndPasswordRecovery(java.lang.String,
     *      java.lang.String, java.lang.String)
     */
    @Override
    public void setPasswordAndPasswordRecovery (final String question,
            final String answer, final String newPassword)
    throws GameLogicException {
        setPassword (newPassword);
        setPasswordRecovery (question, answer);

    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#setPasswordRecovery(java.lang.String,
     *      java.lang.String)
     */
    @Override
    public void setPasswordRecovery (
            final String newForgottenPasswordQuestion,
            final String newForgottenPasswordAnswer) {
        forgotPasswordQuestion = newForgottenPasswordQuestion;
        forgotPasswordAnswer = newForgottenPasswordAnswer;
        changed ();

    }

    /**
     * @see org.starhope.appius.user.AbstractPerson#setRandomPassword()
     */
    @Override
    public String setRandomPassword () {
        final String newPass = Person.generateNewPassword ();
        setPassword (newPass);
        return newPass;
    }

	/**
	 * This is an overriding method.
	 * 
	 * @return JSON form of the parent (basically just the mail address)
	 * @see CastsToJSON#toJSON()
	 */
    public JSONObject toJSON () {
        final JSONObject self = new JSONObject ();
        try {
            self.put ("mail", getMail ());
        } catch (final JSONException e) {
            AppiusClaudiusCaecus.reportBug (e);
        }
        return self;
    }

	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#toString()
	 */
	@Override
	public String toString () {
		StringBuilder s = new StringBuilder ();
		s.append ("Parent ");
		s.append (getDisplayName ());
		s.append (" <");
		s.append (getMail ());
		s.append (">=#");
		s.append (getID ());
		return s.toString ();
	}

}
