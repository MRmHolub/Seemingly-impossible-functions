(defun c-find (p) (lambda ()
                    (if (for-some (lambda (x)
                                    (funcall p (cons 0 x))))
                        (print (cons 0 (c-find (lambda (x)
                                        (funcall p (cons 0 x))))))
                      (print (cons 1 (c-find (lambda (x)
                                    (funcall p (cons 1 x)))))))))
(defun for-some (p)
  (funcall p (c-find p)))

(defun for-each (p)
  (not (for-some (lambda (x) (not (funcall p x))))))


(defun are-same (f1 f2)
  (not (forsome (lambda (x) (/= (funcall f1 x) (funcall f2 x)))))

#|
POSSIBLE SCENARIOS

When we call function my-nth we dont know whether we have already calculated part of the seq or not, thats why we in a first place check that.
Thats why we check whether it is a closure at the start (if it was not, that means we are dealing with already partly-enumerated sequence of 0's and 1's)

Then we check recursion condition, whether we have reached sufficient index, if so we simply return the value on that index

If we did not reached sufficient index we need to go way deeper (we may have calculated it, but just not reached yet).

Since we know we must go deeper we first check whether we have already calculated it or whether the next element is the closure.
(which is just find function with my predicate nested inside list of 1' and 0's --> the list itself depends on the state of program and given predicate

If it is not function it must be a part of the already enumerated sequence (meaning I still need searching further the line but I've already calculated next index that continues


|#


(defun my-nth (seq i)
  (format t "New function call for function my-nth ~a ~a" seq i)  
  (cond ((functionp seq) (eval-lazy-seq seq i)) ;If it is not a function then it is partly computed seq
        ((= i 0) (car seq))
        ((functionp (cdr seq)) (eval-lazy-seq (cdr seq) (- i 1))) 
        (t (my-nth (cdr seq) (- i 1)))))


(defun eval-lazy-seq (lazy-seq i)  
  (my-nth (funcall lazy-seq) i))


;(for-some (lambda (x) (and (= (my-nth x 5) 0) (= (my-nth x 5) 1))))
