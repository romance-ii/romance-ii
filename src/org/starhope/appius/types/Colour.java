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
package org.starhope.appius.types;

import java.io.Serializable;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.DataException;
import org.starhope.appius.game.AppiusClaudiusCaecus;

/**
 * @author brpocock@star-hope.org
 *
 */
public class Colour implements Serializable {

	/**
	 * The colour black
	 */
	public static final Colour BLACK = new Colour (0);

	/**
	 * Serial Version UID
	 *
	 * serialVersionUID (long)
	 */
	private static final long serialVersionUID = 301064641249595141L;
	/**
	 * The colour white
	 */
	public static final Colour WHITE = new Colour (0xffffff);

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Dec 11, 2009) blue
	 * (Colour)
	 */
	private final short blue;

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Dec 11, 2009) green
	 * (Colour)
	 */
	private final short green;

	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Dec 11, 2009) red
	 * (Colour)
	 */
	private final short red;

	/**
	 * Neutral constructor. The colour is initialized as black
	 * (rgb(0,0,0))
	 */
	public Colour () {
		red = 0;
		green = 0;
		blue = 0;
	}

	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param baseColor other colour
	 */
	public Colour (final Colour baseColor) {
		red=baseColor.red;
		blue=baseColor.blue;
		green=baseColor.green;
	}

	/**
	 * Create an RGB triplet from int values
	 *
	 * @param r red
	 * @param g green
	 * @param b blue
	 * @throws DataException if any value is out of range
	 */
	public Colour (final int r, final int g, final int b)
	throws DataException {
		red = (short) r;
		green = (short) g;
		blue = (short) b;
	}

	/**
	 * Create a colour object from JSON data
	 * 
	 * @param object the JSON data
	 * @throws JSONException if it's bad
	 * @throws DataException if it's badder
	 */
	public Colour (final JSONObject object) throws DataException,
			JSONException {
		this (object.getInt ("r"), object.getInt ("g"), object
				.getInt ("b"));
	}

	/**
	 * Instantiates the colour based upon a 24-bit RGB value. (This is
	 * how we store colours in the database, among other things.) The
	 * value has one byte each (high to low) for the red, green, and
	 * blue components.
	 *
	 * To get a compatible value, you can call @see{toLong}
	 *
	 * @param rgb The combined RGB colour value
	 */
	public Colour (final long rgb) {
		red = (short) ( (rgb & 0xff0000) >> 16);
		green = (short) ( (rgb & 0x00ff00) >> 8);
		blue = (short) (rgb & 0x0000ff);
	}

	/**
	 * Create an RGB triplet from short values
	 *
	 * @param r red
	 * @param g green
	 * @param b blue
	 * @throws DataException if any value is out of range
	 */
	public Colour (final short r, final short g, final short b)
	throws DataException {
		red = r;
		green = g;
		blue = b;
	}

	/**
	 * <p>
	 * Constructor: Instantiate a Colour object based upon the CSS,
	 * HTML, or JSON style of colour string.
	 * </p>
	 * <ul>
	 * <li>The "CSS style" uses a decimal triplet in the form rgb(R,G,B)
	 * (the literal string "rgb(" identifies it).</li>
	 * <li>The "HTML style" uses a # sign followed by either 3 or 6 hex
	 * characters, in the form #RGB or #RRGGBB.</li>
	 * <li>The "JSON style" will include the prefices "r:", "g:", and
	 * "b:" followed by decimal values, separated by commas, with the
	 * order ignored.</li>
	 * <li>A “straight integer” can also be used, in the form ( red <<
	 * 16 & green << 8 & blue )</li>
	 * </ul>
	 * <p>
	 * If the colour value passed does not fully specify a colour,
	 * uninitialized channels will be set to 0. EG: A JSON string of
	 * {r:255} or #f or rgb(255) is identical to #f00 or rgb(255,0,0) or
	 * {r:255,g:0,b:0}.
	 * </p>
	 * RFE: This routine could be expanded to accept the Tango colour
	 * palette using name strings.
	 *
	 * @param rgb The colour specification string (in some supported
	 *            format)
	 * @throws NumberFormatException WRITEME
	 * @throws DataException WRITEME
	 */
	public Colour (final String rgb) throws NumberFormatException,
	DataException {
		final Pattern numberPattern = Pattern.compile ("^[0-9x]+$");
		final Pattern cssColour = Pattern
				.compile ("rgb\\(([0-9]+)\\,([0-9]+)\\,([0-9]+)\\)");
		final Pattern htmlColour3 = Pattern
				.compile ("\\#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])");
		final Pattern htmlColour6 = Pattern
				.compile ("\\#([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])");

		final Matcher numberMatcher = numberPattern.matcher (rgb);
		final Matcher cssMatcher = cssColour.matcher (rgb);
		final Matcher html3Matcher = htmlColour3.matcher (rgb);
		final Matcher html6Matcher = htmlColour6.matcher (rgb);

		if (numberMatcher.matches ()) {
			final int num = Integer.parseInt (rgb);
			red = (short) ( (0xff0000 & num) >> 16);
			green = (short) ( (0x00ff00 & num) >> 8);
			blue = (short) (0x0000ff & num);
			return;
		}
		if (cssMatcher.matches ()) {
			red = Short.parseShort (cssMatcher.group (1));
			green = Short.parseShort (cssMatcher.group (2));
			blue = Short.parseShort (cssMatcher.group (3));
			return;
		}
		if (html3Matcher.matches ()) {
			red = Short.parseShort(html3Matcher.group (1)
					+ html3Matcher.group (1), 16);
			green = Short.parseShort(html3Matcher.group (2)
					+ html3Matcher.group (2), 16);
			blue = Short.parseShort(html3Matcher.group (3)
					+ html3Matcher.group (3), 16);
			return;
		}
		if (html6Matcher.matches ()) {
			red = Short.parseShort (html6Matcher.group (1), 16);
			green = Short.parseShort (html6Matcher.group (2), 16);
			blue = Short.parseShort(html6Matcher.group (3),
					16);
			return;
		}
		throw new DataException ("huh?");
	}
	
	/**
	 * brighten colour additive
	 * 
	 * @param reddenning add to red
	 * @param bluing add to blue
	 * @param greening add to green
	 * @return the new colour
	 */
	public Colour add (final int reddenning, final int greening,
			final int bluing) {
		try {
			return new Colour (Math.min (reddenning + red, 0xff), Math
					.min (greening + green, 0xff), Math.min (bluing
					+ blue, 0xff));
		} catch (DataException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a DataException in Colour.add ", e);
		}
	}

	/**
	 * @return the blue component of this colour
	 */
	public short getBlue () {
		return blue;
	}

	/**
	 * @return the green component of this colour
	 */
	public short getGreen () {
		return green;

	}

	/**
	 * @return the red value of this colour
	 */
	public short getRed () {
		return red;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param redness WRITEME
	 * @param greenness WRITEME
	 * @param blueness WRITEME
	 * @return WRITEME
	 */
	public Colour multiply (final double redness,
			final double greenness, final double blueness)
 {
		try {
			return new Colour ((short) (red * redness),
					(short) (green * greenness),
					(short) (blue * blueness));
		} catch (DataException e) {
			throw AppiusClaudiusCaecus.fatalBug (
					"Caught a DataException in Colour.multiply ", e);
		}
	}






	/**
	 * @return  a 24-bit value (in a integer) representing the
	 *         combined red, green, and blue values, one byte per each.
	 */
	public int toInt () {
		return red<<16|green<<8|blue;
	}

	/**
	 * Create a JSON object specifying this colour.
	 *
	 * @return a JSON object representing this colour. Example:
	 *         {r:0,g:255,b:255} represents cyan.
	 * @throws JSONException if the data cannot be stored for some
	 *         reason
	 */
	public JSONObject toJSON () throws JSONException {
		final JSONObject o = new JSONObject ();
		o.put ("r", red);
		o.put ("g", green);
		o.put ("b", blue);
		return o;
	}

	/**
	 * @return a 24-bit value (in a "long" integer) representing the
	 *         combined red, green, and blue values, one byte per each.
	 */
	public long toLong () {
		return red << 16 | green << 8 | blue;
	}

	/**
	 * Creates a representation of this colour as a string compatible
	 * with CSS: specifically, the prefix "rgb" with the parenthesized
	 * values of red, green, and blue, in decimal, in the range 0..255.
	 * For example, chromatic cyan would be: "rgb(0,255,255)"
	 *
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return "rgb(" //$NON-NLS-1$
		+ red + "," + //$NON-NLS-1$
		green + "," + //$NON-NLS-1$
		blue + ")"; //$NON-NLS-1$
	}

	/**
	 * @return a HTML-style string in the form #rrggbb (hex)
	 */
	@SuppressWarnings ("boxing")
	public String toStringHTML () {
		return String.format ("#%02x%02x%02x", red, green, blue);
	}
}
