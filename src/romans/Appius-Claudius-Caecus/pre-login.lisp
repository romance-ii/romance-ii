(in-package :appius)

(defgeneric pre-login-command (socket-info verb args)
  (:method ((socket-info t) (verb t) (args t))
    (error 'verb-not-recognized)))

(defmethod pre-login-command (socket-info (verb (eql :hello)) args)
  (send-raw socket-info 
            "Hello, ~a. I am ~a. Infinity mode ready for login. ∞→ℵ₁~%"
            args (machine-instance)))

(defmethod pre-login-command (socket-info (verb (eql :auth)) args)
  (send-raw socket-info 
            "Authentication incomplete~%"
            args (machine-instance)))

(defmethod serve-socket ((stream stream) (encoding t)
                         (state (eql :pre-login))
                         (socket t) (info socket-info))
  (when (peek-char #\Newline stream nil)
    (let ((*read-eval* nil)
          (*read-suppress* t)
          (read-eval* *read-eval*)
          (read-suppress* *read-suppress*))
      (let* ((line (read-line stream))
             (verb (intern 
                    (string-upcase 
                     (subseq line 0 (or (position #\Space line)
                                        (length line))))
                    :keyword))
             (args (when (find #\Space line)
                     (read-from-string (subseq line
                                               (position #\Space
                                                         line))))))
        (let ((*read-eval* read-eval*)
              (*read-suppress* read-suppress*))
          (pre-login-command info verb args))))))
