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

import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.Remote;
import java.rmi.RemoteException;

import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.CredentialExpiredException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.except.ParameterException;
import org.starhope.appius.except.SerialDataException;
import org.starhope.appius.util.DataRecord;

/**
 * Vehicle for performing Java RMI RPC
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class JavaRMIVehicle implements Vehicle, Remote {
	
	/**
	 * RMI naming URL
	 */
	private String rmiURL;
	
	/**
	 * RMI server object obtained from the naming service
	 */
	JavaRMIServer server = null;
	
	/**
	 * @see org.starhope.catullus.Vehicle#connect()
	 */
	@Override
	public void connect () throws NotFoundException,
			CredentialExpiredException, ForbiddenUserException,
			NotReadyException, ParameterException,
			SerialDataException {
		// Get a remote reference to the RMI class
		
		try {
			server = (JavaRMIServer) Naming.lookup (getURL ());
		} catch (final MalformedURLException e) {
			throw new ParameterException (e);
		} catch (final RemoteException e) {
			throw new SerialDataException (e);
		} catch (final NotBoundException e) {
			throw new NotFoundException (e);
		}
	}
	
	/**
	 * @see org.starhope.catullus.Vehicle#disconnect()
	 */
	@Override
	public void disconnect () throws SerialDataException,
			AlreadyUsedException, ParameterException {
		// no op
	}
	
	/**
	 * @return the rmiURL
	 */
	@Override
	public String getURL () {
		return rmiURL;
	}
	
	/**
	 * @throws NotReadyException if the server isn't connected
	 * @throws NotFoundException if the object can't be found
	 * @see org.starhope.catullus.Vehicle#read(Via,java.lang.Class,
	 *      int)
	 */
	@Override
	public <T extends DataRecord> T read (final Via <T> via,
			final Class <T> klass, final int id)
			throws NotReadyException, NotFoundException {
		if (null == server) {
			throw new NotReadyException ("not connected");
		}
		T o;
		try {
			o = server.read (klass, id);
		} catch (final RemoteException e) {
			throw new NotReadyException (e);
		}
		o.setRecordLoader (via);
		return o;
	}
	
	/**
	 * @throws NotReadyException if the server isn't connected
	 * @throws NotFoundException if the object can't be found
	 * @see org.starhope.catullus.Vehicle#read(Via,java.lang.Class,
	 *      String)
	 */
	@Override
	public <T extends DataRecord> T read (final Via <T> via,
			final Class <T> klass, final String ident)
			throws NotReadyException, NotFoundException {
		if (null == server) {
			throw new NotReadyException ("not connected");
		}
		T o = null;
		try {
			o = server.read (klass, ident);
		} catch (final RemoteException e) {
			throw new NotReadyException (e);
		}
		o.setRecordLoader (via);
		return o;
	}
	
	/**
	 * @see org.starhope.catullus.Vehicle#remove(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public <T extends DataRecord> void remove (final T obj)
			throws NotReadyException, NotFoundException {
		if (null == server) {
			throw new NotReadyException ("not connected");
		}
		try {
			server.remove (obj);
		} catch (final RemoteException e) {
			throw new NotReadyException (e);
			
		}
	}
	
	/**
	 * @param newRMI_URL the rmiURL to set
	 */
	@Override
	public void setURL (final String newRMI_URL) {
		rmiURL = newRMI_URL;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return "CVC-RMI vehicle JavaRMIVehicle for " + rmiURL;
	}
	
	/**
	 * @throws NotReadyException server not connected or ready
	 * @see org.starhope.catullus.Vehicle#write(DataRecord)
	 */
	@Override
	public <T extends DataRecord> T write (final T obj)
			throws NotReadyException {
		if (null == server) {
			throw new NotReadyException ("not connected");
		}
		try {
			return server.write (obj);
		} catch (final RemoteException e) {
			throw new NotReadyException (e);
			
		}
	}
	
	/**
	 * @see org.starhope.catullus.Vehicle#writeSync(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public <T extends DataRecord> T writeSync (final T obj)
			throws NotReadyException {
		if (null == server) {
			throw new NotReadyException ("not connected");
		}
		try {
			return server.writeSync (obj);
		} catch (final RemoteException e) {
			throw new NotReadyException (e);
			
		}
	}
	
}
