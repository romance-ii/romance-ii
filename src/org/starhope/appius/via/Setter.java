/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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
package org.starhope.appius.via;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.starhope.appius.util.DataRecord;
import org.starhope.appius.util.RecordLoader;

/**
 * <p>
 * Mark a method as being one of the setter methods on a
 * {@link DataRecord} required to be called by a {@link RecordLoader}
 * object.
 * </p>
 * <p>
 * If the method name begins with one of the following words, the getter
 * name can be omitted if it follows the form set<i>X</i> (in this order
 * of preference):
 * </p>
 * <ul>
 * <li>get<i>X</i></li>
 * <li>is<i>X</i></li>
 * <li>has<i>X</i></li>
 * <li>can<i>X</i></li>
 * </ul>
 * <p>
 * If both method names do not follow this pattern, a compatible getter
 * must be specified.
 * </p>
 * <p>
 * The setter must take a single input value of the same type as the
 * return value of the getter.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */


@Target (ElementType.METHOD)
@Retention (RetentionPolicy.RUNTIME)
@Documented
@Inherited
public @interface Setter {
	/**
	 * <p>
	 * Specify an override name for a getter, if the getter and setter
	 * names cannot be automatically mapped.
	 * </p>
	 * <p>
	 * Leaving at the default of <tt>""</tt> will search for a matching
	 * getter name.
	 * </p>
	 */
	public String getter() default "";
}