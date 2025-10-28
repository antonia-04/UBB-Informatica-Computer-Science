(defun f()
  (+ (* 2 3) 6)
)

; suma atomilor de la nivelul superficial al unei liste neliniare
; (suma '(1 (2 (3 4) 5) c 1)) → 2
(defun suma(l)
; forma COND – forma condițională: permite ramificarea prelucrărilor
	(cond
		((null l) 0)
		; NUMBERP – returnează T dacă argumentul e număr
		((numberp (car l)) (+ (car l) (suma (cdr l))))
		(t (suma (cdr l)))
	)
)

; să se calculeze suma atomilor numerici dintr-o listă neliniară
; (la toate nivelurile) (sumaN '(1 (2 a (3 4) b 5) c 1)) → 16
(defun sumaN(l)
	(cond
		((null l) 0)
		((numberp (car l)) (+ (car l) (sumaN (cdr l))))
		; ATOM – returnează T dacă argumentul e atom
		((atom (car l)) (sumaN (cdr l)))
		; ultima clauză e pentru primul element listă
		(t (+ (sumaN (car l)) (sumaN (cdr l))))
	)
)