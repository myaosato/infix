;;don't edit
(defsystem "infix"
  :depends-on ("infix/infix")
  :class :package-inferred-system
  :license "mit"
  :author "myaosato"
  :pathname "src/"
  :mailto "tetu60u@yahoo.co.jp"
  :in-order-to ((test-op (test-op "infix/test"))))

(defsystem "infix/test"
  :depends-on ("infix/test")
  :class :package-inferred-system
  :license "mit"
  :author "myaosato"
  :pathname "src/"
  :mailto "tetu60u@yahoo.co.jp"
  :perform (test-op (op sys) (uiop:symbol-call :infix/test :test)))

