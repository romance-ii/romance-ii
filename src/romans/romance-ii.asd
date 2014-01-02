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
   (:file "Appius-Claudius-Caecus" 
          :depends-on ("setup" "common"))
   (:file "Gaius-Valerius-Catullus"
          :depends-on ("setup" "common"))
   (:file "Aelius-Galenus"
          :depends-on ("setup" "common"))
   (:file "Gaius-Asinius-Pollio"
          :depends-on ("setup" "common"))
   (:file "Gaius-Julius-Caesar"
          :depends-on ("setup" "common"))
   (:file "Narcissus"
          :depends-on ("setup" "common"))
   (:module "Clodia-Metelli-Pulcher"
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
            :depends-on ("setup" "common"))))

