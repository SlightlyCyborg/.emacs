
(setq ac-delay 0.2)
(setq ac-quick-help-delay 0.2)


(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
	      package-archives)
(push '("melpa" . "http://melpa.milkbox.net/packages/")
	      package-archives)
(package-initialize)


(defvar myPackages
	'())

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)


(setq inhibit-startup-message t)

(elpy-enable)
(require 'ein)
(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)


(show-paren-mode 1)

(require 'ggtags)
(require 'evil)
(evil-mode 1)


(add-to-list 'exec-path "/usr/local/bin")

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

(load-theme 'wheatgrass)

;; Set your lisp system and, optionally, some contribs
(setq inferior-lisp-program "/usr/local/bin/ccl64")
(setq slime-contribs '(slime-fancy))

(setq tab-width 2)
(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)


(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(require 'ido)
(ido-mode t)

(require 'helm-config)
(helm-mode 1)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(require 'flymake)

(defun flymake-php-init ()
  "Use php to check the syntax of the current file."
  (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
	 (local (file-relative-name temp (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local "-l"))))

(add-to-list 'flymake-err-line-patterns 
  '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

(add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))


(ac-config-default)


(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)


(add-to-list 'load-path "~/.emacs.d/vendor/arduino-mode")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
	 [default default default italic underline success warning error])
 '(ansi-color-names-vector
	 ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
	 (quote
		("dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "fc3ba70e150efbe45db40b4b4886fc75716b4f3b1247a4b96e5be7cfbe4bc9e1" default)))
 '(fringe-mode 6 nil (fringe))
 '(linum-format " %7d ")
 '(main-line-color1 "#191919")
 '(main-line-color2 "#111111")
 '(package-selected-packages
	 (quote
		(ipython zenburn-theme xpm web-mode twittering-mode tree-mode term+ slime s python purple-haze-theme php-mode paredit org markdown-mode jedi helm-projectile gtags goto-last-change ggtags flymake evil elpy ein cyberpunk-theme circe autopair arduino-mode ac-cider)))
 '(powerline-color1 "#191919")
 '(powerline-color2 "#111111")
 '(scroll-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)

;; when cursor is on edge, move to the other side, as in a torus space
(setq windmove-wrap-around t )

;Allow debugger to work without evil mode
(defun my-cider-debug-toggle-insert-state ()
  (if cider--debug-mode    ;; Checks if you're entering the debugger   
      (evil-insert-state)  ;; If so, turn on evil-insert-state
    (evil-normal-state)))  ;; Otherwise, turn on normal-state


(add-hook 'cider--debug-mode-hook 'my-cider-debug-toggle-insert-state)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)

(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'cider-repl-mode-hook #'paredit-mode)
(add-hook 'cider-repl-mode-hook
          '(lambda ()
             (define-key cider-repl-mode-map "{" #'paredit-open-curly)
             (define-key cider-repl-mode-map "}" #'paredit-close-curly)))


(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "C-w (") 'paredit-wrap-round)
     (define-key paredit-mode-map (kbd "C-w {") 'paredit-wrap-curly)
     (define-key paredit-mode-map (kbd "C-w [") 'paredit-wrap-square)))

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/"))

(require 'ob-clojure)
(require 'ob-sh)
(require 'ob-js)
(require 'ob-C)
(setq org-babel-clojure-backend 'cider)
(org-babel-do-load-languages 'org-babel-load-languages '((sh . t)))
(setq org-startup-with-inline-images t)
(setq truncate-lines 'nil)


(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

;; Poping-up contextual documentation
;;(eval-after-load "cider"
 ; '(define-key cider-mode-map (kbd "C-c C-d C-d") 'ac-nrepl-popup-doc))
(require 'twittering-mode)
(setq twittering-use-master-password t)
(add-hook 'term-mode-hook (lambda ()
                            (define-key term-raw-map (kbd "C-y") 'term-paste)))


(global-auto-revert-mode t)



(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"
				python-shell-interpreter-args "--simple-prompt -i"))
