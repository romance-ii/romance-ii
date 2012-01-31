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
package org.starhope.appius.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.json.JSONException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.SFX;
import org.starhope.appius.game.inventory.InventoryPowerController;
import org.starhope.appius.game.inventory.RealItem;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * Singleton meant to manage user effects and powers to ensure that they
 * are accurately tracked regardless of users logging in or out or
 * people being removed from the cache and garbage collected
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
public class UserPowerKeeper {
	
	/**
	 * Private class used to hold information about the individual
	 * powers
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
	private class UserPowerInfo {
		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		Long ID = new Long ( -1L);
		
		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		TempPower power;
		
		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		int realItemID;
		
		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		private SFX userSFX = null;
		
		/**
		 * WRITEME: Document this constructor
		 * ewinkelman@resinteractive.com
		 */
		UserPowerInfo () {
		}
		
		/**
		 * @see java.lang.Object#equals(java.lang.Object)
		 */
		@Override
		public boolean equals (final Object obj) {
			if (this == obj) {
				return true;
			}
			if (obj == null) {
				return false;
			}
			if ( ! (obj instanceof UserPowerInfo)) {
				return false;
			}
			final UserPowerInfo other = (UserPowerInfo) obj;
			if (realItemID != other.realItemID) {
				return false;
			}
			return true;
		}
		
		/**
		 * WRITEME: Document this method ewinkelman@resinteractive.com
		 * 
		 * @return WRITEME 
		 */
		SFX getSFX () {
			if ( (userSFX == null) && (power != null)
					&& (power.userSFX () != null)) {
				final String sfxString = power.userSFX ();
				// If the string starts with a { then it is a JSON
				// defined custom power
				// Otherwise assume that it is the name of a
				// database stored power
				if (sfxString.startsWith ("{")) {
					try {
						userSFX = SFX.getCustomSFX (sfxString);
					} catch (final JSONException e) {
						UserPowerKeeper.log
								.error ("Exception", e);
					}
				} else {
					try {
						userSFX = Nomenclator.getDataRecord (
								SFX.class, sfxString);
					} catch (final NotFoundException e) {
						UserPowerKeeper.log
								.error ("Exception", e);
					}
				}
			}
			return userSFX;
		}
		
		/**
		 * @see java.lang.Object#hashCode()
		 */
		@Override
		public int hashCode () {
			final int prime = 31;
			int result = 1;
			result = (prime * result) + realItemID;
			return result;
		}
		
	}
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static UserPowerKeeper instance = new UserPowerKeeper ();
	
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (UserPowerKeeper.class);
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	public static UserPowerKeeper instance () {
		return UserPowerKeeper.instance;
	}
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private final Map <String, Set <UserPowerInfo>> powerUsers = Collections
			.synchronizedMap (new HashMap <String, Set <UserPowerInfo>> ());
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 */
	private UserPowerKeeper () {
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @param user WRITEME 
	 * @param realItemID WRITEME 
	 * @param power WRITEME 
	 */
	public void addPower (final AbstractUser user,
			final int realItemID, final TempPower.Factory power) {
		boolean found = false;
		// Check to see if there's already an instance of this power
		for (final UserPowerInfo userPowerInfo : getUserPowerInfo (user)) {
			if (userPowerInfo.realItemID == realItemID) {
				// If found, then update the duration
				found = true;
				if (userPowerInfo.power.stacksWithSelf ()) {
					userPowerInfo.power
							.setRemainingDuration (userPowerInfo.power
									.getRemainingDuration ()
									+ power.onUse (
											new InventoryPowerController (
													power,
													user.getInventory ()),
											null)
											.getDuration ());
				} else {
					userPowerInfo.power = power.onUse (
							new InventoryPowerController (power,
									user.getInventory ()),
							null);
				}
				break;
			}
		}
		// If not, add it
		if ( !found) {
			final UserPowerInfo info = new UserPowerInfo ();
			info.power = power.onUse (new InventoryPowerController (
					power, user.getInventory ()), null);
			info.realItemID = realItemID;
			powerUsers.get (user.getAvatarLabel ()).add (info);
			final SFX sfx = info.getSFX ();
			if (sfx != null) {
				user.setSFX (info.getSFX ());
			}
		}
	}
	
	/**
	 * Gets the height scalar from any temporary powers that adjust the
	 * height
	 * 
	 * @param user WRITEME 
	 * @return WRITEME 
	 */
	public double getHeightScalar (final AbstractUser user) {
		double scalar = 0;
		for (final UserPowerInfo userPowerInfo : getUserPowerInfo (user)) {
			if (userPowerInfo.power instanceof HeightPower) {
				scalar += ((HeightPower) userPowerInfo.power)
						.getHeightScalar ();
			}
		}
		return scalar;
	}
	
	/**
	 * WRITEME: Document this method ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME 
	 */
	public Set <TempPower> getPowers (final AbstractUser user) {
		final Set <TempPower> result = new HashSet <TempPower> ();
		for (final UserPowerInfo info : getUserPowerInfo (user)) {
			result.add (info.power);
		}
		return result;
	}
	
	/**
	 * Gets the speed scalar from any temporary powers that adjust the
	 * speed
	 * 
	 * @param user WRITEME 
	 * @return WRITEME 
	 */
	public double getSpeedScalar (final AbstractUser user) {
		double scalar = 0;
		for (final UserPowerInfo userPowerInfo : getUserPowerInfo (user)) {
			if (userPowerInfo.power instanceof SpeedPower) {
				scalar += ((SpeedPower) userPowerInfo.power)
						.getSpeedScalar ();
			}
		}
		return scalar;
	}
	
	/**
	 * Gets the power info from the hashmap if available, and if not
	 * attempts to load it from the database
	 * 
	 * @param user WRITEME 
	 * @return WRITEME 
	 */
	private synchronized Set <UserPowerInfo> getUserPowerInfo (
			final AbstractUser user) {
		if ( !powerUsers.containsKey (user.getAvatarLabel ())) {
			// Add in powers saved in the database
			Connection con = null;
			PreparedStatement getPowers = null;
			ResultSet powers = null;
			try {
				con = AppiusConfig.getDatabaseConnection ();
				getPowers = con
						.prepareStatement ("SELECT * FROM userPowers WHERE userName=?");
				getPowers.setString (1, user.getAvatarLabel ());
				powers = getPowers.executeQuery ();
				final Set <UserPowerInfo> powerSet = new HashSet <UserPowerKeeper.UserPowerInfo> ();
				while (powers.next ()) {
					final UserPowerInfo userPowerInfo = new UserPowerInfo ();
					try {
						final RealItem item = Nomenclator
								.getDataRecord (
										RealItem.class,
										powers.getInt ("realItemID"));
						final TempPower.Factory power = item
								.getItemPowers () instanceof TempPower.Factory ? (TempPower.Factory) item
								.getItemPowers () : null;
						if (power != null) {
							userPowerInfo.ID = new Long (
									powers.getLong ("ID"));
							userPowerInfo.power = power
									.onUse (new InventoryPowerController (
											power,
											user.getInventory ()),
											powers.getString ("saveInfo"));
							userPowerInfo.realItemID = item
									.getRealID ();
							powerSet.add (userPowerInfo);
						}
					} catch (final NotFoundException e) {
						UserPowerKeeper.log
								.error ("Exception", e);
					}
				}
				powerUsers.put (user.getAvatarLabel (), powerSet);
			} catch (final SQLException e) {
				UserPowerKeeper.log.error ("Exception", e);
			} finally {
				LibMisc.closeAll (powers, getPowers, con);
			}
		}
		synchronized (powerUsers) {
			return new HashSet <UserPowerKeeper.UserPowerInfo> (
					powerUsers.get (user.getAvatarLabel ()));
		}
	}
	
	/**
	 * Shuts down the power keeper, saves all information and stops
	 * tracking user powers and durations. Should only be called when
	 * the server is shutting down
	 */
	public void shutdown () {
		synchronized (powerUsers) {
			for (final java.util.Map.Entry <String, Set <UserPowerInfo>> entry : powerUsers
					.entrySet ()) {
				final String name = entry.getKey ();
				final Set <UserPowerInfo> userPowerInfos = entry
						.getValue ();
				Connection con = null;
				PreparedStatement savePower = null;
				try {
					con = AppiusConfig.getDatabaseConnection ();
					for (final UserPowerInfo userPowerInfo : userPowerInfos) {
						savePower = con
								.prepareStatement ("INSERT INTO userPowers (ID,userName,realItemID,saveInfo) VALUES (?,?,?,?) ON DUPLICATE KEY UPDATE ID=LAST_INSERT_ID(ID), userName=VALUES(userName), realItemID=VALUES(realItemID), saveInfo=VALUES(saveInfo)");
						if (userPowerInfo.ID.longValue () >= 0) {
							savePower.setLong (1,
									userPowerInfo.ID
											.longValue ());
						} else {
							savePower.setNull (1, Types.BIGINT);
						}
						savePower.setString (2, name);
						savePower.setInt (3,
								userPowerInfo.realItemID);
						savePower.setString (4,
								userPowerInfo.power
										.getSaveInfo ());
						try {
							savePower.executeUpdate ();
							if (userPowerInfo.ID.longValue () <= 0) {
								final ResultSet rs = savePower
										.getGeneratedKeys ();
								if (rs.next ()) {
									userPowerInfo.ID = new Long (
											rs.getLong (1));
								}
							}
						} catch (final SQLException e) {
							UserPowerKeeper.log.error (
									"Exception", e);
						}
					}
				} catch (final SQLException e) {
					UserPowerKeeper.log.error ("Exception", e);
				} finally {
					LibMisc.closeAll (savePower, con);
				}
			}
		}
	}
	
	/**
	 * Updates the duration, and possibly effects, of the user's
	 * temporary powers
	 * 
	 * @param user WRITEME 
	 * @param currentTime WRITEME 
	 * @param deltaTime WRITEME 
	 * @return True if the powers indicate that something changed or a
	 *         power expired
	 */
	public boolean updateDuration (final AbstractUser user,
			final long currentTime, final long deltaTime) {
		boolean result = false;
		
		for (final UserPowerInfo userPowerInfo : getUserPowerInfo (user)) {
			result |= userPowerInfo.power.tick (currentTime,
					deltaTime);
			// Remove power from the database and hashmap if duration
			// has run out
			if (userPowerInfo.power.getRemainingDuration () <= 0L) {
				if (userPowerInfo.ID.longValue () >= 0L) {
					Connection con = null;
					PreparedStatement deletePower = null;
					try {
						con = AppiusConfig
								.getDatabaseConnection ();
						deletePower = con
								.prepareStatement ("DELETE FROM userPowers WHERE ID=?");
						deletePower.setLong (1,
								userPowerInfo.ID.longValue ());
						deletePower.execute ();
					} catch (final SQLException e) {
						UserPowerKeeper.log
								.error ("Exception", e);
					} finally {
						LibMisc.closeAll (deletePower, con);
					}
				}
				powerUsers.get (user.getAvatarLabel ()).remove (
						userPowerInfo);
				final SFX sfx = userPowerInfo.getSFX ();
				if (sfx != null) {
					user.deleteSFX (sfx);
				}
				result = true;
			}
		}
		
		return result;
	}
}
