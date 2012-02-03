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
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * </p>
 *
 * @author brpocock@star-hope.org
 */
package org.starhope.appius.things;

import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.things.tween.MotionTween;
import org.starhope.appius.things.tween.MotionTweenFactory;

/**
 * WRITEME: Document this type.
 *
 * @author brpocock@star-hope.org
 *
 */
public class Motion {
    /**
     * WRITEME: Document this brpocock@star-hope.org
     */
    private Coord3D endPosition;
    /**
     * WRITEME: Document this brpocock@star-hope.org
     */
    private Coord3D startPosition;
    /**
     * WRITEME: Document this brpocock@star-hope.org
     */
    private long startTime;

    /**
     * WRITEME
     */
    private MotionTween motionTween =
                                      MotionTweenFactory
                                              .getLinear (this);
    /**
     * WRITEME: Document this brpocock@star-hope.org
     */
    private long endTime;

    /**
     * @return the endPosition
     */
    public Coord3D getEndPosition () {
        return endPosition; /* TODO brpocock@star-hope.org */
    }

    /**
     * WRITEME: Document this method brpocock@star-hope.org
     * @return the time at which the motion reaches its end position
     */
    public long getEndTime () {
        return endTime;
    }

    /**
     * @return the motionTween
     */
    public MotionTween getMotionTween () {
        return motionTween; /* TODO brpocock@star-hope.org */
    }

    /**
     * @return the startPosition
     */
    public Coord3D getStartPosition () {
        return startPosition; /* TODO brpocock@star-hope.org */
    }

    /**
     * @return the startTime
     */
    public long getStartTime () {
        return startTime; /* TODO brpocock@star-hope.org */
    }

    /**
     * @param newEndPosition the endPosition to set
     */
    public void setEndPosition (final Coord3D newEndPosition) {
        endPosition = newEndPosition; /* TODO brpocock@star-hope.org */
    }

    /**
     * @param endTime the endTime to set
     */
    public void setEndTime (final long endTime) {
        this.endTime = endTime; /* TODO brpocock@star-hope.org */
    }

    /**
     * @param motionTween the motionTween to set
     */
    public void setMotionTween (final MotionTween motionTween) {
        this.motionTween = motionTween; /* TODO brpocock@star-hope.org */
    }

    /**
     * @param newStartPosition the startPosition to set
     */
    public void setStartPosition (final Coord3D newStartPosition) {
        startPosition = newStartPosition; /* TODO brpocock@star-hope.org */
    }

    /**
     * @param newStartTime the startTime to set
     */
    public void setStartTime (final long newStartTime) {
        startTime = newStartTime; /* TODO brpocock@star-hope.org */
    }


}
