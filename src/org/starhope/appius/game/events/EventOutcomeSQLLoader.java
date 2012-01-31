/**
 * Copyright © 2012, Bruce-Robert Pocock; Copyright © 2010, Res Interactive, LLC. This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful,    but WITHOUT ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the   GNU Affero General Public License for more details.  You should have received a copy of the GNU Affero General Public License  along with this program.  If not, see <http://www.gnu.org/licenses/>..
 */
package org.starhope.appius.game.events;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.inventory.RarityRating;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.appius.util.RecordLoader;
import org.starhope.util.LibMisc;

/**
 * Load an EventOutcomeRecord from the database. TODO: save them, too.
 *
 * <pre>
 * CREATE TABLE eventOutcomes (
 *    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 *    giveMedal INT NULL,
 *    CONSTRAINT FOREIGN KEY (giveMedal) REFERENCES medalTypes(ID),
 *    maxRarity TINYINT NOT NULL DEFAULT 4,
 *    minRarity TINYINT NOT NULL DEFAULT 1,
 *    CONSTRAINT FOREIGN KEY (maxRarity) REFERENCES itemRarities(ID),
 *    CONSTRAINT FOREIGN KEY (minRarity) REFERENCES itemRarities(ID),
 *    onDupe ENUM ('R','I','N') NOT NULL DEFAULT 'I',
 *    rewardPoints ENUM ('Y','N') NOT NULL DEFAULT 'Y',
 *    rewardCurrency CHAR(3) NOT NULL DEFAULT 'xTP',
 *    rewardCollectionID INT UNSIGNED NULL,
 *    CONSTRAINT FOREIGN KEY (rewardCollectionID) REFERENCES itemCollections(ID),
 *    rewardItemID INT NULL,
 *    CONSTRAINT FOREIGN KEY (rewardItemID) REFERENCES items (ID),
 *    rewardRatio DECIMAL(10,5) NOT NULL DEFAULT 00001.00000,
 * 	  rewardRandom ENUM ('Y','N') NOT NULL DEFAULT 'N',
 * 	  rewardMin DECIMAL(5,0) NOT NULL DEFAULT -99999,
 * 	  rewardMax DECIMAL(5,0) NOT NULL DEFAULT 99999,
 *    rewardInventoryItemType ENUM('I','C','G','N') NOT NULL DEFAULT 'N'
 * ) ENGINE=InnoDB;
 *
 * </pre>
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class EventOutcomeSQLLoader implements
RecordLoader <EventOutcome> {

	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (EventOutcomeSQLLoader.class);

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final EventOutcome changedRecord) {
		// no op
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 4603 $";
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#initializeStorage(java.lang.String)
	 */
	@Override
	public void initializeStorage (final String storageURL)
	throws NotReadyException {
		// no op
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#isRealtime()
	 */
	@Override
	public boolean isRealtime () {
		return false;
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
	 */
	@Override
	public EventOutcome loadRecord (final int id)
	throws NotFoundException {
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			con = AppiusConfig.getDatabaseConnection ();
			st = con.prepareStatement ("SELECT * FROM eventOutcomes WHERE ID=?");
			st.setInt (1, id);
			rs = st.executeQuery ();
			rs.next ();
			final EventOutcome rec = new EventOutcome ();
			rec.markForReload ();
			final int giveMedal = rs.getInt ("giveMedal");
			if (rs.wasNull ()) {
				rec.setGiveMedal (null);
			} else {
				rec.setGiveMedal (new MedalType (giveMedal));
			}
			rec.setID (rs.getInt ("ID"));
			rec.setMinRarity (Nomenclator.getDataRecord (
					RarityRating.class, rs.getInt ("minRarity")));
			rec.setMaxRarity (Nomenclator.getDataRecord (
					RarityRating.class, rs.getInt ("maxRarity")));
			final String onDupe = rs.getString ("onDupe");
			if ("R".equals (onDupe)) {
				rec.setPermitDuplicateReward (false);
				rec.setRetryDuplicateReward (true);
			} else if ("I".equals (onDupe)) {
				rec.setPermitDuplicateReward (true);
				rec.setRetryDuplicateReward (false);
			} else if ("N".equals (onDupe)) {
				rec.setPermitDuplicateReward (false);
				rec.setRetryDuplicateReward (false);
			}
			rec.setRewardByPoints ("Y".equals (rs
					.getString ("rewardPoints")));
			rec.setRewardCollectionID (rs.getInt ("rewardCollectionID"));
			rec.setRewardCurrency (Currency.getPeanuts ()); // XXX
			rec.setRewardItemID (rs.getInt ("rewardItemID"));
			rec.setRewardRatio (rs.getBigDecimal ("rewardRatio"));
			rec.setRewardRandom ("Y".equals (rs
					.getString ("rewardRandom")));
			rec.setRewardMin (rs.getLong ("rewardMin"));
			rec.setRewardMax (rs.getLong ("rewardMax"));
			final String rewardType = rs.getString ("rewardInventoryItemType");
			rec.setRewardInventoryItemType ("I".equals (rewardType) ? RewardInventoryItemType.ITEM
					: "C".equals (rewardType) ? RewardInventoryItemType.COLLECTION
							: "G".equals (rewardType) ? RewardInventoryItemType.GLOBAL
									: RewardInventoryItemType.NONE);
			rec.setRecordLoader (this);
			rec.markAsLoaded ();
			return rec;
		} catch (final SQLException e) {
			EventOutcomeSQLLoader.log.error (
					"SQL exception loading outcomes ID " + id, e);
		} finally {
			LibMisc.closeAll (rs, st, con);
		}
		throw new NotFoundException (
				"Could not load event outcomes ID " + id);
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
	 */
	@Override
	public EventOutcome loadRecord (final String identifier)
	throws NotFoundException {
		throw new NotFoundException ("ident not supported");
	}

	@Override
    public void refresh (final EventOutcome record) {
        // TODO Auto-generated method stub

    }

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final EventOutcome record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
	}

    /**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final EventOutcome record) {
		record.markAsSaved ();

	}

}
