(defparameter +commands+
  `(:fx-get-decoded-time
    ,(lambda (dispatch)
       (funcall dispatch `(:msg-type :msg-got-current-time
                           :msg-value ,(multiple-value-list
                                        (get-decoded-time)))))))

(defun init ()
  '(:model nil
    :command :fx-get-decoded-time))

(defparameter +strings+
  '(:unit-deg-celsius "°C"
    :label-today-title "TODAY'S WEATHER"))

(defun view (model)
  (let* ((model-location (getf model :location))
         (model-conditions-current (getf model :conditions-current))
         (model-conditions-current-temp
           (getf model-conditions-current :temperature))
         (model-conditions-current-temp-unit
           (getf model-conditions-current-temp :unit))
         (model-conditions-current-temp-value
           (getf model-conditions-current-temp :value))
         (unit-str (getf +strings+ model-conditions-current-temp-unit))
         (today-button-text (format nil "~A, ~A, ~D~A"
                                    (getf model-location :city)
                                    (getf model-location :department)
                                    model-conditions-current-temp-value
                                    unit-str))
         (today-block-title (getf +strings+ :label-today-title))
         (today-block-subtitle (format nil "~A" (getf model :date)))) 
    `(:header (:home-button (:icon :icon-app-logo
                             :on-click (:type :type-navigation
                                        :destination :destination-home))
               :today-button (:text ,today-button-text
                              :on-click (:type :type-navigation
                                         :destination :destination-today)))
      :content
      (:today-block (:title ,today-block-title
                     :subtitle ,today-block-subtitle
                     :high (:icon :icon-sun-behind-small-cloud
                            :desc "Sunny to partly cloudy"
                            :temp "Hi: 7°")
                     :low (:icon :icon-moon-behind-small-cloud
                           :desc "Tonight: Mainly clear and cold"
                           :temp "Lo: -2°"))
       :current-block (:title "CURRENT WEATHER"
                       :subtitle "6:17 PM"
                       :icon :icon-moon-behind-small-cloud
                       :temp (:actual "-1°"
                              :real-feel "-1°"
                              :unit "C")
                       :desc "Mostly clear"
                       :details ((:label "RealFeel Shade™" :value "-2°")
                                 (:label "Wind" :value "NNE 9 km/h")
                                 (:label "Wind Gusts" :value "21 km/h")
                                 (:label "Air Quality"
                                  :value "Poor"
                                  :color :color-yellow)))))))

(defstruct change model command)

(defstruct model date location conditions-current conditions-today command)

(defstruct command name arguments)

(defstruct message type payload)

(defstruct location city department)

(defstruct conditions-today low high)

(defstruct conditions
  temperature
  cover
  summary
  air-quality
  pressure
  precipitation)

(defun copy-struct-with (src-struct &rest slot-value-pairs)
  (let ((dest-struct (copy-structure src-struct)))
    (loop while slot-value-pairs
          do (let ((slot (pop slot-value-pairs))
                   (value (pop slot-value-pairs)))
               (setf (slot-value dest-struct slot) value)))
    dest-struct))

(defun update (model message)
  (case (getf message :msg-type)
    (:msg-got-current-time
     `(:model
       (:date ,(getf message :msg-value)
        :location (:city "Auxerre" :department "Yonne")
        :conditions-current (:temperature (:value -1
                                           :unit :unit-deg-celsius)
                             :cover :cover-sunny-partly-cloudy
                             :air-quality 75)
        :conditions-today
              (:low (:temperature (:value -4 :unit :unit-deg-celsius)
                     :summary "Clearing and cold"
                     :cover :cover-intermittent-clouds)
               :high (:temperature (:value 2 :unit :unit-deg-celsius)
                      :cover :cover-partly-sunny-w-flurries
                      :summary "Tomorrow: a morning flurry; otherwise, chilly with sunshine and a few clouds"
                      :air-quality :TBD
                      :pressure :TBD
                      :precipitation :TBD)))
       :command nil))
    (otherwise `(:model ,model
                 :command nil))))
