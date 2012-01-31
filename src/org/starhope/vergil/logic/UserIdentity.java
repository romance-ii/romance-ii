/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.vergil.logic;

public interface UserIdentity {
	/**
	 * @return the display version of the avatar label, which may be
	 *         non-unique or null. Everything up the the first '$' or
	 *         '/'
	 */
	public String getAvatarDisplayName ();
	
	/**
	 * @return the avatar label, an unique string
	 */
	public String getAvatarLabel ();
	
	/**
	 * <p>
	 * Note, this subtitle can include ANSI escape codes, use
	 * {@link #getAvatarSubtitlePlain()} to strip them.
	 * </p>
	 * <p>
	 * ANSI codes that clients must accept (but may ignore) include:
	 * </p>
	 * 
	 * <pre>
	 * Preceded by ESCAPE (^[ x'1b') + '[' traditionally (VT100), but we
	 * exclusively will be using the CSI x'9b' code instead
	 * 
	 * To ignore, strip all sequences from CSI through the next
	 * occurrence of [x'40'…x'7e'] inclusive: in PCRE that would be
	 *  s/\x9b.*?[\x40-\x7e]//g
	 * 
	 * 0m   reset all settings to normal
	 * 
	 * 1m   start bold or strong
	 * 2m   start faint or dim
	 * 22m  stop bold & faint
	 * 
	 * 3m   start italic or emphasis
	 * 23m  stop italics
	 * 
	 * 9m   start strikethrough
	 * 29m  stop strikethrough
	 * 
	 * 51m  start framing in a box
	 * 52m  start framing in a circle (or oval, roundrect)
	 * 54m  start framing (box or circle)
	 * 
	 * 53m  start over-lined
	 * 55m  stop over-lined
	 * 
	 * note, underlining is reserved for hyperlinks and therefore
	 * omitted
	 * 
	 * </pre>
	 * 
	 * @return the subtitle to display under an avatar's name, might be
	 *         used for team memberships and ownerships, starts after
	 *         '/' and up to '$', and uses ANSI escape codes
	 */
	public String getAvatarSubtitle ();
	
	/**
	 * @return the user's unique numeric ID
	 */
	public int getUserID ();
}
