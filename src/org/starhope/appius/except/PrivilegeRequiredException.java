/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
package org.starhope.appius.except;

import org.starhope.appius.sys.admin.SecurityCapability;

/**
 * 
 * WRITEME
 * 
 * @author brpocock@star-hope.org
 * 
 */
public class PrivilegeRequiredException extends Exception {

    /**
     * WRITEME
     */
    private static final long serialVersionUID = -2189758661731450124L;
    /**
     * WRITEME
     */
    private final SecurityCapability requiredCap;
    /**
     * WRITEME
     */
    private final int requiredLevel;
    /**
     * WRITEME
     */
    private final String message;

    /**
     * WRITEME
     */
    public PrivilegeRequiredException () {
        requiredCap=null;
        requiredLevel=-1;
        message=null;
    }

    /**
     * @param staffLevelRequired WRITEME
     */
    public PrivilegeRequiredException (final int staffLevelRequired) {
        message = null;
        requiredCap = null;
        requiredLevel = staffLevelRequired;
    }

    /**
     * @param cap WRITEME
     */
    public PrivilegeRequiredException (final SecurityCapability cap) {
        requiredCap = cap;
        requiredLevel = -1;
        message = null;
    }

    /**
     * @param cap WRITEME
     * @param msg WRITEME
     */
    public PrivilegeRequiredException (final SecurityCapability cap, final String msg) {
        requiredCap = cap;
        requiredLevel = -1;
        message = msg;
    }

    /**
     * @param string WRITEME
     */
    public PrivilegeRequiredException (final String string) {
        message = string;
        requiredCap=null;
        requiredLevel=-1;
    }
    /**
     * @see java.lang.Throwable#toString()
     */
    @Override
    public String toString () {
        final StringBuilder s = new StringBuilder ();
        s.append ("Security privilege (capability) is required to perform the indicated operation.\n");
        if (null != message) { s.append (message); s.append('\n'); }
        if (null != requiredCap) { s.append(requiredCap.toString ()); s.append ('\n');}
        if (-1 != requiredLevel) {s.append ("requires Staff Level "); s.append (requiredLevel); s.append ('\n');}
        s.append (super.toString ());
        return s.toString ();
    }

}
