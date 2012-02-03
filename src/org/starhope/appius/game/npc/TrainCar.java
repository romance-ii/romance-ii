/**
 * <p>
 * Copyright © 2009-2010, Bruce-Robert Pocock
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
package org.starhope.appius.game.npc;

import org.starhope.appius.user.AbstractUser;

/**
 *
 * WRITEME: The documentation for this type (TrainCar) is incomplete. (brpocock@star-hope.org, Dec 14, 2009)
 *
 * @author brpocock@star-hope.org
 *
 */
public interface TrainCar extends AbstractUser {

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 14, 2009)
	 * 
	 * @return WRITEME
	 */
	TrainCar getCaboose ();

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 14, 2009)
	 * 
	 * @return WRITEME
	 */
	TrainCar getNextInTrain ();

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 14, 2009)
	 * 
	 * @return WRITEME
	 */
	TrainCar getPriorInTrain ();

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 14, 2009)
	 * 
	 * @return WRITEME
	 */
	TrainCar getTrainLeader ();

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 14, 2009)
	 * 
	 * @return WRITEME
	 */
	boolean isInTrain ();
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 14, 2009)
	 * 
	 * @param trainLeader WRITEME
	 * @return WRITEME
	 */
	boolean isInTrain (TrainCar trainLeader);

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 14, 2009)
	 * 
	 * @param car WRITEME
	 */
	void setNextInTrain (final TrainCar car);

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 14, 2009)
	 * 
	 * @param car WRITEME
	 */
	void setPriorInTrain (final TrainCar car);

	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Dec 14, 2009)
	 * 
	 * @param leader WRITEME
	 */
	void setTrainLeader (TrainCar leader);

}
