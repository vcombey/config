;; Conditionally loads the local site-lisp folder containing 42header ressources
;;(if (string= (shell-command-to-string "printf %s $(uname -s)") "Darwin")
	;;(setq config_files "/usr/share/emacs/site-lisp/")
  ;;(setq config_files (concat (getenv "DOTFILES") "/emacs/site-lisp/")))
;;(setq vc-follow-symlinks t)
;; Sourcing packages necessary for 42 header
;;(setq config_files "/usr/share/emacs/site-lisp/")
;;(setq load-path (append (list nil config_files) load-path))
;;(load "list.el") (load "string.el") (load "comments.el")
;;(load "header.el")

					; list the packages you want
(setq package-list '(evil powerline magit helm org-install))

					; list the repositories containing them
(setq package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")))

					; activate all the packages (in particular autoloads)
(package-initialize)

					; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

					; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;; A few default settings, just to make sure everything works alright
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")
(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
								64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))

;; Activates lines numbers
(add-hook 'prog-mode-hook (lambda() (linum-mode)))
(add-hook 'prog-mode-hook (lambda() (show-paren-mode)))

;; NEED MY FUCKING TABS
;; (add-hook 'prog-mode-hook (lambda() (local-set-key (kbd "TAB") 'self-insert-command)))
(add-hook 'prog-mode-hook (lambda() (local-set-key (kbd "TAB") 'tab-to-tab-stop)))

;; Enables highlight mode
(global-font-lock-mode)
(global-hi-lock-mode)

;; Every file is sent to this backup directory
(setq backup-directory-alist
	  `((".*" . "~/.emacs.d")))
(setq auto-save-file-name-transforms
	  `((".*" ,"~/.emacs.d" t)))

;; Sourcing my modes a d packages init
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

;; Load Helm
;; (require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)

;; Load org mode
(require 'org-install)

;; Load evil-mode
(require 'evil)
(evil-mode 1)
(evil-select-search-module 'evil-search-module 'evil-search)

;; Powerline,powerline
(require 'powerline)
(powerline-center-evil-theme)

;; Remaps C-space as the ESC key. (I need C-c for idiomatic emacs, but i just cant go back to hitting esc)
(evil-define-key 'insert 'evil-insert-state-map (kbd "jk") 'evil-force-normal-state)
(evil-define-key 'visual 'evil-visual-state-map (kbd "C-@") 'evil-force-normal-state)
(evil-define-key 'replace 'evil-replace-state-map (kbd "C-@") 'evil-force-normal-state)

;; Disable toolbar mode in GUI emacs
(if (display-graphic-p)
	(progn ((tool-bar-mode -1)
			(menu-bar-mode -1)
			(scroll-bar-mode -1)))
  )

(load-theme 'atom-dark 'NO-CONFIRM)

;;
;;;; Loading theme depending on GUI or term
;;(if (display-graphic-p)
	;;(load-theme 'nord 'NO-CONFIRM)
  ;;(progn
	;;(load-theme 'atom-dark 'NO-CONFIRM)
	;;(setq atom-dark-theme-force-faces-for-mode nil)
	;;)
  ;;)
;;

;;;; Do not show the startup screen
;;(setq inhibit-startup-screen t)
;;
;;;; Putting font
;;(set-default-font "Roboto Mono Medium for Powerline-11")
;;
;;;; Scroll settings
(setq scroll-margin 3
	  scroll-conservatively 10000
	  scroll-step 1)
;;
;;;;; Functions
;;;; Defining a few of my own functions
;;
;;(defun surround-region-with-paren ()
  ;;"Surrounds the active region with parentheses by killing the region, inserting parens and reinserting the region kill-ring inside"
  ;;(interactive) 
  ;;(progn
	;;(call-interactively 'kill-region)
	;;(insert "(")
	;;(insert (car kill-ring))
	;;(insert ")")))
;;
;;(evil-define-key 'visual 'evil-visual-state-map (kbd "(") 'surround-region-with-paren)
;;
;;
;;;; Setting up c comment with 42 style
;;(setq c-block-comment-prefix "** ")
;;

;;Setting up a hack for system clipboard in emacs
(if (string= (shell-command-to-string "printf %s $(uname -s)") "Darwin")
	(defun paste-from-system-clipboard ()
	  (interactive)
	  (insert (shell-command-to-string "pbpaste")))
  (defun paste-from-system-clipboard ()
	(interactive)
	(insert (shell-command-to-string "xsel --clipboard --output"))))

(if (string= (shell-command-to-string "printf %s $(uname -s)") "Darwin")
	(defun copy-region-to-system-clipboard ()
	  (interactive)
	  (call-interactively 'shell-command-on-region '"pbcopy"))
  (defun copy-region-to-system-clipboard ()
	(interactive)
	(call-interactively 'shell-command-on-region '"xsel --clipboard --input")))

;; Compile options
(setq compilation-scroll-output 1)
;;

;;;; Magit bind
;;(global-set-key (kbd "M-g") 'magit-status)

Little function to compile projecting looking for the closest makefile in the FS

(defun my-make()
  (interactive)
  (let ((makefile-dir (locate-dominating-file "." "makefile")))
	(if makefile-dir
		(progn
		  (print (format "Found Makefile in %s" makefile-dir))
		  (compile (read-string
					"Insert make options: " (format "make -C %s " makefile-dir))))
	  (print "Makefile not found"))))

(defun shell-command-current-file ()
  "Invokes the requested shell command with path current file as argument and displays it in a buffer"
  (interactive)
  (if (buffer-file-name)
	  (shell-command (format "%s %s" (read-string "Program to invoke with current file as argument: ") (buffer-file-name)))
	(print "No file is currently open")))

(defun shell-command-current-file-to-string ()
  "Invokes the requested shell command with path current file as argument and returns it as a string"
  (interactive)
  (if (buffer-file-name)
	  (shell-command-to-string (format "%s %s" (read-string "Program to invoke with current file as argument: ") (buffer-file-name)))
	(print "No file is currently open")))

;;;; No prompt to kill buffer when theres a process running
;;(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

;;;; Ruby mode
;;(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
;;(setq ruby-indent-level 2)
;;(global-auto-revert-mode t)
;;
;;;; ;; Set your lisp system and, optionally, some contribs
;;;; (setq inferior-lisp-program (concat (getenv "HOME") "/.sbcl/bin/sbcl"))
;;;; (setq slime-contribs '(slime-fancy))
;;;; (slime-setup '(slime-fancy slime-company))
;;
;;;;;;;;;;; AUTO COMPLETE ;;;;;;;;;;;;;;;;;
;;(add-hook 'after-init-hook 'global-company-mode)
;;(setq company-auto-complete t)
;;(eval-after-load 'company
  ;;'(progn
	 ;;(define-key company-active-map (kbd "C-n") 'company-complete-common-or-cycle)
	 ;;(define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
	 ;;(define-key company-active-map (kbd "<tab>") 'company-complete-common)))
;;(evil-define-key 'insert 'evil-insert-state-map (kbd "C-n") 'company-complete)
;;(evil-define-key 'insert 'evil-insert-state-map (kbd "C-p") 'company-complete)
;;
;;(add-hook 'rust-mode-hook #'racer-mode)
;;(add-hook 'racer-mode-hook #'eldoc-mode)
;;(setq evil-emacs-state-modes (delq 'ibuffer-mode evil-emacs-state-modes))
;;
;;(add-hook 'ibuffer-hook
    ;;(lambda ()
      ;;(ibuffer-projectile-set-filter-groups)
      ;;(unless (eq ibuffer-sorting-mode 'alphabetic)
        ;;(ibuffer-do-sort-by-alphabetic))))
;;(evil-ex-define-cmd "ls" 'ibuffer)
;;;; Projectile with native indexing cus external doesnt ignore files ...
;;(projectile-mode)
;;(setq projectile-indexing-method 'native)
;;(setq projectile-globally-ignored-file-suffixes (list ".o"))
;;;; Auto revert + auto revert with version control (allows to check branch within magit without issue)
;;(auto-revert-mode t)
;;(setq auto-revert-check-vc-info t)
;;
;;(defun create-tags (dir-name)
    ;;"Create tags file."
    ;;(interactive "DDirectory: ")
    ;;(async-shell-command
     ;;(format "%s -f %s -e -R %s" "ctags" (concat
										  ;;(read-directory-name "Save TAGS to directory: " default-directory default-directory nil nil)
										  ;;"TAGS")
			 ;;(directory-file-name dir-name)))
  ;;)
;;
;;(defun projectile-create-tags ()
  ;;"Create tag file for the current projectile project"
  ;;(interactive)
    ;;(async-shell-command
     ;;(format "%s -f %s -e -R %s" "ctags" (concat (projectile-project-root) "TAGS") (projectile-project-root)))
  ;;)
 ;;;; (setq helm-projectile-fuzzy-match nil)
;;;; (require 'helm-projectile)
;;(helm-projectile-on) 
;;
;;(add-hook 'c++-mode-hook 'irony-mode)
;;(add-hook 'c-mode-hook 'irony-mode)
;;(add-hook 'objc-mode-hook 'irony-mode)
;;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;;
;;;; Load with `irony-mode` as a grouped backend
;;(eval-after-load 'company
  ;;'(add-to-list
    ;;'company-backends '(company-irony-c-headers company-irony)))
;;
 ;;
;;(setq tags-add-tables nil)
;;
;;(add-hook 'after-init-hook (lambda ()
  ;;(when (fboundp 'auto-dim-other-buffers-mode)
    ;;(auto-dim-other-buffers-mode t))))
;;
					; list the packages you want
(setq package-list '(evil magit org-install powerline))

					; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")))

					; activate all the packages (in particular autoloads)
(package-initialize)

					; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

					; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;*******************************************************************************;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comment-style (quote extra-line))
 '(custom-safe-themes
   (quote
	("e9460a84d876da407d9e6accf9ceba453e2f86f8b86076f37c08ad155de8223c" "d494af9adbd2c04bec4b5c414983fefe665cd5dadc5e5c79fd658a17165e435a" "c4bd8fa17f1f1fc088a1153ca676b1e6abc55005e72809ad3aeffb74bd121d23" "b85fc9f122202c71b9884c5aff428eb81b99d25d619ee6fde7f3016e08515f07" "b34636117b62837b3c0c149260dfebe12c5dad3d1177a758bb41c4b15259ed7e" "c158c2a9f1c5fcf27598d313eec9f9dceadf131ccd10abc6448004b14984767c" default)))
 '(global-company-mode nil)
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(package-selected-packages
   (quote
	(auto-dim-other-buffers company-irony-c-headers company-irony helm-ag atom-dark-theme slime-company slime irony vagrant dockerfile-mode yaml-mode enh-ruby-mode projectile-rails helm-projectile ibuffer-projectile projectile ggtags php-mode racer babel company ac-helm auto-complete seoul256-theme moe-theme rust-mode async-await helm nord-theme subatomic-theme subatomic256-theme xterm-color green-phosphor-theme magit evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
