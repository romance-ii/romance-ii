/**
 * <p>
 * Copyright © 2010, Timothy W. Heys
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
 * @author twheys@gmail.com
 */
package org.starhope.rahab.ui;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;
import java.util.logging.Logger;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.ListSelectionModel;
import javax.swing.ScrollPaneConstants;

import org.starhope.rahab.util.Zone;
import org.starhope.rahab.util.ZoneCallBack;

/**
 * WRITEME: Document this type. twheys@gmail.com Dec 30, 2009
 * 
 * @author <a href="mailto:twheys@gmail.com">Tim Heys</a>
 */
public class ZonePromptUI extends JPanel {
    /**
     * WRITEME: Document this field. twheys@gmail.com Dec 30, 2009
     */
    private static final long serialVersionUID = -2175431665170377593L;
	
	/**
	 * WRITEME
	 */
    private final ZoneCallBack callBack;
	
	/**
	 * WRITEME
	 */
    private final Vector <String> listNames;
	
	/**
	 * WRITEME
	 */
    Logger logger = Logger.getLogger (ZonePromptUI.class.getName ());
	
	/**
	 * WRITEME
	 */
    private final JList zoneList;
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * A ZonePromptUI WRITEME...
	 * 
	 * @param zones WRITEME
	 * @param newCallback WRITEME
	 */
    public ZonePromptUI (final Vector <Zone> zones,
            final ZoneCallBack newCallback) {
        callBack = newCallback;
        final JPanel listPane = new JPanel ();
        final JPanel buttonPane = new JPanel ();

        final Vector <String> listItems = new Vector <String> ();
        listNames = new Vector <String> ();
        int index = 0;
        for (final Zone element : zones) {
            listItems.add (index, element.getZoneName () + " ("
                    + element.getZoneHost () + ") Users: "
                    + element.getNumberOfUsers ());
            listNames.add (index, element.getZoneName ());
            index++ ;
        }
        zoneList = new JList (listItems);
        zoneList
        .setSelectionMode (ListSelectionModel.SINGLE_INTERVAL_SELECTION);
        zoneList.setSelectedIndex (0);
        zoneList.setVisibleRowCount (5);
        final JScrollPane zoneListScroll = new JScrollPane (zoneList,
                ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED,
                ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
        zoneListScroll.setPreferredSize (new Dimension (100, 150));

        listPane.setLayout (new BoxLayout (listPane,
                BoxLayout.PAGE_AXIS));
        listPane.add (new JLabel ("Please select a zone to join:"));
        listPane.add (Box.createRigidArea (new Dimension (0, 5)));
        listPane.add (zoneListScroll);
        listPane.setBorder (BorderFactory.createEmptyBorder (10, 10,
                10, 10));

        buttonPane.setLayout (new BoxLayout (buttonPane,
                BoxLayout.LINE_AXIS));
        buttonPane.setBorder (BorderFactory.createEmptyBorder (0, 10,
                10, 10));
        final JButton submit = new JButton ("Connect");
        submit.addActionListener (new ActionListener () {
            @Override
			public void actionPerformed (final ActionEvent e) {
                selectZone ();
            }
        });
        buttonPane.add (Box.createHorizontalGlue ());
        buttonPane.add (Box.createRigidArea (new Dimension (10, 0)));
        buttonPane.add (submit);

        add (listPane, BorderLayout.CENTER);
        add (buttonPane, BorderLayout.PAGE_END);

        setVisible (true);
    }
	
	/**
	 * <pre>
	 * twheys@gmail.com Dec 30, 2009
	 * </pre>
	 * 
	 * TO selectZone WRITEME...
	 */
    protected void selectZone () {
        final int index = zoneList.getSelectedIndex ();
        String zoneToJoin = null;
        try {
            zoneToJoin = listNames.elementAt (index);
        } catch (final Exception e) {
            JOptionPane.showMessageDialog (this,
                    "You must select a zone!", "Error!",
                    JOptionPane.ERROR_MESSAGE);
            return;
        }
        if (null == zoneToJoin) {
            JOptionPane.showMessageDialog (this,
                    "You must select a zone!", "Error!",
                    JOptionPane.ERROR_MESSAGE);
            return;
        }
        callBack.joinZone (zoneToJoin);
    }
}
