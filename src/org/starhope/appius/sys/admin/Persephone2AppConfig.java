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
package org.starhope.appius.sys.admin;

import java.net.InetAddress;

import org.starhope.appius.except.NotFoundException;
import org.starhope.appius.util.RecordLoader;
import org.starhope.appius.util.SimpleDataRecord;

/**
 * WRITEME: Document this type.
 * 
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author twheys@gmail.com Timothy W. Heys
 * @author ewinkelman@resinteractive.com Ed Winkelman
 * @author brpocock@star-hope.org Bruce-Robert Pocock
 */
public class Persephone2AppConfig extends
		SimpleDataRecord <Persephone2AppConfig> {
	
	/**
	 * Java Serialisation Unique ID
	 */
	final static long serialVersionUID = 5282483341848226472L;
	
	/**
	 * WRITEME
	 */
	private InetAddress appiusAddress;
	
	/**
	 * WRITEME
	 */
	private int appiusPort;
	/**
	 * WRITEME
	 */
	private String assetURI;
	/**
	 * WRITEME
	 */
	private String bugReportURL;
	/**
	 * WRITEME
	 */
	private String cookingURL;
	/**
	 * WRITEME
	 */
	private String coreLibURL;
	/**
	 * WRITEME
	 */
	private String fontLibURL;
	/**
	 * WRITEME
	 */
	private String forgetURL;
	/**
	 * WRITEME
	 */
	private String helpURL;
	/**
	 * WRITEME
	 */
	private int id;
	/**
	 * WRITEME
	 */
	private java.sql.Date launchDate;
	/**
	 * WRITEME
	 */
	private String loginBG;
	/**
	 * WRITEME
	 */
	private String loginZone;
	/**
	 * WRITEME
	 */
	private String mainURL;
	/**
	 * WRITEME
	 */
	private String newAccountURL;
	/**
	 * WRITEME
	 */
	private String peanutCodeURL;
	/**
	 * WRITEME
	 */
	private String shopURL;
	/**
	 * WRITEME
	 */
	private String statusReportURL;
	/**
	 * WRITEME
	 */
	private boolean suppressVITPopUp;
	/**
	 * WRITEME
	 */
	private String tootsBookURL;
	/**
	 * WRITEME
	 */
	private String vitAccountInfoURL;
	/**
	 * WRITEME
	 */
	private String vitAccountURL;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 */
	public Persephone2AppConfig () {
		super (Persephone2AppConfig.class);
		// TODO Auto-generated constructor stub brpocock@star-hope.org
		
	}
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param loader WRITEME
	 */
	public Persephone2AppConfig (
			final RecordLoader <Persephone2AppConfig> loader) {
		super (loader);
		// TODO Auto-generated constructor stub brpocock@star-hope.org
	}
	
	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals (final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if ( ! (obj instanceof Persephone2AppConfig)) {
			return false;
		}
		final Persephone2AppConfig other = (Persephone2AppConfig) obj;
		if (id != other.id) {
			return false;
		}
		return true;
	}
	
	/**
	 * @return the appiusAddress
	 */
	public InetAddress getAppiusAddress () {
		return appiusAddress;
	}
	
	/**
	 * @return the appiusPort
	 */
	public int getAppiusPort () {
		return appiusPort;
	}
	
	/**
	 * @return the assetURI
	 */
	public String getAssetURI () {
		return assetURI;
	}
	
	/**
	 * @return the bugReportURL
	 */
	public String getBugReportURL () {
		return bugReportURL;
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableID()
	 */
	@Override
	public int getCacheableID () throws NotFoundException {
		return getID ();
	}
	
	/**
	 * @see org.starhope.appius.util.DataRecord#getCacheableIdent()
	 */
	@Override
	public String getCacheableIdent () throws NotFoundException {
		return String.valueOf (getID ());
	}
	
	/**
	 * @return the cookingURL
	 */
	public String getCookingURL () {
		return cookingURL;
	}
	
	/**
	 * @return the coreLibURL
	 */
	public String getCoreLibURL () {
		return coreLibURL;
	}
	
	/**
	 * @return the fontLibURL
	 */
	public String getFontLibURL () {
		return fontLibURL;
	}
	
	/**
	 * @return the forgetURL
	 */
	public String getForgetURL () {
		return forgetURL;
	}
	
	/**
	 * @return the helpURL
	 */
	public String getHelpURL () {
		return helpURL;
	}
	
	/**
	 * @return the id
	 */
	public int getID () {
		return id;
	}
	
	/**
	 * @return the launchDate
	 */
	public java.sql.Date getLaunchDate () {
		return launchDate;
	}
	
	/**
	 * @return the loginBG
	 */
	public String getLoginBG () {
		return loginBG;
	}
	
	/**
	 * @return the loginZone
	 */
	public String getLoginZone () {
		return loginZone;
	}
	
	/**
	 * @return the mainURL
	 */
	public String getMainURL () {
		return mainURL;
	}
	
	/**
	 * @return the newAccountURL
	 */
	public String getNewAccountURL () {
		return newAccountURL;
	}
	
	/**
	 * @return the peanutCodeURL
	 */
	public String getPeanutCodeURL () {
		return peanutCodeURL;
	}
	
	/**
	 * @return the shopURL
	 */
	public String getShopURL () {
		return shopURL;
	}
	
	/**
	 * @return the statusReportURL
	 */
	public String getStatusReportURL () {
		return statusReportURL;
	}
	
	/**
	 * @see org.starhope.util.HasSubversionRevision#getSubversionRevision()
	 */
	@Override
	public String getSubversionRevision () {
		return "$Rev: 2262 $";
	}
	
	/**
	 * @return the tootsBookURL
	 */
	public String getTootsBookURL () {
		return tootsBookURL;
	}
	
	/**
	 * @return the vitAccountInfoURL
	 */
	public String getVITAccountInfoURL () {
		return vitAccountInfoURL;
	}
	
	/**
	 * @return the vitAccountURL
	 */
	public String getVITAccountURL () {
		return vitAccountURL;
	}
	
	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode () {
		final int prime = 31;
		int result = 1;
		result = (prime * result) + id;
		return result;
	}
	
	/**
	 * @return the suppressVITPopUp
	 */
	public boolean isSuppressVITPopUp () {
		return suppressVITPopUp;
	}
	
	/**
	 * @param newAddress the appiusAddress to set
	 */
	public void setAppiusAddress (final InetAddress newAddress) {
		appiusAddress = newAddress;
		changed ();
	}
	
	/**
	 * @param newPort the appiusPort to set
	 */
	public void setAppiusPort (final int newPort) {
		appiusPort = newPort;
		changed ();
	}
	
	/**
	 * @param newAssetURI the assetURI to set
	 */
	public void setAssetURI (final String newAssetURI) {
		assetURI = newAssetURI;
		changed ();
	}
	
	/**
	 * @param newBugReportURL the bugReportURL to set
	 */
	public void setBugReportURL (final String newBugReportURL) {
		bugReportURL = newBugReportURL;
		changed ();
	}
	
	/**
	 * @param newCookingURL the cookingURL to set
	 */
	public void setCookingURL (final String newCookingURL) {
		cookingURL = newCookingURL;
		changed ();
	}
	
	/**
	 * @param newCoreLibURL the coreLibURL to set
	 */
	public void setCoreLibURL (final String newCoreLibURL) {
		coreLibURL = newCoreLibURL;
		changed ();
	}
	
	/**
	 * @param newFontLibURL the fontLibURL to set
	 */
	public void setFontLibURL (final String newFontLibURL) {
		fontLibURL = newFontLibURL;
		changed ();
	}
	
	/**
	 * @param newForgetURL the forgetURL to set
	 */
	public void setForgetURL (final String newForgetURL) {
		forgetURL = newForgetURL;
		changed ();
	}
	
	/**
	 * @param newHelpURL the helpURL to set
	 */
	public void setHelpURL (final String newHelpURL) {
		helpURL = newHelpURL;
		changed ();
	}
	
	/**
	 * @param newID the id to set
	 */
	public void setID (final int newID) {
		id = newID;
		changed ();
	}
	
	/**
	 * @param newDate the launchDate to set
	 */
	public void setLaunchDate (final java.sql.Date newDate) {
		launchDate = newDate;
		changed ();
	}
	
	/**
	 * @param newLoginBG the loginBG to set
	 */
	public void setLoginBG (final String newLoginBG) {
		loginBG = newLoginBG;
		changed ();
	}
	
	/**
	 * @param newLoginZone the loginZone to set
	 */
	public void setLoginZone (final String newLoginZone) {
		loginZone = newLoginZone;
		changed ();
	}
	
	/**
	 * @param newMainURL the mainURL to set
	 */
	public void setMainURL (final String newMainURL) {
		mainURL = newMainURL;
		changed ();
	}
	
	/**
	 * @param newRegistrationURL the newAccountURL to set
	 */
	public void setNewAccountURL (final String newRegistrationURL) {
		newAccountURL = newRegistrationURL;
		changed ();
	}
	
	/**
	 * @param newPeanutCodeURL the peanutCodeURL to set
	 */
	public void setPeanutCodeURL (final String newPeanutCodeURL) {
		peanutCodeURL = newPeanutCodeURL;
		changed ();
	}
	
	/**
	 * @param newShopURL the shopURL to set
	 */
	public void setShopURL (final String newShopURL) {
		shopURL = newShopURL;
		changed ();
	}
	
	/**
	 * @param newStatusReportURL the statusReportURL to set
	 */
	public void setStatusReportURL (final String newStatusReportURL) {
		statusReportURL = newStatusReportURL;
		changed ();
	}
	
	/**
	 * @param newSuppressVITPopUp the suppressVITPopUp to set
	 */
	public void setSuppressVITPopUp (final boolean newSuppressVITPopUp) {
		suppressVITPopUp = newSuppressVITPopUp;
		changed ();
	}
	
	/**
	 * @param newTootsBookURL the tootsBookURL to set
	 */
	public void setTootsBookURL (final String newTootsBookURL) {
		tootsBookURL = newTootsBookURL;
		changed ();
	}
	
	/**
	 * @param newVITAccountInfoURL the vitAccountInfoURL to set
	 */
	public void setVITAccountInfoURL (final String newVITAccountInfoURL) {
		vitAccountInfoURL = newVITAccountInfoURL;
		changed ();
	}
	
	/**
	 * @param newVITAccountURL the vitAccountURL to set
	 */
	public void setVITAccountURL (final String newVITAccountURL) {
		vitAccountURL = newVITAccountURL;
		changed ();
	}
	
}
