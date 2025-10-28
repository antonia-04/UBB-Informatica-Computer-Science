; Laborator 1 - Lisp
; Problema 1
; a) Sa se insereze intr-o lista liniara un atom dat dupa al 2-lea, al 4-lea, al 6-lea,....element.

(defun insereaza (l pozCurenta pozDeInserat el)
  (cond
  	;daca lista e goala
    ((null l) nil) 
    ; daca pozitia curenta nu e cea de inserat
    ((not (= pozCurenta pozDeInserat)) 
     (cons (car l) (insereaza (cdr l) (+ pozCurenta 1) pozDeInserat el))) 
    ; daca pozCurenta = pozDeInserat
    (t      
     (cons (car l) 
           (cons el (insereaza (cdr l) (+ pozCurenta 1) (+ pozDeInserat 2) el)))))) 

; functie wrapper - insereazaMain
(defun insereazaMain (l el)
  (insereaza l 1 2 el)) ; incepem de la poz 1 si vrem sa inseram de la 2

(print "a)")
(print (insereazaMain '(1 2 3 4 5 6 7 8) 'A))

; b)  Definiti o functie care obtine dintr-o lista data lista tuturor atomilor care apar, pe orice nivel, dar in ordine inversa.
; exemplu: (((A B) C) (D E)) --> (E D C B A)

(defun inversaLista(l)
 (cond
    ((null l) nil)
    ((atom l) (list l))
    (t(append (inversaLista(cdr l)) (inversaLista(car l)) ))
 )
)

(print "b)")
(print (inversaLista `(((A B) C) (D E))))

; c) Definiti o functie care intoarce cel mai mare divizor comun al numerelor dintr-o lista neliniara.

; Euclid
(defun cmmdc (a b)
  (cond
    ((= b 0) a)                           
    (t (cmmdc b (mod a b)))))            

(defun cmmdcLista(l d)
 (cond
   ((null l) d)
   (t(cmmdcLista (cdr l) (cmmdc d (car l))))
 )
)

(defun cmmdcMain( l)
  (cmmdcLista (cdr l) (car l)) 
)

(print "c)")
(print (cmmdcMain '( 60  15 30 90)))

; d) Sa se scrie o functie care determina numarul de aparitii ale unui atom dat intr-o lista neliniara.

(defun nrAparitii (l el)
 (cond 
   ((null l) 0)
   ((AND (atom (car l)) (= (car l) el)) (+ 1 (nrAparitii (cdr l ) el)))
   ((AND (atom (car l)) (not(= (car l) el))) (nrAparitii (cdr l ) el))
   ((listp (car l)) (+ (nrAparitii (car l) el) (nrAparitii (cdr l) el)))
 )
)

(print "d)")
(print (nrAparitii '(1 2 (1 2) 4 5 (1 (4(8(1))))) 1))