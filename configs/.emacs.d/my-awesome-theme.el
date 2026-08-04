;;; my-awesome-theme.el --- My theme -*- lexical-binding: t; -*-

;; Copyright (C) 2026 benja2998


;; Author: benja2998 <benja2998@proton.me>
;; Maintainer: benja2998 <benja2998@proton.me>
;; Created: 2 August 2026
;; Version: 1.0.0

;; Keywords: faces
;; URL: https://codeberg.org/benja2998/dotfiles

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
;; theme

;;; Code:

(defvar my-awesome-palette
  '((cursor "#fcfcfc")
    (bg-main "#202326")
    (bg-dim "#202326")
    (bg-active "#33383d")
    (bg-inactive "#33383d")
    (fg-dim "#525961")    
    (bg-dim "#1e2023")

    (bg-term-black "#393939")
    (fg-term-black "#393939")
    (bg-term-black-bright "#393939")
    (fg-term-black-bright "#393939")        

    (black-warmer "#393939")
    (blue-warmer "#4677ff")
    (cyan-warmer "#5bc6f3")
    (green-warmer "#98cb76")
    (magenta-warmer "magenta3")
    (red-warmer "#ff0000")
    (white-warmer "#e5e5e5")
    (yellow-warmer "yellow3")

    (black-cooler "#393939")
    (blue-cooler "#4677ff")
    (cyan-cooler "#5bc6f3")
    (green-cooler "#98cb76")
    (magenta-cooler "magenta3")
    (red-cooler "#ff0000")
    (white-cooler "#e5e5e5")
    (yellow-cooler "yellow3")

    (black-faint "#393939")
    (blue-faint "#4677ff")
    (cyan-faint "#5bc6f3")
    (green-faint "#98cb76")
    (magenta-faint "magenta3")
    (red-faint "#ff0000")
    (white-faint "#e5e5e5")
    (yellow-faint "yellow3")        
    
    (black "#393939")
    (blue "#4677ff")
    (black-intense "#393939")
    (blue-intense "#4677ff")
    (cyan-intense "#5bc6f3")
    (green-intense "#98cb76")
    (magenta-intense "magenta3")
    (red-intense "#ff0000")
    (white-intense "#e5e5e5")
    (yellow-intense "yellow3")
    (cyan "#5bc6f3")
    (green "#98cb76")
    (magenta "magenta3")
    (red "#ff0000")
    (white "#e5e5e5")

    (bg-term-white "#e5e5e5")
    (bg-term-white-bright "#e5e5e5")
    (fg-term-white "#e5e5e5")
    (fg-term-white-bright "#e5e5e5")

    (bg-mode-line-active "#191c1e")
    (bg-mode-line-inactive "#1d2123")

    (border-mode-line-active "#191c1e")
    (border-mode-line-inactive "#1d2123")
    
    (fg-mode-line-active "#fcfcfc")
    (fg-mode-line-inactive "#fcfcfc")
    
    (yellow "yellow3")
    (fg-main "#fcfcfc")

    (bg-paren-match "#ff0000")
    (fg-heading-0 "#ff0000")
    (fg-heading-1 "#ff0000")
    (fg-heading-2 "#ff0000")
    (fg-heading-3 "#ff0000")
    (fg-heading-4 "#ff0000")
    (fg-heading-5 "#ff0000")
    (fg-heading-6 "#ff0000")
    (fg-heading-7 "#ff0000")
    (fg-heading-8 "#ff0000")
    (bg-button-active "#ff0000")
    (bg-button-inactive "#191c1e")
    (fg-button-active "#fcfcfc")
    (fg-button-inactive "#fcfcfc")

    (bracket "#ff0000")
    (delimiter "#ff0000")
    (docmarkup "coral")
    (number "orange red")
    (comment "#525961")
    (builtin "coral")
    (constant "#ff0000")
    (docstring "#ff0000")
    (fnname "coral")
    (fnname-call "orange red")
    (keyword "#ff0000")
    (property "orange red")
    (rx-backslash "coral")
    (rx-construct "coral")
    (string "#ff0000")
    (type "orange red")
    (variable "coral")
    (variable-use "coral")
    (accent-0 "#ff0000")
    (accent-1 "#ff0000")
    (accent-2 "#ff0000")
    (accent-3 "#ff0000")

    (fg-completion-match-0 "#ff0000")
    (fg-completion-match-1 "#ff0000")
    (fg-completion-match-2 "#ff0000")
    (fg-completion-match-3 "#ff0000")    

    (date-common "coral")
    (date-deadline "#ff0000")
    (date-deadline-subtle "coral")
    (date-event "orange red")
    (date-holiday "coral")
    (date-holiday-other "orange")
    (date-range "#ff0000")
    (date-scheduled "#ff0000")
    (date-scheduled-subtle "coral")
    (date-weekday "coral")
    (date-weekend "orange red")
    (fg-link "#ff0000")
    (underline-link "#ff0000")
    (fg-link-symbolic "#ff0000")
    (underline-link-symbolic "#ff0000")
    (mail-cite-0 "coral")
    (mail-cite-1 "orange red")
    (mail-cite-2 "orange")
    (mail-cite-3 "gold")
    (mail-part "#ff0000")
    (mail-recipient "#ff0000")
    (mail-subject "#ff0000")
    (mail-other "#ff0000")
    (fg-prompt "#ff0000")
    (fg-prose-code "coral")
    (fg-prose-macro "#ff0000")
    (fg-prose-verbatim "orange")
    (prose-done "#ff0000")
    (prose-todo "orange red")
    (fg-alt "#ff0000")

    (keybind "#ff0000")
    (info "gold")
    (warning "orange")

    (name "#ff0000")

    (bg-region "#343a3f")

    (identifier "coral")    
    )
  "Like `modus-vivendi-palette'.")

(modus-themes-theme
 'my-awesome
 'my-awesome
 "My awesome theme."
 'dark
 'modus-vivendi-palette
 'my-awesome-palette
 nil)

(provide 'my-awesome)

;;; my-awesome-theme.el ends here
