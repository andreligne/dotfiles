(setq vc-follow-symlinks nil)
(setq create-lockfiles nil)

(menu-bar-mode 0)
(global-display-line-numbers-mode)

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
(if (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

; Set up customise
(setq custom-file "~/.config/emacs/custom.el")
(load custom-file)

(use-package evil-leader
  :ensure t
  :init
  (global-evil-leader-mode)
  :config
  (progn
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "x" 'execute-extended-command)))

(use-package evil
  :ensure t
  :config
  (progn
    (evil-mode 1)
    (define-key evil-normal-state-map (kbd "gc") 'evilnc-comment-operator)))

(use-package evil-surround
  :after evil
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-nerd-commenter
  :after evil
  :ensure t
  :config (evilnc-default-hotkeys))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package helm
  :ensure t)

(use-package projectile
  :ensure t
  :init (setq projectile-project-search-path '("~/Projects/" "~/Projects/gql-metrics/"))
  :config (projectile-mode))

(use-package helm-projectile
  :ensure t
  :config (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile))

(use-package base16-theme
  :ensure t
  :init
  (setq base16-theme-256-color-source 'base16-shell)
  :config
  (load-theme 'base16-tomorrow-night))
