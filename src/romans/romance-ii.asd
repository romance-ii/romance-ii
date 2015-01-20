(asdf:defsystem :romance-ii
  :description "Romance Ⅱ Game Core"
  :author "Bruce-Robert Fenn Pocock"
  :licence "AGPLv3"

  :depends-on (

               :alexandria
               :apply-argv
               :bordeaux-threads
               :buildapp
               #+romance-with-physics  :cl-bullet2l
               :cl-fad
               :cl-unicode
               :cffi
               :langutils
               :postmodern
               :prepl
               :split-sequence
               :sqlite
               :trivial-garbage
               :usocket
               :wordnet

               )

  :encoding :utf-8

  :components
  ((:file "common")
   (:module "Aelius-Galenus"
            :depends-on ("common")
            :components ((:file "package")
                         (:file "Aelius-Galenus"
                                :depends-on ("package"))))
   (:module "Appius-Claudius-Caecus"
            :depends-on ("common")
            :components ((:file "package")
                         (:file "socket-structures"
                                :depends-on ("package"))
                         (:file "Appius-Claudius-Caecus"
                                :depends-on ("package" "socket-structures"))))
   (:module "Clodia-Metelli-Pulcher"
            :depends-on ("common")
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
            :depends-on ("common"))
   (:module "Gaius-Asinius-Pollio"
            :depends-on ("common")
            :components ((:file "package")
                         (:file "Gaius-Asinius-Pollio"
                                :depends-on ("package"))))
   (:module "Gaius-Julius-Caesar"
            :depends-on ("common")
            :components ((:file "package")
                         (:file "Gaius-Julius-Caesar"
                                :depends-on ("package"))))
   (:module "Gaius-Lutatius-Catulus"
            :depends-on ("common")
            :components ((:file "package")
                         (:file "Gaius-Lutatius-Catulus"
                                :depends-on ("package"))))
   (:module "Gaius-Valerius-Catullus"
            :depends-on ("common")
            :components ((:file "package")
                         (:file "conceptnet5"
                                :depends-on ("package"))
                         (:file "Gaius-Valerius-Catullus"
                                :depends-on ("package" "conceptnet5"))))
   (:module "Lucius-Aemilius-Regillus"
            :depends-on ("common")
            :components ((:file "package")
                         (:file "Lucius-Aemilius-Regillus"
                                :depends-on ("package"))))
   (:module "Marcus-Vitruvius-Pollio"
            :depends-on ("common")
            :components ((:file "package")
                         (:file "Marcus-Vitruvius-Pollio"
                                :depends-on ("package"))))
   (:module "Narcissus"
            :depends-on ("common" "Gaius-Julius-Caesar")
            :components ((:file "package")
                         (:file "Narcissus"
                                :depends-on ("package"))))
   (:module "Rabirius"
            :depends-on ("common")
            :components ((:file "package")
                         (:file "Rabirius"
                                :depends-on ("package"))))
   (:module "Sextus-Julius-Frontinus"
            :depends-on ("common")
            :components ((:file "package")
                         (:file "Sextus-Julius-Frontinus"
                                :depends-on ("package"))))))

