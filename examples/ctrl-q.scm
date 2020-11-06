#!/usr/local/bin/guile
!#
(use-modules (ncurses curses)
             (ice-9 format))

(define stdscr (initscr))
(raw!)
(noecho!)
(keypad! stdscr #t)


(addstr stdscr "Type any character to see its code\n")
(addstr stdscr "Press Ctrl-Q to exit\n\n")
(let loop ((ch (getch stdscr)))
  (define keystr (keyname ch))
  (define code (if (char? ch) (char->integer ch) ch))
  (addstr stdscr
    (format #f "key:  ~d ~s ~%" code keystr ))
  (if (not (equal? keystr "^Q"))
      (loop (getch stdscr))))
(endwin)
