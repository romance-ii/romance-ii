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



package net.authorize.arb.http;

/*
 * SSL Handshake and Certificate retrieval based on Sun Microsystems
 * InstallCert.java example
 * http://blogs.sun.com/andreas/resource/InstallCert.java
 */

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.net.UnknownHostException;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLException;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;

import org.starhope.appius.game.AppiusClaudiusCaecus;

/**
 * WRITEME: The documentation for this type (HttpUtil) is incomplete.
 * (brpocock@star-hope.org, Sep 23, 2009)
 * 
 * @author brpocock@star-hope.org
 */
public class HttpUtil {

    /**
     * WRITEME: The documentation for this type (SavingTrustManager) is
     * incomplete. (brpocock@star-hope.org, Nov 19, 2009)
     */
    private static class SavingTrustManager implements X509TrustManager {
        /**
         * WRITEME: document this field chain (SavingTrustManager)
         */
        X509Certificate [] chain;
        /**
         * WRITEME: document this field tm (SavingTrustManager)
         */
        private final X509TrustManager tm;

        /**
         * @param tm1 WRITEME
         */
        SavingTrustManager (final X509TrustManager tm1) {
            tm = tm1;
        }

		/**
		 * This is an overriding method.
		 * 
		 * @see javax.net.ssl.X509TrustManager#checkClientTrusted(java.security.cert.X509Certificate[],
		 *      java.lang.String)
		 */
        @Override
        public void checkClientTrusted (
                final X509Certificate [] certChain,
                final String authType) throws CertificateException {
            throw new UnsupportedOperationException ();
        }

		/**
		 * This is an overriding method.
		 * 
		 * @see javax.net.ssl.X509TrustManager#checkServerTrusted(java.security.cert.X509Certificate[],
		 *      java.lang.String)
		 */
        @Override
        public void checkServerTrusted (
                final X509Certificate [] certChain,
                final String authType) throws CertificateException {
            chain = certChain;
            tm.checkServerTrusted (certChain, authType);
        }

		/**
		 * This is an overriding method.
		 * 
		 * @see javax.net.ssl.X509TrustManager#getAcceptedIssuers()
		 */
        @Override
        public X509Certificate [] getAcceptedIssuers () {
            throw new UnsupportedOperationException ();
        }
    }

    /**
     * WRITEME: document this field (brpocock@star-hope.org, Sep 23,
     * 2009) CERTIFICATE_FILE (HttpUtil)
     */
    public final static String CERTIFICATE_FILE = "Authorize.Net.certs";

    /**
     * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
     * 2009) default_password (HttpUtil)
     */
    private static final String default_password = "example-passphrase";

    /**
     * WRITEME: document this field (brpocock@star-hope.org, Sep 23,
     * 2009) HTTP_PORT (HttpUtil)
     */
    public final static int HTTP_PORT = 80;
    /**
     * WRITEME: document this field (brpocock@star-hope.org, Sep 23,
     * 2009) HTTPS_PORT (HttpUtil)
     */
    public final static int HTTPS_PORT = 443;

    /**
     * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
     * 2009) hostProperty (HttpUtil)
     */
    private String hostProperty = null;
    /**
     * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
     * 2009) is_secure (HttpUtil)
     */
    private boolean is_secure = false;
    /**
     * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
     * 2009) keys (HttpUtil)
     */
    private KeyStore keys = null;

    /**
     * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
     * 2009) pathProperty (HttpUtil)
     */
    private String pathProperty = null;

    /**
     * @param url WRITEME
     */
    public HttpUtil (final java.net.URL url) {
        hostProperty = url.getHost ();
        pathProperty = url.getPath ();
        final String protocol = url.getProtocol ();
        if (protocol.equals ("https")) {
            is_secure = true;
        }
    }

    /**
     * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
     * 2009)
     */
    public void cleanup () {
        final File file = new File (HttpUtil.CERTIFICATE_FILE);
        if (file.exists ()) {
            if (!file.delete ()) {
                AppiusClaudiusCaecus
                .reportBug ("Failed to delete certificate file "
                        + HttpUtil.CERTIFICATE_FILE);
            }
        }
    }

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param socket WRITEME
	 * @param path WRITEME
	 * @param post_data WRITEME
	 * @return WRITEME
	 * @throws IOException WRITEME
	 */
    private String doSocketTransfer (final Socket socket,
            final String path, final String post_data)
    throws IOException {
        String line;
        final StringBuffer sb = new StringBuffer ();
        String method = "GET";
        if (post_data != null) {
            method = "POST";
        }
        final BufferedWriter out = new BufferedWriter (
                new OutputStreamWriter (socket.getOutputStream ()));
        final BufferedReader in = new BufferedReader (
                new InputStreamReader (socket.getInputStream ()));
        out.write (method + " " + path + " HTTP/1.0\n");
        if (post_data != null) {
            out.write ("Content-Length: "
                    + Integer.toString (post_data.length ()) + "\n");
            out.write ("Content-Type: text/xml; charset=\"utf-8\"\n");
        }
        out.write ("\n");
        if (post_data != null) {
            out.write (post_data);
        }
        out.flush ();

        while ( (line = in.readLine ()) != null) {
            sb.append (line + "\r\n");
        }
        out.close ();
        in.close ();
        socket.close ();
        return sb.toString ();
    }

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param thatHost WRITEME
	 * @param path WRITEME
	 * @param post_data WRITEME
	 * @return WRITEME
	 */
    private String getHttpSocket (final String thatHost,
            final String path, final String post_data) {
        Socket socket = null;
        try {
            socket = new Socket (thatHost, HttpUtil.HTTP_PORT);
            socket.setSoTimeout (10000);
			return doSocketTransfer (socket, path, post_data);
		} catch (UnknownHostException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught an UnknownHostException in HttpUtil.getHttpSocket ",
							e);
		} catch (IOException e) {
			AppiusClaudiusCaecus.reportBug (
					"Caught an IOException in HttpUtil.getHttpSocket ",
					e);
		} catch (Exception e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught an unexpectedException in HttpUtil.getHttpSocket ",
							e);
		} finally {
            try {
                if (null != socket) {
                    socket.close ();
                }
            } catch (final IOException e) {
                AppiusClaudiusCaecus.reportBug (e);
            }
        }
        return null;
    }

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param certificate_password WRITEME
	 * @return WRITEME
	 */
    private KeyStore getKeyStore (final char [] certificate_password) {
        if (keys != null) {
            return keys;
        }
        InputStream in = null;
        try {
            final File file = new File (HttpUtil.CERTIFICATE_FILE);
            final KeyStore ks = KeyStore.getInstance (KeyStore
                    .getDefaultType ());
            if (file.exists () == false) {
                // System.out.println("Null keystore");
                return null;
            }
            in = new FileInputStream (file);
            ks.load (in, certificate_password);
            in.close ();
            keys = ks;
        } catch (final Exception e) {
            System.out.println (e);
        } finally {
            if (null != in) {
                try {
                    in.close ();
                } catch (final IOException e) {
                    AppiusClaudiusCaecus.reportBug (e);
                }
            }
        }
        return keys;
    }

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param thatHost WRITEME
	 * @param path WRITEME
	 * @param post_data WRITEME
	 * @return WRITEME
	 */
    private String getSecureHttpSocket (final String thatHost,
            final String path, final String post_data) {
        return this.getSecureHttpSocket (HttpUtil.default_password,
                thatHost, path, post_data);
    }

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @param password WRITEME
	 * @param host WRITEME
	 * @param path WRITEME
	 * @param post_data WRITEME
	 * @return WRITEME
	 */
    private String getSecureHttpSocket (final String password,
            final String host, final String path, final String post_data) {
        // Get a Socket factory
        try {

            if (this.initializeKeyStore (password, host) == false) {
                return null;
            }
            final SSLContext context = SSLContext.getInstance ("TLS");
            final TrustManagerFactory tmf = TrustManagerFactory
            .getInstance (TrustManagerFactory
                    .getDefaultAlgorithm ());
            tmf.init (getKeyStore (password.toCharArray ()));
            final X509TrustManager defaultTrustManager = (X509TrustManager) tmf
            .getTrustManagers () [0];
            final SavingTrustManager tm = new SavingTrustManager (
                    defaultTrustManager);
            context.init (null, new TrustManager [] { tm }, null);
            final SSLSocketFactory factory = context
            .getSocketFactory ();
            final SSLSocket socket = (SSLSocket) factory.createSocket (
                    host, HttpUtil.HTTPS_PORT);
            socket.setSoTimeout (10000);

                // System.out.println("Starting SSL handshake...");
                socket.startHandshake ();

                return doSocketTransfer (socket, path, post_data);
            } catch (final SSLException e) {
			AppiusClaudiusCaecus.reportBug (e);
		} catch (NoSuchAlgorithmException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a NoSuchAlgorithmException in HttpUtil.getSecureHttpSocket ",
							e);
		} catch (KeyStoreException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a KeyStoreException in HttpUtil.getSecureHttpSocket ",
							e);
		} catch (KeyManagementException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a KeyManagementException in HttpUtil.getSecureHttpSocket ",
							e);
		} catch (UnknownHostException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught an UnknownHostException in HttpUtil.getSecureHttpSocket ",
							e);
		} catch (IOException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught an IOException in HttpUtil.getSecureHttpSocket ",
							e);
		}
        return null;
    }

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
    public String getURL () {
        if (is_secure) {
            return this.getSecureHttpSocket (hostProperty,
                    pathProperty, null);
        }
        return getHttpSocket (hostProperty, pathProperty, null);
    }

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @param theHost WRITEME
	 * @return WRITEME
	 */
    public boolean initializeKeyStore (final String theHost) {
        return this.initializeKeyStore (HttpUtil.default_password,
                theHost);
    }

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @param password WRITEME
	 * @param host WRITEME
	 * @return WRITEME
	 */
    public boolean initializeKeyStore (final String password,
            final String host) {
        OutputStream out = null;
        try {
            final char [] certificate_password = password
            .toCharArray ();

            KeyStore ks = getKeyStore (certificate_password);
            if (ks != null) {
                /*
                 * System.out.println("Loading KeyStore " + file +
                 * "..."); InputStream in = new FileInputStream(file);
                 *
                 * ks.load(in, certificate_password); in.close();
                 */
                // System.out.println("Keystore exists.");
                return true;
            }

            ks = KeyStore.getInstance (KeyStore.getDefaultType ());

            // Initialize the empty keystore
            //
            ks.load (null, certificate_password);

            final SSLContext context = SSLContext.getInstance ("TLS");
            final TrustManagerFactory tmf = TrustManagerFactory
            .getInstance (TrustManagerFactory
                    .getDefaultAlgorithm ());
            tmf.init (ks);
            final X509TrustManager defaultTrustManager = (X509TrustManager) tmf
            .getTrustManagers () [0];
            final SavingTrustManager tm = new SavingTrustManager (
                    defaultTrustManager);
            context.init (null, new TrustManager [] { tm }, null);
            final SSLSocketFactory factory = context
            .getSocketFactory ();
            // System.out.println("Opening connection to " + host + ":"
            // + HTTPS_PORT + "...");
            final SSLSocket socket = (SSLSocket) factory.createSocket (
                    host, HttpUtil.HTTPS_PORT);

            socket.setSoTimeout (10000);
            try {
                // System.out.println("Starting SSL handshake...");
                socket.startHandshake ();
                socket.close ();
                System.out.println ();
                // System.out.println("No errors, certificate is already trusted");
            } catch (final SSLException e) {
                // System.out.println();
                // e.printStackTrace(System.out);
            }

            final X509Certificate [] chain = tm.chain;
            if (chain == null || chain.length == 0) {
                System.out
                .println ("Could not obtain server certificate chain");
                return false;
            }

            // System.out.println("Cert Chain: " + chain.length);

            for (int i = 0; i < chain.length; i++ ) {
                final X509Certificate cert = chain [i];
                final String alias = host + "-" + (i + 1);
                ks.setCertificateEntry (alias, cert);
            }

            out = new FileOutputStream (HttpUtil.CERTIFICATE_FILE);
            ks.store (out, certificate_password);
            out.close ();

            return true;

		} catch (KeyStoreException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a KeyStoreException in HttpUtil.initializeKeyStore ",
							e);
		} catch (NoSuchAlgorithmException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a NoSuchAlgorithmException in HttpUtil.initializeKeyStore ",
							e);
		} catch (CertificateException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a CertificateException in HttpUtil.initializeKeyStore ",
							e);
		} catch (IOException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a IOException in HttpUtil.initializeKeyStore ",
							e);
		} catch (KeyManagementException e) {
			AppiusClaudiusCaecus
					.reportBug (
							"Caught a KeyManagementException in HttpUtil.initializeKeyStore ",
							e);
		} finally {
            if (null != out) {
                try {
                    out.close ();
                } catch (final IOException e) {
                    // Default catch action, report bug (brpocock@star-hope.org, Oct
                    // 13, 2009)
                    AppiusClaudiusCaecus.reportBug (e);
                }
            }
        }
        return false;
    }

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Sep 23,
	 * 2009)
	 * 
	 * @param data WRITEME
	 * @return WRITEME
	 */
    public String postUrl (final String data) {
        if (is_secure) {
            return this.getSecureHttpSocket (hostProperty,
                    pathProperty, data);
        }
        return getHttpSocket (hostProperty, pathProperty, data);
    }
}
