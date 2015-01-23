(defpackage :frontinus
  (:use :cl :alexandria :romans :local-time :bordeaux-threads :split-sequence)
  (:nicknames :sextus-julius-frontinus)
  (:documentation "Frontinus provides a simulation of weather,
 including general water cycle, winds, and the day/night cycle, sky
 conditions (including sun(s), moon(s), stars, or other celestial
 bodies) and the like.")
  (:export #:start-server))

