/**
 * <p>
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010 Res Interactive, LLC
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
package org.starhope.catullus;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.URI;
import java.net.URISyntaxException;
import java.rmi.AccessException;
import java.rmi.AlreadyBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.RMIClientSocketFactory;
import java.rmi.server.RMIServerSocketFactory;
import java.rmi.server.UnicastRemoteObject;

import org.starhope.appius.except.DataException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.npc.NullLoader;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.DataRecord;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.via.Setter;

/**
 * Gaius Valerius Catullus is the class moving data around between the
 * client and server … WRITEME
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class GaiusValeriusCatullus extends UnicastRemoteObject
		implements JavaRMIServer {
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	static final class BoringSocketFactory implements
			RMIClientSocketFactory {
		/**
		 * @see java.rmi.server.RMIClientSocketFactory#createSocket(java.lang.String,
		 *      int)
		 */
		@Override
		public Socket createSocket (final String otherHost,
				final int otherPort) throws IOException {
			return new Socket (InetAddress.getByName (otherHost),
					otherPort);
		}
	}
	
	/**
	 * a simple factory to emit server sockets for RMI
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	static final class LocalServerSocketFactory implements
			RMIServerSocketFactory {
		/**
		 * the local hostname
		 */
		private final String host;
		
		/**
		 * create a {@link LocalServerSocketFactory} for the given
		 * host (which should be the local host!)
		 * 
		 * @param thisHost the host name
		 */
		LocalServerSocketFactory (final String thisHost) {
			host = thisHost;
		}
		
		/**
		 * @see java.rmi.server.RMIServerSocketFactory#createServerSocket(int)
		 */
		@Override
		public ServerSocket createServerSocket (final int localPort)
				throws IOException {
			return new ServerSocket (localPort, 10,
					InetAddress.getByName (host));
		}
	}
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = 199428803624087421L;
	
	/**
	 * set all properties of a data record based upon its peer
	 * 
	 * @param <T> type of the source and destination
	 * @param dest the object to be altered to match the other
	 * @param source the source from which properties are to be copied
	 * @return the destination (for chaining)
	 * @throws DataException if the objects aren't compatible
	 */
	@SuppressWarnings ("unchecked")
	static <T extends DataRecord> T setAll (final T dest,
			final T source) throws DataException {
		final Class <T> klass = (Class <T>) dest.getClass ();
		
		final RecordLoader <? extends DataRecord> oldLoader = dest
				.getRecordLoader ();
		dest.setRecordLoader (new NullLoader <T> (klass));
		
		if (Copyable.class.isInstance (dest)) {
			if ( !source.getClass ().equals (klass)) {
				throw new DataException ("class mismatch: peer "
						+ klass.getCanonicalName () + " is not "
						+ source.getClass ().getCanonicalName ());
			}
			((Copyable <T>) dest).copyProtoype (source);
			
		} else {
			GaiusValeriusCatullus.setAll_annotatedClass (dest,
					source, klass);
		}
		
		if ( (null == oldLoader)
				|| (oldLoader instanceof NullLoader <?>)) {
			dest.setRecordLoader (AppiusConfig
					.getRecordLoaderForClass (klass));
		} else {
			dest.setRecordLoader (oldLoader);
		}
		return dest;
	}
	
	/**
	 * set all properties for an annotated class (using the
	 * {@link Setter} annotations and such)
	 * 
	 * @param <T> WRITEME
	 * @param dest WRITEME
	 * @param source WRITEME
	 * @param klass WRITEME
	 * @throws SecurityException WRITEME
	 * @throws DataException WRITEME
	 */
	private static <T extends DataRecord> void setAll_annotatedClass (
			final T dest, final T source, final Class <T> klass)
			throws SecurityException, DataException {
		boolean seenOne = false;
		METHODS: for (final Method m : klass.getMethods ()) {
			if (m.isAnnotationPresent (Setter.class)) {
				seenOne = true;
				final String getName = GaiusValeriusCatullus
						.setAll_getSetter (klass, m);
				final Class <?> [] parameterTypes = m
						.getParameterTypes ();
				if (parameterTypes.length < 1) {
					BugReporter
							.getReporter ("srv")
							.reportBug (
									"Setter taking no parameters found: only single-object setters are supported by Catullus: "
											+ klass.getCanonicalName ()
											+ "::"
											+ m.toGenericString ());
				}
				if (parameterTypes.length > 1) {
					BugReporter
							.getReporter ("srv")
							.reportBug (
									"Setter taking multiple parameters found: only single-object setters are supported by Catullus: "
											+ klass.getCanonicalName ()
											+ "::"
											+ m.toGenericString ());
					continue METHODS;
				}
				final Class <?> kind = parameterTypes [0];
				Method getter;
				try {
					getter = klass.getMethod (getName);
				} catch (final SecurityException e) {
					log.error (
							"Caught a SecurityException for "
									+ kind.toString ()
									+ " "
									+ getName
									+ " for "
									+ klass.getCanonicalName ()
									+ "::"
									+ m.toGenericString (), e);
					continue METHODS;
				} catch (final NoSuchMethodException e) {
					BugReporter
							.getReporter ("srv")
							.reportBug (
									"Getter not found: wanted "
											+ kind.toString ()
											+ " "
											+ getName
											+ " for "
											+ klass.getCanonicalName ()
											+ "::"
											+ m.toGenericString (),
									e);
					continue METHODS;
				}
				if (null == getter) {
					continue METHODS;
				}
				GaiusValeriusCatullus.setAll_setFromGetter (dest,
						source, klass, m, getName,
						parameterTypes, kind, getter);
			}
		}
		if ( !seenOne) {
			throw new DataException (
					"Class "
							+ klass.getCanonicalName ()
							+ " is not Copyable and lacks @Setter annotations: cannot allocate new local peer");
		}
		
	}
	
	/**
	 * figure out what getter goes with a given setter
	 * 
	 * @param <T> WRITEME
	 * @param klass WRITEME
	 * @param m WRITEME
	 * @return WRITEME
	 * @throws DataException WRITEME
	 */
	private static <T> String setAll_getSetter (final Class <T> klass,
			final Method m) throws DataException {
		final Setter setterNote = m.getAnnotation (Setter.class);
		String getName = setterNote.getter ();
		if ( (null == getName) || "".equals (getName)) {
			final String n = m.getName ();
			if (n.startsWith ("set")) {
				getName = "get" + n.substring (3);
			} else {
				throw new DataException (
						"Setter defined in class without obvious getter name? "
								+ klass.getCanonicalName ()
								+ "::" + m.toGenericString ());
			}
		}
		return getName;
	}
	
	/**
	 * set a property from a given getter
	 * 
	 * @param <T> WRITEME
	 * @param dest WRITEME
	 * @param source WRITEME
	 * @param klass WRITEME
	 * @param m WRITEME
	 * @param getName WRITEME
	 * @param parameterTypes WRITEME
	 * @param kind WRITEME
	 * @param getter WRITEME
	 * @throws DataException WRITEME
	 */
	private static <T> void setAll_setFromGetter (final T dest,
			final T source, final Class <T> klass, final Method m,
			final String getName, final Class <?> [] parameterTypes,
			final Class <?> kind, final Method getter)
			throws DataException {
		try {
			// parameterTypes [0].cast
			m.invoke (dest, getter.invoke (source));
		} catch (final ClassCastException e) {
			throw new DataException ("Parameter mismatch, setter "
					+ m.toString () + " requires "
					+ parameterTypes [0].getCanonicalName ()
					+ " but getter returns "
					+ getter.getReturnType ().getCanonicalName (),
					e);
		} catch (final InvocationTargetException e) {
			throw new DataException (
					"Caught a InvocationTargetException in GaiusValeriusCatullus.setAll "
							+ kind.toString () + " " + getName
							+ " for "
							+ klass.getCanonicalName () + "."
							+ m.toGenericString () + " from "
							+ source.toString () + " to "
							+ dest.toString (), e);
		} catch (final Exception e) {
			throw new DataException (
					"Caught an Exception in GaiusValeriusCatullus.setAll "
							+ kind.toString () + " " + getName
							+ " for "
							+ klass.getCanonicalName () + "."
							+ m.toGenericString (), e);
		}
	}
	
	/**
	 * WRITEME: Document this brpocock@star-hope.org
	 */
	private transient final Registry registry;
	
	/**
	 * The name used for RMI binding; defaults to
	 * org.starhope.catullus.serviceName in the configuration, or,
	 * failing that, C.Valerius.Catullus
	 */
	private final String serviceName;
	
	/**
	 * default no-op constructor. Takes service name from the
	 * configuration.
	 * 
	 * @throws RemoteException WRITEME
	 * @throws NotReadyException WRITEME
	 */
	public GaiusValeriusCatullus () throws RemoteException,
			NotReadyException {
		this (AppiusConfig.getConfigOrDefault (
				"org.starhope.catullus.serviceName",
				"//localhost:2774/C.Valerius.Catullus"));
	}
	
	/**
	 * default no-op constructor
	 * 
	 * @param newServiceName WRITEME
	 * @throws NotReadyException WRITEME
	 * @throws RemoteException WRITEME
	 */
	public GaiusValeriusCatullus (final String newServiceName)
			throws NotReadyException, RemoteException {
		super ();
		serviceName = newServiceName;
		
		URI serviceURL;
		try {
			serviceURL = new URI ("appius:" + serviceName);
		} catch (final URISyntaxException e1) {
			BugReporter.getReporter ("srv").reportBug (
					"Caught a URISyntaxException in GaiusValeriusCatullus: appius:"
							+ serviceName, e1);
			throw new NotReadyException (e1);
		}
		final int port = serviceURL.getPort ();
		final String host = serviceURL.getHost ();
		String path = serviceURL.getPath ();
		if (path.charAt (0) == '/') {
			path = path.substring (1);
		}
		
		BugReporter.getReporter ("srv").reportBug (
				"Attaching C. Valerius Catullus server to "
						+ serviceURL.toString ());
		
		final RMIClientSocketFactory clientSocketFactory = new BoringSocketFactory ();
		final RMIServerSocketFactory serverSocketFactory = new LocalServerSocketFactory (
				host);
		registry = LocateRegistry.createRegistry (port,
				clientSocketFactory, serverSocketFactory);
		try {
			try {
				registry.bind (path, this);
			} catch (final AlreadyBoundException e) {
				registry.rebind (path, this);
			}
		} catch (final AccessException e) {
			throw new NotReadyException (e);
		} catch (final RemoteException e) {
			throw e;
		}
	}
	
	/**
	 * get a local peer class
	 * 
	 * @param <T> class to locate
	 * @param <S> the specific class of the peer
	 * @param obj object whose peer to find
	 * @return peer found
	 */
	@SuppressWarnings ("unchecked")
	private <T extends DataRecord, S extends T> T getLocalPeer (
			final S obj) {
		try {
			final String ident = obj.getCacheableIdent ();
			try {
				return Nomenclator.getDataRecord (
						(Class <S>) obj.getClass (), ident);
			} catch (final NotFoundException e1) {
				// no op
			}
		} catch (final NotFoundException e) {
			try {
				return Nomenclator.getDataRecord (
						(Class <S>) obj.getClass (),
						obj.getCacheableID ());
			} catch (final NotFoundException e1) {
				// no op
			}
		}
		try {
			return GaiusValeriusCatullus.setAll (
					((Class <S>) obj.getClass ()).newInstance (),
					obj);
		} catch (final InstantiationException e) {
			throw new RuntimeException (
					"Caught a InstantiationException in "
							+ "GaiusValeriusCatullus.getLocalPeer ",
					e);
		} catch (final IllegalAccessException e) {
			throw new RuntimeException (
					"Caught a IllegalAccessException in "
							+ "GaiusValeriusCatullus.getLocalPeer ",
					e);
		} catch (final DataException e) {
			throw new RuntimeException ("Caught a DataException in "
					+ "GaiusValeriusCatullus.getLocalPeer ", e);
		}
		
	}
	
	/**
	 * @throws NotFoundException if the record isn't found
	 * @see org.starhope.catullus.JavaRMIServer#read(java.lang.Class,
	 *      int)
	 */
	@Override
	public <T extends DataRecord> T read (final Class <T> klass,
			final int id) throws NotFoundException {
		BugReporter.getReporter ("srv").reportBug (
				"read:" + klass.getCanonicalName () + "/#" + id);
		return Nomenclator.getDataRecord (klass, id);
	}
	
	/**
	 * @throws NotFoundException Read a data record locally
	 * @see org.starhope.catullus.JavaRMIServer#read(java.lang.Class,
	 *      java.lang.String)
	 */
	@Override
	public <T extends DataRecord> T read (final Class <T> klass,
			final String ident) throws NotFoundException {
		BugReporter.getReporter ("srv").reportBug (
				"read:" + klass.getCanonicalName () + "/" + ident);
		return Nomenclator.getDataRecord (klass, ident);
	}
	
	/**
	 * @see org.starhope.catullus.JavaRMIServer#remove(org.starhope.appius.util.DataRecord)
	 */
	@SuppressWarnings ("unchecked")
	@Override
	public <T extends DataRecord> void remove (final T obj) {
		final RecordLoader <T> recordLoader = (RecordLoader <T>) getLocalPeer (
				obj).getRecordLoader ();
		BugReporter.getReporter ("srv").reportBug (
				"remove:" + obj.toString ());
		recordLoader.removeRecord (getLocalPeer (obj));
	}
	
	/**
	 * @see org.starhope.catullus.JavaRMIServer#write(DataRecord)
	 */
	@Override
	public <T extends DataRecord> T write (final T obj) {
		BugReporter.getReporter ("srv").reportBug (
				"write:" + obj.toString ());
		final T peer = getLocalPeer (obj);
		try {
			GaiusValeriusCatullus.setAll (peer, obj);
			return obj;
		} catch (final DataException e) {
			throw new RuntimeException (
					"Caught a DataException in GaiusValeriusCatullus.write ",
					e);
		}
	}
	
	/**
	 * @see org.starhope.catullus.JavaRMIServer#writeSync(org.starhope.appius.util.DataRecord)
	 */
	@SuppressWarnings ("unchecked")
	@Override
	public <T extends DataRecord> T writeSync (final T obj)
			throws RemoteException {
		final T peer = getLocalPeer (obj);
		try {
			GaiusValeriusCatullus.setAll (peer, obj);
			// BugReporter.getReporter ("srv").reportBug (
			// "writeSync:" + obj.toString () + " == "
			// + peer.toString ());
			((RecordLoader <T>) peer.getRecordLoader ())
					.saveRecord (peer);
			GaiusValeriusCatullus.setAll (obj, peer);
			return obj;
		} catch (final DataException e) {
			throw new RuntimeException (
					"Caught a DataException in GaiusValeriusCatullus.write ",
					e);
		}
	}
	
}
