/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * Affero General Public License for more details.
 * </p>
 * <p>
 * You should have received a copy of the GNU Affero General Public
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.net.datagram;

import java.util.Map;
import java.util.Map.Entry;

import org.starhope.appius.game.ChannelListener;
import org.starhope.appius.game.Room;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.AvatarClass;
import org.starhope.appius.user.Wallet;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ADPUserInfo extends ADPJSON {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private ADPUserAction action;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private AvatarClass avatarClass;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private boolean canTalk;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private long chatBackground;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private long chatForeground;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private ADPEquipment equipment;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private double height;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private boolean isPaid;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private ADPPowers powers;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Room room;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private int staffLevel;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private AbstractUser user;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private ADPUserSFX userSFX;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	final private ADPUserVar userVar;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Wallet wallet;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 */
	public ADPUserInfo (final ChannelListener s) {
		super ("user", s);
		userVar = new ADPUserVar (s);
		include (userVar);
	}
	
	/**
	 * @return the action
	 */
	public ADPUserAction getAction () {
		return action;
	}
	
	/**
	 * @return the avatarClass
	 */
	public AvatarClass getAvatarClass () {
		return avatarClass;
	}
	
	/**
	 * @return the chatBackground
	 */
	public long getChatBackground () {
		return chatBackground;
	}
	
	/**
	 * @return the chatForeground
	 */
	public long getChatForeground () {
		return chatForeground;
	}
	
	/**
	 * @return the equipment
	 */
	public ADPEquipment getEquipment () {
		return equipment;
	}
	
	/**
	 * @return the height
	 */
	public double getHeight () {
		return height;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	public ADPPowers getPowers () {
		return powers;
	}
	
	/**
	 * @return the room
	 */
	public Room getRoom () {
		return room;
	}
	
	/**
	 * @return the staffLevel
	 */
	public int getStaffLevel () {
		return staffLevel;
	}
	
	/**
	 * @return the user
	 */
	public AbstractUser getUser () {
		return user;
	}
	
	/**
	 * @return the userSFX
	 */
	public ADPUserSFX getUserSFX () {
		return userSFX;
	}
	
	/**
	 * @return the wallet
	 */
	public Wallet getWallet () {
		return wallet;
	}
	
	/**
	 * @return the canTalk
	 */
	public boolean isCanTalk () {
		return canTalk;
	}
	
	/**
	 * @return the isPaid
	 */
	public boolean isPaid () {
		return isPaid;
	}
	
	/**
	 * @param action the action to set
	 */
	public void setAction (final ADPUserAction action) {
		this.action = action;
		include (action);
	}
	
	/**
	 * @param avatarClass the avatarClass to set
	 */
	public void setAvatarClass (final AvatarClass avatarClass) {
		this.avatarClass = avatarClass;
		include (avatarClass.getDatagram (source));
	}
	
	/**
	 * @param canTalk the canTalk to set
	 */
	public void setCanTalk (final boolean canTalk) {
		this.canTalk = canTalk;
		setJSON ("canTalk", canTalk);
	}
	
	/**
	 * @param chatBackground the chatBackground to set
	 */
	public void setChatBackground (final long chatBackground) {
		this.chatBackground = chatBackground;
		setJSON ("chatBG", chatBackground);
	}
	
	/**
	 * @param chatForeground the chatForeground to set
	 */
	public void setChatForeground (final long chatForeground) {
		this.chatForeground = chatForeground;
		setJSON ("chatFG", chatForeground);
	}
	
	/**
	 * @param equipment the equipment to set
	 */
	public void setEquipment (final ADPEquipment equipment) {
		this.equipment = equipment;
		include (equipment);
	}
	
	/**
	 * @param height the height to set
	 */
	public void setHeight (final double height) {
		this.height = height;
		setJSON ("height", height);
	}
	
	/**
	 * @param isPaid the isPaid to set
	 */
	public void setPaid (final boolean isPaid) {
		this.isPaid = isPaid;
		setJSON ("isPaid", isPaid);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param powersDatagram WRITEME 
	 */
	public void setPowers (final ADPPowers powers) {
		this.powers = powers;
		include (powers);
	}
	
	/**
	 * @param room the room to set
	 */
	public void setRoom (final Room room) {
		this.room = room;
		setJSON ("inRoom", room.getFullMoniker ());
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param userSFXDatagram WRITEME 
	 */
	public void setSFX (final ADPUserSFX userSFXDatagram) {
		userSFX = userSFXDatagram;
		include (userSFXDatagram);
	}
	
	/**
	 * @param staffLevel the staffLevel to set
	 */
	public void setStaffLevel (final int staffLevel) {
		this.staffLevel = staffLevel;
		setJSON ("staffLevel", staffLevel);
	}
	
	/**
	 * @param user the user to set
	 */
	public void setUser (final AbstractUser user) {
		this.user = user;
		setJSON ("who", user.getAvatarLabel ());
		setJSON ("userID", user.getUserID ());
	}
	
	/**
	 * @param userSFX the userSFX to set
	 */
	public void setUserSFX (final ADPUserSFX userSFX) {
		this.userSFX = userSFX;
		include (userSFX);
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param vars WRITEME 
	 */
	public void setUserVars (final Map <String, String> vars) {
		for (final Entry <String, String> entry : vars.entrySet ()) {
			userVar.add (entry.getKey (), entry.getValue ());
		}
	}
	
	/**
	 * @param wallet the wallet to set
	 */
	public void setWallet (final Wallet wallet) {
		this.wallet = wallet;
		include (wallet.toDatagram (source));
	}
	
}
