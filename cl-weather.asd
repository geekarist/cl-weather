(defsystem "cl-weather"
  :description "Weather app"
  :version "0.0.1"
  :author "Christophe Pelé"
  :licence "GPL"
  :components ((:file "main" :depends-on ("hello"))
               (:file "hello")))
