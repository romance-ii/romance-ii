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
package org.starhope.appius.util;

import java.io.Serializable;

import org.json.JSONObject;

/**
 * This interface is implemented by objects which can be cast to/from
 * JSON
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public interface CastsToJSON extends Serializable {
	
	/*
	 * JSONObject public JSONObject(java.lang.Object bean, boolean
	 * includeSuperClass) Construct JSONObject from the given bean.
	 * This will also create JSONObject for all internal object (List,
	 * Map, Inner Objects) of the provided bean. -- See Documentation
	 * of JSONObject(Object bean) also. Parameters: bean - An object
	 * that has getter methods that should be used to make a
	 * JSONObject. includeSuperClass - - Tell whether to include the
	 * super class properties.
	 */
	
	/**
	 * This returns a copy of the object's data cast into a JSON form.
	 * 
	 * @return The string representing this object in JSON format
	 */
	public abstract JSONObject toJSON ();
}
