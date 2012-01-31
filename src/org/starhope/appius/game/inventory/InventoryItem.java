/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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
package org.starhope.appius.game.inventory;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.npc.NullLoader;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.types.Colour;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.events.Action;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.CastsToJSON;
import org.starhope.appius.util.DataRecordFlushManager;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;
import org.starhope.appius.via.Setter;
import org.starhope.catullus.Copyable;
import org.starhope.util.LibMisc;

/**
 * <p>
 * The InventoryItem is the main class for all items which can be placed
 * into the user's inventory. It also has interface elements for the
 * common behaviour of “equipping” the item in some way, giving and
 * receiving items (including purchasing them and trading with other
 * players), and so forth.
 * </p>
 * <p>
 * WRITEME — {@link ItemEffects} {@link InventoryItemType},
 * {@link GenericItemReference}, and how they all get along
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class InventoryItem extends SimpleDataRecord <InventoryItem>
		implements Copyable <InventoryItem> {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -7833931788040090009L;
	
	/**
	 * get the inventory item with the given inventory slot ID
	 * 
	 * @param idByWhichToGet inventory slot number
	 * @return the item in that slot
	 */
	public static InventoryItem getByID (final int idByWhichToGet) {
		return InventoryItem.getByID (AppiusConfig
				.getRecordLoaderForClass (InventoryItem.class),
				idByWhichToGet);
	}
	
	/**
	 * Get an inventory item based upon the database ID
	 * 
	 * @param loader record loader to obtain the item
	 * @param idByWhichToGet the database ID of an inventory item of
	 *             any kind
	 * @return the item or null if there's no such item
	 */
	public static InventoryItem getByID (
			final RecordLoader <InventoryItem> loader,
			final int idByWhichToGet) {
		final InventoryItem i = new InventoryItem (loader);
		GenericItemReference kind;
		try {
			kind = Nomenclator.getDataRecord (
					GenericItemReference.class, idByWhichToGet);
		} catch (final NotFoundException e) {
			return null;
		}
		i.setItemID (idByWhichToGet);
		i.setType (kind.getInventoryItemType ());
		i.setActive (false);
		DataRecordFlushManager.update (AppiusConfig
				.getRecordLoaderForClass (InventoryItem.class), i);
		return i;
	}
	
	/**
	 * if true, the item is equipped/active
	 */
	protected boolean active = false;
	
	/**
	 * The colours that define the appearance of this item. XXX: only
	 * single-colour items are supported in Tootsville™ right now.
	 */
	final List <Colour> colours = new CopyOnWriteArrayList <Colour> ();
	
	/**
	 * @see #getItemEffects()
	 */
	private ItemEffects effects = null;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String facing;
	
	/**
	 * The health of the item
	 */
	private BigDecimal health = BigDecimal.ZERO;
	
	/**
	 * the item ID
	 */
	protected int itemID;
	
	/**
	 * user owning this item
	 */
	protected AbstractUser owner = null;
	
	/**
	 * room number (of all rooms owned by the given owner)
	 */
	private int roomNumber = -1;
	
	/**
	 * The slot/series in which this occurs in the player's inventory
	 */
	protected int slotNumber = -1;
	
	/**
	 * WRITEME
	 */
	protected InventoryItemType type;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private double x = 0;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private double y = 0;
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private double z = 0;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public InventoryItem () {
		super (InventoryItem.class);
	}
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param loader the loader
	 */
	public InventoryItem (final RecordLoader <InventoryItem> loader) {
		super (loader);
	}
	
	/**
	 * @param delta the amount by which to change the health
	 */
	public void changeHealth (final int delta) {
		synchronized (health) {
			health = health.add (BigDecimal.valueOf (delta));
		}
		checkEquipChange ();
		if (0 != delta) {
			changed ();
		}
	}
	
	/**
	 * Check whether the user needs an equipment update
	 */
	private void checkEquipChange () {
		if (isBeingLoaded ()) {
			return;
		}
		final GenericItemReference item = getGenericItem ();
		if (null == item) {
			BugReporter.getReporter ("srv").reportBug (
					"Item ID doesn't resolve to a GenericItemReference?"
							+ itemID);
			return;
		}
		final EquipType equipType = item.getEquipType ();
		try {
			owner = getOnlineOwner ();
			if (equipType != EquipType.SILENT) {
				owner.getInventory ().notifyEquipChange ();
			}
		} catch (final NotFoundException e) {
			// no op
		}
	}
	
	/**
	 * @see org.starhope.catullus.Copyable#copyProtoype(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public InventoryItem copyProtoype (final InventoryItem prototype) {
		active = prototype.active;
		colours.clear ();
		for (final Colour colour : prototype.colours) {
			colours.add (colour);
		}
		facing = prototype.facing;
		health = prototype.health;
		itemID = prototype.itemID;
		owner = prototype.getOwner ();
		roomNumber = prototype.roomNumber;
		slotNumber = prototype.slotNumber;
		type = prototype.type;
		x = prototype.x;
		y = prototype.y;
		z = prototype.z;
		return this;
	}
	
	/**
	 * Destroy an item altogether.
	 */
	public void destroy () {
		if (null != getOwner ()) {
			getOwner ().getInventory ().remove (this);
		}
		setOwnerID (1);
		myLoader.removeRecord (this);
		setRecordLoader (new NullLoader <InventoryItem> (
				InventoryItem.class));
		setOwnerID ( -1);
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		return (obj instanceof InventoryItem)
				&& this.getClass ().isInstance (obj)
				&& ( ((InventoryItem) obj).getSlotNumber () == getSlotNumber ());
	}
	
	/**
	 * Set this item to be active (equipped).
	 */
	public void equip () {
		setActive (true);
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () {
		return slotNumber;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () {
		return String.valueOf (slotNumber);
	}
	
	/**
	 * @return the first colour of this item. (the only colour for some
	 *         items)
	 */
	public Colour getColor () {
		return getColour ();
	}
	
	/**
	 * @return the first colour of this item (the only colour for some
	 *         items), or null if the item is completely uncoloured.
	 */
	public Colour getColour () {
		if (colours.size () == 0) {
			return null;
		}
		return colours.get (0);
	}
	
	/**
	 * @param index the colour index position
	 * @return the colour at that index, or null
	 */
	public Colour getColour (final int index) {
		if (index < colours.size ()) {
			return colours.get (index);
		}
		return null;
	}
	
	/**
	 * @return any/all colours applied to this item
	 */
	public List <Colour> getColours () {
		final LinkedList <Colour> ret = new LinkedList <Colour> ();
		ret.addAll (colours);
		return ret;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return WRITEME
	 */
	public String getFacing () {
		return facing;
	}
	
	/**
	 * @return get a {@link GenericItemReference} of the same kind as
	 *         this
	 */
	public GenericItemReference getGenericItem () {
		try {
			return Nomenclator.getDataRecord (
					GenericItemReference.class, itemID);
		} catch (final NotFoundException e) {
			BugReporter.getReporter ("srv").reportBug (
					"User has an instance of an item ID we don't recognize: "
							+ itemID, e);
			return null;
		}
	}
	
	/**
	 * @return the health of this item
	 */
	public BigDecimal getHealth () {
		return health;
	}
	
	/**
	 * @return the item's ID (as a kind of item)
	 */
	public int getID () {
		return itemID;
	}
	
	/**
	 * Get an {@link ItemEffects} class for this item, if any
	 * 
	 * @return item effects class for this item
	 * @throws NotFoundException if no item effects are defined
	 */
	public synchronized ItemEffects getItemEffects ()
			throws NotFoundException {
		if (null == effects) {
			effects = ItemEffects.forItem (this);
		}
		return effects;
	}
	
	/**
	 * @return the store item ID, of which this item is an instance
	 */
	public int getItemID () {
		return itemID;
	}
	
	/**
	 * If the owner is online, get the owner
	 * 
	 * @return the online owner's object
	 * @throws NotFoundException if the owner isn't online (or isn't a
	 *              valid ownerID)
	 */
	private AbstractUser getOnlineOwner () throws NotFoundException {
		if (null == owner) {
			throw new NotFoundException ("Item has no owner:"
					+ toString ());
		}
		if (1 <= owner.getUserID ()) {
			throw new NotFoundException (
					"Not expressing online owner for ownerID="
							+ owner.getUserID ());
		}
		if (owner.isOnline ()) {
			return owner;
		}
		throw new NotFoundException ("Owner is offline");
	}
	
	/**
	 * @return owner
	 */
	public AbstractUser getOwner () {
		return owner;
	}
	
	/**
	 * @return owner's userID
	 */
	public int getOwnerID () {
		if (null == owner) {
			return -1;
		}
		return owner.getUserID ();
	}
	
	/**
	 * @return the room number in which this item is found, or -1 if it
	 *         is not placed in a room.
	 */
	public int getRoomIndex () {
		if (false == active) {
			return -1;
		}
		return roomNumber;
	}
	
	/**
	 * @return {@link #slotNumber}
	 */
	public int getSlotNumber () {
		return slotNumber;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2231 $";
	}
	
	/**
	 * @return the type of item, which this is.
	 */
	public InventoryItemType getType () {
		if (null == type) {
			throw AppiusClaudiusCaecus
					.fatalBug ("item type = null for ID = "
							+ itemID
							+ " owner "
							+ (null == owner ? "null!" : owner
									.getDebugName ()));
		}
		return type;
	}
	
	/**
	 * @return the type ID
	 */
	public int getTypeID () {
		if (null == type) {
			throw AppiusClaudiusCaecus
					.fatalBug ("item type = null for ID = "
							+ itemID
							+ " owner "
							+ (null == owner ? "null!" : owner
									.getDebugName ()));
		}
		return type.getID ();
	}
	
	/**
	 * @return x ordinate
	 */
	public double getX () {
		if (false == active) {
			return -1;
		}
		return x;
	}
	
	/**
	 * @return y abcessa
	 */
	public double getY () {
		if (false == active) {
			return -1;
		}
		return y;
	}
	
	/**
	 * @return Z ordinate
	 */
	public double getZ () {
		if (false == active) {
			return -1;
		}
		return z;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getCacheableIdent ());
	}
	
	/**
	 * @return true, if the item is active/in use/equipped
	 */
	public boolean isActive () {
		return active;
	}
	
	/**
	 * Report a bug via {@link AppiusClaudiusCaecus} with the slot
	 * number for convenience in debugging
	 * 
	 * @param bug the bug string
	 * @param e an exception thrown
	 */
	private void reportBug (final String bug, final Throwable e) {
		if (null == e) {
			BugReporter.getReporter ("srv").reportBug (
					bug + " (InventoryItem slot#" + slotNumber
							+ ")");
		} else {
			BugReporter.getReporter ("srv").reportBug (
					bug + " (InventoryItem slot#" + slotNumber
							+ ")", e);
		}
	}
	
	/**
	 * @param beActive true if the item is active
	 */
	@Setter (getter = "isActive")
	public void setActive (final boolean beActive) {
		final boolean wasActive = active;
		active = beActive;
		try {
			Quaestor.getDefault ().action (
					new Action (getOnlineOwner (), active ? "don"
							: "doff", String.valueOf (itemID),
							health));
		} catch (final NotFoundException e) {
			// no op
		}
		checkEquipChange ();
		if (active != wasActive) {
			changed ();
		}
	}
	
	/**
	 * set the colour of a single-colour item.
	 * 
	 * @param newColour the new colour
	 * @deprecated use {@link #setColour(List)} or
	 *             {@link #setColour(int, Colour)}
	 */
	@Deprecated
	public void setColour (final Colour newColour) {
		if (colours.size () == 0) {
			colours.add (newColour);
		} else {
			colours.set (0, newColour);
		}
		changed ();
	}
	
	/**
	 * set the colour of a single-colour item.
	 * 
	 * @param newColour the new colour, or -1 for no colour.
	 * @deprecated use {@link #setColour(List)} or
	 *             {@link #setColour(int, Colour)}
	 */
	@Deprecated
	public void setColour (final int newColour) {
		if ( -1 == newColour) {
			setColour ((Colour) null);
		} else {
			setColour (new Colour (newColour));
		}
	}
	
	/**
	 * Set a particular colour.
	 * 
	 * @param index the index position of the colour
	 * @param newColour the new colour
	 */
	public void setColour (final int index, final Colour newColour) {
		if (colours.size () > index) {
			colours.set (index, newColour);
		} else {
			colours.add (index, newColour);
		}
		changed ();
	}
	
	/**
	 * Set the colours of a multi-colour item.
	 * 
	 * @param newColours the ordered set of colours
	 */
	public void setColour (final List <Colour> newColours) {
		colours.clear ();
		colours.addAll (newColours);
		changed ();
	}
	
	/**
	 * Set the facing direction of this item (typically furniture)
	 * 
	 * @param newFacing the new facing directions
	 */
	@Setter
	public void setFacing (final String newFacing) {
		facing = newFacing;
		changed ();
	}
	
	/**
	 * @param newHealth the health to set
	 */
	@Setter
	public void setHealth (final BigDecimal newHealth) {
		health = newHealth;
		checkEquipChange ();
		changed ();
	}
	
	/**
	 * @param newID the item ID represented by this inventory slot
	 */
	@Setter
	public void setItemID (final int newID) {
		itemID = newID;
	}
	
	/**
	 * @param newOwner owner
	 */
	public void setOwner (final AbstractUser newOwner) {
		if (null == newOwner) {
			return;
		}
		owner = newOwner;
		changed ();
		if ( !newOwner.getInventory ().contains (this)) {
			newOwner.getInventory ().add (this);
		}
	}
	
	/**
	 * @param newOwnerID owner's userID
	 */
	@Setter
	public void setOwnerID (final int newOwnerID) {
		if (newOwnerID < 1) {
			owner = null;
			return;
		}
		owner = Nomenclator.getUserByID (newOwnerID);
		changed ();
		// Don't Nomenclator.getUserByID (ownerID1).getInventory
		// ().add
		// (this);
	}
	
	/**
	 * @param room the room in which this item is found
	 */
	public void setRoom (final Room room) {
		if (null == room.getOwner ()) {
			AppiusClaudiusCaecus.fatalBug ("Room has a null owner? "
					+ room.getDebugName ());
		}
		if (null == getOwner ()) {
			AppiusClaudiusCaecus.fatalBug ("I have a null owner? "
					+ toString ());
		}
		if ( !room.getOwner ().equals (getOwner ())) {
			reportBug (
					"Attempting to place item into another person's room : item "
							+ getSlotNumber () + " (owner "
							+ getOwner ().getDebugName ()
							+ ")  in " + room.getDebugName ()
							+ " (owner "
							+ room.getOwner ().getDebugName ()
							+ ")", null);
			return;
		}
		if (roomNumber != room.getRoomIndex ()) {
			reportBug (
					"Furniture trying to set vars in the wrong room",
					null);
			return;
		}
		try {
			final InventoryItemType wallpaperInventoryItemType = Nomenclator
					.getDataRecord (InventoryItemType.class,
							"Wallpaper");
			if (type.equals (wallpaperInventoryItemType)) {
				final HashSet <InventoryItemType> set = new HashSet <InventoryItemType> ();
				set.add (wallpaperInventoryItemType);
				for (final InventoryItem item : getOwner ()
						.getInventory ().getItemsByType (set)) {
					if ( !equals (item)
							&& (item.getRoomIndex () == getRoomIndex ())) {
						item.setActive (false);
					}
				}
				room.setVariable ("wl", String.valueOf (itemID));
				return;
			}
		} catch (final NotFoundException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a NotFoundException in InventoryItem.setRoom for Wallpaper",
							e);
		}
		try {
			final InventoryItemType flooringInventoryItemType = Nomenclator
					.getDataRecord (InventoryItemType.class,
							"Flooring");
			if (type.equals (flooringInventoryItemType)) {
				final HashSet <InventoryItemType> set = new HashSet <InventoryItemType> ();
				set.add (flooringInventoryItemType);
				for (final InventoryItem item : getOwner ()
						.getInventory ().getItemsByType (set)) {
					if ( !equals (item)
							&& (item.getRoomIndex () == getRoomIndex ())) {
						item.setActive (false);
					}
				}
				room.setVariable ("fl", String.valueOf (itemID));
				room.setVariable ("f", String.valueOf (itemID));
				return;
			}
		} catch (final NotFoundException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a NotFoundException in InventoryItem.setRoom for Flooring",
							e);
		}
		try {
			final InventoryItemType ceilingInventoryItemType = Nomenclator
					.getDataRecord (InventoryItemType.class,
							"Ceiling");
			if (type.equals (ceilingInventoryItemType)) {
				final HashSet <InventoryItemType> set = new HashSet <InventoryItemType> ();
				set.add (ceilingInventoryItemType);
				for (final InventoryItem item : getOwner ()
						.getInventory ().getItemsByType (set)) {
					if ( !equals (item)
							&& (item.getRoomIndex () == getRoomIndex ())) {
						item.setActive (false);
					}
				}
				room.setVariable ("cl", String.valueOf (itemID));
				return;
			}
		} catch (final NotFoundException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a NotFoundException in InventoryItem.setRoom for Ceiling",
							e);
		}
		
		if ( !room.canWalk (new Coord3D (x, y, z))) {
			return;
		}
		String varName = "furn~" + slotNumber;
		final boolean furnItems = AppiusConfig
				.getConfigBoolOrFalse ("com.tootsville.furnItems");
		if (furnItems) {
			varName = "item~" + slotNumber;
		}
		
		final StringBuilder rv = new StringBuilder ();
		rv.append (itemID);
		rv.append ('~');
		rv.append ((int) x);
		rv.append ('~');
		rv.append ((int) y);
		if ( !furnItems) {
			rv.append ('~');
			rv.append ((int) z);
		}
		rv.append ('~');
		rv.append (facing);
		if ( !furnItems) {
			rv.append ('~');
			if (colours.size () > 1) {
				for (final Colour c : colours) {
					rv.append (c.toInt ());
					rv.append (',');
				}
			} else if (null != getColour ()) {
				rv.append (getColour ().toInt ());
				
			}
		}
		room.setVariable (varName, rv.toString ());
	}
	
	/**
	 * @param i room index
	 */
	@Setter (getter = "getRoomIndex")
	public void setRoomNumber (final int i) {
		roomNumber = i;
	}
	
	/**
	 * This is only to be used by addItem. Sets the Slot number without
	 * flushing the item.
	 * 
	 * @param slotNumber_force The retrieved slot number from an
	 *             insert.
	 */
	@Setter (getter = "getSlotNumber")
	public void setSlotHarsh (final int slotNumber_force) {
		slotNumber = slotNumber_force;
	}
	
	/**
	 * @param slot new slot number
	 */
	public void setSlotNumber (final int slot) {
		slotNumber = slot;
		changed ();
	}
	
	/**
	 * set the {@link InventoryItemType} of this item
	 * 
	 * @param newType the new type
	 */
	public void setType (final InventoryItemType newType) {
		type = newType;
	}
	
	/**
	 * @param newTypeID the new type ID
	 * @throws GameLogicException if the type ID is not valid
	 */
	@Setter
	public void setTypeID (final int newTypeID)
			throws GameLogicException {
		try {
			type = Nomenclator.getDataRecord (
					InventoryItemType.class, newTypeID);
		} catch (final NotFoundException e) {
			BugReporter
					.getReporter ("srv")
					.reportBug (
							"Caught a NotFoundException in InventoryItem.setTypeID ",
							e);
		}
		checkEquipChange ();
	}
	
	/**
	 * set the X ordinate of this item, within its container. Has no
	 * effect upon items contained by an user (e.g. clothing).
	 * 
	 * @param newX new X
	 */
	@Setter
	public void setX (final double newX) {
		x = newX;
		changed ();
	}
	
	/**
	 * set the Y abcessa of this item, within its container. Has no
	 * effect upon items contained by an user (e.g. clothing).
	 * 
	 * @param newY new Y
	 */
	@Setter
	public void setY (final double newY) {
		y = newY;
		changed ();
	}
	
	/**
	 * set the Z ordinate of this item, within its container. Has no
	 * effect upon items contained by an user (e.g. clothing).
	 * 
	 * @param newZ new Z
	 */
	@Setter
	public void setZ (final double newZ) {
		z = newZ;
		changed ();
	}
	
	/**
	 * @return a JSON object representing this item
	 * @see CastsToJSON#toJSON()
	 */
	public JSONObject toJSON () {
		final JSONObject self = new JSONObject ();
		try {
			final GenericItemReference item = getGenericItem ();
			self.put ("slot", slotNumber);
			self.put ("itemType", getType ().getName ());
			self.put ("itemID", itemID);
			if (Integer.MIN_VALUE != y) {
				self.put ("x", (int) x);
				self.put ("y", (int) y);
				self.put ("z", (int) z);
				self.put ("inRoom", roomNumber);
			}
			self.put ("ownerID",
					null == owner ? -1 : owner.getUserID ());
			self.put ("isActive", isActive () ? "true" : "false");
			self.put ("title", getGenericItem ().getTitle ());
			final Colour colour = getColour ();
			if (null != colour) {
				self.put ("color", colour.toInt ());
			}
			self.put ("rarity", getGenericItem ().getRarity ()
					.getID ());
			self.put ("facing", facing);
			self.put ("health", health.toPlainString ());
			final char equipSlot = item.getEquipSlot ();
			if (' ' != equipSlot) {
				self.put ("equipType", equipSlot);
				final HealthType healthType = item.getHealthType ();
				if (healthType == HealthType.CONTINUOUS) {
					self.put ("healthType", "C");
					/*
					 * FIXME: should be “continuous”
					 */
				} else if (healthType == HealthType.DISCRETE) {
					self.put ("healthType", "D");
					/*
					 * FIXME: should be “discrete”
					 */
				}
			}
		} catch (final JSONException e) {
			reportBug (
					"Trying to write an item's info into JSON failed",
					e);
		}
		return self;
	}
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return "InventoryItem itemID " + itemID + " type "
				+ (null == type ? "null!" : type.toString ())
				+ " owner "
				+ (null == owner ? "null!" : owner.getDebugName ())
				+ " slot " + slotNumber;
	}
	
	/**
	 * un-equip an item (set it to be inactive)
	 */
	public void unequip () {
		setActive (false);
	}
	
	/**
	 * remove the variable(s) set in the room to represent this item.
	 * 
	 * @param room some room
	 */
	public void unsetRoom (final Room room) {
		if (room.getOwner ().equals (getOwner ())
				&& (room.getRoomIndex () == roomNumber)) {
			roomNumber = -1;
			if (AppiusConfig
					.getConfigBoolOrFalse ("com.tootsville.furnItems")) {
				room.setVariable ("item~" + slotNumber, null);
			} else {
				room.setVariable ("furn~" + slotNumber, null);
			}
		}
	}
	
}
