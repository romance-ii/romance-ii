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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author twheys@gmail.com
 */
package org.starhope.rahab.ui;

import java.awt.Dimension;
import java.io.IOException;

import javax.swing.JEditorPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.ScrollPaneConstants;

/**
 * WRITEME: Document this type. twheys@gmail.com Jan 22, 2010
 * 
 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
 */
public final class SpyHTMLWindow extends JPanel {

	/**
	 * WRITEME: Document this field. twheys@gmail.com Jan 22, 2010
	 */
	private static final long serialVersionUID = 7041757436427487461L;
	/**
	 *
	 */
	private final JEditorPane output;
	
	/**
	 * <pre>
	 * twheys@gmail.com Jan 22, 2010
	 * </pre>
	 * 
	 * A HTMLUI WRITEME...
	 * 
	 * @param url WRITEME
	 */
	public SpyHTMLWindow (final String url) {
		output = new JEditorPane ();
		output.setContentType ("text/html");
		output.setEditable (false);
		try {
			output.setPage (this.getClass ().getResource (url));
		} catch (final IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace ();
		}
		final JScrollPane outputScroll = new JScrollPane (output,
				ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED,
				ScrollPaneConstants.HORIZONTAL_SCROLLBAR_AS_NEEDED);
		outputScroll.setPreferredSize (new Dimension (800, 600));
		add (outputScroll);
	}
}
