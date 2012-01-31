/**
 * <p>
 * Copyright © 2009-2012, Bruce-Robert Pocock
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

package org.starhope.appius.via;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map.Entry;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.util.CastsToJSON;

/**
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Via {
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Jan 15,
	 * 2010) munita (Via)
	 */
	private static final ConcurrentHashMap <Class <? extends ViaMunita <?>>, ConcurrentSkipListSet <Entry <String, Vector <Class <?>>>>> classMethodIntrospectionCache = new ConcurrentHashMap <Class <? extends ViaMunita <?>>, ConcurrentSkipListSet <Entry <String, Vector <Class <?>>>>> ();
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Nov 19,
	 * 2009) peers (Via)
	 */
	private static ConcurrentSkipListSet <ViaHost> peers = new ConcurrentSkipListSet <ViaHost> ();
	
	/**
	 * WRITEME: document this field (brpocock@star-hope.org, Jan 18,
	 * 2010) RPC_CALL (Via)
	 */
	private static final String RPC_CALL = "\ufeed\ud00d";
	
	/**
	 *
	 */
	private final static ConcurrentHashMap <String, Socket> socketCache = new ConcurrentHashMap <String, Socket> ();
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 15,
	 * 2010)
	 * 
	 * @param o an object of the class to be made ready
	 */
	@SuppressWarnings ("unchecked")
	private static void classReady (final ViaMunita <?> o) {
		final Class <? extends ViaMunita <?>> klass = (Class <? extends ViaMunita <?>>) o
				.getClass ();
		if (Via.classMethodIntrospectionCache.containsKey (klass)) {
			return;
		}
		/**
		 * Build up the introspection cache for the given class
		 */
		final ConcurrentSkipListSet <Entry <String, Vector <Class <?>>>> classMethods = new ConcurrentSkipListSet <Entry <String, Vector <Class <?>>>> ();
		for (final Method method : klass.getMethods ()) {
			final Vector <Class <?>> signature = new Vector <Class <?>> ();
			for (final Class <?> parameter : method
					.getParameterTypes ()) {
				signature.add (parameter);
			}
			final HashMap <String, Vector <Class <?>>> fakeMap = new HashMap <String, Vector <Class <?>>> ();
			fakeMap.put (method.getName (), signature);
		}
		Via.classMethodIntrospectionCache.put (klass, classMethods);
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 15,
	 * 2010)
	 * 
	 * @param remote WRITEME
	 * @param methodName WRITEME
	 * @param args WRITEME
	 * @return WRITEME
	 */
	private static Object [] conformRPCArgs (
			final ViaMunita <?> remote, final String methodName,
			final Object... args) {
		return args; // FIXME
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 13,
	 * 2010)
	 * 
	 * @param o the local half of the connection to be connected to its
	 *             remote peer
	 * @throws DoNotCrossTheRubicon WRITEME
	 */
	public static void connect (final ViaMunita <?> o)
			throws DoNotCrossTheRubicon {
		// TODO Auto-generated method stub (brpocock@star-hope.org,
		// Jan 13, 2010)
		
	}
	
	/**
	 * @param in WRITEME
	 * @return WRITEME
	 * @throws ViaCommunicationsException WRITEME
	 */
	@SuppressWarnings ("unused")
	private static Object deserialize (final String in)
			throws ViaCommunicationsException {
		final char indicator = in.charAt (0);
		switch (indicator) {
		case '“':
		default:
			throw new ViaCommunicationsException ("fmt.indicator",
					"Data Format error, expected type indicator character, got “"
							+ indicator + "”");
		}
	}
	
	/**
	 * @param localHalf Local half of the connection
	 */
	public static void flush (final ViaMunita <?> localHalf) {
		for (final Method m : localHalf.getClass ().getMethods ()) {
			final SetRemote a;
			a = m.getAnnotation (SetRemote.class);
			if (null != a) {
				Via.setRemote (localHalf, m, a);
			}
		}
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 11,
	 * 2010)
	 * 
	 * @param url WRITEME
	 * @return WRITEME
	 */
	public static String getPathFromURL (final String url) {
		// TODO Auto-generated method stub (brpocock@star-hope.org,
		// Jan 11, 2010)
		return null;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 11,
	 * 2010)
	 * 
	 * @param url WRITEME
	 * @return WRITEME
	 */
	public static int getPortNumberFromURL (final String url) {
		// TODO Auto-generated method stub (brpocock@star-hope.org,
		// Jan 11, 2010)
		return 0;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 11,
	 * 2010)
	 * 
	 * @param url WRITEME
	 * @return WRITEME
	 */
	public static String getServerNameFromURL (final String url) {
		// TODO Auto-generated method stub (brpocock@star-hope.org,
		// Jan 11, 2010)
		return null;
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @throws NumberFormatException WRITEME
	 * @throws UnknownHostException WRITEME
	 * @throws IOException WRITEME
	 * @throws NotFoundException WRITEME
	 */
	public static void joinPeers () throws NumberFormatException,
			UnknownHostException, IOException, NotFoundException {
		if (Via.peers.size () > 0) {
			return;
			// final Socket render = new Socket (AppiusConfig
			// .getConfig ("org.starhope.appius.via.rendezvous"),
			// AppiusConfig.getInt ("org.starhope.appius.via.port"));
			// final InputStream in = render.getInputStream ();
			// final OutputStream out = render.getOutputStream ();
			// TODO
		}
	}
	
	/**
	 * @param remote WRITEME
	 * @param methodName WRITEME
	 * @param args WRITEME
	 * @return WRITEME
	 */
	public static Object rpc (final ViaMunita <?> remote,
			final String methodName, final Object... args) {
		Via.classReady (remote);
		final Object conformedArgs[] = Via.conformRPCArgs (remote,
				methodName, args);
		final StringBuilder rpcCall = new StringBuilder ();
		rpcCall.append (Via.RPC_CALL);
		for (final Object o : conformedArgs) {
			rpcCall.append (Via.serialize (o));
		}
		final Socket socket = Via.socketCache.get (remote
				.getViaAppiaHostname ()
				+ ":"
				+ remote.getViaAppiaServerPort ());
		OutputStream out = null;
		try {
			out = socket.getOutputStream ();
		} catch (final IOException e) {
			throw new RuntimeException (
					"Caught a IOException in rpc obtaining output stream",
					e);
		}
		try {
			out.write (rpcCall.toString ().getBytes ());
		} catch (final IOException e) {
			throw new RuntimeException (
					"Caught a IOException in rpc write", e);
		}
		BufferedInputStream in = null;
		try {
			in = new BufferedInputStream (socket.getInputStream ());
		} catch (final IOException e) {
			throw new RuntimeException (
					"Caught a IOException in rpc obtaining input stream",
					e);
		}
		try {
			if (in.available () != 0) {
				// nada. just to avoid “unread” errors in compiler.
				// TODO
			}
		} catch (final IOException e) {
			// Default catch action, report bug
			// (brpocock@star-hope.org, Feb 1, 2010)
			Via.log.error ("Caught a IOException in rpc", e);
		}
		
		return null; // FIXME
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Jan 18,
	 * 2010)
	 * 
	 * @param o WRITEME
	 * @return WRITEME
	 */
	private static String serialize (final Object o) {
		final Class <?> klass = o.getClass ();
		if (o instanceof CastsToJSON) {
			final String json$ = ((CastsToJSON) o).toJSON ()
					.toString ();
			final StringBuilder serial = new StringBuilder ();
			serial.append ("J");
			serial.append (klass.getCanonicalName ());
			serial.append ("@");
			serial.append (json$.length ());
			serial.append (json$);
			return serial.toString ();
		}
		if (klass.equals (String.class)) {
			final StringBuilder serial = new StringBuilder ();
			serial.append ("“");
			serial.append ( ((String) o).length ());
			serial.append (o);
			return serial.toString ();
		}
		if (klass.equals (int.class)) {
			final StringBuilder serial = new StringBuilder ();
			serial.append ("i(");
			serial.append (String.valueOf (o));
			serial.append (")");
			return serial.toString ();
		}
		if (klass.equals (char.class)) {
			return "c" + o;
		}
		if (klass.equals (float.class)) {
			return "f(" + String.valueOf (o) + ")";
		}
		if (klass.equals (double.class)) {
			return "d(" + String.valueOf (o) + ")";
		}
		if (klass.equals (Integer.class)) {
			return "I(" + o.toString () + ")";
		}
		if (klass.equals (Character.class)) {
			return "C" + o.toString ();
		}
		if (klass.equals (Float.class)) {
			return "F(" + o.toString () + ")";
		}
		if (klass.equals (Double.class)) {
			return "D(" + o.toString () + ")";
		}
		if (klass.equals (byte.class)) {
			return "b(" + String.valueOf (o) + ")";
		}
		if (klass.equals (Byte.class)) {
			return "B(" + o.toString () + ")";
		}
		
		final String stringified = o.toString ();
		return "¿" + klass.getCanonicalName () + "?"
				+ stringified.length () + stringified;
	}
	
	/**
	 * @param remote WRITEME
	 * @param m WRITEME
	 * @param a WRITEME
	 */
	private static void setRemote (final ViaMunita <?> remote,
			final Method m, final SetRemote a) {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Nov 19,
	 * 2009)
	 * 
	 * @return WRITEME
	 */
	public Set <ViaHost> getPeers () {
		final HashSet <ViaHost> myPeers = new HashSet <ViaHost> ();
		myPeers.addAll (Via.peers);
		return myPeers;
	}
	
}
