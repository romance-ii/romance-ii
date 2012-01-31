/**
 * <p>
 * Copyright © 2010 Bruce-Robert Pocock
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
package org.starhope.util.types;

/**
 * This is a basic Lisp-type pair
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @param <A> the type of the head of the pair
 * @param <B> the type of the tail of the pair
 */
public class Pair <A, B> {
	
	/**
	 * the head of the pair
	 */
	final A head;
	
	/**
	 * the tail of the pair
	 */
	final B tail;
	
	/**
	 * create a pair with the given head and tail
	 * 
	 * @param first the head
	 * @param after the tail
	 */
	public Pair (final A first, final B after) {
		head = first;
		tail = after;
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return head.hashCode () ^ tail.hashCode ();
	}
	
	/**
	 * @return the head of the pair
	 */
	public A head () {
		return head;
	}
	
	/**
	 * @return the tail of the pair
	 */
	public B tail () {
		return tail;
	}
	
	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return "(" + head.toString () + "," + tail.toString () + ")";
	}
}
