(use-package evil
  :ensure t
  :config
  ;; 开启 evil mode
  (evil-mode 1)
  ;; 开启全局的 leader
  (setq evil-leader/in-all-states 1)
  ;; (global-evil-leader-mode 1)
  (evil-leader/set-leader " ")
  ;; 配置 j/k 浏览很长的行时的操作
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  
  )
  

(provide 'vim-evil)
