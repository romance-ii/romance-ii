/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
 * </p>
 * <p>
 * Based upon public domain sample code provided by Authorize.net
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
 * License along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
package net.authorize.arb.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * TODO: The documentation for this type (XmlTreeUtil) is incomplete.
 * (brpocock@star-hope.org, Oct 13, 2009)
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class XmlTreeUtil {
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private static Logger log = LoggerFactory
			.getLogger (XmlTreeUtil.class);
	
	/**
	 * WRITEME
	 */
	private String lineSpace = "\n";
	/**
	 * WRITEME
	 */
	private boolean print_document_node = true;
	/**
	 * WRITEME
	 */
	private String tabSpace = "   ";
	
	/**
	 * WRITEME
	 */
	public XmlTreeUtil () {
		// No op
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param node WRITEME
	 * @param os WRITEME
	 * @param nodeLevelStart WRITEME
	 * @return the nodeLevelEnd WRITEME
	 * @throws IOException WRITEME
	 */
	private int _printTree (final Node node, final OutputStream os,
			final int nodeLevelStart) throws IOException {
		int nodeLevel = nodeLevelStart;
		switch (node.getNodeType ()) {
		case Node.DOCUMENT_NODE:
			
			if (print_document_node) {
				final String data = "<?xml version=\"1.0\"?>"
						+ lineSpace;
				os.write (data.getBytes ());
			}
			
			final Document doc = (Document) node;
			nodeLevel = _printTree (doc.getDocumentElement (), os,
					nodeLevel);
			break;
		case Node.ELEMENT_NODE:
			final StringBuilder tabber = new StringBuilder ();
			for (int i = 0; i < nodeLevel; i++ ) {
				tabber.append (tabSpace);
			}
			nodeLevel++ ;
			final String name = node.getNodeName ();
			final String elmName = tabber.toString () + "<" + name;
			os.write (elmName.getBytes ());
			final NamedNodeMap attributes = node.getAttributes ();
			for (int i = 0; i < attributes.getLength (); i++ ) {
				final Node current = attributes.item (i);
				final StringBuilder attrSetMaker = new StringBuilder ();
				attrSetMaker.append (" ");
				attrSetMaker.append (current.getNodeName ());
				attrSetMaker.append ("=\"");
				attrSetMaker.append (current.getNodeValue ());
				attrSetMaker.append ("\"");
				final String attrSet = attrSetMaker.toString ();
				os.write (attrSet.getBytes ());
			}
			
			final NodeList children = node.getChildNodes ();
			
			// whitespace counted as childnode
			
			if ( (children != null) && (children.getLength () > 0)) {
				final String endElm = ">" + lineSpace;
				os.write (endElm.getBytes ());
				for (int i = 0; i < children.getLength (); i++ ) {
					_printTree (children.item (i), os, nodeLevel);
				}
				final String closeElm = tabber.toString () + "</"
						+ name + ">" + lineSpace;
				os.write (closeElm.getBytes ());
			} else {
				final String closeElm = " />" + lineSpace;
				os.write (closeElm.getBytes ());
			}
			nodeLevel-- ;
			break;
		case Node.TEXT_NODE:
			String value = node.getNodeValue ();
			if (value != null) {
				value = value.trim ();
				os.write (value.getBytes ());
			}
			break;
		case Node.CDATA_SECTION_NODE:
			String dataValue = node.getNodeValue ();
			if ( (dataValue != null) && (dataValue.length () > 0)) {
				dataValue = "<![CDATA[" + dataValue + "]]>";
				os.write (dataValue.getBytes ());
			}
			break;
		case Node.PROCESSING_INSTRUCTION_NODE:
		case Node.ENTITY_REFERENCE_NODE:
		case Node.DOCUMENT_TYPE_NODE:
			break;
		}
		return nodeLevel;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param XMLDocument WRITEME
	 * @return WRITEME
	 */
	public String printTree (final Document XMLDocument) {
		return new String (printTreeBytes (XMLDocument));
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param XMLDocument WRITEME
	 * @param os WRITEME
	 */
	public void printTree (final Document XMLDocument,
			final OutputStream os) {
		final int nodeLevel = 0;
		try {
			_printTree (XMLDocument, os, nodeLevel);
		} catch (final IOException e) {
			e.printStackTrace ();
		}
		
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param XMLDocument WRITEME
	 * @return WRITEME
	 */
	public byte [] printTreeBytes (final Document XMLDocument) {
		byte [] xmlData = new byte [0];
		try {
			final ByteArrayOutputStream baos = new ByteArrayOutputStream ();
			this.printTree (XMLDocument, baos);
			xmlData = baos.toByteArray ();
			baos.close ();
		} catch (final IOException e) {
			XmlTreeUtil.log.error ("IOException", e);
		}
		return xmlData;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 */
	public void setCollapsed () {
		tabSpace = "";
		lineSpace = "";
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param b WRITEME
	 */
	public void setPrintDocumentNode (final boolean b) {
		print_document_node = b;
	}
}
