/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
package org.starhope.appius.user;

import java.lang.ref.WeakReference;
import java.sql.Timestamp;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.ParameterException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Channel;
import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.game.DamageTypeRanks;
import org.starhope.appius.game.GameRoom;
import org.starhope.appius.game.GameStateFlag;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.RoomChannel;
import org.starhope.appius.game.RoomListener;
import org.starhope.appius.game.SFX;
import org.starhope.appius.game.Zone;
import org.starhope.appius.game.inventory.Inventory;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.game.inventory.UserInventory;
import org.starhope.appius.geometry.Circle;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.geometry.PolygonPrimitive;
import org.starhope.appius.geometry.Vector2D;
import org.starhope.appius.geometry.Vector3D;
import org.starhope.appius.messaging.AbstractCensor;
import org.starhope.appius.net.datagram.ADPSpeak;
import org.starhope.appius.net.datagram.ADPUserAction;
import org.starhope.appius.net.datagram.ADPUserInfo;
import org.starhope.appius.net.datagram.ADPUserList;
import org.starhope.appius.net.datagram.ADPUserSFX;
import org.starhope.appius.net.datagram.ADPUserVar;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.physica.Collidable;
import org.starhope.appius.sys.admin.Security;
import org.starhope.appius.sys.admin.SecurityCapability;
import org.starhope.appius.sys.op.FilterResult;
import org.starhope.appius.sys.op.FilterStatus;
import org.starhope.appius.types.AgeBracket;
import org.starhope.appius.types.FilterType;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.WeakRecord;
import org.starhope.appius.via.Setter;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public abstract class GeneralUser implements AbstractUser, Collidable {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 6267186342664921052L;
	
	/**
	 * Inherent basic defenses
	 */
	DamageTypeRanks baseDefenses = new DamageTypeRanks ();
	
	/**
	 * The user's base stats
	 */
	protected final Map <UserStat, Integer> baseStats = new ConcurrentHashMap <UserStat, Integer> ();
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private double baseTravelRate = Double.NaN;
	
	/**
	 * List of users being ignored
	 */
	private final transient HashSet <String> buddyList = new HashSet <String> ();
	
	/**
	 * Word censor engine
	 */
	protected AbstractCensor censor = null;
	
	/**
	 * Collision boundaries for an unknown thing or other
	 */
	public PolygonPrimitive <?> collisionBounds = new Circle (0, -10,
			20);
	
	/**
	 * The action or movement currently being performed by the NPC.
	 * Usually “Walk” or “idle” but can be any verb understood by the
	 * client/avatar combination, e.g. “mosey”
	 */
	private String currentAction;
	
	/**
	 * The current room in which the user is active. This can be null.
	 */
	protected transient Room currentRoom = null;
	
	/**
	 * The direction in which the user is facing. Must be one of: N S E
	 * W NE NW SW SE
	 */
	protected String facing = "SE";
	
	/**
	 * List of users being ignored
	 */
	private final transient HashSet <String> ignoreList = new HashSet <String> ();
	
	/**
	 * Weak reference to the inventory for this user
	 */
	private WeakReference <UserInventory> inventory = new WeakReference <UserInventory> (
			null);
	
	/**
	 * the last time that the user intentionally started moving.
	 */
	protected long lastUserMovement;
	
	/**
	 * Current coördinates for the user (as of {@link #travelStartTime}
	 * )
	 */
	Coord3D location = new Coord3D (0, 0, 0);
	
	/**
	 * Destination coördinates towards which the user is currently
	 * moving; May be identical to {@link #location}
	 */
	Coord3D target = location;
	/**
	 * The time at which the user started moving on their current
	 * movement vector. Measured in milliseconds since epoch.
	 */
	long travelStartTime;
	
	/**
	 * The userID of the user attached to this record
	 */
	private int userID;
	
	/**
	 * The user record backing this user
	 */
	private WeakReference <UserRecord> userRecord;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final List <WeakRecord <SFX>> userSFX = Collections
			.synchronizedList (new LinkedList <WeakRecord <SFX>> ());
	
	/**
	 * Arbitrary user variables which can be set or retrieved by the
	 * front-end
	 */
	final WeakRecord <UserVar> userVariables;
	
	/**
	 * Convenience weak reference to the wallet object associated with
	 * this user
	 */
	private WeakReference <Wallet> wallet = new WeakReference <Wallet> (
			null);
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	protected Zone zone;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public GeneralUser () {
		userRecord = new WeakReference <UserRecord> (null);
		userVariables = null;
		censor = AppiusConfig.getFilter (FilterType.KID_CHAT);
	}
	
	/**
	 * @param newRecord the user data record backing this user
	 * @throws NotFoundException if the record is null
	 */
	public GeneralUser (final UserRecord newRecord)
			throws NotFoundException {
		if (null == newRecord) {
			throw new NotFoundException (
					"Mysterious null userrecord in GeneralUser constructor");
		}
		userRecord = new WeakReference <UserRecord> (newRecord);
		userID = newRecord.getUserID ();
		userVariables = new WeakRecord <UserVar> (UserVar.class,
				userID);
		censor = AppiusConfig.getFilter (FilterType.KID_CHAT);
	}
	
	/**
	 * @see org.starhope.appius.game.ChannelListener#acceptDatagram(org.starhope.appius.net.datagram.AbstractDatagram)
	 */
	@Override
	public void acceptDatagram (final AbstractDatagram datagram) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptGameAction(org.starhope.appius.user.AbstractUser,
	 *      org.json.JSONObject)
	 */
	@Override
	public void acceptGameAction (final AbstractUser u,
			final JSONObject action) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptGameStateChange(org.starhope.appius.game.GameRoom,
	 *      org.starhope.appius.game.GameStateFlag)
	 */
	@Override
	public void acceptGameStateChange (final GameRoom gameCode,
			final GameStateFlag gameState) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptObjectJoinRoom(org.starhope.appius.game.Room,
	 *      org.starhope.appius.game.RoomListener)
	 */
	@Override
	public void acceptObjectJoinChannel (final RoomChannel channel,
			final RoomListener object) {
		// no op in base class
		
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptObjectPartRoom(org.starhope.appius.game.Room,
	 *      org.starhope.appius.game.RoomListener)
	 */
	@Override
	public void acceptObjectPartChannel (final RoomChannel channel,
			final RoomListener thing) {
		// no op in base class
		
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptOutOfBandMessage(org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.Room, org.json.JSONObject)
	 */
	@Override
	public void acceptOutOfBandMessage (final AbstractUser sender,
			final RoomChannel channel, final JSONObject body) {
		// no op in base class
		
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.RoomChannel, java.lang.String)
	 */
	@Override
	public void acceptPublicMessage (final AbstractUser sender,
			final RoomChannel room, final String message) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	@Override
	public void acceptPublicMessage (final AbstractUser from,
			final String message) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptUserAction(org.starhope.appius.game.Room,
	 *      org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void acceptUserAction (final RoomChannel r,
			final AbstractUser u) {
		// no op in base class
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptUserVariableUpdate(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String, java.lang.String)
	 */
	@Override
	public void acceptUserVariableUpdate (final AbstractUser user,
			final String varName, final String varValue) {
		// no op in base class
		
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#addBuddy(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void addBuddy (final AbstractUser buddy) {
		buddyList.add (buddy.getAvatarLabel ());
		getSQLUserListIterator ("$buddy").add (buddy);
	}
	
	/**
	 * Attend to an user who may previously have been ignored
	 * 
	 * @param interestingFellow the user to whom to now attend
	 */
	@Override
	public void attend (final AbstractUser interestingFellow) {
		ignoreList.remove (interestingFellow);
		getSQLUserListIterator ("$ignore").remove (interestingFellow);
	}
	
	/**
	 * If the user is a teen (13+) or adult, they are allowed to
	 * approve their own account. This is a boolean test for that fact.
	 * 
	 * @return true, if the user is permitted to approve their own
	 *         account (via their own eMail address). False, if they
	 *         require parent approval.
	 */
	public boolean canApproveSelf () {
		return getUserRecord ().canApproveSelf ();
	}
	
	/**
	 * @return true, if the user is permitted to log in to a beta test
	 *         server
	 */
	public boolean canBetaTest () {
		return getUserRecord ().canBetaTest () || hasStaffLevel (1);
	}
	
	/**
	 * @return WRITEME
	 */
	public boolean canEnterChatZone () {
		return getUserRecord ().canEnterChatZone ();
	}
	
	/**
	 * @return the canEnterMenuZone
	 */
	public boolean canEnterMenuZone () {
		return getUserRecord ().canEnterMenuZone ();
	}
	
	/**
	 * @param alteration amount(s) to alter base defenses
	 * @return copy of new base defenses
	 */
	public DamageTypeRanks changeBaseDefenses (
			final DamageTypeRanks alteration) {
		return baseDefenses.add (alteration);
	}
	
	/**
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo (final Object o) {
		if (null == o) {
			return 1;
		}
		if (o instanceof AbstractUser) {
			return getDebugName ().compareTo (
					((AbstractUser) o).getDebugName ());
		}
		return o.toString ().compareTo (getDebugName ());
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param sfx WRITEME 
	 */
	@Override
	public void deleteSFX (final SFX sfx) {
		final WeakRecord <SFX> newsfx = new WeakRecord <SFX> (
				SFX.class, sfx.getMoniker ());
		if (userSFX.contains (newsfx)) {
			userSFX.remove (newsfx);
			final ADPUserSFX adpUserSFX = new ADPUserSFX (this);
			adpUserSFX.deleteSFX (sfx);
			adpUserSFX.setUser (this);
			if (currentRoom != null) {
				currentRoom.getRoomChannel ()
						.broadcast (adpUserSFX);
			} else {
				acceptDatagram (adpUserSFX);
			}
		}
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.types.HasVariables#deleteVariable(java.lang.String)
	 */
	@Override
	public void deleteVariable (final String key) {
		userVariables.get ().deleteVariable (key);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#doffClothes()
	 */
	@Override
	public void doffClothes () {
		final Inventory inventory = getInventory ();
		for (final InventoryItem i : inventory.getActiveClothing ()) {
			inventory.doff (i);
		}
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if ( ! (obj instanceof GeneralUser)) {
			return false;
		}
		return compareTo (obj) == 0;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getAge()
	 */
	@Override
	public int getAge () {
		return 100;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getAgeGroup()
	 */
	@Override
	public AgeBracket getAgeGroup () {
		return AgeBracket.System;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getApprovedDateString()
	 */
	@Override
	public String getApprovedDateString () {
		final java.sql.Date approvedDate = getUserRecord ()
				.getApprovedDate ();
		if (null == approvedDate) {
			return "(not approved)";
		}
		return approvedDate.toString ();
	}
	
	/**
	 * @return base (innate) defense values
	 */
	public DamageTypeRanks getBaseDefenses () {
		return baseDefenses;
	}
	
	/**
	 * get a base stat (before any modifiers for items or transient
	 * effects are applied)
	 * 
	 * @param stat stat
	 * @return the value of that stat
	 */
	public int getBaseStat (final UserStat stat) {
		return baseStats.get (stat).intValue ();
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#getCenterOfMass()
	 */
	@Override
	public Coord2D getCenterOfMass () {
		return getLocation ().toCoord2D ();
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#getCollisionBounds()
	 */
	@Override
	public PolygonPrimitive <?> getCollisionBounds () {
		return collisionBounds.scale (getSizeScalar ()).translate (
				getLocation ().toCoord2D ());
	}
	
	/**
	 * Normally “Walk” but can be any action that the client recognises
	 * for the avatar type
	 * 
	 * @return the currentAction
	 */
	@Override
	public String getCurrentAction () {
		return currentAction;
	}
	
	/**
	 * Get the archaïc “d” variable
	 * 
	 * @return x~y~tX~tY~facing~started
	 */
	protected String getD () {
		final StringBuilder loc = new StringBuilder ();
		loc.append ((int) location.getX ());
		loc.append ('~');
		loc.append ((int) location.getY ());
		loc.append ('~');
		loc.append ((int) target.getX ());
		loc.append ('~');
		loc.append ((int) target.getY ());
		loc.append ('~');
		loc.append (facing);
		loc.append ('~');
		loc.append (travelStartTime);
		return loc.toString ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getDatagram(org.starhope.appius.game.ChannelListener)
	 */
	@Override
	public ADPUserInfo getDatagram (final ChannelListener s) {
		final ADPUserInfo result = new ADPUserInfo (s);
		final UserRecord ur = getUserRecord ();
		result.setUser (this);
		result.setAvatarClass (getAvatarClass ());
		result.setHeight (getHeight ());
		if (ur != null) {
			result.setChatForeground (getUserRecord ().getChatFG ()
					.toLong ());
			result.setChatBackground (getUserRecord ().getChatBG ()
					.toLong ());
			result.setEquipment (getInventory ()
					.getEquipmentDatagram (s));
		}
		if (currentRoom != null) {
			result.setRoom (currentRoom);
		}
		result.setAction (getUserActionDatagram (s));
		
		if ( (s == this) && (ur != null)) {
			result.setWallet (getWallet ());
			result.setPaid (getUserRecord ().isPaidMember ());
			if (getUserRecord ().getStaffLevel () > 0) {
				result.setStaffLevel (getUserRecord ()
						.getStaffLevel ());
			}
			result.setCanTalk (getUserRecord ().canTalk ());
		}
		if (s == this) {
			result.setPowers (getInventory ().getPowersDatagram (s));
		}
		result.setUserVars (getVariables ());
		result.setSFX (getUserSFXDatagram (s));
		return result;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getDialect()
	 */
	@Override
	public String getDialect () {
		return getUserRecord ().getDialect ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getDisplayName()
	 */
	@Override
	public String getDisplayName () {
		return getUserRecord ().getLogin ();
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#getEndMovementTime(long)
	 */
	@Override
	public long getEndMovementTime (final long currentTime) {
		return Math.round ( (new Vector3D (getLocation (),
				getTarget ()).length () / getTravelRate ()) * 1000)
				+ currentTime;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getFacing()
	 */
	@Override
	public String getFacing () {
		return facing;
	}
	
	/**
	 * @see AbstractUser#getHeight()
	 * @return the user's height in pixels
	 */
	@Override
	public double getHeight () {
		double result = getAvatarClass ().getHeight ();
		final String roomScalarString = null != currentRoom ? currentRoom
				.getVariable ("scale") : null;
		if ( (null != roomScalarString)
				&& (roomScalarString.length () > 0)) {
			try {
				result *= Double.parseDouble (roomScalarString);
			} catch (final NumberFormatException e) {
				// no op
			}
		}
		final double scalar = getInventory ().getHeightScalar ()
				+ UserPowerKeeper.instance ()
						.getHeightScalar (this);
		result += result
				* (scalar < 0 ? - (1 - (1 / (1 - scalar))) : scalar);
		
		return result;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getInventory()
	 */
	@Override
	public Inventory getInventory () {
		UserInventory result = inventory.get ();
		if (result == null) {
			try {
				inventory = new WeakReference <UserInventory> (
						Nomenclator.getDataRecord (
								UserInventory.class, userID));
			} catch (final NotFoundException e) {
				BugReporter.getReporter ("srv").reportBug (
						"Exception", e);
			}
			result = inventory.get ();
		}
		return result;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getKickedByUserID()
	 */
	@Override
	public int getKickedByUserID () {
		return getUserRecord ().getKickedByUserID ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getKickedReasonCode()
	 */
	@Override
	public String getKickedReasonCode () {
		return getUserRecord ().getKickedReasonCode ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getKickedUntil()
	 */
	@Override
	public Timestamp getKickedUntil () {
		return getUserRecord ().getKickedUntil ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getLocation()
	 */
	@Override
	public Coord3D getLocation () {
		return location;
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#getMass()
	 */
	@Override
	public double getMass () {
		return 1000.0d;
	}
	
	/**
	 * @return the registeredAt
	 */
	public Timestamp getRegisteredAt () {
		return getUserRecord ().getRegisteredAt ();
	}
	
	/**
	 * @return the date on which this user first registered
	 * @see UserRecord#getRegisteredDate()
	 */
	public java.util.Date getRegisteredDate () {
		return getUserRecord ().getRegisteredDate ();
	}
	
	/**
	 * @see #getRegisteredDate()
	 * @return Returns an user-visible string describing when the user
	 *         was registered
	 */
	@Override
	public String getRegisteredDateString () {
		return getUserRecord ().getRegisteredDateString ();
	}
	
	/**
	 * @return the name that the user requested
	 */
	public String getRequestedName () {
		return getUserRecord ().getRequestedName ();
	}
	
	/**
	 * <p>
	 * Get the eMail address of a responsible person: either the
	 * player, or the parent.
	 * </p>
	 * <p>
	 * Currently, kids 13-17 return their own mail.
	 * </p>
	 * 
	 * @return the eMail address
	 */
	@Override
	public String getResponsibleMail () {
		return getUserRecord ().getResponsibleMail ();
	}
	
	/**
	 * @return The room in which the user currently exists. This might
	 *         potentially be null.
	 */
	@Override
	public Room getRoom () {
		return currentRoom;
	}
	
	/**
	 * @return the number of the user's current room; or -1 if the user
	 *         isn't in any room
	 */
	@Override
	public int getRoomNumber () {
		if (null == currentRoom) {
			return -1;
		}
		return currentRoom.getID ();
	}
	
	/**
	 * @return the effective scalar for sizes and things
	 */
	@Override
	public double getSizeScalar () {
		return getHeight () / getAvatarClass ().getHeight ();
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param moniker usually either $buddy or $ignore
	 * @return an iterator to fetch the user list
	 */
	protected UserListIterator getSQLUserListIterator (
			final String moniker) {
		return Nomenclator.getDataRecordIterator (
				UserListIterator.class, this, moniker);
	}
	
	/**
	 * @return the staffLevel
	 */
	@Override
	public int getStaffLevel () {
		return getUserRecord ().getStaffLevel ();
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#getStartMovementTime()
	 */
	@Override
	public long getStartMovementTime () {
		return getStartT ();
	}
	
	/**
	 * @return the time at which the user last actually started moving
	 */
	@Override
	public long getStartT () {
		return lastUserMovement;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getTarget()
	 */
	@Override
	public Coord3D getTarget () {
		return target;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.user.AbstractUser#getTravelRate()
	 */
	@Override
	public double getTravelRate () {
		double travelRate = Double.isNaN (baseTravelRate) ? getAvatarClass ()
				.getBaseSpeed () : baseTravelRate;
		final double scalar = getInventory ().getSpeedScalar ()
				+ UserPowerKeeper.instance ().getSpeedScalar (this);
		travelRate += travelRate
				* (scalar < 0 ? - (1 - (1 / (1 - scalar))) : scalar);
		
		return travelRate;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.user.AbstractUser#getTravelStart()
	 */
	@Override
	public long getTravelStart () {
		return travelStartTime;
	}
	
	/**
	 * Gets the datagram describing the user's action state
	 * 
	 * @param s WRITEME 
	 * @return WRITEME 
	 */
	@Override
	public ADPUserAction getUserActionDatagram (final ChannelListener s) {
		final ADPUserAction result = new ADPUserAction (s);
		result.setUser (this);
		result.setAction (currentAction);
		result.setLocation (location.toCoord2D ());
		result.setFacing (getFacing ());
		if (location.distance (target) > 1) {
			result.setDestination (target.toCoord2D ());
			result.setRate (getTravelRate ());
			result.setStart (getTravelStart ());
		}
		return result;
	}
	
	/**
	 * @return the userID
	 */
	@Override
	public int getUserID () {
		return userID;
	}
	
	/**
	 * @throws ParameterException
	 * @see org.starhope.appius.user.AbstractUser#getUserListIterator(java.lang.String)
	 */
	@Override
	public Iterator <String> getUserListIterator (final String moniker)
			throws ParameterException {
		if (moniker == "$buddy") {
			return buddyList.iterator ();
		} else if (moniker == "$ignore") {
			return ignoreList.iterator ();
		}
		throw new ParameterException ("Unknown user list type: "
				+ moniker);
	}
	
	/**
	 * @return the user's login
	 */
	public String getUserName () {
		return getUserRecord ().getLogin ();
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	protected UserRecord getUserRecord () {
		UserRecord result = userRecord.get ();
		if (result == null) {
			try {
				userRecord = new WeakReference <UserRecord> (
						Nomenclator.getDataRecord (
								UserRecord.class, userID));
			} catch (final NotFoundException e) {
				GeneralUser.log.error ("Exception", e);
			}
			result = userRecord.get ();
		}
		return result;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getUserSFXDatagram(org.starhope.appius.game.ChannelListener)
	 */
	@Override
	public ADPUserSFX getUserSFXDatagram (final ChannelListener s) {
		final ADPUserSFX result = new ADPUserSFX (s);
		synchronized (userSFX) {
			for (final WeakRecord <SFX> wsfx : userSFX) {
				final SFX sfx = wsfx.get ();
				if (sfx != null) {
					result.addSFX (sfx);
				}
			}
		}
		return result;
	}
	
	/**
	 * Get the value of a given variable by name.
	 * 
	 * @param string Variable key
	 * @return Value of the named variable
	 */
	@Override
	public String getVariable (final String string) {
		return userVariables.get ().getVariable (string);
	}
	
	/**
	 * Get all user variables in a hash map
	 * 
	 * @return A hashmap containing all user variables
	 */
	@Override
	public Map <String, String> getVariables () {
		final HashMap <String, String> ret = new HashMap <String, String> ();
		ret.putAll (userVariables.get ().getVariables ());
		return ret;
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#getVelocity()
	 */
	@Override
	public Vector2D getVelocity () {
		final Coord3D from = getLocation ();
		final Coord3D to = getTarget ();
		Vector2D midVector2d = new Vector2D (to.getX ()
				- from.getX (), to.getY () - from.getY ());
		if (midVector2d.length () > 0) {
			midVector2d = midVector2d.normalize ();
		}
		midVector2d = midVector2d.scale (getTravelRate ());
		return midVector2d;
	}
	
	/**
	 * @return the user's wallet (currency inventory)
	 */
	@Override
	public Wallet getWallet () {
		Wallet result = wallet.get ();
		if (result == null) {
			try {
				wallet = new WeakReference <Wallet> (
						Nomenclator.getDataRecord (Wallet.class,
								userID));
			} catch (final NotFoundException e) {
				GeneralUser.log.error ("Exception", e);
			}
			result = wallet.get ();
		}
		return result;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getZone()
	 */
	@Override
	public Zone getZone () {
		return zone;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#handleWalkFail(org.starhope.appius.game.Room,
	 *      org.starhope.appius.geometry.Coord3D)
	 */
	@Override
	public Coord3D handleWalkFail (final Room room, final Coord3D to) {
		return room.goTo_clipToWalkSpace (this, to);
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getDebugName ());
	}
	
	/**
	 * Returns true if the user has the asserted staff level, or a
	 * staff level which includes it. Returns false, otherwise.
	 * 
	 * @param staffLevelNeeded The minimum staff level for which we are
	 *             testing.
	 * @return True, if the user meets the minimum staff level stated;
	 *         false, otherwise. * @deprecated use
	 *         {@link Security#hasCapability(AbstractUser, org.starhope.appius.sys.admin.SecurityCapability)}
	 */
	@Override
	@Deprecated
	public boolean hasStaffLevel (final int staffLevelNeeded) {
		return getUserRecord ().hasStaffLevel (staffLevelNeeded);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#hasVariable(java.lang.String)
	 */
	@Override
	public boolean hasVariable (final String string) {
		return userVariables.get ().exists (string);
	}
	
	/**
	 * Calling this method indicates that this user wants to ignore the
	 * other specified user.
	 * 
	 * @param boringFellow The user, whom this user wishes to ignore
	 */
	@Override
	public void ignore (final AbstractUser boringFellow) {
		ignoreList.add (boringFellow.getAvatarLabel ());
		getSQLUserListIterator ("$ignore").add (boringFellow);
	}
	
	/**
	 * @param speaker the person who might be getting ignored
	 * @return true, if we're ignoring them
	 */
	public boolean ignoring (final AbstractUser speaker) {
		return ignoreList.contains (speaker.getAvatarLabel ());
	}
	
	/**
	 * @return true, if this is an active user account (able to sign
	 *         in, potentially)
	 */
	public boolean isActive () {
		return getUserRecord ().isActive ();
	}
	
	/**
	 * @see UserRecord#isApproved()
	 * @return true, if this account has been approved, and is still
	 *         active
	 */
	public boolean isApproved () {
		return getUserRecord ().isApproved ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#isBanned()
	 */
	@Override
	public boolean isBanned () {
		return getUserRecord ().isBanned ();
	}
	
	/**
	 * Determines if someone is your buddy or not
	 * 
	 * @param user WRITEME 
	 * @return WRITEME 
	 */
	public boolean isBuddy (final AbstractUser user) {
		return buddyList.contains (user.getAvatarLabel ());
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#isCanceled()
	 */
	@Override
	public boolean isCanceled () {
		return getUserRecord ().isCanceled ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#isKicked()
	 */
	@Override
	public boolean isKicked () {
		return getUserRecord ().isKicked ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#isPaidMember()
	 */
	@Override
	public boolean isPaidMember () {
		return getUserRecord ().isPaidMember ();
	}
	
	/**
	 * Run initialize the user
	 */
	public void loggedIn () {
		if (ignoreList.size () == 0) {
			final Iterator <UserListEntry> i = getSQLUserListIterator ("$ignore");
			while (i.hasNext ()) {
				ignoreList.add (i.next ().getLogin ());
			}
		}
		if (buddyList.size () == 0) {
			final Iterator <UserListEntry> i = getSQLUserListIterator ("$buddy");
			while (i.hasNext ()) {
				buddyList.add (i.next ().getLogin ());
			}
		}
		GeneralUser.log.info ("{} has logged in", getAvatarLabel ());
	}
	
	/**
	 * Kid accounts (under 13) require parental confirmation. In order
	 * to get that, we have to get a parental contact. If this field is
	 * false, then the user is either a teenager or adult, or they have
	 * a parent on file. It does <em>not</em> mean that they have had
	 * their account approved: only that they have given us the
	 * parental information (if we needed it). If we ever encounter a
	 * user for whom this flag is true, ask them “who's your daddy?”
	 * 
	 * @return true, if this is a kid account without a known parent
	 *         (yet)
	 */
	@Override
	public boolean needsParent () {
		return getUserRecord ().needsParent ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#removeBuddy(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void removeBuddy (final AbstractUser byLogin) {
		buddyList.remove (byLogin);
		getSQLUserListIterator ("$buddy").remove (byLogin);
	}
	
	/**
	 * @see org.starhope.appius.types.HasVariables#resetVariables(java.util.Map)
	 */
	@Override
	@Setter (getter = "getVariables")
	public void resetVariables (final Map <String, String> map) {
		userVariables.get ().resetVariables (map);
		setVariables (map);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param whichList the list name
	 * @param users users on that list
	 */
	@Override
	public void sendBuddyList (final String whichList,
			final List <String> users) {
		final ADPUserList adpUserList = new ADPUserList (this,
				whichList);
		for (final String name : users) {
			adpUserList.add (name);
			final AbstractUser user = Nomenclator
					.getOnlineUserByLogin (name);
			if (null != user) {
				final boolean online = user.isOnline ();
				adpUserList.setOnline (name, online);
				if ( !"ignore".equals (whichList)
						&& (user.getZone () != null) && online) {
					adpUserList.setZone (name, user.getZone ()
							.getName ());
				}
			} else {
				adpUserList.setOnline (name, false);
			}
		}
		sendResponse (adpUserList);
		
		// final JSONObject jsonList = new JSONObject ();
		// try {
		// jsonList.put ("list", whichList);
		// final JSONObject userList = new JSONObject ();
		// for (final AbstractUser entry : users) {
		// final JSONObject userInfo = new JSONObject ();
		// final boolean online = entry.isOnline ();
		// userInfo.put ("online", online);
		// if (online && !"$ignore".equals (whichList)) {
		// userInfo.put ("inZone", entry.getZone ());
		// }
		// userList.put (entry.getAvatarLabel (), userInfo);
		// }
		// jsonList.put ("users", userList);
		// acceptSuccessReply ("userList", jsonList, null);
		// } catch (final JSONException e) {
		// log.error (
		// "Caught a JSONException in Clodia.sendList ", e);
		// }
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setAgeGroupToSystem()
	 */
	@Override
	public void setAgeGroupToSystem () {
		getUserRecord ().setAgeGroup (AgeBracket.System);
	}
	
	/**
	 * @see org.starhope.appius.user.DataRecordBacked#setBackingRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void setBackingRecord (final UserRecord rec) {
		userRecord = new WeakReference <UserRecord> (rec);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setCanTalk(boolean)
	 */
	@Setter (getter = "canTalk")
	@Override
	public void setCanTalk (final boolean b) {
		getUserRecord ().setCanTalk (b);
	}
	
	/**
	 * @see org.starhope.appius.physica.Collidable#setCenterOfMass(Coord2D)
	 */
	@Override
	public void setCenterOfMass (final Coord2D com) {
		final Room aRoom = getRoom ();
		if (null != aRoom) {
			final Room room = aRoom;
			final Coord3D destination = getTarget ();
			room.putHere (this, com.toCoord3D ());
			room.goTo (this, destination, null, "Walk");
			room.notifyUserAction (this);
		}
	}
	
	/**
	 * Normally “Walk” but can be any action that the client recognizes
	 * for the avatar type
	 * 
	 * @param newAction the currentAction to set
	 */
	@Override
	@Setter (getter = "getCurrentAction")
	public void setCurrentAction (final String newAction) {
		currentAction = newAction;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setFacing(java.lang.String)
	 */
	@Override
	@Setter (getter = "getFacing")
	public void setFacing (final String newFacing) {
		facing = newFacing;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setLocation(org.starhope.appius.geometry.Coord3D)
	 */
	@Override
	@Setter (getter = "getLocation")
	public void setLocation (final Coord3D coord3d) {
		location = coord3d;
	}
	
	/**
	 * Set the user's current room to the given room. This will part
	 * from the prior room, if the user was in a room already. It also
	 * sets the user variable “d” to (-100,-100) coördinates.
	 * 
	 * @param room the room in which the user must exist
	 * @return the room number set
	 */
	@Override
	@Setter (getter = "getRoom")
	public int setRoom (final Room room) {
		currentRoom = room;
		return room == null ? -1 : room.getID ();
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param sfx WRITEME 
	 */
	@Override
	public void setSFX (final SFX sfx) {
		final WeakRecord <SFX> newsfx = new WeakRecord <SFX> (
				SFX.class, sfx.getMoniker ());
		if ( !userSFX.contains (newsfx)) {
			userSFX.add (newsfx);
			final ADPUserSFX adpUserSFX = new ADPUserSFX (this);
			adpUserSFX.addSFX (sfx);
			adpUserSFX.setUser (this);
			if (currentRoom != null) {
				currentRoom.getRoomChannel ()
						.broadcast (adpUserSFX);
			} else {
				acceptDatagram (adpUserSFX);
			}
		}
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setStartT(long)
	 */
	@Override
	@Setter (getter = "getStartT")
	public void setStartT (final long when) {
		lastUserMovement = when;
	}
	
	/**
	 * Sets the new target coördinates
	 * 
	 * @param newTarget target coördinates
	 */
	@Override
	@Setter (getter = "getTarget")
	public void setTarget (final Coord3D newTarget) {
		target = newTarget;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setTravelRate(double)
	 */
	@Override
	public void setTravelRate (final double rate) {
		baseTravelRate = rate;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setTravelStart(long)
	 */
	@Override
	@Setter (getter = "getTravelStart")
	public void setTravelStart (final long l) {
		travelStartTime = l;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.types.HasVariables#setVariable(java.util.Map.Entry)
	 */
	@Override
	public void setVariable (final Entry <String, String> var) {
		setVariable (var.getKey (), var.getValue ());
	}
	
	/**
	 * Set an user variable. These are echoed to everyone in the room,
	 * and provide various sorts of semi-persisten information about
	 * the user. For a discussion see the top of the
	 * {@link AbstractUser} manual page.
	 * 
	 * @param varName The name of the variable
	 * @param varValue The value
	 */
	@Override
	public void setVariable (final String varName,
			final String varValue) {
		userVariables.get ().setVariable (varName, varValue);
		
		// sends results to myself and everyone else
		final Room room = getRoom ();
		final ADPUserVar adpUserVar = new ADPUserVar (this);
		adpUserVar.setUser (this);
		adpUserVar.add (getVariables ());
		if (room != null) {
			if (room.getRoomChannel () != null) {
				room.getRoomChannel ().broadcast (adpUserVar);
			}
		} else {
			acceptDatagram (adpUserVar);
		}
		
		if (varValue.length () == 0) {
			deleteVariable (varName);
		}
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see org.starhope.appius.types.HasVariables#setVariables(java.util.Map)
	 */
	@Override
	public void setVariables (final Map <String, String> map) {
		for (final Entry <String, String> var : map.entrySet ()) {
			userVariables.get ().setVariable (var.getKey (),
					var.getValue ());
			if (var.getValue ().length () == 0) {
				deleteVariable (var.getKey ());
			}
		}
		// sends results to myself and everyone else
		final Room room = getRoom ();
		final ADPUserVar adpUserVar = new ADPUserVar (this);
		adpUserVar.setUser (this);
		adpUserVar.add (getVariables ());
		if (room != null) {
			if (room.getRoomChannel () != null) {
				room.getRoomChannel ().broadcast (adpUserVar);
			}
		} else {
			acceptDatagram (adpUserVar);
		}
	}
	
	/**
	 * This method does nothing because we shouldn't be setting the
	 * speed and direction of users
	 * <p>
	 * WRITEME: explain why? We do manipulate these values, regardless…
	 * </p>
	 * 
	 * @see org.starhope.appius.physica.Collidable#setVelocity(Vector2D
	 *      velocity)
	 */
	@Override
	public void setVelocity (final Vector2D velocity) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setZone(org.starhope.appius.game.Zone)
	 */
	@Override
	public void setZone (final Zone zone) {
		this.zone = zone;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#speak(org.starhope.appius.game.Room,
	 *      java.lang.String)
	 */
	@Override
	public void speak (final Channel channel, final String string) {
		FilterResult filterResult = null;
		String speech = string;
		if (org.starhope.appius.sys.admin.Security.hasCapability (
				this, SecurityCapability.CAP_UNCENSORED)) {
			filterResult = new FilterResult (FilterStatus.Ok,
					"staff");
			/* XXX remove this next version eventually… */
		} else if (hasStaffLevel (1)
				&& AppiusConfig
						.getConfigBoolOrTrue ("org.starhope.appius.censor.noCensorStaff")) {
			filterResult = new FilterResult (FilterStatus.Ok,
					"staff");
		} else {
			/* default case: normal user */
			filterResult = censor == null ? new FilterResult (
					FilterStatus.Ok, "NPC") : censor
					.filterMessage (string);
		}
		switch (filterResult.status) {
		case Ok:
		default:
			if (null != channel) {
				channel.broadcast (new ADPSpeak (this, speech));
				GeneralUser.log.info ("[{}] {} said \"{}\"",
						new Object [] { channel.getMoniker (),
								getAvatarLabel (), speech });
			}
			break;
		case Black:
			speech = "/00p$";
			channel.send (new ADPSpeak (this, speech), this);
			break;
		case Red:
			try {
				kick (Nomenclator.getSystemUser (), "obs", 15);
			} catch (final PrivilegeRequiredException e) {
				GeneralUser.log
						.error ("Caught a PrivilegeRequiredException in Room.speak_actually ",
								e);
			}
			break;
		}
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#speak(java.lang.String)
	 */
	@Override
	public void speak (final String string) {
		if (currentRoom != null) {
			speak (currentRoom.getRoomChannel (), string);
		}
	}
	
}
