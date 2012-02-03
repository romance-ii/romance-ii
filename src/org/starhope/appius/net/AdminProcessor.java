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
package org.starhope.appius.net;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Arrays;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.PrivilegeRequiredException;
import org.starhope.appius.except.UserDeadException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.sys.admin.Security;
import org.starhope.appius.sys.admin.SecurityCapability;
import org.starhope.appius.sys.op.OpCommands;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * Processing thread for an administrative connection (normally port
 * 2772)
 *
 * @author brpocock@star-hope.org
 *
 */
public class AdminProcessor extends Thread implements ServerProcessor,
Comparable <Thread> {

	/**
	 * the maximum input line length accepted
	 */
	private static final int maxInputSize = 1024;

    /**
     * the input stream
     */
    private BufferedReader in;
    /**
     * the output stream
     */
    private PrintWriter out;
    /**
     * the socket against which we're acting
     */
    private final Socket socket;
    /**
     * create a new administrative processing thread
     *
     * @param userSocket the socket to which the remote user is
     *            connected
     */
    public AdminProcessor (final Socket userSocket) {
        socket = userSocket;
        setName ("adminprocessor"
                + userSocket.getInetAddress ().toString ());
    }

    /**
     * @see java.lang.Comparable#compareTo(java.lang.Object)
     */
    @Override
    public int compareTo (final Thread o) {
        return getName ().compareTo (o.getName ());
    }

    /**
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals (final Object obj) {
        if ( ! (obj instanceof AdminProcessor)) {
            return false;
        }
        return 0 == compareTo ((Thread) obj);
    }

    /**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2212 $";
	}

    /**
     * @return accept input from the admin
     */
    private String grabInput () {
        final StringBuilder inputBuilder = new StringBuilder ();
        while (true) {
            try {
                int chr = -1;
                if (in.ready ()) {
                    try {
                        chr = in.read ();
                    } catch (final java.net.SocketException e) {
                        chr = -1;
                    }
                    if ('\0' == chr || '\n' == chr || '\r' == chr) {
                        break;
                    }
                    if (chr == -1) {
                        socket.close ();
                        return null;
                    }
                    inputBuilder.append ((char) chr);
                    if (inputBuilder.length () > AdminProcessor.maxInputSize) {
                        break;
                    }
                } else { // no input pending
                    try {
                        Thread.sleep (AppiusConfig.getIntOrDefault (
                                "org.starhope.appius.ioDelay", 100));
                    } catch (final InterruptedException e) {
                        // no problem, keep going
                    }
                }
            } catch (final IOException e) {
                AppiusClaudiusCaecus.reportBug (e);
                return null;
            }
        }

        return inputBuilder.toString ();
    }

    /**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		return LibMisc.makeHashCode (getName ());
	}

    /**
     * @param inputLine the input from the client
     * @return output line to return to the client, or “null” to
     *         disconnect
     * @throws PrivilegeRequiredException if the client doesn't specify
     *         the name of a Developer-level user
     * @throws NotFoundException if the data input is malformed
     */
    private String processInput (final String inputLine)
    throws PrivilegeRequiredException, NotFoundException {
        final String [] words = inputLine.split (" ");
        if (words.length < 2) {
            throw new NotFoundException ("words");
        }
        final AbstractUser who = Nomenclator.getUserByLogin (words [1]);
        if (null == who) {
            throw new NotFoundException (words [1]);
        }
		Security.hasCapability (who,
				SecurityCapability.CAP_SYSADM_COMMANDS);
        if ("dumpthreads".equals (words [0])) {
            OpCommands.op_dumpthreads (words, who, AppiusClaudiusCaecus
					.getZone ("$Eden").getNextLobby ()
					.getRoomChannel ());
            return "OK\n";
        }
        if ("wallzones".equals (words [0])) {
            final String [] wall = Arrays.copyOfRange (words, 2,
                    words.length);
            OpCommands.op_wallzones (wall, who, AppiusClaudiusCaecus
					.getZone ("$Eden").getNextLobby ()
					.getRoomChannel ());
            return "OK\n";
        }
        if ("reloadconfig".equals (words [0])) {
            OpCommands.op_reloadconfig (words, who,
                    AppiusClaudiusCaecus.getZone ("$Eden")
							.getNextLobby ().getRoomChannel ());
            return "OK\n";
        }
        if ("op".equals (words [0])) {
            final StringBuilder command = new StringBuilder ();
            for (int i = 4; i < words.length; ++i) {
                command.append (words [i]);
                command.append (' ');
            }
            OpCommands.exec (AppiusClaudiusCaecus.getZone (words [2])
					.getRoomByName (words [3]).getRoomChannel (),
                    who, command.toString ());
        }
        if ("restart".equals (words [0])) {
            AppiusClaudiusCaecus.restart ();
            return "Ouch\n";
        }
        if ("kick".equals (words [0])) {
            try {
                OpCommands.op_kick (new String [] { words [2],
                        words [3], words [4] }, who,
                        AppiusClaudiusCaecus.getZone ("$Eden")
								.getNextLobby ().getRoomChannel ());
            } catch (final NotFoundException e) {
                return "ERR\t" + e.toString () + "\n\n";
            }
            return "OK\n";
        }
        return "No\n";
    }

    /**
     * This is an overriding method.
     *
     * @see java.lang.Thread#run()
     */
    @Override
    public void run () {
        /*
         * Setup stanza
         */

        try {
            setup ();

            /*
             * Main I/O loop
             */

            while (true) {
                /*
                 * Gather input line
                 */
                final String inputLine = grabInput ();

                String outputLine = null;
                try {
                    outputLine = processInput (inputLine);
                } catch (final Throwable th) {
                    out.print ("ERR\tproc\t"
                            + th.toString () + "\n");
                    AppiusClaudiusCaecus.reportBug (th);
                }

                /*
                 * If the output is null pointer, we're done
                 */
                if (null == outputLine) {
                    out.close ();
                    in.close ();
                    if (null != socket) {
                        socket.close ();
                    }
                    return; // End of thread.
                }
                /*
                 * If the output is empty, don't send anything.
                 */
                if ( ! ("".equals (outputLine) || "\0"
                        .equals (outputLine))) {
                    out.print (outputLine);
                }
            }

        } catch (final IOException e) {
            AppiusClaudiusCaecus.reportBug (e);
        } catch (final Throwable e) {
            AppiusClaudiusCaecus.reportBug (e);
        } finally {
            out.close ();
            if (null != socket) {
                try {
                    socket.close ();
                } catch (final IOException e) {
                    AppiusClaudiusCaecus.reportBug (e);
                }
            }
        }
        // End of thread.
    }

	/**
     * Set up this thread to execute
     *
     * @throws IOException if the I/O streams can't be initialized
     * @throws UserDeadException if the user disconnects before setup is
     *             complete
     */
    private void setup () throws IOException, UserDeadException {
        out = new PrintWriter (socket.getOutputStream (), true);
        in = new BufferedReader (new InputStreamReader (socket
                .getInputStream ()));

    }
}
