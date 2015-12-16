(in-package :brfp)

;;; Handle reading Roman numerals (up to 4,999) to complement ~@:r

(defun proper-roman-numeral (char)
  "Given an ASCII character, return the Unicode Roman numeral code-point
that     it     resembles;     eg,      for     #\C     this     returns
#\ROMAN_NUMERAL_ONE_HUNDRED."
  (case (char-downcase char)
    (#\i #\roman_numeral_one)
    (#\v #\roman_numeral_five)
    (#\g #\roman_numeral_six_late_form)
    (#\x #\roman_numeral_ten)
    (#\l #\roman_numeral_fifty)
    (#\c #\roman_numeral_one_hundred)
    (#\d #\roman_numeral_five_hundred)
    (#\m #\roman_numeral_one_thousand)
    (otherwise nil)))

(defun roman-numeral-value (char)
  "Return the numeric value of an Unicode Roman numeral."
  (case char
    (#\roman_numeral_one 1)
    (#\roman_numeral_two 2)
    (#\roman_numeral_three 3)
    (#\roman_numeral_four 4)
    (#\roman_numeral_five 5)
    (#\roman_numeral_six 6)
    (#\roman_numeral_six_late_form 6)
    (#\roman_numeral_seven 7)
    (#\roman_numeral_eight 8)
    (#\roman_numeral_nine 9)
    (#\roman_numeral_ten 10)
    (#\roman_numeral_eleven 11)
    (#\roman_numeral_twelve 12)
    (#\roman_numeral_fifty 50)
    (#\roman_numeral_fifty_early_form 50)
    (#\roman_numeral_one_hundred 100)
    (#\roman_numeral_reversed_one_hundred 100)
    (#\roman_numeral_five_hundred 500)
    (#\roman_numeral_one_thousand 1000)
    (#\roman_numeral_one_thousand_c_d 1000)
    (#\roman_numeral_five_thousand 5000)
    (#\roman_numeral_ten_thousand 10000)
    (#\roman_numeral_fifty_thousand 50000)
    (#\roman_numeral_one_hundred_thousand 100000)
    (nil nil)
    (otherwise (roman-numeral-value (proper-roman-numeral char)))))

(defun roman-number-value (string)
  "Evaluate  a   string,  returning  its   value  as  a   Roman  number.
Assumes that the string follows typical  rules, and may yield results of
questionable value  on malformed  strings. Functions with  Unicode Roman
numeral codepoints  like #\ROMAN_NUMERAL_FIVE  as well as  Latin letters
that approximate them (as may be produced by `FORMAT' ~:@R)."
  (loop for char across string
     for position from 0
     for value = (roman-numeral-value char)
     for preceding = (when (plusp position)
                       (roman-numeral-value (elt string (1- position))))
     unless value do (error 'reader-error)
     summing (+ (if (and preceding (< preceding value))
                    (- (* 2 preceding))
                    0)
                value)))
