/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package org.starhope.appius.mb.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;

import org.starhope.appius.mb.MBSession;
import org.starhope.appius.mb.fields.MBFieldIdent;

/**
 * Display the contents (body) of this tag only if there is some error
 * detected with the relevant field in the current session.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class IfError extends Nothing {
	
	/**
	 * The field for which errors are being detected
	 */
	private MBFieldIdent field = null;
	
	/**
	 * @see org.starhope.appius.mb.taglib.Nothing#doStartTag()
	 */
	@Override
	public int doStartTag () throws JspException {
		final MBSession session = MBSession.get (pageContext
				.getSession ());
		
		if (session.getErrors ().containsKey (field)) {
			return Tag.EVAL_BODY_INCLUDE;
		}
		
		return Tag.SKIP_BODY;
	}
	
	/**
	 * @return The field associated with this tag
	 */
	public String getField () {
		return field.toString ();
	}
	
	/**
	 * @return the field associated with this tag
	 */
	public String getFor () {
		return null == field ? "" : field.getName ();
	}
	
	/**
	 * @param forField The field associated with this tag
	 */
	public void setFor (final String forField) {
		field = MBFieldIdent.valueOf (forField);
	}
	
}
