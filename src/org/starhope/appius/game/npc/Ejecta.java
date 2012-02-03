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
 * along with this program. If not, see
 * &lt;http://www.gnu.org/licenses/&gt;.
 * </p>
 * <p>
 * 
 * @author brpocock@star-hope.org
 *         </p>
 *         <p>
 *         Created Jun 23, 2010
 *         </p>
 */
package org.starhope.appius.game.npc;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.locks.ReentrantLock;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.GameRoom;
import org.starhope.appius.game.GameStateFlag;
import org.starhope.appius.game.PhysicsScheduler;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.RoomChannel;
import org.starhope.appius.game.RoomListener;
import org.starhope.appius.game.Zone;
import org.starhope.appius.game.inventory.Inventory;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.physica.Geometry;
import org.starhope.appius.sys.admin.Security;
import org.starhope.appius.types.AgeBracket;
import org.starhope.appius.types.Colour;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.AvatarClass;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.Parent;
import org.starhope.appius.user.User;
import org.starhope.appius.user.Wallet;
import org.starhope.util.LibMisc;

/**
 * <p>
 * An Ejecta object is a particle effect, transient effect, or
 * projectile moving through the game world.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
public class Ejecta extends GeneralUser {
	
	/**
	 * The next user ID available for Ejecta
	 */
	private static AtomicInteger nextUserID = new AtomicInteger ( -1);
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 2420951494623865426L;
	/**
	 * The Ejecta's base colour
	 */
	private Colour baseColour;
	/**
	 * Locking semaphore for location
	 * 
	 * @see AbstractUser#getLocationForUpdate()
	 * @see AbstractUser#unlockLocation()
	 */
	private final ReentrantLock locationLock = new ReentrantLock ();
	/**
	 * The action currently being played for the Ejecta
	 */
	private String myAction = "Walk";
	/**
	 * The avatar class for the Ejecta
	 */
	private final AvatarClass myAvatar;
	/**
	 * The avatar's facing direction
	 */
	private String myFacing = "S";
	/**
	 * The Ejecta's position
	 */
	private Coord3D myPosition;
	/**
	 * The Ejecta's room
	 */
	private Room myRoom;
	/**
	 * @see AbstractUser#getStartT()
	 */
	private long myStartT;
	/**
	 * The Ejecta's destination coördinates
	 */
	private Coord3D myTarget;
	/**
	 * The Ejecta's rate of travel
	 */
	private double myTravelRate;
	
	/**
	 * The Ejecta's travel start time
	 */
	private long myTravelStart;
	
	/**
	 * The Ejecta's user ID
	 */
	private final int myUserID;
	
	/**
	 * Specify the avatar file to be provided to the client, and the
	 * point of origination, and motion vector.
	 * 
	 * @param avatar The avatar file to be provided to the client
	 */
	public Ejecta (final AvatarClass avatar) {
		myAvatar = avatar;
		baseColour = myAvatar.getDefaultBaseColor ();
		myUserID = Ejecta.nextUserID.decrementAndGet ();
		EjectaManager.add (this);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#acceptErrorReply(java.lang.String,
	 *      java.lang.String, org.json.JSONObject,
	 *      org.starhope.appius.game.Room)
	 */
	@Override
	public void acceptErrorReply (final String command,
			final String error, final JSONObject result,
			final Room userCurrentRoomInZone) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptGameAction(org.starhope.appius.user.AbstractUser,
	 *      org.json.JSONObject)
	 */
	@Override
	public void acceptGameAction (final AbstractUser u,
			final JSONObject action) {
		// XXX Maybe handle “gotShot” responses?
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptGameStateChange(org.starhope.appius.game.GameEvent,
	 *      org.starhope.appius.game.GameStateFlag)
	 */
	@Override
	public void acceptGameStateChange (final GameRoom gameCode,
			final GameStateFlag gameState) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#acceptMessage(java.lang.String,
	 *      java.lang.String, java.lang.String)
	 */
	@Override
	public void acceptMessage (final String title, final String label,
			final String content) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptObjectJoinRoom(org.starhope.appius.game.Room,
	 *      org.starhope.appius.game.RoomListener)
	 */
	@Override
	public void acceptObjectJoinChannel (final RoomChannel room,
			final RoomListener object) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptObjectPartRoom(org.starhope.appius.game.Room,
	 *      org.starhope.appius.game.RoomListener)
	 */
	@Override
	public void acceptObjectPartChannel (final RoomChannel room,
			final RoomListener thing) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptOutOfBandMessage(org.starhope.appius.game.Room,
	 *      org.starhope.appius.game.RoomListener)
	 */
	@Override
	public void acceptOutOfBandMessage (final AbstractUser sender,
			final RoomChannel room, final JSONObject body) {
		// no op
	}

	/**
	 * @see org.starhope.appius.user.AbstractUser#acceptPrivateMessage(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	@Override
	public void acceptPrivateMessage (final AbstractUser speaker,
			final String speech) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      org.starhope.appius.game.RoomChannel, java.lang.String)
	 */
	@Override
	public void acceptPublicMessage (final AbstractUser sender,
			final RoomChannel channel, final String message) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	@Override
	public void acceptPublicMessage (final AbstractUser from,
			final String message) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#acceptSuccessReply(java.lang.String,
	 *      org.json.JSONObject, org.starhope.appius.game.Room)
	 */
	@Override
	public void acceptSuccessReply (final String command,
			final JSONObject jsonData, final Room room) {
		// no op
	}
	
	@Override
	public void acceptUserAction (final RoomChannel r,
			final AbstractUser u) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#acceptUserVariableUpdate(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String, java.lang.String)
	 */
	@Override
	public void acceptUserVariableUpdate (final AbstractUser user,
			final String varName, final String varValue) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#addBuddy(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void addBuddy (final AbstractUser buddy) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#addGiftSubscription(int,
	 *      int)
	 */
	@Override
	public void addGiftSubscription (final int i, final int days) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#addItem(int)
	 */
	@Override
	public void addItem (final int parseInt) {
		// no op
		
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#assertLocationUnlocked()
	 */
	@Override
	public void assertLocationUnlocked () {
		if (locationLock.isLocked ()) {
			if (locationLock.isHeldByCurrentThread ()) {
				AppiusClaudiusCaecus
						.reportBug (getDebugName ()
								+ " location is locked by this thread, and I thought it wouldn't be.");
				while (locationLock.isLocked ()) {
					locationLock.unlock ();
				}
			}
		}
	}
	
	/**
	 * @deprecated use
	 *             {@link Security#hasCapability(AbstractUser, org.starhope.appius.sys.admin.SecurityCapability)}
	 */
	@Override
	@Deprecated
	public void assertStaffLevel (final int staffLevelStaffMember)
			throws PrivilegeRequiredException {
		throw new PrivilegeRequiredException ("Ejecta");
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#attend(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void attend (final AbstractUser byLogin) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#ban(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	@Override
	public void ban (final AbstractUser u, final String banReason)
			throws PrivilegeRequiredException {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#canTalk()
	 */
	@Override
	public boolean canTalk () {
		return false;
	}
	
	/**
	 * remove this object from the world
	 */
	public void destroy () {
		PhysicsScheduler.removePersonOfInterest (this);
		EjectaManager.remove (this);
		myRoom = null;
		myPosition = null;
		myTarget = null;
		myFacing = null;
		try {
			locationLock.unlock ();
		} catch (final Throwable t) {
			/* no op */
		}
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#doffClothes()
	 */
	@Override
	public void doffClothes () {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#doTransport()
	 */
	@Override
	public void doTransport () {
		// no op
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if ( ! (obj instanceof Ejecta)) {
			return false;
		}
		return 0 == compareTo (obj);
	}
	
	/**
	 * @see java.lang.Object#finalize()
	 */
	@Override
	protected void finalize () throws Throwable {
		super.finalize ();
		EjectaManager.remove (this);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman
	 * 
	 * @param room The room in which the Ejecta is born
	 * @param origin The point of origin
	 * @param birth The time of origination
	 * @param target The destination of motion
	 * @param travelRate The rate of travel
	 */
	public void fire (final Room room, final Coord3D origin,
			final long birth, final Coord3D target,
			final double travelRate) {
		myRoom = room;
		myPosition = origin;
		myTravelStart = birth;
		myTarget = target;
		myTravelRate = travelRate;
		if (null != myRoom) {
			myRoom.join (this);
		}
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getAge()
	 */
	@Override
	public int getAge () {
		return 0;
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
		return "Ejecta approved";
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getAvatarClass()
	 */
	@Override
	public AvatarClass getAvatarClass () {
		return myAvatar;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getAvatarLabel()
	 */
	@Override
	public String getAvatarLabel () {
		return "$/Ejecta#" + myUserID;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getBaseColor()
	 */
	@Override
	public Colour getBaseColor () {
		return baseColour;
	}

	/**
	 * @see org.starhope.appius.user.AbstractUser#getBuddyListNames()
	 */
	@Override
	public Collection <String> getBuddyListNames () {
		return new HashSet <String> ();
	}
	
	public RoomChannel getChannel () {
		return myRoom.getRoomChannel ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getCurrentAction()
	 */
	@Override
	public String getCurrentAction () {
		return myAction;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getDebugName()
	 */
	@Override
	public String getDebugName () {
		return "$/Ejecta#" + myUserID;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getDialect()
	 */
	@Override
	public String getDialect () {
		return "C";
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getDisplayName()
	 */
	@Override
	public String getDisplayName () {
		return "Ejecta";
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getExtraColor()
	 */
	@Override
	public Colour getExtraColor () {
		return myAvatar.getDefaultExtraColor ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getFacing()
	 */
	@Override
	public String getFacing () {
		return myFacing;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getInventory()
	 */
	@Override
	public Inventory getInventory () {
		return new Inventory (null);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getIPAddress()
	 */
	@Override
	public String getIPAddress () {
		return "::1";
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getKickedByUserID()
	 */
	@Override
	public int getKickedByUserID () {
		return -1;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getKickedMessage()
	 */
	@Override
	public String getKickedMessage () {
		return "";
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getKickedReasonCode()
	 */
	@Override
	public String getKickedReasonCode () {
		return "";
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getKickedUntil()
	 */
	@Override
	public Timestamp getKickedUntil () {
		return new Timestamp (0);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getLag()
	 */
	@Override
	public long getLag () {
		return 0;
	}

	/**
	 * @see org.starhope.appius.user.AbstractUser#getLanguage()
	 */
	@Override
	public String getLanguage () {
		return "C";
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getLocation()
	 */
	@Override
	public Coord3D getLocation () {
		return myPosition;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getLocationForUpdate()
	 */
	@Override
	public Coord3D getLocationForUpdate () {
		locationLock.lock ();
		Geometry.updateUserPositioning (this);
		return myPosition;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getMail()
	 */
	@Override
	public String getMail () {
		return "";
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getMoney(org.starhope.appius.mb.Currency)
	 */
	@Override
	@Deprecated
	public BigInteger getMoney (final Currency currency) {
		return BigInteger.ZERO;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getNameApprovedAt()
	 */
	@Override
	public Date getNameApprovedAt () {
		return new Date (0L);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getNameRequestedAt()
	 */
	@Override
	public Date getNameRequestedAt () {
		return new Date (0L);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getPublicInfo()
	 */
	@Override
	public JSONObject getPublicInfo () {
		final JSONObject myInfo = new JSONObject ();
		try {
			myInfo.put ("avatar", myAvatar.getFilename ());
			myInfo.put ("avatarClass", myAvatar.getID ());
			myInfo.put ("chatFG", 0);
			myInfo.put ("chatBG", 0xffffff);
			myInfo.put ("avatarClass_B", myAvatar
					.getDefaultBaseColor ().toLong ());
			myInfo.put ("avatarClass_E", myAvatar
					.getDefaultExtraColor ().toLong ());
			myInfo.put ("avatarClass_P", myAvatar
					.getDefaultPatternColor ().toLong ());
			myInfo.put ("format", myAvatar.getBodyFormat ()
					.getName ());
			final Room room = getRoom ();
			if (null != room) {
				myInfo.put ("inRoom", room.getMoniker ());
				myInfo.put ("action", room.getUserAction_JSON (this));
			}
			myInfo.put ("userName", getAvatarLabel ());
			final JSONObject colors = new JSONObject ();
			if (myAvatar.canColor ()) {
				colors.put ("0", getBaseColor ()
						.toInt ());
				colors.put ("1", getExtraColor ()
						.toInt ());
				colors.put (
						"2",
						User.getOutlineColourForBaseColour (
								getBaseColor ()).toInt ());
			}
			myInfo.put ("colors", colors);
			myInfo.put ("clothes", new JSONObject ());
			myInfo.put ("gameItems", new JSONObject ());
			final JSONObject vars = new JSONObject ();
			vars.put ("noClick", "true");
			vars.put ("ejecta", "true");
			myInfo.put ("vars", vars);
			myInfo.put ("id", getUserID ());
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (e);
		}
		return myInfo;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getRegisteredDateString()
	 */
	@Override
	public String getRegisteredDateString () {
		return "no registration";
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getResponsibleMail()
	 */
	@Override
	public String getResponsibleMail () {
		return "";
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#getRoom()
	 */
	@Override
	public Room getRoom () {
		return myRoom;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getRoomNumber()
	 */
	@Override
	public int getRoomNumber () {
		return myRoom.getID ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getServerThread()
	 */
	@Override
	public ServerThread getServerThread () {
		return null;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getStaffLevel()
	 */
	@Override
	public int getStaffLevel () {
		return 0;
	}

	/**
	 * @see org.starhope.appius.user.AbstractUser#getStartT()
	 */
	@Override
	public long getStartT () {
		return myStartT;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getTarget()
	 */
	@Override
	public Coord3D getTarget () {
		return myTarget;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getTravelRate()
	 */
	@Override
	public double getTravelRate () {
		return myTravelRate;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getTravelStart()
	 */
	@Override
	public long getTravelStart () {
		return myTravelStart;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getUserID()
	 */
	@Override
	public int getUserID () {
		return myUserID;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getUserVariables()
	 */
	@Override
	public Map <String, String> getUserVariables () {
		final HashMap <String, String> vars = new HashMap <String, String> ();
		vars.put ("noClick", "true");
		vars.put ("ejecta", "true");
		return vars;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getVariable(java.lang.String)
	 */
	@Override
	public String getVariable (final String string) {
		if ("ejecta".equals (string) || "noClick".equals (string)) {
			return "true";
		}
		return "";
	}
	
	/**
	 * @return the user's wallet (currency inventory)
	 */
	@Override
	public Wallet getWallet () {
		return new Wallet (null);
	}
	
	/**
	 * @see org.starhope.appius.game.RoomListener#getZone()
	 */
	@Override
	public Zone getZone () {
		return myRoom.getZone ();
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getDebugName ());
	}
	
	/**
	 * @deprecated use
	 *             {@link Security#hasCapability(AbstractUser, org.starhope.appius.sys.admin.SecurityCapability)}
	 */
	@Deprecated
	@Override
	public boolean hasStaffLevel (final int i) {
		return false;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#hasVariable(java.lang.String)
	 */
	@Override
	public boolean hasVariable (final String string) {
		return "ejecta".equals (string) || "noClick".equals (string);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#ignore(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void ignore (final AbstractUser byLogin) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#isBanned()
	 */
	@Override
	public boolean isBanned () {
		return false;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#isCanceled()
	 */
	@Override
	public boolean isCanceled () {
		return false;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#isKicked()
	 */
	@Override
	public boolean isKicked () {
		return false;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#isNPC()
	 */
	@Override
	public boolean isNPC () {
		return true;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#isOnline()
	 */
	@Override
	public boolean isOnline () {
		return true;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#isPaidMember()
	 */
	@Override
	public boolean isPaidMember () {
		return false;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#kick(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String, int)
	 */
	@Override
	public void kick (final AbstractUser u, final String kickReason,
			final int duration) throws PrivilegeRequiredException {
		throw new PrivilegeRequiredException ("Ejecta");
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#liftBan(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void liftBan (final AbstractUser authority)
			throws PrivilegeRequiredException {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#needsParent()
	 */
	@Override
	public boolean needsParent () {
		return false;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#removeBuddy(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void removeBuddy (final AbstractUser byLogin) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#reportedToModeratorBy(org.starhope.appius.user.AbstractUser)
	 */
	@Override
	public void reportedToModeratorBy (final AbstractUser u) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#reportedToModeratorBy(org.starhope.appius.user.AbstractUser,
	 *      java.lang.String)
	 */
	@Override
	public void reportedToModeratorBy (final AbstractUser u,
			final String reason) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#sendEarnings(org.starhope.appius.game.Room,
	 *      java.lang.String)
	 */
	@Override
	public void sendEarnings (final Room room, final String string) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#sendMigrate(org.starhope.appius.types.Zone)
	 */
	@Override
	public void sendMigrate (final Zone refugeeZone)
			throws UserDeadException {
		destroy ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#sendOops()
	 */
	@Override
	public void sendOops () {
		// no op
		
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#sendResponse(org.starhope.appius.net.datagram.AbstractDatagram)
	 */
	@Override
	public void sendResponse (AbstractDatagram datagram) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#sendResponse(org.json.JSONObject)
	 */
	@Override
	public void sendResponse (final JSONObject result) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#sendWardrobe()
	 */
	@Override
	public void sendWardrobe () {
		// no op
		
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setAgeGroupToSystem()
	 */
	@Override
	public void setAgeGroupToSystem () {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setBaseColor(org.starhope.appius.types.Colour)
	 */
	@Override
	public void setBaseColor (final Colour colour) {
		baseColour = colour;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setCanTalk(boolean)
	 */
	@Override
	public void setCanTalk (final boolean b) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setCurrentAction(java.lang.String)
	 */
	@Override
	public void setCurrentAction (final String newAction) {
		myAction = newAction;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setExtraColor(org.starhope.appius.types.Colour)
	 */
	@Override
	public void setExtraColor (final Colour colour) {
		// no op
	}

	/**
	 * @see org.starhope.appius.user.AbstractUser#setFacing(java.lang.String)
	 */
	@Override
	public void setFacing (final String newFacing) {
		myFacing = newFacing;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setLastActive()
	 */
	@Override
	public void setLastActive () {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setLocation(org.starhope.appius.geometry.Coord3D)
	 */
	@Override
	public void setLocation (final Coord3D coord3d) {
		myPosition = coord3d;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setMail(java.lang.String)
	 */
	@Override
	public void setMail (final String email) throws GameLogicException {
		throw new GameLogicException ("Ejecta", this, email);
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setParent(org.starhope.appius.user.Parent)
	 */
	@Override
	public void setParent (final Parent newParent)
			throws GameLogicException, ForbiddenUserException,
			AlreadyExistsException {
		throw new GameLogicException ("Ejecta", this, newParent);
	}

	/**
	 * @see org.starhope.appius.user.AbstractUser#setRoom(org.starhope.appius.game.Room)
	 */
	@Override
	public int setRoom (final Room room) {
		myRoom = room;
		return myRoom.getID ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setStartT(long)
	 */
	@Override
	public void setStartT (final long when) {
		myStartT = when;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setTarget(org.starhope.appius.geometry.Coord3D)
	 */
	@Override
	public void setTarget (final Coord3D coord3d) {
		myTarget = coord3d;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setTravelRate(double)
	 */
	@Override
	public void setTravelRate (final double rate) {
		myTravelRate = rate;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setTravelStart(long)
	 */
	@Override
	public void setTravelStart (final long l) {
		myTravelStart = l;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setVariable(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public void setVariable (final String varName, final String varValue) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#speak(org.starhope.appius.game.Room,
	 *      java.lang.String)
	 */
	@Override
	public void speak (final Room room, final String string) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		return getPublicInfo ();
	}

	/**
	 * @see org.starhope.appius.user.AbstractUser#toSFSXML()
	 */
	@Override
	public String toSFSXML () {
		final StringBuilder reply = new StringBuilder ();
		reply.append ("<u i='");
		reply.append (myUserID);
		reply.append ("' m='0'><n><![CDATA[$/Ejecta#");
		reply.append (myUserID);
		reply.append ("]]></n><vars><var n='ejecta' t='s'><![CDATA[true]]></var><var n='noClick' t='s'><![CDATA[true]]></var></vars></u>");
		return reply.toString ();
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return getAvatarLabel ();
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#unlockLocation()
	 */
	@Override
	public void unlockLocation () {
		locationLock.unlock ();
	}
}
