(defun init ()
  :TBD)

(defun view (model)
  '(:page-header
    (:home-button (:icon :icon-home
		   :on-click (:message-type :destination-home))
     :today-button (:text "Auxerre, Yonne, -1°C"
		    :on-click (:message-type :destination-today)))

    :page-content
    (:today-block (:title "TODAY'S WEATHER"
		   :subtitle "SAT, DEC 27"
		   :prediction-high (:icon :TBD
				     :desc "Sunny to partly cloudy"
				     :temp "Hi: 7°")
		   :prediction-low (:icon :TBD
				    :desc "Tonight: Mainly clear and cold"
				    :temp "Lo: -2°"))
     :current-block :TBD))))

(defun update (model message)
  :TBD)
