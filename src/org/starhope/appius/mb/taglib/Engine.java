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

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.MBSession;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class Engine extends Nothing {

	/**
	 * skip the rest of the page if we forward them
	 */
	protected boolean redirected = false;

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public Engine () {
		super ();
	}

	/**
	 * @see org.starhope.appius.mb.taglib.Nothing#doEndTag()
	 */
	@Override
	public int doEndTag () throws JspException {
		if (redirected) {
			return Tag.SKIP_PAGE;
		}
		return Tag.EVAL_PAGE;
	}

	/**
	 * @see org.starhope.appius.mb.taglib.Nothing#doStartTag()
	 */
	@Override
	public int doStartTag () throws JspException {
		MBSession session = MBSession.get(pageContext.getSession ());

		session.beforePage (pageContext);

		final HttpServletRequest request = (HttpServletRequest) pageContext
				.getRequest ();
		session.acceptInput (request);
		session.getFieldsNeeded ();
		String pageURI = MBSession
				.stripIndex (request.getRequestURI ());

		if (session.wantToVisit(pageURI)) {
			AppiusClaudiusCaecus.blather (session.toString ()
					+ " is in a good place: " + pageURI);
			return Tag.SKIP_BODY;
		}

		String betterURI = session.getBestNextURI ();
		if (null != betterURI
				&& !MBSession.stripIndex (betterURI).equals (pageURI)) {
			AppiusClaudiusCaecus.blather (session.toString ()
					+ " is being redirected to: " + betterURI);
			try {
				((HttpServletResponse) pageContext.getResponse ())
						.sendRedirect (betterURI);
				return Tag.SKIP_PAGE;
			} catch (IOException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a IOException in Engine.doStartTag ",
								e);
			}
		}
		AppiusClaudiusCaecus.blather (session.toString ()
					+ " is kinda lost; let's stay here.");
		return Tag.SKIP_BODY;

	}

}
