/**
 * <p>
 * Copyright © 2010 Res Interactive, LLC
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
package org.starhope.catullus;

import java.rmi.Remote;
import java.rmi.RemoteException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.util.DataRecord;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public interface JavaRMIServer extends Remote {
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param <T> WRITEME
	 * @param klass WRITEME
	 * @param id WRITEME
	 * @return WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws RemoteException WRITEME
	 */
	public <T extends DataRecord> T read (Class <T> klass, int id)
			throws NotFoundException, RemoteException;
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param <T> WRITEME
	 * @param klass WRITEME
	 * @param ident WRITEME
	 * @return WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws RemoteException WRITEME
	 */
	public <T extends DataRecord> T read (Class <T> klass, String ident)
			throws NotFoundException, RemoteException;
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param <T> WRITEME
	 * @param obj WRITEME
	 * @throws NotFoundException WRITEME
	 * @throws RemoteException WRITEME
	 */
	public <T extends DataRecord> void remove (T obj)
			throws NotFoundException, RemoteException;
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param <T> whatever type it might be
	 * @param obj WRITEME
	 * @return the record just written (for chaining purposes)
	 * @throws RemoteException WRITEME
	 */
	public <T extends DataRecord> T write (T obj)
			throws RemoteException;
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param <T> WRITEME
	 * @param obj WRITEME
	 * @return WRITEME
	 * @throws RemoteException WRITEME
	 */
	public <T extends DataRecord> T writeSync (T obj)
			throws RemoteException;
}
