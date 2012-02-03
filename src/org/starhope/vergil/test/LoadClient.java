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
 * along with this program. If not, see <a
 * href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.
 * </p>
 * 
 * @author brpocock@star-hope.org
 */

package org.starhope.vergil.test;

import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.TimerTask;

import org.starhope.vergil.net.smartFaux.SmartFauxClient;
import org.starhope.vergil.net.smartFaux.SmartFauxEvent;
import org.starhope.vergil.net.smartFaux.SmartFauxEventListener;

/**
 * Load-testing client
 * 
 * @author brpocock@star-hope.org
 */
public class LoadClient extends TimerTask implements SmartFauxEventListener {
	
	/**
	 * WRITEME: document this method (brpocock@star-hope.org, Oct 13,
	 * 2009)
	 * 
	 * @param args WRITEME
	 */
    public static void main (final String args[]) {

        for (int number = Integer.parseInt (args [0]); number < 128 + Integer
        .parseInt (args [0]); ++number)
        {
            final int x = number;
            final Thread t = new Thread () {
                @Override
                public void run () {
                    System.err.println ("$LoadUser." + x + ": running");
                    try {
                        new LoadClient (x);
                    } catch (final UnknownHostException e) {
                        e.printStackTrace ();
                        System.exit ( -1);
                    }
                }
            };
            System.err.println ("$LoadUser." + number + ": starting");
            t.start ();
            System.err.println ("$LoadUser." + number + ": started");
        }

        System.err
        .println ("There are now approximately 128 simulated users. High water mark success.");

    }

    /**
     * WRITEME
     */
    Random random = new Random ();
    /**
     * WRITEME
     */
    SmartFauxClient sfs;
    /**
     * WRITEME
     */
    boolean talk = false;
    /**
     * WRITEME
     */
    String userName = "LoadClient";
    /**
     * WRITEME
     */
    private final int userNumber;

    /**
     * @param num WRITEME
     * @throws UnknownHostException if we can't reach Whitney-Dev
     */
    public LoadClient (final int num) throws UnknownHostException {
        userNumber = num;
        sfs = new SmartFauxClient (false);
        userName = "$LoadUser." + num;
        sfs.setDebug (false);
        sfs.smartConnect = false; // Don't use BlueBox proxy
        sfs.addEventListener (SmartFauxEvent.onConnection, this);

        System.out
        .println ("$LoadUser."
                + num
                + " Connecting to the Smartfox server (Whitney-dev)...");
        sfs.connect ("whitney-dev.tootsville.com");

    }

    /**
     * @param event WRITEME
     */
    @Override
    public void handleEvent (final SmartFauxEvent event) {
        if (event.getName ().equals (SmartFauxEvent.onConnectionLost)) {
            System.err.println (userName + " Disconnected");
            Runtime.getRuntime ().exit ( -2);
        } else if (event.getName ().equals (SmartFauxEvent.onConnection)) {
            System.out.println (userName + " Connected. Logging in.");
            sfs.addEventListener (SmartFauxEvent.onConnectionLost, this);
            sfs.addEventListener (SmartFauxEvent.onLogin, this);
            sfs.addEventListener (SmartFauxEvent.onRoomListUpdate, this);
            sfs.addEventListener (SmartFauxEvent.onJoinRoom, this);
            sfs.login ("Lightning", userName, "");
        } else if (event.getName ().equals (SmartFauxEvent.onRoomListUpdate))
        {
            System.out.println (userName
                    + " Got room list. Joining Toot Square");
            sfs.joinRoom (userNumber % 35 + 1);
        } else if (event.getName ().equals (SmartFauxEvent.onLogin)) {
            System.out.println (userName
                    + " Logged in. Getting Room List");
            System.err.println (event.toString ());
            sfs.getRoomList ();
        } else if (event.getName ().equals (SmartFauxEvent.onJoinRoom)) {
            /*
             * System.out.println (userName +
             * " Entered room. Beginning main loop."); while (true) {
             * run (); } final Timer hammer = new Timer
             * ("LoadClient/hammer " + userName);
             * hammer.scheduleAtFixedRate (this, 0, 500);
             */
        } else {
            System.out
            .println ("Unhandled event: " + event.toString ());
        }

    }
	
	/**
	 * This is an overriding method.
	 * 
	 * @see java.lang.Runnable#run()
	 */
    @Override
    public void run () {
        if (talk) {
            sfs.sendPublicMessage ("Let's make some noise");
            System.out.println (userName + " talkie");
            talk = false;
        } else {
            final Map <String, SFSVariable> vars =
                new HashMap <String, SFSVariable> ();
            vars.put ("XPos", new SFSVariable ("n", String
                    .valueOf (random.nextDouble ())));
            vars.put ("YPos", new SFSVariable ("n", String
                    .valueOf (random.nextDouble ())));
            vars.put ("XVel", new SFSVariable ("n", String
                    .valueOf (random.nextDouble ())));
            vars.put ("YVel", new SFSVariable ("n", String
                    .valueOf (random.nextDouble ())));
            vars.put ("files_main",
                    new SFSVariable ("s", "zapQuad.swf"));
            vars.put ("TootType", new SFSVariable ("s", "zapQuad.swf"));
            vars.put ("avatar_type", new SFSVariable ("n", "0"));
            vars
            .put (
                    "garbage",
                    new SFSVariable (
                            "s",
                            "I want you to know /"
                            + "That I'm happy for you /"
                            + "I wish nothing but /"
                            + "The best for you both /"
                            + "An older version of me /"
                            + "Is she perverted like me /"
                            + "Would she go down on you in the theater? /"
                            + "Does she speak eloquently /"
                            + "And would she have your baby /"
                            + "I'm sure she'd make a fucking excellent mother."));
            sfs.setUserVariables (vars);
			System.gc (); // load testing, this is actually a good
							// thing.
			// (please ignore Findbugs griping to the contrariwise)
            System.out.println (userName + " walkie");
            talk = true;
        }
    }
}
