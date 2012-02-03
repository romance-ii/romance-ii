/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
 * @author brpocock@star-hope.org
 */

package org.starhope.appius.user;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.inventory.GenericItemReference;
import org.starhope.appius.game.inventory.Inventory;
import org.starhope.appius.game.inventory.InventoryItemType;
import org.starhope.appius.game.inventory.ItemManager;
import org.starhope.appius.geometry.PolygonBuilder;
import org.starhope.appius.geometry.PolygonPrimitive;
import org.starhope.appius.types.Colour;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.CastsToJSON;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * The avatar class defines a type of avatar which can be used by a game
 * player or NPC. Different avatar classes may use different physical
 * models, accept different clothing, &c. For example, different alien
 * races or mythical species might be represented by different avatar
 * classes.
 *
 * @author brpocock@star-hope.org
 */
public class AvatarClass extends SimpleDataRecord <AvatarClass>
		implements CastsToJSON {

	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -5006183249551211836L;

	/**
	 * @param id ID
	 * @return the record in question
	 * @deprecated use {@link Nomenclator#getDataRecord(Class, int)}
	 */
	@Deprecated
	public static AvatarClass getByID (final int id) {
		try {
			return Nomenclator.getDataRecord (AvatarClass.class, id);
		} catch (final NotFoundException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a NotFoundException in AvatarClass.getByID ",
							e);
			return null;
		}

	}

	/**
	 * The body format for costuming, &c.
	 */
	private AvatarBodyFormat bodyFormat;

	/**
	 * whether the avatar class can be colorised
	 */
	private boolean canColor = false;

	/**
	 * the bounding space for collision detection
	 */
	private PolygonPrimitive <?> collisionBounds = null;

	/**
	 * string describing the bounding space for collision detection
	 */
	private String collisionBoundsString = null;

	/**
	 * the default base colour for the avatar class
	 */
	private Colour defaultBaseColour = Colour.WHITE;

	/**
	 * the default extra/highlight/feature colour for the avatar class
	 */
	private Colour defaultExtraColour = Colour.BLACK;

	/**
	 * the default pattern/hairstyle type for the avatar class
	 */
	private GenericItemReference defaultPattern = null;

	/**
	 * the default pattern/hair/additional colour for the avatar class
	 */
	private Colour defaultPatternColour = Colour.BLACK;

	/**
	 * avatar class filename
	 */
	private String filename = "avatar";

	/**
	 * A cache of whether each avatar class is available to free users
	 */
	private boolean forFree = false;

	/**
	 * A cache of whether each avatar class is available to paid users
	 */
	private boolean forPaid = false;

	/**
	 * The height of this avatar type (barring scaling)
	 */
	private double height;

	/**
	 * unique ID
	 */
	private int id = -1;

	/**
	 * string identifier
	 */
	private String ident = null;

	/**
	 * nil constructor
	 */
	public AvatarClass () {
		super (AvatarClass.class);
	}

	/**
	 * @param loader record loader
	 */
	public AvatarClass (final RecordLoader <AvatarClass> loader) {
		super (loader);
	}

	/**
	 * /** Return whether this avatar class can be colorised (2 planes)
	 * or not.
	 *
	 * @return Whether this avatar class can be colorised
	 */
	public boolean canColor () {
		return canColor;
	}

	/**
	 * @see org.starhope.appius.util.SimpleDataRecord#compareTo(org.starhope.appius.util.SimpleDataRecord)
	 */
	@Override
	public int compareTo (final AvatarClass o) {
		return toString ().compareTo (toString ());
	}

	/**
	 * XXX This is terribly Tootsville™ specific. And dumb.
	 *
	 * @param avatarNum ID number
	 * @return Tootsville™ specific avatar name for quadruped avatars
	 * @deprecated this is really dumb
	 */
	@Deprecated
	public String getAvatarString (final int avatarNum) {
		switch (avatarNum) {
		case 1:
			return "zap";
		case 2:
			return "dottie";
		case 3:
			return "superstar";
		case 4:
			return "lilmc";
		case 5:
			return "sparkle";
		case 6:
			return "moo";
		case 7: // cupid
		case 8: // doodle
			return "cupid";
		default:
			return "moo";
		}
	}

	/**
	 * @return the {@link AvatarBodyFormat} that best describes the
	 *         layout of this {@link AvatarClass} with respect to
	 *         {@link InventoryItemType} slots.
	 */
	public AvatarBodyFormat getBodyFormat () {
		return bodyFormat;
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
		return ident;
	}

	/**
	 * @return a collision polyhedron/subspace/…
	 */
	public PolygonPrimitive <?> getCollisionBounds () {
		return null == collisionBounds ? (collisionBounds = PolygonBuilder
				.instanceOf (collisionBoundsString)) : collisionBounds;
	}

	/**
	 * @return a string somehow describing a collision
	 *         polyhedron/subspace/…
	 */
	public String getCollisionBounds_string () {
		return collisionBoundsString;
	}

	/**
	 * @return the default base colour associated with the avatar class
	 */
	public Colour getDefaultBaseColor () {
		return defaultBaseColour;
	}

	/**
	 * @return the default base colour associated with the avatar class
	 */
	public Colour getDefaultBaseColour () {
		return defaultBaseColour;
	}

	/**
	 * @return the default extra colour associated with the avatar class
	 */
	public Colour getDefaultExtraColor () {
		return defaultExtraColour;
	}
	
	/**
	 * @return the default extra colour associated with the avatar class
	 */
	public Colour getDefaultExtraColour () {
		return defaultExtraColour;
	}

	/**
	 * @return the default pattern associated with the avatar class
	 */
	public GenericItemReference getDefaultPattern () {
		return defaultPattern;
	}

	/**
	 * @return default pattern color associated with the avatar class
	 */
	public Colour getDefaultPatternColor () {
		return defaultPatternColour;
	}

	/**
	 * @return the defaultPatternColour
	 */
	public Colour getDefaultPatternColour () {
		return defaultPatternColour;
	}

	/**
	 * @return the filename/URI/identifier of the avatar class itself
	 */
	public String getFilename () {
		return filename;
	}
	
	/**
	 * FIXME: Avatar heights should be some kind of database entry?
	 * 
	 * @return height in pixels
	 */
	public double getHeight () {
		return height;
	}

	/**
	 * @return the ID
	 */
	public int getID () {
		return id;
	}

	/**
	 * @param inventory WRITEME
	 * @return WRITEME
	 * @deprecated use {@link ItemManager#get(AbstractUser)} or even
	 *             {@link ItemManager#get(AbstractUser, AvatarClass, Inventory)}
	 */
	@Deprecated
	public ItemManager getItemManager (final Inventory inventory) {
		return null;
	}

	/**
	 * @return the name
	 */
	public String getName () {
		return ident;
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2225 $";
	}

	/**
	 * @return true if this is available for free users
	 */
	public boolean isForFree () {
		return forFree;
	}

	/**
	 * @return the forPaid
	 */
	public boolean isForPaid () {
		return forPaid;
	}

	/**
	 * @return true, if paid members can use this avatar
	 * @deprecated use {@link #isForPaid()} — VIT is
	 *             Tootsville™-specific terminology
	 */
	@Deprecated
	public boolean isForVIT () {
		return forPaid;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param newBodyFormat WRITEME
	 */
	public void setBodyFormat (final AvatarBodyFormat newBodyFormat) {
		bodyFormat = newBodyFormat;
		changed ();
	}
	
	/**
	 * @param really whether the avatar class can be colorised
	 */
	public void setCanColor (final boolean really) {
		if (canColor != really) {
			canColor = really;
			changed ();
		}
	}

	/**
	 * @param newString a string somehow describing a collision
	 *            polyhedron/subspace/…
	 */
	public void setCollisionBounds (final String newString) {
		collisionBoundsString = newString;
		collisionBounds = null;
		changed ();
	}

	/**
	 * @param newColour the defaultBaseColour to set
	 */
	public void setDefaultBaseColour (final Colour newColour) {
		defaultBaseColour = newColour;
		changed ();
	}

	/**
	 * @param newColour the defaultExtraColour to set
	 */
	public void setDefaultExtraColour (final Colour newColour) {
		defaultExtraColour = newColour;
		changed ();
	}

	/**
	 * @param newPattern the defaultPattern to set
	 */
	public void setDefaultPattern (final GenericItemReference newPattern) {
		defaultPattern = newPattern;
		changed ();
	}

	/**
	 * @param newColour the defaultPatternColour to set
	 */
	public void setDefaultPatternColour (final Colour newColour) {
		defaultPatternColour = newColour;
		changed ();
	}

	/**
	 * @param newFile the filename to set
	 */
	public void setFilename (final String newFile) {
		filename = newFile;
		changed ();
	}

	/**
	 * @param really the forFree to set
	 */
	public void setForFree (final boolean really) {
		if (forFree != really) {
			forFree = really;
			changed ();
		}
	}

	/**
	 * @param really the forPaid to set
	 */
	public void setForPaid (final boolean really) {
		if (really != forPaid) {
			forPaid = really;
			changed ();
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param heightScalar WRITEME
	 */
	public void setHeight (final double heightScalar) {
		height = heightScalar;
		changed ();
	}

	/**
	 * Note: does <em>not</em> call {@link #changed()}
	 *
	 * @param newID new ID
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}

	/**
	 * @param newName new name
	 */
	public void setName (final String newName) {
		ident = newName;
		changed ();
	}

	/**
	 * @return this object cast as an ActionScript Object for the
	 *         client.
	 * @see CastsToJSON#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		final JSONObject self = new JSONObject ();
		try {
			self.put ("id", id);
			self.put ("title", getName ());
			self.put ("filename", getFilename ());
			self.put ("forFree", isForFree ());
			self.put ("forPaid", isForPaid ());
			if (AppiusConfig
					.getConfigBoolOrFalse ("org.starhope.appius.events.format1.0")) {
				self.put ("s", getName ());
				self.put ("avatarClassID", getID ());
				self.put ("forVIT", isForPaid ());
			}
		} catch (final JSONException e) {
			AppiusClaudiusCaecus.reportBug (e);
		}
		return self;
	}

	/**
	 * String representation is currently the JSON data
	 *
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return getName (); // toJSON ().toString ();
	}
}
