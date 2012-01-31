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
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 */
package org.starhope.appius.game.events;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.except.NotReadyException;
import org.starhope.appius.util.AppiusConfig;
import org.starhope.util.LibMisc;

/**
 * WRITEME: Document this type.
 *
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 *
 */
public class MedalRecordSQLLoader extends MedalRecordLoader {

	/**
	 * Logging
	 */
	private static final Logger log = LoggerFactory.getLogger (MedalRecordSQLLoader.class);

    /**
     * @see org.starhope.appius.util.RecordLoader#changed(org.starhope.appius.util.DataRecord)
     */
    @Override
    public void changed (final MedalRecord changedRecord) {
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
     * @param rs WRITEME
     * @return WRITEME
     * @throws SQLException WRITEME
     */
    private MedalRecord loadFromResultSet (final ResultSet rs)
    throws SQLException
    {
        rs.next ();
        final MedalRecord rec = new MedalRecord ();
        rec.setRecordLoader (this);
        rec.setID (rs.getInt ("ID"));
        rec.setName (rs.getString ("name"));
        rec.markAsLoaded();
        return rec;
    }

    /**
     * @see org.starhope.appius.util.RecordLoader#loadRecord(int)
     */
    @Override
    public MedalRecord loadRecord (final int id) throws NotFoundException {
        Connection con = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            con = AppiusConfig.getDatabaseConnection ();
            st = con
            .prepareStatement ("SELECT * FROM medalTypes WHERE ID=?");
            st.setInt (1, id
            );
            rs = st.executeQuery ();
            return loadFromResultSet (rs);
        } catch (final SQLException e) {
			MedalRecordSQLLoader.log.error (
                    "Caught a SQLException in MedalRecordSQLLoader.loadRecord ",
                    e);
        } finally {
            LibMisc.closeAll (rs, st, con);
        }
        throw new NotFoundException ("Couldn't load " + id);
    }

    /**
     * @see org.starhope.appius.util.RecordLoader#loadRecord(java.lang.String)
     */
    @Override
    public MedalRecord loadRecord (final String identifier)
    throws NotFoundException {
        Connection con = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            con = AppiusConfig.getDatabaseConnection ();
            st = con
            .prepareStatement ("SELECT * FROM medalTypes WHERE name=?");
            st.setString(1, identifier);
            rs = st.executeQuery ();
            return loadFromResultSet (rs);
        } catch (final SQLException e) {
			MedalRecordSQLLoader.log.error (
                    "Caught a SQLException in MedalRecordSQLLoader.loadRecord ",
                    e);
        } finally {
            LibMisc.closeAll (rs, st, con);
        }
        throw new NotFoundException ("Couldn't load " + identifier);

    }

    @Override
    public void refresh (final MedalRecord record) {
        // TODO Auto-generated method stub

    }

	/**
	 * @see org.starhope.appius.util.RecordLoader#removeRecord(org.starhope.appius.util.DataRecord)
	 */
	@Override
	public void removeRecord (final MedalRecord record) {
		// TODO Auto-generated method stub brpocock@star-hope.org

	}

    /**
     * @see org.starhope.appius.util.RecordLoader#saveRecord(org.starhope.appius.util.DataRecord)
     */
    @Override
    public void saveRecord (final MedalRecord record) {
		// no op
    }

}
