(in-package :appius)

(defmethod serve-socket ((stream stream) (encoding t) (state (eql :pre-login))
                         (socket t) (info socket-info))
  )
