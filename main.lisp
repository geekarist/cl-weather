(defun init ()
  :TBD)

(defun view (model)
  '(:page-header
    (:home-button (:icon :TBD
		   :on-click (:type :type-navigation
			      :destination :destination-home))
     :today-button (:text "Auxerre, Yonne, -1°C"
		    :on-click (:message-type :navigation
			       :navigation-destination :destination-today)))

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
		     :details (:TBD))))))

(defun update (model message)
  :TBD)
