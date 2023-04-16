;; 使用 F2 快速打开配置文件
(global-set-key (kbd "<f2>") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))

(provide 'key-bindings)
