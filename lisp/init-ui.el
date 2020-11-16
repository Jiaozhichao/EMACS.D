;;; init-ui.el --- settings for the Emacs UI

;;; Commentary:
;;; (c) Cabins, github.com/cabins/.emacs.d

    ;;; Code:

(set-frame-parameter nil 'alpha 0.98)


;; ;; Settings for UI theme
(use-package doom-themes
  :init (load-theme 'doom-wilmersdorf t))
  
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))
 
 (use-package all-the-icons-dired
  :ensure t)
 
(use-package all-the-icons-ivy)
(setq all-the-icons-scale-factor 1.0)
(defun all-the-icons-ivy-icon-for-file (s)
  "Return icon for filename S.
Return the octicon for directory if S is a directory.
Otherwise fallback to calling `all-the-icons-icon-for-file'."
  (cond
   ((string-match-p "\\/$" s)
    (all-the-icons-octicon "file-directory" :face 'all-the-icons-ivy-dir-face))
   (t (all-the-icons-icon-for-file s :v-adjust 0.02))))
(defun all-the-icons-ivy--icon-for-mode (mode)
  "Apply `all-the-icons-for-mode' on MODE but either return an icon or nil."
  (let ((icon (all-the-icons-icon-for-mode mode :v-adjust 0.02)))
    (unless (symbolp icon)
      icon)))
(all-the-icons-ivy-setup)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
 

;;;;Function to set monofonts
(defun cabins/set-monospaced-font (english chinese e-size c-size)
  "cabins/set-monospaced-font is used for setting monospaced font"
  (set-face-attribute 'default nil
                      :font (font-spec
                             :name english
                             :weight 'normal
                             :slant 'normal
                             :size e-size))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec
                       :name chinese
                       :weight 'normal
                       :slant 'normal
                       :size c-size))))

(when (display-graphic-p)
  (if *is-windows*
      ;; font setting for Windows platform
      (cabins/set-monospaced-font "Noto Mono" "Rubik" 20 20))
  (if *is-mac*
      ;; font setting for macOS platform
      (cabins/set-monospaced-font "Monaco" "Helvetica" 18 18))
  (if *is-linux*
      ;; font setting for GNU/Linux platform
      (cabins/set-monospaced-font "Monaco" "Helvetica" 13 13))
  )


;; Font settings
(use-package emacs
  :when (display-graphic-p)
  :config
  (set-default 'cursor-type 'bar)
  ;; I prefer the cursor be red color, 'cause it's more obvious.
  (set-face-background 'cursor "#FF0000")
  (setq-default scroll-up-aggressively 0.01
                scroll-down-aggressively 0.01)
  (setq default-frame-alist '((width . 180) (height . 40)))
  (setq redisplay-dont-pause t
        scroll-conservatively most-positive-fixnum
        scroll-margin 1
        scroll-step 1
        scroll-preserve-screen-position 'always)
)



;; Line number setting
(setq display-line-number-type 'relative) 
(global-display-line-numbers-mode t)

(use-package maple-minibuffer
  :ensure nil
  :hook (after-init . maple-minibuffer-mode)
  :config
  (setq maple-minibuffer:position-type 'window-center
        maple-minibuffer:border-color "gray50"
        maple-minibuffer:height nil
        maple-minibuffer:width 0.3
        maple-minibuffer:cache t)

  (setq maple-minibuffer:action '(read-from-minibuffer read-string)
        maple-minibuffer:ignore-action '(evil-ex eval-expression))

  (add-to-list 'maple-minibuffer:ignore-action 'org-schedule)
  (add-to-list 'maple-minibuffer:ignore-regexp "^helm-")

  ;; more custom parameters for frame
  (defun maple-minibuffer:parameters ()
    "Maple minibuffer parameters."
    `((height . ,(or maple-minibuffer:height 10))
      (width . ,(or maple-minibuffer:width (window-pixel-width)))
      (left-fringe . 5)
      (right-fringe . 5))))


	  
(provide 'init-ui)
;;; init-ui.el ends here
