(asdf:defsystem :wordnet
  :description "WordNet interface"
  :author "Dan G. Tecuci • University of Texas at Austin • April 2000;
also altered by Sarah Tierney, and Bruce-Robert Pocock"
  :components
  ((:file "packages")
   (:file "wordnet-database-files"
          :depends-on ("packages"
                       "parts-of-speech"))
   (:file "parse-wordnet-data"
          :depends-on ("packages" 
                       "parts-of-speech"         
                       "wordnet-database-files"))
   (:file "parts-of-speech"
          :depends-on ("packages"))
   (:file "relationship-algorithms"
          :depends-on ("packages" 
                       "parts-of-speech"         
                       "wordnet-database-files"
                       "parse-wordnet-data"
                       "representation"))
   (:file "representation"
          :depends-on ("packages" 
                       "parts-of-speech"         
                       "wordnet-database-files"
                       "parse-wordnet-data"))))

