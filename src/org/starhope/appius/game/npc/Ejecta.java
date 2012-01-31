/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
 * &lt;http://www.gnu.org/licenses/&gt;.
 * </p>
 * <p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 *         </p>
 *         <p>
 *         Created Jun 23, 2010
 *         </p>
 */
package org.starhope.appius.game.npc;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import org.json.JSONObject;
import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.DamageTypeRanks;
import org.starhope.appius.game.GameRoom;
import org.starhope.appius.game.GameStateFlag;
import org.starhope.appius.game.PhysicsScheduler;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.RoomChannel;
import org.starhope.appius.game.RoomListener;
import org.starhope.appius.game.Zone;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.geometry.PolygonPrimitive;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.sys.admin.Security;
import org.starhope.appius.types.AgeBracket;
import org.starhope.appius.types.Colour;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.AvatarClass;
import org.starhope.appius.user.GeneralUser;
import org.starhope.appius.user.Parent;
import org.starhope.appius.user.PathFinder;
import org.starhope.appius.user.UserRecord;
import org.starhope.appius.util.AcceptsMetronomeTicks;
import org.starhope.util.LibMisc;

/**
 * <p>
 * An Ejecta object is a particle effect, transient effect, or
 * projectile moving through the game world.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Ejecta extends GeneralUser {
	
	/**
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private static final class EjectaWatcher implements
			AcceptsMetronomeTicks, Serializable {
		
		/**
		 * Java serialisation unique ID
		 */
		private static final long serialVersionUID = 494319176010006645L;
		
		/**
		 * the projectile I'm watching
		 */
		private final Ejecta myProjectile;
		
		/**
		 * The polygon outline of the projectile (scaled)
		 */
		private final PolygonPrimitive <?> polygon;
		
		/**
		 * @param projectile to be watched
		 */
		public EjectaWatcher (final Ejecta projectile) {
			myProjectile = projectile;
			polygon = myProjectile.getAvatarClass ()
					.getCollisionBounds ()
					.scale (myProjectile.getSizeScalar ());
		}
		
		/**
		 * @see org.starhope.appius.util.HasName#getName()
		 */
		@Override
		public String getName () {
			return "ProjectileWatcher/"
					+ myProjectile.getDebugName ();
		}
		
		/**
		 * @see org.starhope.appius.util.AcceptsMetronomeTicks#tick(long,
		 *      long)
		 */
		@Override
		public void tick (final long currentTime, final long deltaTime)
				throws UserDeadException {
			
			if (null == myProjectile.getRoom ()) {
				myProjectile.destroy ();
				PhysicsScheduler.remove (this);
				return;
			}
			
			final PolygonPrimitive <?> shotPoly = polygon
					.translate (myProjectile.getLocation ()
							.toCoord2D ());
			final AbstractUser shooter = myProjectile.getShooter ();
			for (final AbstractUser candidate : myProjectile
					.getRoom ().getAllUsers ()) {
				if (candidate.equals (shooter)) {
					continue;
				}
				if (candidate instanceof Ejecta) {
					continue;
				}
				final PolygonPrimitive <?> candidatePoly = candidate
						.getAvatarClass ()
						.getCollisionBounds ()
						.scale (candidate.getSizeScalar ())
						.translate (
								candidate.getLocation ()
										.toCoord2D ());
				if (shotPoly.intersects (candidatePoly)) {
					myProjectile.hit (candidate);
					myProjectile.destroy ();
					PhysicsScheduler.remove (this);
					return;
				}
			}
			if (myProjectile.getLocation ().distance (
					myProjectile.getTarget ()) < 1) {
				myProjectile.miss ();
				myProjectile.destroy ();
				PhysicsScheduler.remove (this);
			}
		}
		
	}
	
	/**
	 * The next user ID available for Ejecta
	 */
	private static AtomicInteger nextUserID = new AtomicInteger ( -1);
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 2420951494623865426L;
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private AbstractUser attacker = null;
	
	/**
	 * WRITEME brpocock@star-hope.org
	 */
	private HitHandler hitEffect = null;
	/**
	 * WRITEME
	 */
	private MissHandler missEffect = null;
	/**
	 * The action currently being played for the Ejecta
	 */
	private String myAction = "Walk";
	
	/**
	 * The avatar class for the Ejecta
	 */
	private final AvatarClass myAvatar;
	
	/**
	 * Who fired this shot
	 */
	private final AbstractUser myShooter;
	
	/**
	 * The Ejecta's user ID
	 */
	private final int myUserID;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private final EjectaWatcher myWatcher;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private Coord3D startLocation;
	
	/**
	 * Specify the avatar file to be provided to the client, and the
	 * point of origination, and motion vector.
	 * 
	 * @param avatar The avatar file to be provided to the client
	 */
	public Ejecta (final AvatarClass avatar, final AbstractUser shooter) {
		myAvatar = avatar;
		myUserID = Ejecta.nextUserID.decrementAndGet ();
		myShooter = shooter;
		myWatcher = new EjectaWatcher (this);
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
		if (currentRoom != null) {
			currentRoom.part (this);
		}
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
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param room The room in which the Ejecta is born
	 * @param origin The point of origin
	 * @param birth The time of origination
	 * @param target The destination of motion
	 * @param travelRate The rate of travel
	 */
	public void fire (final Room room, final Coord3D origin,
			final long birth, final Coord3D target) {
		setLocation (origin);
		if (null != room) {
			room.goTo (this, target, null, "Walk");
			room.join (this, "");
			PhysicsScheduler.add (myWatcher);
			PhysicsScheduler.addPersonOfInterest (this);
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
	 * @return the attacker
	 */
	public AbstractUser getAttacker () {
		return attacker;
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
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method getBaseColor in AbstractUser, added Jan 31, 2012 by brpocock. TODO.");
		return null;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getBuddyListNames()
	 */
	@Override
	public Collection <String> getBuddyListNames () {
		return new HashSet <String> ();
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
	 * @return the hitEffect
	 */
	public HitHandler getHitEffect () {
		return hitEffect;
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
	 * @see org.starhope.appius.user.AbstractUser#getMail()
	 */
	@Override
	public String getMail () {
		return "";
	}
	
	/**
	 * @return the missEffect
	 */
	public MissHandler getMissEffect () {
		return missEffect;
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
	 * @see org.starhope.appius.user.AbstractUser#getPathFinder()
	 */
	@Override
	public PathFinder getPathFinder () {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method getPathFinder in AbstractUser, added Jan 31, 2012 by brpocock. TODO.");
		return null;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getPublicInfo()
	 */
	@Override
	public JSONObject getPublicInfo () {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method getPublicInfo in AbstractUser, added Jan 31, 2012 by brpocock. TODO.");
		return null;
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
	 * @see org.starhope.appius.user.AbstractUser#getServerThread()
	 */
	@Override
	public ServerThread getServerThread () {
		return null;
	}
	
	/**
	 * @return who fired this shot
	 */
	public AbstractUser getShooter () {
		return myShooter;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getStaffLevel()
	 */
	@Override
	public int getStaffLevel () {
		return 0;
	}
	
	/**
	 * @return the origin coördinates
	 */
	public Coord3D getStartLocation () {
		return startLocation;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#getUserID()
	 */
	@Override
	public int getUserID () {
		return myUserID;
	}
	
	/**
	 * @see org.starhope.appius.user.GeneralUser#getUserRecord()
	 */
	@Override
	protected UserRecord getUserRecord () {
		return null;
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
	 * @see org.starhope.appius.user.AbstractUser#getUserVariables()
	 */
	@Override
	public Map <String, String> getVariables () {
		final HashMap <String, String> vars = new HashMap <String, String> ();
		vars.put ("noClick", "true");
		vars.put ("ejecta", "true");
		return vars;
	}
	
	/**
	 * @return the myWatcher
	 */
	public EjectaWatcher getWatcher () {
		return myWatcher;
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
	 * @param victim WRITEME
	 */
	public void hit (final AbstractUser victim) {
		if (null != getHitEffect ()) {
			getHitEffect ().hitForDamage (victim);
		}
		destroy ();
		PhysicsScheduler.remove (myWatcher);
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
	 * WRITEME: Document this method brpocock@star-hope.org
	 */
	public void miss () {
		if (null != missEffect) {
			missEffect.damageMiss ();
		}
		destroy ();
		PhysicsScheduler.remove (myWatcher);
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
	public void sendResponse (final AbstractDatagram datagram) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#sendWardrobe()
	 */
	@Override
	public void sendWardrobe () {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method sendWardrobe in AbstractUser, added Jan 31, 2012 by brpocock. TODO.");
		
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setAgeGroupToSystem()
	 */
	@Override
	public void setAgeGroupToSystem () {
		// no op
	}
	
	/**
	 * @param myAttacker the attacker to set
	 */
	public void setAttacker (final AbstractUser myAttacker) {
		attacker = myAttacker;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setBaseColor(org.starhope.appius.types.Colour)
	 */
	@Override
	public void setBaseColor (final Colour aColour) {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method setBaseColor in AbstractUser, added Jan 31, 2012 by brpocock. TODO.");
		
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
	public void setExtraColor (final Colour aColour) {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method setExtraColor in AbstractUser, added Jan 31, 2012 by brpocock. TODO.");
		
	}
	
	/**
	 * @param newHitEffect the hitEffect to set
	 */
	public void setHitEffect (final HitHandler newHitEffect) {
		hitEffect = newHitEffect;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setLastActive()
	 */
	@Override
	public void setLastActive () {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#setMail(java.lang.String)
	 */
	@Override
	public void setMail (final String email) throws GameLogicException {
		throw new GameLogicException ("Ejecta", this, email);
	}
	
	/**
	 * @param newMissEffect the missEffect to set
	 */
	public void setMissEffect (final MissHandler newMissEffect) {
		missEffect = newMissEffect;
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
	 * @see org.starhope.appius.user.AbstractUser#setVariable(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public void setVariable (final String varName,
			final String varValue) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#takeAttack(org.starhope.appius.game.DamageTypeRanks)
	 */
	@Override
	public boolean takeAttack (final DamageTypeRanks aAttack) {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method takeAttack in AbstractUser, added Jan 31, 2012 by brpocock. TODO.");
		return false;
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		/*
		 * TODO Jan 31, 2012 brpocock Auto-generated method stub
		 */
		BugReporter
				.getReporter ("srv")
				.reportBug (
						"Unimplemented method toJSON in AbstractUser, added Jan 31, 2012 by brpocock. TODO.");
		return null;
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
	
}
