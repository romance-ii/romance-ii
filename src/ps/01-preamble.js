/* -*- javascript -*- */

/*
 * This preamble will be inserted into the combined JavaScript source
 * file, which otherwise consists entirely of code produced
 * via Parenscript.
 */


/* The /*! leader lets Closure Compiler know to preserve the notice */
/*!ROMANCE-II/JavaScript client/Free Software/AGPL v3+/See docs accompanying
 * Source code in editable form available */

if (!String.prototype.format) {
  String.prototype.format = function() {
    var args = arguments;
    return this.replace
      (/{[\d+]}/g,
       function(match, number)
       { return (typeof args[number] != 'undefined'
                 ? args[number]
                 : match);});
}}

