#!/usr/local/bin/guile
!#
(use-modules (ncurses curses)
             (ice-9 format))

(define stdscr (initscr))
(raw!)
(noecho!)
(keypad! stdscr #t)

(define cur-col 0)
(define resp "none")

;; (addch-at-row 3 #\a)
;; firts column of 'a' using 'do' loop
(define (addch-at-row row ch)
  (addch stdscr
	 (normal ch)
          #:y row
          #:x cur-col))
(do ((i 0 (1+ i))
     (last-row (1- (lines))))
    ((> i last-row))
  (addch-at-row i #\~))


;; second column of 'b' using 'while loop'
(set! cur-col 2)
(define (create-add-next-ch ch)
  (let ((row -1))
    (lambda ()
      (set! row (1+ row))
      (addch-at-row row ch))))

(define add-next-ch (create-add-next-ch #\a))
(set! resp (while (add-next-ch) #t))
;; for some reason following while is skipped by guile
;; (while (add-next-ch) #t)

;; third column of 'c' using naming let
(set! cur-col 4)
(let loop ((row 0))
  (if (addch-at-row row #\b)
      (loop (1+ row))))

(refresh stdscr)
(getch stdscr)
(endwin)
