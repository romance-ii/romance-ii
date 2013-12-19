(asdf:defsystem :romance-ii
  :description "Romance II Game Core"
  :author "Bruce-Robert Fenn Pocock"
  :licence "AGPLv3"
  
  :depends-on (:langutils :bordeaux-threads :alexandria
                          :sqlite :langutils :cl-unicode :wordnet)
  
  :components
  ((:file "Appius-Claudius-Caecus")
   (:file "Gaius-Valerius-Catullus")
   (:file "Aelius-Galenus")
   (:file "Gaius-Asinius-Pollio")
   (:file "Gaius-Julius-Caesar")
   (:file "Narcissus")
   (:module "Clodia-Metelli-Pulcher"
            :components ((:file "package")
                         (:file "memory")
                         (:file "perception")
                         (:file "qos")
                         (:file "self")))))

