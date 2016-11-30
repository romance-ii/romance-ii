(in-package :catullus)
;; This work includes data from ConceptNet  5, which was compiled by the
;; Commonsense Computing  Initiative. ConceptNet  5 is  freely available
;; under the  Creative Commons Attribution-ShareAlike license  (CC BY SA
;; 3.0)  from http://conceptnet5.media.mit.edu.  The  included data  was
;; created   by   contributors   to  Commonsense   Computing   projects,
;; contributors to  Wikimedia projects, Games with  a Purpose, Princeton
;; University's WordNet, DBPedia, OpenCyc, and Umbel.

(defvar *datasets* '()
  "Datasets used which should be attributed")

(defun process-conceptnet5-fact (file line-count subj pred obj ctx) 
  (declare (ignore file))
  (with-simple-restart
      (retry-fact "Retry processing fact #~:d: ~a —~a—→ ~a"
                  line-count subj pred obj)
    (cond
      ((equal ctx "/ctx/all")
       (add-concept subj pred obj))
      
      ((char= (char ctx 0) #\{)
       (let* ((ctx.json (st-json:read-json-from-string ctx))
              (license (st-json:getjso "license" ctx.json)))
         (switch (license :test 'equal) 
           ("cc:by-sa/4.0" (pushnew (st-json:getjso "dataset" ctx.json)
                                    *datasets*
                                    :test 'equal))
           ("cc:by/4.0" (pushnew (st-json:getjso "dataset" ctx.json)
                                 *datasets*
                                 :test 'equal))
           (otherwise (error "Unhandled license type: ~a" license)))
         (add-concept subj pred obj)))
      (t (error "Unhandled context type: ~a" ctx)))))

(defun conceptnet5-file->sexp (file)
  (format *trace-output* "~& Loading ConceptNet5 data from ~S~%" file)
  (with-open-file (in file :direction :input :external-format :utf-8)
    (loop
       for line = (read-line in nil :eof)
       until (eql :eof line)
       for line-count from 1
       for parts = (split-sequence #\Tab line :test #'char=)
       for (pred subj obj ctx) = (subseq parts 1 5)
       do (process-conceptnet5-fact file line-count subj pred obj ctx)
         
       do (trace-sample-record file line-count subj pred obj)
       finally (format *trace-output* "~&~|~%Finished with ~:D records" line-count))))

(defun conceptnet5-read-files (wildcard)
  (map nil #'conceptnet5-file->sexp (shuffle (directory wildcard))))

(defun print-fact (s p o)
  (format t "~&~A" (utterance->human (list s p o) :en)))

(defun dump-concepts ()
  (TODO))
