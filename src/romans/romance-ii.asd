(asdf:defsystem :romance-ii
  :description "Romance Ⅱ is a game server system, mostly oriented toward persistent, MMO-RPG games."
  :author "Bruce-Robert Fenn Pocock"
  :version "2.0.5"
  :maintainer "Bruce-Robert Fenn Pocock"
  :mailto "brpocock+romance2@star-hope.org"
  :licence "AGPLv3"
  :long-name "Romance Ⅱ Game System"

  :depends-on (

               :alexandria
               :apply-argv
               :bordeaux-threads
               :buildapp
               #+romance-with-physics  :cl-bullet2l
               :cl-fad
               :cl-oauth
               :cl-unicode
               :cffi
               :gsll
               :langutils
               :local-time
               :parse-number
               :postmodern
               :prepl
               :split-sequence
               :sqlite
               :st-json
               :swank
               :trivial-garbage
               :usocket
               :wordnet

               )

  :encoding :utf-8

  :components
  ((:file "common")
   (:module "lib"
            :depends-on ("common")
            :components (#+ (and debug bored) (:file "class-graph")
                            (:file "control-utils")
                            (:file "json-utils")
                            (:file "repl-glue")
                            (:file "string-utils")
                            (:file "i18n+l10n"
                                   :depends-on ("string-utils"))
                            (:file "system-utils")))
   (:module "Aelius-Galenus"
            :depends-on ("common" "lib" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Aelius-Galenus"
                                :depends-on ("package"))))
   (:module "Appius-Claudius-Caecus"
            :depends-on ("common" "lib" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "socket-structures"
                                :depends-on ("package"))
                         (:file "Appius-Claudius-Caecus"
                                :depends-on ("package" "socket-structures"))))
   (:module "Clodia-Metelli-Pulcher"
            :depends-on ("common" "lib" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "memory"
                                :depends-on ("package"))
                         (:file "perception"
                                :depends-on ("package"))
                         (:file "qos"
                                :depends-on ("package"))
                         (:file "self"
                                :depends-on ("package"))
                         (:file "server"
                                :depends-on ("package")))
            :depends-on ("common" "lib"))
   (:module "Gaius-Asinius-Pollio"
            :depends-on ("common" "lib" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Gaius-Asinius-Pollio"
                                :depends-on ("package"))))
   (:module "Gaius-Julius-Caesar"
            :depends-on ("common" "lib")
            :components ((:file "package")
                         (:file "journald" :depends-on ("package"))
                         (:file "Gaius-Julius-Caesar"
                                :depends-on ("package" "journald"))
                         (:file "exec-utils"
                                :depends-on ("package"))
                         (:file "ssh-utils"
                                :depends-on ("package"))
                         (:file "running"
                                :depends-on ("package" "exec-utils" "ssh-utils"))
                         (:file "containers" 
                                :depends-on ("package" "running"))))
   (:module "Gaius-Lutatius-Catulus"
            :depends-on ("common" "lib" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Gaius-Lutatius-Catulus"
                                :depends-on ("package"))))
   (:module "Gaius-Valerius-Catullus"
            :depends-on ("common" "lib" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "conceptnet5"
                                :depends-on ("package"))
                         (:file "Gaius-Valerius-Catullus"
                                :depends-on ("package" "conceptnet5"))))
   (:module "Lucius-Aemilius-Regillus"
            :depends-on ("common" "lib" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Lucius-Aemilius-Regillus"
                                :depends-on ("package"))))
   (:module "Marcus-Vitruvius-Pollio"
            :depends-on ("common" "lib" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Marcus-Vitruvius-Pollio"
                                :depends-on ("package"))))
   (:module "Narcissus"
            :depends-on ("common" "lib" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Narcissus"
                                :depends-on ("package"))))
   (:module "Rabirius"
            :depends-on ("common" "lib" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Rabirius"
                                :depends-on ("package"))))
   (:module "Sextus-Julius-Frontinus"
            :depends-on ("common" "lib" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Sextus-Julius-Frontinus"
                                :depends-on ("package"))))))

