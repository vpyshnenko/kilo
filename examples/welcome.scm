#!/usr/local/bin/guile
!#
(use-modules (ncurses curses)
             (ice-9 format))

(define stdscr (initscr))
(raw!)
(noecho!)
(keypad! stdscr #t)

(define cur-col 0)

(define (addch-at-row row ch)
  (addch stdscr
	 (normal ch)
          #:y row
          #:x cur-col))
(do ((i 0 (1+ i))
     (last-row (1- (lines))))
    ((> i last-row))
  (addch-at-row i #\~))

;; draw column of tildes
(let loop ((row 0))
  (if (addch-at-row row #\~)
      (loop (1+ row))))

;; draw welcome message
(let* ((kilo-version "0.0.1")
      (message (format #f "Kilo editor -- version ~a" kilo-version))
      (starty (round (/ (lines) 3)))
      (startx (round (/ (- (cols) (string-length message)) 2))))
  (addstr stdscr message  #:x startx #:y starty))

(move stdscr 0 0)

(refresh stdscr)
(getch stdscr)
(endwin)
