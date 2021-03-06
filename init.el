;;; init.el --- Initialization file

;;; Commentary:
;;  This is NOT part of GNU Emacs.  It's a personal project of Emacs configuration.
;;  Written by (c) Cabins Kong.  2019-2020.

;;; Code:
(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "lisp/")))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(setq default-directory "d:/")  ;;set the default-directory

(require 'init-consts)
(require 'init-startup)
(require 'init-elpa)
(require 'init-package)
(require 'init-kbd)
(require 'init-misc)
(require 'init-program)
(require 'init-ui)
(require 'interactive-funcs)
(require 'maple-minibuffer)
(require 'cdlatex)
(require 'latex)

(when (file-exists-p custom-file)
  (load-file custom-file))

;;; init.el ends here
(put 'narrow-to-region 'disabled nil)
