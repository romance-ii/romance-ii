/**
 * $Id: AimConfig.java 2476 2010-01-05 18:06:56Z brpocock@star-hope.org
 * $
 * <p>
 * Copyright © 2005-2008 Axis Data Management Corp.
 * </p>
 * <p>
 * Copyright © 2009-2010 Bruce-Robert Pocock
 * </p>
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License"); you
 * may not use this file except in compliance with the License. You may
 * obtain a copy of the License at
 * </p>
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * </p>
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 * </p>
 */

package net.authorize.admc.authnet;

import java.net.MalformedURLException;
import java.net.URL;

import org.starhope.appius.util.AppiusConfig;

/**
 * The testMode settings of the AimConfig is a default which may be
 * overridden for individual AimTransactions.
 */
public class AimConfig {
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 13, 2009)
	 *
	 * login (AimConfig)
	 */
	private String login = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 13, 2009)
	 *
	 * md5Kernel (AimConfig)
	 */
	private String md5Kernel = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 13, 2009)
	 *
	 * pdelimiter (AimConfig)
	 */
	private char pdelimiter = '\0';
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 13, 2009)
	 *
	 * pencap (AimConfig)
	 */
	private char pencap = '\0';
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 13, 2009)
	 *
	 * pminfields (AimConfig)
	 */
	private int pminfields = -1;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 13, 2009)
	 *
	 * prelay_response (AimConfig)
	 */
	private String prelay_response = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 13, 2009)
	 *
	 * pversion (AimConfig)
	 */
	private String pversion = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 13, 2009)
	 *
	 * requireCardCode (AimConfig)
	 */
	private boolean requireCardCode = false;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 13, 2009)
	 *
	 * testMode (AimConfig)
	 */
	private boolean testMode = false;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 13, 2009)
	 *
	 * tran_key (AimConfig)
	 */
	private String tran_key = null;
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 13, 2009)
	 *
	 * url (AimConfig)
	 */
	private URL url = null;

	/**
	 * @throws AuthNetException WRITEME
	 */
	public AimConfig () throws AuthNetException {
		String tmpString;

		final String urlString = AppiusConfig
		.getConfigOrNull ("net.authorize.arbURL");
		if (urlString == null) {
			throw new AuthNetException (
			"Property 'url' is not set in authnet.properties");
		}
		try {
			url = new URL (urlString);
		} catch (final MalformedURLException mue) {
			throw new AuthNetException ("Bad URL '" + urlString
					+ "':  " + mue);
		}
		login = AppiusConfig.getConfigOrNull ("net.authorize.login");
		if (login == null) {
			throw new AuthNetException (
			"Property 'login' is not set in authnet.properties");
		}
		tran_key = AppiusConfig
		.getConfigOrNull ("net.authorize.transactionKey");
		if (tran_key == null) {
			throw new AuthNetException (
			"Property 'tran_key' is not set in authnet.properties");
		}
		tmpString = AppiusConfig
		.getConfigOrNull ("net.authorize.protocol.delimiter");
		if (tmpString != null && tmpString.length () > 0) {
			pdelimiter = tmpString.charAt (0);
		}
		if (pdelimiter == '\0') {
			throw new AuthNetException (
			"Property 'protocol.delimiter' is not set in authnet.properties");
		}
		tmpString = AppiusConfig
		.getConfigOrNull ("net.authorize.protocol.encap");
		if (tmpString != null && tmpString.length () > 0) {
			pencap = tmpString.charAt (0);
		}
		tmpString = AppiusConfig
		.getConfigOrNull ("net.authorize.protocol.minfields");
		if (tmpString != null && tmpString.length () > 0) {
			try {
				pminfields = Integer.parseInt (tmpString);
			} catch (final NumberFormatException nfe) {
				throw new AuthNetException (
				"Non-numeric format for 'protocl.minfields' in properties");
			}
		}
		if (pminfields < 0) {
			throw new AuthNetException (
			"Property 'protocol.minfields' is not set in authnet.properties");
		}
		pversion = AppiusConfig
		.getConfigOrNull ("net.authorize.protocol.version");
		md5Kernel = AppiusConfig
		.getConfigOrNull ("net.authorize.protocol.md5kernel");
		prelay_response = AppiusConfig
		.getConfigOrNull ("net.authorize.protocol.relay_reponse");
		testMode = AppiusConfig
		.getConfigBoolOrFalse ("net.authorize.testMode");
		requireCardCode = AppiusConfig
		.getConfigBoolOrFalse ("net.authorize.request.require_cardcode");
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @return WRITEME
	 */
	public String getLogin () {
		return login;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @return WRITEME
	 */
	public String getMd5Kernel () {
		return md5Kernel;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @return WRITEME
	 */
	public char getPdelimiter () {
		return pdelimiter;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @return WRITEME
	 */
	public char getPencap () {
		return pencap;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @return WRITEME
	 */
	public int getPminfields () {
		return pminfields;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @return WRITEME
	 */
	public String getPrelay_response () {
		return prelay_response;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @return WRITEME
	 */
	public String getPversion () {
		return pversion;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @return WRITEME
	 */
	public boolean getRequireCardCode () {
		return requireCardCode;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @return WRITEME
	 */
	public boolean getTestMode () {
		return testMode;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @return WRITEME
	 */
	public String getTran_key () {
		return tran_key;
	}

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @return WRITEME
	 */
	public URL getUrl () {
		return url;
	}

	/**
	 *
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13, 2009)
	 *
	 * @return WRITEME
	 */
	public boolean isTestMode () {
		return getTestMode ();
	}

	/**
	 * Get your AimTransaction instances here!
	 *
	 * <p>
	 * We purposefully keep no handle to the new transactions. When user
	 * finishes with them, the JVM should GC them.
	 * </p>
	 *
	 * @return WRITEME
	 */
	public AimTransaction newTransaction () {
		return new AimTransaction (this);
	}
}
