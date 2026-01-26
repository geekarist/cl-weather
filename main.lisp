(defun init ()
  :TBD)


(defun view (model)
  '(:page-header (:home-button (:icon :TBD
                                :on-click (:type :type-navigation
                                           :destination :destination-home))
                  :today-button (:text "Auxerre, Yonne, -1°C"
                                 :on-click (:type :type-navigation
                                            :destination :destination-today)))
    :page-content
    (:today-block (:title "TODAY'S WEATHER"
                   :subtitle "SAT, DEC 27"
                   :prediction-high (:icon :icon-sun-behind-small-cloud
                                     :desc "Sunny to partly cloudy"
                                     :temp "Hi: 7°")
                   :prediction-low (:icon :icon-moon-behind-small-cloud
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
                                :color :color-yellow))))))


(defun update (model message)
  :TBD)

(defun execute (command on-result-msg)
  (print "TBD: Execute command: " command))

(defun main ()
  (let* ((change-1 (hello-init))
         (model-1 (getf change-1 :model))
         (view-1 (hello-view model-1))
         (_ (format nil "View 1: " view-1))
         (command-1 (getf change-1 :command)))
    (execute command-1
             (lambda (message)
               (print "TBD: Dispatch message: " message))))
  (print "Done")))


