(defpackage :infix/test
  (:use :cl :infix/infix)
  (:export :test))
(in-package :infix/test)

(defmacro test-case (exp)
  `(format t "~A: ~A~%" (if ,exp "OK" "NG") ',exp))

(defun test ()
  (test-case (equal (shunting-yard '(1 + 1)) '(+ 1 1)))
  (test-case (equal (shunting-yard '(1 + 2 * 3 ^ 2 ^ 2)) '(+ 1 (* 2 (expt 3 (expt 2 2))))))
  (test-case (equal (shunting-yard '((1 + 2) * 3 ^ 2 + 1)) '(+ (* (+ 1 2) (expt 3 2)) 1))))

