(defpackage :infix/infix
  (:use :cl :infix/shunting-yard)
  (:export :shunting-yard :infix))
(in-package :infix/infix)

(defmacro infix (&body body)
  (shunting-yard body))