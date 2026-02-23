(ql:quickload '(:drakma
                #:com.inuoe.jzon))

(setf drakma:*text-content-types*
      '(("text" . nil)
        ("application" . "json")))

(defun get-current-location ()
  (let* ((_ (drakma:http-request "https://wtfismyip.com/json")))
    _))

(defun init ()
  (make-change
   :model nil
   :command (lambda (dispatch)
              (funcall dispatch
                       (make-current-time-message
                        :value (get-decoded-time)))
              (funcall dispatch
                       (make-current-location-message
                        :value (get-current-location))))))

(defparameter +strings+
  '(:unit-deg-celsius "°C"
    :label-today-title "TODAY'S WEATHER"))

(defstruct view header content)
(defstruct view-header home-button today-button)
(defstruct view-icon-button icon on-click)
(defstruct view-text-button text on-click)
(defstruct view-nav-action destination)
(defstruct view-content today current)

(defun view (model)
  :TBD)

(defstruct change model command)
(defstruct model date location observations-current predictions-today command)
(defstruct command id arguments)
(defstruct location city department)
(defstruct predictions-day low high)
;;; Conditions hold the data for both observations and predictions
(defstruct conditions
  temperature
  cover
  summary
  air-quality
  pressure
  precipitation)
(defstruct current-time-message value)
(defstruct current-location-message value)

(defun copy-struct-with (src-struct &rest slot-value-pairs)
  (let ((dest-struct (copy-structure src-struct)))
    (loop while slot-value-pairs
          do (let ((slot (pop slot-value-pairs))
                   (value (pop slot-value-pairs)))
               (setf (slot-value dest-struct slot) value)))
    dest-struct))

(defun update (model message)
  (cond
    ((current-time-message-p message)
     (update-from-current-time model message))
    (:otherwise (make-change :model model :command nil))))

(defun update-from-current-time (model message)
  (make-change
   :model (copy-struct-with model
                            'date (current-time-message-value message))
   :command nil))

(defun main ()
  (let*
      ((initial-change (init))
       (_ (print (format nil "Initial change: ~S" initial-change)))
       (initial-command (change-command initial-change))
       (_ (print (format nil "Initial command: ~S" initial-command)))
       (initial-model (change-model initial-change))
       (_ (print (format nil "Initial model: ~S" initial-model)))
       (_ (print "Invoking initial command"))
       (_ (funcall initial-command
                   (lambda (&rest args)
                     (print (format
                             nil
                             "Initial command invoked with arguments: ~S"
                             args))))))))


