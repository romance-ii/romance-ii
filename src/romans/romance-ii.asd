(asdf:defsystem :romance-ii
  :description "Romance II Game Core"
  :author "Bruce-Robert Fenn Pocock"
  :licence "AGPLv3"
  
  :depends-on (

               :alexandria
               :apply-argv
               :bordeaux-threads
               :buildapp
               :cl-unicode
               :cffi
               :langutils
               :langutils 
               :postmodern
               :prepl
               :sqlite
               :usocket
               :wordnet
               
               )
  
  :encoding :utf-8
  
  :components
  ((:file "setup")
   (:file "common" :depends-on ("setup"))
   (:module "Aelius-Galenus"
          :depends-on ("setup" "common")
          :components ((:file "package")
   (:file "Aelius-Galenus"
                              :depends-on ("package"))))
   (:module "Appius-Claudius-Caecus"
          :depends-on ("setup" "common")
          :components ((:file "package")
   (:file "Appius-Claudius-Caecus"
                              :depends-on ("package"))))
   (:module "Clodia-Metelli-Pulcher"
            :depends-on ("setup" "common")
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
            :depends-on ("setup" "common"))
   (:module "Gaius-Asinius-Pollio"
          :depends-on ("setup" "common")
          :components ((:file "package")
   (:file "Gaius-Asinius-Pollio"
                              :depends-on ("package"))))
   (:module "Gaius-Julius-Caesar"
          :depends-on ("setup" "common")
          :components ((:file "package")
   (:file "Gaius-Julius-Caesar"
                              :depends-on ("package"))))
   (:module "Gaius-Lutatius-Catulus"
          :depends-on ("setup" "common")
          :components ((:file "package")
   (:file "Gaius-Lutatius-Catulus"
                              :depends-on ("package"))))
   (:module "Gaius-Valerius-Catullus"
          :depends-on ("setup" "common")
          :components ((:file "package")
                       (:file "conceptnet5")
   (:file "Gaius-Valerius-Catullus"
                              :depends-on ("package" "conceptnet5"))))
   (:module "Lucius-Aemilius-Regillus"
          :depends-on ("setup" "common")
          :components ((:file "package")
   (:file "Lucius-Aemilius-Regillus"
                              :depends-on ("package")))) 
   (:module "Marcus-Vitruvius-Pollio"
          :depends-on ("setup" "common")
          :components ((:file "package")
   (:file "Marcus-Vitruvius-Pollio"
                              :depends-on ("package"))))
   (:module "Narcissus"
            :depends-on ("setup" "common")
          :components ((:file "package")
                       (:file "Narcissus-bullet"
                              :depends-on ("package"))
   (:file "Narcissus"
                              :depends-on ("package" "Narcissus-bullet"))))
   (:module "Rabirius"
          :depends-on ("setup" "common")
          :components ((:file "package")
   (:file "Rabirius"
                              :depends-on ("package"))))
   (:module "Sextus-Julius-Frontinus"
          :depends-on ("setup" "common")
          :components ((:file "package")
   (:file "Sextus-Julius-Frontinus"
                              :depends-on ("package"))))))

