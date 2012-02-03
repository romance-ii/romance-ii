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
 * along with this program. If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.user;

import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map.Entry;
import java.util.Queue;
import java.util.Set;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ConcurrentSkipListSet;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.AlreadyExistsException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.ParameterException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.GameRoom;
import org.starhope.appius.game.GameStateFlag;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.RoomChannel;
import org.starhope.appius.game.Zone;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.geometry.Polygon;
import org.starhope.appius.net.ServerThread;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.physica.Geometry;
import org.starhope.appius.physica.Kalendor;
import org.starhope.appius.services.ClodiaSecunda;
import org.starhope.appius.sys.admin.Security;
import org.starhope.appius.sys.admin.SecurityCapability;
import org.starhope.appius.sys.op.FilterResult;
import org.starhope.appius.sys.op.FilterStatus;
import org.starhope.appius.types.AgeBracket;
import org.starhope.appius.types.Colour;
import org.starhope.appius.util.AcceptsMetronomeTicks;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;
import org.starhope.util.types.Pair;

/**
 * This is the base class from which NPCs are derived.
 *
 * @author brpocock@star-hope.org
 */
public abstract class AbstractNonPlayerCharacter extends GeneralUser
		implements AcceptsMetronomeTicks {

	/**
     * WRITEME: Document this type.
     *
     * @author brpocock@star-hope.org
     */
    private final class RealSpeakRunner implements Runnable {
        /**
         * WRITEME: Document this brpocock@star-hope.org
         */
        private final AbstractNonPlayerCharacter npc;
        /**
         * WRITEME: Document this brpocock@star-hope.org
         */
		private final Room room;
        /**
         * WRITEME: Document this brpocock@star-hope.org
         */
		private final String speech;

		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 *
		 * @param anNPC WRITEME
		 * @param newSpeech WRITEME
		 * @param newRoom WRITEME
		 */
        RealSpeakRunner (final AbstractNonPlayerCharacter anNPC,
                final String newSpeech, final Room newRoom) {
            npc = anNPC;
            speech = newSpeech;
            room = newRoom;
        }

        @Override
        public void run () {
			if (null == room || null == npc || null == speech) {
				return;
			}
            room.speak_actually (npc, speech, new FilterResult (
                    FilterStatus.Ok, "NPC"), null);
            lastSpoken = System.currentTimeMillis ();
        }
    }

	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -6400835991779285364L;

	/**
	 * WRITEME brpocock@star-hope.org Jul 21, 2010
	 *
	 * @param name whom to greet
	 * @return an “appropriate” greeting of some kind
	 */
    public static String getGreeting (final String name) {
        final String nameStripped = AbstractNonPlayerCharacter
        .getNameStripped (name);
        final String [] temporaryGreetings = { "Hi, %s", "Howdy, %s",
                "Hey there, %s", "Hey, %s, how are you?",
                "How's it going, %s?", "Nice to see you, %s!",
                "%s! You're back!", "%s", "Yo, %s… what's up?" };
        return String.format (temporaryGreetings [AppiusConfig
                                                  .getRandomInt (0, temporaryGreetings.length)],
                                                  nameStripped);
    }

	/**
     * @param name any user's name
     * @return the name truncated to before the $ (if any)
     */
    public static String getNameStripped (final String name) {
        final int dollar = name.indexOf ('$');
        if (dollar > 0) {
            return name.substring (0, dollar);
        }
        return name;
    }

	/**
     * WRITEME
     */
	protected final List <String> buddyList = new LinkedList <String> ();

    /**
	 * a queue of arbitrary things that Harmony might say, if she gets
	 * bored.
	 */
	protected Queue <String> casualSpeechQueue = new ConcurrentLinkedQueue <String> ();
	
	/**
	 * the rate at which speech is emitted
	 */
	protected long casualSpeechRate = 5324;

    /**
     * WRITEME
     */
	private final List <String> ignoreList = new LinkedList <String> ();

    /**
     * WRITEME
     */
	protected final int instanceID;
	
	/**
	 * Just fetch the Kalendor once, and keep working with it, rather
	 * than fucking around with fetching it every time.
	 */
	protected final Kalendor kalendor = AppiusClaudiusCaecus
			.getKalendor ();

    /**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
    protected long lastActive;

    /**
     * Time at which we last spoke
     */
    protected long lastSpoken = 0;

    /**
     * @param login the user login of the account for which this NPC
     *            should be instantiated.
     * @throws NotFoundException if the user login given doesn't yield a
     *             valid data record
     * @throws GameLogicException if the user record isn't an NPC
     */
    public AbstractNonPlayerCharacter (final String login)
    throws NotFoundException, GameLogicException {
        this (Nomenclator.getDataRecord (UserRecord.class, login));
    }

	/**
	 * WRITEME
	 *
	 * @param dataRecord WRITEME
	 * @throws GameLogicException for hate
	 */
    protected AbstractNonPlayerCharacter (final UserRecord dataRecord)
    throws GameLogicException {
        super (dataRecord);
        if (AgeBracket.System != userRecord.getAgeGroup ()) {
            throw new GameLogicException ("not NPC", dataRecord, this);
        }
        instanceID = getInstanceID ();
		Nomenclator.noteNPC (this, dataRecord);

		new ClodiaSecunda (this, Thread.currentThread ()).run ();
        AppiusClaudiusCaecus.add (this);
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
        // no op
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
        if (content.startsWith (" ::")) {
            try {
                this.getClass ().getMethod (content.substring (3))
                .invoke (this);
                AppiusClaudiusCaecus.blather (getDebugName (),
                        getRoom ().getDebugName (), "::1",
                        "called method " + content, false);
            } catch (final Exception e) {
                AppiusClaudiusCaecus.reportBug (e);
            }
            return;
        }
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
     *      org.starhope.appius.game.Room, java.lang.String)
     */
    @Override
    public void acceptPublicMessage (final AbstractUser sender,
			final RoomChannel channel, final String message) {
		if (channel.getRoom () == currentRoom) {
            acceptPublicMessage (sender, message);
        }
    }


    /**
     * @see org.starhope.appius.game.RoomListener#acceptPublicMessage(org.starhope.appius.user.AbstractUser,
     *      java.lang.String)
     */
    @Override
    public void acceptPublicMessage (final AbstractUser from,
            final String message) {
        // default no-op
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#acceptSuccessReply(java.lang.String,
     *      org.json.JSONObject, org.starhope.appius.game.Room)
     */
    @Override
    public void acceptSuccessReply (final String command,
            final JSONObject jsonData, final Room room) {
        if ("beam".equals (command)) {
            try {
                try {
                    setRoom (currentRoom.getZone ().getRoomByName (
                            jsonData.getString ("room")));
                } catch (final NotFoundException e) {
                    AppiusClaudiusCaecus
                    .reportBug (
                            "Caught a NotFoundException in AbstractNonPlayerCharacter.acceptSuccessReply(beam) ",
                            e);
                }
            } catch (final JSONException e) {
                AppiusClaudiusCaecus
                .reportBug (
                        "Caught a JSONException in AbstractNonPlayerCharacter.acceptSuccessReply ",
                        e);
            }
            return;
        }
        if ("buddyRequest".equals (command)) {

            if (jsonData.has ("buddy")) {

                AbstractUser bud;
                try {
                    bud = Nomenclator.getUserByLogin (jsonData
                            .getString ("buddy"));
                } catch (final JSONException e1) {
                    AppiusClaudiusCaecus
                    .reportBug (
                            "Caught a JSONException in AbstractNonPlayerCharacter.acceptSuccessReply(buddyRequest) ",
                            e1);
                    return;
                }

                if (bud.isNPC ()) {
                    return;
                }

                addBuddy (bud);
                bud.addBuddy (this);

                try {
                    jsonData.put ("buddy", getAvatarLabel ());
                    jsonData.put ("isApproved", true);
                } catch (final JSONException e) {
                    AppiusClaudiusCaecus
                    .reportBug (
                            "Caught a JSONException in AbstractNonPlayerCharacter.acceptSuccessReply(buddyRequest) ",
                            e);
                }

                bud.acceptSuccessReply ("addToList", jsonData, room);
            } else {
                // they requested us, return the favour.
                try {
                    final AbstractUser requestor = Nomenclator
                    .getUserByLogin (jsonData
                            .getString ("sender"));
                    if (requestor.getAgeGroup () == AgeBracket.System) {
                        return;
                    }
                    inviteBuddy (requestor);
                } catch (final JSONException e) {
                    AppiusClaudiusCaecus
                    .reportBug (
                            "Caught a JSONException in AbstractNonPlayerCharacter.acceptSuccessReply/addToList/sender ",
                            e);
                }

            }
        }
        // AppiusClaudiusCaecus
        // .reportBug
        // ("unimplemented AbstractNonPlayerCharacter::acceptSuccessReply (brpocock@star-hope.org, Jun 22, 2010)");

    }

    /**
     * WRITEME: Document this method brpocock@star-hope.org
     *
     * @param whichList WRITEME
     * @param users WRITEME
     */
    public void acceptUserList (final String whichList,
			final List <String> users) {
        List <String> list = null;
        if ("$buddy".equals (whichList)) {
            list = buddyList;
        }
        if ("$ignore".equals (whichList)) {
            list = ignoreList;
        }
        if (null == list) {
            return;
        }
		for (final String someone : users) {
			list.add (someone);
        }
    }

    /**
     * @see org.starhope.appius.user.GeneralUser#addBuddy(org.starhope.appius.user.AbstractUser)
     */
    @Override
    public void addBuddy (final AbstractUser buddy) {
        buddyList.add (buddy.getAvatarLabel ());
        super.addBuddy (buddy);
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
    public void addItem (final int itemID) {
        userRecord.getInv ().add (itemID);
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#canTalk()
     */
    @Override
    public boolean canTalk () {
        return userRecord.canTalk ();
    }

    /**
     * WRITEME
     */
    public void destroy () {
        if (null != getRoom ()) {
            getRoom ().part (this);
        }
		setRoom (null);
        AppiusClaudiusCaecus.remove (this);
        Nomenclator.removeInstanceNPC (this);
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#doTransport()
     */
    @Override
    public void doTransport () {
        speak (getRoom (), "Bye-bye!");
    }


    /**
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals (final Object obj) {
        if ( ! (obj instanceof AbstractNonPlayerCharacter)) {
            return false;
        }
        return compareTo (obj) == 0;

    }

    /**
	 * Get all rooms currently accessible from the present room, via normal doors.
	 * @return the set of all rooms potentially accessible
	 */
	protected Set <String> getAccessibleRooms () {
		Set <String>accessible = new ConcurrentSkipListSet <String> ();
		accessible.add (getRoom ().getMoniker ());
		Set <String>seen = new ConcurrentSkipListSet <String> ();
		while (!accessible.containsAll (seen)) {
			for ( String moniker : accessible ) {
				if (seen.contains(moniker)) {
					continue;
				}
				final Room r;
				try {
					r = getZone ().getRoomByName (moniker);
				} catch (NotFoundException e) {
continue;				}
				for (Pair <String, Polygon> exit : r.getExits ().values()) {
					accessible.add (exit.head ());
				}
			}
		}
		return accessible;
	}

    /**
     * @see org.starhope.appius.user.AbstractUser#getAvatarClass()
     */
    @Override
    public AvatarClass getAvatarClass () {
        return userRecord.getAvatarClass ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getAvatarLabel()
     */
    @Override
    public String getAvatarLabel () {
        return userRecord.getLogin () + "$" + instanceID;
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getBaseColor()
     */
    @Override
    public Colour getBaseColor () {
        return userRecord.getBaseColor ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getBuddyListNames()
     */
    @Override
    public Collection <String> getBuddyListNames () {
		Iterator <String> i;
		final List <String> names = new LinkedList <String> ();
		try {
			i = getUserListIterator ("$buddy");
			while (i.hasNext ()) {
				names.add (i.next ());
			}
		} catch (ParameterException e) {
			BugReporter.getReporter ("srv").reportBug (e);
		}
        return names;
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getDebugName()
     */
    @Override
    public String getDebugName () {
        return userRecord.getLogin () + "=#" + userRecord.getUserID ()
        + " NPC $(" + instanceID + ") as "
        + this.getClass ().getCanonicalName ();
    }

    /**
     * @return An unique ID for this instance of
     */
    protected abstract int getInstanceID ();

    /**
     * @see org.starhope.appius.user.AbstractUser#getIPAddress()
     */
    @Override
    public String getIPAddress () {
        return "::1";
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getKickedMessage()
     */
    @Override
    public String getKickedMessage () {
        return "";
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
        return userRecord.getLanguage ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getLocation()
     */
    @Override
    public Coord3D getLocation () {
        return location;
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getMail()
     */
    @Override
    public String getMail () {
        return userRecord.getMail ();
    }

    /**
     * @see org.starhope.appius.util.HasName#getName()
     */
    @Override
    public String getName () {
        return userRecord.getLogin () + '$' + instanceID;
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getNameApprovedAt()
     */
    @Override
    public Date getNameApprovedAt () {
        return userRecord.getNameApprovedAt ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getNameRequestedAt()
     */
    @Override
    public Date getNameRequestedAt () {
        return userRecord.getNameRequestedAt ();
    }

    /**
     * @return WRITEME
     * @see org.starhope.appius.user.AbstractUser#getPublicInfo()
     */
    public JSONObject getPublicInfo_new () {
        final JSONObject userInfo = new JSONObject ();
        try {
            final AvatarClass avatarClass = userRecord
            .getAvatarClass ();
            userInfo.put ("avatar", avatarClass.getFilename ());
            userInfo.put ("avatarClass", avatarClass.getID ());
            userInfo.put ("chatFG", userRecord.getChatFG ().toInt ());
            userInfo.put ("chatBG", userRecord.getChatBG ().toInt ());
            userInfo.put ("avatarClass_B", avatarClass
                    .getDefaultBaseColor ().toLong ());
            userInfo.put ("avatarClass_E", avatarClass
                    .getDefaultExtraColor ().toLong ());
            userInfo.put ("avatarClass_P", avatarClass
                    .getDefaultPatternColor ().toLong ());
            final Room room = getRoom ();
            if (null != room) {
                userInfo.put ("inRoom", room.getMoniker ());
            }
            userInfo.put ("userName", getAvatarLabel ());
            final JSONObject colors = new JSONObject ();
            if (avatarClass.canColor ()) {
                colors.put ("0", userRecord.getBaseColor ().toInt ());
                colors.put ("1", userRecord.getExtraColor ().toInt ());
                colors.put ("2", User.getOutlineColourForBaseColour (
                        userRecord.getBaseColor ()).toInt ());
            }
            userInfo.put ("colors", colors);
            userInfo.put ("clothes", getInventory ()
                    .getActiveClothing_JSON ());
            userInfo.put ("gameItems", new JSONObject ());
            final JSONObject vars = new JSONObject ();
            vars.put ("d", getD ());
            for (final java.util.Map.Entry <String, String> e : userVariables
                    .entrySet ()) {
                vars.put (e.getKey (), e.getValue ());
            }
            userInfo.put ("vars", vars);
            userInfo.put ("id", getUserID () + "." + instanceID);
        } catch (final JSONException e) {
            AppiusClaudiusCaecus.reportBug (e);
        }
        return userInfo;
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#getServerThread()
     */
    @Override
    public ServerThread getServerThread () {
        return null;
    }


    /**
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode () {
        return LibMisc.makeHashCode (getDebugName ());
    }

    /**
     * Ask someone to be my friend
     *
     * @param newBuddy that special someone
     */
    public void inviteBuddy (final AbstractUser newBuddy) {
        if (newBuddy instanceof AbstractNonPlayerCharacter) {
            return;
        }
        final JSONObject request = new JSONObject ();
        try {
            request.put ("sign", UserList.getBuddyApprovalCookie (this,
                    newBuddy));
            request.put ("sender", getAvatarLabel ());
        } catch (final JSONException e) {
            AppiusClaudiusCaecus
            .reportBug (
                    "Caught a JSONException in AbstractNonPlayerCharacter.inviteBuddy ",
                    e);
        }
        newBuddy.acceptSuccessReply ("buddyRequest", request,
                getRoom ());
    }

    /**
     * @param who someone who might be my friend
     * @return true, if they're on my buddy list
     */
    public boolean isBuddy (final AbstractUser who) {
        return buddyList.contains (who.getAvatarLabel ());
    }

    /**
     * This is an overriding method.
     *
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
     * @see org.starhope.appius.user.GeneralUser#isPaidMember()
     */
    @Override
    public boolean isPaidMember () {
   return true; // sure, why not?
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#kick(org.starhope.appius.user.AbstractUser,
     *      java.lang.String, int)
     */
    @Override
    public void kick (final AbstractUser u, final String kickReason,
            final int duration) throws PrivilegeRequiredException {
        final SecurityCapability sysOpCap = new SecurityCapability (
                SecurityCapability.CAP_SYSOP_COMMANDS);
        if ( !Security.hasCapability (u, sysOpCap)) {
            throw new PrivilegeRequiredException (sysOpCap);
        }
        destroy ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#liftBan(org.starhope.appius.user.AbstractUser)
     */
    @Override
    public void liftBan (final AbstractUser authority)
    throws PrivilegeRequiredException {
        authority
        .acceptMessage ("Lift Ban", userRecord.getLogin (),
        "Thanks for trying to lift the ban on me, but I'm not a player.");
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#needsParent()
     */
    @Override
    public boolean needsParent () {
        return false;
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
        if (null == currentRoom) {
            return;

        }
        Room newRoom;
        try {
            newRoom = refugeeZone.getRoomByName (currentRoom
                    .getMoniker ());
        } catch (final NotFoundException e) {
            AppiusClaudiusCaecus
            .reportBug (
                    "Caught a NotFoundException in AbstractNonPlayerCharacter.sendMigrate ",
                    e);
            return;
        }
        currentRoom.part (this);

        newRoom.join (this);
        currentRoom = newRoom;

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
		// Nothing to do here in general
	}
	
	/**
	 * @see org.starhope.appius.user.AbstractUser#sendResponse(org.json.JSONObject)
	 */
    @Override
    public void sendResponse (final JSONObject result) {
        // no op
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#setLastActive()
     */
    @Override
    public void setLastActive () {
        lastActive = System.currentTimeMillis ();
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#setMail(java.lang.String)
     */
    @Override
    public void setMail (final String email) throws GameLogicException {
        userRecord.setMail (email);
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#setParent(org.starhope.appius.user.Parent)
     */
    @Override
    public void setParent (final Parent newParent)
    throws GameLogicException, ForbiddenUserException,
    AlreadyExistsException {
        throw new GameLogicException ("robots have no mothers", this,
                newParent);
    }

    /**
     * @see org.starhope.appius.user.AbstractUser#speak(org.starhope.appius.game.Room,
     *      java.lang.String)
     */
    @Override
    public void speak (final Room room, final String string) {
        final AbstractNonPlayerCharacter npc = this;
        final Runnable toReallySpeak = new RealSpeakRunner (npc,
                string, room);
        if (lastSpoken < System.currentTimeMillis () - 1000) {
            toReallySpeak.run ();
        } else {
            kalendor.schedule (lastSpoken + casualSpeechRate,
                    toReallySpeak);
        }
    }

	/**
     * @param text WRITEME
     */
    public void speakCasually (final String text) {
        String baseName = AbstractNonPlayerCharacter
        .getNameStripped (getAvatarLabel ());
        baseName = Character.toUpperCase (baseName.charAt (0))
        + baseName.substring (1).toLowerCase (Locale.ENGLISH);
        final String key = "npc." + baseName + "." + text;
        if (LibMisc.hasText (key)) {
            casualSpeechQueue.add (LibMisc.getText (key));
        } else if (LibMisc.hasText (key + ".d")) {
            casualSpeechQueue.add (LibMisc.getText (key
                    + "."
                    + AppiusConfig.getRandomInt (0,
                            Integer.parseInt (LibMisc.getText (key
                                    + ".d")) - 1)));
        } else {
            AppiusClaudiusCaecus
            .reportDesignBug ("Missing NPC character dialogue: “"
                    + key + "”");
        }
    }

	/**
     * @see org.starhope.appius.util.AcceptsMetronomeTicks#tick(long,
     *      long)
     */
    @Override
    public void tick (final long currentTime, final long deltaTime)
    throws UserDeadException {
        if (lastSpoken < currentTime - casualSpeechRate
                && casualSpeechQueue.size () > 0) {
            speak (getRoom (), casualSpeechQueue.remove ());
            lastSpoken = currentTime;
        }
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
    @Deprecated
    public String toSFSXML () {
        final StringBuilder reply = new StringBuilder ();
        reply.append ("<u i='");
        reply.append (getUserID ());
        reply.append ("' m='0'><n><![CDATA[");
        reply.append (getAvatarLabel ().toLowerCase (Locale.ENGLISH));
        reply.append ("]]></n><vars>");
        for (final Entry <String, String> var : getUserVariables ()
                .entrySet ()) {
            reply.append ("<var n='");
            reply.append (var.getKey ());
            reply.append ("' t='s'><![CDATA[");
            reply.append (var.getValue ());
            reply.append ("]]></var>");
        }
        reply.append ("</vars></u>");
        return reply.toString ();
    }

	/**
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString () {
    	return getDebugName ();
    }

	/**
	 * Perform some action when the current movement-target position has
	 * been reached
	 *
	 * @param runnable what to do when the target position is (or at
	 *            least, should have been) reached
	 * @return the handle to the event, in case it's needed to cancel it
	 * @see Kalendor#schedule(long, Runnable)
	 * @see Kalendor#cancel(long)
	 * @see Geometry#getTimeToTarget(AbstractUser, long)
	 */

	public long whenAtTarget (final Runnable runnable) {
		return pathFinder.whenAtTarget (runnable);
	}

}
