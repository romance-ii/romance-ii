(asdf:defsystem :romance-ii
  :description "Romance Ⅱ is a game server system, mostly oriented toward persistent, MMO-RPG games."
  :author "Bruce-Robert Fenn Pocock"
  :version "2.0.5"
  :maintainer "Bruce-Robert Fenn Pocock"
  ;; CLisp objects to :mailto and :long-name
  #-clisp  :mailto #-clisp "brpocock+romance2@star-hope.org"
  :licence "AGPLv3"
  #-clisp :long-name #-clisp "Romance Ⅱ Game System"

  :depends-on (

               :alexandria
               :apply-argv
               :bordeaux-threads
               :buildapp
               #+romance-with-physics  :cl-bullet2l
               :cl-fad
               :cl-oauth
               :cl-readline
               :cl-unicode
               :cffi
               :dbus
               :langutils
               :local-time
               :parse-number
               :postmodern
               :png-read
               :prepl
               :split-sequence
               :sqlite
               :st-json
               :swank
               :trivial-garbage
               :trivial-gray-streams
               :usocket
               :wordnet

               :oliphaunt
               
               )

  :encoding :utf-8

  :components
  ((:file "common") 
   (:file "lib/start-repl"
          :depends-on ("Gaius-Julius-Caesar"))
   (:module "Aelius-Galenus"
            :depends-on ("common" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Aelius-Galenus"
                                :depends-on ("package"))))
   (:module "Appius-Claudius-Caecus"
            :depends-on ("common" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "socket-structures"
                                :depends-on ("package"))
                         (:file "Appius-Claudius-Caecus"
                                :depends-on ("package" "socket-structures"))
                         (:file "pre-login"
                                :depends-on ("package" "socket-structures"
                                                       "Appius-Claudius-Caecus"))))
   (:module "Clodia-Metelli-Pulcher"
            :depends-on ("common" "Gaius-Julius-Caesar")
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
            :depends-on ("common" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Gaius-Asinius-Pollio"
                                :depends-on ("package"))))
   (:module "Gaius-Julius-Caesar"
            :depends-on ("common")
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
                                :depends-on ("package" "running"))
                         (:file "process-info"
                                :depends-on ("package" "Gaius-Julius-Caesar"))))
   (:module "Gaius-Lutatius-Catulus"
            :depends-on ("common" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Gaius-Lutatius-Catulus"
                                :depends-on ("package"))))
   (:module "Gaius-Valerius-Catullus"
            :depends-on ("common" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "conceptnet5"
                                :depends-on ("package"))
                         (:file "Gaius-Valerius-Catullus"
                                :depends-on ("package" "conceptnet5"))))
   (:module "Lucius-Aemilius-Regillus"
            :depends-on ("common" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Lucius-Aemilius-Regillus"
                                :depends-on ("package"))))
   (:module "Marcus-Vitruvius-Pollio"
            :depends-on ("common" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Marcus-Vitruvius-Pollio"
                                :depends-on ("package"))))
   (:module "Narcissus"
            :depends-on ("common" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Narcissus"
                                :depends-on ("package"))))
   (:module "Rabirius"
            :depends-on ("common" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Rabirius"
                                :depends-on ("package"))))
   (:module "Sextus-Julius-Frontinus"
            :depends-on ("common" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Sextus-Julius-Frontinus"
                                :depends-on ("package"))))
   (:module "Rahab"
            :depends-on ("common" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Rahab"
                                :depends-on ("package"))))))

