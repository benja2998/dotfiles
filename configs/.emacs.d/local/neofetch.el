;; neofetch.el

;; Neofetch program written in pure Emacs Lisp. Does not require any external programs! Runs on any operating system!
;; Copyright (C) 2026 benja2998

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

(defun neofetch ()
  "Neofetch program written in pure Emacs Lisp. Does not require any external programs! Runs on any operating system!"
  (interactive)
  (princ (concat
		  
		  ;;; username@hostname


		  (propertize (user-login-name) 'font-lock-face '(:foreground "purple"))
		  "@"
		  (propertize (system-name) 'font-lock-face '(:foreground "purple"))
		  (format "\n")

		  ;;; Horizontal line

		  "-------------------------"

		  (format "\n")

		  ;;; OS: system-type
		  
		  (propertize "OS" 'font-lock-face '(:foreground "cyan"))
		  (format ": %s\n" system-type)

		  ;;; Emacs version: emacs-version

		  (propertize "Emacs version" 'font-lock-face '(:foreground "cyan"))
		  (format ": %s\n" emacs-version)

		  ;;; Emacs uptime: emacs-uptime

		  (propertize "Emacs uptime" 'font-lock-face '(:foreground "cyan"))
		  ": "
		  (emacs-uptime)
		  (format "\n")

		  ;;; Emacs startup time: emacs-init-time

		  (propertize "Emacs startup time" 'font-lock-face '(:foreground "cyan"))
		  ": "
		  (emacs-init-time)
		  ))
  )

(provide 'neofetch)
