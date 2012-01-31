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

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;

import org.starhope.appius.mb.MBSession;
import org.starhope.appius.mb.fields.MBFieldIdent;

/**
 * JSP tag to evaluate contents only if a field is blank or error.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class IfNeed extends Nothing {
	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory
			.getLogger (IfNeed.class);
	
	/**
	 * The field upon which the test is contingent
	 */
	private MBFieldIdent field = null;
	
	/**
	 * @see org.starhope.appius.mb.taglib.Nothing#doStartTag()
	 */
	@Override
	public int doStartTag () throws JspException {
		final MBSession session = MBSession.get (pageContext
				.getSession ());
		
		if ( (null == field) || (null == session.getField (field))) {
			try {
				pageContext.getOut ().print (
						"<!-- if-need: invalid field -->");
				IfNeed.log.error ("if-need called with no|invalid “for” attribute");
			} catch (final IOException e) {
				IfNeed.log.error (
						"Caught a IOException in IfNeed.doStartTag ",
						e);
			}
			return Tag.SKIP_BODY;
		}
		
		if ( (null == session.getField (field).getValue ())
				|| session.getErrors ().containsKey (field)) {
			return Tag.EVAL_BODY_INCLUDE;
		}
		
		return Tag.SKIP_BODY;
	}
	
	/**
	 * @return the field associated with this tag
	 */
	public String getFor () {
		return null == field ? "" : field.getName ();
	}
	
	/**
	 * Set the “for” field
	 * 
	 * @param forField the {@link MBFieldIdent} for which the
	 *             &lt;mb:if-need&gt; tag is being applied
	 */
	public void setFor (final String forField) {
		field = MBFieldIdent.valueOf (forField);
	}
	
}
