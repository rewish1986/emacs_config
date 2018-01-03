;; use f90-mode for .F90, .h90, and namelist files
(add-to-list 'auto-mode-alist '("\\.F90\\'" . f90-mode))
(add-to-list 'auto-mode-alist '("\\.h90\\'" . f90-mode))
(autoload 'f90-mode "f90" "Fortran 90 mode" t)
(add-hook 'f90-mode-hook 'my-f90-mode-hook)
(defun my-f90-mode-hook ()
(setq f90-font-lock-keywords f90-font-lock-keywords-3)
(abbrev-mode 1)                       ; turn on abbreviation mode
(turn-on-font-lock)                   ; syntax highlighting
(auto-fill-mode 0))                   ; turn off auto-filling

(global-auto-revert-mode t)

(setq save-place-file "~/.emacs.d/saveplace") ;; keep my ~/ clean
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package
(show-paren-mode 1)                           ;;

;; Nyan mode, pic with x window.
;(use-package nyan-mode
;  :ensure t)
;(nyan-mode )

(global-set-key (kbd "C-b") 'ibuffer)
(global-set-key (kbd "C-q") 'grep)

;(use-package neotree
;  :ensure t)
;(global-set-key [f8] 'neotree-toggle)
;(setq neo-smart-open t)
;(setq projectile-switch-project-action 'neotree-projectile-action) ;work with projectile

;; make backup to a designated dir, mirroring the full path
(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* (
         (backupRootDir "~/.emacs.d/emacs-backup/")
         (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path, for example, “C:”
         (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") ))
         )
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath
    )
  )
(setq make-backup-file-name-function 'my-backup-file-name)

;; Smartparens, not work for 24.3
(if (version< emacs-version "24.4")
    ()
  (use-package smartparens
    :ensure t)
  (require 'smartparens-config)
  (smartparens-global-mode t)
  (add-hook 'f90-mode-hook #'smartparens-strict-mode)
  (add-hook 'c-mode-hook #'smartparens-strict-mode)
  (add-hook 'c++-mode-hook #'smartparens-strict-mode))

;sr-speedbar
(use-package sr-speedbar
  :ensure t)
(global-set-key [f9] 'sr-speedbar-toggle)
;(setq sr-speedbar-auto-refresh nil)
(setq speedbar-show-unknown-files t) ; show all files
(setq speedbar-use-images nil) ; use text for buttons
(setq sr-speedbar-right-side nil) ; put on left side

(windmove-default-keybindings 'meta)
(setq column-number-mode t)

;;window layout (it should be put at the end of the init file)
;(use-package workgroups2
;  :ensure t)
;(setq wg-session-file "~/.emacs.d/.emacs_workgroups")
;(setq wg-emacs-exit-save-behavior           'nil)      ; Options: 'save 'ask nil
;(setq wg-workgroups-mode-exit-save-behavior 'nil)      ; Options: 'save 'ask nil
;(global-set-key [f12] 'wg-reload-session)
;(workgroups-mode 1)

(provide 'setup-other)
