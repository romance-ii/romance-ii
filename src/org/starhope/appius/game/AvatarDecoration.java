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
package org.starhope.appius.game;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.util.CastsToJSON;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class AvatarDecoration implements CastsToJSON {
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -2121950898686468645L;
	/**
	 *
	 */
	private String filename;
	/**
	 *
	 */
	private Coord3D position;
	
	/**
	 * Create a new visible attachment that accompanies something
	 * VisibleInWorld
	 * 
	 * @param filename1 The filename of the attachment (model, graphic,
	 *             whatever it is)
	 * @param offset The relative offset to its carrier/owner
	 */
	public AvatarDecoration (final String filename1,
			final Coord3D offset) {
		setFilename (filename1);
		setPosition (offset);
	}
	
	/**
	 * Create a new visible attachment that accompanies something
	 * VisibleInWorld
	 * 
	 * @param filename1 The filename of the attachment (model, graphic,
	 *             whatever it is)
	 * @param offsetX The relative offset to its carrier/owner (X)
	 * @param offsetY The relative offset to its carrier/owner (Y)
	 * @param offsetZ The relative offset to its carrier/owner (Z)
	 */
	public AvatarDecoration (final String filename1,
			final double offsetX, final double offsetY,
			final double offsetZ) {
		setFilename (filename1);
		setPosition (new Coord3D (offsetX, offsetY, offsetZ));
	}
	
	/**
	 * @return the filename
	 */
	public String getFilename () {
		return filename;
	}
	
	/**
	 * @return the position
	 */
	public Coord3D getPosition () {
		return position;
	}
	
	/**
	 * @param filename1 the filename to set
	 */
	public void setFilename (final String filename1) {
		filename = filename1;
	}
	
	/**
	 * @param position1 the position to set
	 */
	public void setPosition (final Coord3D position1) {
		position = position1;
	}
	
	/**
	 * Returns a JSON serialisation of the AvatarDecoration object
	 * 
	 * @see org.starhope.appius.util.CastsToJSON#toJSON()
	 */
	
	@Override
	public JSONObject toJSON () {
		final JSONObject o = new JSONObject ();
		try {
			o.put ("filename", getFilename ());
			o.put ("position", getPosition ().toJSON ());
		} catch (final JSONException e) {
			BugReporter.getReporter ("srv").reportBug (e);
			throw new Error (e);
		}
		return o;
	}
	
}
