#!/usr/local/bin/guile
!#
(use-modules (ncurses curses)
             (ice-9 format))

(define stdscr (initscr))
(cbreak!)
;;(raw!) to see Ctrl-C, Ctrl-Z, Ctrl-S, Ctrl-Q
(noecho!)
;; (keypad! stdscr #t) to see ESC-sequences
(keypad! stdscr #t)


(addstr stdscr "Type any character to see its code\n")
(let loop ((ch (getch stdscr)))
  (if (char? ch)                    ; If a non-function key is pressed
      (addstr stdscr
            (format #f "You entered: ~c ~d~%" ch (char->integer ch)))
      (addstr stdscr
            (format #f "You entered:  ~d ~a ~%" ch (keyname ch) )))
  (refresh stdscr)
  (loop (getch stdscr)))
(endwin)
