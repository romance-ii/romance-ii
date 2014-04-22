(asdf:defsystem :wordnet
  :description "WordNet interface"
  :components
  ((:file "packages")
   (:file "wordnet-database-files")
   (:file "init-wn")
   ;; (:file "component-find")
   (:file "parse-wordnet-data")
   (:file "parts-of-speech")
   (:file "relationship-algorithms")
   (:file "representation")))

