;;; keepass-mode.el --- Mode to open Keepass DB  -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C) 2020  Ignasi Fosch

;; Author: Ignasi Fosch <natx@y10k.ws>
;; Keywords: data files tools
;; Version: 0.0.4
;; Homepage: https://github.com/ifosch/keepass-mode
;; Package-Requires: ((emacs "27"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses>.

;;; Commentary:

;; KeePass mode provides a major mode to work with KeePass DB files.
;; So far it provides with simple navigation through folders and entries,
;; and copying passwords to Emacs clipboard.

;;; Code:

(defvar-local keepass-mode-db "")
(defvar-local keepass-mode-password "")
(defvar-local keepass-mode-group-path "")

(defun keepass-mode-select ()
  "Select an entry in current Keepass key."
  (interactive)
  (let ((entry (aref (tabulated-list-get-entry) 0)))
    (if (keepass-mode-is-group-p entry)
        (progn
          (keepass-mode-update-group-path (keepass-mode-concat-group-path entry))
          (keepass-mode-open))
      (keepass-mode-show entry))))

(defun keepass-mode-back ()
  "Navigate back in group tree."
  (interactive)
  (keepass-mode-update-group-path (replace-regexp-in-string "[^/]*/?$" "" keepass-mode-group-path))
  (keepass-mode-open))

(defun keepass-mode-copy (field)
  "Copy current entry FIELD to clipboard."
  (let ((entry (aref (tabulated-list-get-entry) 0)))
    (if (keepass-mode-is-group-p entry)
        (message "%s is a group, not an entry" entry)
      (progn (kill-new (keepass-mode-get field entry))
             (message "%s for '%s%s' copied to kill-ring" field keepass-mode-group-path entry)))))

(defun keepass-mode-copy-url ()
  "Copy current entry URL to clipboard."
  (interactive)
  (keepass-mode-copy "URL"))

(defun keepass-mode-copy-username ()
  "Copy current entry username to clipboard."
  (interactive)
  (keepass-mode-copy "UserName"))

(defun keepass-mode-copy-password ()
  "Copy current entry password to clipboard."
  (interactive)
  (keepass-mode-copy "Password"))

(defun keepass-mode-copy-totp ()
  "Copy current entry TOTP to clipboard."
  (interactive)
  (let ((entry (aref (tabulated-list-get-entry) 0)))
    (if (keepass-mode-is-group-p entry)
        (message "%s is a group, not an entry" entry)
      (let ((output (shell-command-to-string
                     (keepass-mode-command
                      (keepass-mode-quote-unless-empty
                       (keepass-mode-concat-group-path entry))
                      "show -t"))))
        (kill-new (string-trim output))
        (message "TOTP for '%s%s' copied to kill-ring"
                 keepass-mode-group-path entry)))))

(defun keepass-mode-open ()
  "Open a Keepass file at GROUP."
  (let ((columns [("Key" 100)])
        (rows (mapcar (lambda (x) `(nil [,x]))
                      (keepass-mode-get-entries keepass-mode-group-path))))
    (setq tabulated-list-format columns)
    (setq tabulated-list-entries rows)
    (tabulated-list-init-header)
    (tabulated-list-print)))

(defun keepass-mode-ask-password ()
  "Ask the user for the password."
  (read-passwd (format "Password for %s: " keepass-mode-db)))

(defun keepass-mode-show (group)
  "Show a Keepass entry at GROUP."
  (let* ((entry (keepass-mode-concat-group-path group))
        (output (replace-regexp-in-string "Password: .+" "Password: *************" (keepass-mode-get-entry entry))))
    (switch-to-buffer (format "*keepass %s %s*" keepass-mode-db entry))
    (insert output)
    (read-only-mode)))

(defvar keepass-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "RET") 'keepass-mode-select)
    (define-key map (kbd "<backspace>") 'keepass-mode-back)
    (define-key map (kbd "u") 'keepass-mode-copy-url)
    (define-key map (kbd "b") 'keepass-mode-copy-username)
    (define-key map (kbd "c") 'keepass-mode-copy-password)
    (define-key map (kbd "t") 'keepass-mode-copy-totp)    
   map))

;;;###autoload
(define-derived-mode keepass-mode tabulated-list-mode "KeePass"
  "KeePass mode for interacting with the KeePass DB. \\{keepass-mode-map}."
  (setq-local keepass-mode-db buffer-file-truename)
  (when (zerop (length keepass-mode-password))
    (setq-local keepass-mode-password (keepass-mode-ask-password)))
  (setq-local keepass-mode-group-path "")
  (keepass-mode-open))

(add-to-list 'auto-mode-alist '("\\.kdbx\\'" . keepass-mode))
(add-to-list 'auto-mode-alist '("\\.kdb\\'" . keepass-mode))

(defun keepass-mode-get (field entry)
  "Retrieve FIELD from ENTRY."
  (keepass-mode-get-field field (shell-command-to-string (keepass-mode-command (keepass-mode-quote-unless-empty entry) "show -s"))))

(defun keepass-mode-get-entries (group)
  "Get entry list for GROUP."
  (nbutlast (split-string (shell-command-to-string (keepass-mode-command (keepass-mode-quote-unless-empty group) "ls")) "\n") 1))

(defun keepass-mode-concat-group-path (group)
  "Concat GROUP and group path."
  (format "%s%s" keepass-mode-group-path (or group "")))

(defun keepass-mode-update-group-path (group)
  "Update group-path with GROUP."
  (setq keepass-mode-group-path group))

(defun keepass-mode-get-entry (entry)
  "Get ENTRY details."
  (shell-command-to-string (keepass-mode-command (keepass-mode-quote-unless-empty entry) "show")))

(defun keepass-mode-get-field (field entry)
  "Get FIELD from an ENTRY."
  (keepass-mode-get-value-from-alist field (keepass-mode-read-data-from-string entry)))

(defun keepass-mode-command (group command)
  "Generate KeePass COMMAND to run, on GROUP."
  (format "echo %s | \
           keepassxc-cli %s %s %s 2>&1 | \
           grep -E -v '[Insert|Enter] password to unlock %s'"
          (shell-quote-argument keepass-mode-password)
          command
          keepass-mode-db
          group
          keepass-mode-db))

(defun keepass-mode-quote-unless-empty (text)
  "Quote TEXT unless it's empty."
  (if (= (length text) 0) text (format "'%s'" text)))

(defun keepass-mode-get-value-from-alist (key alist)
  "Get the value for KEY from the ALIST."
  (mapconcat 'identity (cdr (assoc key alist)) ":"))

(defun keepass-mode-read-data-from-string (input)
  "Read data from INPUT string into an alist."
  (mapcar
    (lambda (arg) (split-string arg ":" nil " "))
    (split-string input "\n")))

(defun keepass-mode-is-group-p (entry)
  "Return if ENTRY is a group."
  (string-suffix-p "/" entry))

(defun keepass-mode-run-command (args &optional no-filter)
  "Run `keepassxc-cli' with ARGS (list of strings).
Pipe `keepass-mode-password' to stdin.
If NO-FILTER is nil, remove password‑prompt lines from output.
Return the command output as a string."
  (let* ((cmd (format "echo %s | keepassxc-cli %s"
                      (shell-quote-argument keepass-mode-password)
                      (string-join (mapcar #'shell-quote-argument args) " ")))
         (cmd (if no-filter
                  cmd
                (concat cmd " 2>&1 | grep -E -v '[Insert|Enter] password'"))))
    (shell-command-to-string cmd)))

(defun keepass-mode-add-entry (title username password url notes group)
  "Add a new entry to the current database.
TITLE is required. USERNAME, PASSWORD, URL, NOTES are optional.
GROUP is the target group path (defaults to current)."
  (interactive
   (list (read-string "Entry title: ")
         (read-string "Username (optional): ")
         (read-passwd "Password (optional, empty = generate): ")
         (read-string "URL (optional): ")
         (read-string "Notes (optional): ")
         (read-string (format "Group (default: %s): " keepass-mode-group-path)
                      nil nil keepass-mode-group-path)))
  (let* ((full-path (if (string-empty-p group)
                        title
                      (concat group title)))   ; group already ends with '/'
         (args `("add"
                 ,@(and (not (string-empty-p password))
                        (list "--password" password))
                 ,@(and (string-empty-p password)
                        (list "--generate"))
                 ,@(and (not (string-empty-p username))
                        (list "--username" username))
                 ,@(and (not (string-empty-p url))
                        (list "--url" url))
                 ,@(and (not (string-empty-p notes))
                        (list "--notes" notes))
                 ,keepass-mode-db ,full-path)))
    (keepass-mode-run-command args)
    (keepass-mode-open)))

(defun keepass-mode-edit-entry (field value)
  "Edit FIELD of currently selected entry to VALUE.
FIELD can be: title, username, password, url, notes."
  (interactive
   (let* ((entry (aref (tabulated-list-get-entry) 0)))
     (if (keepass-mode-is-group-p entry)
         (user-error "%s is a group, not an entry" entry)
       (list (completing-read "Field: " '("title" "username" "password" "url" "notes") nil t)
             (read-string "New value: ")))))
  (let* ((entry (aref (tabulated-list-get-entry) 0))
         (full-path (keepass-mode-concat-group-path entry))
         (args `("edit"
                 ,(concat "--" field) ,value
                 ,keepass-mode-db ,full-path)))
    (keepass-mode-run-command args)
    (keepass-mode-open)))

(defun keepass-mode-delete-entry ()
  "Delete currently selected entry after confirmation."
  (interactive)
  (let* ((entry (aref (tabulated-list-get-entry) 0)))
    (if (keepass-mode-is-group-p entry)
        (user-error "%s is a group, not an entry" entry)
      (when (yes-or-no-p (format "Delete '%s%s'? " keepass-mode-group-path entry))
        (let ((full-path (keepass-mode-concat-group-path entry)))
          (keepass-mode-run-command `("rm" ,keepass-mode-db ,full-path))
          (keepass-mode-open))))))

(defun keepass-mode-add-totp (secret)
  "Add or update TOTP secret for the current entry.
SECRET must be a Base32‑encoded key."
  (interactive (list (read-string "TOTP secret (Base32): ")))
  (let* ((entry (aref (tabulated-list-get-entry) 0)))
    (if (keepass-mode-is-group-p entry)
        (user-error "%s is a group, not an entry" entry)
      (let ((full-path (keepass-mode-concat-group-path entry)))
        (keepass-mode-run-command `("edit" "--totp" ,secret ,keepass-mode-db ,full-path))
        (message "TOTP added to '%s%s'" keepass-mode-group-path entry)))))

(define-key keepass-mode-map (kbd "a") 'keepass-mode-add-entry)
(define-key keepass-mode-map (kbd "e") 'keepass-mode-edit-entry)
(define-key keepass-mode-map (kbd "d") 'keepass-mode-delete-entry)
(define-key keepass-mode-map (kbd "o") 'keepass-mode-add-totp)   ; 'o' for OTP

(provide 'keepass-mode)

;;; keepass-mode.el ends here
