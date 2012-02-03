/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
 * @author brpocock@star-hope.org
 */
package net.authorize.arb.util;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.xml.sax.EntityResolver;
import org.xml.sax.ErrorHandler;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

/**
 * XML document used by the Authorize.Net gateway systems
 * 
 * @author brpocock@star-hope.org
 */
public class BasicXmlDocument {

	/**
	 * WRITEME
	 * 
	 * @author brpocock@star-hope.org
	 */
	class BasicXmlDocumentEntityResolver implements EntityResolver {
		/**
		 * WRITEME
		 */
		@SuppressWarnings ("unused")
		private final BasicXmlDocument xml_document;

		/**
		 * WRITEME
		 * 
		 * @param xml_document1 WRITEME
		 */
		public BasicXmlDocumentEntityResolver (
				final BasicXmlDocument xml_document1) {
			xml_document = xml_document1;
		}

		/**
		 * WRITEME
		 * 
		 * @see org.xml.sax.EntityResolver#resolveEntity(java.lang.String,
		 *      java.lang.String)
		 */
		@Override
		public InputSource resolveEntity (final String publicId,
				final String systemId) {
			if (getResolvePath() == null) {
				return null;
			}
			return null;
		}
	}

	/**
	 * WRITEME
	 * 
	 * @author brpocock@star-hope.org
	 */
	static class BasicXMLDocumentErrorHandler implements ErrorHandler {
		/**
		 * WRITEME
		 */
		public BasicXMLDocumentErrorHandler () {
			// no op?
		}

		/**
		 * WRITEME // public void error(String message, String publicId,
		 * String // systemId, int lineNumber, int columnNumber, //
		 * java.lang.Exception e){
		 * 
		 * @see org.xml.sax.ErrorHandler#error(org.xml.sax.SAXParseException)
		 */
		@Override
		public void error (final SAXParseException spe_error) {
			System.out.println ("SAXParseException Error: "
					+ spe_error.toString () + " / "
					+ spe_error.getPublicId ());
		}

		/**
		 * WRITEME
		 * 
		 * @see org.xml.sax.ErrorHandler#fatalError(org.xml.sax.SAXParseException)
		 */

		@Override
		public void fatalError (final SAXParseException spe_fatal) {
			System.out.println ("SAXParseException Fatal: "
					+ spe_fatal.toString ());
		}

		/**
		 * WRITEME
		 * 
		 * @see org.xml.sax.ErrorHandler#warning(org.xml.sax.SAXParseException)
		 */
		@Override
		public void warning (final SAXParseException spe_warn) {
			System.out.println ("SAXParseException Warning: "
					+ spe_warn.toString ());
		}
	}

	/**
	 * WRITEME
	 */
	private boolean accessible = false;
	/**
	 * WRITEME
	 */
	DocumentBuilder db;
	// private int sourceType=0;
	/**
	 * WRITEME
	 */
	DocumentBuilderFactory dbf;
	/**
	 * WRITEME
	 */
	Document document;
	/**
	 * WRITEME
	 */
	private final ArrayList <String> errors;
	/**
	 * WRITEME
	 */
	private String resolve_path = null;
	/**
	 * WRITEME
	 */
	private String sourceFile;
	/**
	 * WRITEME
	 */
	private long xmlParseTime = -1;

	/**
	 * WRITEME
	 */
	public BasicXmlDocument () {
		errors = new ArrayList <String> ();
		initClass ();
	}

	/**
	 * @param sourceFile1 WRITEME
	 */
	public BasicXmlDocument (final String sourceFile1) {
		errors = new ArrayList <String> ();
		sourceFile = sourceFile1;
	}

	/**
	 * WRITEME
	 * 
	 * @param message WRITEME
	 */
	public void addError (final String message) {
		errors.add (message);
		System.out.println (message);
	}

	/**
	 * @param name WRITEME
	 * @return WRITEME
	 */
	public Element createElement (final String name) {
		return document.createElement (name);
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public String dump () {
		return this.dump (true);
	}

	/**
	 * @param collapse WRITEME
	 * @return WRITEME
	 */
	public String dump (final boolean collapse) {
		final XmlTreeUtil xtu = new XmlTreeUtil ();
		if (collapse) {
			xtu.setCollapsed ();
		}
		return xtu.printTree (document);
	}

	/**
	 * WRITEME
	 * 
	 * @param fileName WRITEME
	 * @return WRITEME
	 */
	public boolean dumpToDisk (final String fileName) {
		return this.dumpToDisk (fileName, true);
	}

	/**
	 * WRITEME
	 * 
	 * @param fileName WRITEME
	 * @param collapse WRITEME
	 * @return WRITEME
	 */
	public boolean dumpToDisk (final String fileName,
			final boolean collapse) {
		FileOutputStream fos = null;
		try {
			final File f = new File (fileName);
			fos = new FileOutputStream (f);
			fos.write (this.dump (collapse).getBytes ());
			return true;
		} catch (final IOException e) {
			addError ("dumpToDisk(String fileName):: " + e.toString ());
			// System.out.println(e);
		} finally {
			if (null != fos) {
				try {
					fos.close ();
				} catch (IOException e) {
					addError ("dumpToDisk(String fileName):: "
							+ e.toString ());
				}
			}
		}
		return false;
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public Document getDocument () {
		return document;
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public Element getDocumentElement () {
		return document.getDocumentElement ();
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public ArrayList <String> getErrors () {
		return errors;
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public long getParseTime () {
		return xmlParseTime;
	}

	/**
	 * @return the resolve_path
	 */
	public String getResolvePath () {
		return resolve_path;
	}

	/**
	 * WRITEME
	 */
	private void initClass () {
		try {
			dbf = DocumentBuilderFactory.newInstance ();
			// dbf.setValidating(true);
			db = dbf.newDocumentBuilder ();
		} catch (final ParserConfigurationException e) {
			System.out.println ("Error in parsing: " + e);
		}
	}

	/**
	 * @return WRITEME
	 */
	public boolean IsAccessible () {
		return accessible;
	}

	/**
	 * @return WRITEME
	 */
	public boolean parse () {
		return this.parse (sourceFile);
	}

	/**
	 * @param in_file WRITEME
	 * @return WRITEME
	 */
	public boolean parse (final File in_file) {
		boolean returnType = false;
		try {
			final FileInputStream fis = new FileInputStream (in_file);
			returnType = this.parse (fis);
			fis.close ();
		} catch (final IOException e) {
			addError ("parse(File in_file):: " + e.toString ());
			// System.out.println("Error in parsing: " + e);
		}
		return returnType;
	}

	/**
	 * WRITEME
	 * 
	 * @param in WRITEME
	 * @return WRITEME
	 */
	public boolean parse (final InputStream in) {
		boolean returnType = false;
		try {
			/*
			 * DocumentBuilderFactory dbf =
			 * DocumentBuilderFactory.newInstance(); DocumentBuilder
			 * db=dbf.newDocumentBuilder();
			 */
			final long start = System.currentTimeMillis ();

			// db.setErrorHandler(new BasicXMLDocumentErrorHandler());
			db.setEntityResolver (new BasicXmlDocumentEntityResolver (
					this));

			document = db.parse (in);
			final long stop = System.currentTimeMillis ();

			xmlParseTime = stop - start;
			accessible = true;
			// sourceType=1;
			returnType = true;
		} catch (final IOException e) {
			addError ("parse(InputStream in):: " + e.toString ());
			// System.out.println("Error in parsing: " + e);
		} catch (final SAXException e) {
			addError ("parse(InputStream in):: " + e.toString ());
			// System.out.println("Error in parsing: " + e);
		}
		return returnType;
	}

	/**
	 * WRITEME
	 * 
	 * @param xmlFile WRITEME
	 * @return WRITEME
	 */
	public boolean parse (final String xmlFile) {
		final File f = new File (xmlFile);
		if ( !f.exists ()) {
			addError ("parse(String xmlFile):: File "
					+ f.getAbsolutePath () + " does not exist");
			return false;
		}
		sourceFile = xmlFile;
		return this.parse (f);
	}

	/**
	 * WRITEME
	 * 
	 * @param xmlBytes WRITEME
	 * @return WRITEME
	 */
	public boolean parseBytes (final byte [] xmlBytes) {
		return this.parse (new ByteArrayInputStream (xmlBytes));
	}

	/**
	 * WRITEME
	 * 
	 * @param xmlValue WRITEME
	 * @return WRITEME
	 */
	public boolean parseString (final String xmlValue) {
		return this.parse (new ByteArrayInputStream (xmlValue
				.getBytes ()));
	}

	/**
	 * WRITEME
	 * 
	 * @param ref WRITEME
	 * @return WRITEME
	 */
	public boolean removeChildren (final Node ref) {
		boolean ret = false;
		if (ref == null || ref.hasChildNodes () == false) {
			return ret;
		}
		for (int i = ref.getChildNodes ().getLength () - 1; i >= 0; i-- ) {
			final Node child = ref.getChildNodes ().item (i);
			ref.removeChild (child);
		}
		ret = true;
		return ret;
	}

	/**
	 * WRITEME
	 * 
	 * @param fileName WRITEME
	 */
	public void saveDocument (final String fileName) {
		try {
			final File f = new File (fileName);
			final FileOutputStream fileOut = new FileOutputStream (f);
			final XmlTreeUtil xtu = new XmlTreeUtil ();
			xtu.printTree (document, fileOut);
			fileOut.close ();
		} catch (final IOException e) {
			addError ("saveDocument(String fileName):: "
					+ e.toString ());
			e.printStackTrace ();
		}
	}

	/**
	 * WRITEME
	 * 
	 * @param p WRITEME
	 */
	public void setResolvePath (final String p) {
		resolve_path = p;
	}
}
