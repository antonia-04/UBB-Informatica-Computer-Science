; Laborator 2 - Lisp
; Problema 4
; Sa se converteasca un arbore de tipul (2) la un arbore de tipul (1).

; (A 2 B 0 C 2 D 0 E 0) (1)
; (A (B) (C (D) (E)))   (2)

(defun conversieSubarboriTip1 (subarbori)
  (cond
    ((null subarbori) nil) ; daca nu mai exista subarbori 
    (t (append (conversieArboreTip1 (car subarbori)) ; converteste primul subarbore
               (conversieSubarboriTip1 (cdr subarbori)))))) ; converteste restul

(defun conversieArboreTip1 (arbori)
  (cond
    ((null arbori) nil) ;
    ;; caz de frunza
    ((null (cdr arbori)) (list (car arbori) 0))
    ;; caz de nod cu subarbori
    (t (append 
         (list (car arbori) (length (cdr arbori))) ; nodul si nr de subarbori
         (conversieSubarboriTip1 (cdr arbori)))))) ; converteste lista de subarbori

(print "Exemplu 1")
(print (conversieArboreTip1 '(A (B) (C (D) (E)))))

(print "Exemplu laborator")
(print (conversieArboreTip1 `(A (B (H (I (J)))) (C (D (F (K)) (G)) (E))) ))


