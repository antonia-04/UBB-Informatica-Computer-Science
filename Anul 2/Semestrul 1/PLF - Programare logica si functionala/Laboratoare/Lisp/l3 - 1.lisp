; Laborator 3 - Lisp
; Problema 1
; Sa se construiasca o functie care intoarce adancimea unei liste. (cu functii MAP)

(defun adancime(l)
  (cond
      ((atom l) 0)
      (t (+ 1 (apply #'max(mapcar #'adancime l))))
    )
)
                   
; Exemplu 1
(print "Exemplu 1")
(print (adancime '((a (b (c d))) e (f (g h (i))))))

; Exemplu 2
(print "Exemplu 2: '(A)'")
(print (adancime '(A)))

; Exemplu 3
(print "Exemplu 3: (1 (2 (3 (4) 5 (6 (7))))) ")
(print (adancime '(1 (2 (3 (4) 5 (6 (7))))) ))

