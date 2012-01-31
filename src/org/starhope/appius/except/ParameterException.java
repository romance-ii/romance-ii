/**
 * 
 */
package org.starhope.appius.except;

/**
 * @author ewinkelman@resinteractive.com
 */
public class ParameterException extends Exception {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6973758282644073298L;
	
	/**
	 * WRITEME
	 */
	private final String reason;
	
	/**
	 * WRITEME: Document this constructor brpocock@star-hope.org
	 * 
	 * @param e WRITEME
	 */
	public ParameterException (final Exception e) {
		initCause (e);
		reason = e.getMessage ();
	}
	
	/**
	 * @param message WRITEME
	 */
	public ParameterException (final String message) {
		super (message);
		reason = message;
	}
	
	/**
	 * @see java.lang.Throwable#getMessage()
	 */
	@Override
	public String getMessage () {
		final String superMessage = super.getMessage ();
		return null == superMessage ? reason : superMessage + "\t"
				+ reason;
	}
}
