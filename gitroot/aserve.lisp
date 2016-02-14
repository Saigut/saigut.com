(ql:quickload :aserve)

(asdf:operate 'asdf:load-op 'chapter-8)
(asdf:operate 'asdf:load-op 'chapter-31)

(defpackage :com.gigamonkeys.web
  (:use :cl :net.aserve :com.gigamonkeys.html))

(in-package :com.gigamonkeys.web)

(start :port 80)

(publish-directory :prefix "/" :destination "/home/saigut/gitroot/webroot/")

(defun random-number (request entity)
  (with-http-response (request entity :content-type "text/html")
    (with-http-body (request entity)
      (with-html-output ((request-reply-stream request))
	(html
	  (:html
	    (:head (:title "Random"))
	    (:body
	     (:p "Random number: " (:print (random 1000))))))))))

(publish :path "/random-number" :function 'random-number)
