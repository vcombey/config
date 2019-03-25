(require 'package)
(package-initialize)
					; list the packages you want
(setq package-list '(default-text-scale evil-collection magit-gerrit evil-numbers evil-string-inflection persp-mode default-text-scale helm-gtags haskell-mode key-chord evil base16-theme flycheck flycheck-rust cargo company racer evil evil-leader powerline magit helm evil-magit eyebrowse neotree))

					; list the repositories containing them
(setq package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(package-initialize)
					; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))
					; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package) (package-install package)))

(require 'evil-string-inflection)

(blink-cursor-mode 0)
(show-paren-mode 1)

(defun my-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen 'fullboth) ;this makes the frame go fullscreen
  (tool-bar-mode -1) ;these 3 lines turn off GUI junk
  (scroll-bar-mode -1)
  (menu-bar-mode -1))

(defun my-non-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen 'fullheight)
  (tool-bar-mode -1) ;these 3 lines turn off GUI junk
  (scroll-bar-mode -1)
  (menu-bar-mode -1))

(defun toggle-fullscreen ()
  (interactive)
  (if (eq (frame-parameter nil 'fullscreen) 'fullboth)  ;tests if already fullscreened
      (my-non-fullscreen)
    (my-fullscreen)))

(global-set-key (kbd "<f11>") 'toggle-fullscreen) 

(my-non-fullscreen)

(require 'persp-mode)
(persp-mode)
(persp-mode 1)

;;;; Package emacsrc
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
;(global-set-key persp-keymap-prefix (kbd "C-b"))
;(define-key persp-key-map (kbd ) ...).


;;Load Helm
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(require 'default-text-scale)
(default-text-scale-mode 1)

;(setq mode-require-final-newline nil)

;; A few default settings, just to make sure everything works alright
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")
(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
								64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))

(load-theme 'spacemacs-dark t)

;; Activates lines numbers
;;(add-hook 'prog-mode-hook (lambda() (linum-mode)))
;;(add-hook 'prog-mode-hook (lambda() (show-paren-mode)))

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

;; Load org mode
(require 'org-install)

;; Load evil-mode
(require 'evil-collection)
(evil-collection-init)
(require 'evil)
(evil-mode 1)
(evil-select-search-module 'evil-search-module 'evil-search)
;; Remaps C-space as the ESC key. (I need C-c for idiomatic emacs, but i just cant go back to hitting esc)
(evil-define-key 'insert 'evil-visual-state-map (kbd "C-a") 'beginning-of-line)
(evil-define-key 'normal 'evil-visual-state-map (kbd "C-x l") 'evil-window-right)
(evil-define-key 'normal 'evil-visual-state-map (kbd "C-x h") 'evil-window-left)
(evil-define-key 'normal 'evil-visual-state-map (kbd "C-x j") 'evil-window-down)
(evil-define-key 'normal 'evil-visual-state-map (kbd "C-x k") 'evil-window-up)
;; (evil-define-key 'normal 'evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
;; (evil-define-key 'insert 'evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(evil-define-key 'insert 'evil-visual-state-map (kbd "C-d") 'evil-scroll-down)
(evil-define-key 'replace 'evil-replace-state-map (kbd "C-@") 'evil-force-normal-state)
  (require 'neotree)
    (setq neo-smart-open t)
(evil-define-key 'normal 'evil-replace-state-map (kbd "C-n") 'neotree-toggle)
 (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(setq evil-ex-search-case 'sensitive)


(require 'evil-numbers)
(define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer)

(require 'evil-magit)
 (setq evil-magit-state 'normal)
(global-set-key (kbd "C-x g") 'magit-status)

(require 'magit-gerrit)

(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map  "jk" 'evil-normal-state)

;; Powerline,powerline
(require 'powerline)
(powerline-center-evil-theme)

;;
;; Loading theme depending on GUI or term
;;(if (display-graphic-p)
;;	(load-theme 'nord 'NO-CONFIRM)
;;  (progn
;;	(load-theme 'atom-dark 'NO-CONFIRM)
;;	(setq atom-dark-theme-force-faces-for-mode nil)
;;	)
;;  )
;;

;;;; Do not show the startup screen
;;(setq inhibit-startup-screen t)
;;
;; Putting font
;(set-default-font "Roboto Mono Medium for Powerline-11")
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
(defun my-asm-mode-hook ()
  ;; you can use `comment-dwim' (M-;) for this kind of behaviour anyway
  (local-unset-key (vector asm-comment-char))
  ;; asm-mode sets it locally to nil, to "stay closer to the old TAB behaviour".
  (setq tab-always-indent (default-value 'tab-always-indent)))

(add-hook 'asm-mode-hook #'my-asm-mode-hook)

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

;;
;;Little function to compile projecting looking for the closest makefile in the FS

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
(add-hook 'after-init-hook 'global-company-mode)
(setq company-auto-complete t)
(eval-after-load 'company
  '(progn
	 (define-key company-active-map (kbd "C-n") 'company-complete-common-or-cycle)
	 (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
	 (define-key company-active-map (kbd "<tab>") 'company-complete-common)))
(setq company-idle-delay nil)
; Make company aware of merlin
(with-eval-after-load 'company
 (add-to-list 'company-backends 'merlin-company-backend))

; Enable company on merlin managed buffers
(add-hook 'merlin-mode-hook 'company-mode)
(add-hook 'haskell-mode-hook (lambda () (set (make-local-variable 'company-backends)
                 (append '((company-capf company-dabbrev-code))
                         company-backends))))
; Or enable it globally:
; (add-hook 'after-init-hook 'global-company-mode)

(evil-define-key 'insert 'evil-insert-state-map (kbd "C-n") 'company-complete)
(evil-define-key 'insert 'evil-insert-state-map (kbd "C-p") 'company-complete)



					;;company is for completion
(setq racer-cmd "~/.cargo/bin/racer") ;; Rustup binaries PATH
;(setq racer-rust-src-path "~/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src") ;; Rust source code PATH
(setq racer-rust-src-path "~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src") ;; Rust source code PATH
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'rust-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c TAB") #'rust-format-buffer)))
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(setq rust-format-on-save t)


(package-install 'exec-path-from-shell)
(exec-path-from-shell-initialize)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(setq evil-emacs-state-modes (delq 'ibuffer-mode evil-emacs-state-modes))
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
;;;OCAML
;;(setq vc-follow-symlinks t)
;; (load "/Users/vcombey/.opam/ocaml-base-compiler.4.07.0/share/emacs/site-lisp/tuareg-site-file")
;;(add-hook 'tuareg-mode-hook #'(lambda() (setq mode-name "🐫")))
;; (let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
;;      (when (and opam-share (file-directory-p opam-share))
;;       ;; Register Merlin
;;       (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
;;       (autoload 'merlin-mode "merlin" nil t nil)
;;       ;; Automatically start it in OCaml buffers
;;       (add-hook 'tuareg-mode-hook 'merlin-mode t)
;;       (add-hook 'caml-mode-hook 'merlin-mode t)
;;       ;; Use opam switch to lookup ocamlmerlin binary
;;       (setq merlin-command 'opam)))
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "~/src/linux-trees")
                                       filename))
                (setq indent-tabs-mode t)
                (setq show-trailing-whitespace t)
                (c-set-style "linux-tabs-only")))))


(add-hook 'tuareg-mode-hook 'merlin-mode)
;*******************************************************************************;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comment-style (quote extra-line))
 '(custom-safe-themes
   (quote
	("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "542e6fee85eea8e47243a5647358c344111aa9c04510394720a3108803c8ddd1" "6271fc9740379f8e2722f1510d481c1df1fcc43e48fa6641a5c19e954c21cc8f" "d9dab332207600e49400d798ed05f38372ec32132b3f7d2ba697e59088021555" "f2dd097452b79276ce522df2f8aeb37f6d90f504529616aa46122d549910e46d" "527df6ab42b54d2e5f4eec8b091bd79b2fa9a1da38f5addd297d1c91aa19b616" "7527f3308a83721f9b6d50a36698baaedc79ded9f6d5bd4e9a28a22ab13b3cb1" "e9460a84d876da407d9e6accf9ceba453e2f86f8b86076f37c08ad155de8223c" "d494af9adbd2c04bec4b5c414983fefe665cd5dadc5e5c79fd658a17165e435a" "c4bd8fa17f1f1fc088a1153ca676b1e6abc55005e72809ad3aeffb74bd121d23" "b85fc9f122202c71b9884c5aff428eb81b99d25d619ee6fde7f3016e08515f07" "b34636117b62837b3c0c149260dfebe12c5dad3d1177a758bb41c4b15259ed7e" "c158c2a9f1c5fcf27598d313eec9f9dceadf131ccd10abc6448004b14984767c" default)))
 '(doc-view-continuous t)
 '(global-company-mode nil)
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(package-selected-packages
   (quote
	(evil-collection flycheck-pos-tip
					 (\, evil-numbers)
					 magit-gerrit spacemacs-theme evil-number evil-numbers persp-mode perspective tmux-pane helm-gtags json-mode haskell-emacs nasm-mode key-chord exec-path-from-shell neotree powerline-evil base16-theme flycheck-rust flycheck evil-leader cargo eyebrowse auto-dim-other-buffers company-irony-c-headers company-irony helm-ag atom-dark-theme slime-company slime irony vagrant dockerfile-mode yaml-mode enh-ruby-mode projectile-rails helm-projectile ibuffer-projectile projectile ggtags php-mode racer babel company ac-helm auto-complete seoul256-theme moe-theme rust-mode async-await helm nord-theme subatomic-theme subatomic256-theme xterm-color green-phosphor-theme magit evil)))
 '(persp-mode t nil (persp-mode))
 '(ring-bell-function (quote ignore))
 '(scroll-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
