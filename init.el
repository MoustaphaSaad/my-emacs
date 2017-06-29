
;;Sets the window title to emacs
(setq frame-title-format "emacs")

;;make emacs replace selected text
(delete-selection-mode 1)

;;removes menu bar
(menu-bar-mode -1)

;;removes tool bar
(tool-bar-mode -1)

;;removes scroll bar
(scroll-bar-mode -1)

;;remove welcome screen
(setq inhibit-startup-screen t)

;;make tab insert literal \t
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(defun my-insert-tab-char ()
  "Insert a tab char. (ASCII 9, \t)"
  (interactive)
  (insert "\t"))

(global-set-key (kbd "TAB") 'my-insert-tab-char)

;;make home ignore whitespace at the beginning of line
(defun smart-line-beginning ()
  "Move point to the beginning of text on the current line; if that is already
the current position of point, then move it to the beginning of the line."
  (interactive "^")
  (let ((pt (point)))
    (beginning-of-line-text)
    (when (eq pt (point))
      (beginning-of-line))))
(global-set-key (kbd "<home>") 'smart-line-beginning)

;;enables emacs navigation: files, buffers...etc
(require 'ido)
(ido-mode 1)

;;set C-p to find file inside project
(global-set-key (kbd "C-p") 'helm-projectile-find-file)
;;set C-b to switch open buffers
(global-set-key (kbd "C-b") 'ido-switch-buffer)

;;set C-o to switch projects
(global-set-key (kbd "C-o") 'helm-projectile-switch-project)

;;set C-a to select whole buffer
(global-set-key (kbd "C-a") 'mark-whole-buffer)

;;set escape key to quit current command
;;(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;;(define-key minibuffer-local-map "<escape>" 'keyboard-escape-quit)

;;get rid of the annoying bell
(setq ring-bell-function 'ignore)

;;set search-forward-regexp as default
(global-set-key (kbd "C-f") 'isearch-forward-regexp)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)

;;set save to C-s
(global-set-key (kbd "C-s") 'save-buffer)

;;set eval-buffer to C-e
(global-set-key (kbd "C-e") 'eval-buffer)

;;iedit mode
(define-key global-map (kbd "C-c ;") 'iedit-mode)
(define-key global-map (kbd "C-;") 'iedit-mode-toggle-on-function)

;;shows line number
(column-number-mode 1)

;;highlights matching parens
(show-paren-mode 1)

;;highlights the line you edit
(global-hl-line-mode 1)

;;undo/redo window configs
(winner-mode t)

;;split the window into two
(split-window-horizontally)
;;keybindings for moving between windows
(define-key global-map (kbd "\eo") 'other-window)

;;emacs package-manager
(require 'package)
;;adds melpa
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
;;adds marmalade
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)

;;start auto-complete
(require 'auto-complete)
;;default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

;;set undo/redo buttons
(require 'undo-tree)
(global-undo-tree-mode 1)
;;make ctrl-z undo
(global-set-key (kbd "C-z") 'undo)
;;make ctrl-Z redo
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-S-z") 'redo)

(require 'helm-config)

(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

(require 'helm-projectile)
(helm-projectile-on)

(add-hook 'text-mode-hook '(lambda() (turn-on-auto-fill) (set-fill-column 80)))

;;casey style
(defconst casey-big-fun-c-style
  '((c-electric-pound-behavior   . nil)
    (c-tab-always-indent         . t)
    (c-comment-only-line-offset  . 0)
    (c-hanging-braces-alist      . ((class-open)
                                    (class-close)
                                    (defun-open)
                                    (defun-close)
                                    (inline-open)
                                    (inline-close)
                                    (brace-list-open)
                                    (brace-list-close)
                                    (brace-list-intro)
                                    (brace-list-entry)
                                    (block-open)
                                    (block-close)
                                    (substatement-open)
                                    (statement-case-open)
                                    (class-open)))
    (c-hanging-colons-alist      . ((inher-intro)
                                    (case-label)
                                    (label)
                                    (access-label)
                                    (access-key)
                                    (member-init-intro)))
    (c-cleanup-list              . (scope-operator
                                    list-close-comma
                                    defun-close-semi))
    (c-offsets-alist             . ((arglist-close         .  c-lineup-arglist)
                                    (label                 . -4)
                                    (access-label          . -4)
                                    (substatement-open     .  0)
                                    (statement-case-intro  .  4)
                                    (statement-block-intro .  c-lineup-for)
                                    (case-label            .  4)
                                    (block-open            .  0)
                                    (inline-open           .  0)
                                    (topmost-intro-cont    .  0)
                                    (knr-argdecl-intro     . -4)
                                    (brace-list-open       .  0)
                                    (brace-list-intro      .  4)))
    (c-echo-syntactic-information-p . t))
"Casey's Big Fun C++ Style")

(defun my:cc-config ()
  	 (c-add-style "BigFun" casey-big-fun-c-style t)
  
  	(setq-default indent-tabs-mode t)
	(setq-default tab-width 4)
  (defun my-insert-tab-char ()
  	"Insert a tab char. (ASCII 9, \t)"
  	(interactive)
  	(insert "\t"))

  (global-set-key (kbd "TAB") 'my-insert-tab-char)

  (turn-on-auto-fill) (set-fill-column 80)
)
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:cc-config)
(add-hook 'c-mode-hook 'my:cc-config)

(semantic-mode 1)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;;set C-B to build debug mode
(setq projectile-project-compilation-cmd "bld all dsh64")
(define-key projectile-mode-map (kbd "C-S-b") 'projectile-compile-project)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(org function-args helm-projectile projectile yasnippet-bundle yasnippet undo-tree iedit helm auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
