;; 关闭工具栏，tool-bar-mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 显示行号
(global-linum-mode 1)

;; 更改光标的样式
(setq-default cursor-type 'bar)
(show-paren-mode t)

(icomplete-mode 1)

;; 关闭备份文件
(setq make-backup-files nil)

;; 关闭自动保存文件
(setq auto-save-default nil)

;; 替换粘贴
(delete-selection-mode 1)

(global-hl-line-mode 1)

;; 自动加载外部修改过的文件
(global-auto-revert-mode 1)

;; 关闭警告声音
(setq ring-bell-function 'ignore)

;; 简化yes和no
(fset 'yes-or-no-p 'y-or-n-p)

(provide 'base)
