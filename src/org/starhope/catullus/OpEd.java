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

/**
 * “Op Ed” does not stand for “Opinions of the Editor,” but instead,
 * “Operator Editable…” It's just going to be typed so often that the
 * malapropistic abbreviation seemed entirely appropriate. This
 * annotation is to be used to indicate a property pair (get/set) that
 * can be edited by an operator using a basic
 * editable-property-discovery mechanism.
 * 
 * @author brpocock@star-hope.org
 * 
 */
@Target ( { ElementType.METHOD, ElementType.TYPE })
@Retention (RetentionPolicy.RUNTIME)
@Documented
@Inherited
public @interface OpEd {
    /**
     * <p>
     * Optional “advice” string to help the operator understand the
     * meaning of this property
     * </p>
     * <p>
     * This can also be applied to classes.
     * </p>
     */
    public String advice() default "";

    /**
     * <p>
     * Property groups can be assigned headings, and all properties with
     * the same groupWith heading will appear together under that
     * heading.
     * </p>
     * <p>
     * Does not apply to classes.
     * </p>
     */
    public String groupWith () default "";

    /**
     * <p>
     * if this is an “advanced” field, then it will be hidden by
     * default, even if the user has sufficient privileges to update it,
     * usually behind some simple “advanced” expander box or tab.
     * </p>
     * <p>
     * Does not apply to classes.
     * </p>
     */
    public boolean isAdvanced() default false;

    /**
     * <p>
     * The label to display in the user-interface for this element; by
     * default, it will show the name of the property without the
     * “get/set” prefix; this enables more user-friendly names.
     * </p>
     * <p>
     * Can be used for classes, but probably a bad idea
     * </p>
     */
    public String label() default "";

    /**
     * <p>
     * Minimum security capability needed. Can be specified as a label
     * or an integer (including in hex), must represent a valid
     * capability level, any that are not understood will revert to
     * CAP_UNIVERSAL. Missing this annotation defaults to
     * CAP_SYSOP_COMMANDS.
     * </p>
     * <p>
     * On a class, changes the default for that class to the specified
     * level.
     * </p>
     */
    public String needCap() default "";

    /**
     * Time to live on the display of an attribute. If possible, the
     * editing interface should refresh the value from the getter every
     * (this many) milliseconds. Useful for annotating values that are
     * likely to be changing more frequently. Only applies to
     * properties.
     */
    public long refreshView() default 300000;
}
