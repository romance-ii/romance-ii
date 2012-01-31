/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2011 Res Interactive, LLC
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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.net.datagram;

import org.starhope.appius.game.ChannelListener;
import org.starhope.util.HasSubversionRevision;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class ADPError extends ADPJSON implements HasSubversionRevision {
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author ewinkelman@resinteractive.com Ed Winkelman
	 */
	public enum Codes {
		FULL (603), INVALID (502), JSONERROR (400), NOTFOUND (404), NSF (
				601), NSI (604), NSP (605), PAIDONLY (602);
		
		/**
		 * WRITEME: Document this ewinkelman@resinteractive.com
		 */
		private final int value;
		
		/**
		 * WRITEME: Document this constructor
		 * ewinkelman@resinteractive.com
		 * 
		 * @param v WRITEME 
		 */
		private Codes (final int v) {
			value = v;
		}
		
		/**
		 * @return the value
		 */
		public int getValue () {
			return value;
		}
	}
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String cmd;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private Codes errCode;
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	private String reason;
	
	/**
	 * Creates an ADP datagram to return error information
	 * 
	 * @param s Source
	 * @param command Command that caused the error
	 * @param newReason Why the error occured
	 * @param code Error code for the error
	 */
	public ADPError (final ChannelListener s, final String command,
			final String newReason, final Codes code) {
		super ("error", s);
		setCommand (command);
		setReason (newReason);
		setErrorCode (code);
	}
	
	/**
	 * @return the cmd
	 */
	@Override
	public String getCommand () {
		return cmd;
	}
	
	/**
	 * @return the errCode
	 */
	public Codes getErrorCode () {
		return errCode;
	}
	
	/**
	 * @return the reason
	 */
	public String getReason () {
		return reason;
	}
	
	/**
	 * @param newCommand the cmd to set
	 */
	public void setCommand (final String newCommand) {
		cmd = newCommand;
		setJSON ("cmd", newCommand);
	}
	
	/**
	 * @param newErrorCode the errCode to set
	 */
	public void setErrorCode (final Codes newErrorCode) {
		errCode = newErrorCode;
		setJSON ("code", newErrorCode.getValue ());
	}
	
	/**
	 * @param newReason the reason to set
	 */
	public void setReason (final String newReason) {
		reason = newReason;
		setJSON ("reason", newReason);
	}
	
}
