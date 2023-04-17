(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'base) ;; base setting
(require 'init-org)  ;; org config
(require 'init-packages)  ;; 初始化packages
(require 'key-bindings) ;; keymaps

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages '(use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "终端更纱黑体-简 Nerd" :foundry "????" :slant normal :weight normal :height 158 :width normal)))))
