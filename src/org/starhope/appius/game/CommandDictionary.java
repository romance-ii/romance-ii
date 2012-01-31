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
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * </p>
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
package org.starhope.appius.game;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

import org.json.JSONObject;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.net.datagram.ADPString;
import org.starhope.appius.net.datagram.AbstractDatagram;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * WRITEME: Document this type. WRITEME ewinkelman@resinteractive.com
 * 
 * @author twheys@gmail.com Timothy W. Heys
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 */
public class CommandDictionary extends
		SimpleDataRecord <CommandDictionary> {
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -3008784606975052916L;
	
	/**
	 * WRITEME: Document this field WRITEME
	 * ewinkelman@resinteractive.com
	 */
	private String command;
	
	/**
	 * WRITEME: Document this field WRITEME
	 * ewinkelman@resinteractive.com
	 */
	private Class <?> klass;
	
	/**
	 * WRITEME: Document this constructor ewinkelman@resinteractive.com
	 * 
	 * @param loader WRITEME ewinkelman@resinteractive.com
	 */
	public CommandDictionary (
			final RecordLoader <? super CommandDictionary> loader) {
		super (loader);
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof CommandDictionary)) {
			return false;
		}
		final CommandDictionary other = (CommandDictionary) obj;
		if (command == null) {
			if (other.command != null) {
				return false;
			}
		} else if ( !command.equals (other.command)) {
			return false;
		}
		return true;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		// TODO Auto-generated method stub
		return 0;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return command;
	}
	
	/**
	 * WRITEME: Document this method WRITEME
	 * ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public String getCommand () {
		return command;
	}
	
	/**
	 * Gets the appropriate datagram type for the JSON packet based on
	 * the command text
	 * 
	 * @param jso WRITEME ewinkelman@resinteractive.com
	 * @param source WRITEME ewinkelman@resinteractive.com
	 * @return WRITEME ewinkelman@resinteractive.com
	 * @throws NotFoundException WRITEME ewinkelman@resinteractive.com
	 */
	public AbstractDatagram getDatagram (final JSONObject jso,
			final ChannelListener source) throws NotFoundException {
		Constructor <?> constructor;
		try {
			constructor = klass.getConstructor (JSONObject.class,
					ChannelListener.class);
			final Object result = constructor.newInstance (jso,
					source);
			if (result instanceof AbstractDatagram) {
				return (AbstractDatagram) result;
			}
			throw new NotFoundException (
					"Constructor failed to return an object that extends the AbstractAppiusDatagram class");
		} catch (final SecurityException e) {
			throw new NotFoundException (e);
		} catch (final NoSuchMethodException e) {
			throw new NotFoundException (e);
		} catch (final IllegalArgumentException e) {
			throw new NotFoundException (e);
		} catch (final InstantiationException e) {
			throw new NotFoundException (e);
		} catch (final IllegalAccessException e) {
			throw new NotFoundException (e);
		} catch (final InvocationTargetException e) {
			throw new NotFoundException (e);
		}
	}
	
	/**
	 * WRITEME: Document this method WRITEME
	 * ewinkelman@resinteractive.com
	 * 
	 * @return WRITEME ewinkelman@resinteractive.com
	 */
	public Class <?> getKlass () {
		return klass;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2262 $";
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result)
				+ (command == null ? 0 : command.hashCode ());
		return result;
	}
	
	/**
	 * WRITEME: Document this method WRITEME
	 * ewinkelman@resinteractive.com
	 * 
	 * @param newCommand WRITEME ewinkelman@resinteractive.com
	 */
	public void setCommand (final String newCommand) {
		command = newCommand;
	}
	
	/**
	 * WRITEME: Document this method WRITEME
	 * ewinkelman@resinteractive.com
	 * 
	 * @param newClassName WRITEME ewinkelman@resinteractive.com
	 */
	public void setKlass (final String newClassName) {
		try {
			klass = Class.forName (newClassName);
		} catch (final ClassNotFoundException e) {
			klass = ADPString.class;
		}
	}
}
