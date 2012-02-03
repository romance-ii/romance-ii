/**
 * <p>
 * Copyright © 2010, Bruce-Robert Pocock
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
package org.starhope.appius.physica;

import java.util.HashMap;
import java.util.Map;
import java.util.TimerTask;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;

import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.util.LibMisc;

/**
 * @author brpocock@star-hope.org
 *
 */
public class Kalendor extends TimerTask {
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author brpocock@star-hope.org
	 */
    private static final class KalendorFutureThread extends Thread
    implements Comparable <Thread>
    {
        /**
         * WRITEME: Document this brpocock@star-hope.org
         */
        private final Entry <Long, Runnable> activity;
        /**
         * WRITEME: Document this brpocock@star-hope.org
         */
        private final Long startTime;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param newActivity WRITEME
		 * @param newStartTime WRITEME
		 */
        KalendorFutureThread (
                final Entry <Long, Runnable> newActivity,
                final Long newStartTime) {
            activity = newActivity;
            startTime = newStartTime;
        }

        /**
         * @see java.lang.Comparable#compareTo(java.lang.Object)
         */
        @Override
        public int compareTo (final Thread o) {
            return super.getName ().compareTo (o.getName ());
        }

        /**
         * @see java.lang.Thread#run()
         */
        @Override
        public void run () {
            setName ("Kalendor/Activity@" + startTime);
            activity.getValue ().run ();
        }
    }

    /**
     * scheduled activities
     */
    private final ConcurrentHashMap <Long, Runnable> activities = new ConcurrentHashMap <Long, Runnable> ();

    /**
     * What class scheduled things?
     */
    private final Map <Long, Class <?>> owners = new ConcurrentHashMap <Long, Class <?>> ();

    /**
     *  Cancel a scheduled event
     * @param when the precise moment at which the event is handled
     * @return the canceled event
     */
    public Runnable cancel (final long when) {
        return activities.remove (Long.valueOf (when));
    }

    /**
     * clear all activities for the calling class
     */
    public void clearMySchedule () {
        clearScheduleFor (getCallerClass ());
    }

    /**
     * Clear all activities scheduled for a given class
     * @param klass the class who registered the scheduled activity
     */
    public void clearScheduleFor (final Class<?> klass) {
        for (final Long when : getScheduleFor (klass).keySet ()
        ) {
            cancel (when.longValue ());
        }
    }

    /**
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals (final Object obj) {
        if (!(obj instanceof Kalendor)) {
            return false;
        }
        return activities == ((Kalendor)obj).activities;
    }

    /**
     * figure out the class who called into one of my routines using
     * stack inspection
     *
     * @return the class calling us
     */
    private Class <?> getCallerClass () {
        Class <?> caller = null;
        final StackTraceElement [] trace = Thread.currentThread ().getStackTrace ();
        for (final StackTraceElement el : trace) {
            String classNamePlus = el.getClassName ();
            classNamePlus = classNamePlus.replaceAll ("\\$.*$", ""); // strip
            // after
            // $
            if ( !classNamePlus.equals (
                    this.getClass ().getCanonicalName ())) {
                try {
                    caller = Class.forName (classNamePlus);
                } catch (final ClassNotFoundException e) {
                    AppiusClaudiusCaecus
                    .reportBug (
                            "Caught a ClassNotFoundException in Kalendor.schedule figuring out caller",
                            e);
                }
                break;
            }
        }
        return caller;
    }
	
	/**
     * get all scheduled activities for the calling class
     *
     * @return all scheduled activities for the calling class
     */
    public Map <Long, Runnable> getMySchedule () {
        return getScheduleFor (getCallerClass ());
    }

    /**
     * Get a set of events that are owned by a given class
     *
     * @return a map of event handles (time to fire) and runnables.
     */
    public Map <Long, Runnable> getSchedule () {
        final Map <Long, Runnable> result = new HashMap <Long, Runnable> ();
        for (final Map.Entry <Long, Runnable> activity : activities
                .entrySet ()) {
            final Long when = activity.getKey ();
            result.put (when, activity.getValue ());
        }
        return result;
    }



    /**
     * Get a set of events that are owned by a given class
     *
     * @param klass the class who scheduled the events
     * @return a map of event handles (time to fire) and runnables.
     */
    public Map <Long, Runnable> getScheduleFor (final Class <?> klass) {
        final Map <Long, Runnable> result = new HashMap <Long, Runnable> ();
        for (final Map.Entry <Long, Runnable> activity : activities
                .entrySet ()) {
            final Long when = activity.getKey ();
            final Class <?> owner = owners.get (when);
            if (null != owner && owner.equals (klass)) {
                result.put (when, activity.getValue ());
            }
        }
        return result;
    }
    /**
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode () {
    	return LibMisc.makeHashCode (toString ());
    }

    /**
     * WRITEME: Document this method brpocock@star-hope.org
     */
    @Override
    public void run () {
        final long currentTime = System.currentTimeMillis ();
        final ConcurrentLinkedQueue <Thread> threads = new ConcurrentLinkedQueue <Thread> ();
        for (final Entry <Long, Runnable> activity : activities
                .entrySet ()) {
            final Long startTime = activity.getKey ();
            if (startTime.longValue () <= currentTime) {
                final Thread t = new KalendorFutureThread (activity,
                        startTime);
                activities.remove (startTime);
                owners.remove (startTime);
                t.start ();
                threads.add (t);
            }
        }
        while (threads.size () > 0) {
            for (final Thread t : threads) {
                try {
                    t.join ();
                    threads.remove(t);
                } catch (final InterruptedException e) {
                    // keep trying
                }
            }
        }
    }

    /**
     * @param when when to schedule the activity
     * @param activity what to do
     * @return the time when the activity will actually be performed,
     *         which may differ slightly, and can be used to cancel an
     *         event.
     */
    public long schedule (final long when, final Runnable activity) {
        long then = when;
        for (;activities.putIfAbsent (Long.valueOf (then++), activity) != null;) {
            /**/
        }
        owners.put (Long.valueOf (then), getCallerClass ());
        return then;
    }

    /**
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString () {
        final StringBuilder s = new StringBuilder ("Kalendor\n\n");
        for (final Entry <Long, Runnable> activity : activities
                .entrySet ())
        {
            s.append ("Activity “");
            s.append (activity.getValue ().toString ());
            s.append ("”\t @ ");
            final Long when = activity.getKey ();
            s.append (when.toString ());
            s.append (" for ");
            final Class <?> owner = owners.get (when);
            if (null == owner) {
                s.append("(unknown owner)");
            } else {
                s.append (owner.toString ());
            }
            s.append ('\n');
        }
        return s.toString ();
    }



}
