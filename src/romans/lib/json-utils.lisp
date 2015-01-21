(in-package :romans)

(defun plist-json (plist)
  (labels ((pre-jsonify (plist)
             (loop for (key value) on plist by #'cddr
                appending (list (etypecase key
                                  (symbol (substitute #\_ #\- (string-downcase (symbol-name key))))
                                  (string key)
                                  (number key))
                                (if (consp value)
                                    (pre-jsonify value)
                                    value)))))
    (st-json:write-json-to-string
     (apply #'st-json:jso (pre-jsonify plist)))))


(defun json-plist (string)
  (labels ((post-plist (plist)
             (loop for (key value) on plist by #'cddr
                appending (list (etypecase key
                                  (string (keywordify key))
                                  (number key)
                                  (symbol key))
                                (if (consp value)
                                    (post-plist value)
                                    value)))))
    (post-plist (alist-plist (st-json::jso-alist )))))
