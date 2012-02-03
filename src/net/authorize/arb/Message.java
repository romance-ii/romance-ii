/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
 * </p>
 * <p>
 * Based upon public domain sample code provided by Authorize.net
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
package net.authorize.arb;

/**
 * WRITEME
 */
public class Message {
	/**
	 * WRITEME
	 */
	private String code;
	/**
	 * WRITEME
	 */
	private String result_code;
	/**
	 * WRITEME
	 */
	private String text;

	/**
	 * WRITEME
	 */
	public Message () {
		code = "";
		result_code = "";
		text = "";
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public String getCode () {
		return code;
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public String getResultCode () {
		return result_code;
	}

	/**
	 * WRITEME
	 * 
	 * @return WRITEME
	 */
	public String getText () {
		return text;
	}

	/**
	 * WRITEME
	 * 
	 * @param code1 WRITEME
	 */
	public void setCode (final String code1) {
		code = code1;
	}

	/**
	 * WRITEME
	 * 
	 * @param result_code1 WRITEME
	 */
	public void setResultCode (final String result_code1) {
		result_code = result_code1;
	}

	/**
	 * WRITEME
	 * 
	 * @param text1 WRITEME
	 */
	public void setText (final String text1) {
		text = text1;
	}

}
