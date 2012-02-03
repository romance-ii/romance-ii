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

package org.starhope.appius.user;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NonSufficientFundsException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.ParameterException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Channel;
import org.starhope.appius.game.Commands;
import org.starhope.appius.game.DamageTypeRanks;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.RoomListener;
import org.starhope.appius.game.Zone;
import org.starhope.appius.game.inventory.GenericItemReference;
import org.starhope.appius.game.inventory.Inventory;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.game.npc.Ejecta;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.sys.admin.Security;
import org.starhope.appius.sys.admin.SecurityCapability;
import org.starhope.appius.types.AgeBracket;
import org.starhope.appius.types.Colour;
import org.starhope.appius.types.HasVariables;
import org.starhope.appius.util.AppiusConfig;

/**
 * <p>
 * Any “thing” that exists in the game world and participates therein
 * should implement the AbstractUser interface. This interface provides
 * the “physicality” (no, that's not a word) necessary for something to
 * participate in the game rooms.
 * </p>
 * <p>
 * AbstractUser, along with {@link Room} and {@link Zone}, are the three
 * main classes that are used to describe the game world. (
 * {@link AppiusClaudiusCaecus} and {@link AppiusConfig} are also major
 * ingredients, however.)
 * </p>
 * <p>
 * Pretty much everything in the Appius game server hangs off of these
 * few classes.
 * </p>
 * <p>
 * The AbstractUser provides a messaging interface for users (players),
 * non-player characters, and also moving “animate” objects in the
 * world, like {@link Ejecta} (which include projectiles, particles, and
 * the like).
 * </p>
 * <p>
 * Users have delegate objects which describe them more fully, such as
 * enrolments (subscriptions), inventory, buddy lists, and avatar
 * classes.
 * </p>
 * <p>
 * A user always exists in exactly one room. To “hide” from the game,
 * the user can enter into a Limbo room; typically, each zone has a room
 * named “nowhere” for that purpose.
 * </p>
 * <h2>User Variables</h2>
 * <p>
 * A user also has a hash map of string-string user variables associated
 * with it. These variables are used to portray important information to
 * connected game clients, and often reflect server-side status
 * information. For example, users who should not be interacted with as
 * though they were normal characters/players in the game will have
 * “noClick” set to “true”.
 * </p>
 * <p>
 * Certain user variables are defined for all Appian clients and
 * implementations. In general, any user variables in ALL CAPS are
 * reserved for implementors' own use, and the core server will not
 * interfere with such variables.
 * </p>
 * <h3>Stock User Variables</h3>
 * <p>
 * Implementors are free to pick and choose from among the following for
 * their own purposes, but the Appius server may set — and may expect to
 * be honoured, to various degrees — the following variables.
 * </p>
 * <dl>
 * <dt>d</dt>
 * <dd>The <em>directional vector</em> of the user.
 * <p>
 * This was used exclusively in Appius 1.0 for player placement and
 * movement. <strong>Note</strong> that this has been superseded by the
 * more flexible {@link Commands#do_go(JSONObject, AbstractUser, Room)}
 * “go do” system.
 * </p>
 * <p>
 * The directional vector data is split on the character “~” into the
 * following series of fields:
 * </p>
 * <div> startX ~ startY ~ endX ~ endY ~ facing ~ startTime ~ travelRate
 * </div>
 * <ul>
 * <li>(startX,startY) are the coördinates at which the user began their
 * curent transit</li>
 * <li>(endX,endY) are the coördinates toward which the user was/is
 * moving</li>
 * <li>facing is one of “N,” “NE,” “E,” “SE,” “S,” “SW,” “W,” or “NW”
 * and indicates the general direction in which the avatar should appear
 * to be facing.</li>
 * <li>startTime is the time (in milliseconds since epoch) at which the
 * avatar should (have) begin (begun) their transit. startTime will
 * generally be in the past, but can be projected a brief time into the
 * future to allow for client-synchronisation. See discussion at
 * {@link Room#getLag()}</li>
 * <li>travelRate is the avatar's transit rate in coördinate units
 * (generally pixels) per second.</li>
 * </ul>
 * <p>
 * It must be noted that the avatar's position along the directional
 * vector specified by “d” can be the start (not yet moving), the end
 * (already completed), or any point along the line segment connecting
 * them. It is the responsibility of the client application to properly
 * compute the current position of the avatar.
 * </p>
 * </dd>
 * <dt>noClick</dt>
 * <dd>If “true,” the avatar should not be treated as a normal
 * player-character and subject to things like examination,
 * conversation, buddy lists, and the like. This is, for example, used
 * by projectiles.</dd>
 * <dt>ejecta</dt>
 * <dd>If “true,” this user is a transient effect ({@link Ejecta})
 * ejecta object, such as a projectile or a simple animated effect (puff
 * of smoke, &c.) The client may wish to treat it differently in user
 * interface operations.</dd>
 * <dt>notable</dt>
 * <dd>If “true,” the user is a notable character of some specific value
 * in the game. The client may wish to provide some special presentation
 * of the user, e.g. boldfacing their nametag.</dd>
 * </dl>
 * 
 * @author brpocock@star-hope.org
 */
public interface AbstractUser extends RoomListener, /*
													 * XXX: change to
													 * ChannelListener
													 */
Comparable <Object>, HasVariables, Serializable,
DataRecordBacked <UserRecord>
{
    /**
     * @param command The command which produced the error
     * @param error The error code
     * @param result The additional JSON data describing the error
     * @param userCurrentRoomInZone The room in which the user was
     *        standing when the error occurred.
     */
    public void acceptErrorReply (String command, String error,
            JSONObject result, Room userCurrentRoomInZone);

	/**
	 * Accept an administrative/moderator message with the full range of
	 * options. If the user is currently online, forward this message to
	 * them.
	 * 
	 * @param content The contents of the message
	 * @param title The title of the message
	 * @param label A label which nominally identifies the source of the
	 *            message
	 */
    public void acceptMessage (String title, String label,
            String content);

	/**
	 * Accept a private message from another user (a whisper)
	 * 
	 * @param speaker the person whispering
	 * @param speech what was whispered
	 */
    public void acceptPrivateMessage (AbstractUser speaker,
            String speech);

    /**
     * @param room WRITEME
     * @param command WRITEME
     * @param jsonData WRITEME
     */
    public void acceptSuccessReply (String command,
            JSONObject jsonData, Room room);

    /**
     * @param buddy WRITEME
     */
    public void addBuddy (AbstractUser buddy);

    /**
     * @param months WRITEME
     * @param days WRITEME
     */
    public void addGiftSubscription (int months, int days);

    /**
     * @param itemID the item ID to be instantiated and added
     */
    public void addItem (int itemID);

    /**
     * WRITEME: Document this method brpocock@star-hope.org
     */
    public void assertLocationUnlocked ();

	/**
	 * x-deprecated use
	 * {@link Security#hasCapability(AbstractUser, SecurityCapability)}
	 * for new code
	 * 
	 * @param staffLevelStaffMember WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 */
    // @Deprecated
    public void assertStaffLevel (int staffLevelStaffMember)
    throws PrivilegeRequiredException;

    /**
     * @param byLogin WRITEME
     */
    public void attend (AbstractUser byLogin);

    /**
     * @param u WRITEME
     * @param banReason WRITEME
     * @throws PrivilegeRequiredException WRITEME
     */
    public void ban (AbstractUser u, String banReason)
    throws PrivilegeRequiredException;

    /**
     * @return WRITEME
     */
    public boolean canTalk ();

    /**
     * WRITEME
     */
    public void doffClothes ();

    /**
     * WRITEME
     */
    public void doTransport ();

    /**
     * @return WRITEME
     */
    public int getAge ();

	/**
	 * Get the user's age bracket. Note that system (robot) users will
	 * have the special age bracket type {@link AgeBracket#System}.
	 * 
	 * @see AgeBracket
	 * @return the age bracket of the user
	 */
    public AgeBracket getAgeGroup ();

    /**
     * @return WRITEME
     */
    public String getApprovedDateString ();

    /**
     * @return WRITEME
     */
    public AvatarClass getAvatarClass ();

	/**
	 * The avatar label is the text block that is displayed with the
	 * avatar for this object. It should be unique but isn't guaranteed
	 * to be distinct as user names are. (At any given moment, there can
	 * be only one object with a given avatar label in the room, but
	 * there can be only one user with a given name in the multiverse.)
	 * For users, this is the user name.
	 * 
	 * @return The avatar label
	 */
    public String getAvatarLabel ();

    /**
     * @return base colour
     */
    public Colour getBaseColor ();

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 11,
	 * 2010)
	 * 
	 * @return WRITEME
	 */
    public Collection <String> getBuddyListNames ();

	/**
	 * Normally “Walk” but can be any action that the client recognizes
	 * for the avatar type
	 * 
	 * @return the currentAction
	 */
    public String getCurrentAction ();

	/**
	 * Get a version of the user's ID and name suitable for use in
	 * debugging dumps. The format is: “LOGIN” #ID — e.g. "“Pil” #2".
	 * Note the use of typographically correct quotation marks
	 * 
	 * @return A string with the user's login string and user ID number,
	 *         formatted for debugging output
	 */
    public String getDebugName ();

    /**
     * @return WRITEME
     */
    public String getDialect ();

    /**
     * @return WRITEME
     */
    public String getDisplayName ();

    /**
     * @return extra colour
     */
    public Colour getExtraColor ();

	/**
	 * Get the string identifying the direction which this object is
	 * facing. One of: N,S,E,W,NE,NW,SW,SE.
	 * 
	 * @return The facing direction of this object
	 */
    public String getFacing ();

	/**
	 * Height in pixels. This is used as a scaling-factor for the avatar
	 * file; it's assumed that other dimensions of the avatar will be
	 * scaled proportionally
	 * 
	 * @return height in pixels
	 */
    public double getHeight ();

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Feb 19,
	 * 2010)
	 * 
	 * @return WRITEME
	 */
    public Inventory getInventory ();

    /**
     * @return WRITEME
     */
    public String getIPAddress ();

    /**
     * @return WRITEME
     */
    public int getKickedByUserID ();

    /**
     * @return WRITEME
     */
    public String getKickedMessage ();

    /**
     * @return WRITEME
     */
    public String getKickedReasonCode ();

    /**
     * @return WRITEME
     */
    public Timestamp getKickedUntil ();

    /**
     * @return round-trip lag time
     */
    public long getLag ();

    /**
     * @return WRITEME
     */
    public String getLanguage ();

	/**
	 * Gets the current start coördinates
	 * 
	 * @return the location at which the user was located at
	 *         {@link #getTravelStart()}
	 */
    public Coord3D getLocation ();

	/**
	 * Gets the current coördinates. Performs an update to ensure that
	 * they are “current” as of “now.” Also
	 * <em>blocks on this method</em> if anyone else is trying to do the
	 * same thing. <em>After calling this method,</em> you <em>must</em>
	 * call {@link #unlockLocation()} to free up other threads' ability
	 * to position this {@link AbstractUser}.
	 * 
	 * @return the current coördinates of the user
	 */
    public Coord3D getLocationForUpdate ();

    /**
     * @return WRITEME
     */
    public String getMail ();

	/**
	 * To be deprecated in favour of {@link #getWallet()}
	 * 
	 * @param currency units
	 * @return amount
	 * @deprecated {@link #getWallet()}, {@link Wallet#get(Currency)}
	 */
    @Deprecated
	public BigInteger getMoney (Currency currency);

    /**
     * @return WRITEME
     */
    public Date getNameApprovedAt ();

    /**
     * @return WRITEME
     */
    public Date getNameRequestedAt ();

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return the pathfinder object
	 */
    public PathFinder getPathFinder ();

	/**
	 * <p>
	 * Returned packet contains:
	 * </p>
	 * <ul>
	 * <li>"avatar": FILENAME,</li>
	 * <li>"avatarClass": ID#,</li>
	 * <li>chatFG: foreground colour (RGB int),</li>
	 * <li>chatBG: background colour (RGB int),</li>
	 * <li>"avatarClass_B": avatar class's default base colour,</li>
	 * <li>"avatarClass_E": avatar class's default extra colour,</li>
	 * <li>"avatarClass_P": avatar class's default pattern colour,</li>
	 * <li>"inRoom": room moniker (if in a room),</li>
	 * <li>"userName": avatar label (user visible name),</li>
	 * <li>"colors": { ... array of colour filters to be applied to the
	 * avatar file itself ... },</li>
	 * <li>"clothes": { ... array of clothing items ... },</li>
	 * <li>"gameItem": game equipped item ID (carrying object),</li>
	 * <li>"vars": { ... user variables, including "d" or "s" ... }</li>
	 * </ul>
	 * 
	 * @return WRITEME
	 */
    JSONObject getPublicInfo ();

    /**
     * @return WRITEME
     */
    public String getRegisteredDateString ();

    /**
     * @return WRITEME
     */
    public String getResponsibleMail ();

	/**
	 * @return the user's current room
	 */
	public Room getRoom ();

    /**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 11,
	 * 2010)
	 *
	 * @return WRITEME
	 */
    public int getRoomNumber ();

	/**
     * @return WRITEME
     */
    public ServerThread getServerThread ();

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return scalar
	 */
    public double getSizeScalar ();

    /**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 11,
	 * 2010)
	 *
	 * @return WRITEME
	 */
    public int getStaffLevel ();

	/**
     * @return the time at which the user intentionally moved last
     */
    long getStartT ();

	/**
	 * Gets the current target
	 *
	 * @return the target toward which the user is moving
	 */
    public Coord3D getTarget ();

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 24,
	 * 2009)
	 *
	 * @return WRITEME
	 */
    public double getTravelRate ();

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 24,
	 * 2009)
	 *
	 * @return the time at which the object started moving (msec since
	 *         epoch)
	 */
    public long getTravelStart ();

	/**
	 * Get the user ID number for this user
	 *
	 * @return An unique user ID
	 */
    public int getUserID ();
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param moniker WRITEME
	 * @return WRITEME
	 * @throws ParameterException
	 */
	public Iterator <String> getUserListIterator (String moniker)
			throws ParameterException;

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 11,
	 * 2010)
	 *
	 * @return WRITEME
	 */
    public Map <String, String> getUserVariables ();

    /**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 31,
	 * 2009)
	 *
	 * @param string WRITEME
	 * @return WRITEME
	 */
    @Override
    public String getVariable (String string);

	/**
     * @return the user's wallet (currency inventory)
     */
    Wallet getWallet ();

    /**
	 * @return the user's current zone
	 */
	public Zone getZone ();

	/**
	 * Called from pathfinders and rooms when the user tries to go
	 * someplace and can't get there, to allow them to plot a course
	 * around obstacles.
	 *
	 * @param room the destination room
	 * @param to the destination coördinates
	 * @return the coördinates in the current room toward which the user
	 *         should proceed
	 */
    public Coord3D handleWalkFail (Room room, Coord3D to);

    /**
     * @param i WRITEME
     * @return WRITEME deprecated to be replaced with
     *         {@link Security#hasCapability(AbstractUser,SecurityCapability)}
     */
    public boolean hasStaffLevel (int i);

    /**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 30,
	 * 2009)
	 *
	 * @param string WRITEME
	 * @return WRITEME
	 */
    public boolean hasVariable (String string);

    /**
     * @param byLogin WRITEME
     */
    public void ignore (AbstractUser byLogin);

    /**
     * @return WRITEME
     */
    public boolean isBanned ();

	/**
     * @return WRITEME
     */
    public boolean isCanceled ();

	/**
     * @return WRITEME
     */
    public boolean isKicked ();

    /**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 31,
	 * 2009)
	 *
	 * @return WRITEME
	 */
    boolean isNPC ();

    /**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 31,
	 * 2009)
	 *
	 * @return WRITEME
	 */
    boolean isOnline ();

	/**
     * @return WRITEME
     */
    public boolean isPaidMember ();

	/**
     * @param u WRITEME
     * @param kickReason WRITEME
     * @param duration WRITEME
     * @throws PrivilegeRequiredException WRITEME
     */
    public void kick (AbstractUser u, String kickReason, int duration)
    throws PrivilegeRequiredException;

	/**
	 * remove a ban placed upon this user
	 *
	 * @param authority WRITEME
	 * @throws PrivilegeRequiredException WRITEME
	 */
    public void liftBan (AbstractUser authority)
    throws PrivilegeRequiredException;

    /**
	 * Identify whether this account is owned by a child (per COPPA
	 * age-13 rules), and if it needs a parent account associated with
	 * it to give permission to play the game.
	 *
	 * @return true, if this user needs a parent account associated with
	 *         it per COPPA
	 */
    public boolean needsParent ();

    /**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param itemToBuy WRITEME
	 * @throws NonSufficientFundsException WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws AlreadyExistsException WRITEME
	 */
    public void purchase (GenericItemReference itemToBuy)
    throws NonSufficientFundsException, NotFoundException,
    AlreadyExistsException;

    /**
     * @param byLogin WRITEME
     */
    public void removeBuddy (AbstractUser byLogin);

	/**
     * @param u WRITEME
     */
    public void reportedToModeratorBy (AbstractUser u);

	/**
     * @param u WRITEME
     * @param reason WRITEME
     */
    public void reportedToModeratorBy (AbstractUser u, String reason);

	/**
	 * Sends a buddy list JSON packet
	 *
	 * @param whichList the name of the user list. Special names are
	 *            “$buddy” or “$ignore”
	 * @param users the users on that list
	 */
    public void sendBuddyList (final String whichList,
			final List <String> users);

    /**
	 * Send an “earnings” message to let the user know s/he earned/lost
	 * currency
	 *
	 * @param room the room in which the earnings occurred
	 * @param cu the currency units
	 * @param amount the amount of currency earned/lost
	 */
	void sendEarnings (Room room, Currency cu, BigDecimal amount);

    /**
	 * Send an “earnings” message to let the user know s/he earned an
	 * item
	 *
	 * @param room the room in which the item was earned
	 * @param item the item earned (the instance in the user's
	 *            inventory)
	 */
	void sendEarnings (Room room, InventoryItem item);

    /**
     * @param room WRITEME
     * @param string WRITEME
     */
    public void sendEarnings (Room room, String string);

    /**
     * WRITEME: document this method (brpocock@star-hope.org, Jan 11,
     * 2010)
     *
     * @param refugeeZone WRITEME
     * @throws UserDeadException WRITEME
     */
	public void sendMigrate (Zone refugeeZone)
    throws UserDeadException;

    /**
     * WRITEME
     */
    public void sendOops ();
	
	/**
	 * @param result WRITEME
	 * @deprecated Use sendResponse (AbstractDatagram datagram)
	 */
    @Deprecated
    public void sendResponse (JSONObject result);
	
	/**
	 * Sends a datagram
	 * 
	 * @param datagram The datagram to send
	 */
	public void sendResponse (AbstractDatagram datagram);
	
	/**
	 * WRITEME
	 */
    public void sendWardrobe ();

    /**
     * WRITEME
     */
    public void setAgeGroupToSystem ();

    /**
     * WRITEME
     *
     * @param colour WRITEME
     */
    public void setBaseColor (Colour colour);

    /**
     * WRITEME
     *
     * @param b WRITEME
     */
    public void setCanTalk (boolean b);

    /**
     * Normally “Walk” but can be any action that the client recognizes
     * for the avatar type
     *
     * @param newAction the currentAction to set
     */
    public void setCurrentAction (String newAction);

    /**
     * @param colour WRITEME
     */
    public void setExtraColor (Colour colour);

    /**
     * @param newFacing the new facing direction
     */
    public void setFacing (String newFacing);

    /**
     * WRITEME
     */
    public void setLastActive ();

    /**
     * @param coord3d new 3D coordinates
     */
    public void setLocation (Coord3D coord3d);

    /**
     * WRITEME
     *
     * @param email WRITEME
     * @throws GameLogicException WRITEME
     */
    public void setMail (String email) throws GameLogicException;

    /**
     * If this is a child account (per COPPA), then associate a parent
     * record with it. Affiliated with Parent class and
     * {@link #needsParent()}
     *
     * @param newParent the new parent record to associate with this
     *        user
     * @throws ForbiddenUserException if the parent is not allowed to
     *         register/associate new child accounts (usually due to
     *         having other child accounts which are banned)
     * @throws GameLogicException if this user account does not need a
     *         parent record (adult account or system/robot account)
     * @throws AlreadyExistsException if the parent account has the
     *         maximum allowed children.
     */
    public void setParent (Parent newParent)
    throws GameLogicException, ForbiddenUserException,
    AlreadyExistsException;

    /**
     * @param room WRITEME
     * @return WRITEME
     */
    public int setRoom (Room room);

    /**
     * set the time at which the player started moving — not necessarily
     * the same as {@link #getTravelStart()} because that value is
     * updated over time, this value is when they actually started
     * moving along the path altogether
     *
     * @param when the time at which the user last made a conscious
     *        change in their movement
     */
    public void setStartT (long when);

    /**
     * Sets the target coordinates for movement
     *
     * @param coord3d the new target
     */
    public void setTarget (Coord3D coord3d);

    /**
     * WRITEME: document this method (brpocock@star-hope.org, Nov 24,
     * 2009)
     *
     * @param rate WRITEME
     */
    public void setTravelRate (double rate);

    /**
     * WRITEME: Document this method brpocock@star-hope.org
     *
     * @param l WRITEME
     */
    public void setTravelStart (long l);

    /**
     * @param varName the user variable name
     * @param varValue the user variable value
     */
    @Override
    public void setVariable (String varName, String varValue);
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param zone
	 */
	public void setZone (Zone zone);
	
	/**
	 * @param room the room in which to speak. Typically, the user must
	 *            be present in that room.
	 * @param string the speech (or emote)
	 */
    public void speak (Room room, String string);
	
	/**
	 * @param chan the channel in which to speak. Typically, the user
	 *            must be present in that channel.
	 * @param string the speech (or emote)
	 */
	public void speak (Channel chan, String string);
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param attack WRITEME
	 * @return WRITEME
	 */
    public boolean takeAttack (final DamageTypeRanks attack);

	/**
     * @return a JavaScript Object representing this user
     */
    public JSONObject toJSON ();

	/**
     * @return a string representing Smart Fox Server Pro style of XML
     *         data
     */
    public String toSFSXML ();

	/**
	 * Unlock an user's location, locked by a call to
	 * {@link #getLocationForUpdate()} (q.v.)
	 */
	public void unlockLocation ();

	/**
     * review your current wallet currency amounts, they may have
     * changed
     */
    public void updateWallet ();
}
