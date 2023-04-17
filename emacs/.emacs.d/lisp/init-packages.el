(require 'package)
(setq package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")

			 ("melpa" . "http://1.15.88.122/melpa/")

			 ("nongun" . "http://1.15.88.122/nongnu/")))
(package-initialize)

;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))

;; 删除org相关的内置变量
(eval-after-load 'package
  '(progn
     (setq package--builtin-versions
           (assq-delete-all 'org package--builtin-versions))
     (setq package--builtins
           (assq-delete-all 'org package--builtins))))

;; 保证 use-package 安装
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; 手动安装包

;; awesome tab
(use-package awesome-tab
  :load-path "~/.emacs.d/bin/awesome-tab"
  :config
  (awesome-tab-mode t))


;; 补全
(use-package company
  :ensure t
  :init
  (global-company-mode t)
  :config
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0)
  :bind(:map company-active-map
	     ("C-n" . 'company-select-next)
	     ("C-p" . 'company-select-previous)))

;; 显示文件行、列、大小，美化状态栏
(use-package simple
  :ensure nil
  :hook (after-init . size-indication-mode)
  :init
  (progn
    (setq column-number-mode t)
    ))

;; modeline显示所有按键和执行的命令
(use-package keycast
  :ensure t
  :config
  (add-to-list 'global-mode-string '("" mode-line-keycast))
  (keycast-mode))

;; doom-modeline-mode
(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode t))

;; minibuffer 补全
(use-package vertico
  :ensure t
  :config
  (vertico-mode t))
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)))
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode t))
(use-package embark
  :ensure t
  :config
  (setq prefix-help-command 'embark-prefix-help-command)
  (global-set-key (kbd "C-;") 'embark-act))

;; 文件内搜索和跳转函数定义
(use-package consult
  :ensure t
  :config
  (global-set-key (kbd "C-s") 'consult-line))

;; 增强embark和consult, 批量搜索替换大杀器
(use-package embark-consult
  :ensure t
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package wgrep
  :ensure t
  :config (setq wgrep-auto-save-buffer t))

;; 在加载 consult 和 embark 后再加载 embark-consult
(eval-after-load 'consult
  '(eval-after-load 'embark
     '(require 'embark-consult)))

;; 将C-c C-e键绑定到embark-export-write
;;(with-eval-after-load 'minibuffer-local-map
;;  (define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export-write))

;; 主题配置
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))



(provide 'init-packages)
