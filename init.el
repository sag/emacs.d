(setq inhibit-startup-message t)

(add-to-list 'load-path "~/.emacs.d/hasktags-emacs")
(load "hasktags")

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed 
  'iedit 
  'magit 
  'evil 
  'color-theme 
  'ghc 
  'clojure-mode  
  'lein 
  'clojure-test-mode 
  'cider)


(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
 ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
 ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(evil-mode 1)

(color-theme-initialize)
(color-theme-charcoal-black)


;;(add-hook 'haskell-mode-hook 'flymake-haskell-multi-load)


;;;;;;;;;;;;;;;;;;;;; Layouts;;;;;;;



(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)



;; Don't ring the bell
(setq ring-bell-function 'ignore)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Clojure Config
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode) 


;; ido

(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching t) ; fuzzy matching is a must have
(setq ido-enable-prefix nil)



(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
				   '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))


;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)
;;

(setq make-backup-files nil)

;; projectile
;;
;;
(projectile-global-mode)


;; find things 
(global-set-key [(super shift f)] 'projectile-find-file)

(global-set-key [(super shift p)] nil)
(global-set-key [(super  p)] nil)
;;; font


 (set-default-font "-apple-PragmataPro-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1")
 (global-linum-mode 1)
 (setq linum-format "%d ")
