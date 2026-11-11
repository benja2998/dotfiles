;;; neofetch.el --- Pretty system information tool for the Eshell -*- lexical-binding: t; -*-

;; Copyright (C) 2026 benja2998


;; Author: benja2998 <benja2998@proton.me>
;; Maintainer: benja2998 <benja2998@proton.me>
;; Created: 2 July 2026
;; Package-Version: 20260916.2218
;; Package-Revision: 171b49930dd6

;; Keywords: tools
;; URL: https://codeberg.org/benja2998/neofetch.el

;; Package-Requires: ((emacs "30.2"))

;; This file is not part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;; Pretty system information tool for the Eshell

;;; Code:

;;;
;;; Utils
;;;

(require 'eshell)
(require 'iimage)
(require 'em-basic)
(require 'esh-mode)

(defun neofetch--pairs-to-plist (pairs)
  "Convert PAIRS into a plist."
  (apply #'append
	 (mapcar (lambda (p)
		   (list (intern (concat ":" (car p)))
			 (cadr p)))
		 pairs)))

(defun neofetch--get-file-contents (filename)
  "Return the contents of file FILENAME.

Signals an error when FILENAME can't be read."
  (with-temp-buffer
    (insert-file-contents filename)
    (buffer-string)))

(defun neofetch--get-file-contents-of-first-readable-file (&rest filenames)
  "Return the contents of the first readable file in FILENAMES.

If no file can be read, return nil."
  (when-let* ((file (seq-find #'file-readable-p filenames)))
    (neofetch--get-file-contents file)))

;;;
;;; Exclusive to the 'android' 'system-type'.
;;;

(defun neofetch--android-get-prop (prop)
  "Return the Android system property PROP or nil."
  (car (ignore-error t
	 (process-lines "getprop" prop))))

(defun neofetch--android-get-pretty-name ()
  "Return a pretty representation of the OS name for Android systems.

Return nil if no pretty representation could be found."
  (let* ((release (neofetch--android-get-prop "ro.product.build.version.release")))
    (string-join
     (seq-remove #'null
		 `("Android" ,release))
     " ")))

;;;
;;; Exclusive to the 'gnu/linux' 'system-type'.
;;;

(defun neofetch--gnu-linux-read-os-release ()
  "Return the contents of the \"os-release\" file.

If no \"os-release\" file could be read, return nil.

For details: https://www.man7.org/linux/man-pages/man5/os-release.5.html"
  (neofetch--get-file-contents-of-first-readable-file "/etc/os-release" "/usr/lib/os-release"))

(defun neofetch--gnu-linux-get-os-release-plist ()
  "Return a plist with OS identification data for GNU/Linux systems.

For details: https://www.man7.org/linux/man-pages/man5/os-release.5.html"
  (neofetch--pairs-to-plist
   (mapcar (lambda (cons)
	     `(,(string-replace "_" "-" (downcase (car cons)))
	       ,(string-replace "\"" "" (or (cadr cons) ""))))
	   (mapcar (lambda (line)
		     (split-string line "="))
		   (split-string (or (neofetch--gnu-linux-read-os-release) "") "\n" t)))))

(defun neofetch--gnu-linux-get-distro-pretty-name ()
  "Return a pretty representation of the OS name for GNU/Linux systems.

Return nil if no pretty representation could be found."
  (plist-get (neofetch--gnu-linux-get-os-release-plist) :pretty-name))

;;;
;;; Exclusive to the Linux kernel.
;;;

(defun neofetch--linux-get-kernel-pretty-info ()
  "Return a pretty representation of the Linux kernel."
  (let* ((kernel-name (neofetch--linux-get-kernel-name))
	 (kernel-version-release (neofetch--linux-get-kernel-version-release))
	 (kernel-arch (neofetch--linux-get-kernel-arch))
	 (kernel-arch-formatted (if kernel-arch
				    (format "(%s)" kernel-arch)
				  nil)))
    (string-join
     (seq-remove #'null
		 `(,kernel-name ,kernel-version-release ,kernel-arch-formatted))
     " ")))

(defun neofetch--linux-get-kernel-name ()
  "Return the Linux kernel name or nil."
  (when-let* ((file "/proc/sys/kernel/ostype")
	      ((file-readable-p file)))
    (string-trim (neofetch--get-file-contents file))))

(defun neofetch--linux-get-kernel-version-release ()
  "Return the \"release\" part of the Linux kernel version or nil."
  (when-let* ((file "/proc/sys/kernel/osrelease")
	      ((file-readable-p file)))
    (string-trim (neofetch--get-file-contents file))))

(defun neofetch--linux-get-kernel-arch ()
  "Return the machine architecture used by the Linux kernel or nil."
  (when-let* ((file "/proc/sys/kernel/arch")
	      ((file-readable-p file)))
    (string-trim (neofetch--get-file-contents file))))

(defun neofetch--linux-get-kernel-pretty-arch ()
  "Return a pretty representation of the machine architecture or nil."
  (when-let* ((arch (neofetch--linux-get-kernel-arch)))
    (format "(%s)" arch)))

(defun neofetch--linux-android-get-kernel-pretty-info ()
  "Return a pretty representation of the Linux kernel (Android)."
  (let* ((kernel-name (neofetch--linux-get-kernel-name))
	 (kernel-version-release (neofetch--linux-get-kernel-version-release))
	 (cpu-architecture (neofetch--android-get-prop "ro.product.cpu.abi")))
    (string-join
     (seq-remove #'null
		 `(,kernel-name ,kernel-version-release ,cpu-architecture))
     " ")))

;;;
;;; Common
;;;

(defun neofetch--get-os-pretty-name ()
  "Return a pretty representation of the OS name."
  (pcase system-type
    ('gnu			"GNU Hurd")
    ('gnu/linux     (or (neofetch--gnu-linux-get-distro-pretty-name)
			"GNU/Linux"))
    ('gnu/kfreebsd	"GNU/FreeBSD")
    ('darwin		"Darwin")			; GNU-Darwin / macOS
    ('ms-dos		"MS-DOS")
    ('windows-nt	"Microsoft Windows")
    ('cygwin		"Cygwin")
    ('haiku			"Haiku")
    ('android		(or (neofetch--android-get-pretty-name)
			    "Android"))
    (_ (symbol-name system-type))))

(defun neofetch--get-kernel-pretty-info ()
  "Return a pretty representation of the kernel."
  (pcase system-type
    ('gnu			"Hurd")
    ('gnu/linux     (or (neofetch--linux-get-kernel-pretty-info)
			"Linux"))
    ('gnu/kfreebsd	"GNU/FreeBSD")
    ('darwin		"XNU")				; XNU Is Not Unix
    ('ms-dos		"MS-DOS")
    ('windows-nt	"NT")
    ('cygwin		"Cygwin")
    ('haiku			"Haiku")
    ('android		(or (neofetch--linux-android-get-kernel-pretty-info)
			    "Linux (Android)"))
    (_ (symbol-name system-type))))

;;;
;;; Entry point
;;;

(defun neofetch (&optional logo-path)
  "Neofetch program written in pure Emacs Lisp.
Does not require any external programs and runs on any operating system.
Optional argument LOGO-PATH to display a logo."

  (catch 'not-in-eshell
    (if (not (eq major-mode 'eshell-mode))
	(throw 'not-in-eshell "Not in eshell")))

  (when (derived-mode-p 'eshell-mode)
    (let ((logo-path-if-exists
	   (when logo-path
	     (concat "file://"
		     logo-path
		     (format "\n"))))
	  (hr-line
	   (make-string
	    (length
	     (concat (user-login-name) "@" (system-name))) ?-)))

      (require 'bind-key)

      (eshell/clear-scrollback)

      (iimage-mode 1)
      (unbind-key "C-l" 'iimage-mode-map)

      (eshell/printnl (concat
		       ;; image
		       logo-path-if-exists

		       ;; username@hostname

		       (propertize (user-login-name) 'font-lock-face '(:foreground "purple"))
		       "@"
		       (propertize (system-name) 'font-lock-face '(:foreground "purple"))
		       (format "\n")

		       ;; Horizontal line

		       hr-line

		       (format "\n")

		       ;; OS: system-type

		       (propertize "OS" 'font-lock-face '(:foreground "cyan"))
		       (format ": %s\n" (neofetch--get-os-pretty-name))

		       ;; Kernel: kernel
		       (propertize "Kernel" 'font-lock-face '(:foreground "cyan"))
		       (format ": %s\n" (neofetch--get-kernel-pretty-info))

		       ;; Emacs version: emacs-version

		       (propertize "Emacs version" 'font-lock-face '(:foreground "cyan"))
		       (format ": %s\n" emacs-version)

		       ;; Emacs uptime: emacs-uptime

		       (propertize "Emacs uptime" 'font-lock-face '(:foreground "cyan"))
		       ": "
		       (emacs-uptime)
		       (format "\n")

		       ;; Emacs startup time: emacs-init-time

		       (propertize "Emacs startup time" 'font-lock-face '(:foreground "cyan"))
		       ": "
		       (emacs-init-time)
		       (format "\n")

		       ;; Processors: num-processors

		       (propertize "Processors" 'font-lock-face '(:foreground "cyan"))
		       ": "
		       (format "%s" (num-processors))
		       (format "\n")

		       ;; Running Emacs sub-processes: process-count

		       (propertize "Running Emacs sub-processes" 'font-lock-face '(:foreground "cyan"))
		       ": "
		       (format "%s" (length (process-list)))))
      (iimage-recenter))))

(provide 'neofetch)

;;; neofetch.el ends here
