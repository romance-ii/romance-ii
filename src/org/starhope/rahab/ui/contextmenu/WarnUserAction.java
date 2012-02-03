/**
 * <p>
 * Copyright © 2010, Timothy W. Heys
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
 * @author twheys@gmail.com
 */
package org.starhope.rahab.ui.contextmenu;

import org.starhope.rahab.util.MessageCallBack;

/**
 * WRITEME: Document this type. twheys@gmail.com Dec 31, 2009
 * 
 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
 */
public class WarnUserAction extends RulesAction {

    /**
     * WRITEME: Document this field. twheys@gmail.com Dec 31, 2009
     */
    private static final String MONIKER = "Warn";

    /**
     * WRITEME: Document this field. twheys@gmail.com Dec 31, 2009
     */
    private static final long serialVersionUID = 8729943067605304703L;

    /**
     * <pre>
     * twheys@gmail.com Dec 31, 2009
     * </pre>
     * 
     * A CopyUserNameAction WRITEME...
     * 
     * @param user WRITEME
     * @param callback WRITEME
     */
    public WarnUserAction (final String user,
            final MessageCallBack callback) {
        super (WarnUserAction.MONIKER, user, callback);
    }

    /**
     * @see org.starhope.rahab.ui.contextmenu.RulesAction#doCommand(java.lang.String)
     */
    @Override
    protected void doCommand (final String option) {
        actionCallBack.sendCommand ("warn", option, userOfInterest);
    }

    /**
     * @see org.starhope.rahab.ui.contextmenu.RulesAction#getMoniker()
     */
    @Override
    protected String getMoniker () {
        return WarnUserAction.MONIKER;
    }
}
