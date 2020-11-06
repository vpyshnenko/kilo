#!/usr/local/bin/guile
!#
(use-modules (ncurses curses)
             (ice-9 format))

(define stdscr (initscr))
(nocbreak!)
(let loop ((c (getch stdscr)))
    (cond
     ;; If 'Q' or 'q'  is pressed, quit.  Otherwise, loop.
     ((not (or (eqv? c #\Q) (eqv? c #\q)))
      (loop (getch stdscr)))))
(endwin)
