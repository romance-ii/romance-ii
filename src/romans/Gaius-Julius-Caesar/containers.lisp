(in-package :caesar)


(defgeneric start-program-container (container-model
                                     location program-identifier))

(defmethod start-program-container ((container-model (eql :docker))
                                    host
                                    program-identifier) 
  (todo))

(defun stop-program-container (identifier) (todo))

(defun stonith (identifier) (todo))

