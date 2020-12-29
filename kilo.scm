#!/usr/local/bin/guile
!#
(use-modules (ncurses curses)
             (ice-9 format))

(define stdscr (initscr))
(raw!)
(noecho!)
(keypad! stdscr #t)


(let ((content '("Hello world" "My second line content" "My third line content")))
  (for-each (lambda (line)
	      (addstr stdscr (format #f "~a ~%" line))) content))

(define (addch-at-row row ch)
  (addch stdscr
	 (normal ch)
          #:y row
          #:x 0))

;; draw column of tildes
(let loop ((row (getcury stdscr)))
  (if (addch-at-row row #\~)
      (loop (1+ row))))

;; draw welcome message
(let* ((kilo-version "0.0.1")
      (message (format #f "Kilo editor -- version ~a" kilo-version))
      (starty (round (/ (lines) 3)))
      (startx (round (/ (- (cols) (string-length message)) 2))))
  (addstr stdscr message  #:x startx #:y starty))

(let loop ((cy 0)
	   (cx 0))
    (move stdscr cy cx)
    (refresh stdscr)
    (let ((c (getch stdscr)))
	(cond
	((eqv? c KEY_HOME)
	  (loop cy 0))
	((eqv? c KEY_END)
	  (loop cy (1- (cols))))
	((eqv? c KEY_PPAGE)
	  (loop 0 cx))
	((eqv? c KEY_NPAGE)
	  (loop (1- (lines)) cx))
	((eqv? c KEY_DOWN)
	 (if (< cy (1- (lines)))
	     (loop (1+ cy) cx)
	     (loop cy cx)))
	((eqv? c KEY_UP)
	 (if (> cy 0)
	  (loop (1- cy) cx)
	  (loop cy cx)))
	((eqv? c KEY_RIGHT)
	 (if (< cx (1- (cols)))
	     (loop cy (1+ cx))
	     (loop cy cx)))
	((eqv? c KEY_LEFT)
	 (if (> cx 0)
	  (loop cy (1- cx))
	  (loop cy cx)))
	;; If 'Q' or 'q'  is pressed, quit.  Otherwise, loop.
	((not (or (eqv? c #\Q) (eqv? c #\q)))
	  (loop cy cx)))))

(refresh stdscr)
(endwin)