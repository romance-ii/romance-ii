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
package org.starhope.appius.game.actions;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.RunCommands;
import org.starhope.appius.game.Zone;
import org.starhope.appius.geometry.Coord2D;
import org.starhope.appius.sys.admin.Security;
import org.starhope.appius.sys.admin.SecurityCapability;
import org.starhope.appius.sys.op.OpCommands;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.events.ActionHandler;
import org.starhope.appius.user.events.ActionMethod;
import org.starhope.appius.user.events.Quaestor;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class OperatorControlClick implements RunCommands {
	
	/**
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	static final class ClickHandler implements ActionMethod {
		/**
		 * WRITEME brpocock@star-hope.org
		 */
		final private SecurityCapability capSysOp = new SecurityCapability (
				SecurityCapability.CAP_SYSOP_COMMANDS);
		
		/**
		 * @see org.starhope.appius.user.events.ActionMethod#acceptAction(org.starhope.appius.game.Room,
		 *      org.starhope.appius.user.AbstractUser,
		 *      java.lang.String,
		 *      org.starhope.appius.user.AbstractUser,
		 *      java.lang.String, java.lang.Object[])
		 */
		@Override
		public boolean acceptAction (final Room where,
				final AbstractUser subject, final String verb,
				final AbstractUser object,
				final String indirectObject,
				final Object... trailer) {
			if (trailer.length < 2) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								toString ()
										+ " missing trailer record elements");
				return false;
			}
			final String mods = (String) trailer [0];
			if ( (null != indirectObject) && mods.contains ("^")
					&& mods.contains ("1")
					&& Security.hasCapability (subject, capSysOp)) {
				final Coord2D target = (Coord2D) trailer [1];
				OperatorControlClick.opClick (subject, where,
						target, indirectObject);
			}
			return true;
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param operator WRITEME
	 * @param room WRITEME
	 * @param target WRITEME
	 * @param clickedOn WRITEME
	 */
	protected static void opClick (final AbstractUser operator,
			final Room room, final Coord2D target,
			final String clickedOn) {
		
		final AbstractUser userClicked = Nomenclator
				.getUserByLogin (clickedOn);
		if (null != userClicked) {
			operator.acceptMessage (userClicked.getAvatarLabel (),
					"Nomenclator",
					OpCommands.fingerInfo (operator, userClicked));
			operator.acceptPrivateMessage (
					userClicked,
					"$$: My name is “"
							+ userClicked.getAvatarLabel ()
							+ "”");
			try {
				final JSONObject promptData = new JSONObject ();
				promptData.put ("id",
						"^click+" + userClicked.getUserID ());
				promptData.put ("attachUser", clickedOn);
				promptData.put ("label", "Nomenclator");
				promptData.put ("label_en_US", "Nomenclator");
				promptData.put ("title",
						userClicked.getAvatarLabel ());
				promptData.put ("msg",
						"What do you want to do to him?");
				final JSONObject replies = new JSONObject ();
				final JSONObject kickButton = new JSONObject ();
				kickButton.put ("label", "Kick");
				kickButton.put ("label_en_US", "Kick");
				kickButton.put ("type", "neg");
				replies.put ("kick", kickButton);
				final JSONObject pingButton = new JSONObject ();
				replies.put ("ping", pingButton);
				pingButton.put ("label", "Ping");
				pingButton.put ("label_en_US", "Ping");
				pingButton.put ("type", "aff");
				promptData.put ("replies", replies);
				operator.acceptSuccessReply ("prompt", promptData,
						room);
			} catch (final JSONException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a JSONException in OperatorControlClick.opClick ",
								e);
			}
		}
	}
	
	/**
	 * @see org.starhope.appius.game.RunCommands#newZone(org.starhope.appius.game.Zone)
	 */
	@Override
	public void newZone (final Zone z) {
		// no op
	}
	
	/**
	 * @see org.starhope.appius.game.RunCommands#run()
	 */
	@Override
	public void run () {
		
		AppiusClaudiusCaecus
				.blather ("Adding control+click capabilities for operators");
		
		Quaestor.listen (new ActionHandler (null, null, "click",
				null, new ClickHandler ()));
		
	}
	
}
