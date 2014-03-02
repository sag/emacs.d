
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

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

(ensure-package-installed 'iedit 'magit 'evil 'color-theme)


(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
 (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
 ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
 ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(evil-mode 1)

(color-theme-initialize)
(color-theme-charcoal-black)


(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))
