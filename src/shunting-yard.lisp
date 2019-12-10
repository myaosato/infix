(defpackage :infix/shunting-yard (:use :cl) (:export :shutting-yard))
(in-package :infix/shunting-yard)

(defun shutting-yard (input))

(defun step (in out ops)
  (cond (in
         (cond ((numberp (car in)) (output-number in out ops))
               ((listp (car in)) (step (cdr in) (step (car in) nil nil) ops))
               ((is-op (car in))
                (if () ;; TODO 左結合で優先順位がスタックトップと等しいか低い, あるいは優先順位が低い
                 ;; 
                 (push-operator in out ops))
               (t (error "Error")))) ;; TODO more detailed error message
        (ops (pop-operator in out ops))
        (t out)))

(defun is-op (op?)
  (cond ((string= "+" (symbol-name op?)) '+)
        ((string= "-" (symbol-name op?)) '-)
        ((string= "*" (symbol-name op?)) '*)
        ((string= "/" (symbol-name op?)) '/)
        ((string= "^" (symbol-name op?)) 'expt)
        (t nil)))

(defun get-op (op)
  (let ((sym (is-op op)))
    (if sym
        sym
        (error "Error")))) ;; TODO more detailed error message

(defun output-number (in out ops)
  (step (cdr in) (cons (car in) out) ops))

(defun pop-operator (in out ops)
  (step in
        (cons (list (car ops) (car out) (cdr out)) (cddr out))
        (cdr ops)))

(defun push-operator (in out ops)
  (step (cdr in)
        out
        (cons (get-op (car in)) ops)))
