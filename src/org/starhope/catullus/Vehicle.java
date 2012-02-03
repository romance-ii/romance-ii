/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */
package org.starhope.catullus;

import org.starhope.appius.except.AlreadyUsedException;
import org.starhope.appius.except.CredentialExpiredException;
import org.starhope.appius.except.ForbiddenUserException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.except.ParameterException;
import org.starhope.appius.except.SerialDataException;
import org.starhope.appius.util.DataRecord;

/**
 * A vehicle through which CVC-RMI communications can occur
 * 
 * @author brpocock@star-hope.org
 */
public interface Vehicle {

	/**
	 * Connect to a remote (or, local, but then, why bother?) CVC-RMI
	 * source.
	 * 
	 * @throws NotFoundException perhaps the remote host is unreachable
	 * @throws CredentialExpiredException the credentials may have once
	 *             been valid, but are not any more
	 * @throws ForbiddenUserException the credentials are invalid
	 * @throws NotReadyException the remote host might not be responding
	 * @throws ParameterException general problem caused by the caller
	 * @throws SerialDataException general problem caused in data
	 *             transfer
	 */
	public void connect ()
	throws NotFoundException, CredentialExpiredException,
	ForbiddenUserException, NotReadyException, ParameterException,
	SerialDataException;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @throws SerialDataException general problem caused by data
	 *             transfer
	 * @throws AlreadyUsedException not connected
	 * @throws ParameterException general problem caused by the caller
	 */
	public void disconnect ()
	throws SerialDataException, AlreadyUsedException,
	ParameterException;

	/**
	 * @return the url to which this vehicle is/would connect
	 */
	public String getURL ();

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param <T> WRITEME
	 *
	 * @param via WRITEME
	 * @param klass WRITEME
	 * @param id WRITEME
	 * @return WRITEME
	 * @throws NotReadyException WRITEME
	 * @throws NotFoundException WRITEME
	 */
	public <T extends DataRecord> T read (Via <T> via, Class <T> klass,
			int id)
	throws NotReadyException, NotFoundException;

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 *
	 * @param <T> WRITEME
	 *
	 * @param via WRITEME
	 * @param klass WRITEME
	 * @param ident WRITEME
	 * @return WRITEME
	 * @throws NotReadyException WRITEME
	 * @throws NotFoundException WRITEME
	 */
	public <T extends DataRecord> T read (Via <T> via, Class <T> klass,
			String ident) throws NotReadyException, NotFoundException;
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param <T> WRITEME
	 * @param obj WRITEME
	 * @throws NotReadyException WRITEME
	 * @throws NotFoundException WRITEME
	 */
	public <T extends DataRecord> void remove(T obj)
			throws NotReadyException, NotFoundException;

	/**
	 * @param url the URL to which to connect
	 */
	public void setURL (String url);

	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param <T> WRITEME
	 * @param obj WRITEME
	 * @throws NotReadyException WRITEME
	 */
	public <T extends DataRecord> T write (T obj)
			throws NotReadyException;
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param <T> WRITEME
	 * @param obj WRITEME
	 * @throws NotReadyException WRITEME
	 */
	public <T extends DataRecord> T writeSync (T obj)
			throws NotReadyException;

}
