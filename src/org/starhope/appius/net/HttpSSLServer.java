/*
 * ====================================================================
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements. See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to you under the Apache License, Version
 * 2.0 (the "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0 Unless required by
 * applicable law or agreed to in writing, software distributed under
 * the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License
 * for the specific language governing permissions and limitations under
 * the License.
 * ====================================================================
 * This software consists of voluntary contributions made by many
 * individuals on behalf of the Apache Software Foundation. For more
 * information on the Apache Software Foundation, please see
 * <http://www.apache.org/>.
 */

package org.starhope.appius.net;

import java.io.IOException;
import java.io.InterruptedIOException;
import java.net.InetSocketAddress;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import java.util.Locale;

import javax.net.ssl.KeyManager;
import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLEngine;
import javax.net.ssl.SSLException;
import javax.net.ssl.SSLSession;

import org.apache.http.HttpEntity;
import org.apache.http.HttpEntityEnclosingRequest;
import org.apache.http.HttpException;
import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.apache.http.HttpResponseInterceptor;
import org.apache.http.HttpStatus;
import org.apache.http.MethodNotSupportedException;
import org.apache.http.impl.DefaultConnectionReuseStrategy;
import org.apache.http.impl.DefaultHttpResponseFactory;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.params.CoreProtocolPNames;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.HttpContext;
import org.apache.http.protocol.HttpProcessor;
import org.apache.http.protocol.HttpRequestHandler;
import org.apache.http.protocol.HttpRequestHandlerRegistry;
import org.apache.http.protocol.ResponseConnControl;
import org.apache.http.protocol.ResponseContent;
import org.apache.http.protocol.ResponseDate;
import org.apache.http.protocol.ResponseServer;
import org.apache.http.util.EntityUtils;

/**
 * Basic, yet fully functional and spec compliant, HTTPS/1.1 server
 * based on the non-blocking I/O model.
 * <p>
 * Please note the purpose of this application is demonstrate the usage
 * of HttpCore APIs. It is NOT intended to demonstrate the most
 * efficient way of building an HTTP server.
 */
public class HttpSSLServer extends Thread {
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	static class EventLogger implements EventListener {
		
		@Override
		public void connectionClosed (final NHttpConnection conn) {
			log.debug ("Connection closed: " + conn);
		}
		
		@Override
		public void connectionOpen (final NHttpConnection conn) {
			log.debug ("Connection open: " + conn);
		}
		
		@Override
		public void connectionTimeout (final NHttpConnection conn) {
			log.debug ("Connection timed out: " + conn);
		}
		
		@Override
		public void fatalIOException (final IOException ex,
				final NHttpConnection conn) {
			log.error ("I/O error: ", ex);
		}
		
		@Override
		public void fatalProtocolException (final HttpException ex,
				final NHttpConnection conn) {
			log.error ("HTTP error: ", ex);
		}
		
	}
	
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
	static class HttpHandler implements HttpRequestHandler {
		
		/**
		 * WRITEME: Document this constructor
		 * ewinkelman@resinteractive.com
		 * 
		 * @param docRoot WRITEME 
		 */
		public HttpHandler () {
			super ();
		}
		
		@Override
		public void handle (final HttpRequest request,
				final HttpResponse response,
				final HttpContext context) throws HttpException,
				IOException {
			
			final String method = request.getRequestLine ()
					.getMethod ().toUpperCase (Locale.ENGLISH);
			if ( !method.equals ("GET") && !method.equals ("HEAD")
					&& !method.equals ("POST")) {
				throw new MethodNotSupportedException (method
						+ " method not supported");
			}
			
			if (request instanceof HttpEntityEnclosingRequest) {
				final HttpEntity entity = ((HttpEntityEnclosingRequest) request)
						.getEntity ();
				final byte [] entityContent = EntityUtils
						.toByteArray (entity);
				log.debug ("Incoming entity content (bytes): {}",
						entityContent.length);
			}
			
			final String target = request.getRequestLine ()
					.getUri ();
			
			log.debug (target);
			// final File file = new File (docRoot, URLDecoder.decode
			// (target, "UTF-8"));
			// if ( !file.exists ()) {
			//
			// response.setStatusCode (HttpStatus.SC_NOT_FOUND);
			// EntityTemplate body = new EntityTemplate (new
			// ContentProducer () {
			//
			// @Override
			// public void writeTo (final OutputStream outstream)
			// throws IOException {
			// OutputStreamWriter writer = new OutputStreamWriter
			// (outstream, "UTF-8");
			// writer.write ("<html><body><h1>");
			// writer.write ("File ");
			// writer.write (file.getPath ());
			// writer.write (" not found");
			// writer.write ("</h1></body></html>");
			// writer.flush ();
			// }
			//
			// });
			// body.setContentType ("text/html; charset=UTF-8");
			// response.setEntity (body);
			// System.out.println ("File " + file.getPath () +
			// " not found");
			//
			// } else if ( !file.canRead () || file.isDirectory ()) {
			//
			// response.setStatusCode (HttpStatus.SC_FORBIDDEN);
			// EntityTemplate body = new EntityTemplate (new
			// ContentProducer () {
			//
			// @Override
			// public void writeTo (final OutputStream outstream)
			// throws IOException {
			// OutputStreamWriter writer = new OutputStreamWriter
			// (outstream, "UTF-8");
			// writer.write ("<html><body><h1>");
			// writer.write ("Access denied");
			// writer.write ("</h1></body></html>");
			// writer.flush ();
			// }
			//
			// });
			// body.setContentType ("text/html; charset=UTF-8");
			// response.setEntity (body);
			// System.out.println ("Cannot read file " + file.getPath
			// ());
			//
			// } else {
			
			response.setStatusCode (HttpStatus.SC_OK);
			final NStringEntity body = new NStringEntity (
					"<html><body><h1>Made a successful connection</h1></body></html>");
			
			body.setContentType ("text/html; charset=UTF-8");
			response.setEntity (body);
			
			// }
		}
		
	}
	
	/**
	 * WRITEME: Document this ewinkelman@resinteractive.com
	 */
	static Logger log = LoggerFactory.getLogger (HttpSSLServer.class);
	
	/**
	 * The currently running IO reactor
	 */
	ListeningIOReactor ioReactor;
	
	/**
	 * One shot variable to determine if this thread has already been
	 * run once
	 */
	private boolean readyToRun = true;
	
	/**
	 * @see java.lang.Thread#getUncaughtExceptionHandler()
	 */
	@Override
	public UncaughtExceptionHandler getUncaughtExceptionHandler () {
		return new UncaughtExceptionHandler () {
			
			@Override
			public void uncaughtException (final Thread arg0,
					final Throwable e) {
				log.error (
						"HTTPS Server Thread experienced an uncaught expection",
						e);
			}
		};
	}
	
	/**
	 * @return the readyToRun
	 */
	public boolean isReadyToRun () {
		return readyToRun;
	}
	
	/**
	 * @see java.lang.Thread#run()
	 */
	@Override
	public void run () {
		try {
			readyToRun = false;
			log.info ("HTTPS Server Starting");
			final ClassLoader cl = HttpSSLServer.class
					.getClassLoader ();
			final URL url = cl.getResource ("appius.jks");
			final KeyStore keystore = KeyStore.getInstance ("jks");
			keystore.load (url.openStream (),
					"symphony".toCharArray ());
			final KeyManagerFactory kmfactory = KeyManagerFactory
					.getInstance (KeyManagerFactory
							.getDefaultAlgorithm ());
			kmfactory.init (keystore, "symphony".toCharArray ());
			final KeyManager [] keymanagers = kmfactory
					.getKeyManagers ();
			final SSLContext sslcontext = SSLContext
					.getInstance ("TLS");
			sslcontext.init (keymanagers, null, null);
			
			final SSLSetupHandler sslhandler = new SSLSetupHandler () {
				
				@Override
				public void initalize (final SSLEngine sslengine,
						final HttpParams params)
						throws SSLException {
					// Ask clients to authenticate
					sslengine.setWantClientAuth (false);
					// Enforce strong ciphers
					final String [] suites = sslengine
							.getSupportedCipherSuites ();
					sslengine.setEnabledCipherSuites (suites);
				}
				
				@Override
				public void verify (final IOSession arg0,
						final SSLSession arg1)
						throws SSLException {
					// TODO Auto-generated method stub
					
				}
				
			};
			
			final HttpParams params = new SyncBasicHttpParams ();
			params.setIntParameter (CoreConnectionPNames.SO_TIMEOUT,
					5000)
					.setIntParameter (
							CoreConnectionPNames.SOCKET_BUFFER_SIZE,
							8 * 1024)
					.setBooleanParameter (
							CoreConnectionPNames.STALE_CONNECTION_CHECK,
							false)
					.setBooleanParameter (
							CoreConnectionPNames.TCP_NODELAY,
							true)
					.setParameter (
							CoreProtocolPNames.ORIGIN_SERVER,
							"Jakarta-HttpComponents-NIO/1.1");
			
			final HttpProcessor httpproc = new ImmutableHttpProcessor (
					new HttpResponseInterceptor [] {
							new ResponseDate (),
							new ResponseServer (),
							new ResponseContent (),
							new ResponseConnControl () });
			
			final BufferingHttpServiceHandler handler = new BufferingHttpServiceHandler (
					httpproc, new DefaultHttpResponseFactory (),
					new DefaultConnectionReuseStrategy (), params);
			
			// Set up request handlers
			final HttpRequestHandlerRegistry reqistry = new HttpRequestHandlerRegistry ();
			reqistry.register ("*", new HttpHandler ());
			
			handler.setHandlerResolver (reqistry);
			
			// Provide an event logger
			handler.setEventListener (new EventLogger ());
			
			final IOEventDispatch ioEventDispatch = new SSLServerIOEventDispatch (
					handler, sslcontext, sslhandler, params);
			
			ioReactor = new DefaultListeningIOReactor (2, params);
			ioReactor.listen (new InetSocketAddress (2780));
			ioReactor.execute (ioEventDispatch);
		} catch (final InterruptedIOException e) {
			log.error ("HTTPS Server Thread Interrupted", e);
		} catch (final IOException e) {
			log.error ("HTTPS Server Thread IO Exception:", e);
		} catch (final KeyStoreException e) {
			log.error (
					"HTTPS Server Thread experienced an uncaught expection:",
					e);
		} catch (final NoSuchAlgorithmException e) {
			log.error ("Exception", e);
		} catch (final CertificateException e) {
			log.error ("Exception", e);
		} catch (final UnrecoverableKeyException e) {
			log.error ("Exception", e);
		} catch (final KeyManagementException e) {
			log.error ("Exception", e);
		}
		log.warn ("HTTPS Server shutting down");
	}
	
	/**
	 * Determines if the HTTPS server is running
	 * 
	 * @return WRITEME 
	 */
	public boolean running () {
		return (ioReactor != null)
				&& (ioReactor.getStatus () == IOReactorStatus.ACTIVE);
	}
	
	/**
	 * Shuts down the HTTPS server
	 */
	public void shutdown () {
		if (ioReactor.getStatus () == IOReactorStatus.ACTIVE) {
			try {
				ioReactor.shutdown ();
			} catch (final IOException e) {
				log.error ("IOException", e);
			}
		}
	}
	
}
