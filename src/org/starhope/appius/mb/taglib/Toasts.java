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
import java.util.Collection;
import java.util.EnumSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.mb.MBErrorReason;
import org.starhope.appius.mb.MBSession;
import org.starhope.appius.mb.fields.MBFieldIdent;

/**
 * Display some toasts for the page. Suppresses toasts if the page
 * hasn't been seen yet, if the field is merely blank, and so forth
 * 
 * @author brpocock@star-hope.org
 */
public class Toasts extends Nothing {
	/**
	 * @see org.starhope.appius.mb.taglib.Nothing#doStartTag()
	 */
	@Override
	public int doStartTag () throws JspException {
		final JspWriter out = pageContext.getOut ();
		final MBSession session = MBSession.get (pageContext
				.getSession ());

		try {

			final String requestURI = ((HttpServletRequest) pageContext
					.getRequest ()).getRequestURI ();

			final Set <MBFieldIdent> fieldsHere = session
					.getFieldsOn (requestURI);
			if ( !session.getLastURI ().equals (
					MBSession.stripIndex (requestURI))) {
				out.write ("<!-- New page -->");
				for (final MBFieldIdent field : fieldsHere) {
					session.clearErrorsFor (field);
				}
			} else {

				printErrorToasts (out, session, fieldsHere);

			} // error toasts

			final Collection <String> toasts = session
					.getToastsAndClear ();
			int toastsLeft = toasts.size ();
			for (final String toast : toasts) {
				out.print ("<div class=\"success-message toast\">"
						+ toast);
				if ( --toastsLeft > 0) {
					out.println ("<hr />");
				}
				out.println ("</div>");
			}
			out.write ("<!-- /Toasts -->");

		} catch (final IOException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught a IOException in Toasts.doStartTag ", e);
		}
		return Tag.SKIP_BODY;
	}

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * @param out
	 * @param session
	 * @param fieldsHere
	 * @throws IOException
	 */
	private void printErrorToasts (final JspWriter out,
			final MBSession session, final Set <MBFieldIdent> fieldsHere)
			throws IOException {
		final Map <MBFieldIdent, EnumSet <MBErrorReason>> errorToasts = session
				.getErrors ();

		int errsLeft = errorToasts.size ();

		if (errsLeft == 0) {
			out.write ("<!-- No Errors -->");

			// DEBUG
			// out.write
			// ("<div style=\"position:absolute;top:0;left:0;color:green;font-family:serif;size:xx-large\">All is well.</div>");

			return;
		}

		out.write ("<!-- Toasts -->");
		for (final Map.Entry <MBFieldIdent, EnumSet <MBErrorReason>> errToast : errorToasts
				.entrySet ()) {
			final MBFieldIdent field = errToast.getKey ();
			if ( !fieldsHere.contains (field)) {

				// FIXME DEBUG
				out.write ("<div style=\"color:red;font-family:serif;size:x-large\">Not here:"
						+ field.toString () + "</div>");

				continue;
			}
			final EnumSet <MBErrorReason> reasons = errToast
					.getValue ();
			for (final MBErrorReason reason : reasons) {
				if (MBErrorReason.BLANK != reason) {
					out.write ("<div class=\"error-message toast\">"
							+ reason.getErrorMessage (field));
					if ( --errsLeft > 0) {
						out.println ("<hr />");
					}
					out.println ("</div>");
				} else {
					// FIXME DEBUG
					out.write ("<div style=\"color:red;font-family:serif;size:x-large\">Blank:"
							+ field.toString () + "</div>");

				}
			}
		}
	}
}
