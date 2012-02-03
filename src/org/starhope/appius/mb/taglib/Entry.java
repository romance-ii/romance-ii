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
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.mb.taglib;

import javax.servlet.jsp.JspException;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.fields.MBFieldIdent;

/**
 * This is an automatic entry-maker. It creates a form field appropriate
 * to the type of field given to it.
 * 
 * @author brpocock@star-hope.org
 */
public class Entry extends Nothing {

	/**
	 * The identity of the field which this tag is displaying/editing
	 */
	private MBFieldIdent fieldIdent = null;

	/**
	 * Nil constructor
	 */
	public Entry () {
		super ();
	}

	/**
	 * @see org.starhope.appius.mb.taglib.Nothing#doStartTag()
	 */
	@Override
	public int doStartTag () throws JspException {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
		.reportBug ("unimplemented Entry::doStartTag (brpocock@star-hope.org, Oct 15, 2010)");
		return super.doStartTag ();
	}

	/**
	 * @return the name of the field for which this is an entry
	 */
	public String getName () {
		return fieldIdent.getName ();
	}

	/**
	 * @param name the name of the field for which this is an entry (see
	 *            {@link MBFieldIdent})
	 */
	public void setName (final String name) {
		fieldIdent = MBFieldIdent.valueOf (name);
	}

}
