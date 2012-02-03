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
package org.starhope.appius.user;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.ReentrantLock;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NonSufficientFundsException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.ParameterException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.Channel;
import org.starhope.appius.game.DamageTypeRanks;
import org.starhope.appius.game.GameRoom;
import org.starhope.appius.game.GameStateFlag;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.RoomChannel;
import org.starhope.appius.game.RoomListener;
import org.starhope.appius.game.Zone;
import org.starhope.appius.game.inventory.GenericItemReference;
import org.starhope.appius.game.inventory.Inventory;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.game.inventory.InventoryItemType;
import org.starhope.appius.game.inventory.ItemEffects;
import org.starhope.appius.geometry.Circle;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.geometry.PolygonPrimitive;
import org.starhope.appius.geometry.Vector2D;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.net.datagram.ADPSpeak;
import org.starhope.appius.net.datagram.ADPUserList;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.physica.Collidable;
import org.starhope.appius.physica.Geometry;
import org.starhope.appius.sys.admin.Security;
import org.starhope.appius.types.AgeBracket;
import org.starhope.appius.types.Colour;
import org.starhope.appius.user.events.EventRecord;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.via.Setter;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 */
public abstract class GeneralUser implements AbstractUser, Collidable {
    /**
     * Java serialisation unique ID
     */
    private static final long serialVersionUID = 6267186342664921052L;
	
	/**
	 * List of users being ignored
	 */
	private final transient HashSet <String> buddyList = new HashSet <String> ();
	
	/**
	 * Collision boundaries for an unknown thing or other
	 */
    public PolygonPrimitive <?> collisionBounds = new Circle (0, -10, 20);

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
	 * the last time that the user intentionally started moving.
	 */
    protected long lastUserMovement;
    /**
     * Current coördinates for the user (as of {@link #travelStartTime})
     */
    Coord3D location = new Coord3D (Room.MAX_X / 2, Room.MAX_Y / 2, 0);
	/**
	 * Locking semaphore for location
	 *
	 * @see AbstractUser#getLocationForUpdate()
	 * @see AbstractUser#unlockLocation()
	 */
    private final ReentrantLock locationLock = new ReentrantLock ();
    /**
     * Destination coördinates towards which the user is currently
     * moving; May be identical to {@link #location}
     */
    Coord3D target = new Coord3D (Room.MAX_X / 2, Room.MAX_Y / 2, 0);
    /**
     * The time at which the user started moving on their current
     * movement vector. Measured in milliseconds since epoch.
     */
    long travelStartTime;
    /**
     * The user record backing this user
     */
    protected UserRecord userRecord;
	
	/**
	 * WRITEME: Document this ewinkelman
	 */
	protected Zone zone;
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptGameAction(org.starhope.appius.user.AbstractUser,
	 *      org.json.JSONObject)
	 */
	@Override
	public void acceptGameAction (AbstractUser u, JSONObject action) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptGameStateChange(org.starhope.appius.game.GameRoom,
	 *      org.starhope.appius.game.GameStateFlag)
	 */
	@Override
	public void acceptGameStateChange (GameRoom gameCode,
			GameStateFlag gameState) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.RoomChannel, java.lang.String)
	 */
	@Override
	public void acceptPublicMessage (AbstractUser sender,
			RoomChannel room, String message) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	@Override
	public void acceptPublicMessage (AbstractUser from, String message) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setZone(org.starhope.appius.game.Zone)
	 */
	@Override
	public void setZone (Zone zone) {
		this.zone = zone;
	}
	
	/**
	 * Arbitrary user variables which can be set or retrieved by the
	 * front-end
	 */
    final ConcurrentHashMap <String, String> userVariables =
        new ConcurrentHashMap <String, String> ();

    /**
     * path controller
     */
    protected final PathFinder pathFinder = new PathFinder (this);

    /**
     * The user's base stats
     */
    protected final Map <UserStat, Integer> baseStats =
        new ConcurrentHashMap <UserStat, Integer> ();

    /**
     * Inherent basic defenses
     */
    DamageTypeRanks baseDefenses = new DamageTypeRanks ();

    /**
     * WRITEME: Document this constructor brpocock@star-hope.org
     */
    public GeneralUser () {
        userRecord = null;
    }

    /**
     * @param newRecord the user data record backing this user
     * @throws GameLogicException if the record is null
     */
    public GeneralUser (final UserRecord newRecord)
    throws GameLogicException
    {
        userRecord = newRecord;
        if (null == newRecord) {
            throw new GameLogicException ("null", null, this);
        }
    }

	/**
	 * @see org.starhope.appius.game.ChannelListener#acceptDatagram(org.starhope.appius.net.datagram.AbstractDatagram)
	 */
	@Override
	public void acceptDatagram (final AbstractDatagram datagram) {
		// TODO Auto-generated method stub

	}

    /**
     * @see org.starhope.appius.game.RoomListener#acceptObjectJoinRoom(org.starhope.appius.game.Room,
     *      org.starhope.appius.game.RoomListener)
     */
    @Override
	public void acceptObjectJoinChannel (final RoomChannel channel,
            final RoomListener object)
    {
        // no op in base class

    }

    /**
     * @see org.starhope.appius.game.RoomListener#acceptObjectPartRoom(org.starhope.appius.game.Room,
     *      org.starhope.appius.game.RoomListener)
     */
    @Override
	public void acceptObjectPartChannel (final RoomChannel channel,
            final RoomListener thing)
    {
        // no op in base class

    }

    /**
     * @see org.starhope.appius.game.RoomListener#acceptOutOfBandMessage(org.starhope.appius.user.AbstractUser,
     *      org.starhope.appius.game.Room, org.json.JSONObject)
     */
    @Override
    public void acceptOutOfBandMessage (final AbstractUser sender,
			final RoomChannel channel, final JSONObject body)
    {
        // no op in base class

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
            final String varName, final String varValue)
    {
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
     * @see org.starhope.appius.user.AbstractUser#assertLocationUnlocked()
     */
    @Override
    public void assertLocationUnlocked () {
        if (locationLock.isLocked ()) {
            while (locationLock.isHeldByCurrentThread ()) {
                AppiusClaudiusCaecus
                .reportBug (getDebugName ()
                        + " location is locked by this thread, and I thought it wouldn't be.");
                locationLock.unlock ();
            }
        }
    }

	/**
	 * Assert that this user must have the given staff level (or
	 * greater). Throws an exception if this is untrue.
	 *
	 * @param staffLevelNeeded The minimum staff level which is being
	 *            asserted
	 * @throws PrivilegeRequiredException if the minimum staff level is
	 *             not met.
	 * @deprecated use
	 *             {@link Security#hasCapability(AbstractUser, org.starhope.appius.sys.admin.SecurityCapability)}
	 */
    @Deprecated
    @Override
    public void assertStaffLevel (final int staffLevelNeeded)
    throws PrivilegeRequiredException
    {
        if (userRecord.getStaffLevel () >= staffLevelNeeded) {
            return;
        }
        throw new PrivilegeRequiredException (staffLevelNeeded);
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
	 * If the user is a teen (13+) or adult, they are allowed to approve
	 * their own account. This is a boolean test for that fact.
	 *
	 * @return true, if the user is permitted to approve their own
	 *         account (via their own eMail address). False, if they
	 *         require parent approval.
	 */
    public boolean canApproveSelf () {
        return userRecord.canApproveSelf ();
    }

    /**
     * @return true, if the user is permitted to log in to a beta test
     *         server
     */
    public boolean canBetaTest () {
        return userRecord.canBetaTest () || hasStaffLevel (1);
    }

    /**
     * @return WRITEME
     */
    public boolean canEnterChatZone () {
        return userRecord.canEnterChatZone ();
    }

    /**
     * @return the canEnterMenuZone
     */
    public boolean canEnterMenuZone () {
        return userRecord.canEnterMenuZone ();
    }

    /**
     * @param alteration amount(s) to alter base defenses
     * @return copy of new base defenses
     */
    public DamageTypeRanks changeBaseDefenses (
            final DamageTypeRanks alteration)
    {
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
	 * This is an overriding method.
	 *
	 * @see org.starhope.appius.types.HasVariables#deleteVariable(java.lang.String)
	 */
    @Override
    public void deleteVariable (final String key) {
        userVariables.remove (key);
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
        final java.sql.Date approvedDate =
            userRecord
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
     * @see org.starhope.appius.user.AbstractUser#getDialect()
     */
    @Override
    public String getDialect () {
        return userRecord.getDialect ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getDisplayName()
     */
    @Override
    public String getDisplayName () {
        return userRecord.getLogin ();
    }

	/**
	 * Get the effective defenses of the user (including transient and
	 * item effects)
	 *
	 * @return the effective defenses
	 */
    public DamageTypeRanks getEffectiveDefenses () {
        final DamageTypeRanks effective = getBaseDefenses ();
        final UserTransientEffects fx =
            UserTransients
            .getEffects (this);
		if (null != fx.alterDefenses) {
			effective.add (fx.alterDefenses);
		}

        final Collection <InventoryItem> equippedItems =
            getInventory ()
            .getEquippedItems (
                    true);
        for (final InventoryItem item : equippedItems) {
            try {
                final ItemEffects effects = item.getItemEffects ();
                effective.add (effects.getDefenseLinear ());
            } catch (final NotFoundException e) {
                // no effect
            }
        }
        for (final InventoryItem item : equippedItems) {
            try {
                final ItemEffects effects = item.getItemEffects ();
                effective.multiply (effects.getDefenseGeometric ());
            } catch (final NotFoundException e) {
                // no effect
            }
        }

        return effective;
    }

    /**
     * @see org.starhope.appius.physica.Collidable#getEndMovementTime(long)
     */
    @Override
    public long getEndMovementTime (final long currentTime) {
        return Geometry.getTimeToTarget (this, currentTime)
        + currentTime;
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getExtraColor()
     */
    @Override
    public Colour getExtraColor () {
        return userRecord.getExtraColor ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getFacing()
     */
    @Override
    public String getFacing () {
        return facing;
    }

	/**
	 * If the user has a game item equipped (e.g. a key), then get that
	 * item. Otherwise, returns null.
	 *
	 * @return the game item currently being carried / currently
	 *         equipped, or null if no item is equipped.
	 * @see #getGameEquipItems_JSON()
	 */
    public Collection <InventoryItem> getGameEquipItems () {
        final Collection <InventoryItem> set =
            this
            .getItemsByType ("game_equip_item");
        for (final InventoryItem i : set) {
            if ( !i.isActive ()) {
                set.remove (i);
            }
        }
        return set;
    }

    /**
     * @see #getGameEquipItems()
     * @return game equip items in JSON form
     * @throws JSONException if something goes wrong
     */
    public JSONObject getGameEquipItems_JSON () throws JSONException {
        final JSONObject gameItemsJSON = new JSONObject ();
        final Collection <InventoryItem> gameItems =
            getGameEquipItems ();
        int i = 0;
        for (final InventoryItem gameItem : gameItems) {
            gameItemsJSON.put (String.valueOf (i++ ), String
                    .valueOf (gameItem.getID ()));
        }
        return gameItemsJSON;
    }

    /**
     * @see AbstractUser#getHeight()
     * @return the user's height in pixels
     */
    @Override
    public double getHeight () {
        return getAvatarClass ().getHeight () * getSizeScalar ();
    }

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @return the user's house
	 */
    public UserHouse getHouse () {
        return userRecord.getHouse ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getInventory()
     */
    @Override
    public Inventory getInventory () {
        return userRecord.getInv ();
    }

	/**
	 * Get all items that identify as the type string.
	 *
	 * @param typeString A type string from the config file
	 * @see #getItemsByType(String[])
	 * @return an array of inventory items that identify as the given
	 *         type
	 */
    public Collection <InventoryItem> getItemsByType (
            final String typeString)
            {
        return this.getItemsByType (new String [] { typeString });
            }

	/**
	 * Get all inventory items which are (any of) the given type(s). The
	 * type strings are specified by the config file
	 *
	 * @param types The set of types of inventory items which are wanted
	 * @return get items in the inventory
	 */
    public Collection <InventoryItem> getItemsByType (
            final String [] types)
            {
        final HashSet <InventoryItemType> actualTypes =
            new HashSet <InventoryItemType> ();
        return getInventory ().getItemsByType (actualTypes);
            }

	/**
	 * Get all items that identify as the type string.
	 *
	 * @param typeString A type string specified in the config file
	 * @return an array of inventory items that identify as the given
	 *         type
	 */
    public InventoryItem [] getItemsByTypeAsArray (
            final String typeString)
    {
        final Collection <InventoryItem> itemsByType =
            this
            .getItemsByType (new String [] { typeString });
        return itemsByType.toArray (new InventoryItem [itemsByType
                                                       .size ()]);
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getKickedByUserID()
     */
    @Override
    public int getKickedByUserID () {
        return userRecord.getKickedByUserID ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getKickedReasonCode()
     */
    @Override
    public String getKickedReasonCode () {
        return userRecord.getKickedReasonCode ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getKickedUntil()
     */
    @Override
    public Timestamp getKickedUntil () {
        return userRecord.getKickedUntil ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getLocationForUpdate()
     */
    @Override
    public Coord3D getLocationForUpdate () {
        locationLock.lock ();
        Geometry.updateUserPositioning (this);
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
     * @see org.starhope.appius.user.AbstractUser#getMoney(org.starhope.appius.mb.Currency)
     */
    @Override
	@Deprecated
	public BigInteger getMoney (final Currency currency) {
		return getWallet ().get (currency).toBigInteger ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getPathFinder()
     */
    @Override
    public PathFinder getPathFinder () {
        return pathFinder;
    }

    /**
     * @see AbstractUser#getPublicInfo() Returned packet contains:
     *      <ul>
     *      <li>"avatar": FILENAME,</li>
     *      <li>"avatarClass": ID#,</li>
     *      <li>chatFG: foreground colour (RGB int),</li>
     *      <li>chatBG: background colour (RGB int),</li>
     *      <li>"avatarClass_B": avatar class's default base colour,</li>
     *      <li>"avatarClass_E": avatar class's default extra colour,</li>
     *      <li>"avatarClass_P": avatar class's default pattern colour,</li>
     *      <li>"inRoom": room moniker (if in a room),</li>
     *      <li>"userName": avatar label (user visible name, including
     *      hidden names),</li>
     *      <li>"colors": { ... array of colour filters to be applied to
     *      the avatar file itself ... },</li>
     *      <li>"clothes": { ... array of clothing items ... },</li>
     *      <li>"gameItem": game equipped item ID (carrying object),</li>
     *      <li>"vars": { ... user variables, including "d" or "s" ... }
     *      </li>
     *      <li>"id": USER-ID</li>
     *      </ul>
     * @return JSONObject 'self' including userName and avatarClass
     */
    @Override
    public JSONObject getPublicInfo () {
        final JSONObject userInfo = new JSONObject ();
        try {
            final AvatarClass avatarClass =
                userRecord
                .getAvatarClass ();
            userInfo.put ("avatar", avatarClass.getFilename ());
            userInfo.put ("avatarClass", avatarClass.getID ());
            final double height = getHeight ();
            if ( !Double.isNaN (height)) {
                userInfo.put ("height", height);
            }
            userInfo.put ("chatFG", userRecord.getChatFG ().toLong ());
            userInfo.put ("chatBG", userRecord.getChatBG ().toLong ());
            local_publicInfo (userInfo);
            userInfo.put ("avatarClass_B", avatarClass
                    .getDefaultBaseColor ().toLong ());
            userInfo.put ("avatarClass_E", avatarClass
                    .getDefaultExtraColor ().toLong ());
            userInfo.put ("avatarClass_P", avatarClass
                    .getDefaultPatternColor ().toLong ());
            userInfo.put ("format", avatarClass.getBodyFormat ()
                    .getName ());
			if (null != currentRoom) {
				userInfo.put ("inRoom", currentRoom.getMoniker ());
				userInfo.put ("action", currentRoom
						.getUserAction_JSON (this));
			}
            userInfo.put ("userName", getAvatarLabel ());
            final JSONObject colors = new JSONObject ();
            if (avatarClass.canColor ()) {
				final Colour baseColor = getBaseColor ();
                colors.put ("0", baseColor.toInt ());
				colors.put ("1", getExtraColor ().toInt ());
                colors.put ("2", User.getOutlineColourForBaseColour (
                        baseColor).toInt ());
            }
            userInfo.put ("colors", colors);
            userInfo.put ("clothes", getInventory ()
                    .getActiveClothing_JSON ());
            userInfo.put ("gameItems", getGameEquipItems_JSON ());
            userInfo.put ("vars", getVariablesJSON ());
            userInfo.put ("id", getUserID ());
        } catch (final JSONException e) {
            AppiusClaudiusCaecus.reportBug (e);
        }
        return userInfo;
    }

    /**
     * @return the registeredAt
     */
    public Timestamp getRegisteredAt () {
        return userRecord.getRegisteredAt ();
    }

    /**
     * @return the date on which this user first registered
     * @see UserRecord#getRegisteredDate()
     */
    public java.util.Date getRegisteredDate () {
        return userRecord.getRegisteredDate ();
    }

    /**
     * @see #getRegisteredDate()
     * @return Returns an user-visible string describing when the user
     *         was registered
     */
    @Override
    public String getRegisteredDateString () {
        return userRecord.getRegisteredDateString ();
    }

    /**
     * @return the name that the user requested
     */
    public String getRequestedName () {
        return userRecord.getRequestedName ();
    }

	/**
	 * <p>
	 * Get the eMail address of a responsible person: either the player,
	 * or the parent.
	 * </p>
	 * <p>
	 * Currently, kids 13-17 return their own mail.
	 * </p>
	 *
	 * @return the eMail address
	 */
    @Override
    public String getResponsibleMail () {
        return userRecord.getResponsibleMail ();
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
        final String roomScalar =
            null != currentRoom ? currentRoom
                    .getVariable ("scale") : null;
                    if (null != roomScalar && roomScalar.length () > 0) {
                        try {
                            return Double.parseDouble (roomScalar)
                            * UserTransients.getEffects (this).heightScalar;
                        } catch (final NumberFormatException e) {
                            // no op
                        }
                    }
                    return UserTransients.getEffects (this).heightScalar;
    }

    /**
     * @return the staffLevel
     */
    @Override
    public int getStaffLevel () {
        return userRecord.getStaffLevel ();
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
	 * Get the user's effective stat value (considering any transient
	 * effects in place as well as the base stat)
	 *
	 * @param stat the stat to query
	 * @return the effective stat value
	 */
    public int getStat (final UserStat stat) {
        final UserTransientEffects fx =
            UserTransients
            .getEffects (this);
        Integer base = baseStats.get (stat);
        if (null == base) {
            base = Integer.valueOf (0);
        }

        Integer alter = fx.alterStats.get (stat);
        if (null == alter) {
            alter = Integer.valueOf (0);
        }

        int value = base.intValue () + alter.intValue ();

        for (final InventoryItem item : getInventory ()
                .getEquippedItems (true))
        {
            try {
                value += item.getItemEffects ().alter (stat);
            } catch (final NotFoundException e) {
                // no effect, continue.
            }
        }

        return value;
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
        return userRecord.getTravelRate ();
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
     * @return the userID
     */
    @Override
    public int getUserID () {
        return userRecord.getUserID ();
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
	 * @throws ParameterException
	 * @see org.starhope.appius.user.AbstractUser#getUserListIterator(java.lang.String)
	 */
	@Override
	public Iterator <String> getUserListIterator (String moniker)
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
        return userRecord.getLogin ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getUserVariables()
     */
    @Override
    public Map <String, String> getUserVariables () {
        final Map <String, String> ret =
            new HashMap <String, String> ();
        ret.putAll (userVariables);
        ret.put ("d", getD ());
        return ret;
    }

	/**
	 * Get the value of a given variable by name. Contains special-case
	 * for “d”
	 *
	 * @param string Variable key
	 * @return Value of the named variable
	 */
    @Override
    public String getVariable (final String string) {
        if ("d".equals (string)) {
            return getD ();
        }
        return userVariables.get (string);
    }

	/**
	 * Get all user variables in a hash map
	 *
	 * @return A hashmap containing all user variables
	 */
    @Override
    public Map <String, String> getVariables () {
        final HashMap <String, String> ret =
            new HashMap <String, String> ();
        ret.putAll (userVariables);
        ret.put ("d", getVariable ("d"));
        return ret;
    }

	/**
	 * Get all values in JSON form
	 *
	 * @return the user variables in JSON form
	 */
    public JSONObject getVariablesJSON () {
        final JSONObject vars = new JSONObject ();
        for (final Entry <String, String> var : getUserVariables ()
                .entrySet ())
        {
            try {
                vars.put (var.getKey (), var.getValue ());
            } catch (final JSONException e) {
                AppiusClaudiusCaecus
                .reportBug (
                        "Caught a JSONException in getVariablesJSON",
                        e);
            }
        }
        return vars;
    }

    /**
     * @see org.starhope.appius.physica.Collidable#getVelocity()
     */
    @Override
    public Vector2D getVelocity () {
        final Coord3D from = getLocation ();
        final Coord3D to = getTarget ();
        Vector2D midVector2d =
            new Vector2D (to.getX () - from.getX (),
                    to.getY () - from.getY ());
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
        return Wallet.forUser (userRecord);
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
	 * Returns true if the user has the asserted staff level, or a staff
	 * level which includes it. Returns false, otherwise.
	 *
	 * @param staffLevelNeeded The minimum staff level for which we are
	 *            testing.
	 * @return True, if the user meets the minimum staff level stated;
	 *         false, otherwise. * @deprecated use
	 *         {@link Security#hasCapability(AbstractUser, org.starhope.appius.sys.admin.SecurityCapability)}
	 */
    @Override
    @Deprecated
    public boolean hasStaffLevel (final int staffLevelNeeded) {
        return userRecord.hasStaffLevel (staffLevelNeeded);
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#hasVariable(java.lang.String)
     */
    @Override
    public boolean hasVariable (final String string) {
        if ("d".equals (string)) {
            return true;
        }
        return userVariables.containsKey (string);
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
     * @return true, if this is an active user account (able to sign in,
     *         potentially)
     */
    public boolean isActive () {
        return userRecord.isActive ();
    }

    /**
     * @see UserRecord#isApproved()
     * @return true, if this account has been approved, and is still
     *         active
     */
    public boolean isApproved () {
        return userRecord.isApproved ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#isBanned()
     */
    @Override
    public boolean isBanned () {
        return userRecord.isBanned ();
    }
	
	/**
	 * Determines if someone is your buddy or not
	 * 
	 * @param user
	 * @return
	 */
	public boolean isBuddy (AbstractUser user) {
		return buddyList.contains (user.getAvatarLabel ());
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#isCanceled()
	 */
    @Override
    public boolean isCanceled () {
        return userRecord.isCanceled ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#isKicked()
     */
    @Override
    public boolean isKicked () {
        return userRecord.isKicked ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#isPaidMember()
     */
    @Override
    public boolean isPaidMember () {
        return userRecord.isPaidMember ();
    }

	/**
	 * Append information in the subclass to the already-prepared JSON
	 * data for the getPublicInfo call
	 *
	 * @param userInfo the public info JSON object to which additional
	 *            info. should be appended
	 */
    protected void local_publicInfo (final JSONObject userInfo) {
        /* No op in parent class */
    }
	
	/**
	 * Run initialize the user
	 */
	public void loggedIn () {
		if (ignoreList.size () == 0) {
			Iterator <UserListEntry> i = getSQLUserListIterator ("$ignore");
			while (i.hasNext ()) {
				ignoreList.add (i.next ().getLogin ());
			}
		}
		if (buddyList.size () == 0) {
			Iterator <UserListEntry> i = getSQLUserListIterator ("$buddy");
			while (i.hasNext ()) {
				buddyList.add (i.next ().getLogin ());
			}
		}
	}

	/**
	 * Kid accounts (under 13) require parental confirmation. In order
	 * to get that, we have to get a parental contact. If this field is
	 * false, then the user is either a teenager or adult, or they have
	 * a parent on file. It does <em>not</em> mean that they have had
	 * their account approved: only that they have given us the parental
	 * information (if we needed it). If we ever encounter a user for
	 * whom this flag is true, ask them “who's your daddy?”
	 *
	 * @return true, if this is a kid account without a known parent
	 *         (yet)
	 */
    @Override
    public boolean needsParent () {
        return userRecord.needsParent ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#purchase(org.starhope.appius.game.inventory.GenericItemReference)
     */
    @Override
    public void purchase (final GenericItemReference itemToBuy)
    throws NonSufficientFundsException, NotFoundException,
    AlreadyExistsException
    {
        final EventRecord ev = Quaestor.startEvent (this, "purchase");
        ev.end (itemToBuy);
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
        userVariables.clear ();
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
			final List <String> users)
    {
		final ADPUserList adpUserList = new ADPUserList (this,
				whichList);
		for (final String name : users) {
			adpUserList.add (name);
			AbstractUser user = Nomenclator.getOnlineUserByLogin (name);
			if (null != user) {
				final boolean online = user.isOnline ();
				adpUserList.setOnline (name, online);
				if ( !"ignore".equals (whichList)
						&& user.getZone () != null && online) {
					adpUserList.setZone (name, user.getZone ()
							.getName ());
				}
			} else {
				adpUserList.setOnline (name, false);
			}
		}
		sendResponse (adpUserList);
    	
//        final JSONObject jsonList = new JSONObject ();
//        try {
//            jsonList.put ("list", whichList);
//            final JSONObject userList = new JSONObject ();
//			for (final AbstractUser entry : users) {
//                final JSONObject userInfo = new JSONObject ();
//                final boolean online = entry.isOnline ();
//                userInfo.put ("online", online);
//                if (online && !"$ignore".equals (whichList)) {
//                    userInfo.put ("inZone", entry.getZone ());
//                }
//				userList.put (entry.getAvatarLabel (), userInfo);
//            }
//            jsonList.put ("users", userList);
//            acceptSuccessReply ("userList", jsonList, null);
//        } catch (final JSONException e) {
//            AppiusClaudiusCaecus.reportBug (
//                    "Caught a JSONException in Clodia.sendList ", e);
//        }
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#sendEarnings(org.starhope.appius.game.Room, org.starhope.appius.mb.Currency, java.math.BigDecimal)
     */
    @Override
    public void sendEarnings (final Room room, final Currency cu, final BigDecimal amount) {
    	// no op
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#sendEarnings(org.starhope.appius.game.Room, org.starhope.appius.game.inventory.InventoryItem)
     */
    @Override
    public void sendEarnings (final Room room, final InventoryItem item) {
		// no op
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#sendEarnings(org.starhope.appius.game.Room,
     *      java.lang.String)
     */
    @Override
    public void sendEarnings (final Room room, final String string) {
        // no op in base class
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#sendWardrobe()
     */
    @Override
    public void sendWardrobe () {
		final JSONObject wardrobe = getPublicInfo ();
		final JSONObject results = new JSONObject ();
		try {
			results.put ("avatar", wardrobe);
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a JSONException in sendWardrobe", e);
			return;
		}
		final Room room = getRoom ();
		if (null != room) {
			room.broadcast ("wardrobe", results);
		}
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#setAgeGroupToSystem()
     */
    @Override
    public void setAgeGroupToSystem () {
        userRecord.setAgeGroup (AgeBracket.System);
    }

    /**
     * @see org.starhope.appius.user.DataRecordBacked#setBackingRecord(org.starhope.appius.util.DataRecord)
     */
    @Override
    public void setBackingRecord (final UserRecord rec) {
        userRecord = rec;
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#setBaseColor(org.starhope.appius.types.Colour)
     */
    @Setter (getter = "getBaseColor")
    @Override
    public void setBaseColor (final Colour colour) {
        userRecord.setBaseColor (colour);
    }

	/**
     * @see org.starhope.appius.user.AbstractUser#setCanTalk(boolean)
     */
    @Setter (getter = "canTalk")
    @Override
    public void setCanTalk (final boolean b) {
        userRecord.setCanTalk (b);
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
     * @see org.starhope.appius.user.AbstractUser#setExtraColor(org.starhope.appius.types.Colour)
     */
    @Override
    @Setter (getter = "getExtraColor")
    public void setExtraColor (final Colour colour) {
        userRecord.setExtraColor (colour);
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
        if (Double.isNaN (coord3d.getX ())
                || Double.isNaN (coord3d.getY ())
                || Double.isNaN (coord3d.getZ ())
                || coord3d.getX () < 0 || coord3d.getY () < 0
                || coord3d.getX () > Room.MAX_X
                || coord3d.getY () > Room.MAX_Y)
        {
            // AppiusClaudiusCaecus
            // .reportBug ("Setting dumb coördinates for "
            // + getDebugName () + " at "
            // + coord3d.toString ());
        }
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

        if (null == room || -1 == room.getID ()) {
            AppiusClaudiusCaecus
            .reportBug ("I don't want to go to null! Only bad Toots go to null!");
            return null == currentRoom ? -1 : currentRoom.getID ();
        }

        if (null != currentRoom
                && !currentRoom.getMoniker ().equals (
                        room.getMoniker ()))
        {
            currentRoom.part (this);
            setLocation (new Coord3D ( -100, -100, 0));
            setTarget (new Coord3D ( -100, -100, 0));
            setTravelStart (System.currentTimeMillis ());
        }
        currentRoom = room;
        return currentRoom.getID ();
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
	 * This is an overriding method.
	 *
	 * @see org.starhope.appius.user.AbstractUser#setTravelRate(double)
	 */
    @Override
    @Setter (getter = "getTravelRate")
    public void setTravelRate (final double rate) {
        userRecord.setTravelRate (rate);
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
	 * and provide various sorts of semi-persisten information about the
	 * user. For a discussion see the top of the {@link AbstractUser}
	 * manual page.
	 *
	 * @param varName The name of the variable
	 * @param varValue The value
	 */
    @Override
    public void setVariable (final String varName, final String varValue)
    {
        final String newValue = varValue;
        final Room myRoom = getRoom ();
        if (AppiusConfig
                .getConfigBoolOrTrue ("org.starhope.appius.user.dVarMovement"))
        {
            if ("d".equals (varName)) {
                final String parts[] = newValue.split ("~");
                if (null != myRoom && parts.length >= 5) {
                    myRoom.goTo (this, Double.parseDouble (parts [2]),
                            Double.parseDouble (parts [3]), 0, null,
                    "Walk");
                }
                return;
            }
        }

        userVariables.put (varName, newValue);

        final ServerThread serverThread = getServerThread ();
        if (null != serverThread) {
            serverThread.tattle ("userVar\t" + varName + "\t"
                    + newValue);
            if (null == myRoom) {
                serverThread.tattle ("I'm not even nowhere");
            } else if (myRoom.isLimbo ()) {
                serverThread
                .tattle ("Keeping user vars a secret (in Limbo)");
            } else {
                serverThread.tattle ("Notifying "
                        + myRoom.getUserCount () + " folks");
				myRoom.getRoomChannel ()
						.broadcastAcceptUserVariableUpdate (this,
								varName, varValue);
            }
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
            this.setVariable (var);
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

	@Override
	public void speak (Channel chan, String string) {
		chan.broadcast (new ADPSpeak (this, string));
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param attack WRITEME
	 * @return WRITEME
	 */
    @Override
	public boolean takeAttack (final DamageTypeRanks attack) {
		final DamageTypeRanks netEffect = getEffectiveDefenses ();
		netEffect.subtract (attack);
		netEffect.invert ();
		if (Math.abs (netEffect.sumPositives ()) < .01) {
            return false;
        }
        for (final InventoryItem item : getInventory ()
                .getEquippedItems (true))
        {
            try {
				item.getItemEffects ().takeDamage (netEffect);
            } catch (final NotFoundException e) {
                // no op
            }
        }
        return true;
    }

	/**
	 * @see org.starhope.appius.user.AbstractUser#unlockLocation()
	 */
	@Override
	public void unlockLocation () {
		try {
			locationLock.unlock ();
		} catch (final IllegalMonitorStateException e) {
			AppiusClaudiusCaecus.reportBug (e);
		}
	}

	/**
	 * @see org.starhope.appius.user.AbstractUser#updateWallet()
	 */
	@Override
	public void updateWallet () {
		// no op (usually)
	}


}
