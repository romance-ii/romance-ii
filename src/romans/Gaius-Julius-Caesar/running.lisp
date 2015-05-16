(in-package :caesar)


(defun host-is-local-p (host)
  (or (null host)
      (member (string host) '("localhost" "::1" "127.0.0.1")
              :test 'string-equal)
      ;; todo, compare host name and local interface addresses
      nil))

(defmacro run-external ((host name (command args &optional environ)
                              &key (input (gensym "INPUT"))
                              (output (gensym "OUTPUT"))
                              (error-output (gensym "ERROR-OUTPUT")))
                        &body body)
  (check-type host (or null string symbol))
  (check-type name (or null string symbol))
  (check-type command (or string pathname))
  (check-type input symbol)
  (check-type output symbol)
  (check-type error-output symbol)
  (if (and (constantp host)
           (host-is-local-p host))
      `(run-external/local ,(list (string (eval name)) 
                                  command args environ 
                                  input output error-output)
         ,@body)
      `(if (or (null host)
               (equal (string host) "localhost")
               (equal (string host) (machine-instance)))
           `(run-external/local ,(list (string (eval name)) 
                                       command args environ
                                       input output error-output)
              ,@body)
           `(run-external/remote ,(list (string host) (string name) 
                                        command args environ 
                                        input output error-output)
              ,@body))))

(defgeneric launch-program (container program))

(defmethod launch-program (container (program (eql :postgres))) 
  (todo))
(defmethod launch-program (container (program (eql :static-web-server))) 
  (todo))
(defmethod launch-program (container (program t))
  (todo))

(defun stop-program (identifier) (todo))

(defun kill-program (identifier) (todo))

