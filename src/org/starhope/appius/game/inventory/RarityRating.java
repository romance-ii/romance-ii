/**
 * <p>
 * Copyright © 2010, Tim Heys
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
 * @author twheys@gmail.com
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.game.inventory;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.util.CastsToJSON;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * WRITEME: Document this type.
 * 
 * @author twheys@gmail.com
 * @author brpocock@star-hope.org
 */
public class RarityRating extends SimpleDataRecord <RarityRating>
		implements CastsToJSON {


	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = -483347188430410551L;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private String description ;

	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private int id;

	/**
	 * WRITEME
	 */
	private String value;
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 *
	 */
	public RarityRating () {
		super (RarityRating.class);
	}
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param loader loader
	 */
	public RarityRating (final RecordLoader <RarityRating> loader) {
		super (loader);
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
		return value;
	}


	/**
	 * @return the description
	 */
	public String getDescription () {
		return description;
	}

	/**
	 * @return the id
	 */
	public int getID () {
		return id;
	}



	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * @return {@link #getValue()}
	 * @deprecated {@link #getValue()}
	 */
	public @Deprecated String getString () {
		return getValue ();
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2188 $";
	}

	/**
	 * @return the value
	 */
	public String getValue () {
		return value;
	}

	/**
	 * @param newDescription the description to set
	 */
	public void setDescription (final String newDescription) {
		description = newDescription;
	}

	/**
	 * @param newID the id to set
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}

	/**
	 * @param newValue the value to set
	 */
	public void setValue (final String newValue) {
		value = newValue;
		changed ();
	}

	/**
	 * @see org.starhope.appius.util.CastsToJSON#toJSON()
	 */
	@Override
	public JSONObject toJSON () {
		JSONObject me = new JSONObject ();
		try {
			me.put ("id", id);
		me.put ("n", value);
		me.put ("desc", description);
		} catch (JSONException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a JSONException in RarityRating.toJSON ",
							e);
		}
		return me;
	}

}
