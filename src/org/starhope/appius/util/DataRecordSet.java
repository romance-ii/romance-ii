/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Timothy Heys
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
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */

package org.starhope.appius.util;

import java.util.Collection;

/**
 * <p>
 * This is a simple marker interface which is used to identify a data
 * record which is, in turn, a collection of other data.
 * </p>
 * <p>
 * There was originally an intention to provide separate factory methods
 * to facilitate sets of this type. However, it was discovered that the
 * {@link DataRecord} class was sufficient to the purpose, and permitted
 * more flexibility in the implementation details of the backing store.
 * </p>
 * <p>
 * This interface was, therefore, reduced to a marker interface for
 * convenience purposes.
 * </p>
 * <p>
 * A default implementation sufficient for most purposes is being
 * developed as {@link SimpleDataRecordSet}. As of the writing (Appius
 * 1.1, July 2010), no great effort has been expended toward completing
 * this base class simply because there is no active consumer of the
 * type.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @param <T> the data record type in the set
 */
public interface DataRecordSet <T extends DataRecord> extends
		Collection <T>, DataRecord {
	/* marker interface */
}
