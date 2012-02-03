/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
package org.starhope.catullus;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.DataRecord;

/**
 * <p>
 * This is a marker-like annotation to indicate to {@link Nomenclator}
 * that a particular class is to be regarded sôlely as an instance of
 * the ancestor class specified. When caching or otherwise manipulating
 * the class, {@link Nomenclator} will ignore the actual implementation
 * class and consider it only as an instance of the Gens.
 * </p>
 * <h4>Etymological Note</h4>
 * <p>
 * Aside from being easier to type than something like
 * IgnoreActualClassConsiderAfterAncestor(type), Gens is Latin for
 * something akin to “clan,” and is the origin of the Genus of the
 * Genus/Species nomenclature.
 * </p>
 * 
 * @author brpocock@star-hope.org
 * 
 */
@Documented
@Inherited
@Target (ElementType.TYPE)
@Retention (RetentionPolicy.RUNTIME)
public @interface Gens {
	/**
	 * The <i>nomen gentile</i> of the <i>gens</i>.
	 */
	public Class <? extends DataRecord> nomen();
}
