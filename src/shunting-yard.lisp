(defpackage :infix/shunting-yard (:use :cl) (:shadow :step) (:export :shunting-yard))
(in-package :infix/shunting-yard)

(defun shunting-yard (in)
  (step in nil nil))

(defun step (in out ops)
  (cond (in
         (cond ((numberp (car in)) (output-number in out ops))
               ((listp (car in)) (step (cdr in) (cons (step (car in) nil nil) out) ops))
               ((is-op (car in))
                (if (and ops (or (and (is-left-associative (car in))
                                      (priority<= (car in) (car ops)))
                                 (priority< (car in) (car ops))))
                    ;; 左結合で優先順位がスタックトップと等しいか低い, 
                    ;; あるいはスタックトップと優先順位が低い.
                    (pop-operator in out ops)
                    (push-operator in out ops)))
               (t (error "Error ~A ~A ~A" in out ops)))) ;; TODO more detailed error message
        (ops (pop-operator in out ops))
        (t (car out)))) ;; 最後は値が積まれてる

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
        (error "Error ~A" op)))) ;; TODO more detailed error message

(defun priority< (op1 op2)
  (let ((sym1 (get-op op1))
        (sym2 (get-op op2)))
    (or (and (eq sym1 '+) (eq sym2 '*))
        (and (eq sym1 '+) (eq sym2 '/))
        (and (eq sym1 '-) (eq sym2 '*))
        (and (eq sym1 '-) (eq sym2 '/))
        (and (eq sym1 '*) (eq sym2 'expt))
        (and (eq sym1 '/) (eq sym2 'expt)))))

(defun priority= (op1 op2)
  (let ((sym1 (get-op op1))
        (sym2 (get-op op2)))
    (or (and (eq sym1 '+) (eq sym2 '+))
        (and (eq sym1 '+) (eq sym2 '-))
        (and (eq sym1 '-) (eq sym2 '+))
        (and (eq sym1 '-) (eq sym2 '-))
        (and (eq sym1 '*) (eq sym2 '*))
        (and (eq sym1 '*) (eq sym2 '/))
        (and (eq sym1 '/) (eq sym2 '*))
        (and (eq sym1 '/) (eq sym2 '/))
        (and (eq sym1 'expt) (eq sym2 'expt)))))

(defun priority<= (op1 op2)
  (or (priority< op1 op2) (priority= op1 op2)))

(defun is-left-associative (op)
  (let ((sym (get-op op)))
    (or (eq sym '+)
        (eq sym '-)
        (eq sym '*)
        (eq sym '/))))

(defun output-number (in out ops)
  (step (cdr in) (cons (car in) out) ops))

(defun pop-operator (in out ops)
  (step in
        (cons (list (get-op (car ops)) (car out) (cadr out)) (cddr out))
        (cdr ops)))

(defun push-operator (in out ops)
  (step (cdr in)
        out
        (cons (car in) ops)))
