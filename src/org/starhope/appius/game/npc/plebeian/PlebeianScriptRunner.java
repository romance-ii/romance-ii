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
package org.starhope.appius.game.npc.plebeian;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Deque;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Queue;
import java.util.StringTokenizer;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.LinkedBlockingDeque;

import org.json.JSONException;
import org.json.JSONObject;
import org.starhope.appius.except.GameLogicException;
import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.BugReporter;
import org.starhope.appius.game.Room;
import org.starhope.appius.game.inventory.GenericItemReference;
import org.starhope.appius.game.inventory.InventoryItem;
import org.starhope.appius.game.inventory.InventoryItemType;
import org.starhope.appius.game.inventory.ItemManager;
import org.starhope.appius.geometry.Coord3D;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.user.AbstractUser;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.user.events.Action;
import org.starhope.appius.user.events.Quaestor;
import org.starhope.appius.util.AppiusConfig;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public final class PlebeianScriptRunner implements ScriptRunner,
		Serializable {
	
	/**
	 * Go to a position script event
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class GoToCoordRunner implements Runnable {
		/**
		 * destination coördinates
		 */
		private final Coord3D destCoord;
		
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final String via;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param target the target coördinates
		 * @param method the method of travel, usually “Walk”
		 */
		public GoToCoordRunner (final Coord3D target,
				final String method) {
			destCoord = target;
			via = method;
		}
		
		/**
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run () {
			final ScriptPuppet poppet = getPuppet ();
			poppet.getRoom ().goTo (poppet, destCoord, null, via);
			setLastScriptTime (poppet.whenAtTarget (new RunNextStep (
					PlebeianScriptRunner.this)));
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return "Move " + getPuppet ().getDebugName () + " to "
					+ destCoord.toString () + " via " + via;
		}
		
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class GoToNamedTargetRunner implements Runnable {
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final String destination;
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final String moveVerb;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param dest the named destination
		 * @param via the method of travel, usually “Walk”
		 */
		GoToNamedTargetRunner (final String dest, final String via) {
			destination = dest;
			moveVerb = via;
		}
		
		/**
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run () {
			final ScriptPuppet puppet = getPuppet ();
			puppet.getRoom ().goTo (puppet, destination, moveVerb);
			setLastScriptTime (puppet.whenAtTarget (new RunNextStep (
					PlebeianScriptRunner.this)));
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " Move " + getPuppet ().getDebugName ()
					+ " to region " + destination + " via "
					+ moveVerb;
		}
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class GoToRoomRunner implements Runnable {
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final String toRoom;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param goalRoomMoniker the moniker of the room to which to
		 *             go
		 */
		GoToRoomRunner (final String goalRoomMoniker) {
			toRoom = goalRoomMoniker;
		}
		
		@Override
		public void run () {
			final ScriptPuppet traveler = getPuppet ();
			Room goalRoom;
			try {
				goalRoom = traveler.getZone ().getRoom (toRoom);
			} catch (final NotFoundException e) {
				setLogicalState ("Lost!");
				return;
			}
			final Room roomIn = traveler.getRoom ();
			if (roomIn == goalRoom) {
				return;
			}
			if (goalRoom.isLimbo () || roomIn.isLimbo ()) {
				goalRoom.join (traveler);
				traveler.setRoom (goalRoom);
				return;
			}
			traveler.seekRoom (goalRoom);
			setLastScriptTime (traveler.whenAtTarget (this));
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " Move " + getPuppet ().getDebugName ()
					+ " to room " + toRoom;
		}
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class GrantToActorRunner implements Runnable {
		
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final int item;
		
		/**
		 * rôle
		 */
		private final PlebeianActor rôle;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param itemID the item to be granted
		 * @param actor the rôle to whom to grant the item
		 */
		GrantToActorRunner (final int itemID,
				final PlebeianActor actor) {
			item = itemID;
			rôle = actor;
		}
		
		/**
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run () {
			getActorByRole (rôle).getInventory ().add (item);
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " Give item #" + item + " to " + rôle.toString ();
		}
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	final class HackPropsPrompt implements Runnable {
		@Override
		public void run () {
			final AbstractUser shopper = getActorByRole (PlebeianActor.Subject);
			// JSONObject prompt = new JSONObject ();
			// try {
			// prompt.put ("title", "Buy Air Blaster");
			// prompt.put ("id", "buyAirBlaster/"
			// + shopper.getUserID ());
			// prompt
			// .put ("msg",
			// "Do you want to buy the Air Blaster for 5000 peanuts?");
			// prompt.put ("attachUser", getPuppet ()
			// .getAvatarLabel ());
			// JSONObject replySet = new JSONObject ();
			// JSONObject replyBuy = new JSONObject ();
			// replyBuy.put ("label", "Buy it");
			// replyBuy.put ("type", "aff");
			// replySet.put ("buy", replyBuy);
			// JSONObject replyNo = new JSONObject ();
			// replyNo.put ("label", "Not now");
			// replyNo.put ("type", "neg");
			// replySet.put ("close", replyNo);
			// prompt.put ("replies", replySet);
			// } catch (JSONException e) {
			// AppiusClaudiusCaecus
			// .reportBug (
			// "Caught a JSONException in HackPropsPrompt ",
			// e);
			// }
			//
			// Quaestor.listen (new ActionHandler (null, null,
			// "promptReply[buyAirBlaster/" + shopper.getUserID ()
			// + "]", null, new ActionMethod () {
			//
			// @Override
			// public boolean acceptAction (final Room where,
			// final AbstractUser subject,
			// final String verba,
			// final AbstractUser object,
			// final String indirectObject,
			// final Object... trailer) {
			// if ("buy".equals (indirectObject)) {
			//
			// try {
			// Commands.purchase (subject,
			// getPuppet ().getRoom (),
			// 2584);
			// } catch (JSONException e) {
			// AppiusClaudiusCaecus
			// .reportBug (
			// "Caught a JSONException in *HackPropsPrompt*handler",
			// e);
			// } catch (NotFoundException e) {
			// AppiusClaudiusCaecus
			// .reportBug (
			// "Caught a NotFoundException in *HackPropsPrompt*handler",
			// e);
			// }
			// }
			// return false;
			// }
			// }));
			//
			// shopper.acceptSuccessReply ("prompt", prompt,
			// getPuppet
			// ()
			// .getRoom ());
			final JSONObject propsOverlay = new JSONObject ();
			try {
				propsOverlay.put ("moniker", "propsAirblaster_PU");
			} catch (final JSONException e) {
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Caught a JSONException in HackPropsPrompt.run ",
								e);
			}
			shopper.acceptSuccessReply ("overlayWindow",
					propsOverlay, getPuppet ().getRoom ());
		}
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	final class HackPropsShootThem implements Runnable {
		@Override
		public void run () {
			final AbstractUser shopper = getActorByRole (PlebeianActor.Subject);
			if (getPuppet ().equals (shopper)) {
				return;
			}
			try {
				for (final InventoryItem i : getPuppet ()
						.getInventory ()
						.getItemsByType (
								Nomenclator
										.getDataRecord (
												InventoryItemType.class,
												"Right_Hand"))) {
					if (i.getGenericItem ().getItemID () == 2584) {
						i.setHealth (BigDecimal.valueOf (999));
					}
				}
			} catch (final NotFoundException e) {
				AppiusClaudiusCaecus
						.reportBug (
								"Caught a NotFoundException in HackPropsShootThem.run ",
								e);
			}
			try {
				ItemManager.get (getPuppet ()).useEquipment ('1',
						"", shopper.getLocation ());
			} catch (final NotFoundException e) {
				// No effects if no ItemManager
			}
		}
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class If_Runner implements Runnable {
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final PlebeianScript ifFalseRun;
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final PlebeianScript ifTrueRun;
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final PlebeianScriptConditional test;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param ifFalse condition to run if the test is false
		 * @param conditional the test
		 * @param ifTrue condition to run if the test is true
		 */
		If_Runner (final PlebeianScriptConditional conditional,
				final PlebeianScript ifTrue,
				final PlebeianScript ifFalse) {
			ifFalseRun = ifFalse;
			test = conditional;
			ifTrueRun = ifTrue;
		}
		
		@Override
		public void run () {
			if (test.evaluate ()) {
				if (null != ifTrueRun) {
					ifTrueRun.nowRun (getPuppet ());
				}
			} else {
				if (null != ifFalseRun) {
					ifFalseRun.nowRun (getPuppet ());
				}
			}
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " If [ "
					+ test.toString ()
					+ " ] then { "
					+ (null == ifTrueRun ? "nothing" : ifTrueRun
							.toString ())
					+ " } else { "
					+ (null == ifFalseRun ? "nothing" : ifFalseRun
							.toString ()) + " } ";
		}
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class PaySomeoneRunner implements Runnable {
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final BigDecimal amount;
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final String currency;
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final PlebeianActor rôle;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param actor WRITEME
		 * @param cu WRITEME
		 * @param qty WRITEME
		 */
		public PaySomeoneRunner (final PlebeianActor actor,
				final String cu, final BigDecimal qty) {
			rôle = actor;
			currency = cu;
			amount = qty;
		}
		
		/**
		 * WRITEME: Document this method brpocock@star-hope.org
		 */
		@Override
		public void run () {
			getActorByRole (rôle).getWallet ()
					.add (currency, amount);
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " Pay " + rôle.toString () + " the amount "
					+ currency + " " + amount.toPlainString ();
		}
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	final class PopAction implements Runnable {
		@Override
		public void run () {
			if (actions.size () > 0) {
				actions.pop ();
			}
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " *END* ";
		}
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	final class PushAction implements Runnable {
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final Action a;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param action action
		 */
		protected PushAction (final Action action) {
			a = action;
		}
		
		@Override
		public void run () {
			actions.push (a);
		}
	}
	
	/**
	 * Run something randomly from a set of possible outcomes
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	public final class Random_Runner implements Runnable {
		
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final LinkedList <PlebeianScript> choices;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param options a set of scripts, from which one outcome
		 *             will be chosen randomly at runtime
		 */
		public Random_Runner (final List <PlebeianScript> options) {
			choices = new LinkedList <PlebeianScript> (options);
		}
		
		/**
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run () {
			choices.get (
					AppiusConfig.getRandomInt (0,
							choices.size () - 1)).nowRun (
					getPuppet ());
		}
		
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class SayCasuallyRunner implements Runnable {
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final String key;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param theKey what is to be said (casually)
		 */
		SayCasuallyRunner (final String theKey) {
			key = theKey;
		}
		
		/**
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run () {
			getPuppet ().speakCasually (key);
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " Say casually " + key;
		}
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class SimultaneousExecutionRunner implements
			Runnable {
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final List <Runnable> steps;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param newSteps the steps to be executed simultaneously
		 *             (without a delay between them)
		 */
		SimultaneousExecutionRunner (final List <Runnable> newSteps) {
			steps = new LinkedList <Runnable> ();
			steps.addAll (newSteps);
		}
		
		/**
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run () {
			final Iterator <Runnable> i = steps.iterator ();
			while (i.hasNext ()) {
				final Runnable r = i.next ();
				r.run ();
			}
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			final StringBuilder s = new StringBuilder ();
			s.append (" Simultaneously × " + steps.size () + " { ");
			final Iterator <Runnable> i = steps.iterator ();
			while (i.hasNext ()) {
				s.append (" { ");
				s.append (i.next ().toString ());
				s.append (" } ");
			}
			s.append (" }");
			return s.toString ();
		}
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class StateChangeRunner implements Runnable {
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final String newState;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param nextState the state to which to transition
		 */
		StateChangeRunner (final String nextState) {
			newState = nextState;
		}
		
		/**
		 * @see java.lang.Runnable#run()
		 */
		@Override
		public void run () {
			setLogicalState (newState);
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " Set state to " + newState;
		}
	}
	
	/**
	 * test whether an actor has an item equipped
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class TestActorEquippedItem implements
			PlebeianScriptConditional {
		/**
		 * the item ID, see {@link GenericItemReference}
		 */
		private final int itemID;
		/**
		 * The actor rôle to be tested
		 */
		private final PlebeianActor rôle;
		
		/**
		 * Test whether the given actor has the given item equipped at
		 * the time that this test is run
		 * 
		 * @param actor someone who might have something
		 * @param item the thing that s/he might have
		 */
		TestActorEquippedItem (final PlebeianActor actor,
				final int item) {
			rôle = actor;
			itemID = item;
		}
		
		/**
		 * @see org.starhope.appius.game.npc.plebeian.PlebeianScriptConditional#evaluate()
		 */
		@Override
		public boolean evaluate () {
			return getActorByRole (rôle).getInventory ()
					.hasEquipped (itemID);
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " Test whether " + rôle.toString ()
					+ " has equipped item #" + itemID;
		}
		
	}
	
	/**
	 * Test whether an actor has a certain amount of currency
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class TestActorHasCurrency implements
			PlebeianScriptConditional {
		/**
		 * The units of currency in question
		 */
		private final Currency cu;
		/**
		 * the amount of currency in question
		 */
		private final BigDecimal qty;
		/**
		 * the actor to check for currency
		 */
		private final PlebeianActor rôle;
		
		/**
		 * Test whether an actor has the given amount of a type of
		 * currency
		 * 
		 * @param actor someone who might have money
		 * @param currency what kind of money he might have
		 * @param amount how much money he might have
		 */
		TestActorHasCurrency (final PlebeianActor actor,
				final Currency currency, final BigDecimal amount) {
			rôle = actor;
			cu = currency;
			qty = amount;
		}
		
		/**
		 * @see org.starhope.appius.game.npc.plebeian.PlebeianScriptConditional#evaluate()
		 */
		@Override
		public boolean evaluate () {
			return getActorByRole (rôle).getWallet ().get (cu)
					.compareTo (qty) >= 0;
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return "Test whether " + rôle.toString () + " has " + cu
					+ " " + qty.toPlainString ();
		}
	}
	
	/**
	 * Test whether an actor has a certain type of item in their
	 * inventory
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class TestActorHasItem implements
			PlebeianScriptConditional {
		/**
		 * the item ID, see {@link GenericItemReference}
		 */
		private final int itemID;
		/**
		 * the actor's rôle to be tested
		 */
		private final PlebeianActor rôle;
		
		/**
		 * Test whether the given actor has a certain item in their
		 * inventory
		 * 
		 * @param actor someone who might have something
		 * @param item what they might have
		 */
		TestActorHasItem (final PlebeianActor actor, final int item) {
			rôle = actor;
			itemID = item;
		}
		
		/**
		 * @see org.starhope.appius.game.npc.plebeian.PlebeianScriptConditional#evaluate()
		 */
		@Override
		public boolean evaluate () {
			return getActorByRole (rôle).getInventory ().hasItem (
					itemID);
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " Test whether " + rôle + " has item #" + itemID;
		}
	}
	
	/**
	 * Perform two sub-tests with a Boolean logical AND (using
	 * short-circuiting)
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private static final class TestAND implements
			PlebeianScriptConditional {
		/**
		 * the second test
		 */
		private final PlebeianScriptConditional latter;
		/**
		 * the first test
		 */
		private final PlebeianScriptConditional prior;
		
		/**
		 * Perform two sub-tests ({@link PlebianScriptConditional}
		 * tests) using a short-circuiting Boolean logical AND. Return
		 * true only if both tests return true.
		 * 
		 * @param head a test
		 * @param tail another test
		 */
		TestAND (final PlebeianScriptConditional head,
				final PlebeianScriptConditional tail) {
			prior = head;
			latter = tail;
		}
		
		@Override
		public boolean evaluate () {
			return prior.evaluate () && latter.evaluate ();
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " [ " + prior.toString () + " ] — and — [ "
					+ latter.toString () + " ] ";
		}
	}
	
	/**
	 * Test whether the current Action's indirect object string
	 * contains a certain (case-insensitive) substring.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private final class TestIndirectContains implements
			PlebeianScriptConditional {
		/**
		 * The substring for which to look
		 */
		private final String keyword;
		
		/**
		 * Test whether the indirect object string of the Action
		 * currently on top of the action stack contains the provided
		 * string within in (lower-cased; i.e. case-insensitive)
		 * 
		 * @param string the substring for which to check
		 */
		TestIndirectContains (final String string) {
			keyword = string.toLowerCase (Locale.ENGLISH);
		}
		
		/**
		 * @see org.starhope.appius.game.npc.plebeian.PlebeianScriptConditional#evaluate()
		 */
		@Override
		public boolean evaluate () {
			final Action peekAction = peekAction ();
			if (null == peekAction) {
				toDo.clear ();
				BugReporter
						.getReporter ("srv")
						.reportBug (
								"Got a null action on the stack: clearing script TO-DOs");
				return false;
			}
			final String indirectObject = peekAction
					.getIndirectObject ();
			if (null == indirectObject) {
				return false;
			}
			return indirectObject.toLowerCase (Locale.ENGLISH)
					.contains (keyword);
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " Test whether the indirect object contains “"
					+ keyword + "”";
		}
	}
	
	/**
	 * Perform two sub-tests using a short-circuited Boolean logical OR
	 * operation, returning true if either the first or second return
	 * true (but not evaluating the second if the first succeeds)
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private static final class TestOR implements
			PlebeianScriptConditional {
		/**
		 * The second test to perform
		 */
		private final PlebeianScriptConditional latter;
		/**
		 * The first test to perform
		 */
		private final PlebeianScriptConditional prior;
		
		/**
		 * Perform two sub-tests using a short-circuited Boolean
		 * logical OR operation, returning true if either the first or
		 * second return true (but not evaluating the second if the
		 * first succeeds)
		 * 
		 * @param head a test
		 * @param tail another test
		 */
		TestOR (final PlebeianScriptConditional head,
				final PlebeianScriptConditional tail) {
			prior = head;
			latter = tail;
		}
		
		/**
		 * @see org.starhope.appius.game.npc.plebeian.PlebeianScriptConditional#evaluate()
		 */
		@Override
		public boolean evaluate () {
			return prior.evaluate () || latter.evaluate ();
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " [ " + prior.toString () + " ] — OR — [ "
					+ latter.toString () + " ] ";
		}
	}
	
	/**
	 * WRITEME: Document this type.
	 * 
	 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
	 */
	private static final class TestXOR implements
			PlebeianScriptConditional {
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final PlebeianScriptConditional latter;
		/**
		 * WRITEME: Document this brpocock@star-hope.org
		 */
		private final PlebeianScriptConditional prior;
		
		/**
		 * WRITEME: Document this constructor brpocock@star-hope.org
		 * 
		 * @param head a test
		 * @param tail another test
		 */
		TestXOR (final PlebeianScriptConditional head,
				final PlebeianScriptConditional tail) {
			latter = head;
			prior = tail;
		}
		
		/**
		 * @see org.starhope.appius.game.npc.plebeian.PlebeianScriptConditional#evaluate()
		 */
		@Override
		public boolean evaluate () {
			return prior.evaluate () ^ latter.evaluate ();
		}
		
		/**
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString () {
			return " [ " + prior.toString () + " ] — or — [ "
					+ latter.toString () + " ] — BUT NOT BOTH ";
		}
	}
	
	/**
	 * Java serialisation unique ID
	 */
	private static final long serialVersionUID = -6752348619585966768L;
	
	/**
	 * whitespace and whitespace-equivalent punctuation characters to
	 * be ignored in tokenizing
	 */
	final static String WS_PUNC = " \t\n,:";
	
	/**
	 * currently-being-handled action (potentially recursive; eww.)
	 */
	public Deque <Action> actions;
	/**
	 * state machine stuff
	 */
	public Map <String, Queue <PlebeianExpression>> expressions;
	/**
	 * last time something happened
	 */
	private long lastScriptTime = 0;
	
	/**
	 * logical state of the script
	 */
	public String logicalState;
	
	/**
	 * Steps to be executed
	 */
	public Deque <Runnable> toDo;
	
	/**
	 * the NPC to which this script is running
	 */
	private final ScriptPuppet victim;
	
	/**
	 * start a script runner for a particular puppet
	 * 
	 * @param myNewPuppet The puppet to be controlled by this script
	 *             runner
	 */
	public PlebeianScriptRunner (final ScriptPuppet myNewPuppet) {
		this (
				"Starting!",
				new ConcurrentHashMap <String, Queue <PlebeianExpression>> (),
				new LinkedBlockingDeque <Action> (),
				new LinkedBlockingDeque <Runnable> (), myNewPuppet);
	}
	
	/**
	 * Start a script runner, setting all initial values
	 * 
	 * @param initialState WRITEME
	 * @param initialExpressions WRITEME
	 * @param initialActions WRITEME
	 * @param initialToDoItems WRITEME
	 * @param puppet NPC to be puppetted
	 */
	private PlebeianScriptRunner (
			final String initialState,
			final Map <String, Queue <PlebeianExpression>> initialExpressions,
			final Deque <Action> initialActions,
			final Deque <Runnable> initialToDoItems,
			final ScriptPuppet puppet) {
		logicalState = initialState;
		expressions = initialExpressions;
		actions = initialActions;
		toDo = initialToDoItems;
		victim = puppet;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param prior the prior clause
	 * @param conj the conjunction
	 * @param latter the latter clause
	 * @return a clause applying the conjunction appropriately
	 */
	private PlebeianScriptConditional addCondition (
			final PlebeianScriptConditional prior,
			final PlebeianTestConjunction conj,
			final PlebeianScriptConditional latter) {
		if ( (null == conj) || (null == prior)) {
			return latter;
		}
		if (null == latter) {
			return prior;
		}
		switch (conj) {
		case and:
			return new TestAND (prior, latter);
		case or:
			return new TestOR (prior, latter);
		case xor:
			return new TestXOR (latter, prior);
		}
		return null;
	}
	
	/**
	 * add an expression to a state, handling autovivification if it's
	 * the first expression for that state
	 * 
	 * @param expression the expression to be added
	 */
	private void addExpressionToState (
			final PlebeianExpression expression) {
		if (null == expression) {
			return;
		}
		final String state = expression.getState ();
		final Queue <PlebeianExpression> theSet = expressions
				.get (state);
		if (theSet == null) {
			final Queue <PlebeianExpression> set = new ConcurrentLinkedQueue <PlebeianExpression> ();
			set.add (expression);
			expressions.put (state, set);
		} else {
			theSet.add (expression);
		}
		Quaestor.listen (expression.handler (this));
	}
	
	/**
	 * Add one or more steps to the given queue, running the steps
	 * together if more than one are specified.
	 * 
	 * @param steps the queue to have the steps added to it
	 * @param newSteps the step(s) to be added
	 */
	private void addSteps (final Queue <Runnable> steps,
			final List <Runnable> newSteps) {
		if (newSteps.size () == 0) {
			return;
		}
		if (newSteps.size () == 1) {
			steps.addAll (newSteps);
			newSteps.clear ();
			return;
		}
		steps.add (new SimultaneousExecutionRunner (newSteps));
		newSteps.clear ();
		return;
	}
	
	/**
	 * Clear all scripted content, usually in preparation for a new
	 * script to be loaded
	 */
	public void clearScript () {
		toDo.clear ();
		actions.clear ();
		AppiusClaudiusCaecus.getKalendor ().cancel (lastScriptTime);
		expressions.clear ();
		lastScriptTime = 0;
		logicalState = "Starting!";
	}
	
	/**
	 * Compile a script provided as text in a string.
	 * 
	 * @param scriptTextString the script text
	 */
	public void compileScript (final String scriptTextString) {
		final StringTokenizer tokens = new StringTokenizer (
				scriptTextString, " \t\n", false);
		while (tokens.hasMoreTokens ()) {
			try {
				final String token = tokens.nextToken ();
				parseDeclarationCommand (token, tokens);
			} catch (final GameLogicException e) {
				BugReporter.getReporter ("srv").reportBug (
						"Script error in " + toString (), e);
			}
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param a the action to be dispatched
	 */
	@Override
	synchronized public void dispatch (final Action a) {
		if (getPuppet ().equals (a.getSubject ())) {
			return;
		}
		
		final Queue <PlebeianExpression> theSet = new LinkedList <PlebeianExpression> ();
		
		// get expressions for the current logical state
		final Queue <PlebeianExpression> stateExpressions = expressions
				.get (logicalState);
		if (null != stateExpressions) {
			theSet.addAll (stateExpressions);
		}
		
		// get universal (stateless) expressions
		final Queue <PlebeianExpression> always = expressions
				.get ("");
		if (null != always) {
			theSet.addAll (always);
		}
		
		// build any To-Do actions up.
		toDo.add (new PushAction (a));
		for (final PlebeianExpression expr : theSet) {
			final Queue <Runnable> steps = expr.accept (a);
			if (null != steps) {
				toDo.addAll (steps);
			}
		}
		toDo.add (new PopAction ());
		doNextToDoItem ();
	}
	
	/**
	 * Do the next script step in queue.
	 */
	@Override
	public void doNextToDoItem () {
		if (toDo.size () > 0) {
			// System.err.println (getPuppet ().getDebugName ()
			// + " : doNextToDoItem : remaining " + toDo.size ());
			final Runnable step = toDo.remove ();
			// System.err.println (" >> " + step.toString ());
			step.run ();
			final long now = System.currentTimeMillis ();
			if (lastScriptTime < now) {
				lastScriptTime = now;
			}
			nextToDoItemSoon ();
		}
	}
	
	/**
	 * Get an actor in an active action.
	 * 
	 * @param rôle the actor's rôle
	 * @return the actor
	 */
	protected AbstractUser getActorByRole (final PlebeianActor rôle) {
		final Action peekAction = peekAction ();
		switch (rôle) {
		case Myself:
			return getPuppet ();
		case Object:
			return null == peekAction ? null : peekAction
					.getObject ();
		case Subject:
			return null == peekAction ? null : peekAction
					.getSubject ();
		}
		throw AppiusClaudiusCaecus
				.fatalBug ("Actor type enum failure");
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return time at which the last scripted action should have /
	 *         will complete
	 */
	public long getLastScriptTime () {
		return lastScriptTime;
	}
	
	/**
	 * @return the puppet controlled by this script
	 */
	@Override
	public ScriptPuppet getPuppet () {
		return victim;
	}
	
	/**
	 * @return whitespace and punctuation ignored in script files
	 */
	public String getWsPunc () {
		return PlebeianScriptRunner.WS_PUNC;
	}
	
	/**
	 * load a script from a file named for tthe NPC
	 * 
	 * @param login the NPC's user name (also used to find their
	 *             script)
	 * @throws GameLogicException usually on a syntax error or
	 *              something
	 */
	public void load (final String login) throws GameLogicException {
		final File script = new File ("/etc/appius/npc/"
				+ getPuppet ().getShortLabel ().toLowerCase (
						Locale.ENGLISH) + ".pleb");
		compileScript (readScriptFile (script));
	}
	
	/**
	 * Do another step, soon, where “soon” is currently defined as 60ms
	 * from now
	 */
	protected void nextToDoItemSoon () {
		final long now = System.currentTimeMillis ();
		if (lastScriptTime > now) {
			return;
		}
		lastScriptTime = AppiusClaudiusCaecus.getKalendor ()
				.schedule (now + 60, new RunNextStep (this));
	}
	
	/**
	 * parse the contents of a “Always” clause
	 * 
	 * @param tokens tokenizer
	 * @return the expression parsed
	 * @throws GameLogicException usually a syntax error
	 */
	PlebeianExpression parseAlwaysCommand (final StringTokenizer tokens)
			throws GameLogicException {
		final PlebeianTestClause test = parseTestClause (tokens);
		final PlebeianScript outcome = parseScript (tokens);
		return new PlebeianExpression ("", test, outcome, victim);
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param tokens token stream from script parser
	 * @return a conditional expression evaluator
	 * @throws GameLogicException syntax error
	 */
	private PlebeianScriptConditional parseConditional (
			final StringTokenizer tokens) throws GameLogicException {
		final Queue <String> stack = new LinkedList <String> ();
		PlebeianScriptConditional prior = null;
		PlebeianTestConjunction conj = null;
		while (true) {
			String token = tokens.nextToken ();
			if ("contain".equals (token)
					|| "contains".equals (token)) {
				final String what = stack.remove ();
				if ("text".equals (what)) {
					final String keyword = tokens.nextToken ()
							.toLowerCase (Locale.ENGLISH);
					prior = addCondition (prior, conj,
							new TestIndirectContains (keyword));
					token = tokens.nextToken ();
				}
			}
			if ("has".equals (token)) {
				token = tokens.nextToken ();
				final PlebeianActor rôle = PlebeianActor
						.valueOf (stack.remove ());
				if ("item".equals (token)) {
					final int itemID = Integer.parseInt (tokens
							.nextToken ());
					prior = addCondition (prior, conj,
							new TestActorHasItem (rôle, itemID));
				} else if ("currency".equals (token)) {
					try {
						final Currency cu = Nomenclator
								.getDataRecord (Currency.class,
										tokens.nextToken ());
						final BigDecimal qty = new BigDecimal (
								tokens.nextToken ());
						prior = addCondition (prior, conj,
								new TestActorHasCurrency (rôle,
										cu, qty));
					} catch (final NotFoundException e) {
						throw new GameLogicException (
								"currency not recognized",
								this, e);
					}
					
				} else {
					throw new GameLogicException ("has what?",
							this, token);
				}
				continue;
			} else if ("is".equals (token)) {
				token = tokens.nextToken ();
				final PlebeianActor rôle = PlebeianActor
						.valueOf (stack.remove ());
				if ("wearing".equals (token)
						|| "using".equals (token)) {
					final int itemID = Integer.parseInt (tokens
							.nextToken ());
					prior = addCondition (prior, conj,
							new TestActorEquippedItem (rôle,
									itemID));
				}
				continue;
			}
			if ("then".equals (token)) {
				return prior;
			}
			if ("and".equals (token)) {
				conj = PlebeianTestConjunction.and;
				continue;
			}
			if ("or".equals (token)) {
				conj = PlebeianTestConjunction.or;
				continue;
			}
			if ("xor".equals (token)) {
				conj = PlebeianTestConjunction.xor;
				continue;
			}
			stack.add (token);
		}
	}
	
	/**
	 * Parse a top-level declaration command
	 * 
	 * @param token the command word
	 * @param tokens the tokenizer stream containing the remainder of
	 *             the definition, which will be advanced through ti
	 * @throws GameLogicException on syntax errors
	 */
	private void parseDeclarationCommand (final String token,
			final StringTokenizer tokens) throws GameLogicException {
		try {
			if ("When".equals (token)) {
				addExpressionToState (parseWhenCommand (tokens));
				return;
			}
			if ("Always".equals (token)) {
				addExpressionToState (parseAlwaysCommand (tokens));
				return;
			}
			if ("Note".equals (token) || "Note:".equals (token)) {
				parseNote (tokens);
				return;
			}
			if ("Include".equals (token)) {
				readScriptFile (new File (
						"/etc/appius/npc/include/"
								+ tokens.nextToken ()));
				return;
			}
		} catch (final NoSuchElementException e) {
			return;
		}
		throw new GameLogicException (
				"Syntax error, expected declaration command, got "
						+ token, tokens, this);
	}
	
	/**
	 * Ignore everything up to the next “End.” token
	 * 
	 * @param tokens the tokenizer emitting tokens, which will be
	 *             advanced past “End.”
	 */
	private void parseNote (final StringTokenizer tokens) {
		String token = "";
		while ( ! ("End.".equals (token) || "Done.".equals (token) || "Now:"
				.equals (token))) {
			token = tokens.nextToken ();
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param tokens WRITEME
	 * @return WRITEME
	 * @throws GameLogicException on syntax errors
	 */
	PlebeianScript parseScript (final StringTokenizer tokens)
			throws GameLogicException {
		final Queue <Runnable> steps = new LinkedList <Runnable> ();
		final List <Runnable> prepend = new LinkedList <Runnable> ();
		Runnable step = null;
		
		while (true) {
			step = null;
			final String verb = tokens.nextToken ();
			AppiusClaudiusCaecus.blather ("Parsing script for "
					+ victim.getDebugName () + " verb: " + verb);
			String next = "";
			if ("Go".equals (verb)) {
				final String dest = tokens.nextToken ();
				next = tokens.nextToken ();
				String via_ = "Walk";
				final String via = via_;
				if ( ! ( ( (dest.charAt (0) >= 'a') && (dest
						.charAt (0) <= 'z'))
						|| ( (dest.charAt (0) >= 'A') && (dest
								.charAt (0) <= 'Z')) || (dest
							.charAt (0) == '$'))) {
					final Coord3D destCoord = Coord3D
							.fromString (dest + "," + next + ","
									+ tokens.nextToken ());
					next = tokens.nextToken ();
					if ("via".equals (next)) {
						via_ = tokens.nextToken ();
						next = tokens.nextToken ();
					}
					step = new GoToCoordRunner (destCoord, via);
				} else {
					if ("via".equals (next)) {
						via_ = tokens.nextToken ();
						next = tokens.nextToken ();
					}
					step = new GoToNamedTargetRunner (dest, via);
				}
			} else if ("Say".equals (verb)) {
				final String key = tokens.nextToken ();
				step = new SayCasuallyRunner (key);
				next = tokens.nextToken ();
			} else if ("Grant".equals (verb)) {
				final int itemID = Integer.parseInt (tokens
						.nextToken ());
				if ( !"to".equals (tokens.nextToken ())) {
					throw new GameLogicException (
							"Give item to whom?", this, steps);
				}
				final String target = tokens.nextToken ();
				step = new GrantToActorRunner (itemID,
						PlebeianActor.valueOf (target));
				next = tokens.nextToken ();
			} else if ("Note".equals (verb)) {
				parseNote (tokens);
				next = tokens.nextToken ();
			} else if ("Like".equals (verb)) {
				load (tokens.nextToken ());
				next = tokens.nextToken ();
			} else if ("Be".equals (verb)) {
				final String newState = tokens.nextToken ();
				step = new StateChangeRunner (newState);
				next = tokens.nextToken ();
			} else if ("Pay".equals (verb)) {
				final PlebeianActor rôle = PlebeianActor
						.valueOf (tokens.nextToken ());
				final String currency = tokens.nextToken ();
				final BigDecimal amount = new BigDecimal (
						tokens.nextToken ());
				next = tokens.nextToken ();
				step = new PaySomeoneRunner (rôle, currency, amount);
			} else if ("Either".equals (verb)) {
				final List <PlebeianScript> options = new LinkedList <PlebeianScript> ();
				while (true) {
					options.add (parseScript (tokens));
					next = tokens.nextToken ();
					if ("or".equals (next)) {
						continue;
					}
					if ("then".equals (next)) {
						break;
					}
				}
				step = new Random_Runner (options);
			} else if ("Wait".equals (verb)) {
				final int waitTime = (int) (Double
						.parseDouble (tokens.nextToken ()) * 1000);
				step = new Runnable () {
					
					@Override
					public void run () {
						setLastScriptTime (AppiusClaudiusCaecus
								.getKalendor ()
								.schedule (
										System.currentTimeMillis ()
												+ waitTime,
										new Runnable () {
											
											@Override
											public void run () {
												doNextToDoItem ();
											}
											
										}));
					}
				};
				next = tokens.nextToken ();
			} else if ("If".equals (verb)) {
				final PlebeianScriptConditional test = parseConditional (tokens);
				PlebeianScript ifTrue = null;
				PlebeianScript ifFalse = null;
				next = tokens.nextToken ();
				if ("do".equals (next)) {
					ifTrue = parseScript (tokens);
					next = tokens.nextToken ();
				}
				if ("else".equals (next)
						|| "otherwise".equals (next)) {
					ifFalse = parseScript (tokens);
					next = tokens.nextToken ();
				}
				final PlebeianScript ifTrueRun = ifTrue;
				final PlebeianScript ifFalseRun = ifFalse;
				step = new If_Runner (test, ifTrueRun, ifFalseRun);
			} else if ("HackPropsPrompt".equals (verb)) {
				step = new HackPropsPrompt ();
				next = tokens.nextToken ();
			} else if ("HackPropsShootThem".equals (verb)) {
				step = new HackPropsShootThem ();
				next = tokens.nextToken ();
			} else if ("Join".equals (verb)) {
				final String toRoom = tokens.nextToken ();
				step = new GoToRoomRunner (toRoom);
				next = tokens.nextToken ();
			} else {
				throw new GameLogicException (
						"Unexpected verb in script section: "
								+ verb, this, steps);
			}
			
			// Conjunction.
			
			if ("Done.".equals (next)) {
				prepend.add (step);
				addSteps (steps, prepend);
				return new PlebeianScript (steps);
			}
			if ("while".equals (next) || "and".equals (next)
					|| "meanwhile".equals (next)
					|| "&".equals (next) || ";".equals (next)) {
				prepend.add (step);
				continue;
			}
			if ("then".equals (next) || "next".equals (next)
					|| "afterwards".equals (next)
					|| ".".equals (next) || "…".equals (next)
					|| "...".equals (next) || "--".equals (next)
					|| "---".equals (next) || "—".equals (next)) {
				prepend.add (step);
				addSteps (steps, prepend);
				continue;
			}
			throw new GameLogicException (
					"Unexpected conjunction in script section: "
							+ next, this, steps);
		}
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @param tokens the tokenizer
	 * @return a test clause
	 * @throws GameLogicException if the script can't be parsed
	 */
	PlebeianTestClause parseTestClause (final StringTokenizer tokens)
			throws GameLogicException {
		PlebeianTestClause clause = new PlebeianTestClause ();
		while (true) {
			
			final String preposition = tokens
					.nextToken (getWsPunc ());
			if ("in".equals (preposition)) {
				final String inWhat = tokens.nextToken ();
				if ("room".equals (inWhat)) {
					final String room = tokens.nextToken ();
					clause = clause.addLocativeProposition (room);
					continue;
				}
				throw new GameLogicException (
						"Don't understand in what? " + inWhat,
						tokens, this);
			}
			if ("from".equals (preposition)
					|| "of".equals (preposition)) {
				final String fromWhom = tokens.nextToken ();
				clause = clause.addNominativeProposition (fromWhom);
				continue;
			}
			if ("to".equals (preposition)) {
				String toWhom = tokens.nextToken ();
				if ("Myself".equals (toWhom)) {
					toWhom = getPuppet ().getShortLabel ();
				}
				clause = clause.addAccusativeProposition (toWhom);
				continue;
			}
			if ("for".equals (preposition)
					|| "by".equals (preposition)
					|| "with".equals (preposition)) {
				final String dative = tokens.nextToken ();
				clause = clause.addDativeProposition (dative);
				continue;
			}
			if ("on".equals (preposition)) {
				final String verb = tokens.nextToken ();
				clause = clause.addVerbProposition (verb);
				continue;
			}
			if ("and".equals (preposition)) {
				// nullword
				continue;
			}
			if ("then".equals (preposition)
					|| "do".equals (preposition)) {
				return clause;
			}
			throw new GameLogicException (
					"Don't understand test preposition? "
							+ preposition, tokens, this);
		}
	}
	
	/**
	 * parse the contents of a “When” clause
	 * 
	 * @param tokens tokenizer
	 * @return the expression yielded
	 */
	private PlebeianExpression parseWhenCommand (
			final StringTokenizer tokens) {
		final String testState = tokens.nextToken (" \t,:");
		try {
			final PlebeianTestClause test = parseTestClause (tokens);
			final PlebeianScript outcome = parseScript (tokens);
			return new PlebeianExpression (testState, test, outcome,
					victim);
		} catch (final GameLogicException e) {
			BugReporter.getReporter ("srv").reportBug (
					"In NPC " + getPuppet ().getDebugName ()
							+ " script error", e);
		}
		return null;
	}
	
	/**
	 * WRITEME: Document this method brpocock@star-hope.org
	 * 
	 * @return the action at the top of the stack
	 */
	Action peekAction () {
		return actions.peek ();
	}
	
	/**
	 * @see org.starhope.appius.game.npc.plebeian.ScriptRunner#pushToDo(java.lang.Runnable)
	 */
	@Override
	public void pushToDo (final Runnable runnable) {
		toDo.push (runnable);
	}
	
	/**
	 * Read a script file from the filesystem
	 * 
	 * @param script the script file to be read
	 * @return the contents of the script file
	 * @throws GameLogicException usually syntax error
	 */
	public String readScriptFile (final File script)
			throws GameLogicException {
		final StringBuilder scriptText = new StringBuilder ();
		BufferedReader reader;
		try {
			reader = new BufferedReader (new FileReader (script));
		} catch (final FileNotFoundException e) {
			throw new GameLogicException (
					"problem reading script for NPC", script, e);
		}
		while (true) {
			try {
				final String line = reader.readLine ();
				if (null == line) {
					break;
				}
				scriptText.append (line);
				scriptText.append ('\n');
			} catch (final IOException e) {
				break;
			}
		}
		return scriptText.toString ();
	}
	
	/**
	 * @see org.starhope.appius.game.npc.plebeian.ScriptRunner#setLastScriptTime(long)
	 */
	@Override
	public void setLastScriptTime (final long when) {
		lastScriptTime = when;
		
	}
	
	/**
	 * Set the logical state for scripted events (and fire a “state”
	 * state change event)
	 * 
	 * @param newState the new state to be in
	 */
	public void setLogicalState (final String newState) {
		logicalState = newState;
		dispatch (new Action (victim.getRoom (), null, "state",
				newState));
	}
	
}
