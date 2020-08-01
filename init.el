;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; base emacs settings

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; hide UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; package initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)


  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))
(add-hook 'after-init-hook 'global-company-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; editing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(electric-pair-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evil mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; evil variables
(setq evil-want-C-u-scroll t)
(setq-default evil-escape-key-sequence "jk")
(setq-default evil-escape-delay 0.2)

;; require evil
(use-package evil)
(require 'evil)

(use-package evil-org)
(require 'evil-org)

(use-package evil-escape)

(use-package evil-leader)
(require 'evil-leader)

(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

(defun split-vertically-and-switch ()
  (interactive)
  (split-window-horizontally)
   (balance-windows)
   (other-window 1))

(evil-leader/set-key

  ;; window shortcuts
  "\\" 'split-vertically-and-switch
  "-" '(lambda () (interactive)
	 (split-window-vertically)
	 (balance-windows)
	 (other-window 1))
  "h" 'evil-window-left
  "l" 'evil-window-right
  "j" 'evil-window-down
  "k" 'evil-window-up

  ;; config file shortcuts
  "cee" (lambda () (interactive)
	  (find-file "~/.emacs.d/init.el"))
  "cev" (lambda () (interactive)
	  (split-window-horizontally)
	  (other-window 1)
	  (find-file "~/.emacs.d/init.el"))
  "cs" (lambda () (interactive)(load "~/.emacs.d/init.el"))

  ;; org file shortcuts
  "oie" (lambda () (interactive)(find-file "~/.emacs.d/org/index.org"))
  "oiv" (lambda () (interactive)
	  (split-window-horizontally)
	  (other-window 1)
	  (find-file "~/.emacs.d/org/index.org")))

;; org mode keybindings
(evil-define-key 'normal org-mode-map
  (kbd "ENTER") 'org-follow-link)

(evil-mode 1)
(evil-escape-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; fonts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-face-attribute 'default nil :family "JetBrains Mono" :height 120)
(set-face-attribute 'fixed-pitch nil :family "JetBrains Mono" :height 120)
(set-face-attribute 'variable-pitch nil :family "Spectral" :height 130)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flycheck
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flycheck
  :commands global-flycheck-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; golang mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package go-mode)

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; helm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helm)
(require 'helm-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ivy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ivy)
					;(ivy-mode 1)
					;(setq ivy-use-virtual-buffers t)
					;(setq enable-recursive-minibuffers t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package olivetti)

(setq org-indent-indentation-per-level 1)
(setq org-hide-leading-stars t)
(setq org-hide-emphasis-markers t)
(customize-set-variable 'org-blank-before-new-entry 
                        '((heading . nil)
                          (plain-list-item . nil)))
(setq org-cycle-separator-lines 1)

(defun customize-org-mode ()
  (interactive)
  (variable-pitch-mode 1)
  (olivetti-mode 1))

(add-hook 'org-mode-hook
	  'customize-org-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; projectile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package base16-theme )
(use-package poet-theme)

;(load-theme 'leuven t)
;(load-theme 'base16-onedark t)
;(load-theme 'base16-monokai t)
;(load-theme 'base16-gruvbox-dark-pale t)
(load-theme 'poet-dark t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 1)
 '(company-tooltip-minimum-width 0)
 '(custom-safe-themes
   (quote
    ("28a104f642d09d3e5c62ce3464ea2c143b9130167282ea97ddcc3607b381823f" default)))
 '(global-company-mode t)
 '(org-blank-before-new-entry (quote ((heading) (plain-list-item))))
 '(package-selected-packages
   (quote
    (evil-org use-package projectile powerline poet-theme olivetti lsp-ui ivy helm go-mode flycheck evil-leader evil-escape company-posframe company-go base16-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-echo-common ((t (:foreground "white"))))
 '(company-preview ((t (:background "gray10" :foreground "wheat"))))
 '(company-preview-common ((t (:inherit company-preview :foreground "white"))))
 '(company-scrollbar-bg ((t (:background "white"))))
 '(company-scrollbar-fg ((t (:background "gray10"))))
 '(company-tooltip ((t (:background "black" :foreground "white" :family "JetBrains Mono"))))
 '(company-tooltip-annotation ((t (:foreground "white"))))
 '(company-tooltip-common ((t (:foreground "dark gray"))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-common))))
 '(company-tooltip-selection ((t (:background "gray10")))))
