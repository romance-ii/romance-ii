/**
 * Copyright © 2010, Res Interactive, LLC. All Rights Reserved.
 */
package org.starhope.appius.user.events;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.game.AppiusClaudiusCaecus;
import org.starhope.appius.game.inventory.RarityRating;
import org.starhope.appius.mb.Currency;
import org.starhope.appius.user.Nomenclator;
import org.starhope.appius.util.AppiusConfig;
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
 *    rewardItemType ENUM('I','C','G','N') NOT NULL DEFAULT 'N'
 * ) ENGINE=InnoDB;
 * 
 * </pre>
 * 
 * @author brpocock@star-hope.org
 */
public class EventOutcomeRecordSQLLoader implements
EventOutcomeRecordLoader {

	/**
	 * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void changed (final EventOutcomeRecord changedRecord) {
		// no op
	}

	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 1983 $";
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
	public EventOutcomeRecord loadRecord (final int id)
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
			final EventOutcomeRecord rec = new EventOutcomeRecord ();
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
			} else throw AppiusClaudiusCaecus
			.fatalBug ("onDupe invalid as “" + onDupe
					+ "” for event outcome with ID " + id);
			rec.setRewardByPoints ("Y".equals (rs
					.getString ("rewardPoints")));
			rec.setRewardCollectionID (rs.getInt ("rewardCollectionID"));
			rec.setRewardCurrency (Currency.getPeanuts ()); // XXX
			rec.setRewardItemID (rs.getInt ("rewardItemID"));
			rec.setRewardRatio (rs.getBigDecimal ("rewardRatio"));
			rec.setRewardRandom ("Y".equals (rs
					.getString ("rewardRandom")));
			rec.setRewardMin (rs.getBigDecimal ("rewardMin"));
			rec.setRewardMax (rs.getBigDecimal ("rewardMax"));
			final String rewardType = rs.getString ("rewardItemType");
			rec.setRewardItemType ("I".equals (rewardType) ? RewardItemType.ITEM
					: "C".equals (rewardType) ? RewardItemType.COLLECTION
							: "G".equals (rewardType) ? RewardItemType.GLOBAL
									: RewardItemType.NONE);
			rec.setRecordLoader (this);
			rec.markAsLoaded ();
			return rec;
		} catch (final SQLException e) {
			AppiusClaudiusCaecus.reportBug (
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
	public EventOutcomeRecord loadRecord (final String identifier)
	throws NotFoundException {
		throw new NotFoundException ("ident not supported");
	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final EventOutcomeRecord record) {
		// TODO Auto-generated method stub brpocock@star-hope.org
		AppiusClaudiusCaecus
		.reportBug ("unimplemented RecordLoader<EventOutcomeRecord>::removeRecord (brpocock@star-hope.org, Jul 22, 2010)");

	}

	/**
	 * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void saveRecord (final EventOutcomeRecord record) {
		// TODO Auto-generated method stub brpocock@star-hope.org

	}

    @Override
    public void refresh (EventOutcomeRecord record) {
        // TODO Auto-generated method stub
        
    }

}
