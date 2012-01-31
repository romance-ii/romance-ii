/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
package org.starhope.appius.net;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.geometry.Tuple2D;
import org.starhope.appius.user.notifications.Notification;
import org.starhope.util.LibMisc;

/**
 * <p>
 * The user-agent can specify its capabilities. XXX: Actually, it can't!
 * This object contains the capabilities of a given user-agent,
 * connected on behalf of a certain user.
 * </p>
 * <p>
 * By asking for an active user's user-agent capabilities, the server
 * might modify game play in some ways to better suit the player's
 * ability to perform certain actions or interact in certain ways with
 * the game.
 * </p>
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class UserAgentInfo implements Serializable {
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private static final long serialVersionUID = 8088831881179389093L;
	/**
	 * WRITEME: Document this field brpocock
	 */
	private boolean acceptsNotifications = false;
	/**
	 * WRITEME: Document this field brpocock
	 */
	private String appName = "unknown";
	/**
	 * @see #setCanClick(boolean)
	 */
	private boolean canClick = true;
	/**
	 * WRITEME: Document this field brpocock
	 */
	private final Map <String, String> caps = new HashMap <String, String> ();
	/**
	 * <p>
	 * The name of the hardware platform on which the user-agent is
	 * running.
	 * </p>
	 */
	private String hardware = "unknown";
	/**
	 * WRITEME: Document this field brpocock
	 */
	private boolean hasDirections = true;
	/**
	 * @see #setHasKeyboard(boolean)
	 */
	private boolean hasKeyboard = true;
	
	/**
	 * WRITEME: Document this field brpocock
	 */
	private boolean hasModClick = true;
	
	/**
	 * WRITEME: Document this field brpocock
	 */
	private int infinityModeMaxLevel = 1;
	
	/**
	 * WRITEME: Document this field brpocock
	 */
	private int infinityModeMinLevel = 0;
	
	/**
	 * WRITEME: Document this field brpocock
	 */
	private String kernelVersion = "unknown";
	/**
	 * WRITEME: Document this field brpocock
	 */
	private String os = "unknown";
	/**
	 * @see #isPascalMode()
	 */
	private boolean pascalMode = false;
	/**
	 * WRITEME: Document this field brpocock
	 */
	private String version = "0?";
	
	/**
	 * WRITEME: Document this field brpocock
	 */
	private Tuple2D <?> windowSize = new Coord2D (800, 600);
	
	/**
	 * Nil constructor, applies some general defaults.
	 */
	public UserAgentInfo () {
		// no op
	}
	
	/**
	 * @return whether the user-agent accepts/handles Appius 1.1
	 *         Notification messages
	 */
	public boolean acceptsNotifications () {
		return acceptsNotifications;
	}
	
	/**
	 * @return whether the client can directly click/tap/touch/&c. into
	 *         a room.
	 */
	public boolean canClick () {
		return canClick;
	}
	
	/**
	 * @return the user-agent name reported
	 */
	public String getAppName () {
		return appName;
	}
	
	/**
	 * Get an arbitrary client extension capability string
	 * 
	 * @param cap The capability string
	 * @return the value provided by the client for that capability
	 * @throws NotFoundException if the client does not report a value
	 *              for the given capability string
	 */
	public String getCap (final String cap) throws NotFoundException {
		if ( !caps.containsKey (cap)) {
			throw new NotFoundException (cap);
		}
		return caps.get (cap);
	}
	
	/**
	 * @return the hardware
	 */
	public String getHardware () {
		return hardware;
	}
	
	/**
	 * @return The maximum supported alef-level of the Infinity Mode
	 *         communications protocol level (≥ 0)
	 */
	public int getInfinityModeMaxLevel () {
		return infinityModeMaxLevel;
	}
	
	/**
	 * @return The minimum supported alef-level of the Infinity Mode
	 *         communications protocol level (≥ 0)
	 */
	public int getInfinityModeMinLevel () {
		return infinityModeMinLevel;
	}
	
	/**
	 * @return the user-agent's host OS kernel version
	 */
	public String getKernelVersion () {
		return kernelVersion;
	}
	
	/**
	 * @return the user-agent's host OS
	 */
	public String getOS () {
		return os;
	}
	
	/**
	 * @return The version reported by the user-agent
	 */
	public String getVersion () {
		return version;
	}
	
	/**
	 * The user-agent may only be able to display a certain area in
	 * pixels; these may not literally equate to pixels, because of
	 * client-side zooming effects and so forth, but when we send data
	 * to the client as “pixel units,” we can pretend that they are.
	 * Generally we assume a client-side size of 800×600, until/unless
	 * reported otherwise.
	 * 
	 * @return the area in room measurement virtual pixels that the
	 *         client can display at once.
	 */
	public Tuple2D <?> getWindowSize () {
		return windowSize;
	}
	
	/**
	 * @return whether the client has cursor keys, directional pad,
	 *         D-pad, trackball, joystick, or something analogous.
	 */
	public boolean hasDirections () {
		return hasDirections;
	}
	
	/**
	 * @return whether the client has a keyboard (versus a
	 *         software-supplied text-entry mechanism of some kind, for
	 *         which we should “pause” their game, perhaps)
	 */
	public boolean hasKeyboard () {
		return hasKeyboard;
	}
	
	/**
	 * @return whether the client can click with modifiers like Shift
	 *         or so forth. Absent on touchscreens and similar devices,
	 *         typically.
	 */
	public boolean hasModClick () {
		return hasModClick;
	}
	
	/**
	 * <p>
	 * In Pascal mode, the user-agent can accept raw, binary data
	 * safely. This is done by prefacing each datagram with its length,
	 * in the following format:
	 * </p>
	 * <ul>
	 * <li>If the length is less than 255 <em>bytes</em> (not
	 * characters), the binary value of the length is sent, followed by
	 * the contents</li>
	 * <li>If the length is equal to or greater than 255 bytes, then
	 * the magic value x'ff' is sent, followed by the 64-bit length
	 * indicator as eight bytes in network (big-endian) byte order.</li>
	 * </ul>
	 * <p>
	 * If Pascal mode is disabled, each packet will end with the record
	 * terminator of '\0' (NUL)
	 * </p>
	 * 
	 * @return true, if the user-agent is in Pascal mode; false, for
	 *         zero-terminated records.
	 */
	public boolean isPascalMode () {
		return pascalMode;
	}
	
	/**
	 * @param really whether the user-agent understands and dispatches
	 *             {@link Notification} messages (an Appius 1.1 feature
	 *             which is not mandatory for all user-agents to
	 *             support)
	 */
	public void setAcceptsNotifications (final boolean really) {
		acceptsNotifications = really;
	}
	
	/**
	 * @param uaAppName the (general, un-versioned) name of the
	 *             user-agent being used
	 */
	public void setAppName (final String uaAppName) {
		appName = uaAppName;
	}
	
	/**
	 * @param uaCanClick whether the user-agent can send “click” events
	 *             (e.g. has a mouse, touchscreen, or similar
	 *             direct-coördinate-input device)
	 */
	public void setCanClick (final boolean uaCanClick) {
		canClick = uaCanClick;
	}
	
	/**
	 * accept a capabilities string from the client
	 * 
	 * @param cap the capability moniker, typically in dotted notation
	 * @param value the value of that capability
	 * @return the capability value, for chaining
	 */
	public String setCap (final String cap, final String value) {
		caps.put (cap, value);
		return value;
	}
	
	/**
	 * <p>
	 * Definition: The hardware string provided should comply with the
	 * following restrictions:
	 * </p>
	 * <p>
	 * For PC-type hardware, the CPU architecture of the system should
	 * be used, using the Fedora/Red Hat nomenclature for typical
	 * platforms. This means post-Pentium-type 32-bit architectures of
	 * Intel chips must return “i686,” 64-bit Intel/AMD-type systems
	 * must return “x86_64,” and PowerPC systems must provide “ppc.”
	 * </p>
	 * <p>
	 * For portable computers and mobile devices running a similar OS,
	 * the CPU architecture should be in the same format; e.g. an
	 * Android device might be “arm9”
	 * </p>
	 * <p>
	 * For Nokia phones, the Nokia platform name, in a format like
	 * “nokia_s60” is preferred.
	 * </p>
	 * <p>
	 * For game consoles, the canonical name of the platform,
	 * lower-cased, with underscores, and without the vendor name, is
	 * preferred. For example: “wii,” “playstation_3,” “xbox_360,”
	 * “nintendo_ds,” “nintendo_dsi,” “nintendo_3ds.” Note that the
	 * word “Nintendo” is part of the name of the DS/DSi/3DS, but
	 * Nintendo/Sony/MicroSoft are not part of the names of the
	 * respective home consoles.
	 * </p>
	 * 
	 * @param newHardware the hardware platform upon which the
	 *             user-agent is running
	 */
	public void setHardware (final String newHardware) {
		hardware = newHardware;
	}
	
	/**
	 * @param uaHasDirections whether the user-agent has directional
	 *             controls
	 */
	public void setHasDirections (final boolean uaHasDirections) {
		hasDirections = uaHasDirections;
	}
	
	/**
	 * @param uaHasKeyboard whether the user-agent has a keyboard that
	 *             can be accessed <em>without</em> operating an
	 *             overlay (not a touchscreen or similar text-entry
	 *             mechanism)
	 */
	public void setHasKeyboard (final boolean uaHasKeyboard) {
		hasKeyboard = uaHasKeyboard;
	}
	
	/**
	 * <p>
	 * A modified click event consists of the following capabilities,
	 * which are typically found in a mouse + keyboard or similar
	 * environment, and typically not found in a touchscreen system.
	 * </p>
	 * <ul>
	 * <li>Support for three mouse buttons (button 1, 2, 3) or
	 * analogues</li>
	 * <li>Support for modifier keys Shift, Control/Command,
	 * Alt/Meta/Option, and Super/Winkey/Hyper, being held down while
	 * clicking with any button </p>
	 * </ul>
	 * <p>
	 * Note that e.g. a Wiimote might be a valid way to send modified
	 * click events without a traditional mouse + keyboard system.
	 * </p>
	 * 
	 * @param uaHasModClick whether the user-agent can send modified
	 *             click events.
	 */
	public void setHasModClick (final boolean uaHasModClick) {
		hasModClick = uaHasModClick;
	}
	
	/**
	 * @param uaMaxInfinity the maximum alef-level of Infinity protocol
	 *             understood by the user-agent
	 */
	public void setInfinityModeMaxLevel (final int uaMaxInfinity) {
		infinityModeMaxLevel = uaMaxInfinity;
	}
	
	/**
	 * @param uaMinInfinity the minimum alef-level of Infinity protocol
	 *             understood by the user-agent
	 */
	public void setInfinityModeMinLevel (final int uaMinInfinity) {
		infinityModeMinLevel = uaMinInfinity;
	}
	
	/**
	 * @param userKernelVersion the kernel version (or analogue) of the
	 *             client machine
	 */
	public void setKernelVersion (final String userKernelVersion) {
		kernelVersion = userKernelVersion;
	}
	
	/**
	 * @param userOS the OS of the client machine
	 */
	public void setOS (final String userOS) {
		os = userOS;
	}
	
	/**
	 * Set or clear Pascal mode — see {@link #isPascalMode()}
	 * 
	 * @param really if true, turn on Pascal mode; if false, disable
	 */
	public void setPascalMode (final boolean really) {
		pascalMode = really;
	}
	
	/**
	 * @param userVersion the version of the user-agent software being
	 *             used
	 */
	public void setVersion (final String userVersion) {
		version = userVersion;
	}
	
	/**
	 * @param uaWindowSize the maximum size of the window (into the
	 *             world) that the user-agent can display
	 *             simultaneously
	 */
	public void setWindowSize (final Tuple2D <?> uaWindowSize) {
		windowSize = uaWindowSize;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		final StringBuilder s = new StringBuilder ();
		s.append (" User Agent “");
		s.append (appName);
		s.append ("” version “");
		s.append (version);
		s.append ("”; can speak Infinity mode א");
		s.append (infinityModeMinLevel);
		s.append (" through א");
		s.append (infinityModeMaxLevel);
		s.append (". Basic capabilities: D-pad? ");
		s.append (Boolean.toString (hasDirections));
		s.append ("; Clicks? ");
		s.append (Boolean.toString (canClick));
		s.append ("; Keyboard? ");
		s.append (Boolean.toString (hasKeyboard));
		s.append ("; Mod-Clicks? ");
		s.append (Boolean.toString (hasModClick));
		s.append (". Window size = ");
		s.append (windowSize.toString ());
		s.append (". OS=“");
		s.append (getOS ());
		s.append ("” kernel version=“");
		s.append (getKernelVersion ());
		s.append ("” hardware platform=“");
		s.append (getHardware ());
		s.append ("”. Optional client features: accepts notifications? ");
		s.append (acceptsNotifications);
		s.append (" Pascal mode? ");
		s.append (pascalMode);
		s.append (". Additional client capabilities reported: {");
		s.append (LibMisc.stringify (caps));
		s.append ("}");
		return s.toString ();
	}
}
